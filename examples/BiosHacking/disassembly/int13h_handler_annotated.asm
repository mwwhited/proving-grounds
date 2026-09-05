; ============================================================================
; INT 13h hard-disk driver - annotated/labeled disassembly
; Phoenix A486 core, Compuadd 486 "Color Scan 450"
;
; This is a curated, hand-labeled version of the mechanical dump in
; 03_core_bios_F000.asm, covering only the INT13h hard-disk driver and its
; support routines. See analysis/02_int13h_disk_driver.md for the narrative
; explanation and confidence notes - especially the flagged ambiguity in
; DrqWaitAndTransfer / AtaErrorPeek.
;
; All addresses are F000:xxxx (= file offset 0x10000+xxxx). Segment is F000
; throughout - this driver never changes CS.
; ============================================================================

; ---------------------------------------------------------------------------
; Int13Entry - INT 13h vector target (installed at file 0x17C79 as an imm16
;              operand; see BIOS_ANALYSIS.md SS6 for the LBA-patch hook point)
; ---------------------------------------------------------------------------
Int13Entry:                        ; F000:7DFE
        sti
        cmp     dl, 80h
        jae     Int13HardDisk
        int     40h                 ; DL<80h: floppy -> chain to saved original INT13h (floppy)
        retf    2

Int13HardDisk:                     ; F000:7E0B
        push    ds
        cmp     ah, 0
        jne     Int13NotReset
        cmp     dl, 82h             ; only DL==0x80 (and 0x81, oddly gated at 82h) really resets
        jb      Int13NotReset
        xor     ah, ah
        pop     ds
        retf    2

Int13NotReset:                     ; F000:7E20
        pusha
        push    es
        pushf
        cld
        sub     dl, 80h             ; NOTE: from here on DL is 0-BASED (0/1). Any code that
                                     ; hooks INT13h ahead of this point (e.g. an LBA-translation
                                     ; shim) must redo this conversion itself before calling any
                                     ; of the helper routines below (Get8255TableForDrive,
                                     ; BuildAtaTaskFile) - they all expect 0-based DL.
        mov     ds, [cs:0D49Fh]     ; DS = 0000h for the rest of this driver (BDA-style scratch
                                     ; at 0000:0440-0500ish). Confirmed by reading the actual
                                     ; word value in the ROM image - it's 0.
        mov     byte [474h], 0      ; clear "last operation status" scratch byte
        cmp     ah, 16h
        jae     Int13InvalidFn
        mov     bp, ax
        in      al, 0A1h            ; unmask IRQ14 (slave PIC)
        and     al, 0BFh
        out     0A1h, al
        in      al, 21h             ; unmask IRQ2 cascade (master PIC)
        and     al, 0FBh
        out     21h, al
        call    ShortIoDelay        ; F000:856E
        mov     ax, bp
        shr     bp, 7               ; bp = (ah*256+al)>>7 == ah*2 (+0/1 from al's top bit)
        and     bp, 0FEh            ; force even -> exact word-table index = AH*2
        cmp     dl, [475h]          ; sanity-check drive index against drive count (unused result?)
        jmp     word [cs:bp+Int13FnTable]

; ---------------------------------------------------------------------------
; Int13FnTable - 22-entry (AH=0..0x15) near-jump table, F000:7E72
; ---------------------------------------------------------------------------
; AH  Target           Function
; 00  Int13Reset_00    Reset (shares path with the AH=1/status handler)
; 01  Int13Status      Return last status
; 02  Int13Read        Read sectors            <-- primary target of the LBA patch
; 03  Int13Write       Write sectors           <-- primary target of the LBA patch
; 04  Int13Verify      Verify sectors
; 05  Int13Format      Format track
; 06  Int13Status      (unimplemented, shares error path)
; 07  Int13Status      (unimplemented, shares error path)
; 08  Int13GetParams   Get drive parameters    <-- must report the *translated* geometry
; 09  Int13InitCtrl    Initialize controller
; 0A  Int13ReadLong    Read long
; 0B  Int13WriteLong   Write long
; 0C  Int13Seek        Seek
; 0D  Int13AltReset    Alternate reset
; 0E  Int13Status      (unimplemented)
; 0F  Int13Status      (unimplemented)
; 10  Int13TestReady   Test drive ready
; 11  Int13Recalibrate Recalibrate
; 12  Int13Status      (unimplemented)
; 13  Int13Status      (unimplemented)
; 14  Int13Diagnostic  Controller diagnostic
; 15  Int13GetDiskType Get disk type
; (>=0x16 never reaches the table - filtered out earlier as Int13InvalidFn)

; ---------------------------------------------------------------------------
; Int13GetParams (AH=08) - F000:815B
; Returns: CH:CL = max cylinder (packed classic 10-bit form), DH = max head,
;          DL = number of hard disks, AH=0/CF=0 on success.
; ---------------------------------------------------------------------------
Int13GetParams:                    ; F000:815B
        mov     bp, sp
        cmp     dl, 2
        jb      Int13GetParams_ok
        mov     word [bp+0Eh], 0    ; invalid drive -> zero out the stacked CX/DX slots
        mov     word [bp+10h], 0
        mov     byte [bp+12h], 0
        mov     ah, 7
        jmp     Int13CommonExit     ; F000:7EA0
Int13GetParams_ok:
        call    Get8255TableForDrive    ; F000:8255 -> es:si = fixed disk parameter table
        mov     dh, [es:si+2]
        dec     dh                       ; dh = heads - 1
        mov     dl, [475h]               ; dl = hard disk count
        mov     [bp+0Eh], dx             ; overwrite stacked DX slot (restored by caller's POPA)
        mov     cx, [es:si]
        dec     cx
        dec     cx                        ; NOTE: decremented twice - see analysis doc
        xchg    ch, cl
        shl     cl, 6
        add     cl, [es:si+0Eh]           ; cl = cylhi2<<6 | sectors_per_track
        mov     [bp+10h], cx              ; overwrite stacked CX slot
        mov     word [bp+12h], 0          ; overwrite stacked AX slot -> ah=0 (success)
        jmp     Int13CommonExit2          ; F000:819D (popf/pop es/popa/pop ds/retf 2)

; ---------------------------------------------------------------------------
; Int13Read (AH=02) - F000:7FEC   /   Int13Write (AH=03) - F000:8067
; ---------------------------------------------------------------------------
Int13Read:                          ; F000:7FEC
        mov     ah, 20h              ; ATA READ SECTOR(S) command
        jmp     Int13ReadWriteCommon
Int13Write:                         ; F000:8067
        mov     ah, 30h              ; ATA WRITE SECTOR(S) command
Int13ReadWriteCommon:
        call    NormalizeBufferPtr   ; F000:8266 -> es:di canonicalized from es:bx (INSW/OUTSW target)
        jc      Int13RwError
        call    BuildAtaTaskFile     ; F000:831B -> builds task file from CX/DX/AL/AH (SEE NOTE BELOW)
        jc      Int13RwError
        je      Int13RwSendCmd       ; ZF from BuildAtaTaskFile: control-byte quirk flag
        or      byte [448h], 1        ; set "no retry" bit in the pending command byte
Int13RwSendCmd:
        call    SendAtaTaskFile      ; F000:8383 -> writes control reg + task file + command
        jc      Int13RwError
        call    WaitControllerReady  ; F000:8298
        jc      Int13RwError
        call    DrqWaitAndTransfer   ; F000:842A -- SEE analysis/02_int13h_disk_driver.md SS5
        jc      Int13RwError
        ; --- inline first-sector transfer (always runs, regardless of what
        ;     DrqWaitAndTransfer did internally - this is the ambiguity) ---
        mov     dx, 1F7h
        in      al, dx
        cli
        mov     dx, 1F0h
        mov     cx, 100h
        rep insw
        cmp     bp, 14h              ; bp is stale "orig AX" from the top-level dispatch;
        jne     Int13RwTail           ; for AH=2 (bp=0x02xx) this is always taken - the odd-byte
                                       ; cleanup below is effectively dead code for normal reads.
        call    DrqWaitAndTransferMore ; F000:8404
        jc      Int13RwError
        mov     cx, 4
        mov     dx, 1F0h
Int13RwOddByteLoop1:
        insb
        call    ShortIoDelay
        loop    Int13RwOddByteLoop1
        call    DrqWaitAndTransferMore
        jc      Int13RwTail
        mov     cx, 3
        mov     dx, 1F0h
Int13RwOddByteLoop2:
        insb
        call    ShortIoDelay
        loop    Int13RwOddByteLoop2
Int13RwTail:
        sti
        call    PostTransferCheck    ; F000:83B4
        jc      Int13RwError
        jne     Int13ReadWriteCommon_retry   ; F000:800C-equivalent: loop for next sector
        mov     ah, 0
Int13RwError:
        jmp     Int13CommonExit      ; F000:7EA0

; ---------------------------------------------------------------------------
; Get8255TableForDrive - F000:8255
; In: DL = 0-BASED drive index (0/1). Out: ES:SI = fixed disk parameter table.
; ---------------------------------------------------------------------------
Get8255TableForDrive:
        mov     es, [cs:7B5Ch]
        mov     al, 14h
        mul     dl                    ; ax = dl * 0x14  (0x14-byte stride per drive)
        mov     si, ax
        les     si, [es:si+104h]      ; es:si = far pointer stored in that slot
        ret

; ---------------------------------------------------------------------------
; BuildAtaTaskFile (F000:831B) - the routine the LBA patch must bypass for
; cylinders >1023; see analysis/02_int13h_disk_driver.md SS4 for the full
; bit-level trace of why.
; In: AH=ata command, AL=sector count, CX=packed cyl/sector, DX=head/drive(0-based)
; ---------------------------------------------------------------------------
BuildAtaTaskFile:
        push    es
        mov     bx, 441h              ; BDA mirror of the 8-byte ATA task file
        mov     [bx+7], ah
        mov     [bx+2], al
        call    Get8255TableForDrive
        mov     al, cl
        and     al, 3Fh
        mov     [bx+3], al            ; sector number
        shr     cl, 6
        xchg    ch, cl                ; ch = cyl-hi (0-3), cl = cyl-lo8
        push    dx
        shr     dh, 5                 ; <-- always 0 for any real caller (head<32); NOT a safe
        or      ch, dh                ;     extra-cylinder-bits mechanism, see analysis doc.
        pop     dx
        mov     [bx+4], cx            ; WORD store: [445h]=cyl-lo->port1F4h, [446h]=cyl-hi->port1F5h
        cmp     dl, [475h]
        jb      BuildAtaTaskFile_ok
        mov     ah, 1
        stc
        pop     es
        ret
BuildAtaTaskFile_ok:
        push    ax
        mov     al, 7
        cmp     byte [es:si+2], 8     ; heads <= 8 ?
        jbe     BuildAtaTaskFile_mask
        or      al, 8                 ; heads > 8: use 4-bit mask instead of 3-bit
BuildAtaTaskFile_mask:
        and     dh, al                ; dh = head, masked to hardware's real field width
        pop     ax
        shl     dl, 4
        and     dh, 0Fh
        add     dl, dh
        or      dl, 0A0h              ; classic ATA drive/head register, CHS mode (bit6=0)
        mov     [bx+6], dl
        mov     ax, [es:si+5]
        shr     ax, 2
        mov     [bx+1], al             ; "features" register mirror (vestigial for IDE/CF)
        mov     al, [es:si+8]
        mov     [476h], al             ; control byte -> sent to port 3F6h by SendAtaTaskFile
        test    al, 0C0h               ; sets ZF for the caller's "no-retry" branch
        mov     bh, [bx+2]             ; bh = sector count (output, used by caller as a counter)
        clc
        pop     es
        ret

; ---------------------------------------------------------------------------
; SendAtaTaskFile (F000:8383) - transmit control byte + 6 task-file bytes +
; command, after waiting for the controller to be ready.
; ---------------------------------------------------------------------------
SendAtaTaskFile:
        cli
        mov     byte [48Eh], 0
        mov     al, [476h]
        mov     dx, 3F6h
        out     dx, al                 ; device control register (SRST/nIEN)
        call    ShortIoDelay
        call    WaitNotBusy            ; F000:83E9
        jc      SendAtaTaskFile_fail
        lea     si, [442h]
        mov     dx, 1F1h
        mov     cx, 6
SendAtaTaskFile_loop:
        lodsb
        out     dx, al                 ; ports 1F1h..1F6h: features/sectcount/sectnum/cyllo/cylhi/drvhead
        inc     dx
        loop    SendAtaTaskFile_loop
        lodsb                          ; [448h] = command byte
        cmp     al, 0
        je      SendAtaTaskFile_noCmd
        out     dx, al                 ; port 1F7h: command register (only if nonzero)
SendAtaTaskFile_noCmd:
        call    0x8571                 ; further wait (not traced)
SendAtaTaskFile_fail:
        ret

; ---------------------------------------------------------------------------
; DrqWaitAndTransfer (F000:842A) - see analysis/02_int13h_disk_driver.md SS5.
; The exact interaction between this routine's own conditional REP INSW and
; the caller's unconditional one immediately after is the one piece of this
; driver I could not fully verify from static analysis alone.
; ---------------------------------------------------------------------------
DrqWaitAndTransfer:
        push    cx
        mov     dx, 1F7h
        mov     cx, 1500h
DrqWaitAndTransfer_poll:
        in      al, dx
        mov     [48Ch], al
        test    al, 8                  ; DRQ
        jne     DrqWaitAndTransfer_ready
        call    LongIoDelay            ; F000:0D1C6
        loop    DrqWaitAndTransfer_poll
        jmp     DrqWaitAndTransfer_timeout
DrqWaitAndTransfer_ready:
        call    AtaErrorPeek            ; F000:8458
        jae     DrqWaitAndTransfer_done ; CF=0 from AtaErrorPeek -> return without transferring (?)
        cli
        mov     dx, 1F0h
        mov     cx, 100h
        rep insw
        sti
DrqWaitAndTransfer_timeout:
        mov     ah, 20h
        stc
DrqWaitAndTransfer_done:
        pop     cx
        ret

; ---------------------------------------------------------------------------
; AtaErrorPeek (F000:8458) - non-blocking status/error decode. Returns
; CF=0/AH=0 immediately if BSY or DRQ is set (can't safely read the error
; register yet); only decodes real ATA error bits once the drive is idle.
; ---------------------------------------------------------------------------
AtaErrorPeek:
        mov     ah, 20h
        mov     dx, 1F7h
        call    ShortIoDelay
        in      al, dx
        mov     [48Ch], al
        test    al, 88h                 ; BSY|DRQ
        jne     AtaErrorPeek_noErrYet    ; can't tell yet -> report "no error"
        test    al, 1                    ; ERR bit
        je      AtaErrorPeek_checkCorr
        in      al, 1F1h                 ; read the real error register
        mov     [48Dh], al
        ; ... decodes al into vendor-ish ah error codes (0Ah/04h/02h/10h/05h/BBh/CCh/AAh/40h) ...
        stc
        ret
AtaErrorPeek_checkCorr:
        test    al, 4
        je      AtaErrorPeek_noErrYet
        mov     ah, 11h
        stc
        ret
AtaErrorPeek_noErrYet:
        mov     ah, 0
        ret
