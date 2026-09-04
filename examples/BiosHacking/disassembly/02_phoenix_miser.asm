; "PhoenixMISER(TM)" module - Phoenix power-management / setup overlay.
; File offsets 0x08000-0x0FFFF. Segment/entry mechanism not confirmed (likely called
; directly by the core BIOS rather than scanned as a standard option ROM).
; NOTE: 'F000:' labels below are placeholders (raw IP counter from block start), not a
; confirmed CS value.
; Linear disassembly - data regions (tables/strings) will show as nonsense instructions.
;
F000:0000  [+0x08000]  55                       push    bp
F000:0001  [+0x08001]  AA                       stosb
F000:0002  [+0x08002]  30 CB                    xor     bl,cl
F000:0004  [+0x08004]  50                       push    ax
F000:0005  [+0x08005]  68 6F 65                 push    656Fh
F000:0008  [+0x08008]  6E                       outsb
F000:0009  [+0x08009]  69 78 4D 49 53           imul    di,[bx+si+4Dh],5349h
F000:000E  [+0x0800E]  45                       inc     bp
F000:000F  [+0x0800F]  52                       push    dx
F000:0010  [+0x08010]  E8 11 16                 call    1624h
F000:0013  [+0x08013]  CB                       retf
F000:0014  [+0x08014]  00 00                    add     [bx+si],al
F000:0016  [+0x08016]  00 00                    add     [bx+si],al
F000:0018  [+0x08018]  00 00                    add     [bx+si],al
F000:001A  [+0x0801A]  00 00                    add     [bx+si],al
F000:001C  [+0x0801C]  E9 32 19                 jmp     1951h
F000:001F  [+0x0801F]  00 00                    add     [bx+si],al
F000:0021  [+0x08021]  00 00                    add     [bx+si],al
F000:0023  [+0x08023]  00 CB                    add     bl,cl
F000:0025  [+0x08025]  00 00                    add     [bx+si],al
F000:0027  [+0x08027]  00 E9                    add     cl,ch
F000:0029  [+0x08029]  A3 00 00                 mov     [0],ax
F000:002C  [+0x0802C]  E8 A8 18                 call    18D7h
F000:002F  [+0x0802F]  CB                       retf
F000:0030  [+0x08030]  E8 77 0E                 call    0EAAh
F000:0033  [+0x08033]  CB                       retf
F000:0034  [+0x08034]  E8 43 05                 call    057Ah
F000:0037  [+0x08037]  CB                       retf
F000:0038  [+0x08038]  E8 2E 0A                 call    0A69h
F000:003B  [+0x0803B]  CB                       retf
F000:003C  [+0x0803C]  00 00                    add     [bx+si],al
F000:003E  [+0x0803E]  00 00                    add     [bx+si],al
F000:0040  [+0x08040]  E8 4F 17                 call    1792h
F000:0043  [+0x08043]  CB                       retf
F000:0044  [+0x08044]  00 00                    add     [bx+si],al
F000:0046  [+0x08046]  00 00                    add     [bx+si],al
F000:0048  [+0x08048]  E8 59 17                 call    17A4h
F000:004B  [+0x0804B]  CB                       retf
F000:004C  [+0x0804C]  00 00                    add     [bx+si],al
F000:004E  [+0x0804E]  00 00                    add     [bx+si],al
F000:0050  [+0x08050]  2A 2A                    sub     ch,[bp+si]
F000:0052  [+0x08052]  20 54 65                 and     [si+65h],dl
F000:0055  [+0x08055]  61                       popa
F000:0056  [+0x08056]  6D                       insw
F000:0057  [+0x08057]  20 4C 65                 and     [si+65h],cl
F000:005A  [+0x0805A]  61                       popa
F000:005B  [+0x0805B]  64 65 72 3A              jb      short 0099h
F000:005F  [+0x0805F]  41                       inc     cx
F000:0060  [+0x08060]  6C                       insb
F000:0061  [+0x08061]  62 65 72                 bound   sp,[di+72h]
F000:0064  [+0x08064]  74 20                    je      short 0086h
F000:0066  [+0x08066]  43                       inc     bx
F000:0067  [+0x08067]  68 65 6E                 push    6E65h
F000:006A  [+0x0806A]  7C 4D                    jl      short 00B9h
F000:006C  [+0x0806C]  42                       inc     dx
F000:006D  [+0x0806D]  3A 41 6C                 cmp     al,[bx+di+6Ch]
F000:0070  [+0x08070]  65 78 20                 js      short 0093h
F000:0073  [+0x08073]  4C                       dec     sp
F000:0074  [+0x08074]  69 6E 2F 4B 65           imul    bp,[bp+2Fh],654Bh
F000:0079  [+0x08079]  76 69                    jbe     short 00E4h
F000:007B  [+0x0807B]  6E                       outsb
F000:007C  [+0x0807C]  20 48 75                 and     [bx+si+75h],cl
F000:007F  [+0x0807F]  61                       popa
F000:0080  [+0x08080]  6E                       outsb
F000:0081  [+0x08081]  67 2F                    das
F000:0083  [+0x08083]  4D                       dec     bp
F000:0084  [+0x08084]  61                       popa
F000:0085  [+0x08085]  72 6B                    jb      short 00F2h
F000:0087  [+0x08087]  20 4B 75                 and     [bp+di+75h],cl
F000:008A  [+0x0808A]  7C 50                    jl      short 00DCh
F000:008C  [+0x0808C]  6F                       outsw
F000:008D  [+0x0808D]  77 65                    ja      short 00F4h
F000:008F  [+0x0808F]  72 3A                    jb      short 00CBh
F000:0091  [+0x08091]  4B                       dec     bx
F000:0092  [+0x08092]  2E 20 4C 2E              and     [cs:si+2Eh],cl
F000:0096  [+0x08096]  20 57 75                 and     [bx+75h],dl
F000:0099  [+0x08099]  7C 53                    jl      short 00EEh
F000:009B  [+0x0809B]  6F                       outsw
F000:009C  [+0x0809C]  75 6E                    jne     short 010Ch
F000:009E  [+0x0809E]  64 3A 59 65              cmp     bl,[fs:bx+di+65h]
F000:00A2  [+0x080A2]  6E                       outsb
F000:00A3  [+0x080A3]  20 59 6F                 and     [bx+di+6Fh],bl
F000:00A6  [+0x080A6]  6E                       outsb
F000:00A7  [+0x080A7]  67 20 48 77              and     [eax+77h],cl
F000:00AB  [+0x080AB]  61                       popa
F000:00AC  [+0x080AC]  6E                       outsb
F000:00AD  [+0x080AD]  67 7C 42                 jl      short 00F2h
F000:00B0  [+0x080B0]  49                       dec     cx
F000:00B1  [+0x080B1]  4F                       dec     di
F000:00B2  [+0x080B2]  53                       push    bx
F000:00B3  [+0x080B3]  3A 41 74                 cmp     al,[bx+di+74h]
F000:00B6  [+0x080B6]  6C                       insb
F000:00B7  [+0x080B7]  61                       popa
F000:00B8  [+0x080B8]  73 20                    jae     short 00DAh
F000:00BA  [+0x080BA]  48                       dec     ax
F000:00BB  [+0x080BB]  75 61                    jne     short 011Eh
F000:00BD  [+0x080BD]  6E                       outsb
F000:00BE  [+0x080BE]  67 20 2A                 and     [edx],ch
F000:00C1  [+0x080C1]  2A C7                    sub     al,bh
F000:00C3  [+0x080C3]  06                       push    es
F000:00C4  [+0x080C4]  0C 00                    or      al,0
F000:00C6  [+0x080C6]  00 01                    add     [bx+di],al
F000:00C8  [+0x080C8]  C6 06 0E 00 00           mov     byte [0Eh],0
F000:00CD  [+0x080CD]  C3                       ret
F000:00CE  [+0x080CE]  1E                       push    ds
F000:00CF  [+0x080CF]  68 00 DC                 push    0DC00h
F000:00D2  [+0x080D2]  1F                       pop     ds
F000:00D3  [+0x080D3]  E8 1C 00                 call    00F2h
F000:00D6  [+0x080D6]  1F                       pop     ds
F000:00D7  [+0x080D7]  CA 02 00                 retf    2
F000:00DA  [+0x080DA]  5A                       pop     dx
F000:00DB  [+0x080DB]  01 82 01 BF              add     [bp+si-40FFh],ax
F000:00DF  [+0x080DF]  01 0B                    add     [bp+di],cx
F000:00E1  [+0x080E1]  02 5C 02                 add     bl,[si+2]
F000:00E4  [+0x080E4]  7F 02                    jg      short 00E8h
F000:00E6  [+0x080E6]  95                       xchg    bp,ax
F000:00E7  [+0x080E7]  02 AB 02 02              add     ch,[bp+di+202h]
F000:00EB  [+0x080EB]  03 5E 03                 add     bx,[bp+3]
F000:00EE  [+0x080EE]  89 03                    mov     [bp+di],ax
F000:00F0  [+0x080F0]  0E                       push    cs
F000:00F1  [+0x080F1]  04 9C                    add     al,9Ch
F000:00F3  [+0x080F3]  FA                       cli
F000:00F4  [+0x080F4]  50                       push    ax
F000:00F5  [+0x080F5]  56                       push    si
F000:00F6  [+0x080F6]  66 55                    push    ebp
F000:00F8  [+0x080F8]  66 8B EC                 mov     ebp,esp
F000:00FB  [+0x080FB]  66 81 E5 FF FF 00 00     and     ebp,0FFFFh
F000:0102  [+0x08102]  EB 09                    jmp     short 010Dh
F000:0104  [+0x08104]  9C                       pushf
F000:0105  [+0x08105]  FA                       cli
F000:0106  [+0x08106]  50                       push    ax
F000:0107  [+0x08107]  56                       push    si
F000:0108  [+0x08108]  66 55                    push    ebp
F000:010A  [+0x0810A]  66 8B EC                 mov     ebp,esp
F000:010D  [+0x0810D]  67 80 4D 08 01           or      byte [ebp+8],1
F000:0112  [+0x08112]  3C 0B                    cmp     al,0Bh
F000:0114  [+0x08114]  77 3E                    ja      short 0154h
F000:0116  [+0x08116]  67 80 65 08 FE           and     byte [ebp+8],0FEh
F000:011B  [+0x0811B]  50                       push    ax
F000:011C  [+0x0811C]  53                       push    bx
F000:011D  [+0x0811D]  51                       push    cx
F000:011E  [+0x0811E]  52                       push    dx
F000:011F  [+0x0811F]  9C                       pushf
F000:0120  [+0x08120]  B8 0E 00                 mov     ax,0Eh
F000:0123  [+0x08123]  BB 18 3E                 mov     bx,3E18h
F000:0126  [+0x08126]  E8 C1 11                 call    12EAh
F000:0129  [+0x08129]  9D                       popf
F000:012A  [+0x0812A]  5A                       pop     dx
F000:012B  [+0x0812B]  59                       pop     cx
F000:012C  [+0x0812C]  5B                       pop     bx
F000:012D  [+0x0812D]  58                       pop     ax
F000:012E  [+0x0812E]  E8 19 12                 call    134Ah
F000:0131  [+0x08131]  8B F0                    mov     si,ax
F000:0133  [+0x08133]  81 E6 FF 00              and     si,0FFh
F000:0137  [+0x08137]  D1 E6                    shl     si,1
F000:0139  [+0x08139]  2E FF 94 DA 00           call    word [cs:si+0DAh]
F000:013E  [+0x0813E]  E8 1D 12                 call    135Eh
F000:0141  [+0x08141]  50                       push    ax
F000:0142  [+0x08142]  53                       push    bx
F000:0143  [+0x08143]  51                       push    cx
F000:0144  [+0x08144]  52                       push    dx
F000:0145  [+0x08145]  9C                       pushf
F000:0146  [+0x08146]  B8 0E 00                 mov     ax,0Eh
F000:0149  [+0x08149]  BB 10 3E                 mov     bx,3E10h
F000:014C  [+0x0814C]  E8 9B 11                 call    12EAh
F000:014F  [+0x0814F]  9D                       popf
F000:0150  [+0x08150]  5A                       pop     dx
F000:0151  [+0x08151]  59                       pop     cx
F000:0152  [+0x08152]  5B                       pop     bx
F000:0153  [+0x08153]  58                       pop     ax
F000:0154  [+0x08154]  66 5D                    pop     ebp
F000:0156  [+0x08156]  5E                       pop     si
F000:0157  [+0x08157]  58                       pop     ax
F000:0158  [+0x08158]  9D                       popf
F000:0159  [+0x08159]  C3                       ret
F000:015A  [+0x0815A]  0B DB                    or      bx,bx
F000:015C  [+0x0815C]  0F 85 45 03              jne     near 04A5h
F000:0160  [+0x08160]  BB 4D 50                 mov     bx,504Dh
F000:0163  [+0x08163]  B9 07 00                 mov     cx,7
F000:0166  [+0x08166]  F7 06 0C 00 00 01        test    word [0Ch],100h
F000:016C  [+0x0816C]  75 03                    jne     short 0171h
F000:016E  [+0x0816E]  83 C9 08                 or      cx,8
F000:0171  [+0x08171]  C7 46 06 00 01           mov     word [bp+6],100h
F000:0176  [+0x08176]  50                       push    ax
F000:0177  [+0x08177]  51                       push    cx
F000:0178  [+0x08178]  B0 01                    mov     al,1
F000:017A  [+0x0817A]  E6 80                    out     80h,al
F000:017C  [+0x0817C]  E8 51 03                 call    04D0h
F000:017F  [+0x0817F]  59                       pop     cx
F000:0180  [+0x08180]  58                       pop     ax
F000:0181  [+0x08181]  C3                       ret
F000:0182  [+0x08182]  83 FB 00                 cmp     bx,0
F000:0185  [+0x08185]  0F 85 1C 03              jne     near 04A5h
F000:0189  [+0x08189]  F7 06 0C 00 80 00        test    word [0Ch],80h
F000:018F  [+0x0818F]  0F 85 FA 02              jne     near 048Dh
F000:0193  [+0x08193]  F7 06 0C 00 20 00        test    word [0Ch],20h
F000:0199  [+0x08199]  0F 85 F8 02              jne     near 0495h
F000:019D  [+0x0819D]  F7 06 0C 00 40 00        test    word [0Ch],40h
F000:01A3  [+0x081A3]  0F 85 F6 02              jne     near 049Dh
F000:01A7  [+0x081A7]  81 26 0C 00 00 01        and     word [0Ch],100h
F000:01AD  [+0x081AD]  81 0E 0C 00 80 00        or      word [0Ch],80h
F000:01B3  [+0x081B3]  50                       push    ax
F000:01B4  [+0x081B4]  51                       push    cx
F000:01B5  [+0x081B5]  B0 11                    mov     al,11h
F000:01B7  [+0x081B7]  E6 80                    out     80h,al
F000:01B9  [+0x081B9]  E8 14 03                 call    04D0h
F000:01BC  [+0x081BC]  59                       pop     cx
F000:01BD  [+0x081BD]  58                       pop     ax
F000:01BE  [+0x081BE]  C3                       ret
F000:01BF  [+0x081BF]  83 FB 00                 cmp     bx,0
F000:01C2  [+0x081C2]  0F 85 DF 02              jne     near 04A5h
F000:01C6  [+0x081C6]  F7 06 0C 00 40 00        test    word [0Ch],40h
F000:01CC  [+0x081CC]  0F 85 CD 02              jne     near 049Dh
F000:01D0  [+0x081D0]  F7 06 0C 00 20 00        test    word [0Ch],20h
F000:01D6  [+0x081D6]  0F 85 BB 02              jne     near 0495h
F000:01DA  [+0x081DA]  F7 06 0C 00 80 00        test    word [0Ch],80h
F000:01E0  [+0x081E0]  0F 85 A9 02              jne     near 048Dh
F000:01E4  [+0x081E4]  81 26 0C 00 00 01        and     word [0Ch],100h
F000:01EA  [+0x081EA]  81 0E 0C 00 80 00        or      word [0Ch],80h
F000:01F0  [+0x081F0]  83 0E 0C 00 20           or      word [0Ch],20h
F000:01F5  [+0x081F5]  67 8C 4D 06              mov     [ebp+6],cs
F000:01F9  [+0x081F9]  BB E5 04                 mov     bx,4E5h
F000:01FC  [+0x081FC]  B9 00 DC                 mov     cx,0DC00h
F000:01FF  [+0x081FF]  50                       push    ax
F000:0200  [+0x08200]  51                       push    cx
F000:0201  [+0x08201]  B0 21                    mov     al,21h
F000:0203  [+0x08203]  E6 80                    out     80h,al
F000:0205  [+0x08205]  E8 C8 02                 call    04D0h
F000:0208  [+0x08208]  59                       pop     cx
F000:0209  [+0x08209]  58                       pop     ax
F000:020A  [+0x0820A]  C3                       ret
F000:020B  [+0x0820B]  83 FB 00                 cmp     bx,0
F000:020E  [+0x0820E]  0F 85 93 02              jne     near 04A5h
F000:0212  [+0x08212]  F7 06 0C 00 40 00        test    word [0Ch],40h
F000:0218  [+0x08218]  0F 85 81 02              jne     near 049Dh
F000:021C  [+0x0821C]  F7 06 0C 00 20 00        test    word [0Ch],20h
F000:0222  [+0x08222]  0F 85 6F 02              jne     near 0495h
F000:0226  [+0x08226]  F7 06 0C 00 80 00        test    word [0Ch],80h
F000:022C  [+0x0822C]  0F 85 5D 02              jne     near 048Dh
F000:0230  [+0x08230]  81 26 0C 00 00 01        and     word [0Ch],100h
F000:0236  [+0x08236]  81 0E 0C 00 80 00        or      word [0Ch],80h
F000:023C  [+0x0823C]  83 0E 0C 00 40           or      word [0Ch],40h
F000:0241  [+0x08241]  67 8C 4D 06              mov     [ebp+6],cs
F000:0245  [+0x08245]  66 BB 02 5C 00 00        mov     ebx,5C02h
F000:024B  [+0x0824B]  8C C9                    mov     cx,cs
F000:024D  [+0x0824D]  BA 00 DC                 mov     dx,0DC00h
F000:0250  [+0x08250]  50                       push    ax
F000:0251  [+0x08251]  51                       push    cx
F000:0252  [+0x08252]  B0 31                    mov     al,31h
F000:0254  [+0x08254]  E6 80                    out     80h,al
F000:0256  [+0x08256]  E8 77 02                 call    04D0h
F000:0259  [+0x08259]  59                       pop     cx
F000:025A  [+0x0825A]  58                       pop     ax
F000:025B  [+0x0825B]  C3                       ret
F000:025C  [+0x0825C]  83 FB 00                 cmp     bx,0
F000:025F  [+0x0825F]  0F 85 42 02              jne     near 04A5h
F000:0263  [+0x08263]  F7 06 0C 00 80 00        test    word [0Ch],80h
F000:0269  [+0x08269]  0F 84 24 02              je      near 0491h
F000:026D  [+0x0826D]  81 26 0C 00 00 01        and     word [0Ch],100h
F000:0273  [+0x08273]  50                       push    ax
F000:0274  [+0x08274]  51                       push    cx
F000:0275  [+0x08275]  B0 41                    mov     al,41h
F000:0277  [+0x08277]  E6 80                    out     80h,al
F000:0279  [+0x08279]  E8 54 02                 call    04D0h
F000:027C  [+0x0827C]  59                       pop     cx
F000:027D  [+0x0827D]  58                       pop     ax
F000:027E  [+0x0827E]  C3                       ret
F000:027F  [+0x0827F]  F7 06 0C 00 80 00        test    word [0Ch],80h
F000:0285  [+0x08285]  0F 84 08 02              je      near 0491h
F000:0289  [+0x08289]  50                       push    ax
F000:028A  [+0x0828A]  51                       push    cx
F000:028B  [+0x0828B]  B0 51                    mov     al,51h
F000:028D  [+0x0828D]  E6 80                    out     80h,al
F000:028F  [+0x0828F]  E8 3E 02                 call    04D0h
F000:0292  [+0x08292]  59                       pop     cx
F000:0293  [+0x08293]  58                       pop     ax
F000:0294  [+0x08294]  C3                       ret
F000:0295  [+0x08295]  F7 06 0C 00 80 00        test    word [0Ch],80h
F000:029B  [+0x0829B]  0F 84 F2 01              je      near 0491h
F000:029F  [+0x0829F]  50                       push    ax
F000:02A0  [+0x082A0]  51                       push    cx
F000:02A1  [+0x082A1]  B0 06                    mov     al,6
F000:02A3  [+0x082A3]  E6 80                    out     80h,al
F000:02A5  [+0x082A5]  E8 28 02                 call    04D0h
F000:02A8  [+0x082A8]  59                       pop     cx
F000:02A9  [+0x082A9]  58                       pop     ax
F000:02AA  [+0x082AA]  C3                       ret
F000:02AB  [+0x082AB]  83 FB 01                 cmp     bx,1
F000:02AE  [+0x082AE]  0F 85 F3 01              jne     near 04A5h
F000:02B2  [+0x082B2]  83 F9 04                 cmp     cx,4
F000:02B5  [+0x082B5]  0F 87 F0 01              ja      near 04A9h
F000:02B9  [+0x082B9]  F7 06 0C 00 00 01        test    word [0Ch],100h
F000:02BF  [+0x082BF]  0F 84 C6 01              je      near 0489h
F000:02C3  [+0x082C3]  F7 06 0C 00 80 00        test    word [0Ch],80h
F000:02C9  [+0x082C9]  0F 84 C4 01              je      near 0491h
F000:02CD  [+0x082CD]  50                       push    ax
F000:02CE  [+0x082CE]  51                       push    cx
F000:02CF  [+0x082CF]  B0 71                    mov     al,71h
F000:02D1  [+0x082D1]  E6 80                    out     80h,al
F000:02D3  [+0x082D3]  E8 FA 01                 call    04D0h
F000:02D6  [+0x082D6]  59                       pop     cx
F000:02D7  [+0x082D7]  58                       pop     ax
F000:02D8  [+0x082D8]  83 F9 02                 cmp     cx,2
F000:02DB  [+0x082DB]  0F 85 CA 01              jne     near 04A9h
F000:02DF  [+0x082DF]  50                       push    ax
F000:02E0  [+0x082E0]  51                       push    cx
F000:02E1  [+0x082E1]  B0 72                    mov     al,72h
F000:02E3  [+0x082E3]  E6 80                    out     80h,al
F000:02E5  [+0x082E5]  E8 E8 01                 call    04D0h
F000:02E8  [+0x082E8]  59                       pop     cx
F000:02E9  [+0x082E9]  58                       pop     ax
F000:02EA  [+0x082EA]  E8 50 1E                 call    213Dh
F000:02ED  [+0x082ED]  0F 82 BC 01              jb      near 04ADh
F000:02F1  [+0x082F1]  83 0E 0C 00 04           or      word [0Ch],4
F000:02F6  [+0x082F6]  50                       push    ax
F000:02F7  [+0x082F7]  51                       push    cx
F000:02F8  [+0x082F8]  B0 70                    mov     al,70h
F000:02FA  [+0x082FA]  E6 80                    out     80h,al
F000:02FC  [+0x082FC]  E8 D1 01                 call    04D0h
F000:02FF  [+0x082FF]  59                       pop     cx
F000:0300  [+0x08300]  58                       pop     ax
F000:0301  [+0x08301]  C3                       ret
F000:0302  [+0x08302]  83 FB FF                 cmp     bx,0FFFFh
F000:0305  [+0x08305]  0F 85 9C 01              jne     near 04A5h
F000:0309  [+0x08309]  0A C9                    or      cl,cl
F000:030B  [+0x0830B]  75 26                    jne     short 0333h
F000:030D  [+0x0830D]  F7 06 0C 00 00 01        test    word [0Ch],100h
F000:0313  [+0x08313]  0F 84 72 01              je      near 0489h
F000:0317  [+0x08317]  81 26 0C 00 FF FE        and     word [0Ch],0FEFFh
F000:031D  [+0x0831D]  50                       push    ax
F000:031E  [+0x0831E]  51                       push    cx
F000:031F  [+0x0831F]  B0 80                    mov     al,80h
F000:0321  [+0x08321]  E6 80                    out     80h,al
F000:0323  [+0x08323]  E8 AA 01                 call    04D0h
F000:0326  [+0x08326]  59                       pop     cx
F000:0327  [+0x08327]  58                       pop     ax
F000:0328  [+0x08328]  50                       push    ax
F000:0329  [+0x08329]  B0 00                    mov     al,0
F000:032B  [+0x0832B]  A2 0F 01                 mov     [10Fh],al
F000:032E  [+0x0832E]  E8 12 17                 call    1A43h
F000:0331  [+0x08331]  58                       pop     ax
F000:0332  [+0x08332]  C3                       ret
F000:0333  [+0x08333]  80 F9 01                 cmp     cl,1
F000:0336  [+0x08336]  0F 85 6F 01              jne     near 04A9h
F000:033A  [+0x0833A]  81 0E 0C 00 00 01        or      word [0Ch],100h
F000:0340  [+0x08340]  50                       push    ax
F000:0341  [+0x08341]  51                       push    cx
F000:0342  [+0x08342]  B0 81                    mov     al,81h
F000:0344  [+0x08344]  E6 80                    out     80h,al
F000:0346  [+0x08346]  E8 87 01                 call    04D0h
F000:0349  [+0x08349]  59                       pop     cx
F000:034A  [+0x0834A]  58                       pop     ax
F000:034B  [+0x0834B]  50                       push    ax
F000:034C  [+0x0834C]  53                       push    bx
F000:034D  [+0x0834D]  B0 42                    mov     al,42h
F000:034F  [+0x0834F]  B3 03                    mov     bl,3
F000:0351  [+0x08351]  E8 A3 1C                 call    1FF7h
F000:0354  [+0x08354]  88 26 0F 01              mov     [10Fh],ah
F000:0358  [+0x08358]  E8 E8 16                 call    1A43h
F000:035B  [+0x0835B]  5B                       pop     bx
F000:035C  [+0x0835C]  58                       pop     ax
F000:035D  [+0x0835D]  C3                       ret
F000:035E  [+0x0835E]  83 FB FF                 cmp     bx,0FFFFh
F000:0361  [+0x08361]  0F 85 40 01              jne     near 04A5h
F000:0365  [+0x08365]  C7 06 0C 00 00 01        mov     word [0Ch],100h
F000:036B  [+0x0836B]  50                       push    ax
F000:036C  [+0x0836C]  53                       push    bx
F000:036D  [+0x0836D]  B0 42                    mov     al,42h
F000:036F  [+0x0836F]  B3 03                    mov     bl,3
F000:0371  [+0x08371]  E8 83 1C                 call    1FF7h
F000:0374  [+0x08374]  88 26 0F 01              mov     [10Fh],ah
F000:0378  [+0x08378]  E8 C8 16                 call    1A43h
F000:037B  [+0x0837B]  5B                       pop     bx
F000:037C  [+0x0837C]  58                       pop     ax
F000:037D  [+0x0837D]  50                       push    ax
F000:037E  [+0x0837E]  51                       push    cx
F000:037F  [+0x0837F]  B0 91                    mov     al,91h
F000:0381  [+0x08381]  E6 80                    out     80h,al
F000:0383  [+0x08383]  E8 4A 01                 call    04D0h
F000:0386  [+0x08386]  59                       pop     cx
F000:0387  [+0x08387]  58                       pop     ax
F000:0388  [+0x08388]  C3                       ret
F000:0389  [+0x08389]  83 FB 01                 cmp     bx,1
F000:038C  [+0x0838C]  0F 85 15 01              jne     near 04A5h
F000:0390  [+0x08390]  50                       push    ax
F000:0391  [+0x08391]  52                       push    dx
F000:0392  [+0x08392]  BB FF 01                 mov     bx,1FFh
F000:0395  [+0x08395]  B1 FF                    mov     cl,0FFh
F000:0397  [+0x08397]  53                       push    bx
F000:0398  [+0x08398]  51                       push    cx
F000:0399  [+0x08399]  B8 01 00                 mov     ax,1
F000:039C  [+0x0839C]  BA 08 00                 mov     dx,8
F000:039F  [+0x0839F]  E8 4F 0F                 call    12F1h
F000:03A2  [+0x083A2]  59                       pop     cx
F000:03A3  [+0x083A3]  5B                       pop     bx
F000:03A4  [+0x083A4]  0F 85 02 00              jne     near 03AAh
F000:03A8  [+0x083A8]  B7 00                    mov     bh,0
F000:03AA  [+0x083AA]  53                       push    bx
F000:03AB  [+0x083AB]  51                       push    cx
F000:03AC  [+0x083AC]  B8 12 00                 mov     ax,12h
F000:03AF  [+0x083AF]  BA 01 00                 mov     dx,1
F000:03B2  [+0x083B2]  E8 3C 0F                 call    12F1h
F000:03B5  [+0x083B5]  59                       pop     cx
F000:03B6  [+0x083B6]  5B                       pop     bx
F000:03B7  [+0x083B7]  0F 85 50 00              jne     near 040Bh
F000:03BB  [+0x083BB]  53                       push    bx
F000:03BC  [+0x083BC]  B8 00 00                 mov     ax,0
F000:03BF  [+0x083BF]  E8 21 0F                 call    12E3h
F000:03C2  [+0x083C2]  8B D3                    mov     dx,bx
F000:03C4  [+0x083C4]  5B                       pop     bx
F000:03C5  [+0x083C5]  F6 C6 30                 test    dh,30h
F000:03C8  [+0x083C8]  0F 84 04 00              je      near 03D0h
F000:03CC  [+0x083CC]  B3 02                    mov     bl,2
F000:03CE  [+0x083CE]  EB 02                    jmp     short 03D2h
F000:03D0  [+0x083D0]  32 DB                    xor     bl,bl
F000:03D2  [+0x083D2]  BA FF 01                 mov     dx,1FFh
F000:03D5  [+0x083D5]  EC                       in      al,dx
F000:03D6  [+0x083D6]  EB 00                    jmp     short 03D8h
F000:03D8  [+0x083D8]  EB 00                    jmp     short 03DAh
F000:03DA  [+0x083DA]  EB 00                    jmp     short 03DCh
F000:03DC  [+0x083DC]  C0 E0 02                 shl     al,2
F000:03DF  [+0x083DF]  8A C8                    mov     cl,al
F000:03E1  [+0x083E1]  50                       push    ax
F000:03E2  [+0x083E2]  52                       push    dx
F000:03E3  [+0x083E3]  8A C1                    mov     al,cl
F000:03E5  [+0x083E5]  B1 14                    mov     cl,14h
F000:03E7  [+0x083E7]  F6 E1                    mul     cl
F000:03E9  [+0x083E9]  B1 33                    mov     cl,33h
F000:03EB  [+0x083EB]  F6 F1                    div     cl
F000:03ED  [+0x083ED]  8A C8                    mov     cl,al
F000:03EF  [+0x083EF]  5A                       pop     dx
F000:03F0  [+0x083F0]  58                       pop     ax
F000:03F1  [+0x083F1]  53                       push    bx
F000:03F2  [+0x083F2]  B8 00 00                 mov     ax,0
F000:03F5  [+0x083F5]  E8 EB 0E                 call    12E3h
F000:03F8  [+0x083F8]  8B D3                    mov     dx,bx
F000:03FA  [+0x083FA]  5B                       pop     bx
F000:03FB  [+0x083FB]  F6 C6 30                 test    dh,30h
F000:03FE  [+0x083FE]  0F 85 09 00              jne     near 040Bh
F000:0402  [+0x08402]  80 F9 19                 cmp     cl,19h
F000:0405  [+0x08405]  0F 87 02 00              ja      near 040Bh
F000:0409  [+0x08409]  B3 01                    mov     bl,1
F000:040B  [+0x0840B]  5A                       pop     dx
F000:040C  [+0x0840C]  58                       pop     ax
F000:040D  [+0x0840D]  C3                       ret
F000:040E  [+0x0840E]  A1 0C 00                 mov     ax,[0Ch]
F000:0411  [+0x08411]  F7 06 0C 00 80 00        test    word [0Ch],80h
F000:0417  [+0x08417]  0F 84 76 00              je      near 0491h
F000:041B  [+0x0841B]  51                       push    cx
F000:041C  [+0x0841C]  52                       push    dx
F000:041D  [+0x0841D]  50                       push    ax
F000:041E  [+0x0841E]  53                       push    bx
F000:041F  [+0x0841F]  52                       push    dx
F000:0420  [+0x08420]  83 26 0C 00 EF           and     word [0Ch],0FFEFh
F000:0425  [+0x08425]  B8 00 00                 mov     ax,0
F000:0428  [+0x08428]  E8 B8 0E                 call    12E3h
F000:042B  [+0x0842B]  F6 C7 30                 test    bh,30h
F000:042E  [+0x0842E]  0F 84 26 00              je      near 0458h
F000:0432  [+0x08432]  53                       push    bx
F000:0433  [+0x08433]  B8 09 00                 mov     ax,9
F000:0436  [+0x08436]  E8 AA 0E                 call    12E3h
F000:0439  [+0x08439]  8B D3                    mov     dx,bx
F000:043B  [+0x0843B]  5B                       pop     bx
F000:043C  [+0x0843C]  F6 C6 01                 test    dh,1
F000:043F  [+0x0843F]  0F 84 15 00              je      near 0458h
F000:0443  [+0x08443]  50                       push    ax
F000:0444  [+0x08444]  A0 0E 00                 mov     al,[0Eh]
F000:0447  [+0x08447]  FE C0                    inc     al
F000:0449  [+0x08449]  A2 0E 00                 mov     [0Eh],al
F000:044C  [+0x0844C]  3C 03                    cmp     al,3
F000:044E  [+0x0844E]  58                       pop     ax
F000:044F  [+0x0844F]  0F 87 05 00              ja      near 0458h
F000:0453  [+0x08453]  83 0E 0C 00 10           or      word [0Ch],10h
F000:0458  [+0x08458]  5A                       pop     dx
F000:0459  [+0x08459]  5B                       pop     bx
F000:045A  [+0x0845A]  58                       pop     ax
F000:045B  [+0x0845B]  BB 01 00                 mov     bx,1
F000:045E  [+0x0845E]  BA 01 00                 mov     dx,1
F000:0461  [+0x08461]  B9 05 00                 mov     cx,5
F000:0464  [+0x08464]  85 C3                    test    bx,ax
F000:0466  [+0x08466]  75 09                    jne     short 0471h
F000:0468  [+0x08468]  D1 E3                    shl     bx,1
F000:046A  [+0x0846A]  42                       inc     dx
F000:046B  [+0x0846B]  E2 F7                    loop    0464h
F000:046D  [+0x0846D]  5A                       pop     dx
F000:046E  [+0x0846E]  59                       pop     cx
F000:046F  [+0x0846F]  EB 40                    jmp     short 04B1h
F000:0471  [+0x08471]  F7 D3                    not     bx
F000:0473  [+0x08473]  21 1E 0C 00              and     [0Ch],bx
F000:0477  [+0x08477]  8B DA                    mov     bx,dx
F000:0479  [+0x08479]  5A                       pop     dx
F000:047A  [+0x0847A]  59                       pop     cx
F000:047B  [+0x0847B]  50                       push    ax
F000:047C  [+0x0847C]  53                       push    bx
F000:047D  [+0x0847D]  51                       push    cx
F000:047E  [+0x0847E]  B0 B1                    mov     al,0B1h
F000:0480  [+0x08480]  E6 80                    out     80h,al
F000:0482  [+0x08482]  E8 4B 00                 call    04D0h
F000:0485  [+0x08485]  59                       pop     cx
F000:0486  [+0x08486]  5B                       pop     bx
F000:0487  [+0x08487]  58                       pop     ax
F000:0488  [+0x08488]  C3                       ret
F000:0489  [+0x08489]  B4 01                    mov     ah,1
F000:048B  [+0x0848B]  EB 26                    jmp     short 04B3h
F000:048D  [+0x0848D]  B4 02                    mov     ah,2
F000:048F  [+0x0848F]  EB 22                    jmp     short 04B3h
F000:0491  [+0x08491]  B4 03                    mov     ah,3
F000:0493  [+0x08493]  EB 1E                    jmp     short 04B3h
F000:0495  [+0x08495]  B4 05                    mov     ah,5
F000:0497  [+0x08497]  EB 1A                    jmp     short 04B3h
F000:0499  [+0x08499]  B4 06                    mov     ah,6
F000:049B  [+0x0849B]  EB 16                    jmp     short 04B3h
F000:049D  [+0x0849D]  B4 07                    mov     ah,7
F000:049F  [+0x0849F]  EB 12                    jmp     short 04B3h
F000:04A1  [+0x084A1]  B4 08                    mov     ah,8
F000:04A3  [+0x084A3]  EB 0E                    jmp     short 04B3h
F000:04A5  [+0x084A5]  B4 09                    mov     ah,9
F000:04A7  [+0x084A7]  EB 0A                    jmp     short 04B3h
F000:04A9  [+0x084A9]  B4 0A                    mov     ah,0Ah
F000:04AB  [+0x084AB]  EB 06                    jmp     short 04B3h
F000:04AD  [+0x084AD]  B4 60                    mov     ah,60h
F000:04AF  [+0x084AF]  EB 02                    jmp     short 04B3h
F000:04B1  [+0x084B1]  B4 80                    mov     ah,80h
F000:04B3  [+0x084B3]  67 88 65 07              mov     [ebp+7],ah
F000:04B7  [+0x084B7]  67 80 4D 08 01           or      byte [ebp+8],1
F000:04BC  [+0x084BC]  C3                       ret
F000:04BD  [+0x084BD]  F7 06 0C 00 80 00        test    word [0Ch],80h
F000:04C3  [+0x084C3]  0F 84 C1 0E              je      near 1388h
F000:04C7  [+0x084C7]  83 0E 0C 00 01           or      word [0Ch],1
F000:04CC  [+0x084CC]  C3                       ret
F000:04CD  [+0x084CD]  E9 6D 1C                 jmp     213Dh
F000:04D0  [+0x084D0]  C3                       ret
F000:04D1  [+0x084D1]  51                       push    cx
F000:04D2  [+0x084D2]  B9 00 A0                 mov     cx,0A000h
F000:04D5  [+0x084D5]  E8 69 1B                 call    2041h
F000:04D8  [+0x084D8]  E2 FB                    loop    04D5h
F000:04DA  [+0x084DA]  59                       pop     cx
F000:04DB  [+0x084DB]  C3                       ret
F000:04DC  [+0x084DC]  E8 25 FC                 call    0104h
F000:04DF  [+0x084DF]  66 CB                    retfd
F000:04E1  [+0x084E1]  E8 20 FC                 call    0104h
F000:04E4  [+0x084E4]  CB                       retf
F000:04E5  [+0x084E5]  1E                       push    ds
F000:04E6  [+0x084E6]  56                       push    si
F000:04E7  [+0x084E7]  0E                       push    cs
F000:04E8  [+0x084E8]  BE FB 04                 mov     si,4FBh
F000:04EB  [+0x084EB]  56                       push    si
F000:04EC  [+0x084EC]  8C CE                    mov     si,cs
F000:04EE  [+0x084EE]  56                       push    si
F000:04EF  [+0x084EF]  BE E1 04                 mov     si,4E1h
F000:04F2  [+0x084F2]  56                       push    si
F000:04F3  [+0x084F3]  8C CE                    mov     si,cs
F000:04F5  [+0x084F5]  83 C6 08                 add     si,8
F000:04F8  [+0x084F8]  8E DE                    mov     ds,si
F000:04FA  [+0x084FA]  CB                       retf
F000:04FB  [+0x084FB]  5E                       pop     si
F000:04FC  [+0x084FC]  1F                       pop     ds
F000:04FD  [+0x084FD]  CB                       retf
F000:04FE  [+0x084FE]  02 28                    add     ch,[bx+si]
F000:0500  [+0x08500]  A4                       movsb
F000:0501  [+0x08501]  13 C2                    adc     ax,dx
F000:0503  [+0x08503]  00 80 19 12              add     [bx+si+1219h],al
F000:0507  [+0x08507]  1A 9C 29 73              sbb     bl,[si+7329h]
F000:050B  [+0x0850B]  28 DE                    sub     dh,bl
F000:050D  [+0x0850D]  38 D9                    cmp     cl,bl
F000:050F  [+0x0850F]  2C F4                    sub     al,0F4h
F000:0511  [+0x08511]  36 74 18                 je      short 052Ch
F000:0514  [+0x08514]  4A                       dec     dx
F000:0515  [+0x08515]  05 EA 0A                 add     ax,0AEAh
F000:0518  [+0x08518]  88 06 00 00              mov     [0],al
F000:051C  [+0x0851C]  FD                       std
F000:051D  [+0x0851D]  2C D7                    sub     al,0D7h
F000:051F  [+0x0851F]  29 85 28 0A              sub     [di+0A28h],ax
F000:0523  [+0x08523]  39 3B                    cmp     [bp+di],di
F000:0525  [+0x08525]  3A 08                    cmp     cl,[bx+si]
F000:0527  [+0x08527]  37                       aaa
F000:0528  [+0x08528]  00 00                    add     [bx+si],al
F000:052A  [+0x0852A]  AC                       lodsb
F000:052B  [+0x0852B]  31 A8 09 4B              xor     [bx+si+4B09h],bp
F000:052F  [+0x0852F]  3A EF                    cmp     ch,bh
F000:0531  [+0x08531]  29 AF 28 85              sub     [bx-7AD8h],bp
F000:0535  [+0x08535]  39 12                    cmp     [bp+si],dx
F000:0537  [+0x08537]  37                       aaa
F000:0538  [+0x08538]  00 00                    add     [bx+si],al
F000:053A  [+0x0853A]  FD                       std
F000:053B  [+0x0853B]  2C 85                    sub     al,85h
F000:053D  [+0x0853D]  28 0A                    sub     [bp+si],cl
F000:053F  [+0x0853F]  39 00                    cmp     [bx+si],ax
F000:0541  [+0x08541]  00 AC 31 AF              add     [si-50CFh],ch
F000:0545  [+0x08545]  28 85 39 00              sub     [di+39h],al
F000:0549  [+0x08549]  00 60 E8                 add     [bx+si-18h],ah
F000:054C  [+0x0854C]  72 25                    jb      short 0573h
F000:054E  [+0x0854E]  61                       popa
F000:054F  [+0x0854F]  C3                       ret
F000:0550  [+0x08550]  B8 00 DC                 mov     ax,0DC00h
F000:0553  [+0x08553]  8E D8                    mov     ds,ax
F000:0555  [+0x08555]  8E C0                    mov     es,ax
F000:0557  [+0x08557]  B8 22 10                 mov     ax,1022h
F000:055A  [+0x0855A]  BB 00 00                 mov     bx,0
F000:055D  [+0x0855D]  CD 15                    int     15h
F000:055F  [+0x0855F]  83 FB 00                 cmp     bx,0
F000:0562  [+0x08562]  75 15                    jne     short 0579h
F000:0564  [+0x08564]  E8 E3 0D                 call    134Ah
F000:0567  [+0x08567]  E8 EC 00                 call    0656h
F000:056A  [+0x0856A]  E8 B8 02                 call    0825h
F000:056D  [+0x0856D]  E8 E4 03                 call    0954h
F000:0570  [+0x08570]  E8 84 00                 call    05F7h
F000:0573  [+0x08573]  E8 C7 02                 call    083Dh
F000:0576  [+0x08576]  E8 F6 00                 call    066Fh
F000:0579  [+0x08579]  C3                       ret
F000:057A  [+0x0857A]  60                       pusha
F000:057B  [+0x0857B]  50                       push    ax
F000:057C  [+0x0857C]  B8 00 16                 mov     ax,1600h
F000:057F  [+0x0857F]  CD 2F                    int     2Fh
F000:0581  [+0x08581]  A8 FF                    test    al,0FFh
F000:0583  [+0x08583]  58                       pop     ax
F000:0584  [+0x08584]  74 03                    je      short 0589h
F000:0586  [+0x08586]  EB 6D                    jmp     short 05F5h
F000:0588  [+0x08588]  90                       nop
F000:0589  [+0x08589]  B8 22 10                 mov     ax,1022h
F000:058C  [+0x0858C]  BB 00 00                 mov     bx,0
F000:058F  [+0x0858F]  CD 15                    int     15h
F000:0591  [+0x08591]  83 FB 00                 cmp     bx,0
F000:0594  [+0x08594]  74 03                    je      short 0599h
F000:0596  [+0x08596]  EB 5D                    jmp     short 05F5h
F000:0598  [+0x08598]  90                       nop
F000:0599  [+0x08599]  B8 00 54                 mov     ax,5400h
F000:059C  [+0x0859C]  CD 2F                    int     2Fh
F000:059E  [+0x0859E]  3D 00 54                 cmp     ax,5400h
F000:05A1  [+0x085A1]  0F 84 20 00              je      near 05C5h
F000:05A5  [+0x085A5]  B8 01 54                 mov     ax,5401h
F000:05A8  [+0x085A8]  BB 00 00                 mov     bx,0
F000:05AB  [+0x085AB]  CD 2F                    int     2Fh
F000:05AD  [+0x085AD]  A8 00                    test    al,0
F000:05AF  [+0x085AF]  0F 85 12 00              jne     near 05C5h
F000:05B3  [+0x085B3]  80 FB 03                 cmp     bl,3
F000:05B6  [+0x085B6]  0F 85 0B 00              jne     near 05C5h
F000:05BA  [+0x085BA]  B8 01 54                 mov     ax,5401h
F000:05BD  [+0x085BD]  BB 00 01                 mov     bx,100h
F000:05C0  [+0x085C0]  CD 2F                    int     2Fh
F000:05C2  [+0x085C2]  BB 03 00                 mov     bx,3
F000:05C5  [+0x085C5]  53                       push    bx
F000:05C6  [+0x085C6]  B8 00 DC                 mov     ax,0DC00h
F000:05C9  [+0x085C9]  8E D8                    mov     ds,ax
F000:05CB  [+0x085CB]  8E C0                    mov     es,ax
F000:05CD  [+0x085CD]  E8 7A 0D                 call    134Ah
F000:05D0  [+0x085D0]  E8 83 00                 call    0656h
F000:05D3  [+0x085D3]  E8 9A 03                 call    0970h
F000:05D6  [+0x085D6]  E8 1E 00                 call    05F7h
F000:05D9  [+0x085D9]  E8 93 00                 call    066Fh
F000:05DC  [+0x085DC]  E8 7F 0D                 call    135Eh
F000:05DF  [+0x085DF]  E8 9B 03                 call    097Dh
F000:05E2  [+0x085E2]  5B                       pop     bx
F000:05E3  [+0x085E3]  83 FB 03                 cmp     bx,3
F000:05E6  [+0x085E6]  0F 85 08 00              jne     near 05F2h
F000:05EA  [+0x085EA]  B8 01 54                 mov     ax,5401h
F000:05ED  [+0x085ED]  BB 03 01                 mov     bx,103h
F000:05F0  [+0x085F0]  CD 2F                    int     2Fh
F000:05F2  [+0x085F2]  EB 01                    jmp     short 05F5h
F000:05F4  [+0x085F4]  90                       nop
F000:05F5  [+0x085F5]  61                       popa
F000:05F6  [+0x085F6]  C3                       ret
F000:05F7  [+0x085F7]  E8 C7 04                 call    0AC1h
F000:05FA  [+0x085FA]  E8 28 02                 call    0825h
F000:05FD  [+0x085FD]  E8 4F 02                 call    084Fh
F000:0600  [+0x08600]  E8 DB 00                 call    06DEh
F000:0603  [+0x08603]  E8 C8 1A                 call    20CEh
F000:0606  [+0x08606]  E8 6F 02                 call    0878h
F000:0609  [+0x08609]  E8 D4 05                 call    0BE0h
F000:060C  [+0x0860C]  B8 00 DC                 mov     ax,0DC00h
F000:060F  [+0x0860F]  8E D8                    mov     ds,ax
F000:0611  [+0x08611]  8E C0                    mov     es,ax
F000:0613  [+0x08613]  E8 34 0D                 call    134Ah
F000:0616  [+0x08616]  E8 3D 00                 call    0656h
F000:0619  [+0x08619]  E8 04 02                 call    0820h
F000:061C  [+0x0861C]  FB                       sti
F000:061D  [+0x0861D]  9A 00 01 00 F0           call    0F000h:0100h
F000:0622  [+0x08622]  FA                       cli
F000:0623  [+0x08623]  B8 00 DC                 mov     ax,0DC00h
F000:0626  [+0x08626]  8E D8                    mov     ds,ax
F000:0628  [+0x08628]  8E C0                    mov     es,ax
F000:062A  [+0x0862A]  E8 1D 0D                 call    134Ah
F000:062D  [+0x0862D]  E8 26 00                 call    0656h
F000:0630  [+0x08630]  E8 85 06                 call    0CB8h
F000:0633  [+0x08633]  B8 00 DC                 mov     ax,0DC00h
F000:0636  [+0x08636]  8E D8                    mov     ds,ax
F000:0638  [+0x08638]  8E C0                    mov     es,ax
F000:063A  [+0x0863A]  E8 0D 0D                 call    134Ah
F000:063D  [+0x0863D]  E8 16 00                 call    0656h
F000:0640  [+0x08640]  E8 4B 02                 call    088Eh
F000:0643  [+0x08643]  E8 E6 02                 call    092Ch
F000:0646  [+0x08646]  E8 5D 01                 call    07A6h
F000:0649  [+0x08649]  E8 FD 01                 call    0849h
F000:064C  [+0x0864C]  E8 EE 01                 call    083Dh
F000:064F  [+0x0864F]  E8 75 04                 call    0AC7h
F000:0652  [+0x08652]  E8 04 25                 call    2B59h
F000:0655  [+0x08655]  C3                       ret
F000:0656  [+0x08656]  B8 00 02                 mov     ax,200h
F000:0659  [+0x08659]  E8 87 0C                 call    12E3h
F000:065C  [+0x0865C]  80 CB 04                 or      bl,4
F000:065F  [+0x0865F]  E8 88 0C                 call    12EAh
F000:0662  [+0x08662]  B8 07 02                 mov     ax,207h
F000:0665  [+0x08665]  E8 7B 0C                 call    12E3h
F000:0668  [+0x08668]  80 CB 04                 or      bl,4
F000:066B  [+0x0866B]  E8 7C 0C                 call    12EAh
F000:066E  [+0x0866E]  C3                       ret
F000:066F  [+0x0866F]  B8 00 02                 mov     ax,200h
F000:0672  [+0x08672]  E8 6E 0C                 call    12E3h
F000:0675  [+0x08675]  80 E3 FB                 and     bl,0FBh
F000:0678  [+0x08678]  E8 6F 0C                 call    12EAh
F000:067B  [+0x0867B]  B8 07 02                 mov     ax,207h
F000:067E  [+0x0867E]  E8 62 0C                 call    12E3h
F000:0681  [+0x08681]  80 E3 FB                 and     bl,0FBh
F000:0684  [+0x08684]  E8 63 0C                 call    12EAh
F000:0687  [+0x08687]  C3                       ret
F000:0688  [+0x08688]  66 50                    push    eax
F000:068A  [+0x0868A]  53                       push    bx
F000:068B  [+0x0868B]  1E                       push    ds
F000:068C  [+0x0868C]  06                       push    es
F000:068D  [+0x0868D]  33 C0                    xor     ax,ax
F000:068F  [+0x0868F]  8E D8                    mov     ds,ax
F000:0691  [+0x08691]  B8 00 DC                 mov     ax,0DC00h
F000:0694  [+0x08694]  8E C0                    mov     es,ax
F000:0696  [+0x08696]  BB 24 00                 mov     bx,24h
F000:0699  [+0x08699]  66 8B 07                 mov     eax,[bx]
F000:069C  [+0x0869C]  26 66 A3 10 00           mov     [es:10h],eax
F000:06A1  [+0x086A1]  BB 58 00                 mov     bx,58h
F000:06A4  [+0x086A4]  66 8B 07                 mov     eax,[bx]
F000:06A7  [+0x086A7]  26 66 A3 1C 00           mov     [es:1Ch],eax
F000:06AC  [+0x086AC]  BB 40 00                 mov     bx,40h
F000:06AF  [+0x086AF]  66 8B 07                 mov     eax,[bx]
F000:06B2  [+0x086B2]  26 66 A3 14 00           mov     [es:14h],eax
F000:06B7  [+0x086B7]  BB 54 00                 mov     bx,54h
F000:06BA  [+0x086BA]  66 8B 07                 mov     eax,[bx]
F000:06BD  [+0x086BD]  26 66 A3 18 00           mov     [es:18h],eax
F000:06C2  [+0x086C2]  BB 84 00                 mov     bx,84h
F000:06C5  [+0x086C5]  66 8B 07                 mov     eax,[bx]
F000:06C8  [+0x086C8]  26 66 A3 20 00           mov     [es:20h],eax
F000:06CD  [+0x086CD]  BB CC 00                 mov     bx,0CCh
F000:06D0  [+0x086D0]  66 8B 07                 mov     eax,[bx]
F000:06D3  [+0x086D3]  26 66 A3 24 00           mov     [es:24h],eax
F000:06D8  [+0x086D8]  07                       pop     es
F000:06D9  [+0x086D9]  1F                       pop     ds
F000:06DA  [+0x086DA]  5B                       pop     bx
F000:06DB  [+0x086DB]  66 58                    pop     eax
F000:06DD  [+0x086DD]  C3                       ret
F000:06DE  [+0x086DE]  E8 B1 10                 call    1792h
F000:06E1  [+0x086E1]  74 01                    je      short 06E4h
F000:06E3  [+0x086E3]  C3                       ret
F000:06E4  [+0x086E4]  66 50                    push    eax
F000:06E6  [+0x086E6]  53                       push    bx
F000:06E7  [+0x086E7]  1E                       push    ds
F000:06E8  [+0x086E8]  06                       push    es
F000:06E9  [+0x086E9]  33 C0                    xor     ax,ax
F000:06EB  [+0x086EB]  8E D8                    mov     ds,ax
F000:06ED  [+0x086ED]  B8 00 DC                 mov     ax,0DC00h
F000:06F0  [+0x086F0]  8E C0                    mov     es,ax
F000:06F2  [+0x086F2]  BB 24 00                 mov     bx,24h
F000:06F5  [+0x086F5]  66 8B 07                 mov     eax,[bx]
F000:06F8  [+0x086F8]  26 66 A3 28 00           mov     [es:28h],eax
F000:06FD  [+0x086FD]  BB 58 00                 mov     bx,58h
F000:0700  [+0x08700]  66 8B 07                 mov     eax,[bx]
F000:0703  [+0x08703]  26 66 A3 34 00           mov     [es:34h],eax
F000:0708  [+0x08708]  BB 40 00                 mov     bx,40h
F000:070B  [+0x0870B]  66 8B 07                 mov     eax,[bx]
F000:070E  [+0x0870E]  26 66 A3 2C 00           mov     [es:2Ch],eax
F000:0713  [+0x08713]  BB 54 00                 mov     bx,54h
F000:0716  [+0x08716]  66 8B 07                 mov     eax,[bx]
F000:0719  [+0x08719]  26 66 A3 30 00           mov     [es:30h],eax
F000:071E  [+0x0871E]  BB 84 00                 mov     bx,84h
F000:0721  [+0x08721]  66 8B 07                 mov     eax,[bx]
F000:0724  [+0x08724]  26 66 A3 38 00           mov     [es:38h],eax
F000:0729  [+0x08729]  BB CC 00                 mov     bx,0CCh
F000:072C  [+0x0872C]  66 8B 07                 mov     eax,[bx]
F000:072F  [+0x0872F]  26 66 A3 3C 00           mov     [es:3Ch],eax
F000:0734  [+0x08734]  FA                       cli
F000:0735  [+0x08735]  26 66 A1 10 00           mov     eax,[es:10h]
F000:073A  [+0x0873A]  BB 24 00                 mov     bx,24h
F000:073D  [+0x0873D]  66 89 07                 mov     [bx],eax
F000:0740  [+0x08740]  26 66 A1 1C 00           mov     eax,[es:1Ch]
F000:0745  [+0x08745]  BB 58 00                 mov     bx,58h
F000:0748  [+0x08748]  66 89 07                 mov     [bx],eax
F000:074B  [+0x0874B]  26 66 A1 14 00           mov     eax,[es:14h]
F000:0750  [+0x08750]  BB 40 00                 mov     bx,40h
F000:0753  [+0x08753]  66 89 07                 mov     [bx],eax
F000:0756  [+0x08756]  26 66 A1 18 00           mov     eax,[es:18h]
F000:075B  [+0x0875B]  BB 54 00                 mov     bx,54h
F000:075E  [+0x0875E]  66 89 07                 mov     [bx],eax
F000:0761  [+0x08761]  26 66 A1 20 00           mov     eax,[es:20h]
F000:0766  [+0x08766]  BB 84 00                 mov     bx,84h
F000:0769  [+0x08769]  66 89 07                 mov     [bx],eax
F000:076C  [+0x0876C]  26 66 A1 24 00           mov     eax,[es:24h]
F000:0771  [+0x08771]  BB CC 00                 mov     bx,0CCh
F000:0774  [+0x08774]  66 89 07                 mov     [bx],eax
F000:0777  [+0x08777]  B8 40 00                 mov     ax,40h
F000:077A  [+0x0877A]  8E D8                    mov     ds,ax
F000:077C  [+0x0877C]  A1 1A 00                 mov     ax,[1Ah]
F000:077F  [+0x0877F]  26 A3 40 00              mov     [es:40h],ax
F000:0783  [+0x08783]  07                       pop     es
F000:0784  [+0x08784]  1F                       pop     ds
F000:0785  [+0x08785]  5B                       pop     bx
F000:0786  [+0x08786]  66 58                    pop     eax
F000:0788  [+0x08788]  C3                       ret
F000:0789  [+0x08789]  50                       push    ax
F000:078A  [+0x0878A]  53                       push    bx
F000:078B  [+0x0878B]  1E                       push    ds
F000:078C  [+0x0878C]  33 C0                    xor     ax,ax
F000:078E  [+0x0878E]  8E D8                    mov     ds,ax
F000:0790  [+0x08790]  F6 06 B6 04 02           test    byte [4B6h],2
F000:0795  [+0x08795]  74 0B                    je      short 07A2h
F000:0797  [+0x08797]  B8 F0 09                 mov     ax,9F0h
F000:079A  [+0x0879A]  BB 58 00                 mov     bx,58h
F000:079D  [+0x0879D]  89 07                    mov     [bx],ax
F000:079F  [+0x0879F]  8C 4F 02                 mov     [bx+2],cs
F000:07A2  [+0x087A2]  1F                       pop     ds
F000:07A3  [+0x087A3]  5B                       pop     bx
F000:07A4  [+0x087A4]  58                       pop     ax
F000:07A5  [+0x087A5]  C3                       ret
F000:07A6  [+0x087A6]  E8 A1 0B                 call    134Ah
F000:07A9  [+0x087A9]  E8 E6 0F                 call    1792h
F000:07AC  [+0x087AC]  74 01                    je      short 07AFh
F000:07AE  [+0x087AE]  C3                       ret
F000:07AF  [+0x087AF]  66 50                    push    eax
F000:07B1  [+0x087B1]  53                       push    bx
F000:07B2  [+0x087B2]  1E                       push    ds
F000:07B3  [+0x087B3]  06                       push    es
F000:07B4  [+0x087B4]  33 C0                    xor     ax,ax
F000:07B6  [+0x087B6]  8E D8                    mov     ds,ax
F000:07B8  [+0x087B8]  B8 00 DC                 mov     ax,0DC00h
F000:07BB  [+0x087BB]  8E C0                    mov     es,ax
F000:07BD  [+0x087BD]  FA                       cli
F000:07BE  [+0x087BE]  26 66 A1 28 00           mov     eax,[es:28h]
F000:07C3  [+0x087C3]  BB 24 00                 mov     bx,24h
F000:07C6  [+0x087C6]  66 89 07                 mov     [bx],eax
F000:07C9  [+0x087C9]  26 66 A1 34 00           mov     eax,[es:34h]
F000:07CE  [+0x087CE]  BB 58 00                 mov     bx,58h
F000:07D1  [+0x087D1]  66 89 07                 mov     [bx],eax
F000:07D4  [+0x087D4]  26 66 A1 2C 00           mov     eax,[es:2Ch]
F000:07D9  [+0x087D9]  BB 40 00                 mov     bx,40h
F000:07DC  [+0x087DC]  66 89 07                 mov     [bx],eax
F000:07DF  [+0x087DF]  26 66 A1 30 00           mov     eax,[es:30h]
F000:07E4  [+0x087E4]  BB 54 00                 mov     bx,54h
F000:07E7  [+0x087E7]  66 89 07                 mov     [bx],eax
F000:07EA  [+0x087EA]  26 66 A1 38 00           mov     eax,[es:38h]
F000:07EF  [+0x087EF]  BB 84 00                 mov     bx,84h
F000:07F2  [+0x087F2]  66 89 07                 mov     [bx],eax
F000:07F5  [+0x087F5]  26 66 A1 3C 00           mov     eax,[es:3Ch]
F000:07FA  [+0x087FA]  BB CC 00                 mov     bx,0CCh
F000:07FD  [+0x087FD]  66 89 07                 mov     [bx],eax
F000:0800  [+0x08800]  B8 40 00                 mov     ax,40h
F000:0803  [+0x08803]  8E D8                    mov     ds,ax
F000:0805  [+0x08805]  26 A1 40 00              mov     ax,[es:40h]
F000:0809  [+0x08809]  A3 1A 00                 mov     [1Ah],ax
F000:080C  [+0x0880C]  A3 1C 00                 mov     [1Ch],ax
F000:080F  [+0x0880F]  07                       pop     es
F000:0810  [+0x08810]  1F                       pop     ds
F000:0811  [+0x08811]  5B                       pop     bx
F000:0812  [+0x08812]  66 58                    pop     eax
F000:0814  [+0x08814]  C3                       ret
F000:0815  [+0x08815]  E4 64                    in      al,64h
F000:0817  [+0x08817]  A8 01                    test    al,1
F000:0819  [+0x08819]  74 04                    je      short 081Fh
F000:081B  [+0x0881B]  E4 60                    in      al,60h
F000:081D  [+0x0881D]  EB F6                    jmp     short 0815h
F000:081F  [+0x0881F]  C3                       ret
F000:0820  [+0x08820]  B0 AE                    mov     al,0AEh
F000:0822  [+0x08822]  E6 64                    out     64h,al
F000:0824  [+0x08824]  C3                       ret
F000:0825  [+0x08825]  FA                       cli
F000:0826  [+0x08826]  E4 21                    in      al,21h
F000:0828  [+0x08828]  A2 44 00                 mov     [44h],al
F000:082B  [+0x0882B]  E4 A1                    in      al,0A1h
F000:082D  [+0x0882D]  A2 45 00                 mov     [45h],al
F000:0830  [+0x08830]  B0 F9                    mov     al,0F9h
F000:0832  [+0x08832]  E6 21                    out     21h,al
F000:0834  [+0x08834]  EB 00                    jmp     short 0836h
F000:0836  [+0x08836]  EB 00                    jmp     short 0838h
F000:0838  [+0x08838]  B0 FE                    mov     al,0FEh
F000:083A  [+0x0883A]  E6 A1                    out     0A1h,al
F000:083C  [+0x0883C]  C3                       ret
F000:083D  [+0x0883D]  FA                       cli
F000:083E  [+0x0883E]  A0 44 00                 mov     al,[44h]
F000:0841  [+0x08841]  E6 21                    out     21h,al
F000:0843  [+0x08843]  A0 45 00                 mov     al,[45h]
F000:0846  [+0x08846]  E6 A1                    out     0A1h,al
F000:0848  [+0x08848]  C3                       ret
F000:0849  [+0x08849]  A0 46 00                 mov     al,[46h]
F000:084C  [+0x0884C]  E6 61                    out     61h,al
F000:084E  [+0x0884E]  C3                       ret
F000:084F  [+0x0884F]  E4 61                    in      al,61h
F000:0851  [+0x08851]  A2 46 00                 mov     [46h],al
F000:0854  [+0x08854]  24 FC                    and     al,0FCh
F000:0856  [+0x08856]  E6 61                    out     61h,al
F000:0858  [+0x08858]  C3                       ret
F000:0859  [+0x08859]  50                       push    ax
F000:085A  [+0x0885A]  52                       push    dx
F000:085B  [+0x0885B]  BA C4 03                 mov     dx,3C4h
F000:085E  [+0x0885E]  B8 02 04                 mov     ax,402h
F000:0861  [+0x08861]  EF                       out     dx,ax
F000:0862  [+0x08862]  B8 04 07                 mov     ax,704h
F000:0865  [+0x08865]  EF                       out     dx,ax
F000:0866  [+0x08866]  BA CE 03                 mov     dx,3CEh
F000:0869  [+0x08869]  B8 04 02                 mov     ax,204h
F000:086C  [+0x0886C]  EF                       out     dx,ax
F000:086D  [+0x0886D]  B8 05 00                 mov     ax,5
F000:0870  [+0x08870]  EF                       out     dx,ax
F000:0871  [+0x08871]  B8 06 04                 mov     ax,406h
F000:0874  [+0x08874]  EF                       out     dx,ax
F000:0875  [+0x08875]  5A                       pop     dx
F000:0876  [+0x08876]  58                       pop     ax
F000:0877  [+0x08877]  C3                       ret
F000:0878  [+0x08878]  1E                       push    ds
F000:0879  [+0x08879]  06                       push    es
F000:087A  [+0x0887A]  B8 00 C8                 mov     ax,0C800h
F000:087D  [+0x0887D]  8E C0                    mov     es,ax
F000:087F  [+0x0887F]  BB 00 08                 mov     bx,800h
F000:0882  [+0x08882]  B8 01 1C                 mov     ax,1C01h
F000:0885  [+0x08885]  B9 07 80                 mov     cx,8007h
F000:0888  [+0x08888]  E8 B0 2E                 call    373Bh
F000:088B  [+0x0888B]  07                       pop     es
F000:088C  [+0x0888C]  1F                       pop     ds
F000:088D  [+0x0888D]  C3                       ret
F000:088E  [+0x0888E]  1E                       push    ds
F000:088F  [+0x0888F]  06                       push    es
F000:0890  [+0x08890]  B8 00 C8                 mov     ax,0C800h
F000:0893  [+0x08893]  8E C0                    mov     es,ax
F000:0895  [+0x08895]  BB 00 08                 mov     bx,800h
F000:0898  [+0x08898]  B8 02 1C                 mov     ax,1C02h
F000:089B  [+0x0889B]  B9 07 80                 mov     cx,8007h
F000:089E  [+0x0889E]  E8 9A 2E                 call    373Bh
F000:08A1  [+0x088A1]  07                       pop     es
F000:08A2  [+0x088A2]  1F                       pop     ds
F000:08A3  [+0x088A3]  C3                       ret
F000:08A4  [+0x088A4]  1E                       push    ds
F000:08A5  [+0x088A5]  06                       push    es
F000:08A6  [+0x088A6]  BA CE 03                 mov     dx,3CEh
F000:08A9  [+0x088A9]  B8 04 02                 mov     ax,204h
F000:08AC  [+0x088AC]  EF                       out     dx,ax
F000:08AD  [+0x088AD]  B8 00 A0                 mov     ax,0A000h
F000:08B0  [+0x088B0]  8E D8                    mov     ds,ax
F000:08B2  [+0x088B2]  B8 00 C8                 mov     ax,0C800h
F000:08B5  [+0x088B5]  8E C0                    mov     es,ax
F000:08B7  [+0x088B7]  33 F6                    xor     si,si
F000:08B9  [+0x088B9]  BF A0 1E                 mov     di,1EA0h
F000:08BC  [+0x088BC]  FC                       cld
F000:08BD  [+0x088BD]  B9 08 00                 mov     cx,8
F000:08C0  [+0x088C0]  F3 A5                    rep movsw
F000:08C2  [+0x088C2]  83 C6 10                 add     si,10h
F000:08C5  [+0x088C5]  81 FE 10 20              cmp     si,2010h
F000:08C9  [+0x088C9]  7C F2                    jl      short 08BDh
F000:08CB  [+0x088CB]  07                       pop     es
F000:08CC  [+0x088CC]  1F                       pop     ds
F000:08CD  [+0x088CD]  C3                       ret
F000:08CE  [+0x088CE]  1E                       push    ds
F000:08CF  [+0x088CF]  06                       push    es
F000:08D0  [+0x088D0]  BA C4 03                 mov     dx,3C4h
F000:08D3  [+0x088D3]  B8 02 04                 mov     ax,402h
F000:08D6  [+0x088D6]  EF                       out     dx,ax
F000:08D7  [+0x088D7]  B8 00 C8                 mov     ax,0C800h
F000:08DA  [+0x088DA]  8E D8                    mov     ds,ax
F000:08DC  [+0x088DC]  B8 00 A0                 mov     ax,0A000h
F000:08DF  [+0x088DF]  8E C0                    mov     es,ax
F000:08E1  [+0x088E1]  BE A0 1E                 mov     si,1EA0h
F000:08E4  [+0x088E4]  33 FF                    xor     di,di
F000:08E6  [+0x088E6]  FC                       cld
F000:08E7  [+0x088E7]  B9 08 00                 mov     cx,8
F000:08EA  [+0x088EA]  F3 A5                    rep movsw
F000:08EC  [+0x088EC]  83 C7 10                 add     di,10h
F000:08EF  [+0x088EF]  81 FF 10 20              cmp     di,2010h
F000:08F3  [+0x088F3]  7C F2                    jl      short 08E7h
F000:08F5  [+0x088F5]  07                       pop     es
F000:08F6  [+0x088F6]  1F                       pop     ds
F000:08F7  [+0x088F7]  C3                       ret
F000:08F8  [+0x088F8]  1E                       push    ds
F000:08F9  [+0x088F9]  06                       push    es
F000:08FA  [+0x088FA]  B8 00 B8                 mov     ax,0B800h
F000:08FD  [+0x088FD]  8E D8                    mov     ds,ax
F000:08FF  [+0x088FF]  B8 00 C8                 mov     ax,0C800h
F000:0902  [+0x08902]  8E C0                    mov     es,ax
F000:0904  [+0x08904]  33 F6                    xor     si,si
F000:0906  [+0x08906]  BF 00 0F                 mov     di,0F00h
F000:0909  [+0x08909]  B9 D0 07                 mov     cx,7D0h
F000:090C  [+0x0890C]  FC                       cld
F000:090D  [+0x0890D]  F3 A5                    rep movsw
F000:090F  [+0x0890F]  07                       pop     es
F000:0910  [+0x08910]  1F                       pop     ds
F000:0911  [+0x08911]  C3                       ret
F000:0912  [+0x08912]  1E                       push    ds
F000:0913  [+0x08913]  06                       push    es
F000:0914  [+0x08914]  B8 00 C8                 mov     ax,0C800h
F000:0917  [+0x08917]  8E D8                    mov     ds,ax
F000:0919  [+0x08919]  B8 00 B8                 mov     ax,0B800h
F000:091C  [+0x0891C]  8E C0                    mov     es,ax
F000:091E  [+0x0891E]  BE 00 0F                 mov     si,0F00h
F000:0921  [+0x08921]  33 FF                    xor     di,di
F000:0923  [+0x08923]  B9 D0 07                 mov     cx,7D0h
F000:0926  [+0x08926]  FC                       cld
F000:0927  [+0x08927]  F3 A5                    rep movsw
F000:0929  [+0x08929]  07                       pop     es
F000:092A  [+0x0892A]  1F                       pop     ds
F000:092B  [+0x0892B]  C3                       ret
F000:092C  [+0x0892C]  1E                       push    ds
F000:092D  [+0x0892D]  B8 40 00                 mov     ax,40h
F000:0930  [+0x08930]  8E D8                    mov     ds,ax
F000:0932  [+0x08932]  8A 26 B6 00              mov     ah,[0B6h]
F000:0936  [+0x08936]  80 26 B6 00 BD           and     byte [0B6h],0BDh
F000:093B  [+0x0893B]  F6 C4 40                 test    ah,40h
F000:093E  [+0x0893E]  1F                       pop     ds
F000:093F  [+0x0893F]  74 12                    je      short 0953h
F000:0941  [+0x08941]  E8 E1 2E                 call    3825h
F000:0944  [+0x08944]  50                       push    ax
F000:0945  [+0x08945]  B0 4E                    mov     al,4Eh
F000:0947  [+0x08947]  E6 80                    out     80h,al
F000:0949  [+0x08949]  58                       pop     ax
F000:094A  [+0x0894A]  E8 27 0F                 call    1874h
F000:094D  [+0x0894D]  50                       push    ax
F000:094E  [+0x0894E]  B0 4F                    mov     al,4Fh
F000:0950  [+0x08950]  E6 80                    out     80h,al
F000:0952  [+0x08952]  58                       pop     ax
F000:0953  [+0x08953]  C3                       ret
F000:0954  [+0x08954]  1E                       push    ds
F000:0955  [+0x08955]  B8 40 00                 mov     ax,40h
F000:0958  [+0x08958]  8E D8                    mov     ds,ax
F000:095A  [+0x0895A]  80 0E B6 00 02           or      byte [0B6h],2
F000:095F  [+0x0895F]  B0 50                    mov     al,50h
F000:0961  [+0x08961]  A2 B7 00                 mov     [0B7h],al
F000:0964  [+0x08964]  B0 6F                    mov     al,6Fh
F000:0966  [+0x08966]  A2 B8 00                 mov     [0B8h],al
F000:0969  [+0x08969]  B0 70                    mov     al,70h
F000:096B  [+0x0896B]  A2 B9 00                 mov     [0B9h],al
F000:096E  [+0x0896E]  1F                       pop     ds
F000:096F  [+0x0896F]  C3                       ret
F000:0970  [+0x08970]  1E                       push    ds
F000:0971  [+0x08971]  B8 40 00                 mov     ax,40h
F000:0974  [+0x08974]  8E D8                    mov     ds,ax
F000:0976  [+0x08976]  80 0E B6 00 80           or      byte [0B6h],80h
F000:097B  [+0x0897B]  1F                       pop     ds
F000:097C  [+0x0897C]  C3                       ret
F000:097D  [+0x0897D]  1E                       push    ds
F000:097E  [+0x0897E]  B8 40 00                 mov     ax,40h
F000:0981  [+0x08981]  8E D8                    mov     ds,ax
F000:0983  [+0x08983]  80 26 B6 00 7F           and     byte [0B6h],7Fh
F000:0988  [+0x08988]  1F                       pop     ds
F000:0989  [+0x08989]  52                       push    dx
F000:098A  [+0x0898A]  51                       push    cx
F000:098B  [+0x0898B]  53                       push    bx
F000:098C  [+0x0898C]  50                       push    ax
F000:098D  [+0x0898D]  B8 01 00                 mov     ax,1
F000:0990  [+0x08990]  BA F7 00                 mov     dx,0F7h
F000:0993  [+0x08993]  E8 A2 09                 call    1338h
F000:0996  [+0x08996]  58                       pop     ax
F000:0997  [+0x08997]  5B                       pop     bx
F000:0998  [+0x08998]  59                       pop     cx
F000:0999  [+0x08999]  5A                       pop     dx
F000:099A  [+0x0899A]  C3                       ret
F000:099B  [+0x0899B]  1E                       push    ds
F000:099C  [+0x0899C]  B8 40 00                 mov     ax,40h
F000:099F  [+0x0899F]  8E D8                    mov     ds,ax
F000:09A1  [+0x089A1]  F6 06 B6 00 80           test    byte [0B6h],80h
F000:09A6  [+0x089A6]  1F                       pop     ds
F000:09A7  [+0x089A7]  C3                       ret
F000:09A8  [+0x089A8]  C3                       ret
F000:09A9  [+0x089A9]  50                       push    ax
F000:09AA  [+0x089AA]  1E                       push    ds
F000:09AB  [+0x089AB]  6A 40                    push    40h
F000:09AD  [+0x089AD]  1F                       pop     ds
F000:09AE  [+0x089AE]  A0 17 00                 mov     al,[17h]
F000:09B1  [+0x089B1]  24 70                    and     al,70h
F000:09B3  [+0x089B3]  C0 E8 04                 shr     al,4
F000:09B6  [+0x089B6]  E8 03 00                 call    09BCh
F000:09B9  [+0x089B9]  1F                       pop     ds
F000:09BA  [+0x089BA]  58                       pop     ax
F000:09BB  [+0x089BB]  C3                       ret
F000:09BC  [+0x089BC]  C3                       ret
F000:09BD  [+0x089BD]  50                       push    ax
F000:09BE  [+0x089BE]  51                       push    cx
F000:09BF  [+0x089BF]  50                       push    ax
F000:09C0  [+0x089C0]  B9 00 10                 mov     cx,1000h
F000:09C3  [+0x089C3]  E4 60                    in      al,60h
F000:09C5  [+0x089C5]  B0 ED                    mov     al,0EDh
F000:09C7  [+0x089C7]  E8 F0 2C                 call    36BAh
F000:09CA  [+0x089CA]  E6 60                    out     60h,al
F000:09CC  [+0x089CC]  E8 F4 2C                 call    36C3h
F000:09CF  [+0x089CF]  3C FA                    cmp     al,0FAh
F000:09D1  [+0x089D1]  74 05                    je      short 09D8h
F000:09D3  [+0x089D3]  E2 EE                    loop    09C3h
F000:09D5  [+0x089D5]  58                       pop     ax
F000:09D6  [+0x089D6]  EB 06                    jmp     short 09DEh
F000:09D8  [+0x089D8]  58                       pop     ax
F000:09D9  [+0x089D9]  E6 60                    out     60h,al
F000:09DB  [+0x089DB]  E8 E5 2C                 call    36C3h
F000:09DE  [+0x089DE]  59                       pop     cx
F000:09DF  [+0x089DF]  58                       pop     ax
F000:09E0  [+0x089E0]  C3                       ret
F000:09E1  [+0x089E1]  50                       push    ax
F000:09E2  [+0x089E2]  1E                       push    ds
F000:09E3  [+0x089E3]  B8 40 00                 mov     ax,40h
F000:09E6  [+0x089E6]  8E D8                    mov     ds,ax
F000:09E8  [+0x089E8]  80 0E B9 00 80           or      byte [0B9h],80h
F000:09ED  [+0x089ED]  1F                       pop     ds
F000:09EE  [+0x089EE]  58                       pop     ax
F000:09EF  [+0x089EF]  C3                       ret
F000:09F0  [+0x089F0]  80 FC 01                 cmp     ah,1
F000:09F3  [+0x089F3]  77 0D                    ja      short 0A02h
F000:09F5  [+0x089F5]  74 05                    je      short 09FCh
F000:09F7  [+0x089F7]  E8 0B 00                 call    0A05h
F000:09FA  [+0x089FA]  EB 06                    jmp     short 0A02h
F000:09FC  [+0x089FC]  50                       push    ax
F000:09FD  [+0x089FD]  E4 64                    in      al,64h
F000:09FF  [+0x089FF]  A8 01                    test    al,1
F000:0A01  [+0x08A01]  58                       pop     ax
F000:0A02  [+0x08A02]  CA 02 00                 retf    2
F000:0A05  [+0x08A05]  E4 64                    in      al,64h
F000:0A07  [+0x08A07]  A8 01                    test    al,1
F000:0A09  [+0x08A09]  74 FA                    je      short 0A05h
F000:0A0B  [+0x08A0B]  E4 60                    in      al,60h
F000:0A0D  [+0x08A0D]  A8 80                    test    al,80h
F000:0A0F  [+0x08A0F]  75 F4                    jne     short 0A05h
F000:0A11  [+0x08A11]  8A E0                    mov     ah,al
F000:0A13  [+0x08A13]  06                       push    es
F000:0A14  [+0x08A14]  57                       push    di
F000:0A15  [+0x08A15]  51                       push    cx
F000:0A16  [+0x08A16]  0E                       push    cs
F000:0A17  [+0x08A17]  07                       pop     es
F000:0A18  [+0x08A18]  B9 11 00                 mov     cx,11h
F000:0A1B  [+0x08A1B]  BF 33 0A                 mov     di,0A33h
F000:0A1E  [+0x08A1E]  FC                       cld
F000:0A1F  [+0x08A1F]  F2 AE                    repne scasb
F000:0A21  [+0x08A21]  B0 00                    mov     al,0
F000:0A23  [+0x08A23]  75 0A                    jne     short 0A2Fh
F000:0A25  [+0x08A25]  53                       push    bx
F000:0A26  [+0x08A26]  BB 54 0A                 mov     bx,0A54h
F000:0A29  [+0x08A29]  2B D9                    sub     bx,cx
F000:0A2B  [+0x08A2B]  2E 8A 07                 mov     al,[cs:bx]
F000:0A2E  [+0x08A2E]  5B                       pop     bx
F000:0A2F  [+0x08A2F]  59                       pop     cx
F000:0A30  [+0x08A30]  5F                       pop     di
F000:0A31  [+0x08A31]  07                       pop     es
F000:0A32  [+0x08A32]  C3                       ret
F000:0A33  [+0x08A33]  02 03                    add     al,[bp+di]
F000:0A35  [+0x08A35]  04 05                    add     al,5
F000:0A37  [+0x08A37]  06                       push    es
F000:0A38  [+0x08A38]  07                       pop     es
F000:0A39  [+0x08A39]  08 09                    or      [bx+di],cl
F000:0A3B  [+0x08A3B]  0A 0B                    or      cl,[bp+di]
F000:0A3D  [+0x08A3D]  0E                       push    cs
F000:0A3E  [+0x08A3E]  4E                       dec     si
F000:0A3F  [+0x08A3F]  4A                       dec     dx
F000:0A40  [+0x08A40]  01 39                    add     [bx+di],di
F000:0A42  [+0x08A42]  0D 0C 31                 or      ax,310Ch
F000:0A45  [+0x08A45]  32 33                    xor     dh,[bp+di]
F000:0A47  [+0x08A47]  34 35                    xor     al,35h
F000:0A49  [+0x08A49]  36 37                    aaa
F000:0A4B  [+0x08A4B]  38 39                    cmp     [bx+di],bh
F000:0A4D  [+0x08A4D]  30 08                    xor     [bx+si],cl
F000:0A4F  [+0x08A4F]  2B 2D                    sub     bp,[di]
F000:0A51  [+0x08A51]  1B 20                    sbb     sp,[bx+si]
F000:0A53  [+0x08A53]  3D 2D 48                 cmp     ax,482Dh
F000:0A56  [+0x08A56]  4B                       dec     bx
F000:0A57  [+0x08A57]  4D                       dec     bp
F000:0A58  [+0x08A58]  50                       push    ax
F000:0A59  [+0x08A59]  3E 3F                    aas
F000:0A5B  [+0x08A5B]  40                       inc     ax
F000:0A5C  [+0x08A5C]  45                       inc     bp
F000:0A5D  [+0x08A5D]  52                       push    dx
F000:0A5E  [+0x08A5E]  53                       push    bx
F000:0A5F  [+0x08A5F]  3E 49                    dec     cx
F000:0A61  [+0x08A61]  51                       push    cx
F000:0A62  [+0x08A62]  01 39                    add     [bx+di],di
F000:0A64  [+0x08A64]  4E                       dec     si
F000:0A65  [+0x08A65]  4A                       dec     dx
F000:0A66  [+0x08A66]  0C 0D                    or      al,0Dh
F000:0A68  [+0x08A68]  0E                       push    cs
F000:0A69  [+0x08A69]  B8 00 DF                 mov     ax,0DF00h
F000:0A6C  [+0x08A6C]  C3                       ret
F000:0A6D  [+0x08A6D]  E8 41 00                 call    0AB1h
F000:0A70  [+0x08A70]  E8 47 2C                 call    36BAh
F000:0A73  [+0x08A73]  B0 20                    mov     al,20h
F000:0A75  [+0x08A75]  E6 64                    out     64h,al
F000:0A77  [+0x08A77]  E8 49 2C                 call    36C3h
F000:0A7A  [+0x08A7A]  A2 47 00                 mov     [47h],al
F000:0A7D  [+0x08A7D]  B0 60                    mov     al,60h
F000:0A7F  [+0x08A7F]  E6 64                    out     64h,al
F000:0A81  [+0x08A81]  E8 36 2C                 call    36BAh
F000:0A84  [+0x08A84]  B0 65                    mov     al,65h
F000:0A86  [+0x08A86]  E6 60                    out     60h,al
F000:0A88  [+0x08A88]  C3                       ret
F000:0A89  [+0x08A89]  E8 25 00                 call    0AB1h
F000:0A8C  [+0x08A8C]  E8 2B 2C                 call    36BAh
F000:0A8F  [+0x08A8F]  B0 60                    mov     al,60h
F000:0A91  [+0x08A91]  E6 64                    out     64h,al
F000:0A93  [+0x08A93]  E8 24 2C                 call    36BAh
F000:0A96  [+0x08A96]  A0 47 00                 mov     al,[47h]
F000:0A99  [+0x08A99]  E6 60                    out     60h,al
F000:0A9B  [+0x08A9B]  E8 01 00                 call    0A9Fh
F000:0A9E  [+0x08A9E]  C3                       ret
F000:0A9F  [+0x08A9F]  1E                       push    ds
F000:0AA0  [+0x08AA0]  B8 40 00                 mov     ax,40h
F000:0AA3  [+0x08AA3]  8E D8                    mov     ds,ax
F000:0AA5  [+0x08AA5]  A1 0E 00                 mov     ax,[0Eh]
F000:0AA8  [+0x08AA8]  8E D8                    mov     ds,ax
F000:0AAA  [+0x08AAA]  80 26 26 00 F8           and     byte [26h],0F8h
F000:0AAF  [+0x08AAF]  1F                       pop     ds
F000:0AB0  [+0x08AB0]  C3                       ret
F000:0AB1  [+0x08AB1]  50                       push    ax
F000:0AB2  [+0x08AB2]  E4 64                    in      al,64h
F000:0AB4  [+0x08AB4]  A8 01                    test    al,1
F000:0AB6  [+0x08AB6]  74 07                    je      short 0ABFh
F000:0AB8  [+0x08AB8]  E4 60                    in      al,60h
F000:0ABA  [+0x08ABA]  E8 84 15                 call    2041h
F000:0ABD  [+0x08ABD]  EB F3                    jmp     short 0AB2h
F000:0ABF  [+0x08ABF]  58                       pop     ax
F000:0AC0  [+0x08AC0]  C3                       ret
F000:0AC1  [+0x08AC1]  B0 A7                    mov     al,0A7h
F000:0AC3  [+0x08AC3]  E8 0A 00                 call    0AD0h
F000:0AC6  [+0x08AC6]  C3                       ret
F000:0AC7  [+0x08AC7]  B0 A8                    mov     al,0A8h
F000:0AC9  [+0x08AC9]  E8 04 00                 call    0AD0h
F000:0ACC  [+0x08ACC]  E8 46 FD                 call    0815h
F000:0ACF  [+0x08ACF]  C3                       ret
F000:0AD0  [+0x08AD0]  50                       push    ax
F000:0AD1  [+0x08AD1]  51                       push    cx
F000:0AD2  [+0x08AD2]  33 C9                    xor     cx,cx
F000:0AD4  [+0x08AD4]  8A E0                    mov     ah,al
F000:0AD6  [+0x08AD6]  FA                       cli
F000:0AD7  [+0x08AD7]  E4 64                    in      al,64h
F000:0AD9  [+0x08AD9]  A8 02                    test    al,2
F000:0ADB  [+0x08ADB]  0F 84 04 00              je      near 0AE3h
F000:0ADF  [+0x08ADF]  E2 F6                    loop    0AD7h
F000:0AE1  [+0x08AE1]  EB 04                    jmp     short 0AE7h
F000:0AE3  [+0x08AE3]  8A C4                    mov     al,ah
F000:0AE5  [+0x08AE5]  E6 64                    out     64h,al
F000:0AE7  [+0x08AE7]  59                       pop     cx
F000:0AE8  [+0x08AE8]  58                       pop     ax
F000:0AE9  [+0x08AE9]  C3                       ret
F000:0AEA  [+0x08AEA]  C3                       ret
F000:0AEB  [+0x08AEB]  9C                       pushf
F000:0AEC  [+0x08AEC]  50                       push    ax
F000:0AED  [+0x08AED]  53                       push    bx
F000:0AEE  [+0x08AEE]  51                       push    cx
F000:0AEF  [+0x08AEF]  52                       push    dx
F000:0AF0  [+0x08AF0]  FA                       cli
F000:0AF1  [+0x08AF1]  BA 2C 02                 mov     dx,22Ch
F000:0AF4  [+0x08AF4]  B9 20 00                 mov     cx,20h
F000:0AF7  [+0x08AF7]  BB 04 00                 mov     bx,4
F000:0AFA  [+0x08AFA]  EC                       in      al,dx
F000:0AFB  [+0x08AFB]  A8 80                    test    al,80h
F000:0AFD  [+0x08AFD]  0F 84 0F 00              je      near 0B10h
F000:0B01  [+0x08B01]  4B                       dec     bx
F000:0B02  [+0x08B02]  75 F6                    jne     short 0AFAh
F000:0B04  [+0x08B04]  BA 2C 02                 mov     dx,22Ch
F000:0B07  [+0x08B07]  B0 D3                    mov     al,0D3h
F000:0B09  [+0x08B09]  EE                       out     dx,al
F000:0B0A  [+0x08B0A]  E8 78 00                 call    0B85h
F000:0B0D  [+0x08B0D]  EB 10                    jmp     short 0B1Fh
F000:0B0F  [+0x08B0F]  90                       nop
F000:0B10  [+0x08B10]  E3 0D                    jcxz    0B1Fh
F000:0B12  [+0x08B12]  A8 04                    test    al,4
F000:0B14  [+0x08B14]  0F 84 07 00              je      near 0B1Fh
F000:0B18  [+0x08B18]  FB                       sti
F000:0B19  [+0x08B19]  50                       push    ax
F000:0B1A  [+0x08B1A]  58                       pop     ax
F000:0B1B  [+0x08B1B]  FA                       cli
F000:0B1C  [+0x08B1C]  49                       dec     cx
F000:0B1D  [+0x08B1D]  EB D8                    jmp     short 0AF7h
F000:0B1F  [+0x08B1F]  B0 FD                    mov     al,0FDh
F000:0B21  [+0x08B21]  EE                       out     dx,al
F000:0B22  [+0x08B22]  FB                       sti
F000:0B23  [+0x08B23]  5A                       pop     dx
F000:0B24  [+0x08B24]  59                       pop     cx
F000:0B25  [+0x08B25]  5B                       pop     bx
F000:0B26  [+0x08B26]  58                       pop     ax
F000:0B27  [+0x08B27]  9D                       popf
F000:0B28  [+0x08B28]  C3                       ret
F000:0B29  [+0x08B29]  9C                       pushf
F000:0B2A  [+0x08B2A]  50                       push    ax
F000:0B2B  [+0x08B2B]  53                       push    bx
F000:0B2C  [+0x08B2C]  51                       push    cx
F000:0B2D  [+0x08B2D]  52                       push    dx
F000:0B2E  [+0x08B2E]  FA                       cli
F000:0B2F  [+0x08B2F]  BA 2C 02                 mov     dx,22Ch
F000:0B32  [+0x08B32]  B0 EF                    mov     al,0EFh
F000:0B34  [+0x08B34]  EE                       out     dx,al
F000:0B35  [+0x08B35]  BA 26 02                 mov     dx,226h
F000:0B38  [+0x08B38]  B0 01                    mov     al,1
F000:0B3A  [+0x08B3A]  EE                       out     dx,al
F000:0B3B  [+0x08B3B]  B0 F1                    mov     al,0F1h
F000:0B3D  [+0x08B3D]  E6 80                    out     80h,al
F000:0B3F  [+0x08B3F]  E8 33 00                 call    0B75h
F000:0B42  [+0x08B42]  B0 F2                    mov     al,0F2h
F000:0B44  [+0x08B44]  E6 80                    out     80h,al
F000:0B46  [+0x08B46]  B0 00                    mov     al,0
F000:0B48  [+0x08B48]  EE                       out     dx,al
F000:0B49  [+0x08B49]  E8 29 00                 call    0B75h
F000:0B4C  [+0x08B4C]  B0 F3                    mov     al,0F3h
F000:0B4E  [+0x08B4E]  E6 80                    out     80h,al
F000:0B50  [+0x08B50]  B9 00 10                 mov     cx,1000h
F000:0B53  [+0x08B53]  BA 2C 02                 mov     dx,22Ch
F000:0B56  [+0x08B56]  EC                       in      al,dx
F000:0B57  [+0x08B57]  A8 40                    test    al,40h
F000:0B59  [+0x08B59]  0F 85 05 00              jne     near 0B62h
F000:0B5D  [+0x08B5D]  E2 F4                    loop    0B53h
F000:0B5F  [+0x08B5F]  E8 23 00                 call    0B85h
F000:0B62  [+0x08B62]  BA 2A 02                 mov     dx,22Ah
F000:0B65  [+0x08B65]  EC                       in      al,dx
F000:0B66  [+0x08B66]  3C AB                    cmp     al,0ABh
F000:0B68  [+0x08B68]  75 E9                    jne     short 0B53h
F000:0B6A  [+0x08B6A]  FB                       sti
F000:0B6B  [+0x08B6B]  B0 F4                    mov     al,0F4h
F000:0B6D  [+0x08B6D]  E6 80                    out     80h,al
F000:0B6F  [+0x08B6F]  5A                       pop     dx
F000:0B70  [+0x08B70]  59                       pop     cx
F000:0B71  [+0x08B71]  5B                       pop     bx
F000:0B72  [+0x08B72]  58                       pop     ax
F000:0B73  [+0x08B73]  9D                       popf
F000:0B74  [+0x08B74]  C3                       ret
F000:0B75  [+0x08B75]  51                       push    cx
F000:0B76  [+0x08B76]  B9 10 00                 mov     cx,10h
F000:0B79  [+0x08B79]  51                       push    cx
F000:0B7A  [+0x08B7A]  B9 F0 FF                 mov     cx,0FFF0h
F000:0B7D  [+0x08B7D]  90                       nop
F000:0B7E  [+0x08B7E]  E2 FD                    loop    0B7Dh
F000:0B80  [+0x08B80]  59                       pop     cx
F000:0B81  [+0x08B81]  E2 F6                    loop    0B79h
F000:0B83  [+0x08B83]  59                       pop     cx
F000:0B84  [+0x08B84]  C3                       ret
F000:0B85  [+0x08B85]  BA 2C 02                 mov     dx,22Ch
F000:0B88  [+0x08B88]  B0 EF                    mov     al,0EFh
F000:0B8A  [+0x08B8A]  EE                       out     dx,al
F000:0B8B  [+0x08B8B]  E8 E7 FF                 call    0B75h
F000:0B8E  [+0x08B8E]  B9 10 00                 mov     cx,10h
F000:0B91  [+0x08B91]  BA 2C 02                 mov     dx,22Ch
F000:0B94  [+0x08B94]  EC                       in      al,dx
F000:0B95  [+0x08B95]  A8 40                    test    al,40h
F000:0B97  [+0x08B97]  0F 85 02 00              jne     near 0B9Dh
F000:0B9B  [+0x08B9B]  E2 F4                    loop    0B91h
F000:0B9D  [+0x08B9D]  BA 2A 02                 mov     dx,22Ah
F000:0BA0  [+0x08BA0]  EC                       in      al,dx
F000:0BA1  [+0x08BA1]  EB 00                    jmp     short 0BA3h
F000:0BA3  [+0x08BA3]  EB 00                    jmp     short 0BA5h
F000:0BA5  [+0x08BA5]  EB 00                    jmp     short 0BA7h
F000:0BA7  [+0x08BA7]  3C AA                    cmp     al,0AAh
F000:0BA9  [+0x08BA9]  75 DA                    jne     short 0B85h
F000:0BAB  [+0x08BAB]  C3                       ret
F000:0BAC  [+0x08BAC]  9C                       pushf
F000:0BAD  [+0x08BAD]  50                       push    ax
F000:0BAE  [+0x08BAE]  51                       push    cx
F000:0BAF  [+0x08BAF]  52                       push    dx
F000:0BB0  [+0x08BB0]  FA                       cli
F000:0BB1  [+0x08BB1]  BA 2C 02                 mov     dx,22Ch
F000:0BB4  [+0x08BB4]  B9 20 00                 mov     cx,20h
F000:0BB7  [+0x08BB7]  BB 04 00                 mov     bx,4
F000:0BBA  [+0x08BBA]  EC                       in      al,dx
F000:0BBB  [+0x08BBB]  A8 80                    test    al,80h
F000:0BBD  [+0x08BBD]  0F 84 08 00              je      near 0BC9h
F000:0BC1  [+0x08BC1]  4B                       dec     bx
F000:0BC2  [+0x08BC2]  75 F6                    jne     short 0BBAh
F000:0BC4  [+0x08BC4]  B3 FF                    mov     bl,0FFh
F000:0BC6  [+0x08BC6]  EB 13                    jmp     short 0BDBh
F000:0BC8  [+0x08BC8]  90                       nop
F000:0BC9  [+0x08BC9]  E3 0E                    jcxz    0BD9h
F000:0BCB  [+0x08BCB]  A8 04                    test    al,4
F000:0BCD  [+0x08BCD]  0F 84 08 00              je      near 0BD9h
F000:0BD1  [+0x08BD1]  B3 FF                    mov     bl,0FFh
F000:0BD3  [+0x08BD3]  EB 06                    jmp     short 0BDBh
F000:0BD5  [+0x08BD5]  90                       nop
F000:0BD6  [+0x08BD6]  49                       dec     cx
F000:0BD7  [+0x08BD7]  EB DE                    jmp     short 0BB7h
F000:0BD9  [+0x08BD9]  B3 00                    mov     bl,0
F000:0BDB  [+0x08BDB]  5A                       pop     dx
F000:0BDC  [+0x08BDC]  59                       pop     cx
F000:0BDD  [+0x08BDD]  58                       pop     ax
F000:0BDE  [+0x08BDE]  9D                       popf
F000:0BDF  [+0x08BDF]  C3                       ret
F000:0BE0  [+0x08BE0]  60                       pusha
F000:0BE1  [+0x08BE1]  1E                       push    ds
F000:0BE2  [+0x08BE2]  06                       push    es
F000:0BE3  [+0x08BE3]  9C                       pushf
F000:0BE4  [+0x08BE4]  FA                       cli
F000:0BE5  [+0x08BE5]  E4 21                    in      al,21h
F000:0BE7  [+0x08BE7]  86 C4                    xchg    al,ah
F000:0BE9  [+0x08BE9]  E4 A1                    in      al,0A1h
F000:0BEB  [+0x08BEB]  50                       push    ax
F000:0BEC  [+0x08BEC]  B0 FF                    mov     al,0FFh
F000:0BEE  [+0x08BEE]  E6 21                    out     21h,al
F000:0BF0  [+0x08BF0]  E6 A1                    out     0A1h,al
F000:0BF2  [+0x08BF2]  B8 00 F0                 mov     ax,0F000h
F000:0BF5  [+0x08BF5]  8E D8                    mov     ds,ax
F000:0BF7  [+0x08BF7]  B8 00 DC                 mov     ax,0DC00h
F000:0BFA  [+0x08BFA]  8E C0                    mov     es,ax
F000:0BFC  [+0x08BFC]  BE B1 E6                 mov     si,0E6B1h
F000:0BFF  [+0x08BFF]  BF 48 00                 mov     di,48h
F000:0C02  [+0x08C02]  B9 10 00                 mov     cx,10h
F000:0C05  [+0x08C05]  FC                       cld
F000:0C06  [+0x08C06]  F3 66 A5                 rep movsd
F000:0C09  [+0x08C09]  BE EC FF                 mov     si,0FFECh
F000:0C0C  [+0x08C0C]  BF 88 00                 mov     di,88h
F000:0C0F  [+0x08C0F]  B9 01 00                 mov     cx,1
F000:0C12  [+0x08C12]  FC                       cld
F000:0C13  [+0x08C13]  F3 66 A5                 rep movsd
F000:0C16  [+0x08C16]  E8 AA 01                 call    0DC3h
F000:0C19  [+0x08C19]  B8 00 02                 mov     ax,200h
F000:0C1C  [+0x08C1C]  BB 8F 0C                 mov     bx,0C8Fh
F000:0C1F  [+0x08C1F]  E8 C8 06                 call    12EAh
F000:0C22  [+0x08C22]  B8 07 02                 mov     ax,207h
F000:0C25  [+0x08C25]  BA BF 13                 mov     dx,13BFh
F000:0C28  [+0x08C28]  E8 0D 07                 call    1338h
F000:0C2B  [+0x08C2B]  FA                       cli
F000:0C2C  [+0x08C2C]  BA CC 03                 mov     dx,3CCh
F000:0C2F  [+0x08C2F]  EC                       in      al,dx
F000:0C30  [+0x08C30]  0C 02                    or      al,2
F000:0C32  [+0x08C32]  BA C2 03                 mov     dx,3C2h
F000:0C35  [+0x08C35]  EE                       out     dx,al
F000:0C36  [+0x08C36]  BA C4 03                 mov     dx,3C4h
F000:0C39  [+0x08C39]  B8 01 21                 mov     ax,2101h
F000:0C3C  [+0x08C3C]  EF                       out     dx,ax
F000:0C3D  [+0x08C3D]  B8 04 0E                 mov     ax,0E04h
F000:0C40  [+0x08C40]  EF                       out     dx,ax
F000:0C41  [+0x08C41]  BA CE 03                 mov     dx,3CEh
F000:0C44  [+0x08C44]  B8 05 00                 mov     ax,5
F000:0C47  [+0x08C47]  EF                       out     dx,ax
F000:0C48  [+0x08C48]  B8 06 05                 mov     ax,506h
F000:0C4B  [+0x08C4B]  EF                       out     dx,ax
F000:0C4C  [+0x08C4C]  BA D6 03                 mov     dx,3D6h
F000:0C4F  [+0x08C4F]  B8 0B 05                 mov     ax,50Bh
F000:0C52  [+0x08C52]  EF                       out     dx,ax
F000:0C53  [+0x08C53]  B8 10 00                 mov     ax,10h
F000:0C56  [+0x08C56]  BA D6 03                 mov     dx,3D6h
F000:0C59  [+0x08C59]  EF                       out     dx,ax
F000:0C5A  [+0x08C5A]  BF 00 F0                 mov     di,0F000h
F000:0C5D  [+0x08C5D]  E8 7A 01                 call    0DDAh
F000:0C60  [+0x08C60]  B8 10 10                 mov     ax,1010h
F000:0C63  [+0x08C63]  BA D6 03                 mov     dx,3D6h
F000:0C66  [+0x08C66]  EF                       out     dx,ax
F000:0C67  [+0x08C67]  BE 00 A0                 mov     si,0A000h
F000:0C6A  [+0x08C6A]  8E DE                    mov     ds,si
F000:0C6C  [+0x08C6C]  BF 00 D0                 mov     di,0D000h
F000:0C6F  [+0x08C6F]  8E C7                    mov     es,di
F000:0C71  [+0x08C71]  E8 83 01                 call    0DF7h
F000:0C74  [+0x08C74]  BE 00 A8                 mov     si,0A800h
F000:0C77  [+0x08C77]  8E DE                    mov     ds,si
F000:0C79  [+0x08C79]  BF 00 E0                 mov     di,0E000h
F000:0C7C  [+0x08C7C]  8E C7                    mov     es,di
F000:0C7E  [+0x08C7E]  E8 76 01                 call    0DF7h
F000:0C81  [+0x08C81]  B8 10 20                 mov     ax,2010h
F000:0C84  [+0x08C84]  BA D6 03                 mov     dx,3D6h
F000:0C87  [+0x08C87]  EF                       out     dx,ax
F000:0C88  [+0x08C88]  BE 00 A0                 mov     si,0A000h
F000:0C8B  [+0x08C8B]  8E DE                    mov     ds,si
F000:0C8D  [+0x08C8D]  BF 00 C0                 mov     di,0C000h
F000:0C90  [+0x08C90]  8E C7                    mov     es,di
F000:0C92  [+0x08C92]  E8 62 01                 call    0DF7h
F000:0C95  [+0x08C95]  B8 07 02                 mov     ax,207h
F000:0C98  [+0x08C98]  BA 7F 1F                 mov     dx,1F7Fh
F000:0C9B  [+0x08C9B]  E8 A3 06                 call    1341h
F000:0C9E  [+0x08C9E]  E8 2D 01                 call    0DCEh
F000:0CA1  [+0x08CA1]  B8 00 DC                 mov     ax,0DC00h
F000:0CA4  [+0x08CA4]  8E D8                    mov     ds,ax
F000:0CA6  [+0x08CA6]  B8 83 00                 mov     ax,83h
F000:0CA9  [+0x08CA9]  E8 8F 2A                 call    373Bh
F000:0CAC  [+0x08CAC]  58                       pop     ax
F000:0CAD  [+0x08CAD]  E6 A1                    out     0A1h,al
F000:0CAF  [+0x08CAF]  86 C4                    xchg    al,ah
F000:0CB1  [+0x08CB1]  E6 21                    out     21h,al
F000:0CB3  [+0x08CB3]  9D                       popf
F000:0CB4  [+0x08CB4]  07                       pop     es
F000:0CB5  [+0x08CB5]  1F                       pop     ds
F000:0CB6  [+0x08CB6]  61                       popa
F000:0CB7  [+0x08CB7]  C3                       ret
F000:0CB8  [+0x08CB8]  60                       pusha
F000:0CB9  [+0x08CB9]  1E                       push    ds
F000:0CBA  [+0x08CBA]  06                       push    es
F000:0CBB  [+0x08CBB]  9C                       pushf
F000:0CBC  [+0x08CBC]  FA                       cli
F000:0CBD  [+0x08CBD]  E4 21                    in      al,21h
F000:0CBF  [+0x08CBF]  86 C4                    xchg    al,ah
F000:0CC1  [+0x08CC1]  E4 A1                    in      al,0A1h
F000:0CC3  [+0x08CC3]  50                       push    ax
F000:0CC4  [+0x08CC4]  B0 FF                    mov     al,0FFh
F000:0CC6  [+0x08CC6]  E6 21                    out     21h,al
F000:0CC8  [+0x08CC8]  E6 A1                    out     0A1h,al
F000:0CCA  [+0x08CCA]  E8 F6 00                 call    0DC3h
F000:0CCD  [+0x08CCD]  B8 00 02                 mov     ax,200h
F000:0CD0  [+0x08CD0]  BB FF 1F                 mov     bx,1FFFh
F000:0CD3  [+0x08CD3]  E8 14 06                 call    12EAh
F000:0CD6  [+0x08CD6]  B8 07 02                 mov     ax,207h
F000:0CD9  [+0x08CD9]  BB 80 00                 mov     bx,80h
F000:0CDC  [+0x08CDC]  E8 0B 06                 call    12EAh
F000:0CDF  [+0x08CDF]  BA CC 03                 mov     dx,3CCh
F000:0CE2  [+0x08CE2]  EC                       in      al,dx
F000:0CE3  [+0x08CE3]  0C 02                    or      al,2
F000:0CE5  [+0x08CE5]  BA C2 03                 mov     dx,3C2h
F000:0CE8  [+0x08CE8]  EE                       out     dx,al
F000:0CE9  [+0x08CE9]  BA C4 03                 mov     dx,3C4h
F000:0CEC  [+0x08CEC]  B8 01 21                 mov     ax,2101h
F000:0CEF  [+0x08CEF]  EF                       out     dx,ax
F000:0CF0  [+0x08CF0]  B8 04 0E                 mov     ax,0E04h
F000:0CF3  [+0x08CF3]  EF                       out     dx,ax
F000:0CF4  [+0x08CF4]  BA CE 03                 mov     dx,3CEh
F000:0CF7  [+0x08CF7]  B8 05 00                 mov     ax,5
F000:0CFA  [+0x08CFA]  EF                       out     dx,ax
F000:0CFB  [+0x08CFB]  B8 06 05                 mov     ax,506h
F000:0CFE  [+0x08CFE]  EF                       out     dx,ax
F000:0CFF  [+0x08CFF]  BA D6 03                 mov     dx,3D6h
F000:0D02  [+0x08D02]  B8 0B 05                 mov     ax,50Bh
F000:0D05  [+0x08D05]  EF                       out     dx,ax
F000:0D06  [+0x08D06]  BA C4 03                 mov     dx,3C4h
F000:0D09  [+0x08D09]  B8 02 0F                 mov     ax,0F02h
F000:0D0C  [+0x08D0C]  EF                       out     dx,ax
F000:0D0D  [+0x08D0D]  B2 CE                    mov     dl,0CEh
F000:0D0F  [+0x08D0F]  B8 01 00                 mov     ax,1
F000:0D12  [+0x08D12]  EF                       out     dx,ax
F000:0D13  [+0x08D13]  B8 03 00                 mov     ax,3
F000:0D16  [+0x08D16]  EF                       out     dx,ax
F000:0D17  [+0x08D17]  B8 08 FF                 mov     ax,0FF08h
F000:0D1A  [+0x08D1A]  EF                       out     dx,ax
F000:0D1B  [+0x08D1B]  B8 10 00                 mov     ax,10h
F000:0D1E  [+0x08D1E]  BA D6 03                 mov     dx,3D6h
F000:0D21  [+0x08D21]  EF                       out     dx,ax
F000:0D22  [+0x08D22]  BE 00 F0                 mov     si,0F000h
F000:0D25  [+0x08D25]  E8 BC 00                 call    0DE4h
F000:0D28  [+0x08D28]  B8 10 10                 mov     ax,1010h
F000:0D2B  [+0x08D2B]  BA D6 03                 mov     dx,3D6h
F000:0D2E  [+0x08D2E]  EF                       out     dx,ax
F000:0D2F  [+0x08D2F]  BE 00 D0                 mov     si,0D000h
F000:0D32  [+0x08D32]  8E DE                    mov     ds,si
F000:0D34  [+0x08D34]  BF 00 A0                 mov     di,0A000h
F000:0D37  [+0x08D37]  8E C7                    mov     es,di
F000:0D39  [+0x08D39]  E8 BB 00                 call    0DF7h
F000:0D3C  [+0x08D3C]  BE 00 E0                 mov     si,0E000h
F000:0D3F  [+0x08D3F]  8E DE                    mov     ds,si
F000:0D41  [+0x08D41]  BF 00 A8                 mov     di,0A800h
F000:0D44  [+0x08D44]  8E C7                    mov     es,di
F000:0D46  [+0x08D46]  E8 AE 00                 call    0DF7h
F000:0D49  [+0x08D49]  B8 10 20                 mov     ax,2010h
F000:0D4C  [+0x08D4C]  BA D6 03                 mov     dx,3D6h
F000:0D4F  [+0x08D4F]  EF                       out     dx,ax
F000:0D50  [+0x08D50]  BE 00 C0                 mov     si,0C000h
F000:0D53  [+0x08D53]  8E DE                    mov     ds,si
F000:0D55  [+0x08D55]  BF 00 A0                 mov     di,0A000h
F000:0D58  [+0x08D58]  8E C7                    mov     es,di
F000:0D5A  [+0x08D5A]  E8 9A 00                 call    0DF7h
F000:0D5D  [+0x08D5D]  B8 00 02                 mov     ax,200h
F000:0D60  [+0x08D60]  BA 7F 13                 mov     dx,137Fh
F000:0D63  [+0x08D63]  E8 DB 05                 call    1341h
F000:0D66  [+0x08D66]  B8 07 02                 mov     ax,207h
F000:0D69  [+0x08D69]  BA 00 13                 mov     dx,1300h
F000:0D6C  [+0x08D6C]  E8 C9 05                 call    1338h
F000:0D6F  [+0x08D6F]  B8 00 E0                 mov     ax,0E000h
F000:0D72  [+0x08D72]  8E D8                    mov     ds,ax
F000:0D74  [+0x08D74]  8E C0                    mov     es,ax
F000:0D76  [+0x08D76]  E8 7E 00                 call    0DF7h
F000:0D79  [+0x08D79]  B8 00 F0                 mov     ax,0F000h
F000:0D7C  [+0x08D7C]  8E D8                    mov     ds,ax
F000:0D7E  [+0x08D7E]  8E C0                    mov     es,ax
F000:0D80  [+0x08D80]  E8 68 00                 call    0DEBh
F000:0D83  [+0x08D83]  B8 00 DC                 mov     ax,0DC00h
F000:0D86  [+0x08D86]  8E D8                    mov     ds,ax
F000:0D88  [+0x08D88]  BF B1 E6                 mov     di,0E6B1h
F000:0D8B  [+0x08D8B]  BE 48 00                 mov     si,48h
F000:0D8E  [+0x08D8E]  B9 10 00                 mov     cx,10h
F000:0D91  [+0x08D91]  FC                       cld
F000:0D92  [+0x08D92]  F3 66 A5                 rep movsd
F000:0D95  [+0x08D95]  BF EC FF                 mov     di,0FFECh
F000:0D98  [+0x08D98]  BE 88 00                 mov     si,88h
F000:0D9B  [+0x08D9B]  B9 01 00                 mov     cx,1
F000:0D9E  [+0x08D9E]  FC                       cld
F000:0D9F  [+0x08D9F]  F3 66 A5                 rep movsd
F000:0DA2  [+0x08DA2]  B8 00 02                 mov     ax,200h
F000:0DA5  [+0x08DA5]  BA 80 1F                 mov     dx,1F80h
F000:0DA8  [+0x08DA8]  E8 8D 05                 call    1338h
F000:0DAB  [+0x08DAB]  B8 07 02                 mov     ax,207h
F000:0DAE  [+0x08DAE]  BA 7F 1F                 mov     dx,1F7Fh
F000:0DB1  [+0x08DB1]  E8 8D 05                 call    1341h
F000:0DB4  [+0x08DB4]  E8 17 00                 call    0DCEh
F000:0DB7  [+0x08DB7]  58                       pop     ax
F000:0DB8  [+0x08DB8]  E6 A1                    out     0A1h,al
F000:0DBA  [+0x08DBA]  86 C4                    xchg    al,ah
F000:0DBC  [+0x08DBC]  E6 21                    out     21h,al
F000:0DBE  [+0x08DBE]  9D                       popf
F000:0DBF  [+0x08DBF]  07                       pop     es
F000:0DC0  [+0x08DC0]  1F                       pop     ds
F000:0DC1  [+0x08DC1]  61                       popa
F000:0DC2  [+0x08DC2]  C3                       ret
F000:0DC3  [+0x08DC3]  BA DA 03                 mov     dx,3DAh
F000:0DC6  [+0x08DC6]  EC                       in      al,dx
F000:0DC7  [+0x08DC7]  BA C0 03                 mov     dx,3C0h
F000:0DCA  [+0x08DCA]  B0 00                    mov     al,0
F000:0DCC  [+0x08DCC]  EE                       out     dx,al
F000:0DCD  [+0x08DCD]  C3                       ret
F000:0DCE  [+0x08DCE]  BA C0 03                 mov     dx,3C0h
F000:0DD1  [+0x08DD1]  B0 20                    mov     al,20h
F000:0DD3  [+0x08DD3]  EE                       out     dx,al
F000:0DD4  [+0x08DD4]  EB 00                    jmp     short 0DD6h
F000:0DD6  [+0x08DD6]  EB 00                    jmp     short 0DD8h
F000:0DD8  [+0x08DD8]  EE                       out     dx,al
F000:0DD9  [+0x08DD9]  C3                       ret
F000:0DDA  [+0x08DDA]  8E C7                    mov     es,di
F000:0DDC  [+0x08DDC]  BE 00 A0                 mov     si,0A000h
F000:0DDF  [+0x08DDF]  8E DE                    mov     ds,si
F000:0DE1  [+0x08DE1]  EB 08                    jmp     short 0DEBh
F000:0DE3  [+0x08DE3]  90                       nop
F000:0DE4  [+0x08DE4]  8E DE                    mov     ds,si
F000:0DE6  [+0x08DE6]  BF 00 A0                 mov     di,0A000h
F000:0DE9  [+0x08DE9]  8E C7                    mov     es,di
F000:0DEB  [+0x08DEB]  33 F6                    xor     si,si
F000:0DED  [+0x08DED]  33 FF                    xor     di,di
F000:0DEF  [+0x08DEF]  FC                       cld
F000:0DF0  [+0x08DF0]  B9 00 40                 mov     cx,4000h
F000:0DF3  [+0x08DF3]  F3 66 A5                 rep movsd
F000:0DF6  [+0x08DF6]  C3                       ret
F000:0DF7  [+0x08DF7]  33 F6                    xor     si,si
F000:0DF9  [+0x08DF9]  33 FF                    xor     di,di
F000:0DFB  [+0x08DFB]  FC                       cld
F000:0DFC  [+0x08DFC]  B9 00 20                 mov     cx,2000h
F000:0DFF  [+0x08DFF]  F3 66 A5                 rep movsd
F000:0E02  [+0x08E02]  C3                       ret
F000:0E03  [+0x08E03]  F6 06 10 01 08           test    byte [110h],8
F000:0E08  [+0x08E08]  0F 85 50 00              jne     near 0E5Ch
F000:0E0C  [+0x08E0C]  80 0E 10 01 08           or      byte [110h],8
F000:0E11  [+0x08E11]  C6 06 94 04 00           mov     byte [494h],0
F000:0E16  [+0x08E16]  B8 03 00                 mov     ax,3
F000:0E19  [+0x08E19]  BA 03 00                 mov     dx,3
F000:0E1C  [+0x08E1C]  E8 19 05                 call    1338h
F000:0E1F  [+0x08E1F]  E8 DC 1D                 call    2BFEh
F000:0E22  [+0x08E22]  E8 5F 2A                 call    3884h
F000:0E25  [+0x08E25]  B8 02 00                 mov     ax,2
F000:0E28  [+0x08E28]  BA FF 13                 mov     dx,13FFh
F000:0E2B  [+0x08E2B]  E8 13 05                 call    1341h
F000:0E2E  [+0x08E2E]  B8 11 00                 mov     ax,11h
F000:0E31  [+0x08E31]  BB 00 01                 mov     bx,100h
F000:0E34  [+0x08E34]  E8 B3 04                 call    12EAh
F000:0E37  [+0x08E37]  B8 10 00                 mov     ax,10h
F000:0E3A  [+0x08E3A]  BB 00 00                 mov     bx,0
F000:0E3D  [+0x08E3D]  E8 AA 04                 call    12EAh
F000:0E40  [+0x08E40]  B8 06 00                 mov     ax,6
F000:0E43  [+0x08E43]  BB 03 03                 mov     bx,303h
F000:0E46  [+0x08E46]  E8 A1 04                 call    12EAh
F000:0E49  [+0x08E49]  B8 0D 00                 mov     ax,0Dh
F000:0E4C  [+0x08E4C]  BB 00 08                 mov     bx,800h
F000:0E4F  [+0x08E4F]  E8 98 04                 call    12EAh
F000:0E52  [+0x08E52]  B8 01 00                 mov     ax,1
F000:0E55  [+0x08E55]  BA F7 00                 mov     dx,0F7h
F000:0E58  [+0x08E58]  E8 DD 04                 call    1338h
F000:0E5B  [+0x08E5B]  C3                       ret
F000:0E5C  [+0x08E5C]  80 26 10 01 F7           and     byte [110h],0F7h
F000:0E61  [+0x08E61]  C6 06 94 04 00           mov     byte [494h],0
F000:0E66  [+0x08E66]  B8 11 00                 mov     ax,11h
F000:0E69  [+0x08E69]  BB 00 02                 mov     bx,200h
F000:0E6C  [+0x08E6C]  E8 7B 04                 call    12EAh
F000:0E6F  [+0x08E6F]  B8 02 00                 mov     ax,2
F000:0E72  [+0x08E72]  BA FF 13                 mov     dx,13FFh
F000:0E75  [+0x08E75]  E8 C9 04                 call    1341h
F000:0E78  [+0x08E78]  B8 06 00                 mov     ax,6
F000:0E7B  [+0x08E7B]  BB 83 43                 mov     bx,4383h
F000:0E7E  [+0x08E7E]  E8 69 04                 call    12EAh
F000:0E81  [+0x08E81]  B8 03 00                 mov     ax,3
F000:0E84  [+0x08E84]  BB C0 2E                 mov     bx,2EC0h
F000:0E87  [+0x08E87]  E8 60 04                 call    12EAh
F000:0E8A  [+0x08E8A]  E8 08 04                 call    1295h
F000:0E8D  [+0x08E8D]  0F 83 09 00              jae     near 0E9Ah
F000:0E91  [+0x08E91]  B8 03 00                 mov     ax,3
F000:0E94  [+0x08E94]  BA 01 00                 mov     dx,1
F000:0E97  [+0x08E97]  E8 9E 04                 call    1338h
F000:0E9A  [+0x08E9A]  B8 01 00                 mov     ax,1
F000:0E9D  [+0x08E9D]  BA F7 00                 mov     dx,0F7h
F000:0EA0  [+0x08EA0]  E8 95 04                 call    1338h
F000:0EA3  [+0x08EA3]  E8 B5 29                 call    385Bh
F000:0EA6  [+0x08EA6]  E8 9A 0B                 call    1A43h
F000:0EA9  [+0x08EA9]  C3                       ret
F000:0EAA  [+0x08EAA]  60                       pusha
F000:0EAB  [+0x08EAB]  1E                       push    ds
F000:0EAC  [+0x08EAC]  06                       push    es
F000:0EAD  [+0x08EAD]  B8 00 E8                 mov     ax,0E800h
F000:0EB0  [+0x08EB0]  8E D8                    mov     ds,ax
F000:0EB2  [+0x08EB2]  8E C0                    mov     es,ax
F000:0EB4  [+0x08EB4]  BA 24 00                 mov     dx,24h
F000:0EB7  [+0x08EB7]  B8 00 02                 mov     ax,200h
F000:0EBA  [+0x08EBA]  EF                       out     dx,ax
F000:0EBB  [+0x08EBB]  EB 00                    jmp     short 0EBDh
F000:0EBD  [+0x08EBD]  EB 00                    jmp     short 0EBFh
F000:0EBF  [+0x08EBF]  BA 26 00                 mov     dx,26h
F000:0EC2  [+0x08EC2]  ED                       in      ax,dx
F000:0EC3  [+0x08EC3]  0D 0F 00                 or      ax,0Fh
F000:0EC6  [+0x08EC6]  50                       push    ax
F000:0EC7  [+0x08EC7]  BA 24 00                 mov     dx,24h
F000:0ECA  [+0x08ECA]  B8 00 02                 mov     ax,200h
F000:0ECD  [+0x08ECD]  EF                       out     dx,ax
F000:0ECE  [+0x08ECE]  EB 00                    jmp     short 0ED0h
F000:0ED0  [+0x08ED0]  EB 00                    jmp     short 0ED2h
F000:0ED2  [+0x08ED2]  BA 26 00                 mov     dx,26h
F000:0ED5  [+0x08ED5]  58                       pop     ax
F000:0ED6  [+0x08ED6]  EF                       out     dx,ax
F000:0ED7  [+0x08ED7]  EB 00                    jmp     short 0ED9h
F000:0ED9  [+0x08ED9]  BA 24 00                 mov     dx,24h
F000:0EDC  [+0x08EDC]  B8 07 02                 mov     ax,207h
F000:0EDF  [+0x08EDF]  EF                       out     dx,ax
F000:0EE0  [+0x08EE0]  EB 00                    jmp     short 0EE2h
F000:0EE2  [+0x08EE2]  EB 00                    jmp     short 0EE4h
F000:0EE4  [+0x08EE4]  BA 26 00                 mov     dx,26h
F000:0EE7  [+0x08EE7]  ED                       in      ax,dx
F000:0EE8  [+0x08EE8]  0D 0F 00                 or      ax,0Fh
F000:0EEB  [+0x08EEB]  50                       push    ax
F000:0EEC  [+0x08EEC]  BA 24 00                 mov     dx,24h
F000:0EEF  [+0x08EEF]  B8 07 02                 mov     ax,207h
F000:0EF2  [+0x08EF2]  EF                       out     dx,ax
F000:0EF3  [+0x08EF3]  EB 00                    jmp     short 0EF5h
F000:0EF5  [+0x08EF5]  EB 00                    jmp     short 0EF7h
F000:0EF7  [+0x08EF7]  BA 26 00                 mov     dx,26h
F000:0EFA  [+0x08EFA]  58                       pop     ax
F000:0EFB  [+0x08EFB]  EF                       out     dx,ax
F000:0EFC  [+0x08EFC]  EB 00                    jmp     short 0EFEh
F000:0EFE  [+0x08EFE]  BB 00 B8                 mov     bx,0B800h
F000:0F01  [+0x08F01]  8E DB                    mov     ds,bx
F000:0F03  [+0x08F03]  BB 00 C8                 mov     bx,0C800h
F000:0F06  [+0x08F06]  8E C3                    mov     es,bx
F000:0F08  [+0x08F08]  33 FF                    xor     di,di
F000:0F0A  [+0x08F0A]  33 F6                    xor     si,si
F000:0F0C  [+0x08F0C]  B9 90 01                 mov     cx,190h
F000:0F0F  [+0x08F0F]  F3 A5                    rep movsw
F000:0F11  [+0x08F11]  B8 00 E8                 mov     ax,0E800h
F000:0F14  [+0x08F14]  8E D8                    mov     ds,ax
F000:0F16  [+0x08F16]  8E C0                    mov     es,ax
F000:0F18  [+0x08F18]  8D 2E EB 10              lea     bp,[10EBh]
F000:0F1C  [+0x08F1C]  B3 71                    mov     bl,71h
F000:0F1E  [+0x08F1E]  90                       nop
F000:0F1F  [+0x08F1F]  90                       nop
F000:0F20  [+0x08F20]  B9 50 00                 mov     cx,50h
F000:0F23  [+0x08F23]  90                       nop
F000:0F24  [+0x08F24]  BA 00 00                 mov     dx,0
F000:0F27  [+0x08F27]  B8 00 13                 mov     ax,1300h
F000:0F2A  [+0x08F2A]  B7 00                    mov     bh,0
F000:0F2C  [+0x08F2C]  CD 10                    int     10h
F000:0F2E  [+0x08F2E]  8D 2E 3B 11              lea     bp,[113Bh]
F000:0F32  [+0x08F32]  B3 71                    mov     bl,71h
F000:0F34  [+0x08F34]  90                       nop
F000:0F35  [+0x08F35]  90                       nop
F000:0F36  [+0x08F36]  B9 50 00                 mov     cx,50h
F000:0F39  [+0x08F39]  90                       nop
F000:0F3A  [+0x08F3A]  BA 00 01                 mov     dx,100h
F000:0F3D  [+0x08F3D]  B8 00 13                 mov     ax,1300h
F000:0F40  [+0x08F40]  B7 00                    mov     bh,0
F000:0F42  [+0x08F42]  CD 10                    int     10h
F000:0F44  [+0x08F44]  8D 2E 8B 11              lea     bp,[118Bh]
F000:0F48  [+0x08F48]  B3 71                    mov     bl,71h
F000:0F4A  [+0x08F4A]  90                       nop
F000:0F4B  [+0x08F4B]  90                       nop
F000:0F4C  [+0x08F4C]  B9 50 00                 mov     cx,50h
F000:0F4F  [+0x08F4F]  90                       nop
F000:0F50  [+0x08F50]  BA 00 02                 mov     dx,200h
F000:0F53  [+0x08F53]  B8 00 13                 mov     ax,1300h
F000:0F56  [+0x08F56]  B7 00                    mov     bh,0
F000:0F58  [+0x08F58]  CD 10                    int     10h
F000:0F5A  [+0x08F5A]  8D 2E DB 11              lea     bp,[11DBh]
F000:0F5E  [+0x08F5E]  B3 71                    mov     bl,71h
F000:0F60  [+0x08F60]  90                       nop
F000:0F61  [+0x08F61]  90                       nop
F000:0F62  [+0x08F62]  B9 50 00                 mov     cx,50h
F000:0F65  [+0x08F65]  90                       nop
F000:0F66  [+0x08F66]  BA 00 03                 mov     dx,300h
F000:0F69  [+0x08F69]  B8 00 13                 mov     ax,1300h
F000:0F6C  [+0x08F6C]  B7 00                    mov     bh,0
F000:0F6E  [+0x08F6E]  CD 10                    int     10h
F000:0F70  [+0x08F70]  BA FF 01                 mov     dx,1FFh
F000:0F73  [+0x08F73]  EC                       in      al,dx
F000:0F74  [+0x08F74]  EB 00                    jmp     short 0F76h
F000:0F76  [+0x08F76]  EB 00                    jmp     short 0F78h
F000:0F78  [+0x08F78]  8A E0                    mov     ah,al
F000:0F7A  [+0x08F7A]  51                       push    cx
F000:0F7B  [+0x08F7B]  B9 FF FF                 mov     cx,0FFFFh
F000:0F7E  [+0x08F7E]  90                       nop
F000:0F7F  [+0x08F7F]  E2 FD                    loop    0F7Eh
F000:0F81  [+0x08F81]  59                       pop     cx
F000:0F82  [+0x08F82]  EC                       in      al,dx
F000:0F83  [+0x08F83]  EB 00                    jmp     short 0F85h
F000:0F85  [+0x08F85]  EB 00                    jmp     short 0F87h
F000:0F87  [+0x08F87]  3A E0                    cmp     ah,al
F000:0F89  [+0x08F89]  75 ED                    jne     short 0F78h
F000:0F8B  [+0x08F8B]  D0 E8                    shr     al,1
F000:0F8D  [+0x08F8D]  24 1F                    and     al,1Fh
F000:0F8F  [+0x08F8F]  32 E4                    xor     ah,ah
F000:0F91  [+0x08F91]  8B C8                    mov     cx,ax
F000:0F93  [+0x08F93]  83 F9 1F                 cmp     cx,1Fh
F000:0F96  [+0x08F96]  0F 87 B7 00              ja      near 1051h
F000:0F9A  [+0x08F9A]  83 F9 18                 cmp     cx,18h
F000:0F9D  [+0x08F9D]  0F 87 2D 00              ja      near 0FCEh
F000:0FA1  [+0x08FA1]  83 F9 10                 cmp     cx,10h
F000:0FA4  [+0x08FA4]  0F 87 1F 00              ja      near 0FC7h
F000:0FA8  [+0x08FA8]  83 F9 08                 cmp     cx,8
F000:0FAB  [+0x08FAB]  0F 87 11 00              ja      near 0FC0h
F000:0FAF  [+0x08FAF]  83 F9 00                 cmp     cx,0
F000:0FB2  [+0x08FB2]  0F 87 03 00              ja      near 0FB9h
F000:0FB6  [+0x08FB6]  B9 01 00                 mov     cx,1
F000:0FB9  [+0x08FB9]  B3 40                    mov     bl,40h
F000:0FBB  [+0x08FBB]  90                       nop
F000:0FBC  [+0x08FBC]  90                       nop
F000:0FBD  [+0x08FBD]  EB 13                    jmp     short 0FD2h
F000:0FBF  [+0x08FBF]  90                       nop
F000:0FC0  [+0x08FC0]  B3 50                    mov     bl,50h
F000:0FC2  [+0x08FC2]  90                       nop
F000:0FC3  [+0x08FC3]  90                       nop
F000:0FC4  [+0x08FC4]  EB 0C                    jmp     short 0FD2h
F000:0FC6  [+0x08FC6]  90                       nop
F000:0FC7  [+0x08FC7]  B3 30                    mov     bl,30h
F000:0FC9  [+0x08FC9]  90                       nop
F000:0FCA  [+0x08FCA]  90                       nop
F000:0FCB  [+0x08FCB]  EB 05                    jmp     short 0FD2h
F000:0FCD  [+0x08FCD]  90                       nop
F000:0FCE  [+0x08FCE]  B3 20                    mov     bl,20h
F000:0FD0  [+0x08FD0]  90                       nop
F000:0FD1  [+0x08FD1]  90                       nop
F000:0FD2  [+0x08FD2]  60                       pusha
F000:0FD3  [+0x08FD3]  1E                       push    ds
F000:0FD4  [+0x08FD4]  06                       push    es
F000:0FD5  [+0x08FD5]  8D 2E 3B 11              lea     bp,[113Bh]
F000:0FD9  [+0x08FD9]  B3 71                    mov     bl,71h
F000:0FDB  [+0x08FDB]  90                       nop
F000:0FDC  [+0x08FDC]  90                       nop
F000:0FDD  [+0x08FDD]  B9 50 00                 mov     cx,50h
F000:0FE0  [+0x08FE0]  90                       nop
F000:0FE1  [+0x08FE1]  BA 00 01                 mov     dx,100h
F000:0FE4  [+0x08FE4]  B8 00 13                 mov     ax,1300h
F000:0FE7  [+0x08FE7]  B7 00                    mov     bh,0
F000:0FE9  [+0x08FE9]  CD 10                    int     10h
F000:0FEB  [+0x08FEB]  B8 12 00                 mov     ax,12h
F000:0FEE  [+0x08FEE]  E8 F2 02                 call    12E3h
F000:0FF1  [+0x08FF1]  8B C3                    mov     ax,bx
F000:0FF3  [+0x08FF3]  A8 01                    test    al,1
F000:0FF5  [+0x08FF5]  0F 85 1C 00              jne     near 1015h
F000:0FF9  [+0x08FF9]  B8 01 00                 mov     ax,1
F000:0FFC  [+0x08FFC]  E8 E4 02                 call    12E3h
F000:0FFF  [+0x08FFF]  F7 C3 08 00              test    bx,8
F000:1003  [+0x09003]  0F 85 07 00              jne     near 100Eh
F000:1007  [+0x09007]  8D 2E 65 12              lea     bp,[1265h]
F000:100B  [+0x0900B]  EB 0C                    jmp     short 1019h
F000:100D  [+0x0900D]  90                       nop
F000:100E  [+0x0900E]  8D 2E 7D 12              lea     bp,[127Dh]
F000:1012  [+0x09012]  EB 05                    jmp     short 1019h
F000:1014  [+0x09014]  90                       nop
F000:1015  [+0x09015]  8D 2E 4D 12              lea     bp,[124Dh]
F000:1019  [+0x09019]  B3 71                    mov     bl,71h
F000:101B  [+0x0901B]  90                       nop
F000:101C  [+0x0901C]  90                       nop
F000:101D  [+0x0901D]  B9 18 00                 mov     cx,18h
F000:1020  [+0x09020]  90                       nop
F000:1021  [+0x09021]  BA 37 01                 mov     dx,137h
F000:1024  [+0x09024]  90                       nop
F000:1025  [+0x09025]  B8 00 13                 mov     ax,1300h
F000:1028  [+0x09028]  B7 00                    mov     bh,0
F000:102A  [+0x0902A]  CD 10                    int     10h
F000:102C  [+0x0902C]  07                       pop     es
F000:102D  [+0x0902D]  1F                       pop     ds
F000:102E  [+0x0902E]  61                       popa
F000:102F  [+0x0902F]  53                       push    bx
F000:1030  [+0x09030]  B8 12 00                 mov     ax,12h
F000:1033  [+0x09033]  E8 AD 02                 call    12E3h
F000:1036  [+0x09036]  8B C3                    mov     ax,bx
F000:1038  [+0x09038]  A8 01                    test    al,1
F000:103A  [+0x0903A]  5B                       pop     bx
F000:103B  [+0x0903B]  0F 85 12 00              jne     near 1051h
F000:103F  [+0x0903F]  8D 2E 2B 12              lea     bp,[122Bh]
F000:1043  [+0x09043]  BA 14 01                 mov     dx,114h
F000:1046  [+0x09046]  90                       nop
F000:1047  [+0x09047]  B8 00 13                 mov     ax,1300h
F000:104A  [+0x0904A]  B7 00                    mov     bh,0
F000:104C  [+0x0904C]  CD 10                    int     10h
F000:104E  [+0x0904E]  42                       inc     dx
F000:104F  [+0x0904F]  E2 F6                    loop    1047h
F000:1051  [+0x09051]  B9 E8 03                 mov     cx,3E8h
F000:1054  [+0x09054]  51                       push    cx
F000:1055  [+0x09055]  B9 FF FF                 mov     cx,0FFFFh
F000:1058  [+0x09058]  E8 E6 0F                 call    2041h
F000:105B  [+0x0905B]  59                       pop     cx
F000:105C  [+0x0905C]  E2 F6                    loop    1054h
F000:105E  [+0x0905E]  33 C9                    xor     cx,cx
F000:1060  [+0x09060]  B8 00 01                 mov     ax,100h
F000:1063  [+0x09063]  CD 16                    int     16h
F000:1065  [+0x09065]  0F 84 07 FF              je      near 0F70h
F000:1069  [+0x09069]  32 E4                    xor     ah,ah
F000:106B  [+0x0906B]  CD 16                    int     16h
F000:106D  [+0x0906D]  53                       push    bx
F000:106E  [+0x0906E]  1E                       push    ds
F000:106F  [+0x0906F]  BB 00 00                 mov     bx,0
F000:1072  [+0x09072]  8E DB                    mov     ds,bx
F000:1074  [+0x09074]  8B 1E 1A 04              mov     bx,[41Ah]
F000:1078  [+0x09078]  89 1E 1C 04              mov     [41Ch],bx
F000:107C  [+0x0907C]  8B 1E 17 04              mov     bx,[417h]
F000:1080  [+0x09080]  81 E3 F3 F3              and     bx,0F3F3h
F000:1084  [+0x09084]  89 1E 17 04              mov     [417h],bx
F000:1088  [+0x09088]  1F                       pop     ds
F000:1089  [+0x09089]  5B                       pop     bx
F000:108A  [+0x0908A]  BB 00 B8                 mov     bx,0B800h
F000:108D  [+0x0908D]  8E C3                    mov     es,bx
F000:108F  [+0x0908F]  BB 00 C8                 mov     bx,0C800h
F000:1092  [+0x09092]  8E DB                    mov     ds,bx
F000:1094  [+0x09094]  33 FF                    xor     di,di
F000:1096  [+0x09096]  33 F6                    xor     si,si
F000:1098  [+0x09098]  B9 90 01                 mov     cx,190h
F000:109B  [+0x0909B]  F3 A5                    rep movsw
F000:109D  [+0x0909D]  BA 24 00                 mov     dx,24h
F000:10A0  [+0x090A0]  B8 00 02                 mov     ax,200h
F000:10A3  [+0x090A3]  EF                       out     dx,ax
F000:10A4  [+0x090A4]  EB 00                    jmp     short 10A6h
F000:10A6  [+0x090A6]  EB 00                    jmp     short 10A8h
F000:10A8  [+0x090A8]  BA 26 00                 mov     dx,26h
F000:10AB  [+0x090AB]  ED                       in      ax,dx
F000:10AC  [+0x090AC]  25 F0 FF                 and     ax,0FFF0h
F000:10AF  [+0x090AF]  50                       push    ax
F000:10B0  [+0x090B0]  BA 24 00                 mov     dx,24h
F000:10B3  [+0x090B3]  B8 00 02                 mov     ax,200h
F000:10B6  [+0x090B6]  EF                       out     dx,ax
F000:10B7  [+0x090B7]  EB 00                    jmp     short 10B9h
F000:10B9  [+0x090B9]  EB 00                    jmp     short 10BBh
F000:10BB  [+0x090BB]  BA 26 00                 mov     dx,26h
F000:10BE  [+0x090BE]  58                       pop     ax
F000:10BF  [+0x090BF]  EF                       out     dx,ax
F000:10C0  [+0x090C0]  EB 00                    jmp     short 10C2h
F000:10C2  [+0x090C2]  BA 24 00                 mov     dx,24h
F000:10C5  [+0x090C5]  B8 07 02                 mov     ax,207h
F000:10C8  [+0x090C8]  EF                       out     dx,ax
F000:10C9  [+0x090C9]  EB 00                    jmp     short 10CBh
F000:10CB  [+0x090CB]  EB 00                    jmp     short 10CDh
F000:10CD  [+0x090CD]  BA 26 00                 mov     dx,26h
F000:10D0  [+0x090D0]  ED                       in      ax,dx
F000:10D1  [+0x090D1]  25 F0 FF                 and     ax,0FFF0h
F000:10D4  [+0x090D4]  50                       push    ax
F000:10D5  [+0x090D5]  BA 24 00                 mov     dx,24h
F000:10D8  [+0x090D8]  B8 07 02                 mov     ax,207h
F000:10DB  [+0x090DB]  EF                       out     dx,ax
F000:10DC  [+0x090DC]  EB 00                    jmp     short 10DEh
F000:10DE  [+0x090DE]  EB 00                    jmp     short 10E0h
F000:10E0  [+0x090E0]  BA 26 00                 mov     dx,26h
F000:10E3  [+0x090E3]  58                       pop     ax
F000:10E4  [+0x090E4]  EF                       out     dx,ax
F000:10E5  [+0x090E5]  EB 00                    jmp     short 10E7h
F000:10E7  [+0x090E7]  07                       pop     es
F000:10E8  [+0x090E8]  1F                       pop     ds
F000:10E9  [+0x090E9]  61                       popa
F000:10EA  [+0x090EA]  C3                       ret
F000:10EB  [+0x090EB]  20 50 4F                 and     [bx+si+4Fh],dl
F000:10EE  [+0x090EE]  57                       push    di
F000:10EF  [+0x090EF]  45                       inc     bp
F000:10F0  [+0x090F0]  52                       push    dx
F000:10F1  [+0x090F1]  20 20                    and     [bx+si],ah
F000:10F3  [+0x090F3]  20 20                    and     [bx+si],ah
F000:10F5  [+0x090F5]  20 20                    and     [bx+si],ah
F000:10F7  [+0x090F7]  20 20                    and     [bx+si],ah
F000:10F9  [+0x090F9]  20 20                    and     [bx+si],ah
F000:10FB  [+0x090FB]  20 20                    and     [bx+si],ah
F000:10FD  [+0x090FD]  20 DA                    and     dl,bl
F000:10FF  [+0x090FF]  DB 0xC4  (bad)
F000:1103  [+0x09103]  DB 0xC4  (bad)
F000:1107  [+0x09107]  DB 0xC4  (bad)
F000:110B  [+0x0910B]  DB 0xC4  (bad)
F000:110F  [+0x0910F]  DB 0xC4  (bad)
F000:1113  [+0x09113]  DB 0xC4  (bad)
F000:1117  [+0x09117]  DB 0xC4  (bad)
F000:111B  [+0x0911B]  DB 0xC4  (bad)
F000:111F  [+0x0911F]  20 20                    and     [bx+si],ah
F000:1121  [+0x09121]  20 20                    and     [bx+si],ah
F000:1123  [+0x09123]  20 20                    and     [bx+si],ah
F000:1125  [+0x09125]  20 20                    and     [bx+si],ah
F000:1127  [+0x09127]  20 20                    and     [bx+si],ah
F000:1129  [+0x09129]  20 20                    and     [bx+si],ah
F000:112B  [+0x0912B]  20 20                    and     [bx+si],ah
F000:112D  [+0x0912D]  20 20                    and     [bx+si],ah
F000:112F  [+0x0912F]  20 20                    and     [bx+si],ah
F000:1131  [+0x09131]  20 20                    and     [bx+si],ah
F000:1133  [+0x09133]  20 20                    and     [bx+si],ah
F000:1135  [+0x09135]  20 20                    and     [bx+si],ah
F000:1137  [+0x09137]  20 20                    and     [bx+si],ah
F000:1139  [+0x09139]  20 20                    and     [bx+si],ah
F000:113B  [+0x0913B]  20 4D 45                 and     [di+45h],cl
F000:113E  [+0x0913E]  54                       push    sp
F000:113F  [+0x0913F]  45                       inc     bp
F000:1140  [+0x09140]  52                       push    dx
F000:1141  [+0x09141]  20 20                    and     [bx+si],ah
F000:1143  [+0x09143]  20 20                    and     [bx+si],ah
F000:1145  [+0x09145]  20 42 61                 and     [bp+si+61h],al
F000:1148  [+0x09148]  74 74                    je      short 11BEh
F000:114A  [+0x0914A]  65 72 79                 jb      short 11C6h
F000:114D  [+0x0914D]  20 B3 20 20              and     [bp+di+2020h],dh
F000:1151  [+0x09151]  20 20                    and     [bx+si],ah
F000:1153  [+0x09153]  20 20                    and     [bx+si],ah
F000:1155  [+0x09155]  20 20                    and     [bx+si],ah
F000:1157  [+0x09157]  20 20                    and     [bx+si],ah
F000:1159  [+0x09159]  20 20                    and     [bx+si],ah
F000:115B  [+0x0915B]  20 20                    and     [bx+si],ah
F000:115D  [+0x0915D]  20 20                    and     [bx+si],ah
F000:115F  [+0x0915F]  20 20                    and     [bx+si],ah
F000:1161  [+0x09161]  20 20                    and     [bx+si],ah
F000:1163  [+0x09163]  20 20                    and     [bx+si],ah
F000:1165  [+0x09165]  20 20                    and     [bx+si],ah
F000:1167  [+0x09167]  20 20                    and     [bx+si],ah
F000:1169  [+0x09169]  20 20                    and     [bx+si],ah
F000:116B  [+0x0916B]  20 20                    and     [bx+si],ah
F000:116D  [+0x0916D]  20 B3 20 20              and     [bp+di+2020h],dh
F000:1171  [+0x09171]  20 20                    and     [bx+si],ah
F000:1173  [+0x09173]  20 20                    and     [bx+si],ah
F000:1175  [+0x09175]  20 20                    and     [bx+si],ah
F000:1177  [+0x09177]  20 20                    and     [bx+si],ah
F000:1179  [+0x09179]  20 20                    and     [bx+si],ah
F000:117B  [+0x0917B]  20 20                    and     [bx+si],ah
F000:117D  [+0x0917D]  20 20                    and     [bx+si],ah
F000:117F  [+0x0917F]  20 20                    and     [bx+si],ah
F000:1181  [+0x09181]  20 20                    and     [bx+si],ah
F000:1183  [+0x09183]  20 20                    and     [bx+si],ah
F000:1185  [+0x09185]  20 20                    and     [bx+si],ah
F000:1187  [+0x09187]  20 20                    and     [bx+si],ah
F000:1189  [+0x09189]  20 20                    and     [bx+si],ah
F000:118B  [+0x0918B]  20 20                    and     [bx+si],ah
F000:118D  [+0x0918D]  20 20                    and     [bx+si],ah
F000:118F  [+0x0918F]  20 20                    and     [bx+si],ah
F000:1191  [+0x09191]  20 20                    and     [bx+si],ah
F000:1193  [+0x09193]  20 20                    and     [bx+si],ah
F000:1195  [+0x09195]  20 20                    and     [bx+si],ah
F000:1197  [+0x09197]  20 20                    and     [bx+si],ah
F000:1199  [+0x09199]  20 20                    and     [bx+si],ah
F000:119B  [+0x0919B]  20 20                    and     [bx+si],ah
F000:119D  [+0x0919D]  20 C0                    and     al,al
F000:119F  [+0x0919F]  DB 0xC4  (bad)
F000:11A4  [+0x091A4]  C1 C4 C1                 rol     sp,0C1h
F000:11A7  [+0x091A7]  DB 0xC4  (bad)
F000:11AC  [+0x091AC]  C1 C4 C1                 rol     sp,0C1h
F000:11AF  [+0x091AF]  DB 0xC4  (bad)
F000:11B4  [+0x091B4]  C1 C4 C1                 rol     sp,0C1h
F000:11B7  [+0x091B7]  DB 0xC4  (bad)
F000:11BC  [+0x091BC]  C1 C4 D9                 rol     sp,0D9h
F000:11BF  [+0x091BF]  20 20                    and     [bx+si],ah
F000:11C1  [+0x091C1]  20 20                    and     [bx+si],ah
F000:11C3  [+0x091C3]  20 20                    and     [bx+si],ah
F000:11C5  [+0x091C5]  20 20                    and     [bx+si],ah
F000:11C7  [+0x091C7]  20 20                    and     [bx+si],ah
F000:11C9  [+0x091C9]  20 20                    and     [bx+si],ah
F000:11CB  [+0x091CB]  20 20                    and     [bx+si],ah
F000:11CD  [+0x091CD]  20 20                    and     [bx+si],ah
F000:11CF  [+0x091CF]  20 20                    and     [bx+si],ah
F000:11D1  [+0x091D1]  20 20                    and     [bx+si],ah
F000:11D3  [+0x091D3]  20 20                    and     [bx+si],ah
F000:11D5  [+0x091D5]  20 20                    and     [bx+si],ah
F000:11D7  [+0x091D7]  20 20                    and     [bx+si],ah
F000:11D9  [+0x091D9]  20 20                    and     [bx+si],ah
F000:11DB  [+0x091DB]  20 20                    and     [bx+si],ah
F000:11DD  [+0x091DD]  20 20                    and     [bx+si],ah
F000:11DF  [+0x091DF]  20 20                    and     [bx+si],ah
F000:11E1  [+0x091E1]  20 20                    and     [bx+si],ah
F000:11E3  [+0x091E3]  20 20                    and     [bx+si],ah
F000:11E5  [+0x091E5]  20 20                    and     [bx+si],ah
F000:11E7  [+0x091E7]  20 20                    and     [bx+si],ah
F000:11E9  [+0x091E9]  20 20                    and     [bx+si],ah
F000:11EB  [+0x091EB]  20 20                    and     [bx+si],ah
F000:11ED  [+0x091ED]  20 45 6D                 and     [di+6Dh],al
F000:11F0  [+0x091F0]  70 74                    jo      short 1266h
F000:11F2  [+0x091F2]  79 20                    jns     short 1214h
F000:11F4  [+0x091F4]  20 20                    and     [bx+si],ah
F000:11F6  [+0x091F6]  20 20                    and     [bx+si],ah
F000:11F8  [+0x091F8]  20 20                    and     [bx+si],ah
F000:11FA  [+0x091FA]  20 20                    and     [bx+si],ah
F000:11FC  [+0x091FC]  20 20                    and     [bx+si],ah
F000:11FE  [+0x091FE]  20 20                    and     [bx+si],ah
F000:1200  [+0x09200]  20 20                    and     [bx+si],ah
F000:1202  [+0x09202]  20 20                    and     [bx+si],ah
F000:1204  [+0x09204]  20 20                    and     [bx+si],ah
F000:1206  [+0x09206]  20 20                    and     [bx+si],ah
F000:1208  [+0x09208]  20 20                    and     [bx+si],ah
F000:120A  [+0x0920A]  20 46 75                 and     [bp+75h],al
F000:120D  [+0x0920D]  6C                       insb
F000:120E  [+0x0920E]  6C                       insb
F000:120F  [+0x0920F]  20 20                    and     [bx+si],ah
F000:1211  [+0x09211]  20 20                    and     [bx+si],ah
F000:1213  [+0x09213]  20 20                    and     [bx+si],ah
F000:1215  [+0x09215]  20 20                    and     [bx+si],ah
F000:1217  [+0x09217]  20 20                    and     [bx+si],ah
F000:1219  [+0x09219]  20 20                    and     [bx+si],ah
F000:121B  [+0x0921B]  20 20                    and     [bx+si],ah
F000:121D  [+0x0921D]  20 20                    and     [bx+si],ah
F000:121F  [+0x0921F]  20 20                    and     [bx+si],ah
F000:1221  [+0x09221]  20 20                    and     [bx+si],ah
F000:1223  [+0x09223]  20 20                    and     [bx+si],ah
F000:1225  [+0x09225]  20 20                    and     [bx+si],ah
F000:1227  [+0x09227]  20 20                    and     [bx+si],ah
F000:1229  [+0x09229]  20 20                    and     [bx+si],ah
F000:122B  [+0x0922B]  B1 B1                    mov     cl,0B1h
F000:122D  [+0x0922D]  B1 B1                    mov     cl,0B1h
F000:122F  [+0x0922F]  B1 B1                    mov     cl,0B1h
F000:1231  [+0x09231]  B1 B1                    mov     cl,0B1h
F000:1233  [+0x09233]  B1 B1                    mov     cl,0B1h
F000:1235  [+0x09235]  B1 B1                    mov     cl,0B1h
F000:1237  [+0x09237]  B1 B1                    mov     cl,0B1h
F000:1239  [+0x09239]  B1 B1                    mov     cl,0B1h
F000:123B  [+0x0923B]  B1 B1                    mov     cl,0B1h
F000:123D  [+0x0923D]  B1 B1                    mov     cl,0B1h
F000:123F  [+0x0923F]  B1 B1                    mov     cl,0B1h
F000:1241  [+0x09241]  B1 B1                    mov     cl,0B1h
F000:1243  [+0x09243]  B1 B1                    mov     cl,0B1h
F000:1245  [+0x09245]  B1 B1                    mov     cl,0B1h
F000:1247  [+0x09247]  B1 B1                    mov     cl,0B1h
F000:1249  [+0x09249]  B1 B1                    mov     cl,0B1h
F000:124B  [+0x0924B]  B1 B1                    mov     cl,0B1h
F000:124D  [+0x0924D]  42                       inc     dx
F000:124E  [+0x0924E]  61                       popa
F000:124F  [+0x0924F]  74 74                    je      short 12C5h
F000:1251  [+0x09251]  65 72 79                 jb      short 12CDh
F000:1254  [+0x09254]  20 6E 6F                 and     [bp+6Fh],ch
F000:1257  [+0x09257]  74 20                    je      short 1279h
F000:1259  [+0x09259]  69 6E 73 74 61           imul    bp,[bp+73h],6174h
F000:125E  [+0x0925E]  6C                       insb
F000:125F  [+0x0925F]  6C                       insb
F000:1260  [+0x09260]  65 64 20 20              and     [fs:bx+si],ah
F000:1264  [+0x09264]  20 52 75                 and     [bp+si+75h],dl
F000:1267  [+0x09267]  6E                       outsb
F000:1268  [+0x09268]  6E                       outsb
F000:1269  [+0x09269]  69 6E 67 20 6F           imul    bp,[bp+67h],6F20h
F000:126E  [+0x0926E]  6E                       outsb
F000:126F  [+0x0926F]  20 62 61                 and     [bp+si+61h],ah
F000:1272  [+0x09272]  74 74                    je      short 12E8h
F000:1274  [+0x09274]  65 72 79                 jb      short 12F0h
F000:1277  [+0x09277]  20 70 6F                 and     [bx+si+6Fh],dh
F000:127A  [+0x0927A]  77 65                    ja      short 12E1h
F000:127C  [+0x0927C]  72 52                    jb      short 12D0h
F000:127E  [+0x0927E]  75 6E                    jne     short 12EEh
F000:1280  [+0x09280]  6E                       outsb
F000:1281  [+0x09281]  69 6E 67 20 6F           imul    bp,[bp+67h],6F20h
F000:1286  [+0x09286]  6E                       outsb
F000:1287  [+0x09287]  20 41 43                 and     [bx+di+43h],al
F000:128A  [+0x0928A]  20 70 6F                 and     [bx+si+6Fh],dh
F000:128D  [+0x0928D]  77 65                    ja      short 12F4h
F000:128F  [+0x0928F]  72 20                    jb      short 12B1h
F000:1291  [+0x09291]  20 20                    and     [bx+si],ah
F000:1293  [+0x09293]  20 20                    and     [bx+si],ah
F000:1295  [+0x09295]  F8                       clc
F000:1296  [+0x09296]  C3                       ret
F000:1297  [+0x09297]  52                       push    dx
F000:1298  [+0x09298]  51                       push    cx
F000:1299  [+0x09299]  50                       push    ax
F000:129A  [+0x0929A]  F8                       clc
F000:129B  [+0x0929B]  B9 FF 00                 mov     cx,0FFh
F000:129E  [+0x0929E]  BA 2C 02                 mov     dx,22Ch
F000:12A1  [+0x092A1]  EC                       in      al,dx
F000:12A2  [+0x092A2]  EB 00                    jmp     short 12A4h
F000:12A4  [+0x092A4]  EB 00                    jmp     short 12A6h
F000:12A6  [+0x092A6]  EB 00                    jmp     short 12A8h
F000:12A8  [+0x092A8]  A8 80                    test    al,80h
F000:12AA  [+0x092AA]  E0 F2                    loopne  129Eh
F000:12AC  [+0x092AC]  E3 31                    jcxz    12DFh
F000:12AE  [+0x092AE]  B0 E7                    mov     al,0E7h
F000:12B0  [+0x092B0]  EE                       out     dx,al
F000:12B1  [+0x092B1]  EB 00                    jmp     short 12B3h
F000:12B3  [+0x092B3]  EB 00                    jmp     short 12B5h
F000:12B5  [+0x092B5]  EB 00                    jmp     short 12B7h
F000:12B7  [+0x092B7]  B9 FF 00                 mov     cx,0FFh
F000:12BA  [+0x092BA]  BA 2E 02                 mov     dx,22Eh
F000:12BD  [+0x092BD]  EC                       in      al,dx
F000:12BE  [+0x092BE]  EB 00                    jmp     short 12C0h
F000:12C0  [+0x092C0]  EB 00                    jmp     short 12C2h
F000:12C2  [+0x092C2]  EB 00                    jmp     short 12C4h
F000:12C4  [+0x092C4]  A8 80                    test    al,80h
F000:12C6  [+0x092C6]  E1 F2                    loope   12BAh
F000:12C8  [+0x092C8]  BA 2A 02                 mov     dx,22Ah
F000:12CB  [+0x092CB]  EC                       in      al,dx
F000:12CC  [+0x092CC]  EB 00                    jmp     short 12CEh
F000:12CE  [+0x092CE]  EB 00                    jmp     short 12D0h
F000:12D0  [+0x092D0]  EB 00                    jmp     short 12D2h
F000:12D2  [+0x092D2]  F8                       clc
F000:12D3  [+0x092D3]  3C 48                    cmp     al,48h
F000:12D5  [+0x092D5]  0F 84 01 00              je      near 12DAh
F000:12D9  [+0x092D9]  F9                       stc
F000:12DA  [+0x092DA]  EC                       in      al,dx
F000:12DB  [+0x092DB]  EB 00                    jmp     short 12DDh
F000:12DD  [+0x092DD]  EB 00                    jmp     short 12DFh
F000:12DF  [+0x092DF]  58                       pop     ax
F000:12E0  [+0x092E0]  59                       pop     cx
F000:12E1  [+0x092E1]  5A                       pop     dx
F000:12E2  [+0x092E2]  C3                       ret
F000:12E3  [+0x092E3]  E7 24                    out     24h,ax
F000:12E5  [+0x092E5]  93                       xchg    bx,ax
F000:12E6  [+0x092E6]  E5 26                    in      ax,26h
F000:12E8  [+0x092E8]  93                       xchg    bx,ax
F000:12E9  [+0x092E9]  C3                       ret
F000:12EA  [+0x092EA]  E7 24                    out     24h,ax
F000:12EC  [+0x092EC]  93                       xchg    bx,ax
F000:12ED  [+0x092ED]  E7 26                    out     26h,ax
F000:12EF  [+0x092EF]  93                       xchg    bx,ax
F000:12F0  [+0x092F0]  C3                       ret
F000:12F1  [+0x092F1]  52                       push    dx
F000:12F2  [+0x092F2]  E8 EE FF                 call    12E3h
F000:12F5  [+0x092F5]  23 DA                    and     bx,dx
F000:12F7  [+0x092F7]  74 0C                    je      short 1305h
F000:12F9  [+0x092F9]  F7 C2 01 00              test    dx,1
F000:12FD  [+0x092FD]  75 06                    jne     short 1305h
F000:12FF  [+0x092FF]  D1 EB                    shr     bx,1
F000:1301  [+0x09301]  D1 EA                    shr     dx,1
F000:1303  [+0x09303]  EB F4                    jmp     short 12F9h
F000:1305  [+0x09305]  0B DB                    or      bx,bx
F000:1307  [+0x09307]  5A                       pop     dx
F000:1308  [+0x09308]  C3                       ret
F000:1309  [+0x09309]  53                       push    bx
F000:130A  [+0x0930A]  52                       push    dx
F000:130B  [+0x0930B]  0B D2                    or      dx,dx
F000:130D  [+0x0930D]  74 0C                    je      short 131Bh
F000:130F  [+0x0930F]  F7 C2 01 00              test    dx,1
F000:1313  [+0x09313]  75 06                    jne     short 131Bh
F000:1315  [+0x09315]  D1 E3                    shl     bx,1
F000:1317  [+0x09317]  D1 EA                    shr     dx,1
F000:1319  [+0x09319]  EB F4                    jmp     short 130Fh
F000:131B  [+0x0931B]  5A                       pop     dx
F000:131C  [+0x0931C]  E8 02 00                 call    1321h
F000:131F  [+0x0931F]  5B                       pop     bx
F000:1320  [+0x09320]  C3                       ret
F000:1321  [+0x09321]  53                       push    bx
F000:1322  [+0x09322]  51                       push    cx
F000:1323  [+0x09323]  8B CB                    mov     cx,bx
F000:1325  [+0x09325]  E8 BB FF                 call    12E3h
F000:1328  [+0x09328]  F7 D2                    not     dx
F000:132A  [+0x0932A]  23 DA                    and     bx,dx
F000:132C  [+0x0932C]  F7 D2                    not     dx
F000:132E  [+0x0932E]  23 CA                    and     cx,dx
F000:1330  [+0x09330]  0B D9                    or      bx,cx
F000:1332  [+0x09332]  E8 B5 FF                 call    12EAh
F000:1335  [+0x09335]  59                       pop     cx
F000:1336  [+0x09336]  5B                       pop     bx
F000:1337  [+0x09337]  C3                       ret
F000:1338  [+0x09338]  53                       push    bx
F000:1339  [+0x09339]  BB FF FF                 mov     bx,0FFFFh
F000:133C  [+0x0933C]  E8 CA FF                 call    1309h
F000:133F  [+0x0933F]  5B                       pop     bx
F000:1340  [+0x09340]  C3                       ret
F000:1341  [+0x09341]  53                       push    bx
F000:1342  [+0x09342]  BB 00 00                 mov     bx,0
F000:1345  [+0x09345]  E8 C1 FF                 call    1309h
F000:1348  [+0x09348]  5B                       pop     bx
F000:1349  [+0x09349]  C3                       ret
F000:134A  [+0x0934A]  50                       push    ax
F000:134B  [+0x0934B]  52                       push    dx
F000:134C  [+0x0934C]  BA 80 00                 mov     dx,80h
F000:134F  [+0x0934F]  B8 00 02                 mov     ax,200h
F000:1352  [+0x09352]  E8 E3 FF                 call    1338h
F000:1355  [+0x09355]  B8 07 02                 mov     ax,207h
F000:1358  [+0x09358]  E8 DD FF                 call    1338h
F000:135B  [+0x0935B]  5A                       pop     dx
F000:135C  [+0x0935C]  58                       pop     ax
F000:135D  [+0x0935D]  C3                       ret
F000:135E  [+0x0935E]  50                       push    ax
F000:135F  [+0x0935F]  52                       push    dx
F000:1360  [+0x09360]  BA 80 00                 mov     dx,80h
F000:1363  [+0x09363]  B8 07 02                 mov     ax,207h
F000:1366  [+0x09366]  E8 D8 FF                 call    1341h
F000:1369  [+0x09369]  5A                       pop     dx
F000:136A  [+0x0936A]  58                       pop     ax
F000:136B  [+0x0936B]  C3                       ret
F000:136C  [+0x0936C]  50                       push    ax
F000:136D  [+0x0936D]  52                       push    dx
F000:136E  [+0x0936E]  B8 03 01                 mov     ax,103h
F000:1371  [+0x09371]  BA 01 00                 mov     dx,1
F000:1374  [+0x09374]  E8 C1 FF                 call    1338h
F000:1377  [+0x09377]  5A                       pop     dx
F000:1378  [+0x09378]  58                       pop     ax
F000:1379  [+0x09379]  C3                       ret
F000:137A  [+0x0937A]  50                       push    ax
F000:137B  [+0x0937B]  52                       push    dx
F000:137C  [+0x0937C]  B8 03 01                 mov     ax,103h
F000:137F  [+0x0937F]  BA 01 00                 mov     dx,1
F000:1382  [+0x09382]  E8 BC FF                 call    1341h
F000:1385  [+0x09385]  5A                       pop     dx
F000:1386  [+0x09386]  58                       pop     ax
F000:1387  [+0x09387]  C3                       ret
F000:1388  [+0x09388]  C3                       ret
F000:1389  [+0x09389]  60                       pusha
F000:138A  [+0x0938A]  B8 10 00                 mov     ax,10h
F000:138D  [+0x0938D]  E8 53 FF                 call    12E3h
F000:1390  [+0x09390]  8B CB                    mov     cx,bx
F000:1392  [+0x09392]  E8 4E FF                 call    12E3h
F000:1395  [+0x09395]  3B CB                    cmp     cx,bx
F000:1397  [+0x09397]  74 F9                    je      short 1392h
F000:1399  [+0x09399]  8B CB                    mov     cx,bx
F000:139B  [+0x0939B]  E8 45 FF                 call    12E3h
F000:139E  [+0x0939E]  3B CB                    cmp     cx,bx
F000:13A0  [+0x093A0]  74 F9                    je      short 139Bh
F000:13A2  [+0x093A2]  61                       popa
F000:13A3  [+0x093A3]  C3                       ret
F000:13A4  [+0x093A4]  60                       pusha
F000:13A5  [+0x093A5]  1E                       push    ds
F000:13A6  [+0x093A6]  B8 00 60                 mov     ax,6000h
F000:13A9  [+0x093A9]  8E D8                    mov     ds,ax
F000:13AB  [+0x093AB]  50                       push    ax
F000:13AC  [+0x093AC]  B0 66                    mov     al,66h
F000:13AE  [+0x093AE]  E6 80                    out     80h,al
F000:13B0  [+0x093B0]  58                       pop     ax
F000:13B1  [+0x093B1]  0F 20 C0                 mov     eax,cr0
F000:13B4  [+0x093B4]  66 50                    push    eax
F000:13B6  [+0x093B6]  66 0D 00 00 00 60        or      eax,60000000h
F000:13BC  [+0x093BC]  0F 22 C0                 mov     cr0,eax
F000:13BF  [+0x093BF]  90                       nop
F000:13C0  [+0x093C0]  0F 08                    invd
F000:13C2  [+0x093C2]  B8 03 01                 mov     ax,103h
F000:13C5  [+0x093C5]  BA 02 00                 mov     dx,2
F000:13C8  [+0x093C8]  E8 6D FF                 call    1338h
F000:13CB  [+0x093CB]  B8 13 00                 mov     ax,13h
F000:13CE  [+0x093CE]  BA 02 00                 mov     dx,2
F000:13D1  [+0x093D1]  E8 6D FF                 call    1341h
F000:13D4  [+0x093D4]  B8 03 01                 mov     ax,103h
F000:13D7  [+0x093D7]  BA 01 00                 mov     dx,1
F000:13DA  [+0x093DA]  E8 5B FF                 call    1338h
F000:13DD  [+0x093DD]  C6 06 00 80 EA           mov     byte [8000h],0EAh
F000:13E2  [+0x093E2]  C7 06 01 80 77 14        mov     word [8001h],1477h
F000:13E8  [+0x093E8]  C7 06 03 80 00 E8        mov     word [8003h],0E800h
F000:13EE  [+0x093EE]  B8 03 01                 mov     ax,103h
F000:13F1  [+0x093F1]  BA 01 00                 mov     dx,1
F000:13F4  [+0x093F4]  E8 4A FF                 call    1341h
F000:13F7  [+0x093F7]  B8 00 30                 mov     ax,3000h
F000:13FA  [+0x093FA]  8E D8                    mov     ds,ax
F000:13FC  [+0x093FC]  C6 06 00 80 EA           mov     byte [8000h],0EAh
F000:1401  [+0x09401]  C7 06 01 80 77 14        mov     word [8001h],1477h
F000:1407  [+0x09407]  C7 06 03 80 00 E8        mov     word [8003h],0E800h
F000:140D  [+0x0940D]  B8 01 00                 mov     ax,1
F000:1410  [+0x09410]  BA F0 00                 mov     dx,0F0h
F000:1413  [+0x09413]  E8 22 FF                 call    1338h
F000:1416  [+0x09416]  E8 D8 FE                 call    12F1h
F000:1419  [+0x09419]  75 F2                    jne     short 140Dh
F000:141B  [+0x0941B]  B8 06 00                 mov     ax,6
F000:141E  [+0x0941E]  BA 00 10                 mov     dx,1000h
F000:1421  [+0x09421]  E8 14 FF                 call    1338h
F000:1424  [+0x09424]  80 3E 00 80 EA           cmp     byte [8000h],0EAh
F000:1429  [+0x09429]  74 F9                    je      short 1424h
F000:142B  [+0x0942B]  B8 06 00                 mov     ax,6
F000:142E  [+0x0942E]  BA 00 10                 mov     dx,1000h
F000:1431  [+0x09431]  E8 0D FF                 call    1341h
F000:1434  [+0x09434]  B8 01 00                 mov     ax,1
F000:1437  [+0x09437]  BA F0 00                 mov     dx,0F0h
F000:143A  [+0x0943A]  E8 FB FE                 call    1338h
F000:143D  [+0x0943D]  9C                       pushf
F000:143E  [+0x0943E]  FA                       cli
F000:143F  [+0x0943F]  B8 06 00                 mov     ax,6
F000:1442  [+0x09442]  BA 00 10                 mov     dx,1000h
F000:1445  [+0x09445]  E8 F0 FE                 call    1338h
F000:1448  [+0x09448]  C7 06 00 80 EA 00        mov     word [8000h],0EAh
F000:144E  [+0x0944E]  81 3E 00 80 EA 00        cmp     word [8000h],0EAh
F000:1454  [+0x09454]  74 F8                    je      short 144Eh
F000:1456  [+0x09456]  9D                       popf
F000:1457  [+0x09457]  B8 06 00                 mov     ax,6
F000:145A  [+0x0945A]  BA 00 10                 mov     dx,1000h
F000:145D  [+0x0945D]  E8 E1 FE                 call    1341h
F000:1460  [+0x09460]  B8 01 00                 mov     ax,1
F000:1463  [+0x09463]  BA F0 00                 mov     dx,0F0h
F000:1466  [+0x09466]  E8 CF FE                 call    1338h
F000:1469  [+0x09469]  66 58                    pop     eax
F000:146B  [+0x0946B]  0F 22 C0                 mov     cr0,eax
F000:146E  [+0x0946E]  50                       push    ax
F000:146F  [+0x0946F]  B0 88                    mov     al,88h
F000:1471  [+0x09471]  E6 80                    out     80h,al
F000:1473  [+0x09473]  58                       pop     ax
F000:1474  [+0x09474]  1F                       pop     ds
F000:1475  [+0x09475]  61                       popa
F000:1476  [+0x09476]  C3                       ret
F000:1477  [+0x09477]  B8 00 30                 mov     ax,3000h
F000:147A  [+0x0947A]  8E D8                    mov     ds,ax
F000:147C  [+0x0947C]  C6 06 00 80 00           mov     byte [8000h],0
F000:1481  [+0x09481]  66 C7 06 F8 FE 00 00 06 00 mov     dword [0FEF8h],60000h
F000:148A  [+0x0948A]  B8 00 60                 mov     ax,6000h
F000:148D  [+0x0948D]  8E D8                    mov     ds,ax
F000:148F  [+0x0948F]  C6 06 00 80 EA           mov     byte [8000h],0EAh
F000:1494  [+0x09494]  C7 06 01 80 A2 14        mov     word [8001h],14A2h
F000:149A  [+0x0949A]  C7 06 03 80 00 E8        mov     word [8003h],0E800h
F000:14A0  [+0x094A0]  0F AA                    rsm
F000:14A2  [+0x094A2]  B8 00 30                 mov     ax,3000h
F000:14A5  [+0x094A5]  8E D8                    mov     ds,ax
F000:14A7  [+0x094A7]  C6 06 00 80 00           mov     byte [8000h],0
F000:14AC  [+0x094AC]  B8 00 60                 mov     ax,6000h
F000:14AF  [+0x094AF]  8E D8                    mov     ds,ax
F000:14B1  [+0x094B1]  8E C0                    mov     es,ax
F000:14B3  [+0x094B3]  C6 06 00 80 EA           mov     byte [8000h],0EAh
F000:14B8  [+0x094B8]  C7 06 01 80 D7 14        mov     word [8001h],14D7h
F000:14BE  [+0x094BE]  C7 06 03 80 00 E8        mov     word [8003h],0E800h
F000:14C4  [+0x094C4]  BE 00 FE                 mov     si,0FE00h
F000:14C7  [+0x094C7]  BF 00 90                 mov     di,9000h
F000:14CA  [+0x094CA]  B9 00 01                 mov     cx,100h
F000:14CD  [+0x094CD]  FC                       cld
F000:14CE  [+0x094CE]  F3 A5                    rep movsw
F000:14D0  [+0x094D0]  26 8C 0E AC 91           mov     [es:91ACh],cs
F000:14D5  [+0x094D5]  0F AA                    rsm
F000:14D7  [+0x094D7]  0F 08                    invd
F000:14D9  [+0x094D9]  0F 20 C0                 mov     eax,cr0
F000:14DC  [+0x094DC]  66 0D 00 00 00 60        or      eax,60000000h
F000:14E2  [+0x094E2]  0F 22 C0                 mov     cr0,eax
F000:14E5  [+0x094E5]  B8 00 DC                 mov     ax,0DC00h
F000:14E8  [+0x094E8]  8E D8                    mov     ds,ax
F000:14EA  [+0x094EA]  8E C0                    mov     es,ax
F000:14EC  [+0x094EC]  FA                       cli
F000:14ED  [+0x094ED]  B8 00 60                 mov     ax,6000h
F000:14F0  [+0x094F0]  8E D0                    mov     ss,ax
F000:14F2  [+0x094F2]  BC 00 FD                 mov     sp,0FD00h
F000:14F5  [+0x094F5]  E8 A3 F4                 call    099Bh
F000:14F8  [+0x094F8]  0F 85 20 00              jne     near 151Ch
F000:14FC  [+0x094FC]  B8 07 02                 mov     ax,207h
F000:14FF  [+0x094FF]  BA 80 00                 mov     dx,80h
F000:1502  [+0x09502]  E8 EC FD                 call    12F1h
F000:1505  [+0x09505]  53                       push    bx
F000:1506  [+0x09506]  E8 41 FE                 call    134Ah
F000:1509  [+0x09509]  E8 1C 13                 call    2828h
F000:150C  [+0x0950C]  E8 D2 F4                 call    09E1h
F000:150F  [+0x0950F]  E8 4C FE                 call    135Eh
F000:1512  [+0x09512]  5B                       pop     bx
F000:1513  [+0x09513]  B8 07 02                 mov     ax,207h
F000:1516  [+0x09516]  BA 80 00                 mov     dx,80h
F000:1519  [+0x09519]  E8 ED FD                 call    1309h
F000:151C  [+0x0951C]  0F 08                    invd
F000:151E  [+0x0951E]  0F AA                    rsm
F000:1520  [+0x09520]  50                       push    ax
F000:1521  [+0x09521]  1E                       push    ds
F000:1522  [+0x09522]  06                       push    es
F000:1523  [+0x09523]  B8 00 60                 mov     ax,6000h
F000:1526  [+0x09526]  8E D8                    mov     ds,ax
F000:1528  [+0x09528]  8E C0                    mov     es,ax
F000:152A  [+0x0952A]  BE 00 FE                 mov     si,0FE00h
F000:152D  [+0x0952D]  BF 00 94                 mov     di,9400h
F000:1530  [+0x09530]  B9 00 01                 mov     cx,100h
F000:1533  [+0x09533]  FC                       cld
F000:1534  [+0x09534]  F3 A5                    rep movsw
F000:1536  [+0x09536]  07                       pop     es
F000:1537  [+0x09537]  1F                       pop     ds
F000:1538  [+0x09538]  58                       pop     ax
F000:1539  [+0x09539]  C3                       ret
F000:153A  [+0x0953A]  E8 67 FE                 call    13A4h
F000:153D  [+0x0953D]  B8 03 01                 mov     ax,103h
F000:1540  [+0x09540]  BA 01 00                 mov     dx,1
F000:1543  [+0x09543]  E8 F2 FD                 call    1338h
F000:1546  [+0x09546]  B8 00 60                 mov     ax,6000h
F000:1549  [+0x09549]  8E D8                    mov     ds,ax
F000:154B  [+0x0954B]  C6 06 00 80 EA           mov     byte [8000h],0EAh
F000:1550  [+0x09550]  C7 06 01 80 70 15        mov     word [8001h],1570h
F000:1556  [+0x09556]  C7 06 03 80 00 E8        mov     word [8003h],0E800h
F000:155C  [+0x0955C]  B8 03 01                 mov     ax,103h
F000:155F  [+0x0955F]  BA 01 00                 mov     dx,1
F000:1562  [+0x09562]  E8 DC FD                 call    1341h
F000:1565  [+0x09565]  B8 06 00                 mov     ax,6
F000:1568  [+0x09568]  BA 00 10                 mov     dx,1000h
F000:156B  [+0x0956B]  E8 CA FD                 call    1338h
F000:156E  [+0x0956E]  EB FE                    jmp     short 156Eh
F000:1570  [+0x09570]  B8 00 60                 mov     ax,6000h
F000:1573  [+0x09573]  8E D8                    mov     ds,ax
F000:1575  [+0x09575]  8E C0                    mov     es,ax
F000:1577  [+0x09577]  FA                       cli
F000:1578  [+0x09578]  8E D0                    mov     ss,ax
F000:157A  [+0x0957A]  BC 00 80                 mov     sp,8000h
F000:157D  [+0x0957D]  B8 06 00                 mov     ax,6
F000:1580  [+0x09580]  BA 00 10                 mov     dx,1000h
F000:1583  [+0x09583]  E8 BB FD                 call    1341h
F000:1586  [+0x09586]  C6 06 00 80 EA           mov     byte [8000h],0EAh
F000:158B  [+0x0958B]  C7 06 01 80 D7 14        mov     word [8001h],14D7h
F000:1591  [+0x09591]  C7 06 03 80 00 E8        mov     word [8003h],0E800h
F000:1597  [+0x09597]  BE 00 94                 mov     si,9400h
F000:159A  [+0x0959A]  BF 00 FE                 mov     di,0FE00h
F000:159D  [+0x0959D]  B9 00 01                 mov     cx,100h
F000:15A0  [+0x095A0]  FC                       cld
F000:15A1  [+0x095A1]  F3 A5                    rep movsw
F000:15A3  [+0x095A3]  E9 E4 0E                 jmp     248Ah
F000:15A6  [+0x095A6]  00 00                    add     [bx+si],al
F000:15A8  [+0x095A8]  FF 0F                    dec     word [bx]
F000:15AA  [+0x095AA]  88 07                    mov     [bx],al
F000:15AC  [+0x095AC]  0D 00 FE                 or      ax,0FE00h
F000:15AF  [+0x095AF]  7F 00                    jg      short 15B1h
F000:15B1  [+0x095B1]  00 01                    add     [bx+di],al
F000:15B3  [+0x095B3]  00 00                    add     [bx+si],al
F000:15B5  [+0x095B5]  FF 00                    inc     word [bx+si]
F000:15B7  [+0x095B7]  20 03                    and     [bp+di],al
F000:15B9  [+0x095B9]  00 FF                    add     bh,bh
F000:15BB  [+0x095BB]  3F                       aas
F000:15BC  [+0x095BC]  C0 2E 04 00 FF           shr     byte [4],0FFh
F000:15C1  [+0x095C1]  03 66 03                 add     sp,[bp+3]
F000:15C4  [+0x095C4]  06                       push    es
F000:15C5  [+0x095C5]  00 FF                    add     bh,bh
F000:15C7  [+0x095C7]  DB 0xFF  (bad)
F000:15C9  [+0x095C9]  CF                       iret
F000:15CA  [+0x095CA]  07                       pop     es
F000:15CB  [+0x095CB]  00 FF                    add     bh,bh
F000:15CD  [+0x095CD]  DB 0xF0  (bad)
F000:15CF  [+0x095CF]  00 08                    add     [bx+si],cl
F000:15D1  [+0x095D1]  00 FF                    add     bh,bh
F000:15D3  [+0x095D3]  DB 0xFF  (bad)
F000:15D5  [+0x095D5]  23 09                    and     cx,[bx+di]
F000:15D7  [+0x095D7]  00 FF                    add     bh,bh
F000:15D9  [+0x095D9]  03 0F                    add     cx,[bx]
F000:15DB  [+0x095DB]  03 0A                    add     cx,[bp+si]
F000:15DD  [+0x095DD]  00 FF                    add     bh,bh
F000:15DF  [+0x095DF]  03 0F                    add     cx,[bx]
F000:15E1  [+0x095E1]  03 0B                    add     cx,[bp+di]
F000:15E3  [+0x095E3]  00 FF                    add     bh,bh
F000:15E5  [+0x095E5]  03 0F                    add     cx,[bx]
F000:15E7  [+0x095E7]  03 0C                    add     cx,[si]
F000:15E9  [+0x095E9]  00 FF                    add     bh,bh
F000:15EB  [+0x095EB]  03 0E 03 0E              add     cx,[0E03h]
F000:15EF  [+0x095EF]  00 7F 0D                 add     [bx+0Dh],bh
F000:15F2  [+0x095F2]  10 3E 11 00              adc     [11h],bh
F000:15F6  [+0x095F6]  FF 03                    inc     word [bp+di]
F000:15F8  [+0x095F8]  00 02                    add     [bp+si],al
F000:15FA  [+0x095FA]  13 00                    adc     ax,[bx+si]
F000:15FC  [+0x095FC]  07                       pop     es
F000:15FD  [+0x095FD]  00 00                    add     [bx+si],al
F000:15FF  [+0x095FF]  00 02                    add     [bp+si],al
F000:1601  [+0x09601]  03 FF                    add     di,di
F000:1603  [+0x09603]  03 2E 02 03              add     bp,[302h]
F000:1607  [+0x09607]  03 FF                    add     di,di
F000:1609  [+0x09609]  0F FF 0B                 ud0     cx,[bp+di]
F000:160C  [+0x0960C]  DB 0xFF  (bad)
F000:160E  [+0x0960E]  DB 0xFF  (bad)
F000:1610  [+0x09610]  DB 0xFF  (bad)
F000:1612  [+0x09612]  06                       push    es
F000:1613  [+0x09613]  00 FF                    add     bh,bh
F000:1615  [+0x09615]  FF 83 43 13              inc     word [bp+di+1343h]
F000:1619  [+0x09619]  00 07                    add     [bx],al
F000:161B  [+0x0961B]  00 00                    add     [bx+si],al
F000:161D  [+0x0961D]  00 FF                    add     bh,bh
F000:161F  [+0x0961F]  DB 0xFF  (bad)
F000:1621  [+0x09621]  DB 0xFF  (bad)
F000:1623  [+0x09623]  DB 0xFF  (bad)
F000:1625  [+0x09625]  FC                       cld
F000:1626  [+0x09626]  50                       push    ax
F000:1627  [+0x09627]  B0 90                    mov     al,90h
F000:1629  [+0x09629]  E6 80                    out     80h,al
F000:162B  [+0x0962B]  58                       pop     ax
F000:162C  [+0x0962C]  E5 8D                    in      ax,8Dh
F000:162E  [+0x0962E]  EB 00                    jmp     short 1630h
F000:1630  [+0x09630]  3D 34 12                 cmp     ax,1234h
F000:1633  [+0x09633]  0F 84 15 00              je      near 164Ch
F000:1637  [+0x09637]  3D 78 56                 cmp     ax,5678h
F000:163A  [+0x0963A]  0F 84 04 00              je      near 1642h
F000:163E  [+0x0963E]  0F 85 14 00              jne     near 1656h
F000:1642  [+0x09642]  B8 00 00                 mov     ax,0
F000:1645  [+0x09645]  E7 8D                    out     8Dh,ax
F000:1647  [+0x09647]  EB 00                    jmp     short 1649h
F000:1649  [+0x09649]  E9 C4 3E                 jmp     5510h
F000:164C  [+0x0964C]  B8 00 00                 mov     ax,0
F000:164F  [+0x0964F]  E7 8D                    out     8Dh,ax
F000:1651  [+0x09651]  EB 00                    jmp     short 1653h
F000:1653  [+0x09653]  E9 37 3D                 jmp     538Dh
F000:1656  [+0x09656]  E4 21                    in      al,21h
F000:1658  [+0x09658]  0C 02                    or      al,2
F000:165A  [+0x0965A]  E6 21                    out     21h,al
F000:165C  [+0x0965C]  B8 01 00                 mov     ax,1
F000:165F  [+0x0965F]  BA F0 00                 mov     dx,0F0h
F000:1662  [+0x09662]  E8 D3 FC                 call    1338h
F000:1665  [+0x09665]  E8 89 FC                 call    12F1h
F000:1668  [+0x09668]  75 F2                    jne     short 165Ch
F000:166A  [+0x0966A]  E4 A1                    in      al,0A1h
F000:166C  [+0x0966C]  0C 80                    or      al,80h
F000:166E  [+0x0966E]  E6 A1                    out     0A1h,al
F000:1670  [+0x09670]  BE A6 15                 mov     si,15A6h
F000:1673  [+0x09673]  BF 21 13                 mov     di,1321h
F000:1676  [+0x09676]  E8 02 01                 call    177Bh
F000:1679  [+0x09679]  E8 CE FC                 call    134Ah
F000:167C  [+0x0967C]  B8 00 DC                 mov     ax,0DC00h
F000:167F  [+0x0967F]  8E D8                    mov     ds,ax
F000:1681  [+0x09681]  8E C0                    mov     es,ax
F000:1683  [+0x09683]  33 FF                    xor     di,di
F000:1685  [+0x09685]  B8 11 11                 mov     ax,1111h
F000:1688  [+0x09688]  B9 00 20                 mov     cx,2000h
F000:168B  [+0x0968B]  F3 AB                    rep stosw
F000:168D  [+0x0968D]  C6 06 12 01 00           mov     byte [112h],0
F000:1692  [+0x09692]  C6 06 10 01 00           mov     byte [110h],0
F000:1697  [+0x09697]  50                       push    ax
F000:1698  [+0x09698]  53                       push    bx
F000:1699  [+0x09699]  52                       push    dx
F000:169A  [+0x0969A]  B0 44                    mov     al,44h
F000:169C  [+0x0969C]  B3 07                    mov     bl,7
F000:169E  [+0x0969E]  E8 56 09                 call    1FF7h
F000:16A1  [+0x096A1]  0F 85 05 00              jne     near 16AAh
F000:16A5  [+0x096A5]  C6 06 10 01 03           mov     byte [110h],3
F000:16AA  [+0x096AA]  5A                       pop     dx
F000:16AB  [+0x096AB]  5B                       pop     bx
F000:16AC  [+0x096AC]  58                       pop     ax
F000:16AD  [+0x096AD]  BE FE 04                 mov     si,4FEh
F000:16B0  [+0x096B0]  E8 A2 09                 call    2055h
F000:16B3  [+0x096B3]  BE 12 16                 mov     si,1612h
F000:16B6  [+0x096B6]  BF 09 13                 mov     di,1309h
F000:16B9  [+0x096B9]  E8 BF 00                 call    177Bh
F000:16BC  [+0x096BC]  E8 D6 FB                 call    1295h
F000:16BF  [+0x096BF]  0F 83 09 00              jae     near 16CCh
F000:16C3  [+0x096C3]  B8 03 00                 mov     ax,3
F000:16C6  [+0x096C6]  BA 01 00                 mov     dx,1
F000:16C9  [+0x096C9]  E8 6C FC                 call    1338h
F000:16CC  [+0x096CC]  B8 00 01                 mov     ax,100h
F000:16CF  [+0x096CF]  E8 11 FC                 call    12E3h
F000:16D2  [+0x096D2]  F6 C7 01                 test    bh,1
F000:16D5  [+0x096D5]  0F 84 30 00              je      near 1709h
F000:16D9  [+0x096D9]  B8 09 00                 mov     ax,9
F000:16DC  [+0x096DC]  BB 0F 03                 mov     bx,30Fh
F000:16DF  [+0x096DF]  E8 08 FC                 call    12EAh
F000:16E2  [+0x096E2]  B8 0A 00                 mov     ax,0Ah
F000:16E5  [+0x096E5]  BB 0F 03                 mov     bx,30Fh
F000:16E8  [+0x096E8]  E8 FF FB                 call    12EAh
F000:16EB  [+0x096EB]  B8 0B 00                 mov     ax,0Bh
F000:16EE  [+0x096EE]  BB 0F 03                 mov     bx,30Fh
F000:16F1  [+0x096F1]  E8 F6 FB                 call    12EAh
F000:16F4  [+0x096F4]  B8 0C 00                 mov     ax,0Ch
F000:16F7  [+0x096F7]  BB 02 87                 mov     bx,8702h
F000:16FA  [+0x096FA]  E8 ED FB                 call    12EAh
F000:16FD  [+0x096FD]  B8 00 03                 mov     ax,300h
F000:1700  [+0x09700]  BB E7 01                 mov     bx,1E7h
F000:1703  [+0x09703]  E8 E4 FB                 call    12EAh
F000:1706  [+0x09706]  EB 13                    jmp     short 171Bh
F000:1708  [+0x09708]  90                       nop
F000:1709  [+0x09709]  B8 0C 00                 mov     ax,0Ch
F000:170C  [+0x0970C]  BA 00 84                 mov     dx,8400h
F000:170F  [+0x0970F]  E8 26 FC                 call    1338h
F000:1712  [+0x09712]  B8 00 03                 mov     ax,300h
F000:1715  [+0x09715]  BB DD 01                 mov     bx,1DDh
F000:1718  [+0x09718]  E8 CF FB                 call    12EAh
F000:171B  [+0x0971B]  33 C0                    xor     ax,ax
F000:171D  [+0x0971D]  8E C0                    mov     es,ax
F000:171F  [+0x0971F]  B8 00 00                 mov     ax,0
F000:1722  [+0x09722]  26 A3 DC 01              mov     [es:1DCh],ax
F000:1726  [+0x09726]  26 8C 0E DE 01           mov     [es:1DEh],cs
F000:172B  [+0x0972B]  B8 0E 00                 mov     ax,0Eh
F000:172E  [+0x0972E]  BA 01 00                 mov     dx,1
F000:1731  [+0x09731]  E8 04 FC                 call    1338h
F000:1734  [+0x09734]  E4 A1                    in      al,0A1h
F000:1736  [+0x09736]  24 7F                    and     al,7Fh
F000:1738  [+0x09738]  E6 A1                    out     0A1h,al
F000:173A  [+0x0973A]  E8 E4 31                 call    4921h
F000:173D  [+0x0973D]  0F 82 03 00              jb      near 1744h
F000:1741  [+0x09741]  E8 29 34                 call    4B6Dh
F000:1744  [+0x09744]  9C                       pushf
F000:1745  [+0x09745]  B8 06 00                 mov     ax,6
F000:1748  [+0x09748]  BA D0 00                 mov     dx,0D0h
F000:174B  [+0x0974B]  E8 F3 FB                 call    1341h
F000:174E  [+0x0974E]  C6 06 8D 00 34           mov     byte [8Dh],34h
F000:1753  [+0x09753]  E8 08 FC                 call    135Eh
F000:1756  [+0x09756]  E4 21                    in      al,21h
F000:1758  [+0x09758]  24 FD                    and     al,0FDh
F000:175A  [+0x0975A]  E6 21                    out     21h,al
F000:175C  [+0x0975C]  50                       push    ax
F000:175D  [+0x0975D]  B0 9F                    mov     al,9Fh
F000:175F  [+0x0975F]  E6 80                    out     80h,al
F000:1761  [+0x09761]  58                       pop     ax
F000:1762  [+0x09762]  52                       push    dx
F000:1763  [+0x09763]  50                       push    ax
F000:1764  [+0x09764]  BA A1 00                 mov     dx,0A1h
F000:1767  [+0x09767]  EC                       in      al,dx
F000:1768  [+0x09768]  EB 00                    jmp     short 176Ah
F000:176A  [+0x0976A]  EB 00                    jmp     short 176Ch
F000:176C  [+0x0976C]  EB 00                    jmp     short 176Eh
F000:176E  [+0x0976E]  0C 02                    or      al,2
F000:1770  [+0x09770]  EE                       out     dx,al
F000:1771  [+0x09771]  EB 00                    jmp     short 1773h
F000:1773  [+0x09773]  EB 00                    jmp     short 1775h
F000:1775  [+0x09775]  EB 00                    jmp     short 1777h
F000:1777  [+0x09777]  58                       pop     ax
F000:1778  [+0x09778]  5A                       pop     dx
F000:1779  [+0x09779]  9D                       popf
F000:177A  [+0x0977A]  C3                       ret
F000:177B  [+0x0977B]  60                       pusha
F000:177C  [+0x0977C]  2E AD                    cs lodsw
F000:177E  [+0x0977E]  8B D8                    mov     bx,ax
F000:1780  [+0x09780]  2E AD                    cs lodsw
F000:1782  [+0x09782]  8B D0                    mov     dx,ax
F000:1784  [+0x09784]  2E AD                    cs lodsw
F000:1786  [+0x09786]  93                       xchg    bx,ax
F000:1787  [+0x09787]  3D FF FF                 cmp     ax,0FFFFh
F000:178A  [+0x0978A]  74 04                    je      short 1790h
F000:178C  [+0x0978C]  FF D7                    call    di
F000:178E  [+0x0978E]  EB EC                    jmp     short 177Ch
F000:1790  [+0x09790]  61                       popa
F000:1791  [+0x09791]  C3                       ret
F000:1792  [+0x09792]  50                       push    ax
F000:1793  [+0x09793]  1E                       push    ds
F000:1794  [+0x09794]  B8 00 DC                 mov     ax,0DC00h
F000:1797  [+0x09797]  8E D8                    mov     ds,ax
F000:1799  [+0x09799]  E8 AE FB                 call    134Ah
F000:179C  [+0x0979C]  A0 8D 00                 mov     al,[8Dh]
F000:179F  [+0x0979F]  3C 34                    cmp     al,34h
F000:17A1  [+0x097A1]  1F                       pop     ds
F000:17A2  [+0x097A2]  58                       pop     ax
F000:17A3  [+0x097A3]  C3                       ret
F000:17A4  [+0x097A4]  1E                       push    ds
F000:17A5  [+0x097A5]  E8 A2 FB                 call    134Ah
F000:17A8  [+0x097A8]  B8 00 DC                 mov     ax,0DC00h
F000:17AB  [+0x097AB]  8E D8                    mov     ds,ax
F000:17AD  [+0x097AD]  C7 06 00 00 55 AA        mov     word [0],0AA55h
F000:17B3  [+0x097B3]  C6 06 02 00 20           mov     byte [2],20h
F000:17B8  [+0x097B8]  E8 A3 FB                 call    135Eh
F000:17BB  [+0x097BB]  1F                       pop     ds
F000:17BC  [+0x097BC]  C3                       ret
F000:17BD  [+0x097BD]  00 42 03                 add     [bp+si+3],al
F000:17C0  [+0x097C0]  E1 1E                    loope   17E0h
F000:17C2  [+0x097C2]  03 00                    add     ax,[bx+si]
F000:17C4  [+0x097C4]  01 02                    add     [bp+si],ax
F000:17C6  [+0x097C6]  00 01                    add     [bx+di],al
F000:17C8  [+0x097C8]  02 01                    add     al,[bx+di]
F000:17CA  [+0x097CA]  4E                       dec     si
F000:17CB  [+0x097CB]  01 E6                    add     si,sp
F000:17CD  [+0x097CD]  19 01                    sbb     [bx+di],ax
F000:17CF  [+0x097CF]  01 00                    add     [bx+si],ax
F000:17D1  [+0x097D1]  02 43 38                 add     al,[bp+di+38h]
F000:17D4  [+0x097D4]  F2 19 01                 sbb     [bx+di],ax
F000:17D7  [+0x097D7]  00 07                    add     [bx],al
F000:17D9  [+0x097D9]  03 44 38                 add     ax,[si+38h]
F000:17DC  [+0x097DC]  FA                       cli
F000:17DD  [+0x097DD]  19 01                    sbb     [bx+di],ax
F000:17DF  [+0x097DF]  00 07                    add     [bx],al
F000:17E1  [+0x097E1]  04 46                    add     al,46h
F000:17E3  [+0x097E3]  07                       pop     es
F000:17E4  [+0x097E4]  02 1A                    add     bl,[bp+si]
F000:17E6  [+0x097E6]  02 01                    add     al,[bx+di]
F000:17E8  [+0x097E8]  00 00                    add     [bx+si],al
F000:17EA  [+0x097EA]  07                       pop     es
F000:17EB  [+0x097EB]  05 46 38                 add     ax,3846h
F000:17EE  [+0x097EE]  0A 1A                    or      bl,[bp+si]
F000:17F0  [+0x097F0]  02 01                    add     al,[bx+di]
F000:17F2  [+0x097F2]  00 00                    add     [bx+si],al
F000:17F4  [+0x097F4]  07                       pop     es
F000:17F5  [+0x097F5]  06                       push    es
F000:17F6  [+0x097F6]  43                       inc     bx
F000:17F7  [+0x097F7]  07                       pop     es
F000:17F8  [+0x097F8]  EC                       in      al,dx
F000:17F9  [+0x097F9]  1E                       push    ds
F000:17FA  [+0x097FA]  08 41 41                 or      [bx+di+41h],al
F000:17FD  [+0x097FD]  41                       inc     cx
F000:17FE  [+0x097FE]  41                       inc     cx
F000:17FF  [+0x097FF]  41                       inc     cx
F000:1800  [+0x09800]  41                       inc     cx
F000:1801  [+0x09801]  41                       inc     cx
F000:1802  [+0x09802]  41                       inc     cx
F000:1803  [+0x09803]  07                       pop     es
F000:1804  [+0x09804]  07                       pop     es
F000:1805  [+0x09805]  07                       pop     es
F000:1806  [+0x09806]  07                       pop     es
F000:1807  [+0x09807]  07                       pop     es
F000:1808  [+0x09808]  07                       pop     es
F000:1809  [+0x09809]  07                       pop     es
F000:180A  [+0x0980A]  07                       pop     es
F000:180B  [+0x0980B]  07                       pop     es
F000:180C  [+0x0980C]  44                       inc     sp
F000:180D  [+0x0980D]  07                       pop     es
F000:180E  [+0x0980E]  F6 1E 08 00              neg     byte [8]
F000:1812  [+0x09812]  06                       push    es
F000:1813  [+0x09813]  0A 12                    or      dl,[bp+si]
F000:1815  [+0x09815]  1A 22                    sbb     ah,[bp+si]
F000:1817  [+0x09817]  32 42 00                 xor     al,[bp+si]
F000:181A  [+0x0981A]  01 02                    add     [bp+si],ax
F000:181C  [+0x0981C]  03 04                    add     ax,[si]
F000:181E  [+0x0981E]  05 06 07                 add     ax,706h
F000:1821  [+0x09821]  08 45 07                 or      [di+7],al
F000:1824  [+0x09824]  DB 0xFE  (bad)
F000:1826  [+0x09826]  08 00                    or      [bx+si],al
F000:1828  [+0x09828]  16                       push    ss
F000:1829  [+0x09829]  2A 3E 52 7A              sub     bh,[7A52h]
F000:182D  [+0x0982D]  A2 F2 00                 mov     [0F2h],al
F000:1830  [+0x09830]  01 02                    add     [bp+si],ax
F000:1832  [+0x09832]  03 04                    add     ax,[si]
F000:1834  [+0x09834]  05 06 07                 add     ax,706h
F000:1837  [+0x09837]  0A 4B FF                 or      cl,[bp+di-1]
F000:183A  [+0x0983A]  C0 2A 06                 shr     byte [bp+si],6
F000:183D  [+0x0983D]  00 06 0A 16              add     [160Ah],al
F000:1841  [+0x09841]  2A 3E 00 0C              sub     bh,[0C00h]
F000:1845  [+0x09845]  18 3C                    sbb     [si],bh
F000:1847  [+0x09847]  78 B4                    js      short 17FDh
F000:1849  [+0x09849]  0C 42                    or      al,42h
F000:184B  [+0x0984B]  40                       inc     ax
F000:184C  [+0x0984C]  CC                       int3
F000:184D  [+0x0984D]  18 02                    sbb     [bp+si],al
F000:184F  [+0x0984F]  00 01                    add     [bx+di],al
F000:1851  [+0x09851]  00 01                    add     [bx+di],al
F000:1853  [+0x09853]  0D 4C 10                 or      ax,104Ch
F000:1856  [+0x09856]  06                       push    es
F000:1857  [+0x09857]  1F                       pop     ds
F000:1858  [+0x09858]  02 00                    add     al,[bx+si]
F000:185A  [+0x0985A]  01 00                    add     [bx+si],ax
F000:185C  [+0x0985C]  01 0E 4A 07              add     [74Ah],cx
F000:1860  [+0x09860]  0B 1F                    or      bx,[bx]
F000:1862  [+0x09862]  08 00                    or      [bx+si],al
F000:1864  [+0x09864]  01 02                    add     [bp+si],ax
F000:1866  [+0x09866]  03 04                    add     ax,[si]
F000:1868  [+0x09868]  05 06 07                 add     ax,706h
F000:186B  [+0x0986B]  00 01                    add     [bx+di],al
F000:186D  [+0x0986D]  02 03                    add     al,[bp+di]
F000:186F  [+0x0986F]  04 05                    add     al,5
F000:1871  [+0x09871]  06                       push    es
F000:1872  [+0x09872]  07                       pop     es
F000:1873  [+0x09873]  FF 60 06                 jmp     word [bx+si+6]
F000:1876  [+0x09876]  1E                       push    ds
F000:1877  [+0x09877]  07                       pop     es
F000:1878  [+0x09878]  BF 8E 00                 mov     di,8Eh
F000:187B  [+0x0987B]  B9 78 00                 mov     cx,78h
F000:187E  [+0x0987E]  B0 00                    mov     al,0
F000:1880  [+0x09880]  F3 AA                    rep stosb
F000:1882  [+0x09882]  BE BD 17                 mov     si,17BDh
F000:1885  [+0x09885]  2E AC                    cs lodsb
F000:1887  [+0x09887]  BF 8E 00                 mov     di,8Eh
F000:188A  [+0x0988A]  B4 08                    mov     ah,8
F000:188C  [+0x0988C]  F6 E4                    mul     ah
F000:188E  [+0x0988E]  03 F8                    add     di,ax
F000:1890  [+0x09890]  2E AD                    cs lodsw
F000:1892  [+0x09892]  8A DC                    mov     bl,ah
F000:1894  [+0x09894]  E8 60 07                 call    1FF7h
F000:1897  [+0x09897]  88 25                    mov     [di],ah
F000:1899  [+0x09899]  2E AD                    cs lodsw
F000:189B  [+0x0989B]  89 45 02                 mov     [di+2],ax
F000:189E  [+0x0989E]  2E AC                    cs lodsb
F000:18A0  [+0x098A0]  88 45 01                 mov     [di+1],al
F000:18A3  [+0x098A3]  89 75 04                 mov     [di+4],si
F000:18A6  [+0x098A6]  32 E4                    xor     ah,ah
F000:18A8  [+0x098A8]  03 F0                    add     si,ax
F000:18AA  [+0x098AA]  89 75 06                 mov     [di+6],si
F000:18AD  [+0x098AD]  03 F0                    add     si,ax
F000:18AF  [+0x098AF]  2E AC                    cs lodsb
F000:18B1  [+0x098B1]  3C FF                    cmp     al,0FFh
F000:18B3  [+0x098B3]  75 D2                    jne     short 1887h
F000:18B5  [+0x098B5]  33 C0                    xor     ax,ax
F000:18B7  [+0x098B7]  B4 01                    mov     ah,1
F000:18B9  [+0x098B9]  E8 1B 00                 call    18D7h
F000:18BC  [+0x098BC]  B4 03                    mov     ah,3
F000:18BE  [+0x098BE]  E8 16 00                 call    18D7h
F000:18C1  [+0x098C1]  FE C0                    inc     al
F000:18C3  [+0x098C3]  3C 0F                    cmp     al,0Fh
F000:18C5  [+0x098C5]  72 F0                    jb      short 18B7h
F000:18C7  [+0x098C7]  E8 80 FA                 call    134Ah
F000:18CA  [+0x098CA]  07                       pop     es
F000:18CB  [+0x098CB]  61                       popa
F000:18CC  [+0x098CC]  C3                       ret
F000:18CD  [+0x098CD]  19 19                    sbb     [bx+di],bx
F000:18CF  [+0x098CF]  1E                       push    ds
F000:18D0  [+0x098D0]  19 22                    sbb     [bp+si],sp
F000:18D2  [+0x098D2]  19 38                    sbb     [bx+si],di
F000:18D4  [+0x098D4]  19 57 19                 sbb     [bx+19h],dx
F000:18D7  [+0x098D7]  9C                       pushf
F000:18D8  [+0x098D8]  1E                       push    ds
F000:18D9  [+0x098D9]  56                       push    si
F000:18DA  [+0x098DA]  57                       push    di
F000:18DB  [+0x098DB]  50                       push    ax
F000:18DC  [+0x098DC]  80 E4 0F                 and     ah,0Fh
F000:18DF  [+0x098DF]  80 FC 04                 cmp     ah,4
F000:18E2  [+0x098E2]  58                       pop     ax
F000:18E3  [+0x098E3]  0F 84 0C 00              je      near 18F3h
F000:18E7  [+0x098E7]  77 2B                    ja      short 1914h
F000:18E9  [+0x098E9]  3C 0F                    cmp     al,0Fh
F000:18EB  [+0x098EB]  0F 82 04 00              jb      near 18F3h
F000:18EF  [+0x098EF]  B4 81                    mov     ah,81h
F000:18F1  [+0x098F1]  EB 21                    jmp     short 1914h
F000:18F3  [+0x098F3]  FA                       cli
F000:18F4  [+0x098F4]  FC                       cld
F000:18F5  [+0x098F5]  BE 00 DC                 mov     si,0DC00h
F000:18F8  [+0x098F8]  8E DE                    mov     ds,si
F000:18FA  [+0x098FA]  0F B6 F4                 movzx   si,ah
F000:18FD  [+0x098FD]  03 F6                    add     si,si
F000:18FF  [+0x098FF]  50                       push    ax
F000:1900  [+0x09900]  BF 8E 00                 mov     di,8Eh
F000:1903  [+0x09903]  B4 08                    mov     ah,8
F000:1905  [+0x09905]  F6 E4                    mul     ah
F000:1907  [+0x09907]  03 F8                    add     di,ax
F000:1909  [+0x09909]  58                       pop     ax
F000:190A  [+0x0990A]  E8 3D FA                 call    134Ah
F000:190D  [+0x0990D]  B4 80                    mov     ah,80h
F000:190F  [+0x0990F]  2E FF 94 CD 18           call    word [cs:si+18CDh]
F000:1914  [+0x09914]  5F                       pop     di
F000:1915  [+0x09915]  5E                       pop     si
F000:1916  [+0x09916]  1F                       pop     ds
F000:1917  [+0x09917]  9D                       popf
F000:1918  [+0x09918]  C3                       ret
F000:1919  [+0x09919]  0F B6 5D 01              movzx   bx,byte [di+1]
F000:191D  [+0x0991D]  C3                       ret
F000:191E  [+0x0991E]  0F B6 1D                 movzx   bx,byte [di]
F000:1921  [+0x09921]  C3                       ret
F000:1922  [+0x09922]  0A FF                    or      bh,bh
F000:1924  [+0x09924]  75 0F                    jne     short 1935h
F000:1926  [+0x09926]  3A 5D 01                 cmp     bl,[di+1]
F000:1929  [+0x09929]  73 0A                    jae     short 1935h
F000:192B  [+0x0992B]  8B 7D 04                 mov     di,[di+4]
F000:192E  [+0x0992E]  03 FB                    add     di,bx
F000:1930  [+0x09930]  2E 0F B6 0D              movzx   cx,byte [cs:di]
F000:1934  [+0x09934]  C3                       ret
F000:1935  [+0x09935]  B4 82                    mov     ah,82h
F000:1937  [+0x09937]  C3                       ret
F000:1938  [+0x09938]  0A FF                    or      bh,bh
F000:193A  [+0x0993A]  75 12                    jne     short 194Eh
F000:193C  [+0x0993C]  3A 5D 01                 cmp     bl,[di+1]
F000:193F  [+0x0993F]  73 0D                    jae     short 194Eh
F000:1941  [+0x09941]  88 1D                    mov     [di],bl
F000:1943  [+0x09943]  03 5D 06                 add     bx,[di+6]
F000:1946  [+0x09946]  2E 0F B6 1F              movzx   bx,byte [cs:bx]
F000:194A  [+0x0994A]  FF 55 02                 call    word [di+2]
F000:194D  [+0x0994D]  C3                       ret
F000:194E  [+0x0994E]  B4 82                    mov     ah,82h
F000:1950  [+0x09950]  C3                       ret
F000:1951  [+0x09951]  8C CA                    mov     dx,cs
F000:1953  [+0x09953]  B8 2C 00                 mov     ax,2Ch
F000:1956  [+0x09956]  CB                       retf
F000:1957  [+0x09957]  9C                       pushf
F000:1958  [+0x09958]  1E                       push    ds
F000:1959  [+0x09959]  FA                       cli
F000:195A  [+0x0995A]  B8 00 DC                 mov     ax,0DC00h
F000:195D  [+0x0995D]  8E D8                    mov     ds,ax
F000:195F  [+0x0995F]  8C 16 27 14              mov     [1427h],ss
F000:1963  [+0x09963]  89 26 25 14              mov     [1425h],sp
F000:1967  [+0x09967]  B8 80 DF                 mov     ax,0DF80h
F000:196A  [+0x0996A]  8E D0                    mov     ss,ax
F000:196C  [+0x0996C]  BC FF 07                 mov     sp,7FFh
F000:196F  [+0x0996F]  E8 00 38                 call    5172h
F000:1972  [+0x09972]  05 00 04                 add     ax,400h
F000:1975  [+0x09975]  BB 00 80                 mov     bx,8000h
F000:1978  [+0x09978]  0F B2 26 25 14           lss     sp,[1425h]
F000:197D  [+0x0997D]  1F                       pop     ds
F000:197E  [+0x0997E]  9D                       popf
F000:197F  [+0x0997F]  C3                       ret
F000:1980  [+0x09980]  53                       push    bx
F000:1981  [+0x09981]  C6 06 06 01 00           mov     byte [106h],0
F000:1986  [+0x09986]  C6 06 07 01 00           mov     byte [107h],0
F000:198B  [+0x0998B]  C6 06 08 01 00           mov     byte [108h],0
F000:1990  [+0x09990]  C6 06 09 01 00           mov     byte [109h],0
F000:1995  [+0x09995]  C6 06 0A 01 00           mov     byte [10Ah],0
F000:199A  [+0x0999A]  E8 02 00                 call    199Fh
F000:199D  [+0x0999D]  5B                       pop     bx
F000:199E  [+0x0999E]  C3                       ret
F000:199F  [+0x0999F]  50                       push    ax
F000:19A0  [+0x099A0]  53                       push    bx
F000:19A1  [+0x099A1]  51                       push    cx
F000:19A2  [+0x099A2]  52                       push    dx
F000:19A3  [+0x099A3]  B8 00 00                 mov     ax,0
F000:19A6  [+0x099A6]  BB 88 07                 mov     bx,788h
F000:19A9  [+0x099A9]  E8 3E F9                 call    12EAh
F000:19AC  [+0x099AC]  5A                       pop     dx
F000:19AD  [+0x099AD]  59                       pop     cx
F000:19AE  [+0x099AE]  5B                       pop     bx
F000:19AF  [+0x099AF]  58                       pop     ax
F000:19B0  [+0x099B0]  C3                       ret
F000:19B1  [+0x099B1]  50                       push    ax
F000:19B2  [+0x099B2]  53                       push    bx
F000:19B3  [+0x099B3]  51                       push    cx
F000:19B4  [+0x099B4]  52                       push    dx
F000:19B5  [+0x099B5]  B8 00 00                 mov     ax,0
F000:19B8  [+0x099B8]  E8 28 F9                 call    12E3h
F000:19BB  [+0x099BB]  F7 C3 00 30              test    bx,3000h
F000:19BF  [+0x099BF]  74 14                    je      short 19D5h
F000:19C1  [+0x099C1]  8A 2E 09 01              mov     ch,[109h]
F000:19C5  [+0x099C5]  F7 C3 00 20              test    bx,2000h
F000:19C9  [+0x099C9]  74 0A                    je      short 19D5h
F000:19CB  [+0x099CB]  3A 2E 0A 01              cmp     ch,[10Ah]
F000:19CF  [+0x099CF]  73 04                    jae     short 19D5h
F000:19D1  [+0x099D1]  8A 2E 0A 01              mov     ch,[10Ah]
F000:19D5  [+0x099D5]  80 FD 07                 cmp     ch,7
F000:19D8  [+0x099D8]  75 03                    jne     short 19DDh
F000:19DA  [+0x099DA]  E8 F0 EA                 call    04CDh
F000:19DD  [+0x099DD]  5A                       pop     dx
F000:19DE  [+0x099DE]  59                       pop     cx
F000:19DF  [+0x099DF]  5B                       pop     bx
F000:19E0  [+0x099E0]  58                       pop     ax
F000:19E1  [+0x099E1]  C3                       ret
F000:19E2  [+0x099E2]  E8 38 05                 call    1F1Dh
F000:19E5  [+0x099E5]  C3                       ret
F000:19E6  [+0x099E6]  66 50                    push    eax
F000:19E8  [+0x099E8]  88 1E 06 01              mov     [106h],bl
F000:19EC  [+0x099EC]  E8 B0 FF                 call    199Fh
F000:19EF  [+0x099EF]  66 58                    pop     eax
F000:19F1  [+0x099F1]  C3                       ret
F000:19F2  [+0x099F2]  88 1E 07 01              mov     [107h],bl
F000:19F6  [+0x099F6]  E8 A6 FF                 call    199Fh
F000:19F9  [+0x099F9]  C3                       ret
F000:19FA  [+0x099FA]  88 1E 08 01              mov     [108h],bl
F000:19FE  [+0x099FE]  E8 9E FF                 call    199Fh
F000:1A01  [+0x09A01]  C3                       ret
F000:1A02  [+0x09A02]  88 1E 09 01              mov     [109h],bl
F000:1A06  [+0x09A06]  E8 96 FF                 call    199Fh
F000:1A09  [+0x09A09]  C3                       ret
F000:1A0A  [+0x09A0A]  88 1E 0A 01              mov     [10Ah],bl
F000:1A0E  [+0x09A0E]  E8 8E FF                 call    199Fh
F000:1A11  [+0x09A11]  C3                       ret
F000:1A12  [+0x09A12]  53                       push    bx
F000:1A13  [+0x09A13]  C6 06 0B 01 00           mov     byte [10Bh],0
F000:1A18  [+0x09A18]  C6 06 0C 01 00           mov     byte [10Ch],0
F000:1A1D  [+0x09A1D]  C6 06 0D 01 00           mov     byte [10Dh],0
F000:1A22  [+0x09A22]  C6 06 0F 01 01           mov     byte [10Fh],1
F000:1A27  [+0x09A27]  B0 0E                    mov     al,0Eh
F000:1A29  [+0x09A29]  B3 80                    mov     bl,80h
F000:1A2B  [+0x09A2B]  E8 C9 05                 call    1FF7h
F000:1A2E  [+0x09A2E]  75 09                    jne     short 1A39h
F000:1A30  [+0x09A30]  B0 34                    mov     al,34h
F000:1A32  [+0x09A32]  B3 80                    mov     bl,80h
F000:1A34  [+0x09A34]  E8 C0 05                 call    1FF7h
F000:1A37  [+0x09A37]  75 05                    jne     short 1A3Eh
F000:1A39  [+0x09A39]  C6 06 0F 01 00           mov     byte [10Fh],0
F000:1A3E  [+0x09A3E]  E8 02 00                 call    1A43h
F000:1A41  [+0x09A41]  5B                       pop     bx
F000:1A42  [+0x09A42]  C3                       ret
F000:1A43  [+0x09A43]  50                       push    ax
F000:1A44  [+0x09A44]  53                       push    bx
F000:1A45  [+0x09A45]  52                       push    dx
F000:1A46  [+0x09A46]  B8 0D 00                 mov     ax,0Dh
F000:1A49  [+0x09A49]  BA FE 1F                 mov     dx,1FFEh
F000:1A4C  [+0x09A4C]  E8 F2 F8                 call    1341h
F000:1A4F  [+0x09A4F]  E8 71 04                 call    1EC3h
F000:1A52  [+0x09A52]  73 46                    jae     short 1A9Ah
F000:1A54  [+0x09A54]  C6 06 10 01 00           mov     byte [110h],0
F000:1A59  [+0x09A59]  B0 44                    mov     al,44h
F000:1A5B  [+0x09A5B]  B3 07                    mov     bl,7
F000:1A5D  [+0x09A5D]  E8 97 05                 call    1FF7h
F000:1A60  [+0x09A60]  0F 85 0B 00              jne     near 1A6Fh
F000:1A64  [+0x09A64]  C6 06 10 01 03           mov     byte [110h],3
F000:1A69  [+0x09A69]  A0 0D 01                 mov     al,[10Dh]
F000:1A6C  [+0x09A6C]  A2 0C 01                 mov     [10Ch],al
F000:1A6F  [+0x09A6F]  B8 0D 00                 mov     ax,0Dh
F000:1A72  [+0x09A72]  BA 00 1C                 mov     dx,1C00h
F000:1A75  [+0x09A75]  8A 1E 0B 01              mov     bl,[10Bh]
F000:1A79  [+0x09A79]  E8 8D F8                 call    1309h
F000:1A7C  [+0x09A7C]  BA 80 03                 mov     dx,380h
F000:1A7F  [+0x09A7F]  8A 1E 0C 01              mov     bl,[10Ch]
F000:1A83  [+0x09A83]  E8 83 F8                 call    1309h
F000:1A86  [+0x09A86]  BA 70 00                 mov     dx,70h
F000:1A89  [+0x09A89]  8A 1E 0D 01              mov     bl,[10Dh]
F000:1A8D  [+0x09A8D]  E8 79 F8                 call    1309h
F000:1A90  [+0x09A90]  BA 0E 00                 mov     dx,0Eh
F000:1A93  [+0x09A93]  8A 1E 0E 01              mov     bl,[10Eh]
F000:1A97  [+0x09A97]  E8 6F F8                 call    1309h
F000:1A9A  [+0x09A9A]  5A                       pop     dx
F000:1A9B  [+0x09A9B]  5B                       pop     bx
F000:1A9C  [+0x09A9C]  58                       pop     ax
F000:1A9D  [+0x09A9D]  C3                       ret
F000:1A9E  [+0x09A9E]  52                       push    dx
F000:1A9F  [+0x09A9F]  50                       push    ax
F000:1AA0  [+0x09AA0]  E8 9D 20                 call    3B40h
F000:1AA3  [+0x09AA3]  58                       pop     ax
F000:1AA4  [+0x09AA4]  5A                       pop     dx
F000:1AA5  [+0x09AA5]  0F 84 0C 00              je      near 1AB5h
F000:1AA9  [+0x09AA9]  F6 06 10 01 08           test    byte [110h],8
F000:1AAE  [+0x09AAE]  0F 84 03 00              je      near 1AB5h
F000:1AB2  [+0x09AB2]  E9 4E F3                 jmp     0E03h
F000:1AB5  [+0x09AB5]  50                       push    ax
F000:1AB6  [+0x09AB6]  53                       push    bx
F000:1AB7  [+0x09AB7]  52                       push    dx
F000:1AB8  [+0x09AB8]  B8 06 00                 mov     ax,6
F000:1ABB  [+0x09ABB]  BA 80 00                 mov     dx,80h
F000:1ABE  [+0x09ABE]  E8 77 F8                 call    1338h
F000:1AC1  [+0x09AC1]  B8 02 00                 mov     ax,2
F000:1AC4  [+0x09AC4]  BA FF 13                 mov     dx,13FFh
F000:1AC7  [+0x09AC7]  E8 77 F8                 call    1341h
F000:1ACA  [+0x09ACA]  B8 01 00                 mov     ax,1
F000:1ACD  [+0x09ACD]  BB F7 20                 mov     bx,20F7h
F000:1AD0  [+0x09AD0]  E8 17 F8                 call    12EAh
F000:1AD3  [+0x09AD3]  B8 06 00                 mov     ax,6
F000:1AD6  [+0x09AD6]  BA 00 40                 mov     dx,4000h
F000:1AD9  [+0x09AD9]  E8 5C F8                 call    1338h
F000:1ADC  [+0x09ADC]  B8 11 00                 mov     ax,11h
F000:1ADF  [+0x09ADF]  BB 00 02                 mov     bx,200h
F000:1AE2  [+0x09AE2]  E8 05 F8                 call    12EAh
F000:1AE5  [+0x09AE5]  80 3E 10 01 03           cmp     byte [110h],3
F000:1AEA  [+0x09AEA]  0F 84 12 00              je      near 1B00h
F000:1AEE  [+0x09AEE]  B8 0D 00                 mov     ax,0Dh
F000:1AF1  [+0x09AF1]  BA 80 03                 mov     dx,380h
F000:1AF4  [+0x09AF4]  8A 1E 0C 01              mov     bl,[10Ch]
F000:1AF8  [+0x09AF8]  E8 0E F8                 call    1309h
F000:1AFB  [+0x09AFB]  C6 06 10 01 00           mov     byte [110h],0
F000:1B00  [+0x09B00]  E8 58 1D                 call    385Bh
F000:1B03  [+0x09B03]  5A                       pop     dx
F000:1B04  [+0x09B04]  5B                       pop     bx
F000:1B05  [+0x09B05]  58                       pop     ax
F000:1B06  [+0x09B06]  C3                       ret
F000:1B07  [+0x09B07]  B8 06 00                 mov     ax,6
F000:1B0A  [+0x09B0A]  BA 00 40                 mov     dx,4000h
F000:1B0D  [+0x09B0D]  E8 28 F8                 call    1338h
F000:1B10  [+0x09B10]  B8 02 00                 mov     ax,2
F000:1B13  [+0x09B13]  BA FF 13                 mov     dx,13FFh
F000:1B16  [+0x09B16]  E8 28 F8                 call    1341h
F000:1B19  [+0x09B19]  B8 06 00                 mov     ax,6
F000:1B1C  [+0x09B1C]  BA 80 00                 mov     dx,80h
F000:1B1F  [+0x09B1F]  E8 1F F8                 call    1341h
F000:1B22  [+0x09B22]  B8 01 00                 mov     ax,1
F000:1B25  [+0x09B25]  E8 BB F7                 call    12E3h
F000:1B28  [+0x09B28]  8B C3                    mov     ax,bx
F000:1B2A  [+0x09B2A]  B7 9F                    mov     bh,9Fh
F000:1B2C  [+0x09B2C]  A9 00 10                 test    ax,1000h
F000:1B2F  [+0x09B2F]  75 07                    jne     short 1B38h
F000:1B31  [+0x09B31]  A9 00 08                 test    ax,800h
F000:1B34  [+0x09B34]  75 02                    jne     short 1B38h
F000:1B36  [+0x09B36]  B7 7F                    mov     bh,7Fh
F000:1B38  [+0x09B38]  53                       push    bx
F000:1B39  [+0x09B39]  B3 F7                    mov     bl,0F7h
F000:1B3B  [+0x09B3B]  B8 01 00                 mov     ax,1
F000:1B3E  [+0x09B3E]  E8 A9 F7                 call    12EAh
F000:1B41  [+0x09B41]  5B                       pop     bx
F000:1B42  [+0x09B42]  80 E7 E0                 and     bh,0E0h
F000:1B45  [+0x09B45]  80 FF 06                 cmp     bh,6
F000:1B48  [+0x09B48]  0F 85 0E 00              jne     near 1B5Ah
F000:1B4C  [+0x09B4C]  80 3E 10 01 03           cmp     byte [110h],3
F000:1B51  [+0x09B51]  0F 84 05 00              je      near 1B5Ah
F000:1B55  [+0x09B55]  C6 06 10 01 00           mov     byte [110h],0
F000:1B5A  [+0x09B5A]  F6 06 10 01 08           test    byte [110h],8
F000:1B5F  [+0x09B5F]  0F 85 23 00              jne     near 1B86h
F000:1B63  [+0x09B63]  F6 06 11 01 01           test    byte [111h],1
F000:1B68  [+0x09B68]  0F 84 1A 00              je      near 1B86h
F000:1B6C  [+0x09B6C]  B8 03 00                 mov     ax,3
F000:1B6F  [+0x09B6F]  BA 02 00                 mov     dx,2
F000:1B72  [+0x09B72]  E8 C3 F7                 call    1338h
F000:1B75  [+0x09B75]  E8 E1 0F                 call    2B59h
F000:1B78  [+0x09B78]  B8 03 00                 mov     ax,3
F000:1B7B  [+0x09B7B]  BA 02 00                 mov     dx,2
F000:1B7E  [+0x09B7E]  E8 C0 F7                 call    1341h
F000:1B81  [+0x09B81]  C6 06 11 01 00           mov     byte [111h],0
F000:1B86  [+0x09B86]  B8 10 00                 mov     ax,10h
F000:1B89  [+0x09B89]  BB 01 00                 mov     bx,1
F000:1B8C  [+0x09B8C]  E8 5B F7                 call    12EAh
F000:1B8F  [+0x09B8F]  B8 06 00                 mov     ax,6
F000:1B92  [+0x09B92]  BA 00 40                 mov     dx,4000h
F000:1B95  [+0x09B95]  E8 A9 F7                 call    1341h
F000:1B98  [+0x09B98]  C3                       ret
F000:1B99  [+0x09B99]  52                       push    dx
F000:1B9A  [+0x09B9A]  50                       push    ax
F000:1B9B  [+0x09B9B]  E8 A2 1F                 call    3B40h
F000:1B9E  [+0x09B9E]  58                       pop     ax
F000:1B9F  [+0x09B9F]  5A                       pop     dx
F000:1BA0  [+0x09BA0]  0F 84 08 00              je      near 1BACh
F000:1BA4  [+0x09BA4]  C6 06 11 01 00           mov     byte [111h],0
F000:1BA9  [+0x09BA9]  E9 57 F2                 jmp     0E03h
F000:1BAC  [+0x09BAC]  80 3E 10 01 03           cmp     byte [110h],3
F000:1BB1  [+0x09BB1]  0F 84 7F 02              je      near 1E34h
F000:1BB5  [+0x09BB5]  80 3E 10 01 02           cmp     byte [110h],2
F000:1BBA  [+0x09BBA]  0F 85 08 00              jne     near 1BC6h
F000:1BBE  [+0x09BBE]  C6 06 10 01 00           mov     byte [110h],0
F000:1BC3  [+0x09BC3]  E9 6E 02                 jmp     1E34h
F000:1BC6  [+0x09BC6]  B8 0D 00                 mov     ax,0Dh
F000:1BC9  [+0x09BC9]  BA 80 03                 mov     dx,380h
F000:1BCC  [+0x09BCC]  8A 1E 0D 01              mov     bl,[10Dh]
F000:1BD0  [+0x09BD0]  E8 36 F7                 call    1309h
F000:1BD3  [+0x09BD3]  C6 06 10 01 02           mov     byte [110h],2
F000:1BD8  [+0x09BD8]  B8 03 00                 mov     ax,3
F000:1BDB  [+0x09BDB]  BA 02 00                 mov     dx,2
F000:1BDE  [+0x09BDE]  E8 57 F7                 call    1338h
F000:1BE1  [+0x09BE1]  E8 1A 10                 call    2BFEh
F000:1BE4  [+0x09BE4]  B8 03 00                 mov     ax,3
F000:1BE7  [+0x09BE7]  BA 02 00                 mov     dx,2
F000:1BEA  [+0x09BEA]  E8 54 F7                 call    1341h
F000:1BED  [+0x09BED]  B8 02 00                 mov     ax,2
F000:1BF0  [+0x09BF0]  BA FF 13                 mov     dx,13FFh
F000:1BF3  [+0x09BF3]  E8 4B F7                 call    1341h
F000:1BF6  [+0x09BF6]  B8 06 00                 mov     ax,6
F000:1BF9  [+0x09BF9]  BA 80 00                 mov     dx,80h
F000:1BFC  [+0x09BFC]  E8 42 F7                 call    1341h
F000:1BFF  [+0x09BFF]  E8 B4 03                 call    1FB6h
F000:1C02  [+0x09C02]  C6 06 10 01 02           mov     byte [110h],2
F000:1C07  [+0x09C07]  B8 01 00                 mov     ax,1
F000:1C0A  [+0x09C0A]  BB F7 77                 mov     bx,77F7h
F000:1C0D  [+0x09C0D]  E8 DA F6                 call    12EAh
F000:1C10  [+0x09C10]  B8 11 00                 mov     ax,11h
F000:1C13  [+0x09C13]  BB 00 01                 mov     bx,100h
F000:1C16  [+0x09C16]  E8 D1 F6                 call    12EAh
F000:1C19  [+0x09C19]  B8 06 00                 mov     ax,6
F000:1C1C  [+0x09C1C]  BA 00 40                 mov     dx,4000h
F000:1C1F  [+0x09C1F]  E8 1F F7                 call    1341h
F000:1C22  [+0x09C22]  B8 10 00                 mov     ax,10h
F000:1C25  [+0x09C25]  BB 00 00                 mov     bx,0
F000:1C28  [+0x09C28]  E8 BF F6                 call    12EAh
F000:1C2B  [+0x09C2B]  E8 56 1C                 call    3884h
F000:1C2E  [+0x09C2E]  C3                       ret
F000:1C2F  [+0x09C2F]  B0 3F                    mov     al,3Fh
F000:1C31  [+0x09C31]  E8 B8 03                 call    1FECh
F000:1C34  [+0x09C34]  50                       push    ax
F000:1C35  [+0x09C35]  B8 07 00                 mov     ax,7
F000:1C38  [+0x09C38]  BA 00 07                 mov     dx,700h
F000:1C3B  [+0x09C3B]  E8 B3 F6                 call    12F1h
F000:1C3E  [+0x09C3E]  58                       pop     ax
F000:1C3F  [+0x09C3F]  8A C3                    mov     al,bl
F000:1C41  [+0x09C41]  3C 05                    cmp     al,5
F000:1C43  [+0x09C43]  0F 84 38 00              je      near 1C7Fh
F000:1C47  [+0x09C47]  3C 01                    cmp     al,1
F000:1C49  [+0x09C49]  0F 84 1B 00              je      near 1C68h
F000:1C4D  [+0x09C4D]  3C 06                    cmp     al,6
F000:1C4F  [+0x09C4F]  0F 84 43 00              je      near 1C96h
F000:1C53  [+0x09C53]  3C 02                    cmp     al,2
F000:1C55  [+0x09C55]  0F 84 49 00              je      near 1CA2h
F000:1C59  [+0x09C59]  3C 07                    cmp     al,7
F000:1C5B  [+0x09C5B]  0F 84 62 00              je      near 1CC1h
F000:1C5F  [+0x09C5F]  3C 03                    cmp     al,3
F000:1C61  [+0x09C61]  0F 84 5C 00              je      near 1CC1h
F000:1C65  [+0x09C65]  E9 BF 01                 jmp     1E27h
F000:1C68  [+0x09C68]  8A C4                    mov     al,ah
F000:1C6A  [+0x09C6A]  25 07 F8                 and     ax,0F807h
F000:1C6D  [+0x09C6D]  80 FC F0                 cmp     ah,0F0h
F000:1C70  [+0x09C70]  0F 83 06 00              jae     near 1C7Ah
F000:1C74  [+0x09C74]  80 C4 08                 add     ah,8
F000:1C77  [+0x09C77]  EB 32                    jmp     short 1CABh
F000:1C79  [+0x09C79]  90                       nop
F000:1C7A  [+0x09C7A]  B4 08                    mov     ah,8
F000:1C7C  [+0x09C7C]  EB 2D                    jmp     short 1CABh
F000:1C7E  [+0x09C7E]  90                       nop
F000:1C7F  [+0x09C7F]  8A C4                    mov     al,ah
F000:1C81  [+0x09C81]  25 07 F8                 and     ax,0F807h
F000:1C84  [+0x09C84]  80 FC 08                 cmp     ah,8
F000:1C87  [+0x09C87]  0F 86 06 00              jbe     near 1C91h
F000:1C8B  [+0x09C8B]  80 EC 08                 sub     ah,8
F000:1C8E  [+0x09C8E]  EB 1B                    jmp     short 1CABh
F000:1C90  [+0x09C90]  90                       nop
F000:1C91  [+0x09C91]  B4 F0                    mov     ah,0F0h
F000:1C93  [+0x09C93]  EB 16                    jmp     short 1CABh
F000:1C95  [+0x09C95]  90                       nop
F000:1C96  [+0x09C96]  8A C4                    mov     al,ah
F000:1C98  [+0x09C98]  25 07 F8                 and     ax,0F807h
F000:1C9B  [+0x09C9B]  FE C0                    inc     al
F000:1C9D  [+0x09C9D]  24 07                    and     al,7
F000:1C9F  [+0x09C9F]  EB 0A                    jmp     short 1CABh
F000:1CA1  [+0x09CA1]  90                       nop
F000:1CA2  [+0x09CA2]  8A C4                    mov     al,ah
F000:1CA4  [+0x09CA4]  25 07 F8                 and     ax,0F807h
F000:1CA7  [+0x09CA7]  FE C8                    dec     al
F000:1CA9  [+0x09CA9]  24 07                    and     al,7
F000:1CAB  [+0x09CAB]  0A C4                    or      al,ah
F000:1CAD  [+0x09CAD]  BA FF 01                 mov     dx,1FFh
F000:1CB0  [+0x09CB0]  EE                       out     dx,al
F000:1CB1  [+0x09CB1]  EB 00                    jmp     short 1CB3h
F000:1CB3  [+0x09CB3]  EB 00                    jmp     short 1CB5h
F000:1CB5  [+0x09CB5]  EB 00                    jmp     short 1CB7h
F000:1CB7  [+0x09CB7]  B4 3F                    mov     ah,3Fh
F000:1CB9  [+0x09CB9]  86 C4                    xchg    al,ah
F000:1CBB  [+0x09CBB]  E8 40 03                 call    1FFEh
F000:1CBE  [+0x09CBE]  E9 66 01                 jmp     1E27h
F000:1CC1  [+0x09CC1]  3C 03                    cmp     al,3
F000:1CC3  [+0x09CC3]  0F 85 80 00              jne     near 1D47h
F000:1CC7  [+0x09CC7]  50                       push    ax
F000:1CC8  [+0x09CC8]  53                       push    bx
F000:1CC9  [+0x09CC9]  B8 01 00                 mov     ax,1
F000:1CCC  [+0x09CCC]  E8 14 F6                 call    12E3h
F000:1CCF  [+0x09CCF]  F7 C3 08 00              test    bx,8
F000:1CD3  [+0x09CD3]  5B                       pop     bx
F000:1CD4  [+0x09CD4]  58                       pop     ax
F000:1CD5  [+0x09CD5]  0F 85 6E 00              jne     near 1D47h
F000:1CD9  [+0x09CD9]  50                       push    ax
F000:1CDA  [+0x09CDA]  53                       push    bx
F000:1CDB  [+0x09CDB]  B8 00 00                 mov     ax,0
F000:1CDE  [+0x09CDE]  E8 02 F6                 call    12E3h
F000:1CE1  [+0x09CE1]  F7 C3 00 30              test    bx,3000h
F000:1CE5  [+0x09CE5]  5B                       pop     bx
F000:1CE6  [+0x09CE6]  58                       pop     ax
F000:1CE7  [+0x09CE7]  0F 84 5C 00              je      near 1D47h
F000:1CEB  [+0x09CEB]  B8 09 00                 mov     ax,9
F000:1CEE  [+0x09CEE]  E8 F2 F5                 call    12E3h
F000:1CF1  [+0x09CF1]  F7 C3 00 01              test    bx,100h
F000:1CF5  [+0x09CF5]  0F 84 27 00              je      near 1D20h
F000:1CF9  [+0x09CF9]  B8 09 00                 mov     ax,9
F000:1CFC  [+0x09CFC]  BA 00 01                 mov     dx,100h
F000:1CFF  [+0x09CFF]  E8 3F F6                 call    1341h
F000:1D02  [+0x09D02]  B8 0A 00                 mov     ax,0Ah
F000:1D05  [+0x09D05]  BA 00 01                 mov     dx,100h
F000:1D08  [+0x09D08]  E8 36 F6                 call    1341h
F000:1D0B  [+0x09D0B]  B8 0B 00                 mov     ax,0Bh
F000:1D0E  [+0x09D0E]  BA 00 01                 mov     dx,100h
F000:1D11  [+0x09D11]  E8 2D F6                 call    1341h
F000:1D14  [+0x09D14]  B8 0C 00                 mov     ax,0Ch
F000:1D17  [+0x09D17]  BA 00 01                 mov     dx,100h
F000:1D1A  [+0x09D1A]  E8 24 F6                 call    1341h
F000:1D1D  [+0x09D1D]  E9 07 01                 jmp     1E27h
F000:1D20  [+0x09D20]  B8 09 00                 mov     ax,9
F000:1D23  [+0x09D23]  BA 00 01                 mov     dx,100h
F000:1D26  [+0x09D26]  E8 0F F6                 call    1338h
F000:1D29  [+0x09D29]  B8 0A 00                 mov     ax,0Ah
F000:1D2C  [+0x09D2C]  BA 00 01                 mov     dx,100h
F000:1D2F  [+0x09D2F]  E8 06 F6                 call    1338h
F000:1D32  [+0x09D32]  B8 0B 00                 mov     ax,0Bh
F000:1D35  [+0x09D35]  BA 00 01                 mov     dx,100h
F000:1D38  [+0x09D38]  E8 FD F5                 call    1338h
F000:1D3B  [+0x09D3B]  B8 0C 00                 mov     ax,0Ch
F000:1D3E  [+0x09D3E]  BA 00 01                 mov     dx,100h
F000:1D41  [+0x09D41]  E8 F4 F5                 call    1338h
F000:1D44  [+0x09D44]  E9 E0 00                 jmp     1E27h
F000:1D47  [+0x09D47]  9C                       pushf
F000:1D48  [+0x09D48]  FA                       cli
F000:1D49  [+0x09D49]  B9 FF 0F                 mov     cx,0FFFh
F000:1D4C  [+0x09D4C]  E2 FE                    loop    1D4Ch
F000:1D4E  [+0x09D4E]  BA 21 00                 mov     dx,21h
F000:1D51  [+0x09D51]  EC                       in      al,dx
F000:1D52  [+0x09D52]  EB 00                    jmp     short 1D54h
F000:1D54  [+0x09D54]  EB 00                    jmp     short 1D56h
F000:1D56  [+0x09D56]  EB 00                    jmp     short 1D58h
F000:1D58  [+0x09D58]  50                       push    ax
F000:1D59  [+0x09D59]  BA 2C 02                 mov     dx,22Ch
F000:1D5C  [+0x09D5C]  B9 4F 00                 mov     cx,4Fh
F000:1D5F  [+0x09D5F]  EC                       in      al,dx
F000:1D60  [+0x09D60]  EB 00                    jmp     short 1D62h
F000:1D62  [+0x09D62]  EB 00                    jmp     short 1D64h
F000:1D64  [+0x09D64]  EB 00                    jmp     short 1D66h
F000:1D66  [+0x09D66]  EB 00                    jmp     short 1D68h
F000:1D68  [+0x09D68]  EB 00                    jmp     short 1D6Ah
F000:1D6A  [+0x09D6A]  A8 84                    test    al,84h
F000:1D6C  [+0x09D6C]  E0 F1                    loopne  1D5Fh
F000:1D6E  [+0x09D6E]  0B C9                    or      cx,cx
F000:1D70  [+0x09D70]  0F 85 03 00              jne     near 1D77h
F000:1D74  [+0x09D74]  E9 A4 00                 jmp     1E1Bh
F000:1D77  [+0x09D77]  B9 4F 00                 mov     cx,4Fh
F000:1D7A  [+0x09D7A]  BA 2C 02                 mov     dx,22Ch
F000:1D7D  [+0x09D7D]  B0 DE                    mov     al,0DEh
F000:1D7F  [+0x09D7F]  EE                       out     dx,al
F000:1D80  [+0x09D80]  EB 00                    jmp     short 1D82h
F000:1D82  [+0x09D82]  EB 00                    jmp     short 1D84h
F000:1D84  [+0x09D84]  EB 00                    jmp     short 1D86h
F000:1D86  [+0x09D86]  EB 00                    jmp     short 1D88h
F000:1D88  [+0x09D88]  EB 00                    jmp     short 1D8Ah
F000:1D8A  [+0x09D8A]  B9 1F 00                 mov     cx,1Fh
F000:1D8D  [+0x09D8D]  BA 2E 02                 mov     dx,22Eh
F000:1D90  [+0x09D90]  EC                       in      al,dx
F000:1D91  [+0x09D91]  EB 00                    jmp     short 1D93h
F000:1D93  [+0x09D93]  EB 00                    jmp     short 1D95h
F000:1D95  [+0x09D95]  EB 00                    jmp     short 1D97h
F000:1D97  [+0x09D97]  EB 00                    jmp     short 1D99h
F000:1D99  [+0x09D99]  A8 80                    test    al,80h
F000:1D9B  [+0x09D9B]  E1 F3                    loope   1D90h
F000:1D9D  [+0x09D9D]  E3 7C                    jcxz    1E1Bh
F000:1D9F  [+0x09D9F]  BA 2A 02                 mov     dx,22Ah
F000:1DA2  [+0x09DA2]  EC                       in      al,dx
F000:1DA3  [+0x09DA3]  EB 00                    jmp     short 1DA5h
F000:1DA5  [+0x09DA5]  EB 00                    jmp     short 1DA7h
F000:1DA7  [+0x09DA7]  EB 00                    jmp     short 1DA9h
F000:1DA9  [+0x09DA9]  EB 00                    jmp     short 1DABh
F000:1DAB  [+0x09DAB]  EB 00                    jmp     short 1DADh
F000:1DAD  [+0x09DAD]  EB 00                    jmp     short 1DAFh
F000:1DAF  [+0x09DAF]  80 FB 03                 cmp     bl,3
F000:1DB2  [+0x09DB2]  0F 84 0B 00              je      near 1DC1h
F000:1DB6  [+0x09DB6]  3C 0F                    cmp     al,0Fh
F000:1DB8  [+0x09DB8]  0F 84 5F 00              je      near 1E1Bh
F000:1DBC  [+0x09DBC]  FE C0                    inc     al
F000:1DBE  [+0x09DBE]  EB 0B                    jmp     short 1DCBh
F000:1DC0  [+0x09DC0]  90                       nop
F000:1DC1  [+0x09DC1]  24 0F                    and     al,0Fh
F000:1DC3  [+0x09DC3]  A8 0F                    test    al,0Fh
F000:1DC5  [+0x09DC5]  0F 84 52 00              je      near 1E1Bh
F000:1DC9  [+0x09DC9]  FE C8                    dec     al
F000:1DCB  [+0x09DCB]  8A D8                    mov     bl,al
F000:1DCD  [+0x09DCD]  B9 1F 00                 mov     cx,1Fh
F000:1DD0  [+0x09DD0]  BA 2C 02                 mov     dx,22Ch
F000:1DD3  [+0x09DD3]  EC                       in      al,dx
F000:1DD4  [+0x09DD4]  EB 00                    jmp     short 1DD6h
F000:1DD6  [+0x09DD6]  EB 00                    jmp     short 1DD8h
F000:1DD8  [+0x09DD8]  EB 00                    jmp     short 1DDAh
F000:1DDA  [+0x09DDA]  EB 00                    jmp     short 1DDCh
F000:1DDC  [+0x09DDC]  EB 00                    jmp     short 1DDEh
F000:1DDE  [+0x09DDE]  A8 84                    test    al,84h
F000:1DE0  [+0x09DE0]  E0 F1                    loopne  1DD3h
F000:1DE2  [+0x09DE2]  E3 37                    jcxz    1E1Bh
F000:1DE4  [+0x09DE4]  B0 DF                    mov     al,0DFh
F000:1DE6  [+0x09DE6]  BA 2C 02                 mov     dx,22Ch
F000:1DE9  [+0x09DE9]  EE                       out     dx,al
F000:1DEA  [+0x09DEA]  EB 00                    jmp     short 1DECh
F000:1DEC  [+0x09DEC]  B9 2F 00                 mov     cx,2Fh
F000:1DEF  [+0x09DEF]  E2 FE                    loop    1DEFh
F000:1DF1  [+0x09DF1]  B9 1F 00                 mov     cx,1Fh
F000:1DF4  [+0x09DF4]  EC                       in      al,dx
F000:1DF5  [+0x09DF5]  EB 00                    jmp     short 1DF7h
F000:1DF7  [+0x09DF7]  EB 00                    jmp     short 1DF9h
F000:1DF9  [+0x09DF9]  EB 00                    jmp     short 1DFBh
F000:1DFB  [+0x09DFB]  EB 00                    jmp     short 1DFDh
F000:1DFD  [+0x09DFD]  EB 00                    jmp     short 1DFFh
F000:1DFF  [+0x09DFF]  A8 84                    test    al,84h
F000:1E01  [+0x09E01]  E0 F1                    loopne  1DF4h
F000:1E03  [+0x09E03]  E3 16                    jcxz    1E1Bh
F000:1E05  [+0x09E05]  8A C3                    mov     al,bl
F000:1E07  [+0x09E07]  24 0F                    and     al,0Fh
F000:1E09  [+0x09E09]  EE                       out     dx,al
F000:1E0A  [+0x09E0A]  EB 00                    jmp     short 1E0Ch
F000:1E0C  [+0x09E0C]  EB 00                    jmp     short 1E0Eh
F000:1E0E  [+0x09E0E]  EB 00                    jmp     short 1E10h
F000:1E10  [+0x09E10]  EB 00                    jmp     short 1E12h
F000:1E12  [+0x09E12]  EB 00                    jmp     short 1E14h
F000:1E14  [+0x09E14]  EB 00                    jmp     short 1E16h
F000:1E16  [+0x09E16]  B9 FF 0F                 mov     cx,0FFFh
F000:1E19  [+0x09E19]  E2 FE                    loop    1E19h
F000:1E1B  [+0x09E1B]  58                       pop     ax
F000:1E1C  [+0x09E1C]  BA 21 00                 mov     dx,21h
F000:1E1F  [+0x09E1F]  EE                       out     dx,al
F000:1E20  [+0x09E20]  EB 00                    jmp     short 1E22h
F000:1E22  [+0x09E22]  EB 00                    jmp     short 1E24h
F000:1E24  [+0x09E24]  EB 00                    jmp     short 1E26h
F000:1E26  [+0x09E26]  9D                       popf
F000:1E27  [+0x09E27]  BB 0F 00                 mov     bx,0Fh
F000:1E2A  [+0x09E2A]  BA F0 00                 mov     dx,0F0h
F000:1E2D  [+0x09E2D]  B8 01 00                 mov     ax,1
F000:1E30  [+0x09E30]  E8 D6 F4                 call    1309h
F000:1E33  [+0x09E33]  C3                       ret
F000:1E34  [+0x09E34]  B8 06 00                 mov     ax,6
F000:1E37  [+0x09E37]  BA 00 40                 mov     dx,4000h
F000:1E3A  [+0x09E3A]  E8 FB F4                 call    1338h
F000:1E3D  [+0x09E3D]  E8 8D E6                 call    04CDh
F000:1E40  [+0x09E40]  B8 01 00                 mov     ax,1
F000:1E43  [+0x09E43]  BB F7 20                 mov     bx,20F7h
F000:1E46  [+0x09E46]  E8 A1 F4                 call    12EAh
F000:1E49  [+0x09E49]  E8 20 02                 call    206Ch
F000:1E4C  [+0x09E4C]  C3                       ret
F000:1E4D  [+0x09E4D]  B0 3F                    mov     al,3Fh
F000:1E4F  [+0x09E4F]  E8 9A 01                 call    1FECh
F000:1E52  [+0x09E52]  86 C4                    xchg    al,ah
F000:1E54  [+0x09E54]  24 F8                    and     al,0F8h
F000:1E56  [+0x09E56]  BA FF 01                 mov     dx,1FFh
F000:1E59  [+0x09E59]  EE                       out     dx,al
F000:1E5A  [+0x09E5A]  EB 00                    jmp     short 1E5Ch
F000:1E5C  [+0x09E5C]  EB 00                    jmp     short 1E5Eh
F000:1E5E  [+0x09E5E]  E8 B2 00                 call    1F13h
F000:1E61  [+0x09E61]  C3                       ret
F000:1E62  [+0x09E62]  E8 DE FB                 call    1A43h
F000:1E65  [+0x09E65]  E8 37 FB                 call    199Fh
F000:1E68  [+0x09E68]  E8 A8 00                 call    1F13h
F000:1E6B  [+0x09E6B]  C6 06 0E 00 00           mov     byte [0Eh],0
F000:1E70  [+0x09E70]  B8 01 00                 mov     ax,1
F000:1E73  [+0x09E73]  E8 6D F4                 call    12E3h
F000:1E76  [+0x09E76]  F6 C3 08                 test    bl,8
F000:1E79  [+0x09E79]  0F 85 03 00              jne     near 1E80h
F000:1E7D  [+0x09E7D]  EB 01                    jmp     short 1E80h
F000:1E7F  [+0x09E7F]  90                       nop
F000:1E80  [+0x09E80]  B8 09 00                 mov     ax,9
F000:1E83  [+0x09E83]  BA 00 01                 mov     dx,100h
F000:1E86  [+0x09E86]  E8 AF F4                 call    1338h
F000:1E89  [+0x09E89]  B8 0A 00                 mov     ax,0Ah
F000:1E8C  [+0x09E8C]  BA 00 01                 mov     dx,100h
F000:1E8F  [+0x09E8F]  E8 A6 F4                 call    1338h
F000:1E92  [+0x09E92]  B8 0B 00                 mov     ax,0Bh
F000:1E95  [+0x09E95]  BA 00 01                 mov     dx,100h
F000:1E98  [+0x09E98]  E8 9D F4                 call    1338h
F000:1E9B  [+0x09E9B]  B8 0C 00                 mov     ax,0Ch
F000:1E9E  [+0x09E9E]  BA 00 01                 mov     dx,100h
F000:1EA1  [+0x09EA1]  E8 94 F4                 call    1338h
F000:1EA4  [+0x09EA4]  C3                       ret
F000:1EA5  [+0x09EA5]  E8 6B 00                 call    1F13h
F000:1EA8  [+0x09EA8]  C3                       ret
F000:1EA9  [+0x09EA9]  E8 71 00                 call    1F1Dh
F000:1EAC  [+0x09EAC]  B8 01 00                 mov     ax,1
F000:1EAF  [+0x09EAF]  BB F7 FF                 mov     bx,0FFF7h
F000:1EB2  [+0x09EB2]  E8 35 F4                 call    12EAh
F000:1EB5  [+0x09EB5]  B8 10 00                 mov     ax,10h
F000:1EB8  [+0x09EB8]  BB 01 00                 mov     bx,1
F000:1EBB  [+0x09EBB]  E8 2C F4                 call    12EAh
F000:1EBE  [+0x09EBE]  C3                       ret
F000:1EBF  [+0x09EBF]  E9 72 FF                 jmp     1E34h
F000:1EC2  [+0x09EC2]  C3                       ret
F000:1EC3  [+0x09EC3]  80 3E 0F 01 01           cmp     byte [10Fh],1
F000:1EC8  [+0x09EC8]  74 15                    je      short 1EDFh
F000:1ECA  [+0x09ECA]  72 11                    jb      short 1EDDh
F000:1ECC  [+0x09ECC]  50                       push    ax
F000:1ECD  [+0x09ECD]  53                       push    bx
F000:1ECE  [+0x09ECE]  52                       push    dx
F000:1ECF  [+0x09ECF]  B8 01 00                 mov     ax,1
F000:1ED2  [+0x09ED2]  BA 08 00                 mov     dx,8
F000:1ED5  [+0x09ED5]  E8 19 F4                 call    12F1h
F000:1ED8  [+0x09ED8]  5A                       pop     dx
F000:1ED9  [+0x09ED9]  5B                       pop     bx
F000:1EDA  [+0x09EDA]  58                       pop     ax
F000:1EDB  [+0x09EDB]  74 02                    je      short 1EDFh
F000:1EDD  [+0x09EDD]  F8                       clc
F000:1EDE  [+0x09EDE]  C3                       ret
F000:1EDF  [+0x09EDF]  F9                       stc
F000:1EE0  [+0x09EE0]  C3                       ret
F000:1EE1  [+0x09EE1]  88 1E 0F 01              mov     [10Fh],bl
F000:1EE5  [+0x09EE5]  E8 5B FB                 call    1A43h
F000:1EE8  [+0x09EE8]  E8 B4 FA                 call    199Fh
F000:1EEB  [+0x09EEB]  C3                       ret
F000:1EEC  [+0x09EEC]  B3 07                    mov     bl,7
F000:1EEE  [+0x09EEE]  88 1E 0B 01              mov     [10Bh],bl
F000:1EF2  [+0x09EF2]  E8 4E FB                 call    1A43h
F000:1EF5  [+0x09EF5]  C3                       ret
F000:1EF6  [+0x09EF6]  88 1E 0C 01              mov     [10Ch],bl
F000:1EFA  [+0x09EFA]  E8 46 FB                 call    1A43h
F000:1EFD  [+0x09EFD]  C3                       ret
F000:1EFE  [+0x09EFE]  88 1E 0D 01              mov     [10Dh],bl
F000:1F02  [+0x09F02]  E8 3E FB                 call    1A43h
F000:1F05  [+0x09F05]  C3                       ret
F000:1F06  [+0x09F06]  88 1E 24 0C              mov     [0C24h],bl
F000:1F0A  [+0x09F0A]  C3                       ret
F000:1F0B  [+0x09F0B]  88 1E 0E 01              mov     [10Eh],bl
F000:1F0F  [+0x09F0F]  E8 31 FB                 call    1A43h
F000:1F12  [+0x09F12]  C3                       ret
F000:1F13  [+0x09F13]  B8 01 00                 mov     ax,1
F000:1F16  [+0x09F16]  BA F7 00                 mov     dx,0F7h
F000:1F19  [+0x09F19]  E8 1C F4                 call    1338h
F000:1F1C  [+0x09F1C]  C3                       ret
F000:1F1D  [+0x09F1D]  50                       push    ax
F000:1F1E  [+0x09F1E]  53                       push    bx
F000:1F1F  [+0x09F1F]  51                       push    cx
F000:1F20  [+0x09F20]  52                       push    dx
F000:1F21  [+0x09F21]  B0 B8                    mov     al,0B8h
F000:1F23  [+0x09F23]  E6 21                    out     21h,al
F000:1F25  [+0x09F25]  EB 00                    jmp     short 1F27h
F000:1F27  [+0x09F27]  EB 00                    jmp     short 1F29h
F000:1F29  [+0x09F29]  EB 00                    jmp     short 1F2Bh
F000:1F2B  [+0x09F2B]  EB 00                    jmp     short 1F2Dh
F000:1F2D  [+0x09F2D]  EB 00                    jmp     short 1F2Fh
F000:1F2F  [+0x09F2F]  EB 00                    jmp     short 1F31h
F000:1F31  [+0x09F31]  B0 1C                    mov     al,1Ch
F000:1F33  [+0x09F33]  E6 A1                    out     0A1h,al
F000:1F35  [+0x09F35]  EB 00                    jmp     short 1F37h
F000:1F37  [+0x09F37]  EB 00                    jmp     short 1F39h
F000:1F39  [+0x09F39]  EB 00                    jmp     short 1F3Bh
F000:1F3B  [+0x09F3B]  EB 00                    jmp     short 1F3Dh
F000:1F3D  [+0x09F3D]  EB 00                    jmp     short 1F3Fh
F000:1F3F  [+0x09F3F]  EB 00                    jmp     short 1F41h
F000:1F41  [+0x09F41]  BA 20 00                 mov     dx,20h
F000:1F44  [+0x09F44]  EC                       in      al,dx
F000:1F45  [+0x09F45]  EB 00                    jmp     short 1F47h
F000:1F47  [+0x09F47]  EB 00                    jmp     short 1F49h
F000:1F49  [+0x09F49]  EB 00                    jmp     short 1F4Bh
F000:1F4B  [+0x09F4B]  A8 FF                    test    al,0FFh
F000:1F4D  [+0x09F4D]  0F 85 54 00              jne     near 1FA5h
F000:1F51  [+0x09F51]  B0 61                    mov     al,61h
F000:1F53  [+0x09F53]  BA 80 00                 mov     dx,80h
F000:1F56  [+0x09F56]  EE                       out     dx,al
F000:1F57  [+0x09F57]  EB 00                    jmp     short 1F59h
F000:1F59  [+0x09F59]  EB 00                    jmp     short 1F5Bh
F000:1F5B  [+0x09F5B]  EB 00                    jmp     short 1F5Dh
F000:1F5D  [+0x09F5D]  90                       nop
F000:1F5E  [+0x09F5E]  90                       nop
F000:1F5F  [+0x09F5F]  90                       nop
F000:1F60  [+0x09F60]  90                       nop
F000:1F61  [+0x09F61]  90                       nop
F000:1F62  [+0x09F62]  90                       nop
F000:1F63  [+0x09F63]  90                       nop
F000:1F64  [+0x09F64]  90                       nop
F000:1F65  [+0x09F65]  90                       nop
F000:1F66  [+0x09F66]  90                       nop
F000:1F67  [+0x09F67]  90                       nop
F000:1F68  [+0x09F68]  90                       nop
F000:1F69  [+0x09F69]  90                       nop
F000:1F6A  [+0x09F6A]  90                       nop
F000:1F6B  [+0x09F6B]  90                       nop
F000:1F6C  [+0x09F6C]  90                       nop
F000:1F6D  [+0x09F6D]  90                       nop
F000:1F6E  [+0x09F6E]  90                       nop
F000:1F6F  [+0x09F6F]  90                       nop
F000:1F70  [+0x09F70]  90                       nop
F000:1F71  [+0x09F71]  B8 12 00                 mov     ax,12h
F000:1F74  [+0x09F74]  BA 20 00                 mov     dx,20h
F000:1F77  [+0x09F77]  E7 24                    out     24h,ax
F000:1F79  [+0x09F79]  EB 00                    jmp     short 1F7Bh
F000:1F7B  [+0x09F7B]  EB 00                    jmp     short 1F7Dh
F000:1F7D  [+0x09F7D]  93                       xchg    bx,ax
F000:1F7E  [+0x09F7E]  E5 26                    in      ax,26h
F000:1F80  [+0x09F80]  EB 00                    jmp     short 1F82h
F000:1F82  [+0x09F82]  EB 00                    jmp     short 1F84h
F000:1F84  [+0x09F84]  0D 20 00                 or      ax,20h
F000:1F87  [+0x09F87]  93                       xchg    bx,ax
F000:1F88  [+0x09F88]  E7 24                    out     24h,ax
F000:1F8A  [+0x09F8A]  EB 00                    jmp     short 1F8Ch
F000:1F8C  [+0x09F8C]  EB 00                    jmp     short 1F8Eh
F000:1F8E  [+0x09F8E]  93                       xchg    bx,ax
F000:1F8F  [+0x09F8F]  E7 26                    out     26h,ax
F000:1F91  [+0x09F91]  90                       nop
F000:1F92  [+0x09F92]  90                       nop
F000:1F93  [+0x09F93]  90                       nop
F000:1F94  [+0x09F94]  90                       nop
F000:1F95  [+0x09F95]  90                       nop
F000:1F96  [+0x09F96]  90                       nop
F000:1F97  [+0x09F97]  90                       nop
F000:1F98  [+0x09F98]  90                       nop
F000:1F99  [+0x09F99]  90                       nop
F000:1F9A  [+0x09F9A]  90                       nop
F000:1F9B  [+0x09F9B]  90                       nop
F000:1F9C  [+0x09F9C]  90                       nop
F000:1F9D  [+0x09F9D]  90                       nop
F000:1F9E  [+0x09F9E]  90                       nop
F000:1F9F  [+0x09F9F]  90                       nop
F000:1FA0  [+0x09FA0]  90                       nop
F000:1FA1  [+0x09FA1]  90                       nop
F000:1FA2  [+0x09FA2]  90                       nop
F000:1FA3  [+0x09FA3]  90                       nop
F000:1FA4  [+0x09FA4]  90                       nop
F000:1FA5  [+0x09FA5]  B0 62                    mov     al,62h
F000:1FA7  [+0x09FA7]  BA 80 00                 mov     dx,80h
F000:1FAA  [+0x09FAA]  EE                       out     dx,al
F000:1FAB  [+0x09FAB]  EB 00                    jmp     short 1FADh
F000:1FAD  [+0x09FAD]  EB 00                    jmp     short 1FAFh
F000:1FAF  [+0x09FAF]  EB 00                    jmp     short 1FB1h
F000:1FB1  [+0x09FB1]  5A                       pop     dx
F000:1FB2  [+0x09FB2]  59                       pop     cx
F000:1FB3  [+0x09FB3]  5B                       pop     bx
F000:1FB4  [+0x09FB4]  58                       pop     ax
F000:1FB5  [+0x09FB5]  C3                       ret
F000:1FB6  [+0x09FB6]  90                       nop
F000:1FB7  [+0x09FB7]  90                       nop
F000:1FB8  [+0x09FB8]  90                       nop
F000:1FB9  [+0x09FB9]  90                       nop
F000:1FBA  [+0x09FBA]  90                       nop
F000:1FBB  [+0x09FBB]  90                       nop
F000:1FBC  [+0x09FBC]  90                       nop
F000:1FBD  [+0x09FBD]  90                       nop
F000:1FBE  [+0x09FBE]  90                       nop
F000:1FBF  [+0x09FBF]  90                       nop
F000:1FC0  [+0x09FC0]  90                       nop
F000:1FC1  [+0x09FC1]  90                       nop
F000:1FC2  [+0x09FC2]  90                       nop
F000:1FC3  [+0x09FC3]  90                       nop
F000:1FC4  [+0x09FC4]  90                       nop
F000:1FC5  [+0x09FC5]  90                       nop
F000:1FC6  [+0x09FC6]  90                       nop
F000:1FC7  [+0x09FC7]  90                       nop
F000:1FC8  [+0x09FC8]  90                       nop
F000:1FC9  [+0x09FC9]  90                       nop
F000:1FCA  [+0x09FCA]  50                       push    ax
F000:1FCB  [+0x09FCB]  52                       push    dx
F000:1FCC  [+0x09FCC]  B8 12 00                 mov     ax,12h
F000:1FCF  [+0x09FCF]  BA 20 00                 mov     dx,20h
F000:1FD2  [+0x09FD2]  E8 6C F3                 call    1341h
F000:1FD5  [+0x09FD5]  5A                       pop     dx
F000:1FD6  [+0x09FD6]  58                       pop     ax
F000:1FD7  [+0x09FD7]  90                       nop
F000:1FD8  [+0x09FD8]  90                       nop
F000:1FD9  [+0x09FD9]  90                       nop
F000:1FDA  [+0x09FDA]  90                       nop
F000:1FDB  [+0x09FDB]  90                       nop
F000:1FDC  [+0x09FDC]  90                       nop
F000:1FDD  [+0x09FDD]  90                       nop
F000:1FDE  [+0x09FDE]  90                       nop
F000:1FDF  [+0x09FDF]  90                       nop
F000:1FE0  [+0x09FE0]  90                       nop
F000:1FE1  [+0x09FE1]  90                       nop
F000:1FE2  [+0x09FE2]  90                       nop
F000:1FE3  [+0x09FE3]  90                       nop
F000:1FE4  [+0x09FE4]  90                       nop
F000:1FE5  [+0x09FE5]  90                       nop
F000:1FE6  [+0x09FE6]  90                       nop
F000:1FE7  [+0x09FE7]  90                       nop
F000:1FE8  [+0x09FE8]  90                       nop
F000:1FE9  [+0x09FE9]  90                       nop
F000:1FEA  [+0x09FEA]  90                       nop
F000:1FEB  [+0x09FEB]  C3                       ret
F000:1FEC  [+0x09FEC]  E6 70                    out     70h,al
F000:1FEE  [+0x09FEE]  EB 00                    jmp     short 1FF0h
F000:1FF0  [+0x09FF0]  86 E0                    xchg    ah,al
F000:1FF2  [+0x09FF2]  E4 71                    in      al,71h
F000:1FF4  [+0x09FF4]  86 E0                    xchg    ah,al
F000:1FF6  [+0x09FF6]  C3                       ret
F000:1FF7  [+0x09FF7]  E8 F2 FF                 call    1FECh
F000:1FFA  [+0x09FFA]  E8 31 00                 call    202Eh
F000:1FFD  [+0x09FFD]  C3                       ret
F000:1FFE  [+0x09FFE]  E6 70                    out     70h,al
F000:2000  [+0x0A000]  EB 00                    jmp     short 2002h
F000:2002  [+0x0A002]  86 E0                    xchg    ah,al
F000:2004  [+0x0A004]  E6 71                    out     71h,al
F000:2006  [+0x0A006]  86 E0                    xchg    ah,al
F000:2008  [+0x0A008]  C3                       ret
F000:2009  [+0x0A009]  0A DB                    or      bl,bl
F000:200B  [+0x0A00B]  74 20                    je      short 202Dh
F000:200D  [+0x0A00D]  50                       push    ax
F000:200E  [+0x0A00E]  53                       push    bx
F000:200F  [+0x0A00F]  D0 EB                    shr     bl,1
F000:2011  [+0x0A011]  72 04                    jb      short 2017h
F000:2013  [+0x0A013]  D0 E4                    shl     ah,1
F000:2015  [+0x0A015]  EB F8                    jmp     short 200Fh
F000:2017  [+0x0A017]  5B                       pop     bx
F000:2018  [+0x0A018]  53                       push    bx
F000:2019  [+0x0A019]  8A FC                    mov     bh,ah
F000:201B  [+0x0A01B]  E8 CE FF                 call    1FECh
F000:201E  [+0x0A01E]  F6 D3                    not     bl
F000:2020  [+0x0A020]  22 E3                    and     ah,bl
F000:2022  [+0x0A022]  F6 D3                    not     bl
F000:2024  [+0x0A024]  22 FB                    and     bh,bl
F000:2026  [+0x0A026]  0A E7                    or      ah,bh
F000:2028  [+0x0A028]  E8 D3 FF                 call    1FFEh
F000:202B  [+0x0A02B]  5B                       pop     bx
F000:202C  [+0x0A02C]  58                       pop     ax
F000:202D  [+0x0A02D]  C3                       ret
F000:202E  [+0x0A02E]  53                       push    bx
F000:202F  [+0x0A02F]  22 E3                    and     ah,bl
F000:2031  [+0x0A031]  74 0A                    je      short 203Dh
F000:2033  [+0x0A033]  8A FC                    mov     bh,ah
F000:2035  [+0x0A035]  D1 EB                    shr     bx,1
F000:2037  [+0x0A037]  73 FC                    jae     short 2035h
F000:2039  [+0x0A039]  D1 E3                    shl     bx,1
F000:203B  [+0x0A03B]  8A E7                    mov     ah,bh
F000:203D  [+0x0A03D]  0A E4                    or      ah,ah
F000:203F  [+0x0A03F]  5B                       pop     bx
F000:2040  [+0x0A040]  C3                       ret
F000:2041  [+0x0A041]  50                       push    ax
F000:2042  [+0x0A042]  51                       push    cx
F000:2043  [+0x0A043]  B9 07 00                 mov     cx,7
F000:2046  [+0x0A046]  E4 61                    in      al,61h
F000:2048  [+0x0A048]  24 10                    and     al,10h
F000:204A  [+0x0A04A]  3A C4                    cmp     al,ah
F000:204C  [+0x0A04C]  74 F8                    je      short 2046h
F000:204E  [+0x0A04E]  8A E0                    mov     ah,al
F000:2050  [+0x0A050]  E2 F4                    loop    2046h
F000:2052  [+0x0A052]  59                       pop     cx
F000:2053  [+0x0A053]  58                       pop     ax
F000:2054  [+0x0A054]  C3                       ret
F000:2055  [+0x0A055]  60                       pusha
F000:2056  [+0x0A056]  33 C0                    xor     ax,ax
F000:2058  [+0x0A058]  EB 08                    jmp     short 2062h
F000:205A  [+0x0A05A]  2E FF 14                 call    word [cs:si]
F000:205D  [+0x0A05D]  15 00 00                 adc     ax,0
F000:2060  [+0x0A060]  46                       inc     si
F000:2061  [+0x0A061]  46                       inc     si
F000:2062  [+0x0A062]  2E 83 3C 00              cmp     word [cs:si],0
F000:2066  [+0x0A066]  75 F2                    jne     short 205Ah
F000:2068  [+0x0A068]  F7 D8                    neg     ax
F000:206A  [+0x0A06A]  61                       popa
F000:206B  [+0x0A06B]  C3                       ret
F000:206C  [+0x0A06C]  9C                       pushf
F000:206D  [+0x0A06D]  FA                       cli
F000:206E  [+0x0A06E]  50                       push    ax
F000:206F  [+0x0A06F]  51                       push    cx
F000:2070  [+0x0A070]  53                       push    bx
F000:2071  [+0x0A071]  B8 00 00                 mov     ax,0
F000:2074  [+0x0A074]  E8 6C F2                 call    12E3h
F000:2077  [+0x0A077]  53                       push    bx
F000:2078  [+0x0A078]  80 E3 88                 and     bl,88h
F000:207B  [+0x0A07B]  E8 6C F2                 call    12EAh
F000:207E  [+0x0A07E]  B9 F4 01                 mov     cx,1F4h
F000:2081  [+0x0A081]  E4 61                    in      al,61h
F000:2083  [+0x0A083]  8A E0                    mov     ah,al
F000:2085  [+0x0A085]  24 FC                    and     al,0FCh
F000:2087  [+0x0A087]  0C 02                    or      al,2
F000:2089  [+0x0A089]  E6 61                    out     61h,al
F000:208B  [+0x0A08B]  E8 19 00                 call    20A7h
F000:208E  [+0x0A08E]  24 FC                    and     al,0FCh
F000:2090  [+0x0A090]  E6 61                    out     61h,al
F000:2092  [+0x0A092]  E8 12 00                 call    20A7h
F000:2095  [+0x0A095]  E2 F0                    loop    2087h
F000:2097  [+0x0A097]  8A C4                    mov     al,ah
F000:2099  [+0x0A099]  E6 61                    out     61h,al
F000:209B  [+0x0A09B]  B8 00 00                 mov     ax,0
F000:209E  [+0x0A09E]  5B                       pop     bx
F000:209F  [+0x0A09F]  E8 48 F2                 call    12EAh
F000:20A2  [+0x0A0A2]  5B                       pop     bx
F000:20A3  [+0x0A0A3]  59                       pop     cx
F000:20A4  [+0x0A0A4]  58                       pop     ax
F000:20A5  [+0x0A0A5]  9D                       popf
F000:20A6  [+0x0A0A6]  C3                       ret
F000:20A7  [+0x0A0A7]  51                       push    cx
F000:20A8  [+0x0A0A8]  B9 F4 01                 mov     cx,1F4h
F000:20AB  [+0x0A0AB]  E2 FE                    loop    20ABh
F000:20AD  [+0x0A0AD]  59                       pop     cx
F000:20AE  [+0x0A0AE]  C3                       ret
F000:20AF  [+0x0A0AF]  9C                       pushf
F000:20B0  [+0x0A0B0]  FA                       cli
F000:20B1  [+0x0A0B1]  50                       push    ax
F000:20B2  [+0x0A0B2]  51                       push    cx
F000:20B3  [+0x0A0B3]  E8 B6 FF                 call    206Ch
F000:20B6  [+0x0A0B6]  FE C8                    dec     al
F000:20B8  [+0x0A0B8]  0F 84 0E 00              je      near 20CAh
F000:20BC  [+0x0A0BC]  51                       push    cx
F000:20BD  [+0x0A0BD]  B9 F4 01                 mov     cx,1F4h
F000:20C0  [+0x0A0C0]  D1 E1                    shl     cx,1
F000:20C2  [+0x0A0C2]  E8 E2 FF                 call    20A7h
F000:20C5  [+0x0A0C5]  E2 FB                    loop    20C2h
F000:20C7  [+0x0A0C7]  59                       pop     cx
F000:20C8  [+0x0A0C8]  EB E9                    jmp     short 20B3h
F000:20CA  [+0x0A0CA]  59                       pop     cx
F000:20CB  [+0x0A0CB]  58                       pop     ax
F000:20CC  [+0x0A0CC]  9D                       popf
F000:20CD  [+0x0A0CD]  C3                       ret
F000:20CE  [+0x0A0CE]  E8 79 F2                 call    134Ah
F000:20D1  [+0x0A0D1]  B8 0A EC                 mov     ax,0EC0Ah
F000:20D4  [+0x0A0D4]  BA CE 03                 mov     dx,3CEh
F000:20D7  [+0x0A0D7]  EF                       out     dx,ax
F000:20D8  [+0x0A0D8]  EB 00                    jmp     short 20DAh
F000:20DA  [+0x0A0DA]  EB 00                    jmp     short 20DCh
F000:20DC  [+0x0A0DC]  B0 92                    mov     al,92h
F000:20DE  [+0x0A0DE]  EE                       out     dx,al
F000:20DF  [+0x0A0DF]  EB 00                    jmp     short 20E1h
F000:20E1  [+0x0A0E1]  EB 00                    jmp     short 20E3h
F000:20E3  [+0x0A0E3]  FE C2                    inc     dl
F000:20E5  [+0x0A0E5]  EC                       in      al,dx
F000:20E6  [+0x0A0E6]  A2 17 01                 mov     [117h],al
F000:20E9  [+0x0A0E9]  4A                       dec     dx
F000:20EA  [+0x0A0EA]  B0 80                    mov     al,80h
F000:20EC  [+0x0A0EC]  EE                       out     dx,al
F000:20ED  [+0x0A0ED]  EB 00                    jmp     short 20EFh
F000:20EF  [+0x0A0EF]  EB 00                    jmp     short 20F1h
F000:20F1  [+0x0A0F1]  FE C2                    inc     dl
F000:20F3  [+0x0A0F3]  EC                       in      al,dx
F000:20F4  [+0x0A0F4]  A2 16 01                 mov     [116h],al
F000:20F7  [+0x0A0F7]  BA D4 03                 mov     dx,3D4h
F000:20FA  [+0x0A0FA]  EC                       in      al,dx
F000:20FB  [+0x0A0FB]  A2 13 01                 mov     [113h],al
F000:20FE  [+0x0A0FE]  B2 CE                    mov     dl,0CEh
F000:2100  [+0x0A100]  EC                       in      al,dx
F000:2101  [+0x0A101]  A2 14 01                 mov     [114h],al
F000:2104  [+0x0A104]  B2 C4                    mov     dl,0C4h
F000:2106  [+0x0A106]  EC                       in      al,dx
F000:2107  [+0x0A107]  A2 15 01                 mov     [115h],al
F000:210A  [+0x0A10A]  C3                       ret
F000:210B  [+0x0A10B]  E8 3C F2                 call    134Ah
F000:210E  [+0x0A10E]  BA D4 03                 mov     dx,3D4h
F000:2111  [+0x0A111]  A0 13 01                 mov     al,[113h]
F000:2114  [+0x0A114]  EE                       out     dx,al
F000:2115  [+0x0A115]  B2 CE                    mov     dl,0CEh
F000:2117  [+0x0A117]  A0 14 01                 mov     al,[114h]
F000:211A  [+0x0A11A]  EE                       out     dx,al
F000:211B  [+0x0A11B]  B2 C4                    mov     dl,0C4h
F000:211D  [+0x0A11D]  A0 15 01                 mov     al,[115h]
F000:2120  [+0x0A120]  EE                       out     dx,al
F000:2121  [+0x0A121]  B8 0A EC                 mov     ax,0EC0Ah
F000:2124  [+0x0A124]  BA CE 03                 mov     dx,3CEh
F000:2127  [+0x0A127]  EF                       out     dx,ax
F000:2128  [+0x0A128]  EB 00                    jmp     short 212Ah
F000:212A  [+0x0A12A]  EB 00                    jmp     short 212Ch
F000:212C  [+0x0A12C]  A0 16 01                 mov     al,[116h]
F000:212F  [+0x0A12F]  B4 80                    mov     ah,80h
F000:2131  [+0x0A131]  86 C4                    xchg    al,ah
F000:2133  [+0x0A133]  EF                       out     dx,ax
F000:2134  [+0x0A134]  A0 17 01                 mov     al,[117h]
F000:2137  [+0x0A137]  B4 92                    mov     ah,92h
F000:2139  [+0x0A139]  86 C4                    xchg    al,ah
F000:213B  [+0x0A13B]  EF                       out     dx,ax
F000:213C  [+0x0A13C]  C3                       ret
F000:213D  [+0x0A13D]  B8 06 00                 mov     ax,6
F000:2140  [+0x0A140]  BA 00 40                 mov     dx,4000h
F000:2143  [+0x0A143]  E8 F2 F1                 call    1338h
F000:2146  [+0x0A146]  B8 00 02                 mov     ax,200h
F000:2149  [+0x0A149]  BA 00 1F                 mov     dx,1F00h
F000:214C  [+0x0A14C]  E8 E9 F1                 call    1338h
F000:214F  [+0x0A14F]  80 3E 94 04 00           cmp     byte [494h],0
F000:2154  [+0x0A154]  0F 85 D5 01              jne     near 232Dh
F000:2158  [+0x0A158]  B8 00 00                 mov     ax,0
F000:215B  [+0x0A15B]  E8 85 F1                 call    12E3h
F000:215E  [+0x0A15E]  F7 C3 00 20              test    bx,2000h
F000:2162  [+0x0A162]  0F 85 73 01              jne     near 22D9h
F000:2166  [+0x0A166]  B8 09 00                 mov     ax,9
F000:2169  [+0x0A169]  E8 77 F1                 call    12E3h
F000:216C  [+0x0A16C]  F7 C3 80 00              test    bx,80h
F000:2170  [+0x0A170]  0F 84 A7 00              je      near 221Bh
F000:2174  [+0x0A174]  B8 12 00                 mov     ax,12h
F000:2177  [+0x0A177]  E8 69 F1                 call    12E3h
F000:217A  [+0x0A17A]  F7 C3 00 02              test    bx,200h
F000:217E  [+0x0A17E]  0F 84 03 00              je      near 2185h
F000:2182  [+0x0A182]  E9 95 01                 jmp     231Ah
F000:2185  [+0x0A185]  E8 18 04                 call    25A0h
F000:2188  [+0x0A188]  B8 50 5F                 mov     ax,5F50h
F000:218B  [+0x0A18B]  E8 AD 15                 call    373Bh
F000:218E  [+0x0A18E]  83 E2 0A                 and     dx,0Ah
F000:2191  [+0x0A191]  80 FA 02                 cmp     dl,2
F000:2194  [+0x0A194]  0F 85 50 00              jne     near 21E8h
F000:2198  [+0x0A198]  80 26 10 01 F7           and     byte [110h],0F7h
F000:219D  [+0x0A19D]  C6 06 94 04 00           mov     byte [494h],0
F000:21A2  [+0x0A1A2]  B8 11 00                 mov     ax,11h
F000:21A5  [+0x0A1A5]  BB 00 02                 mov     bx,200h
F000:21A8  [+0x0A1A8]  E8 3F F1                 call    12EAh
F000:21AB  [+0x0A1AB]  B8 02 00                 mov     ax,2
F000:21AE  [+0x0A1AE]  BA FF 13                 mov     dx,13FFh
F000:21B1  [+0x0A1B1]  E8 8D F1                 call    1341h
F000:21B4  [+0x0A1B4]  B8 06 00                 mov     ax,6
F000:21B7  [+0x0A1B7]  BB 83 43                 mov     bx,4383h
F000:21BA  [+0x0A1BA]  E8 2D F1                 call    12EAh
F000:21BD  [+0x0A1BD]  B8 03 00                 mov     ax,3
F000:21C0  [+0x0A1C0]  BB C0 2E                 mov     bx,2EC0h
F000:21C3  [+0x0A1C3]  E8 24 F1                 call    12EAh
F000:21C6  [+0x0A1C6]  E8 CC F0                 call    1295h
F000:21C9  [+0x0A1C9]  0F 83 09 00              jae     near 21D6h
F000:21CD  [+0x0A1CD]  B8 03 00                 mov     ax,3
F000:21D0  [+0x0A1D0]  BA 01 00                 mov     dx,1
F000:21D3  [+0x0A1D3]  E8 62 F1                 call    1338h
F000:21D6  [+0x0A1D6]  B8 01 00                 mov     ax,1
F000:21D9  [+0x0A1D9]  BA F7 00                 mov     dx,0F7h
F000:21DC  [+0x0A1DC]  E8 59 F1                 call    1338h
F000:21DF  [+0x0A1DF]  E8 79 16                 call    385Bh
F000:21E2  [+0x0A1E2]  E8 5E F8                 call    1A43h
F000:21E5  [+0x0A1E5]  EB 0A                    jmp     short 21F1h
F000:21E7  [+0x0A1E7]  90                       nop
F000:21E8  [+0x0A1E8]  B8 51 5F                 mov     ax,5F51h
F000:21EB  [+0x0A1EB]  BB 02 00                 mov     bx,2
F000:21EE  [+0x0A1EE]  E8 4A 15                 call    373Bh
F000:21F1  [+0x0A1F1]  E8 BF 03                 call    25B3h
F000:21F4  [+0x0A1F4]  B8 09 00                 mov     ax,9
F000:21F7  [+0x0A1F7]  BA 80 00                 mov     dx,80h
F000:21FA  [+0x0A1FA]  E8 44 F1                 call    1341h
F000:21FD  [+0x0A1FD]  B8 0A 00                 mov     ax,0Ah
F000:2200  [+0x0A200]  BA 80 00                 mov     dx,80h
F000:2203  [+0x0A203]  E8 3B F1                 call    1341h
F000:2206  [+0x0A206]  B8 0B 00                 mov     ax,0Bh
F000:2209  [+0x0A209]  BA 80 00                 mov     dx,80h
F000:220C  [+0x0A20C]  E8 32 F1                 call    1341h
F000:220F  [+0x0A20F]  B8 0C 00                 mov     ax,0Ch
F000:2212  [+0x0A212]  BA 80 00                 mov     dx,80h
F000:2215  [+0x0A215]  E8 29 F1                 call    1341h
F000:2218  [+0x0A218]  E9 BE 00                 jmp     22D9h
F000:221B  [+0x0A21B]  B8 12 00                 mov     ax,12h
F000:221E  [+0x0A21E]  E8 C2 F0                 call    12E3h
F000:2221  [+0x0A221]  F7 C3 00 02              test    bx,200h
F000:2225  [+0x0A225]  0F 85 40 00              jne     near 2269h
F000:2229  [+0x0A229]  8A 26 0F 01              mov     ah,[10Fh]
F000:222D  [+0x0A22D]  80 FC 00                 cmp     ah,0
F000:2230  [+0x0A230]  0F 84 A5 00              je      near 22D9h
F000:2234  [+0x0A234]  86 E0                    xchg    ah,al
F000:2236  [+0x0A236]  E6 80                    out     80h,al
F000:2238  [+0x0A238]  86 E0                    xchg    ah,al
F000:223A  [+0x0A23A]  80 FC 01                 cmp     ah,1
F000:223D  [+0x0A23D]  0F 84 0D 00              je      near 224Eh
F000:2241  [+0x0A241]  B8 01 00                 mov     ax,1
F000:2244  [+0x0A244]  BA 08 00                 mov     dx,8
F000:2247  [+0x0A247]  E8 A7 F0                 call    12F1h
F000:224A  [+0x0A24A]  0F 85 8B 00              jne     near 22D9h
F000:224E  [+0x0A24E]  B0 42                    mov     al,42h
F000:2250  [+0x0A250]  E8 99 FD                 call    1FECh
F000:2253  [+0x0A253]  F6 C4 03                 test    ah,3
F000:2256  [+0x0A256]  0F 84 9D 00              je      near 22F7h
F000:225A  [+0x0A25A]  B0 45                    mov     al,45h
F000:225C  [+0x0A25C]  E8 8D FD                 call    1FECh
F000:225F  [+0x0A25F]  F6 C4 07                 test    ah,7
F000:2262  [+0x0A262]  0F 84 73 00              je      near 22D9h
F000:2266  [+0x0A266]  E9 8E 00                 jmp     22F7h
F000:2269  [+0x0A269]  B8 50 5F                 mov     ax,5F50h
F000:226C  [+0x0A26C]  E8 CC 14                 call    373Bh
F000:226F  [+0x0A26F]  F7 C2 0A 00              test    dx,0Ah
F000:2273  [+0x0A273]  0F 84 62 00              je      near 22D9h
F000:2277  [+0x0A277]  F7 C2 08 00              test    dx,8
F000:227B  [+0x0A27B]  0F 85 27 00              jne     near 22A6h
F000:227F  [+0x0A27F]  B8 09 00                 mov     ax,9
F000:2282  [+0x0A282]  BA 80 00                 mov     dx,80h
F000:2285  [+0x0A285]  E8 B0 F0                 call    1338h
F000:2288  [+0x0A288]  B8 0A 00                 mov     ax,0Ah
F000:228B  [+0x0A28B]  BA 80 00                 mov     dx,80h
F000:228E  [+0x0A28E]  E8 A7 F0                 call    1338h
F000:2291  [+0x0A291]  B8 0B 00                 mov     ax,0Bh
F000:2294  [+0x0A294]  BA 80 00                 mov     dx,80h
F000:2297  [+0x0A297]  E8 9E F0                 call    1338h
F000:229A  [+0x0A29A]  B8 0C 00                 mov     ax,0Ch
F000:229D  [+0x0A29D]  BA 80 00                 mov     dx,80h
F000:22A0  [+0x0A2A0]  E8 95 F0                 call    1338h
F000:22A3  [+0x0A2A3]  EB 52                    jmp     short 22F7h
F000:22A5  [+0x0A2A5]  90                       nop
F000:22A6  [+0x0A2A6]  B8 09 00                 mov     ax,9
F000:22A9  [+0x0A2A9]  BA 80 00                 mov     dx,80h
F000:22AC  [+0x0A2AC]  E8 89 F0                 call    1338h
F000:22AF  [+0x0A2AF]  B8 0A 00                 mov     ax,0Ah
F000:22B2  [+0x0A2B2]  BA 80 00                 mov     dx,80h
F000:22B5  [+0x0A2B5]  E8 80 F0                 call    1338h
F000:22B8  [+0x0A2B8]  B8 0B 00                 mov     ax,0Bh
F000:22BB  [+0x0A2BB]  BA 80 00                 mov     dx,80h
F000:22BE  [+0x0A2BE]  E8 77 F0                 call    1338h
F000:22C1  [+0x0A2C1]  B8 0C 00                 mov     ax,0Ch
F000:22C4  [+0x0A2C4]  BA 80 00                 mov     dx,80h
F000:22C7  [+0x0A2C7]  E8 6E F0                 call    1338h
F000:22CA  [+0x0A2CA]  E8 D3 02                 call    25A0h
F000:22CD  [+0x0A2CD]  B8 51 5F                 mov     ax,5F51h
F000:22D0  [+0x0A2D0]  BB 00 00                 mov     bx,0
F000:22D3  [+0x0A2D3]  E8 65 14                 call    373Bh
F000:22D6  [+0x0A2D6]  E8 DA 02                 call    25B3h
F000:22D9  [+0x0A2D9]  C6 06 94 04 00           mov     byte [494h],0
F000:22DE  [+0x0A2DE]  B8 11 00                 mov     ax,11h
F000:22E1  [+0x0A2E1]  BB 00 02                 mov     bx,200h
F000:22E4  [+0x0A2E4]  E8 03 F0                 call    12EAh
F000:22E7  [+0x0A2E7]  B8 01 00                 mov     ax,1
F000:22EA  [+0x0A2EA]  BA F7 00                 mov     dx,0F7h
F000:22ED  [+0x0A2ED]  E8 48 F0                 call    1338h
F000:22F0  [+0x0A2F0]  E8 50 F7                 call    1A43h
F000:22F3  [+0x0A2F3]  E8 A9 F6                 call    199Fh
F000:22F6  [+0x0A2F6]  C3                       ret
F000:22F7  [+0x0A2F7]  C6 06 94 04 01           mov     byte [494h],1
F000:22FC  [+0x0A2FC]  B8 0D 00                 mov     ax,0Dh
F000:22FF  [+0x0A2FF]  BA 00 1C                 mov     dx,1C00h
F000:2302  [+0x0A302]  B3 04                    mov     bl,4
F000:2304  [+0x0A304]  E8 02 F0                 call    1309h
F000:2307  [+0x0A307]  B8 03 00                 mov     ax,3
F000:230A  [+0x0A30A]  BA 01 00                 mov     dx,1
F000:230D  [+0x0A30D]  E8 28 F0                 call    1338h
F000:2310  [+0x0A310]  B8 01 00                 mov     ax,1
F000:2313  [+0x0A313]  BA 00 1C                 mov     dx,1C00h
F000:2316  [+0x0A316]  E8 28 F0                 call    1341h
F000:2319  [+0x0A319]  C3                       ret
F000:231A  [+0x0A31A]  B8 51 5F                 mov     ax,5F51h
F000:231D  [+0x0A31D]  BB 02 01                 mov     bx,102h
F000:2320  [+0x0A320]  E8 18 14                 call    373Bh
F000:2323  [+0x0A323]  51                       push    cx
F000:2324  [+0x0A324]  B9 64 00                 mov     cx,64h
F000:2327  [+0x0A327]  E8 17 FD                 call    2041h
F000:232A  [+0x0A32A]  E2 FB                    loop    2327h
F000:232C  [+0x0A32C]  59                       pop     cx
F000:232D  [+0x0A32D]  52                       push    dx
F000:232E  [+0x0A32E]  50                       push    ax
F000:232F  [+0x0A32F]  E8 0E 18                 call    3B40h
F000:2332  [+0x0A332]  58                       pop     ax
F000:2333  [+0x0A333]  5A                       pop     dx
F000:2334  [+0x0A334]  0F 84 08 00              je      near 2340h
F000:2338  [+0x0A338]  C6 06 94 04 00           mov     byte [494h],0
F000:233D  [+0x0A33D]  E9 C3 EA                 jmp     0E03h
F000:2340  [+0x0A340]  E8 9B E3                 call    06DEh
F000:2343  [+0x0A343]  E8 27 E7                 call    0A6Dh
F000:2346  [+0x0A346]  B8 06 00                 mov     ax,6
F000:2349  [+0x0A349]  E8 97 EF                 call    12E3h
F000:234C  [+0x0A34C]  89 1E 27 01              mov     [127h],bx
F000:2350  [+0x0A350]  B8 06 00                 mov     ax,6
F000:2353  [+0x0A353]  BA 43 08                 mov     dx,843h
F000:2356  [+0x0A356]  E8 DF EF                 call    1338h
F000:2359  [+0x0A359]  B8 06 00                 mov     ax,6
F000:235C  [+0x0A35C]  BA 80 00                 mov     dx,80h
F000:235F  [+0x0A35F]  E8 D6 EF                 call    1338h
F000:2362  [+0x0A362]  B8 06 00                 mov     ax,6
F000:2365  [+0x0A365]  BA 00 40                 mov     dx,4000h
F000:2368  [+0x0A368]  E8 CD EF                 call    1338h
F000:236B  [+0x0A36B]  B8 01 00                 mov     ax,1
F000:236E  [+0x0A36E]  BA 00 1C                 mov     dx,1C00h
F000:2371  [+0x0A371]  E8 CD EF                 call    1341h
F000:2374  [+0x0A374]  B8 11 00                 mov     ax,11h
F000:2377  [+0x0A377]  BB 00 02                 mov     bx,200h
F000:237A  [+0x0A37A]  E8 6D EF                 call    12EAh
F000:237D  [+0x0A37D]  B8 09 00                 mov     ax,9
F000:2380  [+0x0A380]  BA 00 02                 mov     dx,200h
F000:2383  [+0x0A383]  E8 BB EF                 call    1341h
F000:2386  [+0x0A386]  B8 0C 00                 mov     ax,0Ch
F000:2389  [+0x0A389]  BA 00 02                 mov     dx,200h
F000:238C  [+0x0A38C]  E8 B2 EF                 call    1341h
F000:238F  [+0x0A38F]  80 3E 10 01 03           cmp     byte [110h],3
F000:2394  [+0x0A394]  0F 84 05 00              je      near 239Dh
F000:2398  [+0x0A398]  C6 06 10 01 00           mov     byte [110h],0
F000:239D  [+0x0A39D]  C6 06 94 04 00           mov     byte [494h],0
F000:23A2  [+0x0A3A2]  56                       push    si
F000:23A3  [+0x0A3A3]  57                       push    di
F000:23A4  [+0x0A3A4]  FC                       cld
F000:23A5  [+0x0A3A5]  8C 0E 8A 02              mov     [28Ah],cs
F000:23A9  [+0x0A3A9]  E8 F4 01                 call    25A0h
F000:23AC  [+0x0A3AC]  BE 29 01                 mov     si,129h
F000:23AF  [+0x0A3AF]  E8 99 03                 call    274Bh
F000:23B2  [+0x0A3B2]  0F 82 43 01              jb      near 24F9h
F000:23B6  [+0x0A3B6]  B8 00 DC                 mov     ax,0DC00h
F000:23B9  [+0x0A3B9]  8E D8                    mov     ds,ax
F000:23BB  [+0x0A3BB]  8E D0                    mov     ss,ax
F000:23BD  [+0x0A3BD]  BC 00 30                 mov     sp,3000h
F000:23C0  [+0x0A3C0]  E4 80                    in      al,80h
F000:23C2  [+0x0A3C2]  A2 1C 01                 mov     [11Ch],al
F000:23C5  [+0x0A3C5]  B8 0D 00                 mov     ax,0Dh
F000:23C8  [+0x0A3C8]  BA FE 1F                 mov     dx,1FFEh
F000:23CB  [+0x0A3CB]  E8 23 EF                 call    12F1h
F000:23CE  [+0x0A3CE]  89 1E 1D 01              mov     [11Dh],bx
F000:23D2  [+0x0A3D2]  BB 00 00                 mov     bx,0
F000:23D5  [+0x0A3D5]  E8 31 EF                 call    1309h
F000:23D8  [+0x0A3D8]  1E                       push    ds
F000:23D9  [+0x0A3D9]  B8 80 DF                 mov     ax,0DF80h
F000:23DC  [+0x0A3DC]  8E D8                    mov     ds,ax
F000:23DE  [+0x0A3DE]  C6 06 30 00 00           mov     byte [30h],0
F000:23E3  [+0x0A3E3]  1F                       pop     ds
F000:23E4  [+0x0A3E4]  B8 86 00                 mov     ax,86h
F000:23E7  [+0x0A3E7]  E8 F9 EE                 call    12E3h
F000:23EA  [+0x0A3EA]  88 1E 25 01              mov     [125h],bl
F000:23EE  [+0x0A3EE]  B0 0B                    mov     al,0Bh
F000:23F0  [+0x0A3F0]  E8 F9 FB                 call    1FECh
F000:23F3  [+0x0A3F3]  88 26 26 01              mov     [126h],ah
F000:23F7  [+0x0A3F7]  80 E4 8F                 and     ah,8Fh
F000:23FA  [+0x0A3FA]  E8 01 FC                 call    1FFEh
F000:23FD  [+0x0A3FD]  BE 1C 05                 mov     si,51Ch
F000:2400  [+0x0A400]  BA 4C 10                 mov     dx,104Ch
F000:2403  [+0x0A403]  E8 7B 31                 call    5581h
F000:2406  [+0x0A406]  74 03                    je      short 240Bh
F000:2408  [+0x0A408]  BE 3A 05                 mov     si,53Ah
F000:240B  [+0x0A40B]  E8 47 FC                 call    2055h
F000:240E  [+0x0A40E]  33 C0                    xor     ax,ax
F000:2410  [+0x0A410]  8E C0                    mov     es,ax
F000:2412  [+0x0A412]  26 66 A1 72 04           mov     eax,[es:472h]
F000:2417  [+0x0A417]  66 A3 1F 01              mov     [11Fh],eax
F000:241B  [+0x0A41B]  B8 78 24                 mov     ax,2478h
F000:241E  [+0x0A41E]  26 A3 72 04              mov     [es:472h],ax
F000:2422  [+0x0A422]  26 8C 0E 74 04           mov     [es:474h],cs
F000:2427  [+0x0A427]  8C 16 18 01              mov     [118h],ss
F000:242B  [+0x0A42B]  89 26 1A 01              mov     [11Ah],sp
F000:242F  [+0x0A42F]  1E                       push    ds
F000:2430  [+0x0A430]  06                       push    es
F000:2431  [+0x0A431]  8C D8                    mov     ax,ds
F000:2433  [+0x0A433]  8E C0                    mov     es,ax
F000:2435  [+0x0A435]  B8 00 30                 mov     ax,3000h
F000:2438  [+0x0A438]  8E D8                    mov     ds,ax
F000:243A  [+0x0A43A]  BE 00 FE                 mov     si,0FE00h
F000:243D  [+0x0A43D]  BF 8C 02                 mov     di,28Ch
F000:2440  [+0x0A440]  B9 00 01                 mov     cx,100h
F000:2443  [+0x0A443]  FC                       cld
F000:2444  [+0x0A444]  F3 A5                    rep movsw
F000:2446  [+0x0A446]  BE 00 80                 mov     si,8000h
F000:2449  [+0x0A449]  BF 8C 04                 mov     di,48Ch
F000:244C  [+0x0A44C]  B9 04 00                 mov     cx,4
F000:244F  [+0x0A44F]  F3 A5                    rep movsw
F000:2451  [+0x0A451]  07                       pop     es
F000:2452  [+0x0A452]  1F                       pop     ds
F000:2453  [+0x0A453]  E8 CA F0                 call    1520h
F000:2456  [+0x0A456]  E8 C5 2D                 call    521Eh
F000:2459  [+0x0A459]  E8 23 25                 call    497Fh
F000:245C  [+0x0A45C]  B8 01 00                 mov     ax,1
F000:245F  [+0x0A45F]  E7 24                    out     24h,ax
F000:2461  [+0x0A461]  EB 00                    jmp     short 2463h
F000:2463  [+0x0A463]  EB 00                    jmp     short 2465h
F000:2465  [+0x0A465]  E5 26                    in      ax,26h
F000:2467  [+0x0A467]  EB 00                    jmp     short 2469h
F000:2469  [+0x0A469]  EB 00                    jmp     short 246Bh
F000:246B  [+0x0A46B]  80 E4 1F                 and     ah,1Fh
F000:246E  [+0x0A46E]  80 CC A0                 or      ah,0A0h
F000:2471  [+0x0A471]  E7 26                    out     26h,ax
F000:2473  [+0x0A473]  EB 00                    jmp     short 2475h
F000:2475  [+0x0A475]  EB 00                    jmp     short 2477h
F000:2477  [+0x0A477]  F4                       hlt
F000:2478  [+0x0A478]  FA                       cli
F000:2479  [+0x0A479]  FC                       cld
F000:247A  [+0x0A47A]  B8 00 DC                 mov     ax,0DC00h
F000:247D  [+0x0A47D]  8E D8                    mov     ds,ax
F000:247F  [+0x0A47F]  8E 16 18 01              mov     ss,[118h]
F000:2483  [+0x0A483]  8B 26 1A 01              mov     sp,[11Ah]
F000:2487  [+0x0A487]  E9 B0 F0                 jmp     153Ah
F000:248A  [+0x0A48A]  B8 00 DC                 mov     ax,0DC00h
F000:248D  [+0x0A48D]  8E D8                    mov     ds,ax
F000:248F  [+0x0A48F]  8E 16 18 01              mov     ss,[118h]
F000:2493  [+0x0A493]  8B 26 1A 01              mov     sp,[11Ah]
F000:2497  [+0x0A497]  A0 1C 01                 mov     al,[11Ch]
F000:249A  [+0x0A49A]  E6 80                    out     80h,al
F000:249C  [+0x0A49C]  B8 00 30                 mov     ax,3000h
F000:249F  [+0x0A49F]  8E C0                    mov     es,ax
F000:24A1  [+0x0A4A1]  BF 00 FE                 mov     di,0FE00h
F000:24A4  [+0x0A4A4]  BE 8C 02                 mov     si,28Ch
F000:24A7  [+0x0A4A7]  B9 00 01                 mov     cx,100h
F000:24AA  [+0x0A4AA]  FC                       cld
F000:24AB  [+0x0A4AB]  F3 A5                    rep movsw
F000:24AD  [+0x0A4AD]  BF 00 80                 mov     di,8000h
F000:24B0  [+0x0A4B0]  BE 8C 04                 mov     si,48Ch
F000:24B3  [+0x0A4B3]  B9 04 00                 mov     cx,4
F000:24B6  [+0x0A4B6]  F3 A5                    rep movsw
F000:24B8  [+0x0A4B8]  33 C0                    xor     ax,ax
F000:24BA  [+0x0A4BA]  8E C0                    mov     es,ax
F000:24BC  [+0x0A4BC]  66 A1 1F 01              mov     eax,[11Fh]
F000:24C0  [+0x0A4C0]  26 66 A3 72 04           mov     [es:472h],eax
F000:24C5  [+0x0A4C5]  B8 01 00                 mov     ax,1
F000:24C8  [+0x0A4C8]  BA 00 01                 mov     dx,100h
F000:24CB  [+0x0A4CB]  E8 73 EE                 call    1341h
F000:24CE  [+0x0A4CE]  E8 EF 00                 call    25C0h
F000:24D1  [+0x0A4D1]  E8 53 01                 call    2627h
F000:24D4  [+0x0A4D4]  BE 2A 05                 mov     si,52Ah
F000:24D7  [+0x0A4D7]  E8 52 30                 call    552Ch
F000:24DA  [+0x0A4DA]  74 03                    je      short 24DFh
F000:24DC  [+0x0A4DC]  BE 42 05                 mov     si,542h
F000:24DF  [+0x0A4DF]  E8 73 FB                 call    2055h
F000:24E2  [+0x0A4E2]  50                       push    ax
F000:24E3  [+0x0A4E3]  B0 CD                    mov     al,0CDh
F000:24E5  [+0x0A4E5]  E6 80                    out     80h,al
F000:24E7  [+0x0A4E7]  58                       pop     ax
F000:24E8  [+0x0A4E8]  FA                       cli
F000:24E9  [+0x0A4E9]  B8 0D 00                 mov     ax,0Dh
F000:24EC  [+0x0A4EC]  BA FE 1F                 mov     dx,1FFEh
F000:24EF  [+0x0A4EF]  8B 1E 1D 01              mov     bx,[11Dh]
F000:24F3  [+0x0A4F3]  E8 13 EE                 call    1309h
F000:24F6  [+0x0A4F6]  E8 73 FB                 call    206Ch
F000:24F9  [+0x0A4F9]  BE 29 01                 mov     si,129h
F000:24FC  [+0x0A4FC]  E8 A9 02                 call    27A8h
F000:24FF  [+0x0A4FF]  5F                       pop     di
F000:2500  [+0x0A500]  5E                       pop     si
F000:2501  [+0x0A501]  E8 AF 00                 call    25B3h
F000:2504  [+0x0A504]  E8 82 E5                 call    0A89h
F000:2507  [+0x0A507]  E8 9C E2                 call    07A6h
F000:250A  [+0x0A50A]  B8 0E 00                 mov     ax,0Eh
F000:250D  [+0x0A50D]  BA 01 00                 mov     dx,1
F000:2510  [+0x0A510]  E8 25 EE                 call    1338h
F000:2513  [+0x0A513]  B8 01 00                 mov     ax,1
F000:2516  [+0x0A516]  BA F7 00                 mov     dx,0F7h
F000:2519  [+0x0A519]  E8 1C EE                 call    1338h
F000:251C  [+0x0A51C]  E8 24 F5                 call    1A43h
F000:251F  [+0x0A51F]  E8 7D F4                 call    199Fh
F000:2522  [+0x0A522]  B0 0B                    mov     al,0Bh
F000:2524  [+0x0A524]  8A 26 26 01              mov     ah,[126h]
F000:2528  [+0x0A528]  E8 D3 FA                 call    1FFEh
F000:252B  [+0x0A52B]  B0 0C                    mov     al,0Ch
F000:252D  [+0x0A52D]  E8 BC FA                 call    1FECh
F000:2530  [+0x0A530]  B8 06 00                 mov     ax,6
F000:2533  [+0x0A533]  8B 1E 27 01              mov     bx,[127h]
F000:2537  [+0x0A537]  E8 B0 ED                 call    12EAh
F000:253A  [+0x0A53A]  1E                       push    ds
F000:253B  [+0x0A53B]  B8 00 DC                 mov     ax,0DC00h
F000:253E  [+0x0A53E]  8E D8                    mov     ds,ax
F000:2540  [+0x0A540]  A0 25 01                 mov     al,[125h]
F000:2543  [+0x0A543]  E6 70                    out     70h,al
F000:2545  [+0x0A545]  1F                       pop     ds
F000:2546  [+0x0A546]  B0 42                    mov     al,42h
F000:2548  [+0x0A548]  E8 A1 FA                 call    1FECh
F000:254B  [+0x0A54B]  F6 C4 03                 test    ah,3
F000:254E  [+0x0A54E]  0F 85 09 00              jne     near 255Bh
F000:2552  [+0x0A552]  B8 0D 00                 mov     ax,0Dh
F000:2555  [+0x0A555]  BB 00 00                 mov     bx,0
F000:2558  [+0x0A558]  E8 8F ED                 call    12EAh
F000:255B  [+0x0A55B]  E8 91 04                 call    29EFh
F000:255E  [+0x0A55E]  C6 06 11 01 01           mov     byte [111h],1
F000:2563  [+0x0A563]  B8 09 00                 mov     ax,9
F000:2566  [+0x0A566]  BA 80 00                 mov     dx,80h
F000:2569  [+0x0A569]  E8 D5 ED                 call    1341h
F000:256C  [+0x0A56C]  B8 0A 00                 mov     ax,0Ah
F000:256F  [+0x0A56F]  BA 80 00                 mov     dx,80h
F000:2572  [+0x0A572]  E8 CC ED                 call    1341h
F000:2575  [+0x0A575]  B8 0B 00                 mov     ax,0Bh
F000:2578  [+0x0A578]  BA 80 00                 mov     dx,80h
F000:257B  [+0x0A57B]  E8 C3 ED                 call    1341h
F000:257E  [+0x0A57E]  B8 0C 00                 mov     ax,0Ch
F000:2581  [+0x0A581]  BA 80 00                 mov     dx,80h
F000:2584  [+0x0A584]  E8 BA ED                 call    1341h
F000:2587  [+0x0A587]  B8 09 00                 mov     ax,9
F000:258A  [+0x0A58A]  BA 00 02                 mov     dx,200h
F000:258D  [+0x0A58D]  E8 A8 ED                 call    1338h
F000:2590  [+0x0A590]  B8 0C 00                 mov     ax,0Ch
F000:2593  [+0x0A593]  BA 00 02                 mov     dx,200h
F000:2596  [+0x0A596]  E8 9F ED                 call    1338h
F000:2599  [+0x0A599]  50                       push    ax
F000:259A  [+0x0A59A]  B0 CF                    mov     al,0CFh
F000:259C  [+0x0A59C]  E6 80                    out     80h,al
F000:259E  [+0x0A59E]  58                       pop     ax
F000:259F  [+0x0A59F]  C3                       ret
F000:25A0  [+0x0A5A0]  50                       push    ax
F000:25A1  [+0x0A5A1]  E4 21                    in      al,21h
F000:25A3  [+0x0A5A3]  A2 23 01                 mov     [123h],al
F000:25A6  [+0x0A5A6]  E4 A1                    in      al,0A1h
F000:25A8  [+0x0A5A8]  A2 24 01                 mov     [124h],al
F000:25AB  [+0x0A5AB]  B0 FF                    mov     al,0FFh
F000:25AD  [+0x0A5AD]  E6 21                    out     21h,al
F000:25AF  [+0x0A5AF]  E6 A1                    out     0A1h,al
F000:25B1  [+0x0A5B1]  58                       pop     ax
F000:25B2  [+0x0A5B2]  C3                       ret
F000:25B3  [+0x0A5B3]  50                       push    ax
F000:25B4  [+0x0A5B4]  A0 23 01                 mov     al,[123h]
F000:25B7  [+0x0A5B7]  E6 21                    out     21h,al
F000:25B9  [+0x0A5B9]  A0 24 01                 mov     al,[124h]
F000:25BC  [+0x0A5BC]  E6 A1                    out     0A1h,al
F000:25BE  [+0x0A5BE]  58                       pop     ax
F000:25BF  [+0x0A5BF]  C3                       ret
F000:25C0  [+0x0A5C0]  50                       push    ax
F000:25C1  [+0x0A5C1]  1E                       push    ds
F000:25C2  [+0x0A5C2]  B8 00 DC                 mov     ax,0DC00h
F000:25C5  [+0x0A5C5]  8E D8                    mov     ds,ax
F000:25C7  [+0x0A5C7]  B0 11                    mov     al,11h
F000:25C9  [+0x0A5C9]  E6 A0                    out     0A0h,al
F000:25CB  [+0x0A5CB]  E6 20                    out     20h,al
F000:25CD  [+0x0A5CD]  A0 5B 14                 mov     al,[145Bh]
F000:25D0  [+0x0A5D0]  E6 A1                    out     0A1h,al
F000:25D2  [+0x0A5D2]  A0 5A 14                 mov     al,[145Ah]
F000:25D5  [+0x0A5D5]  E6 21                    out     21h,al
F000:25D7  [+0x0A5D7]  B0 02                    mov     al,2
F000:25D9  [+0x0A5D9]  E6 A1                    out     0A1h,al
F000:25DB  [+0x0A5DB]  B0 04                    mov     al,4
F000:25DD  [+0x0A5DD]  E6 21                    out     21h,al
F000:25DF  [+0x0A5DF]  B0 01                    mov     al,1
F000:25E1  [+0x0A5E1]  E6 A1                    out     0A1h,al
F000:25E3  [+0x0A5E3]  E6 21                    out     21h,al
F000:25E5  [+0x0A5E5]  B0 FF                    mov     al,0FFh
F000:25E7  [+0x0A5E7]  E6 21                    out     21h,al
F000:25E9  [+0x0A5E9]  E6 A1                    out     0A1h,al
F000:25EB  [+0x0A5EB]  1F                       pop     ds
F000:25EC  [+0x0A5EC]  58                       pop     ax
F000:25ED  [+0x0A5ED]  C3                       ret
F000:25EE  [+0x0A5EE]  50                       push    ax
F000:25EF  [+0x0A5EF]  53                       push    bx
F000:25F0  [+0x0A5F0]  52                       push    dx
F000:25F1  [+0x0A5F1]  FA                       cli
F000:25F2  [+0x0A5F2]  50                       push    ax
F000:25F3  [+0x0A5F3]  B0 55                    mov     al,55h
F000:25F5  [+0x0A5F5]  E6 80                    out     80h,al
F000:25F7  [+0x0A5F7]  58                       pop     ax
F000:25F8  [+0x0A5F8]  B9 00 03                 mov     cx,300h
F000:25FB  [+0x0A5FB]  B8 02 00                 mov     ax,2
F000:25FE  [+0x0A5FE]  BA FF 03                 mov     dx,3FFh
F000:2601  [+0x0A601]  BB 00 00                 mov     bx,0
F000:2604  [+0x0A604]  E8 02 ED                 call    1309h
F000:2607  [+0x0A607]  B8 02 00                 mov     ax,2
F000:260A  [+0x0A60A]  BA FF 03                 mov     dx,3FFh
F000:260D  [+0x0A60D]  E8 E1 EC                 call    12F1h
F000:2610  [+0x0A610]  F7 C3 FF 03              test    bx,3FFh
F000:2614  [+0x0A614]  E1 F1                    loope   2607h
F000:2616  [+0x0A616]  75 09                    jne     short 2621h
F000:2618  [+0x0A618]  9C                       pushf
F000:2619  [+0x0A619]  E8 25 FA                 call    2041h
F000:261C  [+0x0A61C]  9D                       popf
F000:261D  [+0x0A61D]  5A                       pop     dx
F000:261E  [+0x0A61E]  5B                       pop     bx
F000:261F  [+0x0A61F]  58                       pop     ax
F000:2620  [+0x0A620]  C3                       ret
F000:2621  [+0x0A621]  9C                       pushf
F000:2622  [+0x0A622]  9D                       popf
F000:2623  [+0x0A623]  5A                       pop     dx
F000:2624  [+0x0A624]  5B                       pop     bx
F000:2625  [+0x0A625]  58                       pop     ax
F000:2626  [+0x0A626]  C3                       ret
F000:2627  [+0x0A627]  BA 0B 00                 mov     dx,0Bh
F000:262A  [+0x0A62A]  B0 40                    mov     al,40h
F000:262C  [+0x0A62C]  B9 04 00                 mov     cx,4
F000:262F  [+0x0A62F]  EB 00                    jmp     short 2631h
F000:2631  [+0x0A631]  EB 00                    jmp     short 2633h
F000:2633  [+0x0A633]  EE                       out     dx,al
F000:2634  [+0x0A634]  FE C0                    inc     al
F000:2636  [+0x0A636]  E2 F7                    loop    262Fh
F000:2638  [+0x0A638]  80 C2 CB                 add     dl,0CBh
F000:263B  [+0x0A63B]  73 ED                    jae     short 262Ah
F000:263D  [+0x0A63D]  B0 C0                    mov     al,0C0h
F000:263F  [+0x0A63F]  E6 D6                    out     0D6h,al
F000:2641  [+0x0A641]  EB 00                    jmp     short 2643h
F000:2643  [+0x0A643]  EB 00                    jmp     short 2645h
F000:2645  [+0x0A645]  B0 00                    mov     al,0
F000:2647  [+0x0A647]  E6 D4                    out     0D4h,al
F000:2649  [+0x0A649]  EB 00                    jmp     short 264Bh
F000:264B  [+0x0A64B]  EB 00                    jmp     short 264Dh
F000:264D  [+0x0A64D]  C3                       ret
F000:264E  [+0x0A64E]  E8 4F FF                 call    25A0h
F000:2651  [+0x0A651]  E4 80                    in      al,80h
F000:2653  [+0x0A653]  A2 1C 01                 mov     [11Ch],al
F000:2656  [+0x0A656]  50                       push    ax
F000:2657  [+0x0A657]  B0 55                    mov     al,55h
F000:2659  [+0x0A659]  E6 80                    out     80h,al
F000:265B  [+0x0A65B]  58                       pop     ax
F000:265C  [+0x0A65C]  E8 0E 00                 call    266Dh
F000:265F  [+0x0A65F]  FA                       cli
F000:2660  [+0x0A660]  E8 50 FF                 call    25B3h
F000:2663  [+0x0A663]  E8 39 F3                 call    199Fh
F000:2666  [+0x0A666]  50                       push    ax
F000:2667  [+0x0A667]  B0 56                    mov     al,56h
F000:2669  [+0x0A669]  E6 80                    out     80h,al
F000:266B  [+0x0A66B]  58                       pop     ax
F000:266C  [+0x0A66C]  C3                       ret
F000:266D  [+0x0A66D]  1E                       push    ds
F000:266E  [+0x0A66E]  06                       push    es
F000:266F  [+0x0A66F]  B8 00 60                 mov     ax,6000h
F000:2672  [+0x0A672]  8E D8                    mov     ds,ax
F000:2674  [+0x0A674]  8E C0                    mov     es,ax
F000:2676  [+0x0A676]  BE 00 FE                 mov     si,0FE00h
F000:2679  [+0x0A679]  BF 00 92                 mov     di,9200h
F000:267C  [+0x0A67C]  B9 00 01                 mov     cx,100h
F000:267F  [+0x0A67F]  FC                       cld
F000:2680  [+0x0A680]  F3 A5                    rep movsw
F000:2682  [+0x0A682]  BE 00 90                 mov     si,9000h
F000:2685  [+0x0A685]  C7 84 F0 01 C3 26        mov     word [si+1F0h],26C3h
F000:268B  [+0x0A68B]  BF 00 FE                 mov     di,0FE00h
F000:268E  [+0x0A68E]  B9 00 01                 mov     cx,100h
F000:2691  [+0x0A691]  FC                       cld
F000:2692  [+0x0A692]  F3 A5                    rep movsw
F000:2694  [+0x0A694]  B8 86 00                 mov     ax,86h
F000:2697  [+0x0A697]  E8 49 EC                 call    12E3h
F000:269A  [+0x0A69A]  88 1E 00 96              mov     [9600h],bl
F000:269E  [+0x0A69E]  66 50                    push    eax
F000:26A0  [+0x0A6A0]  1E                       push    ds
F000:26A1  [+0x0A6A1]  B8 40 00                 mov     ax,40h
F000:26A4  [+0x0A6A4]  8E D8                    mov     ds,ax
F000:26A6  [+0x0A6A6]  66 A1 B6 00              mov     eax,[0B6h]
F000:26AA  [+0x0A6AA]  1F                       pop     ds
F000:26AB  [+0x0A6AB]  66 A3 01 96              mov     [9601h],eax
F000:26AF  [+0x0A6AF]  66 58                    pop     eax
F000:26B1  [+0x0A6B1]  C7 06 01 80 40 27        mov     word [8001h],2740h
F000:26B7  [+0x0A6B7]  8C 16 05 96              mov     [9605h],ss
F000:26BB  [+0x0A6BB]  89 26 07 96              mov     [9607h],sp
F000:26BF  [+0x0A6BF]  0F 08                    invd
F000:26C1  [+0x0A6C1]  0F AA                    rsm
F000:26C3  [+0x0A6C3]  B8 00 DC                 mov     ax,0DC00h
F000:26C6  [+0x0A6C6]  8E D8                    mov     ds,ax
F000:26C8  [+0x0A6C8]  FA                       cli
F000:26C9  [+0x0A6C9]  8E D0                    mov     ss,ax
F000:26CB  [+0x0A6CB]  BC 00 40                 mov     sp,4000h
F000:26CE  [+0x0A6CE]  E8 A9 EC                 call    137Ah
F000:26D1  [+0x0A6D1]  E8 7C DE                 call    0550h
F000:26D4  [+0x0A6D4]  E8 95 EC                 call    136Ch
F000:26D7  [+0x0A6D7]  B8 00 60                 mov     ax,6000h
F000:26DA  [+0x0A6DA]  8E D8                    mov     ds,ax
F000:26DC  [+0x0A6DC]  C7 06 01 80 F9 26        mov     word [8001h],26F9h
F000:26E2  [+0x0A6E2]  E8 95 EC                 call    137Ah
F000:26E5  [+0x0A6E5]  B8 01 00                 mov     ax,1
F000:26E8  [+0x0A6E8]  BA F0 00                 mov     dx,0F0h
F000:26EB  [+0x0A6EB]  E8 4A EC                 call    1338h
F000:26EE  [+0x0A6EE]  B8 06 00                 mov     ax,6
F000:26F1  [+0x0A6F1]  BA 00 10                 mov     dx,1000h
F000:26F4  [+0x0A6F4]  E8 41 EC                 call    1338h
F000:26F7  [+0x0A6F7]  EB FE                    jmp     short 26F7h
F000:26F9  [+0x0A6F9]  B8 00 60                 mov     ax,6000h
F000:26FC  [+0x0A6FC]  8E D8                    mov     ds,ax
F000:26FE  [+0x0A6FE]  8E C0                    mov     es,ax
F000:2700  [+0x0A700]  8E 16 05 96              mov     ss,[9605h]
F000:2704  [+0x0A704]  8B 26 07 96              mov     sp,[9607h]
F000:2708  [+0x0A708]  A0 00 96                 mov     al,[9600h]
F000:270B  [+0x0A70B]  E6 70                    out     70h,al
F000:270D  [+0x0A70D]  C7 06 01 80 D7 14        mov     word [8001h],14D7h
F000:2713  [+0x0A713]  BE 00 92                 mov     si,9200h
F000:2716  [+0x0A716]  BF 00 FE                 mov     di,0FE00h
F000:2719  [+0x0A719]  B9 00 01                 mov     cx,100h
F000:271C  [+0x0A71C]  FC                       cld
F000:271D  [+0x0A71D]  F3 A5                    rep movsw
F000:271F  [+0x0A71F]  66 53                    push    ebx
F000:2721  [+0x0A721]  66 8B 1E 01 96           mov     ebx,[9601h]
F000:2726  [+0x0A726]  1E                       push    ds
F000:2727  [+0x0A727]  B8 40 00                 mov     ax,40h
F000:272A  [+0x0A72A]  8E D8                    mov     ds,ax
F000:272C  [+0x0A72C]  66 89 1E B6 00           mov     [0B6h],ebx
F000:2731  [+0x0A731]  1F                       pop     ds
F000:2732  [+0x0A732]  66 5B                    pop     ebx
F000:2734  [+0x0A734]  B8 06 00                 mov     ax,6
F000:2737  [+0x0A737]  BA 00 10                 mov     dx,1000h
F000:273A  [+0x0A73A]  E8 04 EC                 call    1341h
F000:273D  [+0x0A73D]  07                       pop     es
F000:273E  [+0x0A73E]  1F                       pop     ds
F000:273F  [+0x0A73F]  C3                       ret
F000:2740  [+0x0A740]  0F 08                    invd
F000:2742  [+0x0A742]  0F AA                    rsm
F000:2744  [+0x0A744]  C3                       ret
F000:2745  [+0x0A745]  FF 03                    inc     word [bp+di]
F000:2747  [+0x0A747]  00 00                    add     [bx+si],al
F000:2749  [+0x0A749]  00 00                    add     [bx+si],al
F000:274B  [+0x0A74B]  FA                       cli
F000:274C  [+0x0A74C]  9B                       wait
F000:274D  [+0x0A74D]  DD B4 E9 00              fnsave  [si+0E9h]
F000:2751  [+0x0A751]  66 89 04                 mov     [si],eax
F000:2754  [+0x0A754]  66 89 5C 04              mov     [si+4],ebx
F000:2758  [+0x0A758]  66 89 4C 08              mov     [si+8],ecx
F000:275C  [+0x0A75C]  66 89 54 0C              mov     [si+0Ch],edx
F000:2760  [+0x0A760]  66 89 7C 10              mov     [si+10h],edi
F000:2764  [+0x0A764]  66 89 74 14              mov     [si+14h],esi
F000:2768  [+0x0A768]  66 89 6C 18              mov     [si+18h],ebp
F000:276C  [+0x0A76C]  5B                       pop     bx
F000:276D  [+0x0A76D]  66 89 64 1C              mov     [si+1Ch],esp
F000:2771  [+0x0A771]  8C 4C 3C                 mov     [si+3Ch],cs
F000:2774  [+0x0A774]  8C 5C 3E                 mov     [si+3Eh],ds
F000:2777  [+0x0A777]  8C 44 40                 mov     [si+40h],es
F000:277A  [+0x0A77A]  8C 64 42                 mov     [si+42h],fs
F000:277D  [+0x0A77D]  8C 6C 44                 mov     [si+44h],gs
F000:2780  [+0x0A780]  8C 54 46                 mov     [si+46h],ss
F000:2783  [+0x0A783]  0F 20 C0                 mov     eax,cr0
F000:2786  [+0x0A786]  66 89 44 20              mov     [si+20h],eax
F000:278A  [+0x0A78A]  C6 84 E8 00 00           mov     byte [si+0E8h],0
F000:278F  [+0x0A78F]  0F 01 E0                 smsw    ax
F000:2792  [+0x0A792]  24 01                    and     al,1
F000:2794  [+0x0A794]  F8                       clc
F000:2795  [+0x0A795]  0F 84 00 00              je      near 2799h
F000:2799  [+0x0A799]  B8 00 00                 mov     ax,0
F000:279C  [+0x0A79C]  8E D8                    mov     ds,ax
F000:279E  [+0x0A79E]  8E D0                    mov     ss,ax
F000:27A0  [+0x0A7A0]  8E C0                    mov     es,ax
F000:27A2  [+0x0A7A2]  8E E0                    mov     fs,ax
F000:27A4  [+0x0A7A4]  8E E8                    mov     gs,ax
F000:27A6  [+0x0A7A6]  FF E3                    jmp     bx
F000:27A8  [+0x0A7A8]  FA                       cli
F000:27A9  [+0x0A7A9]  5B                       pop     bx
F000:27AA  [+0x0A7AA]  0F 01 E0                 smsw    ax
F000:27AD  [+0x0A7AD]  24 01                    and     al,1
F000:27AF  [+0x0A7AF]  74 0A                    je      short 27BBh
F000:27B1  [+0x0A7B1]  66 8B 44 20              mov     eax,[si+20h]
F000:27B5  [+0x0A7B5]  0F 22 C0                 mov     cr0,eax
F000:27B8  [+0x0A7B8]  EB 08                    jmp     short 27C2h
F000:27BA  [+0x0A7BA]  90                       nop
F000:27BB  [+0x0A7BB]  80 BC E8 00 00           cmp     byte [si+0E8h],0
F000:27C0  [+0x0A7C0]  74 EF                    je      short 27B1h
F000:27C2  [+0x0A7C2]  8E 5C 3E                 mov     ds,[si+3Eh]
F000:27C5  [+0x0A7C5]  8E 44 40                 mov     es,[si+40h]
F000:27C8  [+0x0A7C8]  8E 64 42                 mov     fs,[si+42h]
F000:27CB  [+0x0A7CB]  8E 6C 44                 mov     gs,[si+44h]
F000:27CE  [+0x0A7CE]  8E 54 46                 mov     ss,[si+46h]
F000:27D1  [+0x0A7D1]  66 8B 64 1C              mov     esp,[si+1Ch]
F000:27D5  [+0x0A7D5]  53                       push    bx
F000:27D6  [+0x0A7D6]  66 8B 04                 mov     eax,[si]
F000:27D9  [+0x0A7D9]  66 8B 5C 04              mov     ebx,[si+4]
F000:27DD  [+0x0A7DD]  66 8B 4C 08              mov     ecx,[si+8]
F000:27E1  [+0x0A7E1]  66 8B 54 0C              mov     edx,[si+0Ch]
F000:27E5  [+0x0A7E5]  66 8B 7C 10              mov     edi,[si+10h]
F000:27E9  [+0x0A7E9]  66 8B 6C 18              mov     ebp,[si+18h]
F000:27ED  [+0x0A7ED]  66 8B 74 14              mov     esi,[si+14h]
F000:27F1  [+0x0A7F1]  EB 00                    jmp     short 27F3h
F000:27F3  [+0x0A7F3]  50                       push    ax
F000:27F4  [+0x0A7F4]  32 C0                    xor     al,al
F000:27F6  [+0x0A7F6]  E6 F0                    out     0F0h,al
F000:27F8  [+0x0A7F8]  EB 00                    jmp     short 27FAh
F000:27FA  [+0x0A7FA]  58                       pop     ax
F000:27FB  [+0x0A7FB]  9B                       wait
F000:27FC  [+0x0A7FC]  DD A4 E9 00              frstor  [si+0E9h]
F000:2800  [+0x0A800]  9B                       wait
F000:2801  [+0x0A801]  C3                       ret
F000:2802  [+0x0A802]  C6 06 94 04 00           mov     byte [494h],0
F000:2807  [+0x0A807]  C3                       ret
F000:2808  [+0x0A808]  60                       pusha
F000:2809  [+0x0A809]  28 BF 1E A5              sub     [bx-5AE2h],bh
F000:280D  [+0x0A80D]  1E                       push    ds
F000:280E  [+0x0A80E]  34 1E                    xor     al,1Eh
F000:2810  [+0x0A810]  99                       cwd
F000:2811  [+0x0A811]  1B 07                    sbb     ax,[bx]
F000:2813  [+0x0A813]  1B 4D 1E                 sbb     cx,[di+1Eh]
F000:2816  [+0x0A816]  2F                       das
F000:2817  [+0x0A817]  1C 9E                    sbb     al,9Eh
F000:2819  [+0x0A819]  1A 60 28                 sbb     ah,[bx+si+28h]
F000:281C  [+0x0A81C]  60                       pusha
F000:281D  [+0x0A81D]  28 34                    sub     [si],dh
F000:281F  [+0x0A81F]  1E                       push    ds
F000:2820  [+0x0A820]  62 1E 60 28              bound   bx,[2860h]
F000:2824  [+0x0A824]  A9 1E 60                 test    ax,601Eh
F000:2827  [+0x0A827]  28 E4                    sub     ah,ah
F000:2829  [+0x0A829]  21 A2 95 04              and     [bp+si+495h],sp
F000:282D  [+0x0A82D]  E4 A1                    in      al,0A1h
F000:282F  [+0x0A82F]  A2 96 04                 mov     [496h],al
F000:2832  [+0x0A832]  B8 01 00                 mov     ax,1
F000:2835  [+0x0A835]  BA F0 00                 mov     dx,0F0h
F000:2838  [+0x0A838]  E8 B6 EA                 call    12F1h
F000:283B  [+0x0A83B]  80 3E 94 04 00           cmp     byte [494h],0
F000:2840  [+0x0A840]  74 0B                    je      short 284Dh
F000:2842  [+0x0A842]  80 FB 05                 cmp     bl,5
F000:2845  [+0x0A845]  B3 00                    mov     bl,0
F000:2847  [+0x0A847]  75 04                    jne     short 284Dh
F000:2849  [+0x0A849]  B3 0B                    mov     bl,0Bh
F000:284B  [+0x0A84B]  EB 00                    jmp     short 284Dh
F000:284D  [+0x0A84D]  03 DB                    add     bx,bx
F000:284F  [+0x0A84F]  2E FF 97 08 28           call    word [cs:bx+2808h]
F000:2854  [+0x0A854]  FA                       cli
F000:2855  [+0x0A855]  A0 95 04                 mov     al,[495h]
F000:2858  [+0x0A858]  E6 21                    out     21h,al
F000:285A  [+0x0A85A]  A0 96 04                 mov     al,[496h]
F000:285D  [+0x0A85D]  E6 A1                    out     0A1h,al
F000:285F  [+0x0A85F]  C3                       ret
F000:2860  [+0x0A860]  B8 06 00                 mov     ax,6
F000:2863  [+0x0A863]  BA 00 40                 mov     dx,4000h
F000:2866  [+0x0A866]  E8 CF EA                 call    1338h
F000:2869  [+0x0A869]  B8 01 00                 mov     ax,1
F000:286C  [+0x0A86C]  BA F7 00                 mov     dx,0F7h
F000:286F  [+0x0A86F]  E8 C6 EA                 call    1338h
F000:2872  [+0x0A872]  C3                       ret
F000:2873  [+0x0A873]  50                       push    ax
F000:2874  [+0x0A874]  06                       push    es
F000:2875  [+0x0A875]  33 C0                    xor     ax,ax
F000:2877  [+0x0A877]  8E C0                    mov     es,ax
F000:2879  [+0x0A879]  26 A0 10 04              mov     al,[es:410h]
F000:287D  [+0x0A87D]  24 01                    and     al,1
F000:287F  [+0x0A87F]  A2 97 04                 mov     [497h],al
F000:2882  [+0x0A882]  07                       pop     es
F000:2883  [+0x0A883]  58                       pop     ax
F000:2884  [+0x0A884]  C3                       ret
F000:2885  [+0x0A885]  52                       push    dx
F000:2886  [+0x0A886]  51                       push    cx
F000:2887  [+0x0A887]  53                       push    bx
F000:2888  [+0x0A888]  80 3E 97 04 00           cmp     byte [497h],0
F000:288D  [+0x0A88D]  74 1C                    je      short 28ABh
F000:288F  [+0x0A88F]  50                       push    ax
F000:2890  [+0x0A890]  B8 81 00                 mov     ax,81h
F000:2893  [+0x0A893]  E8 4D EA                 call    12E3h
F000:2896  [+0x0A896]  89 1E A8 04              mov     [4A8h],bx
F000:289A  [+0x0A89A]  B8 82 00                 mov     ax,82h
F000:289D  [+0x0A89D]  E8 43 EA                 call    12E3h
F000:28A0  [+0x0A8A0]  89 1E AA 04              mov     [4AAh],bx
F000:28A4  [+0x0A8A4]  BA F2 03                 mov     dx,3F2h
F000:28A7  [+0x0A8A7]  B0 04                    mov     al,4
F000:28A9  [+0x0A8A9]  EE                       out     dx,al
F000:28AA  [+0x0A8AA]  58                       pop     ax
F000:28AB  [+0x0A8AB]  5B                       pop     bx
F000:28AC  [+0x0A8AC]  59                       pop     cx
F000:28AD  [+0x0A8AD]  5A                       pop     dx
F000:28AE  [+0x0A8AE]  C3                       ret
F000:28AF  [+0x0A8AF]  52                       push    dx
F000:28B0  [+0x0A8B0]  51                       push    cx
F000:28B1  [+0x0A8B1]  53                       push    bx
F000:28B2  [+0x0A8B2]  E8 C0 00                 call    2975h
F000:28B5  [+0x0A8B5]  80 3E 97 04 00           cmp     byte [497h],0
F000:28BA  [+0x0A8BA]  74 1E                    je      short 28DAh
F000:28BC  [+0x0A8BC]  50                       push    ax
F000:28BD  [+0x0A8BD]  8B 1E A8 04              mov     bx,[4A8h]
F000:28C1  [+0x0A8C1]  8B 0E AA 04              mov     cx,[4AAh]
F000:28C5  [+0x0A8C5]  C1 EB 08                 shr     bx,8
F000:28C8  [+0x0A8C8]  C1 E9 08                 shr     cx,8
F000:28CB  [+0x0A8CB]  BA F2 03                 mov     dx,3F2h
F000:28CE  [+0x0A8CE]  8A C3                    mov     al,bl
F000:28D0  [+0x0A8D0]  EE                       out     dx,al
F000:28D1  [+0x0A8D1]  EB 00                    jmp     short 28D3h
F000:28D3  [+0x0A8D3]  BA F7 03                 mov     dx,3F7h
F000:28D6  [+0x0A8D6]  8A C1                    mov     al,cl
F000:28D8  [+0x0A8D8]  EE                       out     dx,al
F000:28D9  [+0x0A8D9]  58                       pop     ax
F000:28DA  [+0x0A8DA]  5B                       pop     bx
F000:28DB  [+0x0A8DB]  59                       pop     cx
F000:28DC  [+0x0A8DC]  5A                       pop     dx
F000:28DD  [+0x0A8DD]  C3                       ret
F000:28DE  [+0x0A8DE]  60                       pusha
F000:28DF  [+0x0A8DF]  1E                       push    ds
F000:28E0  [+0x0A8E0]  B8 40 00                 mov     ax,40h
F000:28E3  [+0x0A8E3]  8E D8                    mov     ds,ax
F000:28E5  [+0x0A8E5]  A0 3F 00                 mov     al,[3Fh]
F000:28E8  [+0x0A8E8]  1F                       pop     ds
F000:28E9  [+0x0A8E9]  C0 C0 04                 rol     al,4
F000:28EC  [+0x0A8EC]  24 39                    and     al,39h
F000:28EE  [+0x0A8EE]  0C 08                    or      al,8
F000:28F0  [+0x0A8F0]  BA F2 03                 mov     dx,3F2h
F000:28F3  [+0x0A8F3]  EE                       out     dx,al
F000:28F4  [+0x0A8F4]  E8 4A F7                 call    2041h
F000:28F7  [+0x0A8F7]  0C 0C                    or      al,0Ch
F000:28F9  [+0x0A8F9]  EE                       out     dx,al
F000:28FA  [+0x0A8FA]  B9 0A 00                 mov     cx,0Ah
F000:28FD  [+0x0A8FD]  E8 41 F7                 call    2041h
F000:2900  [+0x0A900]  E2 FB                    loop    28FDh
F000:2902  [+0x0A902]  B9 04 00                 mov     cx,4
F000:2905  [+0x0A905]  51                       push    cx
F000:2906  [+0x0A906]  E8 05 00                 call    290Eh
F000:2909  [+0x0A909]  59                       pop     cx
F000:290A  [+0x0A90A]  E2 F9                    loop    2905h
F000:290C  [+0x0A90C]  61                       popa
F000:290D  [+0x0A90D]  C3                       ret
F000:290E  [+0x0A90E]  50                       push    ax
F000:290F  [+0x0A90F]  51                       push    cx
F000:2910  [+0x0A910]  B0 08                    mov     al,8
F000:2912  [+0x0A912]  E8 0B 00                 call    2920h
F000:2915  [+0x0A915]  72 06                    jb      short 291Dh
F000:2917  [+0x0A917]  B9 02 00                 mov     cx,2
F000:291A  [+0x0A91A]  E8 26 00                 call    2943h
F000:291D  [+0x0A91D]  59                       pop     cx
F000:291E  [+0x0A91E]  58                       pop     ax
F000:291F  [+0x0A91F]  C3                       ret
F000:2920  [+0x0A920]  52                       push    dx
F000:2921  [+0x0A921]  50                       push    ax
F000:2922  [+0x0A922]  8A E0                    mov     ah,al
F000:2924  [+0x0A924]  E8 3A 00                 call    2961h
F000:2927  [+0x0A927]  74 17                    je      short 2940h
F000:2929  [+0x0A929]  A8 40                    test    al,40h
F000:292B  [+0x0A92B]  75 0B                    jne     short 2938h
F000:292D  [+0x0A92D]  BA F5 03                 mov     dx,3F5h
F000:2930  [+0x0A930]  8A C4                    mov     al,ah
F000:2932  [+0x0A932]  EE                       out     dx,al
F000:2933  [+0x0A933]  EB 00                    jmp     short 2935h
F000:2935  [+0x0A935]  58                       pop     ax
F000:2936  [+0x0A936]  5A                       pop     dx
F000:2937  [+0x0A937]  C3                       ret
F000:2938  [+0x0A938]  51                       push    cx
F000:2939  [+0x0A939]  B9 10 00                 mov     cx,10h
F000:293C  [+0x0A93C]  E8 04 00                 call    2943h
F000:293F  [+0x0A93F]  59                       pop     cx
F000:2940  [+0x0A940]  F9                       stc
F000:2941  [+0x0A941]  EB F2                    jmp     short 2935h
F000:2943  [+0x0A943]  50                       push    ax
F000:2944  [+0x0A944]  53                       push    bx
F000:2945  [+0x0A945]  52                       push    dx
F000:2946  [+0x0A946]  BB 98 04                 mov     bx,498h
F000:2949  [+0x0A949]  E8 15 00                 call    2961h
F000:294C  [+0x0A94C]  74 0F                    je      short 295Dh
F000:294E  [+0x0A94E]  24 50                    and     al,50h
F000:2950  [+0x0A950]  3C 50                    cmp     al,50h
F000:2952  [+0x0A952]  75 09                    jne     short 295Dh
F000:2954  [+0x0A954]  BA F5 03                 mov     dx,3F5h
F000:2957  [+0x0A957]  EC                       in      al,dx
F000:2958  [+0x0A958]  88 07                    mov     [bx],al
F000:295A  [+0x0A95A]  43                       inc     bx
F000:295B  [+0x0A95B]  E2 EC                    loop    2949h
F000:295D  [+0x0A95D]  5A                       pop     dx
F000:295E  [+0x0A95E]  5B                       pop     bx
F000:295F  [+0x0A95F]  58                       pop     ax
F000:2960  [+0x0A960]  C3                       ret
F000:2961  [+0x0A961]  52                       push    dx
F000:2962  [+0x0A962]  51                       push    cx
F000:2963  [+0x0A963]  E8 DB F6                 call    2041h
F000:2966  [+0x0A966]  33 C9                    xor     cx,cx
F000:2968  [+0x0A968]  BA F4 03                 mov     dx,3F4h
F000:296B  [+0x0A96B]  EB 00                    jmp     short 296Dh
F000:296D  [+0x0A96D]  EC                       in      al,dx
F000:296E  [+0x0A96E]  A8 80                    test    al,80h
F000:2970  [+0x0A970]  E1 F9                    loope   296Bh
F000:2972  [+0x0A972]  59                       pop     cx
F000:2973  [+0x0A973]  5A                       pop     dx
F000:2974  [+0x0A974]  C3                       ret
F000:2975  [+0x0A975]  BA 0B 00                 mov     dx,0Bh
F000:2978  [+0x0A978]  B0 40                    mov     al,40h
F000:297A  [+0x0A97A]  B9 04 00                 mov     cx,4
F000:297D  [+0x0A97D]  EB 00                    jmp     short 297Fh
F000:297F  [+0x0A97F]  EB 00                    jmp     short 2981h
F000:2981  [+0x0A981]  EE                       out     dx,al
F000:2982  [+0x0A982]  FE C0                    inc     al
F000:2984  [+0x0A984]  E2 F7                    loop    297Dh
F000:2986  [+0x0A986]  80 C2 CB                 add     dl,0CBh
F000:2989  [+0x0A989]  73 ED                    jae     short 2978h
F000:298B  [+0x0A98B]  B0 C0                    mov     al,0C0h
F000:298D  [+0x0A98D]  E6 D6                    out     0D6h,al
F000:298F  [+0x0A98F]  EB 00                    jmp     short 2991h
F000:2991  [+0x0A991]  EB 00                    jmp     short 2993h
F000:2993  [+0x0A993]  B0 00                    mov     al,0
F000:2995  [+0x0A995]  E6 D4                    out     0D4h,al
F000:2997  [+0x0A997]  EB 00                    jmp     short 2999h
F000:2999  [+0x0A999]  EB 00                    jmp     short 299Bh
F000:299B  [+0x0A99B]  C3                       ret
F000:299C  [+0x0A99C]  50                       push    ax
F000:299D  [+0x0A99D]  06                       push    es
F000:299E  [+0x0A99E]  33 C0                    xor     ax,ax
F000:29A0  [+0x0A9A0]  8E C0                    mov     es,ax
F000:29A2  [+0x0A9A2]  26 A0 75 04              mov     al,[es:475h]
F000:29A6  [+0x0A9A6]  A2 AC 04                 mov     [4ACh],al
F000:29A9  [+0x0A9A9]  0A C0                    or      al,al
F000:29AB  [+0x0A9AB]  74 27                    je      short 29D4h
F000:29AD  [+0x0A9AD]  53                       push    bx
F000:29AE  [+0x0A9AE]  E8 3C 01                 call    2AEDh
F000:29B1  [+0x0A9B1]  88 1E AD 04              mov     [4ADh],bl
F000:29B5  [+0x0A9B5]  26 C4 1E 04 01           les     bx,[es:104h]
F000:29BA  [+0x0A9BA]  26 8A 47 0E              mov     al,[es:bx+0Eh]
F000:29BE  [+0x0A9BE]  A2 AE 04                 mov     [4AEh],al
F000:29C1  [+0x0A9C1]  26 8A 47 02              mov     al,[es:bx+2]
F000:29C5  [+0x0A9C5]  A2 AF 04                 mov     [4AFh],al
F000:29C8  [+0x0A9C8]  8A 3E AD 04              mov     bh,[4ADh]
F000:29CC  [+0x0A9CC]  B3 00                    mov     bl,0
F000:29CE  [+0x0A9CE]  B4 E3                    mov     ah,0E3h
F000:29D0  [+0x0A9D0]  E8 5E 00                 call    2A31h
F000:29D3  [+0x0A9D3]  5B                       pop     bx
F000:29D4  [+0x0A9D4]  07                       pop     es
F000:29D5  [+0x0A9D5]  58                       pop     ax
F000:29D6  [+0x0A9D6]  C3                       ret
F000:29D7  [+0x0A9D7]  80 3E AC 04 00           cmp     byte [4ACh],0
F000:29DC  [+0x0A9DC]  74 10                    je      short 29EEh
F000:29DE  [+0x0A9DE]  50                       push    ax
F000:29DF  [+0x0A9DF]  53                       push    bx
F000:29E0  [+0x0A9E0]  E8 0A 01                 call    2AEDh
F000:29E3  [+0x0A9E3]  8A FB                    mov     bh,bl
F000:29E5  [+0x0A9E5]  B3 00                    mov     bl,0
F000:29E7  [+0x0A9E7]  B4 E2                    mov     ah,0E2h
F000:29E9  [+0x0A9E9]  E8 45 00                 call    2A31h
F000:29EC  [+0x0A9EC]  5B                       pop     bx
F000:29ED  [+0x0A9ED]  58                       pop     ax
F000:29EE  [+0x0A9EE]  C3                       ret
F000:29EF  [+0x0A9EF]  50                       push    ax
F000:29F0  [+0x0A9F0]  53                       push    bx
F000:29F1  [+0x0A9F1]  80 3E AC 04 00           cmp     byte [4ACh],0
F000:29F6  [+0x0A9F6]  74 1D                    je      short 2A15h
F000:29F8  [+0x0A9F8]  E8 98 00                 call    2A93h
F000:29FB  [+0x0A9FB]  B4 91                    mov     ah,91h
F000:29FD  [+0x0A9FD]  8A 3E AE 04              mov     bh,[4AEh]
F000:2A01  [+0x0AA01]  8A 1E AF 04              mov     bl,[4AFh]
F000:2A05  [+0x0AA05]  FE CB                    dec     bl
F000:2A07  [+0x0AA07]  E8 27 00                 call    2A31h
F000:2A0A  [+0x0AA0A]  B4 E3                    mov     ah,0E3h
F000:2A0C  [+0x0AA0C]  8A 3E AD 04              mov     bh,[4ADh]
F000:2A10  [+0x0AA10]  B3 00                    mov     bl,0
F000:2A12  [+0x0AA12]  E8 1C 00                 call    2A31h
F000:2A15  [+0x0AA15]  E8 41 01                 call    2B59h
F000:2A18  [+0x0AA18]  5B                       pop     bx
F000:2A19  [+0x0AA19]  58                       pop     ax
F000:2A1A  [+0x0AA1A]  C3                       ret
F000:2A1B  [+0x0AA1B]  60                       pusha
F000:2A1C  [+0x0AA1C]  80 3E AC 04 00           cmp     byte [4ACh],0
F000:2A21  [+0x0AA21]  74 46                    je      short 2A69h
F000:2A23  [+0x0AA23]  E8 C7 00                 call    2AEDh
F000:2A26  [+0x0AA26]  8A FB                    mov     bh,bl
F000:2A28  [+0x0AA28]  B3 00                    mov     bl,0
F000:2A2A  [+0x0AA2A]  B4 E2                    mov     ah,0E2h
F000:2A2C  [+0x0AA2C]  E8 02 00                 call    2A31h
F000:2A2F  [+0x0AA2F]  61                       popa
F000:2A30  [+0x0AA30]  C3                       ret
F000:2A31  [+0x0AA31]  50                       push    ax
F000:2A32  [+0x0AA32]  52                       push    dx
F000:2A33  [+0x0AA33]  FA                       cli
F000:2A34  [+0x0AA34]  E8 75 00                 call    2AACh
F000:2A37  [+0x0AA37]  75 57                    jne     short 2A90h
F000:2A39  [+0x0AA39]  BA F2 01                 mov     dx,1F2h
F000:2A3C  [+0x0AA3C]  8A C7                    mov     al,bh
F000:2A3E  [+0x0AA3E]  EE                       out     dx,al
F000:2A3F  [+0x0AA3F]  E8 6A 00                 call    2AACh
F000:2A42  [+0x0AA42]  75 4C                    jne     short 2A90h
F000:2A44  [+0x0AA44]  BA F6 01                 mov     dx,1F6h
F000:2A47  [+0x0AA47]  8A C3                    mov     al,bl
F000:2A49  [+0x0AA49]  EE                       out     dx,al
F000:2A4A  [+0x0AA4A]  EB 00                    jmp     short 2A4Ch
F000:2A4C  [+0x0AA4C]  EB 00                    jmp     short 2A4Eh
F000:2A4E  [+0x0AA4E]  EB 00                    jmp     short 2A50h
F000:2A50  [+0x0AA50]  EB 00                    jmp     short 2A52h
F000:2A52  [+0x0AA52]  E8 57 00                 call    2AACh
F000:2A55  [+0x0AA55]  75 39                    jne     short 2A90h
F000:2A57  [+0x0AA57]  BA F7 01                 mov     dx,1F7h
F000:2A5A  [+0x0AA5A]  8A C4                    mov     al,ah
F000:2A5C  [+0x0AA5C]  EE                       out     dx,al
F000:2A5D  [+0x0AA5D]  EB 00                    jmp     short 2A5Fh
F000:2A5F  [+0x0AA5F]  EB 00                    jmp     short 2A61h
F000:2A61  [+0x0AA61]  EB 00                    jmp     short 2A63h
F000:2A63  [+0x0AA63]  EB 00                    jmp     short 2A65h
F000:2A65  [+0x0AA65]  51                       push    cx
F000:2A66  [+0x0AA66]  B9 05 00                 mov     cx,5
F000:2A69  [+0x0AA69]  B0 0A                    mov     al,0Ah
F000:2A6B  [+0x0AA6B]  E6 A0                    out     0A0h,al
F000:2A6D  [+0x0AA6D]  EB 00                    jmp     short 2A6Fh
F000:2A6F  [+0x0AA6F]  EB 00                    jmp     short 2A71h
F000:2A71  [+0x0AA71]  EB 00                    jmp     short 2A73h
F000:2A73  [+0x0AA73]  EB 00                    jmp     short 2A75h
F000:2A75  [+0x0AA75]  E4 A0                    in      al,0A0h
F000:2A77  [+0x0AA77]  EB 00                    jmp     short 2A79h
F000:2A79  [+0x0AA79]  EB 00                    jmp     short 2A7Bh
F000:2A7B  [+0x0AA7B]  EB 00                    jmp     short 2A7Dh
F000:2A7D  [+0x0AA7D]  EB 00                    jmp     short 2A7Fh
F000:2A7F  [+0x0AA7F]  A8 40                    test    al,40h
F000:2A81  [+0x0AA81]  E1 E6                    loope   2A69h
F000:2A83  [+0x0AA83]  59                       pop     cx
F000:2A84  [+0x0AA84]  BA F7 01                 mov     dx,1F7h
F000:2A87  [+0x0AA87]  EC                       in      al,dx
F000:2A88  [+0x0AA88]  EB 00                    jmp     short 2A8Ah
F000:2A8A  [+0x0AA8A]  EB 00                    jmp     short 2A8Ch
F000:2A8C  [+0x0AA8C]  EB 00                    jmp     short 2A8Eh
F000:2A8E  [+0x0AA8E]  EB 00                    jmp     short 2A90h
F000:2A90  [+0x0AA90]  5A                       pop     dx
F000:2A91  [+0x0AA91]  58                       pop     ax
F000:2A92  [+0x0AA92]  C3                       ret
F000:2A93  [+0x0AA93]  50                       push    ax
F000:2A94  [+0x0AA94]  52                       push    dx
F000:2A95  [+0x0AA95]  E8 14 00                 call    2AACh
F000:2A98  [+0x0AA98]  75 0F                    jne     short 2AA9h
F000:2A9A  [+0x0AA9A]  BA F6 03                 mov     dx,3F6h
F000:2A9D  [+0x0AA9D]  B0 04                    mov     al,4
F000:2A9F  [+0x0AA9F]  EE                       out     dx,al
F000:2AA0  [+0x0AAA0]  E8 9E F5                 call    2041h
F000:2AA3  [+0x0AAA3]  BA F6 03                 mov     dx,3F6h
F000:2AA6  [+0x0AAA6]  B0 00                    mov     al,0
F000:2AA8  [+0x0AAA8]  EE                       out     dx,al
F000:2AA9  [+0x0AAA9]  5A                       pop     dx
F000:2AAA  [+0x0AAAA]  58                       pop     ax
F000:2AAB  [+0x0AAAB]  C3                       ret
F000:2AAC  [+0x0AAAC]  50                       push    ax
F000:2AAD  [+0x0AAAD]  52                       push    dx
F000:2AAE  [+0x0AAAE]  51                       push    cx
F000:2AAF  [+0x0AAAF]  B9 05 00                 mov     cx,5
F000:2AB2  [+0x0AAB2]  BA F6 03                 mov     dx,3F6h
F000:2AB5  [+0x0AAB5]  EC                       in      al,dx
F000:2AB6  [+0x0AAB6]  24 C0                    and     al,0C0h
F000:2AB8  [+0x0AAB8]  3C 40                    cmp     al,40h
F000:2ABA  [+0x0AABA]  E0 F9                    loopne  2AB5h
F000:2ABC  [+0x0AABC]  59                       pop     cx
F000:2ABD  [+0x0AABD]  5A                       pop     dx
F000:2ABE  [+0x0AABE]  58                       pop     ax
F000:2ABF  [+0x0AABF]  C3                       ret
F000:2AC0  [+0x0AAC0]  50                       push    ax
F000:2AC1  [+0x0AAC1]  53                       push    bx
F000:2AC2  [+0x0AAC2]  80 3E AC 04 00           cmp     byte [4ACh],0
F000:2AC7  [+0x0AAC7]  74 1E                    je      short 2AE7h
F000:2AC9  [+0x0AAC9]  C6 06 AD 04 00           mov     byte [4ADh],0
F000:2ACE  [+0x0AACE]  E8 1C 00                 call    2AEDh
F000:2AD1  [+0x0AAD1]  80 3E 0F 01 00           cmp     byte [10Fh],0
F000:2AD6  [+0x0AAD6]  74 04                    je      short 2ADCh
F000:2AD8  [+0x0AAD8]  88 1E AD 04              mov     [4ADh],bl
F000:2ADC  [+0x0AADC]  8A 3E AD 04              mov     bh,[4ADh]
F000:2AE0  [+0x0AAE0]  B3 00                    mov     bl,0
F000:2AE2  [+0x0AAE2]  B4 E3                    mov     ah,0E3h
F000:2AE4  [+0x0AAE4]  E8 4A FF                 call    2A31h
F000:2AE7  [+0x0AAE7]  E8 6F 00                 call    2B59h
F000:2AEA  [+0x0AAEA]  5B                       pop     bx
F000:2AEB  [+0x0AAEB]  58                       pop     ax
F000:2AEC  [+0x0AAEC]  C3                       ret
F000:2AED  [+0x0AAED]  50                       push    ax
F000:2AEE  [+0x0AAEE]  52                       push    dx
F000:2AEF  [+0x0AAEF]  B0 42                    mov     al,42h
F000:2AF1  [+0x0AAF1]  E8 F8 F4                 call    1FECh
F000:2AF4  [+0x0AAF4]  B0 00                    mov     al,0
F000:2AF6  [+0x0AAF6]  80 E4 03                 and     ah,3
F000:2AF9  [+0x0AAF9]  0F 84 57 00              je      near 2B54h
F000:2AFD  [+0x0AAFD]  80 FC 01                 cmp     ah,1
F000:2B00  [+0x0AB00]  0F 84 0F 00              je      near 2B13h
F000:2B04  [+0x0AB04]  B8 01 00                 mov     ax,1
F000:2B07  [+0x0AB07]  BA 08 00                 mov     dx,8
F000:2B0A  [+0x0AB0A]  E8 E4 E7                 call    12F1h
F000:2B0D  [+0x0AB0D]  B0 00                    mov     al,0
F000:2B0F  [+0x0AB0F]  0F 85 41 00              jne     near 2B54h
F000:2B13  [+0x0AB13]  B0 4B                    mov     al,4Bh
F000:2B15  [+0x0AB15]  E8 D4 F4                 call    1FECh
F000:2B18  [+0x0AB18]  80 FC 01                 cmp     ah,1
F000:2B1B  [+0x0AB1B]  75 05                    jne     short 2B22h
F000:2B1D  [+0x0AB1D]  B0 0C                    mov     al,0Ch
F000:2B1F  [+0x0AB1F]  EB 33                    jmp     short 2B54h
F000:2B21  [+0x0AB21]  90                       nop
F000:2B22  [+0x0AB22]  80 FC 02                 cmp     ah,2
F000:2B25  [+0x0AB25]  0F 85 05 00              jne     near 2B2Eh
F000:2B29  [+0x0AB29]  B0 18                    mov     al,18h
F000:2B2B  [+0x0AB2B]  EB 27                    jmp     short 2B54h
F000:2B2D  [+0x0AB2D]  90                       nop
F000:2B2E  [+0x0AB2E]  80 FC 03                 cmp     ah,3
F000:2B31  [+0x0AB31]  0F 85 05 00              jne     near 2B3Ah
F000:2B35  [+0x0AB35]  B0 3C                    mov     al,3Ch
F000:2B37  [+0x0AB37]  EB 1B                    jmp     short 2B54h
F000:2B39  [+0x0AB39]  90                       nop
F000:2B3A  [+0x0AB3A]  80 FC 04                 cmp     ah,4
F000:2B3D  [+0x0AB3D]  0F 85 05 00              jne     near 2B46h
F000:2B41  [+0x0AB41]  B0 78                    mov     al,78h
F000:2B43  [+0x0AB43]  EB 0F                    jmp     short 2B54h
F000:2B45  [+0x0AB45]  90                       nop
F000:2B46  [+0x0AB46]  80 FC 05                 cmp     ah,5
F000:2B49  [+0x0AB49]  0F 85 05 00              jne     near 2B52h
F000:2B4D  [+0x0AB4D]  B0 B4                    mov     al,0B4h
F000:2B4F  [+0x0AB4F]  EB 03                    jmp     short 2B54h
F000:2B51  [+0x0AB51]  90                       nop
F000:2B52  [+0x0AB52]  B0 00                    mov     al,0
F000:2B54  [+0x0AB54]  8A D8                    mov     bl,al
F000:2B56  [+0x0AB56]  5A                       pop     dx
F000:2B57  [+0x0AB57]  58                       pop     ax
F000:2B58  [+0x0AB58]  C3                       ret
F000:2B59  [+0x0AB59]  50                       push    ax
F000:2B5A  [+0x0AB5A]  53                       push    bx
F000:2B5B  [+0x0AB5B]  51                       push    cx
F000:2B5C  [+0x0AB5C]  52                       push    dx
F000:2B5D  [+0x0AB5D]  B0 42                    mov     al,42h
F000:2B5F  [+0x0AB5F]  E8 8A F4                 call    1FECh
F000:2B62  [+0x0AB62]  B0 00                    mov     al,0
F000:2B64  [+0x0AB64]  80 E4 03                 and     ah,3
F000:2B67  [+0x0AB67]  0F 84 6E 00              je      near 2BD9h
F000:2B6B  [+0x0AB6B]  80 FC 00                 cmp     ah,0
F000:2B6E  [+0x0AB6E]  B0 00                    mov     al,0
F000:2B70  [+0x0AB70]  0F 84 65 00              je      near 2BD9h
F000:2B74  [+0x0AB74]  80 FC 01                 cmp     ah,1
F000:2B77  [+0x0AB77]  0F 84 0F 00              je      near 2B8Ah
F000:2B7B  [+0x0AB7B]  B8 01 00                 mov     ax,1
F000:2B7E  [+0x0AB7E]  BA 08 00                 mov     dx,8
F000:2B81  [+0x0AB81]  E8 6D E7                 call    12F1h
F000:2B84  [+0x0AB84]  B0 00                    mov     al,0
F000:2B86  [+0x0AB86]  0F 85 4F 00              jne     near 2BD9h
F000:2B8A  [+0x0AB8A]  B0 4B                    mov     al,4Bh
F000:2B8C  [+0x0AB8C]  E8 5D F4                 call    1FECh
F000:2B8F  [+0x0AB8F]  80 FC 00                 cmp     ah,0
F000:2B92  [+0x0AB92]  0F 85 05 00              jne     near 2B9Bh
F000:2B96  [+0x0AB96]  B0 00                    mov     al,0
F000:2B98  [+0x0AB98]  EB 3F                    jmp     short 2BD9h
F000:2B9A  [+0x0AB9A]  90                       nop
F000:2B9B  [+0x0AB9B]  80 FC 01                 cmp     ah,1
F000:2B9E  [+0x0AB9E]  0F 85 05 00              jne     near 2BA7h
F000:2BA2  [+0x0ABA2]  B0 0C                    mov     al,0Ch
F000:2BA4  [+0x0ABA4]  EB 33                    jmp     short 2BD9h
F000:2BA6  [+0x0ABA6]  90                       nop
F000:2BA7  [+0x0ABA7]  80 FC 02                 cmp     ah,2
F000:2BAA  [+0x0ABAA]  0F 85 05 00              jne     near 2BB3h
F000:2BAE  [+0x0ABAE]  B0 18                    mov     al,18h
F000:2BB0  [+0x0ABB0]  EB 27                    jmp     short 2BD9h
F000:2BB2  [+0x0ABB2]  90                       nop
F000:2BB3  [+0x0ABB3]  80 FC 03                 cmp     ah,3
F000:2BB6  [+0x0ABB6]  0F 85 05 00              jne     near 2BBFh
F000:2BBA  [+0x0ABBA]  B0 3C                    mov     al,3Ch
F000:2BBC  [+0x0ABBC]  EB 1B                    jmp     short 2BD9h
F000:2BBE  [+0x0ABBE]  90                       nop
F000:2BBF  [+0x0ABBF]  80 FC 04                 cmp     ah,4
F000:2BC2  [+0x0ABC2]  0F 85 05 00              jne     near 2BCBh
F000:2BC6  [+0x0ABC6]  B0 78                    mov     al,78h
F000:2BC8  [+0x0ABC8]  EB 0F                    jmp     short 2BD9h
F000:2BCA  [+0x0ABCA]  90                       nop
F000:2BCB  [+0x0ABCB]  80 FC 05                 cmp     ah,5
F000:2BCE  [+0x0ABCE]  0F 85 05 00              jne     near 2BD7h
F000:2BD2  [+0x0ABD2]  B0 B4                    mov     al,0B4h
F000:2BD4  [+0x0ABD4]  EB 03                    jmp     short 2BD9h
F000:2BD6  [+0x0ABD6]  90                       nop
F000:2BD7  [+0x0ABD7]  B0 00                    mov     al,0
F000:2BD9  [+0x0ABD9]  BA F2 01                 mov     dx,1F2h
F000:2BDC  [+0x0ABDC]  EE                       out     dx,al
F000:2BDD  [+0x0ABDD]  EB 00                    jmp     short 2BDFh
F000:2BDF  [+0x0ABDF]  EB 00                    jmp     short 2BE1h
F000:2BE1  [+0x0ABE1]  EB 00                    jmp     short 2BE3h
F000:2BE3  [+0x0ABE3]  EB 00                    jmp     short 2BE5h
F000:2BE5  [+0x0ABE5]  EB 00                    jmp     short 2BE7h
F000:2BE7  [+0x0ABE7]  EB 00                    jmp     short 2BE9h
F000:2BE9  [+0x0ABE9]  B0 E3                    mov     al,0E3h
F000:2BEB  [+0x0ABEB]  BA F7 01                 mov     dx,1F7h
F000:2BEE  [+0x0ABEE]  EE                       out     dx,al
F000:2BEF  [+0x0ABEF]  EB 00                    jmp     short 2BF1h
F000:2BF1  [+0x0ABF1]  EB 00                    jmp     short 2BF3h
F000:2BF3  [+0x0ABF3]  EB 00                    jmp     short 2BF5h
F000:2BF5  [+0x0ABF5]  EB 00                    jmp     short 2BF7h
F000:2BF7  [+0x0ABF7]  EB 00                    jmp     short 2BF9h
F000:2BF9  [+0x0ABF9]  5A                       pop     dx
F000:2BFA  [+0x0ABFA]  59                       pop     cx
F000:2BFB  [+0x0ABFB]  5B                       pop     bx
F000:2BFC  [+0x0ABFC]  58                       pop     ax
F000:2BFD  [+0x0ABFD]  C3                       ret
F000:2BFE  [+0x0ABFE]  50                       push    ax
F000:2BFF  [+0x0ABFF]  53                       push    bx
F000:2C00  [+0x0AC00]  51                       push    cx
F000:2C01  [+0x0AC01]  52                       push    dx
F000:2C02  [+0x0AC02]  B0 42                    mov     al,42h
F000:2C04  [+0x0AC04]  E8 E5 F3                 call    1FECh
F000:2C07  [+0x0AC07]  B0 00                    mov     al,0
F000:2C09  [+0x0AC09]  80 E4 03                 and     ah,3
F000:2C0C  [+0x0AC0C]  74 CB                    je      short 2BD9h
F000:2C0E  [+0x0AC0E]  80 FC 00                 cmp     ah,0
F000:2C11  [+0x0AC11]  B0 00                    mov     al,0
F000:2C13  [+0x0AC13]  0F 84 65 00              je      near 2C7Ch
F000:2C17  [+0x0AC17]  80 FC 01                 cmp     ah,1
F000:2C1A  [+0x0AC1A]  0F 84 0F 00              je      near 2C2Dh
F000:2C1E  [+0x0AC1E]  B8 01 00                 mov     ax,1
F000:2C21  [+0x0AC21]  BA 08 00                 mov     dx,8
F000:2C24  [+0x0AC24]  E8 CA E6                 call    12F1h
F000:2C27  [+0x0AC27]  B0 00                    mov     al,0
F000:2C29  [+0x0AC29]  0F 85 4F 00              jne     near 2C7Ch
F000:2C2D  [+0x0AC2D]  B0 4B                    mov     al,4Bh
F000:2C2F  [+0x0AC2F]  E8 BA F3                 call    1FECh
F000:2C32  [+0x0AC32]  80 FC 00                 cmp     ah,0
F000:2C35  [+0x0AC35]  0F 85 05 00              jne     near 2C3Eh
F000:2C39  [+0x0AC39]  B0 00                    mov     al,0
F000:2C3B  [+0x0AC3B]  EB 3F                    jmp     short 2C7Ch
F000:2C3D  [+0x0AC3D]  90                       nop
F000:2C3E  [+0x0AC3E]  80 FC 01                 cmp     ah,1
F000:2C41  [+0x0AC41]  0F 85 05 00              jne     near 2C4Ah
F000:2C45  [+0x0AC45]  B0 0C                    mov     al,0Ch
F000:2C47  [+0x0AC47]  EB 33                    jmp     short 2C7Ch
F000:2C49  [+0x0AC49]  90                       nop
F000:2C4A  [+0x0AC4A]  80 FC 02                 cmp     ah,2
F000:2C4D  [+0x0AC4D]  0F 85 05 00              jne     near 2C56h
F000:2C51  [+0x0AC51]  B0 18                    mov     al,18h
F000:2C53  [+0x0AC53]  EB 27                    jmp     short 2C7Ch
F000:2C55  [+0x0AC55]  90                       nop
F000:2C56  [+0x0AC56]  80 FC 03                 cmp     ah,3
F000:2C59  [+0x0AC59]  0F 85 05 00              jne     near 2C62h
F000:2C5D  [+0x0AC5D]  B0 3C                    mov     al,3Ch
F000:2C5F  [+0x0AC5F]  EB 1B                    jmp     short 2C7Ch
F000:2C61  [+0x0AC61]  90                       nop
F000:2C62  [+0x0AC62]  80 FC 04                 cmp     ah,4
F000:2C65  [+0x0AC65]  0F 85 05 00              jne     near 2C6Eh
F000:2C69  [+0x0AC69]  B0 78                    mov     al,78h
F000:2C6B  [+0x0AC6B]  EB 0F                    jmp     short 2C7Ch
F000:2C6D  [+0x0AC6D]  90                       nop
F000:2C6E  [+0x0AC6E]  80 FC 05                 cmp     ah,5
F000:2C71  [+0x0AC71]  0F 85 05 00              jne     near 2C7Ah
F000:2C75  [+0x0AC75]  B0 B4                    mov     al,0B4h
F000:2C77  [+0x0AC77]  EB 03                    jmp     short 2C7Ch
F000:2C79  [+0x0AC79]  90                       nop
F000:2C7A  [+0x0AC7A]  B0 00                    mov     al,0
F000:2C7C  [+0x0AC7C]  BA F2 01                 mov     dx,1F2h
F000:2C7F  [+0x0AC7F]  EE                       out     dx,al
F000:2C80  [+0x0AC80]  EB 00                    jmp     short 2C82h
F000:2C82  [+0x0AC82]  EB 00                    jmp     short 2C84h
F000:2C84  [+0x0AC84]  EB 00                    jmp     short 2C86h
F000:2C86  [+0x0AC86]  EB 00                    jmp     short 2C88h
F000:2C88  [+0x0AC88]  EB 00                    jmp     short 2C8Ah
F000:2C8A  [+0x0AC8A]  EB 00                    jmp     short 2C8Ch
F000:2C8C  [+0x0AC8C]  B0 E2                    mov     al,0E2h
F000:2C8E  [+0x0AC8E]  BA F7 01                 mov     dx,1F7h
F000:2C91  [+0x0AC91]  EE                       out     dx,al
F000:2C92  [+0x0AC92]  EB 00                    jmp     short 2C94h
F000:2C94  [+0x0AC94]  EB 00                    jmp     short 2C96h
F000:2C96  [+0x0AC96]  EB 00                    jmp     short 2C98h
F000:2C98  [+0x0AC98]  EB 00                    jmp     short 2C9Ah
F000:2C9A  [+0x0AC9A]  EB 00                    jmp     short 2C9Ch
F000:2C9C  [+0x0AC9C]  5A                       pop     dx
F000:2C9D  [+0x0AC9D]  59                       pop     cx
F000:2C9E  [+0x0AC9E]  5B                       pop     bx
F000:2C9F  [+0x0AC9F]  58                       pop     ax
F000:2CA0  [+0x0ACA0]  C3                       ret
F000:2CA1  [+0x0ACA1]  40                       inc     ax
F000:2CA2  [+0x0ACA2]  00 11                    add     [bx+di],dl
F000:2CA4  [+0x0ACA4]  00 0D                    add     [di],cl
F000:2CA6  [+0x0ACA6]  00 07                    add     [bx],al
F000:2CA8  [+0x0ACA8]  00 05                    add     [di],al
F000:2CAA  [+0x0ACAA]  00 04                    add     [si],al
F000:2CAC  [+0x0ACAC]  00 03                    add     [bp+di],al
F000:2CAE  [+0x0ACAE]  00 FF                    add     bh,bh
F000:2CB0  [+0x0ACB0]  FF 24                    jmp     word [si]
F000:2CB2  [+0x0ACB2]  25 26 2A                 and     ax,2A26h
F000:2CB5  [+0x0ACB5]  2B 2C                    sub     bp,[si]
F000:2CB7  [+0x0ACB7]  2D 2E 2F                 sub     ax,2F2Eh
F000:2CBA  [+0x0ACBA]  32 33                    xor     dh,[bp+di]
F000:2CBC  [+0x0ACBC]  34 35                    xor     al,35h
F000:2CBE  [+0x0ACBE]  36 37                    aaa
F000:2CC0  [+0x0ACC0]  38 39                    cmp     [bx+di],bh
F000:2CC2  [+0x0ACC2]  3A 3B                    cmp     bh,[bp+di]
F000:2CC4  [+0x0ACC4]  3C 3D                    cmp     al,3Dh
F000:2CC6  [+0x0ACC6]  3E 3F                    aas
F000:2CC8  [+0x0ACC8]  FF 4B 65                 dec     word [bp+di+65h]
F000:2CCB  [+0x0ACCB]  79 62                    jns     short 2D2Fh
F000:2CCD  [+0x0ACCD]  6F                       outsw
F000:2CCE  [+0x0ACCE]  61                       popa
F000:2CCF  [+0x0ACCF]  72 64                    jb      short 2D35h
F000:2CD1  [+0x0ACD1]  50                       push    ax
F000:2CD2  [+0x0ACD2]  4D                       dec     bp
F000:2CD3  [+0x0ACD3]  53                       push    bx
F000:2CD4  [+0x0ACD4]  52                       push    dx
F000:2CD5  [+0x0ACD5]  20 20                    and     [bx+si],ah
F000:2CD7  [+0x0ACD7]  20 00                    and     [bx+si],al
F000:2CD9  [+0x0ACD9]  9C                       pushf
F000:2CDA  [+0x0ACDA]  FA                       cli
F000:2CDB  [+0x0ACDB]  57                       push    di
F000:2CDC  [+0x0ACDC]  56                       push    si
F000:2CDD  [+0x0ACDD]  50                       push    ax
F000:2CDE  [+0x0ACDE]  BF B0 04                 mov     di,4B0h
F000:2CE1  [+0x0ACE1]  BE C9 2C                 mov     si,2CC9h
F000:2CE4  [+0x0ACE4]  2E 8A 04                 mov     al,[cs:si]
F000:2CE7  [+0x0ACE7]  88 05                    mov     [di],al
F000:2CE9  [+0x0ACE9]  47                       inc     di
F000:2CEA  [+0x0ACEA]  46                       inc     si
F000:2CEB  [+0x0ACEB]  3C 00                    cmp     al,0
F000:2CED  [+0x0ACED]  75 F5                    jne     short 2CE4h
F000:2CEF  [+0x0ACEF]  58                       pop     ax
F000:2CF0  [+0x0ACF0]  5E                       pop     si
F000:2CF1  [+0x0ACF1]  5F                       pop     di
F000:2CF2  [+0x0ACF2]  9D                       popf
F000:2CF3  [+0x0ACF3]  F8                       clc
F000:2CF4  [+0x0ACF4]  C3                       ret
F000:2CF5  [+0x0ACF5]  F8                       clc
F000:2CF6  [+0x0ACF6]  C3                       ret
F000:2CF7  [+0x0ACF7]  F8                       clc
F000:2CF8  [+0x0ACF8]  C3                       ret
F000:2CF9  [+0x0ACF9]  F8                       clc
F000:2CFA  [+0x0ACFA]  C3                       ret
F000:2CFB  [+0x0ACFB]  F8                       clc
F000:2CFC  [+0x0ACFC]  C3                       ret
F000:2CFD  [+0x0ACFD]  9C                       pushf
F000:2CFE  [+0x0ACFE]  FA                       cli
F000:2CFF  [+0x0ACFF]  C7 06 7F 05 00 00        mov     word [57Fh],0
F000:2D05  [+0x0AD05]  C7 06 81 05 00 00        mov     word [581h],0
F000:2D0B  [+0x0AD0B]  C7 06 83 05 00 00        mov     word [583h],0
F000:2D11  [+0x0AD11]  E8 1E 00                 call    2D32h
F000:2D14  [+0x0AD14]  E8 3B 00                 call    2D52h
F000:2D17  [+0x0AD17]  E8 5C 02                 call    2F76h
F000:2D1A  [+0x0AD1A]  E8 A1 02                 call    2FBEh
F000:2D1D  [+0x0AD1D]  E8 31 03                 call    3051h
F000:2D20  [+0x0AD20]  E8 93 03                 call    30B6h
F000:2D23  [+0x0AD23]  E8 C2 03                 call    30E8h
F000:2D26  [+0x0AD26]  E8 E5 03                 call    310Eh
F000:2D29  [+0x0AD29]  E8 06 04                 call    3132h
F000:2D2C  [+0x0AD2C]  E8 27 04                 call    3156h
F000:2D2F  [+0x0AD2F]  9D                       popf
F000:2D30  [+0x0AD30]  F8                       clc
F000:2D31  [+0x0AD31]  C3                       ret
F000:2D32  [+0x0AD32]  50                       push    ax
F000:2D33  [+0x0AD33]  E4 60                    in      al,60h
F000:2D35  [+0x0AD35]  B0 20                    mov     al,20h
F000:2D37  [+0x0AD37]  E8 80 09                 call    36BAh
F000:2D3A  [+0x0AD3A]  E6 64                    out     64h,al
F000:2D3C  [+0x0AD3C]  B0 AD                    mov     al,0ADh
F000:2D3E  [+0x0AD3E]  E8 79 09                 call    36BAh
F000:2D41  [+0x0AD41]  E6 64                    out     64h,al
F000:2D43  [+0x0AD43]  B0 A7                    mov     al,0A7h
F000:2D45  [+0x0AD45]  E8 72 09                 call    36BAh
F000:2D48  [+0x0AD48]  E6 64                    out     64h,al
F000:2D4A  [+0x0AD4A]  E8 76 09                 call    36C3h
F000:2D4D  [+0x0AD4D]  A2 C8 04                 mov     [4C8h],al
F000:2D50  [+0x0AD50]  58                       pop     ax
F000:2D51  [+0x0AD51]  C3                       ret
F000:2D52  [+0x0AD52]  06                       push    es
F000:2D53  [+0x0AD53]  50                       push    ax
F000:2D54  [+0x0AD54]  2E 8E 06 A1 2C           mov     es,[cs:2CA1h]
F000:2D59  [+0x0AD59]  26 A0 17 00              mov     al,[es:17h]
F000:2D5D  [+0x0AD5D]  24 70                    and     al,70h
F000:2D5F  [+0x0AD5F]  D0 E8                    shr     al,1
F000:2D61  [+0x0AD61]  D0 E8                    shr     al,1
F000:2D63  [+0x0AD63]  D0 E8                    shr     al,1
F000:2D65  [+0x0AD65]  D0 E8                    shr     al,1
F000:2D67  [+0x0AD67]  A2 C5 04                 mov     [4C5h],al
F000:2D6A  [+0x0AD6A]  0C 20                    or      al,20h
F000:2D6C  [+0x0AD6C]  A2 D0 04                 mov     [4D0h],al
F000:2D6F  [+0x0AD6F]  C6 06 D1 04 2B           mov     byte [4D1h],2Bh
F000:2D74  [+0x0AD74]  C6 06 C1 04 00           mov     byte [4C1h],0
F000:2D79  [+0x0AD79]  C6 06 C2 04 00           mov     byte [4C2h],0
F000:2D7E  [+0x0AD7E]  C6 06 C0 04 00           mov     byte [4C0h],0
F000:2D83  [+0x0AD83]  E8 12 00                 call    2D98h
F000:2D86  [+0x0AD86]  E8 5B 00                 call    2DE4h
F000:2D89  [+0x0AD89]  E8 84 00                 call    2E10h
F000:2D8C  [+0x0AD8C]  E8 AD 00                 call    2E3Ch
F000:2D8F  [+0x0AD8F]  E8 09 01                 call    2E9Bh
F000:2D92  [+0x0AD92]  E8 7A 01                 call    2F0Fh
F000:2D95  [+0x0AD95]  58                       pop     ax
F000:2D96  [+0x0AD96]  07                       pop     es
F000:2D97  [+0x0AD97]  C3                       ret
F000:2D98  [+0x0AD98]  51                       push    cx
F000:2D99  [+0x0AD99]  50                       push    ax
F000:2D9A  [+0x0AD9A]  80 0E C0 04 80           or      byte [4C0h],80h
F000:2D9F  [+0x0AD9F]  E4 60                    in      al,60h
F000:2DA1  [+0x0ADA1]  B0 A1                    mov     al,0A1h
F000:2DA3  [+0x0ADA3]  E8 14 09                 call    36BAh
F000:2DA6  [+0x0ADA6]  E6 64                    out     64h,al
F000:2DA8  [+0x0ADA8]  B9 32 00                 mov     cx,32h
F000:2DAB  [+0x0ADAB]  E8 20 09                 call    36CEh
F000:2DAE  [+0x0ADAE]  72 31                    jb      short 2DE1h
F000:2DB0  [+0x0ADB0]  83 0E 7F 05 01           or      word [57Fh],1
F000:2DB5  [+0x0ADB5]  B4 00                    mov     ah,0
F000:2DB7  [+0x0ADB7]  A3 C3 04                 mov     [4C3h],ax
F000:2DBA  [+0x0ADBA]  B0 CA                    mov     al,0CAh
F000:2DBC  [+0x0ADBC]  E8 FB 08                 call    36BAh
F000:2DBF  [+0x0ADBF]  E6 64                    out     64h,al
F000:2DC1  [+0x0ADC1]  B9 32 00                 mov     cx,32h
F000:2DC4  [+0x0ADC4]  E8 07 09                 call    36CEh
F000:2DC7  [+0x0ADC7]  72 18                    jb      short 2DE1h
F000:2DC9  [+0x0ADC9]  83 0E 7F 05 02           or      word [57Fh],2
F000:2DCE  [+0x0ADCE]  80 26 C0 04 7F           and     byte [4C0h],7Fh
F000:2DD3  [+0x0ADD3]  A8 01                    test    al,1
F000:2DD5  [+0x0ADD5]  74 0A                    je      short 2DE1h
F000:2DD7  [+0x0ADD7]  83 0E 7F 05 04           or      word [57Fh],4
F000:2DDC  [+0x0ADDC]  80 0E C5 04 80           or      byte [4C5h],80h
F000:2DE1  [+0x0ADE1]  58                       pop     ax
F000:2DE2  [+0x0ADE2]  59                       pop     cx
F000:2DE3  [+0x0ADE3]  C3                       ret
F000:2DE4  [+0x0ADE4]  51                       push    cx
F000:2DE5  [+0x0ADE5]  50                       push    ax
F000:2DE6  [+0x0ADE6]  F6 06 C0 04 80           test    byte [4C0h],80h
F000:2DEB  [+0x0ADEB]  74 20                    je      short 2E0Dh
F000:2DED  [+0x0ADED]  83 0E 7F 05 08           or      word [57Fh],8
F000:2DF2  [+0x0ADF2]  E4 60                    in      al,60h
F000:2DF4  [+0x0ADF4]  B0 A9                    mov     al,0A9h
F000:2DF6  [+0x0ADF6]  E8 C1 08                 call    36BAh
F000:2DF9  [+0x0ADF9]  E6 64                    out     64h,al
F000:2DFB  [+0x0ADFB]  B9 32 00                 mov     cx,32h
F000:2DFE  [+0x0ADFE]  E8 CD 08                 call    36CEh
F000:2E01  [+0x0AE01]  72 0A                    jb      short 2E0Dh
F000:2E03  [+0x0AE03]  83 0E 7F 05 10           or      word [57Fh],10h
F000:2E08  [+0x0AE08]  80 0E C5 04 80           or      byte [4C5h],80h
F000:2E0D  [+0x0AE0D]  58                       pop     ax
F000:2E0E  [+0x0AE0E]  59                       pop     cx
F000:2E0F  [+0x0AE0F]  C3                       ret
F000:2E10  [+0x0AE10]  51                       push    cx
F000:2E11  [+0x0AE11]  50                       push    ax
F000:2E12  [+0x0AE12]  F6 06 C0 04 80           test    byte [4C0h],80h
F000:2E17  [+0x0AE17]  74 20                    je      short 2E39h
F000:2E19  [+0x0AE19]  83 0E 7F 05 20           or      word [57Fh],20h
F000:2E1E  [+0x0AE1E]  E4 60                    in      al,60h
F000:2E20  [+0x0AE20]  B0 BA                    mov     al,0BAh
F000:2E22  [+0x0AE22]  E8 95 08                 call    36BAh
F000:2E25  [+0x0AE25]  E6 64                    out     64h,al
F000:2E27  [+0x0AE27]  B9 32 00                 mov     cx,32h
F000:2E2A  [+0x0AE2A]  E8 A1 08                 call    36CEh
F000:2E2D  [+0x0AE2D]  72 0A                    jb      short 2E39h
F000:2E2F  [+0x0AE2F]  83 0E 7F 05 40           or      word [57Fh],40h
F000:2E34  [+0x0AE34]  80 0E C0 04 40           or      byte [4C0h],40h
F000:2E39  [+0x0AE39]  58                       pop     ax
F000:2E3A  [+0x0AE3A]  59                       pop     cx
F000:2E3B  [+0x0AE3B]  C3                       ret
F000:2E3C  [+0x0AE3C]  51                       push    cx
F000:2E3D  [+0x0AE3D]  50                       push    ax
F000:2E3E  [+0x0AE3E]  F6 06 C0 04 40           test    byte [4C0h],40h
F000:2E43  [+0x0AE43]  74 53                    je      short 2E98h
F000:2E45  [+0x0AE45]  81 0E 7F 05 80 00        or      word [57Fh],80h
F000:2E4B  [+0x0AE4B]  E4 60                    in      al,60h
F000:2E4D  [+0x0AE4D]  B0 B9                    mov     al,0B9h
F000:2E4F  [+0x0AE4F]  E8 68 08                 call    36BAh
F000:2E52  [+0x0AE52]  E6 64                    out     64h,al
F000:2E54  [+0x0AE54]  B9 32 00                 mov     cx,32h
F000:2E57  [+0x0AE57]  E8 74 08                 call    36CEh
F000:2E5A  [+0x0AE5A]  72 3C                    jb      short 2E98h
F000:2E5C  [+0x0AE5C]  81 0E 7F 05 00 01        or      word [57Fh],100h
F000:2E62  [+0x0AE62]  A2 C6 04                 mov     [4C6h],al
F000:2E65  [+0x0AE65]  B0 B8                    mov     al,0B8h
F000:2E67  [+0x0AE67]  E8 50 08                 call    36BAh
F000:2E6A  [+0x0AE6A]  E6 64                    out     64h,al
F000:2E6C  [+0x0AE6C]  A0 C6 04                 mov     al,[4C6h]
F000:2E6F  [+0x0AE6F]  F6 D0                    not     al
F000:2E71  [+0x0AE71]  E8 46 08                 call    36BAh
F000:2E74  [+0x0AE74]  E6 60                    out     60h,al
F000:2E76  [+0x0AE76]  B0 B9                    mov     al,0B9h
F000:2E78  [+0x0AE78]  E8 3F 08                 call    36BAh
F000:2E7B  [+0x0AE7B]  E6 64                    out     64h,al
F000:2E7D  [+0x0AE7D]  B9 32 00                 mov     cx,32h
F000:2E80  [+0x0AE80]  E8 4B 08                 call    36CEh
F000:2E83  [+0x0AE83]  8A 26 C6 04              mov     ah,[4C6h]
F000:2E87  [+0x0AE87]  F6 D4                    not     ah
F000:2E89  [+0x0AE89]  3A C4                    cmp     al,ah
F000:2E8B  [+0x0AE8B]  75 0B                    jne     short 2E98h
F000:2E8D  [+0x0AE8D]  81 0E 7F 05 00 02        or      word [57Fh],200h
F000:2E93  [+0x0AE93]  80 0E C0 04 20           or      byte [4C0h],20h
F000:2E98  [+0x0AE98]  58                       pop     ax
F000:2E99  [+0x0AE99]  59                       pop     cx
F000:2E9A  [+0x0AE9A]  C3                       ret
F000:2E9B  [+0x0AE9B]  51                       push    cx
F000:2E9C  [+0x0AE9C]  53                       push    bx
F000:2E9D  [+0x0AE9D]  50                       push    ax
F000:2E9E  [+0x0AE9E]  F6 06 C0 04 40           test    byte [4C0h],40h
F000:2EA3  [+0x0AEA3]  74 66                    je      short 2F0Bh
F000:2EA5  [+0x0AEA5]  81 0E 7F 05 00 04        or      word [57Fh],400h
F000:2EAB  [+0x0AEAB]  B0 D5                    mov     al,0D5h
F000:2EAD  [+0x0AEAD]  B3 D6                    mov     bl,0D6h
F000:2EAF  [+0x0AEAF]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:2EB4  [+0x0AEB4]  75 27                    jne     short 2EDDh
F000:2EB6  [+0x0AEB6]  81 0E 7F 05 00 08        or      word [57Fh],800h
F000:2EBC  [+0x0AEBC]  C7 06 C3 04 80 24        mov     word [4C3h],2480h
F000:2EC2  [+0x0AEC2]  C6 06 C1 04 73           mov     byte [4C1h],73h
F000:2EC7  [+0x0AEC7]  C6 06 C2 04 80           mov     byte [4C2h],80h
F000:2ECC  [+0x0AECC]  F6 06 C5 04 80           test    byte [4C5h],80h
F000:2ED1  [+0x0AED1]  74 0A                    je      short 2EDDh
F000:2ED3  [+0x0AED3]  81 0E 7F 05 00 10        or      word [57Fh],1000h
F000:2ED9  [+0x0AED9]  B0 D7                    mov     al,0D7h
F000:2EDB  [+0x0AEDB]  B3 D8                    mov     bl,0D8h
F000:2EDD  [+0x0AEDD]  E8 DA 07                 call    36BAh
F000:2EE0  [+0x0AEE0]  E6 64                    out     64h,al
F000:2EE2  [+0x0AEE2]  B9 32 00                 mov     cx,32h
F000:2EE5  [+0x0AEE5]  E8 E6 07                 call    36CEh
F000:2EE8  [+0x0AEE8]  72 21                    jb      short 2F0Bh
F000:2EEA  [+0x0AEEA]  81 0E 7F 05 00 20        or      word [57Fh],2000h
F000:2EF0  [+0x0AEF0]  8A E0                    mov     ah,al
F000:2EF2  [+0x0AEF2]  E8 CE 07                 call    36C3h
F000:2EF5  [+0x0AEF5]  A3 C3 04                 mov     [4C3h],ax
F000:2EF8  [+0x0AEF8]  8A C3                    mov     al,bl
F000:2EFA  [+0x0AEFA]  E8 BD 07                 call    36BAh
F000:2EFD  [+0x0AEFD]  E6 64                    out     64h,al
F000:2EFF  [+0x0AEFF]  E8 C1 07                 call    36C3h
F000:2F02  [+0x0AF02]  A2 C1 04                 mov     [4C1h],al
F000:2F05  [+0x0AF05]  E8 BB 07                 call    36C3h
F000:2F08  [+0x0AF08]  A2 C2 04                 mov     [4C2h],al
F000:2F0B  [+0x0AF0B]  58                       pop     ax
F000:2F0C  [+0x0AF0C]  5B                       pop     bx
F000:2F0D  [+0x0AF0D]  59                       pop     cx
F000:2F0E  [+0x0AF0E]  C3                       ret
F000:2F0F  [+0x0AF0F]  50                       push    ax
F000:2F10  [+0x0AF10]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:2F15  [+0x0AF15]  74 5D                    je      short 2F74h
F000:2F17  [+0x0AF17]  81 0E 7F 05 00 40        or      word [57Fh],4000h
F000:2F1D  [+0x0AF1D]  F6 06 C1 04 80           test    byte [4C1h],80h
F000:2F22  [+0x0AF22]  74 05                    je      short 2F29h
F000:2F24  [+0x0AF24]  80 0E C0 04 04           or      byte [4C0h],4
F000:2F29  [+0x0AF29]  F6 06 C1 04 08           test    byte [4C1h],8
F000:2F2E  [+0x0AF2E]  74 05                    je      short 2F35h
F000:2F30  [+0x0AF30]  80 0E C0 04 02           or      byte [4C0h],2
F000:2F35  [+0x0AF35]  F6 06 C1 04 01           test    byte [4C1h],1
F000:2F3A  [+0x0AF3A]  74 05                    je      short 2F41h
F000:2F3C  [+0x0AF3C]  80 0E C0 04 01           or      byte [4C0h],1
F000:2F41  [+0x0AF41]  A0 C0 04                 mov     al,[4C0h]
F000:2F44  [+0x0AF44]  24 07                    and     al,7
F000:2F46  [+0x0AF46]  3C 01                    cmp     al,1
F000:2F48  [+0x0AF48]  75 2A                    jne     short 2F74h
F000:2F4A  [+0x0AF4A]  81 0E 7F 05 00 80        or      word [57Fh],8000h
F000:2F50  [+0x0AF50]  81 3E C3 04 55 01        cmp     word [4C3h],155h
F000:2F56  [+0x0AF56]  77 1C                    ja      short 2F74h
F000:2F58  [+0x0AF58]  83 0E 81 05 01           or      word [581h],1
F000:2F5D  [+0x0AF5D]  80 0E C0 04 10           or      byte [4C0h],10h
F000:2F62  [+0x0AF62]  81 3E C3 04 48 01        cmp     word [4C3h],148h
F000:2F68  [+0x0AF68]  77 0A                    ja      short 2F74h
F000:2F6A  [+0x0AF6A]  83 0E 81 05 02           or      word [581h],2
F000:2F6F  [+0x0AF6F]  80 0E C0 04 08           or      byte [4C0h],8
F000:2F74  [+0x0AF74]  58                       pop     ax
F000:2F75  [+0x0AF75]  C3                       ret
F000:2F76  [+0x0AF76]  57                       push    di
F000:2F77  [+0x0AF77]  51                       push    cx
F000:2F78  [+0x0AF78]  50                       push    ax
F000:2F79  [+0x0AF79]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:2F7E  [+0x0AF7E]  74 3A                    je      short 2FBAh
F000:2F80  [+0x0AF80]  83 0E 81 05 04           or      word [581h],4
F000:2F85  [+0x0AF85]  BF C9 04                 mov     di,4C9h
F000:2F88  [+0x0AF88]  B4 01                    mov     ah,1
F000:2F8A  [+0x0AF8A]  B9 0A 00                 mov     cx,0Ah
F000:2F8D  [+0x0AF8D]  F6 06 C1 04 20           test    byte [4C1h],20h
F000:2F92  [+0x0AF92]  74 08                    je      short 2F9Ch
F000:2F94  [+0x0AF94]  83 0E 81 05 08           or      word [581h],8
F000:2F99  [+0x0AF99]  B9 14 00                 mov     cx,14h
F000:2F9C  [+0x0AF9C]  E8 C2 06                 call    3661h
F000:2F9F  [+0x0AF9F]  88 05                    mov     [di],al
F000:2FA1  [+0x0AFA1]  47                       inc     di
F000:2FA2  [+0x0AFA2]  FE C4                    inc     ah
F000:2FA4  [+0x0AFA4]  E2 F6                    loop    2F9Ch
F000:2FA6  [+0x0AFA6]  F6 06 C0 04 08           test    byte [4C0h],8
F000:2FAB  [+0x0AFAB]  74 0D                    je      short 2FBAh
F000:2FAD  [+0x0AFAD]  83 0E 81 05 10           or      word [581h],10h
F000:2FB2  [+0x0AFB2]  B4 2A                    mov     ah,2Ah
F000:2FB4  [+0x0AFB4]  E8 74 06                 call    362Bh
F000:2FB7  [+0x0AFB7]  A2 D8 04                 mov     [4D8h],al
F000:2FBA  [+0x0AFBA]  58                       pop     ax
F000:2FBB  [+0x0AFBB]  59                       pop     cx
F000:2FBC  [+0x0AFBC]  5F                       pop     di
F000:2FBD  [+0x0AFBD]  C3                       ret
F000:2FBE  [+0x0AFBE]  57                       push    di
F000:2FBF  [+0x0AFBF]  51                       push    cx
F000:2FC0  [+0x0AFC0]  50                       push    ax
F000:2FC1  [+0x0AFC1]  F6 06 C0 04 40           test    byte [4C0h],40h
F000:2FC6  [+0x0AFC6]  74 F2                    je      short 2FBAh
F000:2FC8  [+0x0AFC8]  83 0E 81 05 20           or      word [581h],20h
F000:2FCD  [+0x0AFCD]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:2FD2  [+0x0AFD2]  74 26                    je      short 2FFAh
F000:2FD4  [+0x0AFD4]  83 0E 81 05 40           or      word [581h],40h
F000:2FD9  [+0x0AFD9]  BF DF 04                 mov     di,4DFh
F000:2FDC  [+0x0AFDC]  8A 26 CE 04              mov     ah,[4CEh]
F000:2FE0  [+0x0AFE0]  B9 09 00                 mov     cx,9
F000:2FE3  [+0x0AFE3]  E8 45 06                 call    362Bh
F000:2FE6  [+0x0AFE6]  88 05                    mov     [di],al
F000:2FE8  [+0x0AFE8]  47                       inc     di
F000:2FE9  [+0x0AFE9]  FE C4                    inc     ah
F000:2FEB  [+0x0AFEB]  E2 F6                    loop    2FE3h
F000:2FED  [+0x0AFED]  B4 01                    mov     ah,1
F000:2FEF  [+0x0AFEF]  E8 6F 06                 call    3661h
F000:2FF2  [+0x0AFF2]  24 F7                    and     al,0F7h
F000:2FF4  [+0x0AFF4]  E8 83 06                 call    367Ah
F000:2FF7  [+0x0AFF7]  EB 54                    jmp     short 304Dh
F000:2FF9  [+0x0AFF9]  90                       nop
F000:2FFA  [+0x0AFFA]  80 26 C9 04 F7           and     byte [4C9h],0F7h
F000:2FFF  [+0x0AFFF]  B0 FE                    mov     al,0FEh
F000:3001  [+0x0B001]  E8 B6 06                 call    36BAh
F000:3004  [+0x0B004]  E6 60                    out     60h,al
F000:3006  [+0x0B006]  B9 32 00                 mov     cx,32h
F000:3009  [+0x0B009]  E8 C2 06                 call    36CEh
F000:300C  [+0x0B00C]  73 3F                    jae     short 304Dh
F000:300E  [+0x0B00E]  81 0E 81 05 80 00        or      word [581h],80h
F000:3014  [+0x0B014]  80 0E C9 04 08           or      byte [4C9h],8
F000:3019  [+0x0B019]  E4 60                    in      al,60h
F000:301B  [+0x0B01B]  B0 AA                    mov     al,0AAh
F000:301D  [+0x0B01D]  E8 9A 06                 call    36BAh
F000:3020  [+0x0B020]  E6 64                    out     64h,al
F000:3022  [+0x0B022]  E8 9E 06                 call    36C3h
F000:3025  [+0x0B025]  8A 26 C8 04              mov     ah,[4C8h]
F000:3029  [+0x0B029]  80 CC 10                 or      ah,10h
F000:302C  [+0x0B02C]  F6 06 C5 04 80           test    byte [4C5h],80h
F000:3031  [+0x0B031]  74 09                    je      short 303Ch
F000:3033  [+0x0B033]  81 0E 81 05 00 01        or      word [581h],100h
F000:3039  [+0x0B039]  80 CC 20                 or      ah,20h
F000:303C  [+0x0B03C]  B0 60                    mov     al,60h
F000:303E  [+0x0B03E]  E8 79 06                 call    36BAh
F000:3041  [+0x0B041]  E6 64                    out     64h,al
F000:3043  [+0x0B043]  8A C4                    mov     al,ah
F000:3045  [+0x0B045]  E8 72 06                 call    36BAh
F000:3048  [+0x0B048]  E6 60                    out     60h,al
F000:304A  [+0x0B04A]  E8 6D 06                 call    36BAh
F000:304D  [+0x0B04D]  58                       pop     ax
F000:304E  [+0x0B04E]  59                       pop     cx
F000:304F  [+0x0B04F]  5F                       pop     di
F000:3050  [+0x0B050]  C3                       ret
F000:3051  [+0x0B051]  50                       push    ax
F000:3052  [+0x0B052]  F6 06 C5 04 80           test    byte [4C5h],80h
F000:3057  [+0x0B057]  74 5B                    je      short 30B4h
F000:3059  [+0x0B059]  81 0E 81 05 00 02        or      word [581h],200h
F000:305F  [+0x0B05F]  80 26 C5 04 E7           and     byte [4C5h],0E7h
F000:3064  [+0x0B064]  C6 06 DC 04 00           mov     byte [4DCh],0
F000:3069  [+0x0B069]  C6 06 DD 04 02           mov     byte [4DDh],2
F000:306E  [+0x0B06E]  C6 06 DE 04 64           mov     byte [4DEh],64h
F000:3073  [+0x0B073]  E4 60                    in      al,60h
F000:3075  [+0x0B075]  B4 E9                    mov     ah,0E9h
F000:3077  [+0x0B077]  E8 9F 05                 call    3619h
F000:307A  [+0x0B07A]  3C E9                    cmp     al,0E9h
F000:307C  [+0x0B07C]  75 15                    jne     short 3093h
F000:307E  [+0x0B07E]  81 0E 81 05 00 04        or      word [581h],400h
F000:3084  [+0x0B084]  80 0E C5 04 08           or      byte [4C5h],8
F000:3089  [+0x0B089]  B4 EC                    mov     ah,0ECh
F000:308B  [+0x0B08B]  E8 8B 05                 call    3619h
F000:308E  [+0x0B08E]  B4 E9                    mov     ah,0E9h
F000:3090  [+0x0B090]  E8 86 05                 call    3619h
F000:3093  [+0x0B093]  3C FA                    cmp     al,0FAh
F000:3095  [+0x0B095]  75 1D                    jne     short 30B4h
F000:3097  [+0x0B097]  81 0E 81 05 00 08        or      word [581h],800h
F000:309D  [+0x0B09D]  E8 23 06                 call    36C3h
F000:30A0  [+0x0B0A0]  A2 DC 04                 mov     [4DCh],al
F000:30A3  [+0x0B0A3]  E8 1D 06                 call    36C3h
F000:30A6  [+0x0B0A6]  A2 DD 04                 mov     [4DDh],al
F000:30A9  [+0x0B0A9]  E8 17 06                 call    36C3h
F000:30AC  [+0x0B0AC]  A2 DE 04                 mov     [4DEh],al
F000:30AF  [+0x0B0AF]  80 0E C5 04 10           or      byte [4C5h],10h
F000:30B4  [+0x0B0B4]  58                       pop     ax
F000:30B5  [+0x0B0B5]  C3                       ret
F000:30B6  [+0x0B0B6]  50                       push    ax
F000:30B7  [+0x0B0B7]  E4 60                    in      al,60h
F000:30B9  [+0x0B0B9]  B0 F5                    mov     al,0F5h
F000:30BB  [+0x0B0BB]  E8 FC 05                 call    36BAh
F000:30BE  [+0x0B0BE]  E6 60                    out     60h,al
F000:30C0  [+0x0B0C0]  E8 00 06                 call    36C3h
F000:30C3  [+0x0B0C3]  B0 AD                    mov     al,0ADh
F000:30C5  [+0x0B0C5]  E8 F2 05                 call    36BAh
F000:30C8  [+0x0B0C8]  E6 64                    out     64h,al
F000:30CA  [+0x0B0CA]  F6 06 C5 04 80           test    byte [4C5h],80h
F000:30CF  [+0x0B0CF]  74 15                    je      short 30E6h
F000:30D1  [+0x0B0D1]  81 0E 81 05 00 10        or      word [581h],1000h
F000:30D7  [+0x0B0D7]  B4 F5                    mov     ah,0F5h
F000:30D9  [+0x0B0D9]  E8 3D 05                 call    3619h
F000:30DC  [+0x0B0DC]  B0 A7                    mov     al,0A7h
F000:30DE  [+0x0B0DE]  E8 D9 05                 call    36BAh
F000:30E1  [+0x0B0E1]  E6 64                    out     64h,al
F000:30E3  [+0x0B0E3]  E8 D4 05                 call    36BAh
F000:30E6  [+0x0B0E6]  58                       pop     ax
F000:30E7  [+0x0B0E7]  C3                       ret
F000:30E8  [+0x0B0E8]  57                       push    di
F000:30E9  [+0x0B0E9]  51                       push    cx
F000:30EA  [+0x0B0EA]  50                       push    ax
F000:30EB  [+0x0B0EB]  F6 06 C1 04 20           test    byte [4C1h],20h
F000:30F0  [+0x0B0F0]  74 18                    je      short 310Ah
F000:30F2  [+0x0B0F2]  81 0E 81 05 00 20        or      word [581h],2000h
F000:30F8  [+0x0B0F8]  BF FF 04                 mov     di,4FFh
F000:30FB  [+0x0B0FB]  B4 80                    mov     ah,80h
F000:30FD  [+0x0B0FD]  B9 80 00                 mov     cx,80h
F000:3100  [+0x0B100]  E8 28 05                 call    362Bh
F000:3103  [+0x0B103]  88 05                    mov     [di],al
F000:3105  [+0x0B105]  47                       inc     di
F000:3106  [+0x0B106]  FE C4                    inc     ah
F000:3108  [+0x0B108]  E2 F6                    loop    3100h
F000:310A  [+0x0B10A]  58                       pop     ax
F000:310B  [+0x0B10B]  59                       pop     cx
F000:310C  [+0x0B10C]  5F                       pop     di
F000:310D  [+0x0B10D]  C3                       ret
F000:310E  [+0x0B10E]  57                       push    di
F000:310F  [+0x0B10F]  56                       push    si
F000:3110  [+0x0B110]  51                       push    cx
F000:3111  [+0x0B111]  50                       push    ax
F000:3112  [+0x0B112]  BF E8 04                 mov     di,4E8h
F000:3115  [+0x0B115]  BE B1 2C                 mov     si,2CB1h
F000:3118  [+0x0B118]  2E 8A 04                 mov     al,[cs:si]
F000:311B  [+0x0B11B]  3C FF                    cmp     al,0FFh
F000:311D  [+0x0B11D]  74 0E                    je      short 312Dh
F000:311F  [+0x0B11F]  E8 98 05                 call    36BAh
F000:3122  [+0x0B122]  E6 64                    out     64h,al
F000:3124  [+0x0B124]  E8 9C 05                 call    36C3h
F000:3127  [+0x0B127]  88 05                    mov     [di],al
F000:3129  [+0x0B129]  46                       inc     si
F000:312A  [+0x0B12A]  47                       inc     di
F000:312B  [+0x0B12B]  EB EB                    jmp     short 3118h
F000:312D  [+0x0B12D]  58                       pop     ax
F000:312E  [+0x0B12E]  59                       pop     cx
F000:312F  [+0x0B12F]  5E                       pop     si
F000:3130  [+0x0B130]  5F                       pop     di
F000:3131  [+0x0B131]  C3                       ret
F000:3132  [+0x0B132]  50                       push    ax
F000:3133  [+0x0B133]  E4 60                    in      al,60h
F000:3135  [+0x0B135]  B0 D0                    mov     al,0D0h
F000:3137  [+0x0B137]  E8 80 05                 call    36BAh
F000:313A  [+0x0B13A]  E6 64                    out     64h,al
F000:313C  [+0x0B13C]  E8 84 05                 call    36C3h
F000:313F  [+0x0B13F]  24 02                    and     al,2
F000:3141  [+0x0B141]  0C DD                    or      al,0DDh
F000:3143  [+0x0B143]  A2 C7 04                 mov     [4C7h],al
F000:3146  [+0x0B146]  B0 D1                    mov     al,0D1h
F000:3148  [+0x0B148]  E8 6F 05                 call    36BAh
F000:314B  [+0x0B14B]  E6 64                    out     64h,al
F000:314D  [+0x0B14D]  E8 6A 05                 call    36BAh
F000:3150  [+0x0B150]  B0 DF                    mov     al,0DFh
F000:3152  [+0x0B152]  E6 60                    out     60h,al
F000:3154  [+0x0B154]  58                       pop     ax
F000:3155  [+0x0B155]  C3                       ret
F000:3156  [+0x0B156]  E4 60                    in      al,60h
F000:3158  [+0x0B158]  B0 ED                    mov     al,0EDh
F000:315A  [+0x0B15A]  E8 5D 05                 call    36BAh
F000:315D  [+0x0B15D]  E6 60                    out     60h,al
F000:315F  [+0x0B15F]  E8 61 05                 call    36C3h
F000:3162  [+0x0B162]  3C FA                    cmp     al,0FAh
F000:3164  [+0x0B164]  75 0C                    jne     short 3172h
F000:3166  [+0x0B166]  83 0E 83 05 01           or      word [583h],1
F000:316B  [+0x0B16B]  B0 00                    mov     al,0
F000:316D  [+0x0B16D]  E6 60                    out     60h,al
F000:316F  [+0x0B16F]  E8 51 05                 call    36C3h
F000:3172  [+0x0B172]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:3177  [+0x0B177]  74 32                    je      short 31ABh
F000:3179  [+0x0B179]  83 0E 83 05 02           or      word [583h],2
F000:317E  [+0x0B17E]  F6 06 C1 04 10           test    byte [4C1h],10h
F000:3183  [+0x0B183]  74 26                    je      short 31ABh
F000:3185  [+0x0B185]  83 0E 83 05 04           or      word [583h],4
F000:318A  [+0x0B18A]  F6 06 C0 04 08           test    byte [4C0h],8
F000:318F  [+0x0B18F]  75 1A                    jne     short 31ABh
F000:3191  [+0x0B191]  83 0E 83 05 08           or      word [583h],8
F000:3196  [+0x0B196]  A0 C0 04                 mov     al,[4C0h]
F000:3199  [+0x0B199]  24 07                    and     al,7
F000:319B  [+0x0B19B]  3C 05                    cmp     al,5
F000:319D  [+0x0B19D]  74 0C                    je      short 31ABh
F000:319F  [+0x0B19F]  83 0E 83 05 10           or      word [583h],10h
F000:31A4  [+0x0B1A4]  E8 13 05                 call    36BAh
F000:31A7  [+0x0B1A7]  B0 CB                    mov     al,0CBh
F000:31A9  [+0x0B1A9]  E6 64                    out     64h,al
F000:31AB  [+0x0B1AB]  C3                       ret
F000:31AC  [+0x0B1AC]  9C                       pushf
F000:31AD  [+0x0B1AD]  51                       push    cx
F000:31AE  [+0x0B1AE]  FA                       cli
F000:31AF  [+0x0B1AF]  C7 06 85 05 00 00        mov     word [585h],0
F000:31B5  [+0x0B1B5]  C7 06 87 05 00 00        mov     word [587h],0
F000:31BB  [+0x0B1BB]  C7 06 89 05 00 00        mov     word [589h],0
F000:31C1  [+0x0B1C1]  E8 28 00                 call    31ECh
F000:31C4  [+0x0B1C4]  E8 4E 00                 call    3215h
F000:31C7  [+0x0B1C7]  E8 5F 00                 call    3229h
F000:31CA  [+0x0B1CA]  E8 81 00                 call    324Eh
F000:31CD  [+0x0B1CD]  E8 A4 00                 call    3274h
F000:31D0  [+0x0B1D0]  E8 EC 00                 call    32BFh
F000:31D3  [+0x0B1D3]  E8 08 01                 call    32DEh
F000:31D6  [+0x0B1D6]  E8 65 01                 call    333Eh
F000:31D9  [+0x0B1D9]  E8 B1 01                 call    338Dh
F000:31DC  [+0x0B1DC]  E8 15 02                 call    33F4h
F000:31DF  [+0x0B1DF]  E8 DE 02                 call    34C0h
F000:31E2  [+0x0B1E2]  E8 A7 03                 call    358Ch
F000:31E5  [+0x0B1E5]  E8 15 04                 call    35FDh
F000:31E8  [+0x0B1E8]  59                       pop     cx
F000:31E9  [+0x0B1E9]  9D                       popf
F000:31EA  [+0x0B1EA]  F8                       clc
F000:31EB  [+0x0B1EB]  C3                       ret
F000:31EC  [+0x0B1EC]  50                       push    ax
F000:31ED  [+0x0B1ED]  E4 60                    in      al,60h
F000:31EF  [+0x0B1EF]  B0 AA                    mov     al,0AAh
F000:31F1  [+0x0B1F1]  E8 C6 04                 call    36BAh
F000:31F4  [+0x0B1F4]  E6 64                    out     64h,al
F000:31F6  [+0x0B1F6]  E8 CA 04                 call    36C3h
F000:31F9  [+0x0B1F9]  B0 AD                    mov     al,0ADh
F000:31FB  [+0x0B1FB]  E8 BC 04                 call    36BAh
F000:31FE  [+0x0B1FE]  E6 64                    out     64h,al
F000:3200  [+0x0B200]  F6 06 C5 04 80           test    byte [4C5h],80h
F000:3205  [+0x0B205]  74 0C                    je      short 3213h
F000:3207  [+0x0B207]  83 0E 85 05 01           or      word [585h],1
F000:320C  [+0x0B20C]  B0 A7                    mov     al,0A7h
F000:320E  [+0x0B20E]  E8 A9 04                 call    36BAh
F000:3211  [+0x0B211]  E6 64                    out     64h,al
F000:3213  [+0x0B213]  58                       pop     ax
F000:3214  [+0x0B214]  C3                       ret
F000:3215  [+0x0B215]  50                       push    ax
F000:3216  [+0x0B216]  E4 60                    in      al,60h
F000:3218  [+0x0B218]  B0 D1                    mov     al,0D1h
F000:321A  [+0x0B21A]  E8 9D 04                 call    36BAh
F000:321D  [+0x0B21D]  E6 64                    out     64h,al
F000:321F  [+0x0B21F]  A0 C7 04                 mov     al,[4C7h]
F000:3222  [+0x0B222]  E8 95 04                 call    36BAh
F000:3225  [+0x0B225]  E6 60                    out     60h,al
F000:3227  [+0x0B227]  58                       pop     ax
F000:3228  [+0x0B228]  C3                       ret
F000:3229  [+0x0B229]  57                       push    di
F000:322A  [+0x0B22A]  51                       push    cx
F000:322B  [+0x0B22B]  50                       push    ax
F000:322C  [+0x0B22C]  F6 06 C1 04 20           test    byte [4C1h],20h
F000:3231  [+0x0B231]  74 17                    je      short 324Ah
F000:3233  [+0x0B233]  83 0E 85 05 10           or      word [585h],10h
F000:3238  [+0x0B238]  BF FF 04                 mov     di,4FFh
F000:323B  [+0x0B23B]  B4 80                    mov     ah,80h
F000:323D  [+0x0B23D]  B9 80 00                 mov     cx,80h
F000:3240  [+0x0B240]  8A 05                    mov     al,[di]
F000:3242  [+0x0B242]  E8 FF 03                 call    3644h
F000:3245  [+0x0B245]  47                       inc     di
F000:3246  [+0x0B246]  FE C4                    inc     ah
F000:3248  [+0x0B248]  E2 F6                    loop    3240h
F000:324A  [+0x0B24A]  58                       pop     ax
F000:324B  [+0x0B24B]  59                       pop     cx
F000:324C  [+0x0B24C]  5F                       pop     di
F000:324D  [+0x0B24D]  C3                       ret
F000:324E  [+0x0B24E]  57                       push    di
F000:324F  [+0x0B24F]  56                       push    si
F000:3250  [+0x0B250]  50                       push    ax
F000:3251  [+0x0B251]  BF E8 04                 mov     di,4E8h
F000:3254  [+0x0B254]  BE B1 2C                 mov     si,2CB1h
F000:3257  [+0x0B257]  2E 8A 04                 mov     al,[cs:si]
F000:325A  [+0x0B25A]  3C FF                    cmp     al,0FFh
F000:325C  [+0x0B25C]  74 12                    je      short 3270h
F000:325E  [+0x0B25E]  0C 40                    or      al,40h
F000:3260  [+0x0B260]  E8 57 04                 call    36BAh
F000:3263  [+0x0B263]  E6 64                    out     64h,al
F000:3265  [+0x0B265]  8A 05                    mov     al,[di]
F000:3267  [+0x0B267]  E8 50 04                 call    36BAh
F000:326A  [+0x0B26A]  E6 60                    out     60h,al
F000:326C  [+0x0B26C]  46                       inc     si
F000:326D  [+0x0B26D]  47                       inc     di
F000:326E  [+0x0B26E]  EB E7                    jmp     short 3257h
F000:3270  [+0x0B270]  58                       pop     ax
F000:3271  [+0x0B271]  5E                       pop     si
F000:3272  [+0x0B272]  5F                       pop     di
F000:3273  [+0x0B273]  C3                       ret
F000:3274  [+0x0B274]  57                       push    di
F000:3275  [+0x0B275]  56                       push    si
F000:3276  [+0x0B276]  50                       push    ax
F000:3277  [+0x0B277]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:327C  [+0x0B27C]  74 3D                    je      short 32BBh
F000:327E  [+0x0B27E]  83 0E 85 05 20           or      word [585h],20h
F000:3283  [+0x0B283]  BE A7 2C                 mov     si,2CA7h
F000:3286  [+0x0B286]  F6 06 C1 04 20           test    byte [4C1h],20h
F000:328B  [+0x0B28B]  74 15                    je      short 32A2h
F000:328D  [+0x0B28D]  83 0E 85 05 40           or      word [585h],40h
F000:3292  [+0x0B292]  F6 06 C0 04 10           test    byte [4C0h],10h
F000:3297  [+0x0B297]  75 09                    jne     short 32A2h
F000:3299  [+0x0B299]  81 0E 85 05 80 00        or      word [585h],80h
F000:329F  [+0x0B29F]  BE A3 2C                 mov     si,2CA3h
F000:32A2  [+0x0B2A2]  BF C8 04                 mov     di,4C8h
F000:32A5  [+0x0B2A5]  2E 8B 04                 mov     ax,[cs:si]
F000:32A8  [+0x0B2A8]  3D FF FF                 cmp     ax,0FFFFh
F000:32AB  [+0x0B2AB]  74 0E                    je      short 32BBh
F000:32AD  [+0x0B2AD]  03 F8                    add     di,ax
F000:32AF  [+0x0B2AF]  8A 25                    mov     ah,[di]
F000:32B1  [+0x0B2B1]  86 C4                    xchg    al,ah
F000:32B3  [+0x0B2B3]  E8 C4 03                 call    367Ah
F000:32B6  [+0x0B2B6]  83 C6 02                 add     si,2
F000:32B9  [+0x0B2B9]  EB E7                    jmp     short 32A2h
F000:32BB  [+0x0B2BB]  58                       pop     ax
F000:32BC  [+0x0B2BC]  5E                       pop     si
F000:32BD  [+0x0B2BD]  5F                       pop     di
F000:32BE  [+0x0B2BE]  C3                       ret
F000:32BF  [+0x0B2BF]  50                       push    ax
F000:32C0  [+0x0B2C0]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:32C5  [+0x0B2C5]  74 15                    je      short 32DCh
F000:32C7  [+0x0B2C7]  81 0E 85 05 00 01        or      word [585h],100h
F000:32CD  [+0x0B2CD]  B0 B8                    mov     al,0B8h
F000:32CF  [+0x0B2CF]  E8 E8 03                 call    36BAh
F000:32D2  [+0x0B2D2]  E6 64                    out     64h,al
F000:32D4  [+0x0B2D4]  A0 C6 04                 mov     al,[4C6h]
F000:32D7  [+0x0B2D7]  E8 E0 03                 call    36BAh
F000:32DA  [+0x0B2DA]  E6 60                    out     60h,al
F000:32DC  [+0x0B2DC]  58                       pop     ax
F000:32DD  [+0x0B2DD]  C3                       ret
F000:32DE  [+0x0B2DE]  51                       push    cx
F000:32DF  [+0x0B2DF]  50                       push    ax
F000:32E0  [+0x0B2E0]  80 26 C5 04 DF           and     byte [4C5h],0DFh
F000:32E5  [+0x0B2E5]  B9 03 00                 mov     cx,3
F000:32E8  [+0x0B2E8]  51                       push    cx
F000:32E9  [+0x0B2E9]  B9 88 13                 mov     cx,1388h
F000:32EC  [+0x0B2EC]  E8 FC 03                 call    36EBh
F000:32EF  [+0x0B2EF]  E4 60                    in      al,60h
F000:32F1  [+0x0B2F1]  B0 FF                    mov     al,0FFh
F000:32F3  [+0x0B2F3]  E8 C4 03                 call    36BAh
F000:32F6  [+0x0B2F6]  E6 60                    out     60h,al
F000:32F8  [+0x0B2F8]  E8 C8 03                 call    36C3h
F000:32FB  [+0x0B2FB]  59                       pop     cx
F000:32FC  [+0x0B2FC]  3C FA                    cmp     al,0FAh
F000:32FE  [+0x0B2FE]  E0 E8                    loopne  32E8h
F000:3300  [+0x0B300]  75 0D                    jne     short 330Fh
F000:3302  [+0x0B302]  83 0E 89 05 04           or      word [589h],4
F000:3307  [+0x0B307]  80 0E C5 04 20           or      byte [4C5h],20h
F000:330C  [+0x0B30C]  E8 B4 03                 call    36C3h
F000:330F  [+0x0B30F]  F6 06 C5 04 80           test    byte [4C5h],80h
F000:3314  [+0x0B314]  74 1D                    je      short 3333h
F000:3316  [+0x0B316]  83 0E 89 05 08           or      word [589h],8
F000:331B  [+0x0B31B]  80 26 C5 04 EF           and     byte [4C5h],0EFh
F000:3320  [+0x0B320]  B4 F5                    mov     ah,0F5h
F000:3322  [+0x0B322]  E8 F4 02                 call    3619h
F000:3325  [+0x0B325]  3C FA                    cmp     al,0FAh
F000:3327  [+0x0B327]  75 0A                    jne     short 3333h
F000:3329  [+0x0B329]  83 0E 89 05 10           or      word [589h],10h
F000:332E  [+0x0B32E]  80 0E C5 04 10           or      byte [4C5h],10h
F000:3333  [+0x0B333]  B9 32 00                 mov     cx,32h
F000:3336  [+0x0B336]  E8 95 03                 call    36CEh
F000:3339  [+0x0B339]  73 F8                    jae     short 3333h
F000:333B  [+0x0B33B]  58                       pop     ax
F000:333C  [+0x0B33C]  59                       pop     cx
F000:333D  [+0x0B33D]  C3                       ret
F000:333E  [+0x0B33E]  51                       push    cx
F000:333F  [+0x0B33F]  50                       push    ax
F000:3340  [+0x0B340]  F6 06 C5 04 20           test    byte [4C5h],20h
F000:3345  [+0x0B345]  74 3C                    je      short 3383h
F000:3347  [+0x0B347]  83 0E 89 05 20           or      word [589h],20h
F000:334C  [+0x0B34C]  E4 60                    in      al,60h
F000:334E  [+0x0B34E]  B0 FF                    mov     al,0FFh
F000:3350  [+0x0B350]  E8 67 03                 call    36BAh
F000:3353  [+0x0B353]  E6 60                    out     60h,al
F000:3355  [+0x0B355]  E8 6B 03                 call    36C3h
F000:3358  [+0x0B358]  3C FE                    cmp     al,0FEh
F000:335A  [+0x0B35A]  74 27                    je      short 3383h
F000:335C  [+0x0B35C]  81 0E 85 05 00 02        or      word [585h],200h
F000:3362  [+0x0B362]  3C AA                    cmp     al,0AAh
F000:3364  [+0x0B364]  74 13                    je      short 3379h
F000:3366  [+0x0B366]  81 0E 85 05 00 04        or      word [585h],400h
F000:336C  [+0x0B36C]  3C FA                    cmp     al,0FAh
F000:336E  [+0x0B36E]  75 09                    jne     short 3379h
F000:3370  [+0x0B370]  81 0E 85 05 00 08        or      word [585h],800h
F000:3376  [+0x0B376]  E8 4A 03                 call    36C3h
F000:3379  [+0x0B379]  B0 F5                    mov     al,0F5h
F000:337B  [+0x0B37B]  E8 3C 03                 call    36BAh
F000:337E  [+0x0B37E]  E6 60                    out     60h,al
F000:3380  [+0x0B380]  E8 40 03                 call    36C3h
F000:3383  [+0x0B383]  B0 AD                    mov     al,0ADh
F000:3385  [+0x0B385]  E8 32 03                 call    36BAh
F000:3388  [+0x0B388]  E6 64                    out     64h,al
F000:338A  [+0x0B38A]  58                       pop     ax
F000:338B  [+0x0B38B]  59                       pop     cx
F000:338C  [+0x0B38C]  C3                       ret
F000:338D  [+0x0B38D]  50                       push    ax
F000:338E  [+0x0B38E]  F6 06 C5 04 80           test    byte [4C5h],80h
F000:3393  [+0x0B393]  74 5D                    je      short 33F2h
F000:3395  [+0x0B395]  81 0E 85 05 00 10        or      word [585h],1000h
F000:339B  [+0x0B39B]  F6 06 C5 04 10           test    byte [4C5h],10h
F000:33A0  [+0x0B3A0]  74 49                    je      short 33EBh
F000:33A2  [+0x0B3A2]  83 0E 89 05 40           or      word [589h],40h
F000:33A7  [+0x0B3A7]  E4 60                    in      al,60h
F000:33A9  [+0x0B3A9]  B4 FF                    mov     ah,0FFh
F000:33AB  [+0x0B3AB]  E8 6B 02                 call    3619h
F000:33AE  [+0x0B3AE]  3C 00                    cmp     al,0
F000:33B0  [+0x0B3B0]  74 34                    je      short 33E6h
F000:33B2  [+0x0B3B2]  81 0E 85 05 00 20        or      word [585h],2000h
F000:33B8  [+0x0B3B8]  3C AA                    cmp     al,0AAh
F000:33BA  [+0x0B3BA]  74 27                    je      short 33E3h
F000:33BC  [+0x0B3BC]  81 0E 85 05 00 40        or      word [585h],4000h
F000:33C2  [+0x0B3C2]  3C FA                    cmp     al,0FAh
F000:33C4  [+0x0B3C4]  75 25                    jne     short 33EBh
F000:33C6  [+0x0B3C6]  81 0E 85 05 00 80        or      word [585h],8000h
F000:33CC  [+0x0B3CC]  E8 F4 02                 call    36C3h
F000:33CF  [+0x0B3CF]  3C 00                    cmp     al,0
F000:33D1  [+0x0B3D1]  74 13                    je      short 33E6h
F000:33D3  [+0x0B3D3]  81 0E 89 05 80 00        or      word [589h],80h
F000:33D9  [+0x0B3D9]  3C AA                    cmp     al,0AAh
F000:33DB  [+0x0B3DB]  75 09                    jne     short 33E6h
F000:33DD  [+0x0B3DD]  81 0E 89 05 00 01        or      word [589h],100h
F000:33E3  [+0x0B3E3]  E8 DD 02                 call    36C3h
F000:33E6  [+0x0B3E6]  B4 F5                    mov     ah,0F5h
F000:33E8  [+0x0B3E8]  E8 2E 02                 call    3619h
F000:33EB  [+0x0B3EB]  B0 A7                    mov     al,0A7h
F000:33ED  [+0x0B3ED]  E8 CA 02                 call    36BAh
F000:33F0  [+0x0B3F0]  E6 64                    out     64h,al
F000:33F2  [+0x0B3F2]  58                       pop     ax
F000:33F3  [+0x0B3F3]  C3                       ret
F000:33F4  [+0x0B3F4]  50                       push    ax
F000:33F5  [+0x0B3F5]  F6 06 C5 04 20           test    byte [4C5h],20h
F000:33FA  [+0x0B3FA]  74 18                    je      short 3414h
F000:33FC  [+0x0B3FC]  83 0E 87 05 01           or      word [587h],1
F000:3401  [+0x0B401]  E8 12 00                 call    3416h
F000:3404  [+0x0B404]  E8 3A 00                 call    3441h
F000:3407  [+0x0B407]  E8 67 00                 call    3471h
F000:340A  [+0x0B40A]  E8 8A 00                 call    3497h
F000:340D  [+0x0B40D]  B0 AD                    mov     al,0ADh
F000:340F  [+0x0B40F]  E8 A8 02                 call    36BAh
F000:3412  [+0x0B412]  E6 64                    out     64h,al
F000:3414  [+0x0B414]  58                       pop     ax
F000:3415  [+0x0B415]  C3                       ret
F000:3416  [+0x0B416]  50                       push    ax
F000:3417  [+0x0B417]  E4 60                    in      al,60h
F000:3419  [+0x0B419]  B0 ED                    mov     al,0EDh
F000:341B  [+0x0B41B]  E8 9C 02                 call    36BAh
F000:341E  [+0x0B41E]  E6 60                    out     60h,al
F000:3420  [+0x0B420]  E8 A0 02                 call    36C3h
F000:3423  [+0x0B423]  A0 C5 04                 mov     al,[4C5h]
F000:3426  [+0x0B426]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:342B  [+0x0B42B]  74 08                    je      short 3435h
F000:342D  [+0x0B42D]  83 0E 87 05 02           or      word [587h],2
F000:3432  [+0x0B432]  A0 D0 04                 mov     al,[4D0h]
F000:3435  [+0x0B435]  24 07                    and     al,7
F000:3437  [+0x0B437]  E8 80 02                 call    36BAh
F000:343A  [+0x0B43A]  E6 60                    out     60h,al
F000:343C  [+0x0B43C]  E8 84 02                 call    36C3h
F000:343F  [+0x0B43F]  58                       pop     ax
F000:3440  [+0x0B440]  C3                       ret
F000:3441  [+0x0B441]  50                       push    ax
F000:3442  [+0x0B442]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:3447  [+0x0B447]  74 26                    je      short 346Fh
F000:3449  [+0x0B449]  83 0E 87 05 04           or      word [587h],4
F000:344E  [+0x0B44E]  E4 60                    in      al,60h
F000:3450  [+0x0B450]  B0 F0                    mov     al,0F0h
F000:3452  [+0x0B452]  E8 65 02                 call    36BAh
F000:3455  [+0x0B455]  E6 60                    out     60h,al
F000:3457  [+0x0B457]  E8 69 02                 call    36C3h
F000:345A  [+0x0B45A]  A0 D0 04                 mov     al,[4D0h]
F000:345D  [+0x0B45D]  24 30                    and     al,30h
F000:345F  [+0x0B45F]  D0 E8                    shr     al,1
F000:3461  [+0x0B461]  D0 E8                    shr     al,1
F000:3463  [+0x0B463]  D0 E8                    shr     al,1
F000:3465  [+0x0B465]  D0 E8                    shr     al,1
F000:3467  [+0x0B467]  E8 50 02                 call    36BAh
F000:346A  [+0x0B46A]  E6 60                    out     60h,al
F000:346C  [+0x0B46C]  E8 54 02                 call    36C3h
F000:346F  [+0x0B46F]  58                       pop     ax
F000:3470  [+0x0B470]  C3                       ret
F000:3471  [+0x0B471]  50                       push    ax
F000:3472  [+0x0B472]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:3477  [+0x0B477]  74 1C                    je      short 3495h
F000:3479  [+0x0B479]  83 0E 89 05 02           or      word [589h],2
F000:347E  [+0x0B47E]  E4 60                    in      al,60h
F000:3480  [+0x0B480]  B0 F3                    mov     al,0F3h
F000:3482  [+0x0B482]  E8 35 02                 call    36BAh
F000:3485  [+0x0B485]  E6 60                    out     60h,al
F000:3487  [+0x0B487]  E8 39 02                 call    36C3h
F000:348A  [+0x0B48A]  A0 D1 04                 mov     al,[4D1h]
F000:348D  [+0x0B48D]  E8 2A 02                 call    36BAh
F000:3490  [+0x0B490]  E6 60                    out     60h,al
F000:3492  [+0x0B492]  E8 2E 02                 call    36C3h
F000:3495  [+0x0B495]  58                       pop     ax
F000:3496  [+0x0B496]  C3                       ret
F000:3497  [+0x0B497]  50                       push    ax
F000:3498  [+0x0B498]  E4 60                    in      al,60h
F000:349A  [+0x0B49A]  B0 F4                    mov     al,0F4h
F000:349C  [+0x0B49C]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:34A1  [+0x0B4A1]  74 13                    je      short 34B6h
F000:34A3  [+0x0B4A3]  83 0E 87 05 08           or      word [587h],8
F000:34A8  [+0x0B4A8]  F6 06 D0 04 80           test    byte [4D0h],80h
F000:34AD  [+0x0B4AD]  74 07                    je      short 34B6h
F000:34AF  [+0x0B4AF]  83 0E 87 05 10           or      word [587h],10h
F000:34B4  [+0x0B4B4]  B0 F5                    mov     al,0F5h
F000:34B6  [+0x0B4B6]  E8 01 02                 call    36BAh
F000:34B9  [+0x0B4B9]  E6 60                    out     60h,al
F000:34BB  [+0x0B4BB]  E8 05 02                 call    36C3h
F000:34BE  [+0x0B4BE]  58                       pop     ax
F000:34BF  [+0x0B4BF]  C3                       ret
F000:34C0  [+0x0B4C0]  50                       push    ax
F000:34C1  [+0x0B4C1]  F6 06 C5 04 80           test    byte [4C5h],80h
F000:34C6  [+0x0B4C6]  74 2A                    je      short 34F2h
F000:34C8  [+0x0B4C8]  83 0E 87 05 20           or      word [587h],20h
F000:34CD  [+0x0B4CD]  F6 06 C5 04 10           test    byte [4C5h],10h
F000:34D2  [+0x0B4D2]  74 17                    je      short 34EBh
F000:34D4  [+0x0B4D4]  83 0E 87 05 40           or      word [587h],40h
F000:34D9  [+0x0B4D9]  E8 18 00                 call    34F4h
F000:34DC  [+0x0B4DC]  E8 2E 00                 call    350Dh
F000:34DF  [+0x0B4DF]  E8 44 00                 call    3526h
F000:34E2  [+0x0B4E2]  E8 52 00                 call    3537h
F000:34E5  [+0x0B4E5]  E8 74 00                 call    355Ch
F000:34E8  [+0x0B4E8]  E8 8A 00                 call    3575h
F000:34EB  [+0x0B4EB]  B0 A7                    mov     al,0A7h
F000:34ED  [+0x0B4ED]  E8 CA 01                 call    36BAh
F000:34F0  [+0x0B4F0]  E6 64                    out     64h,al
F000:34F2  [+0x0B4F2]  58                       pop     ax
F000:34F3  [+0x0B4F3]  C3                       ret
F000:34F4  [+0x0B4F4]  50                       push    ax
F000:34F5  [+0x0B4F5]  E4 60                    in      al,60h
F000:34F7  [+0x0B4F7]  B4 F0                    mov     ah,0F0h
F000:34F9  [+0x0B4F9]  F6 06 DC 04 40           test    byte [4DCh],40h
F000:34FE  [+0x0B4FE]  75 08                    jne     short 3508h
F000:3500  [+0x0B500]  81 0E 87 05 80 00        or      word [587h],80h
F000:3506  [+0x0B506]  B4 EA                    mov     ah,0EAh
F000:3508  [+0x0B508]  E8 0E 01                 call    3619h
F000:350B  [+0x0B50B]  58                       pop     ax
F000:350C  [+0x0B50C]  C3                       ret
F000:350D  [+0x0B50D]  50                       push    ax
F000:350E  [+0x0B50E]  E4 60                    in      al,60h
F000:3510  [+0x0B510]  B4 E7                    mov     ah,0E7h
F000:3512  [+0x0B512]  F6 06 DC 04 10           test    byte [4DCh],10h
F000:3517  [+0x0B517]  75 08                    jne     short 3521h
F000:3519  [+0x0B519]  81 0E 87 05 00 01        or      word [587h],100h
F000:351F  [+0x0B51F]  B4 E6                    mov     ah,0E6h
F000:3521  [+0x0B521]  E8 F5 00                 call    3619h
F000:3524  [+0x0B524]  58                       pop     ax
F000:3525  [+0x0B525]  C3                       ret
F000:3526  [+0x0B526]  50                       push    ax
F000:3527  [+0x0B527]  E4 60                    in      al,60h
F000:3529  [+0x0B529]  B4 E8                    mov     ah,0E8h
F000:352B  [+0x0B52B]  E8 EB 00                 call    3619h
F000:352E  [+0x0B52E]  8A 26 DD 04              mov     ah,[4DDh]
F000:3532  [+0x0B532]  E8 E4 00                 call    3619h
F000:3535  [+0x0B535]  58                       pop     ax
F000:3536  [+0x0B536]  C3                       ret
F000:3537  [+0x0B537]  50                       push    ax
F000:3538  [+0x0B538]  E4 60                    in      al,60h
F000:353A  [+0x0B53A]  B4 F3                    mov     ah,0F3h
F000:353C  [+0x0B53C]  E8 DA 00                 call    3619h
F000:353F  [+0x0B53F]  B4 0A                    mov     ah,0Ah
F000:3541  [+0x0B541]  E8 D5 00                 call    3619h
F000:3544  [+0x0B544]  B4 F3                    mov     ah,0F3h
F000:3546  [+0x0B546]  E8 D0 00                 call    3619h
F000:3549  [+0x0B549]  B4 3C                    mov     ah,3Ch
F000:354B  [+0x0B54B]  E8 CB 00                 call    3619h
F000:354E  [+0x0B54E]  B4 F3                    mov     ah,0F3h
F000:3550  [+0x0B550]  E8 C6 00                 call    3619h
F000:3553  [+0x0B553]  8A 26 DE 04              mov     ah,[4DEh]
F000:3557  [+0x0B557]  E8 BF 00                 call    3619h
F000:355A  [+0x0B55A]  58                       pop     ax
F000:355B  [+0x0B55B]  C3                       ret
F000:355C  [+0x0B55C]  50                       push    ax
F000:355D  [+0x0B55D]  E4 60                    in      al,60h
F000:355F  [+0x0B55F]  B4 F4                    mov     ah,0F4h
F000:3561  [+0x0B561]  F6 06 DC 04 20           test    byte [4DCh],20h
F000:3566  [+0x0B566]  75 08                    jne     short 3570h
F000:3568  [+0x0B568]  81 0E 87 05 00 02        or      word [587h],200h
F000:356E  [+0x0B56E]  B4 F5                    mov     ah,0F5h
F000:3570  [+0x0B570]  E8 A6 00                 call    3619h
F000:3573  [+0x0B573]  58                       pop     ax
F000:3574  [+0x0B574]  C3                       ret
F000:3575  [+0x0B575]  50                       push    ax
F000:3576  [+0x0B576]  E4 60                    in      al,60h
F000:3578  [+0x0B578]  F6 06 C5 04 08           test    byte [4C5h],8
F000:357D  [+0x0B57D]  74 0B                    je      short 358Ah
F000:357F  [+0x0B57F]  81 0E 87 05 00 04        or      word [587h],400h
F000:3585  [+0x0B585]  B4 EE                    mov     ah,0EEh
F000:3587  [+0x0B587]  E8 8F 00                 call    3619h
F000:358A  [+0x0B58A]  58                       pop     ax
F000:358B  [+0x0B58B]  C3                       ret
F000:358C  [+0x0B58C]  57                       push    di
F000:358D  [+0x0B58D]  50                       push    ax
F000:358E  [+0x0B58E]  F6 06 C0 04 40           test    byte [4C0h],40h
F000:3593  [+0x0B593]  74 65                    je      short 35FAh
F000:3595  [+0x0B595]  81 0E 87 05 00 08        or      word [587h],800h
F000:359B  [+0x0B59B]  F6 06 C0 04 20           test    byte [4C0h],20h
F000:35A0  [+0x0B5A0]  74 29                    je      short 35CBh
F000:35A2  [+0x0B5A2]  81 0E 87 05 00 10        or      word [587h],1000h
F000:35A8  [+0x0B5A8]  BF DF 04                 mov     di,4DFh
F000:35AB  [+0x0B5AB]  80 3D 00                 cmp     byte [di],0
F000:35AE  [+0x0B5AE]  74 4A                    je      short 35FAh
F000:35B0  [+0x0B5B0]  81 0E 87 05 00 20        or      word [587h],2000h
F000:35B6  [+0x0B5B6]  B0 A5                    mov     al,0A5h
F000:35B8  [+0x0B5B8]  E8 FF 00                 call    36BAh
F000:35BB  [+0x0B5BB]  E6 64                    out     64h,al
F000:35BD  [+0x0B5BD]  8A 05                    mov     al,[di]
F000:35BF  [+0x0B5BF]  E8 F8 00                 call    36BAh
F000:35C2  [+0x0B5C2]  E6 60                    out     60h,al
F000:35C4  [+0x0B5C4]  47                       inc     di
F000:35C5  [+0x0B5C5]  80 7D FF 00              cmp     byte [di-1],0
F000:35C9  [+0x0B5C9]  75 F2                    jne     short 35BDh
F000:35CB  [+0x0B5CB]  F6 06 C9 04 08           test    byte [4C9h],8
F000:35D0  [+0x0B5D0]  74 28                    je      short 35FAh
F000:35D2  [+0x0B5D2]  81 0E 87 05 00 40        or      word [587h],4000h
F000:35D8  [+0x0B5D8]  B0 A6                    mov     al,0A6h
F000:35DA  [+0x0B5DA]  F6 06 C1 04 20           test    byte [4C1h],20h
F000:35DF  [+0x0B5DF]  74 14                    je      short 35F5h
F000:35E1  [+0x0B5E1]  81 0E 87 05 00 80        or      word [587h],8000h
F000:35E7  [+0x0B5E7]  F6 06 D8 04 02           test    byte [4D8h],2
F000:35EC  [+0x0B5EC]  74 07                    je      short 35F5h
F000:35EE  [+0x0B5EE]  83 0E 89 05 01           or      word [589h],1
F000:35F3  [+0x0B5F3]  B0 CC                    mov     al,0CCh
F000:35F5  [+0x0B5F5]  E8 C2 00                 call    36BAh
F000:35F8  [+0x0B5F8]  E6 64                    out     64h,al
F000:35FA  [+0x0B5FA]  58                       pop     ax
F000:35FB  [+0x0B5FB]  5F                       pop     di
F000:35FC  [+0x0B5FC]  C3                       ret
F000:35FD  [+0x0B5FD]  50                       push    ax
F000:35FE  [+0x0B5FE]  B0 60                    mov     al,60h
F000:3600  [+0x0B600]  E8 B7 00                 call    36BAh
F000:3603  [+0x0B603]  E6 64                    out     64h,al
F000:3605  [+0x0B605]  A0 C8 04                 mov     al,[4C8h]
F000:3608  [+0x0B608]  E8 AF 00                 call    36BAh
F000:360B  [+0x0B60B]  E6 60                    out     60h,al
F000:360D  [+0x0B60D]  58                       pop     ax
F000:360E  [+0x0B60E]  C3                       ret
F000:360F  [+0x0B60F]  F8                       clc
F000:3610  [+0x0B610]  C3                       ret
F000:3611  [+0x0B611]  F8                       clc
F000:3612  [+0x0B612]  C3                       ret
F000:3613  [+0x0B613]  F8                       clc
F000:3614  [+0x0B614]  C3                       ret
F000:3615  [+0x0B615]  F8                       clc
F000:3616  [+0x0B616]  C3                       ret
F000:3617  [+0x0B617]  F8                       clc
F000:3618  [+0x0B618]  C3                       ret
F000:3619  [+0x0B619]  B0 D4                    mov     al,0D4h
F000:361B  [+0x0B61B]  E8 9C 00                 call    36BAh
F000:361E  [+0x0B61E]  E6 64                    out     64h,al
F000:3620  [+0x0B620]  8A C4                    mov     al,ah
F000:3622  [+0x0B622]  E8 95 00                 call    36BAh
F000:3625  [+0x0B625]  E6 60                    out     60h,al
F000:3627  [+0x0B627]  E8 99 00                 call    36C3h
F000:362A  [+0x0B62A]  C3                       ret
F000:362B  [+0x0B62B]  B0 B8                    mov     al,0B8h
F000:362D  [+0x0B62D]  E8 8A 00                 call    36BAh
F000:3630  [+0x0B630]  E6 64                    out     64h,al
F000:3632  [+0x0B632]  8A C4                    mov     al,ah
F000:3634  [+0x0B634]  E8 83 00                 call    36BAh
F000:3637  [+0x0B637]  E6 60                    out     60h,al
F000:3639  [+0x0B639]  B0 BA                    mov     al,0BAh
F000:363B  [+0x0B63B]  E8 7C 00                 call    36BAh
F000:363E  [+0x0B63E]  E6 64                    out     64h,al
F000:3640  [+0x0B640]  E8 80 00                 call    36C3h
F000:3643  [+0x0B643]  C3                       ret
F000:3644  [+0x0B644]  50                       push    ax
F000:3645  [+0x0B645]  B0 B8                    mov     al,0B8h
F000:3647  [+0x0B647]  E8 70 00                 call    36BAh
F000:364A  [+0x0B64A]  E6 64                    out     64h,al
F000:364C  [+0x0B64C]  8A C4                    mov     al,ah
F000:364E  [+0x0B64E]  E8 69 00                 call    36BAh
F000:3651  [+0x0B651]  E6 60                    out     60h,al
F000:3653  [+0x0B653]  B0 BB                    mov     al,0BBh
F000:3655  [+0x0B655]  E8 62 00                 call    36BAh
F000:3658  [+0x0B658]  E6 64                    out     64h,al
F000:365A  [+0x0B65A]  58                       pop     ax
F000:365B  [+0x0B65B]  E8 5C 00                 call    36BAh
F000:365E  [+0x0B65E]  E6 60                    out     60h,al
F000:3660  [+0x0B660]  C3                       ret
F000:3661  [+0x0B661]  B0 B8                    mov     al,0B8h
F000:3663  [+0x0B663]  E8 54 00                 call    36BAh
F000:3666  [+0x0B666]  E6 64                    out     64h,al
F000:3668  [+0x0B668]  8A C4                    mov     al,ah
F000:366A  [+0x0B66A]  E8 4D 00                 call    36BAh
F000:366D  [+0x0B66D]  E6 60                    out     60h,al
F000:366F  [+0x0B66F]  B0 BC                    mov     al,0BCh
F000:3671  [+0x0B671]  E8 46 00                 call    36BAh
F000:3674  [+0x0B674]  E6 64                    out     64h,al
F000:3676  [+0x0B676]  E8 4A 00                 call    36C3h
F000:3679  [+0x0B679]  C3                       ret
F000:367A  [+0x0B67A]  50                       push    ax
F000:367B  [+0x0B67B]  B0 B8                    mov     al,0B8h
F000:367D  [+0x0B67D]  E8 3A 00                 call    36BAh
F000:3680  [+0x0B680]  E6 64                    out     64h,al
F000:3682  [+0x0B682]  8A C4                    mov     al,ah
F000:3684  [+0x0B684]  E8 33 00                 call    36BAh
F000:3687  [+0x0B687]  E6 60                    out     60h,al
F000:3689  [+0x0B689]  B0 BD                    mov     al,0BDh
F000:368B  [+0x0B68B]  E8 2C 00                 call    36BAh
F000:368E  [+0x0B68E]  E6 64                    out     64h,al
F000:3690  [+0x0B690]  58                       pop     ax
F000:3691  [+0x0B691]  E8 26 00                 call    36BAh
F000:3694  [+0x0B694]  E6 60                    out     60h,al
F000:3696  [+0x0B696]  C3                       ret
F000:3697  [+0x0B697]  E8 0F 00                 call    36A9h
F000:369A  [+0x0B69A]  B0 AD                    mov     al,0ADh
F000:369C  [+0x0B69C]  E6 64                    out     64h,al
F000:369E  [+0x0B69E]  B0 A7                    mov     al,0A7h
F000:36A0  [+0x0B6A0]  E8 17 00                 call    36BAh
F000:36A3  [+0x0B6A3]  E6 64                    out     64h,al
F000:36A5  [+0x0B6A5]  E8 12 00                 call    36BAh
F000:36A8  [+0x0B6A8]  C3                       ret
F000:36A9  [+0x0B6A9]  50                       push    ax
F000:36AA  [+0x0B6AA]  E4 64                    in      al,64h
F000:36AC  [+0x0B6AC]  A8 01                    test    al,1
F000:36AE  [+0x0B6AE]  74 04                    je      short 36B4h
F000:36B0  [+0x0B6B0]  E4 60                    in      al,60h
F000:36B2  [+0x0B6B2]  EB F6                    jmp     short 36AAh
F000:36B4  [+0x0B6B4]  A8 02                    test    al,2
F000:36B6  [+0x0B6B6]  75 F2                    jne     short 36AAh
F000:36B8  [+0x0B6B8]  58                       pop     ax
F000:36B9  [+0x0B6B9]  C3                       ret
F000:36BA  [+0x0B6BA]  50                       push    ax
F000:36BB  [+0x0B6BB]  E4 64                    in      al,64h
F000:36BD  [+0x0B6BD]  A8 02                    test    al,2
F000:36BF  [+0x0B6BF]  75 FA                    jne     short 36BBh
F000:36C1  [+0x0B6C1]  58                       pop     ax
F000:36C2  [+0x0B6C2]  C3                       ret
F000:36C3  [+0x0B6C3]  50                       push    ax
F000:36C4  [+0x0B6C4]  E4 64                    in      al,64h
F000:36C6  [+0x0B6C6]  A8 01                    test    al,1
F000:36C8  [+0x0B6C8]  74 FA                    je      short 36C4h
F000:36CA  [+0x0B6CA]  58                       pop     ax
F000:36CB  [+0x0B6CB]  E4 60                    in      al,60h
F000:36CD  [+0x0B6CD]  C3                       ret
F000:36CE  [+0x0B6CE]  50                       push    ax
F000:36CF  [+0x0B6CF]  E4 64                    in      al,64h
F000:36D1  [+0x0B6D1]  A8 01                    test    al,1
F000:36D3  [+0x0B6D3]  75 11                    jne     short 36E6h
F000:36D5  [+0x0B6D5]  9C                       pushf
F000:36D6  [+0x0B6D6]  51                       push    cx
F000:36D7  [+0x0B6D7]  FA                       cli
F000:36D8  [+0x0B6D8]  E8 66 E9                 call    2041h
F000:36DB  [+0x0B6DB]  59                       pop     cx
F000:36DC  [+0x0B6DC]  9D                       popf
F000:36DD  [+0x0B6DD]  E2 F0                    loop    36CFh
F000:36DF  [+0x0B6DF]  58                       pop     ax
F000:36E0  [+0x0B6E0]  B0 00                    mov     al,0
F000:36E2  [+0x0B6E2]  F9                       stc
F000:36E3  [+0x0B6E3]  EB 05                    jmp     short 36EAh
F000:36E5  [+0x0B6E5]  90                       nop
F000:36E6  [+0x0B6E6]  58                       pop     ax
F000:36E7  [+0x0B6E7]  E4 60                    in      al,60h
F000:36E9  [+0x0B6E9]  F8                       clc
F000:36EA  [+0x0B6EA]  C3                       ret
F000:36EB  [+0x0B6EB]  9C                       pushf
F000:36EC  [+0x0B6EC]  FA                       cli
F000:36ED  [+0x0B6ED]  E8 51 E9                 call    2041h
F000:36F0  [+0x0B6F0]  E2 FB                    loop    36EDh
F000:36F2  [+0x0B6F2]  9D                       popf
F000:36F3  [+0x0B6F3]  C3                       ret
F000:36F4  [+0x0B6F4]  66 50                    push    eax
F000:36F6  [+0x0B6F6]  06                       push    es
F000:36F7  [+0x0B6F7]  33 C0                    xor     ax,ax
F000:36F9  [+0x0B6F9]  8E C0                    mov     es,ax
F000:36FB  [+0x0B6FB]  26 66 A1 B4 01           mov     eax,[es:1B4h]
F000:3700  [+0x0B700]  66 A3 8E 05              mov     [58Eh],eax
F000:3704  [+0x0B704]  07                       pop     es
F000:3705  [+0x0B705]  66 58                    pop     eax
F000:3707  [+0x0B707]  C3                       ret
F000:3708  [+0x0B708]  50                       push    ax
F000:3709  [+0x0B709]  53                       push    bx
F000:370A  [+0x0B70A]  52                       push    dx
F000:370B  [+0x0B70B]  E8 4D 01                 call    385Bh
F000:370E  [+0x0B70E]  5A                       pop     dx
F000:370F  [+0x0B70F]  5B                       pop     bx
F000:3710  [+0x0B710]  58                       pop     ax
F000:3711  [+0x0B711]  C3                       ret
F000:3712  [+0x0B712]  50                       push    ax
F000:3713  [+0x0B713]  53                       push    bx
F000:3714  [+0x0B714]  52                       push    dx
F000:3715  [+0x0B715]  E8 B2 01                 call    38CAh
F000:3718  [+0x0B718]  53                       push    bx
F000:3719  [+0x0B719]  B8 03 00                 mov     ax,3
F000:371C  [+0x0B71C]  BB C0 2E                 mov     bx,2EC0h
F000:371F  [+0x0B71F]  E8 C8 DB                 call    12EAh
F000:3722  [+0x0B722]  5B                       pop     bx
F000:3723  [+0x0B723]  E8 6F DB                 call    1295h
F000:3726  [+0x0B726]  0F 83 09 00              jae     near 3733h
F000:372A  [+0x0B72A]  B8 03 00                 mov     ax,3
F000:372D  [+0x0B72D]  BA 01 00                 mov     dx,1
F000:3730  [+0x0B730]  E8 05 DC                 call    1338h
F000:3733  [+0x0B733]  5A                       pop     dx
F000:3734  [+0x0B734]  5B                       pop     bx
F000:3735  [+0x0B735]  58                       pop     ax
F000:3736  [+0x0B736]  C3                       ret
F000:3737  [+0x0B737]  02 02                    add     al,[bp+si]
F000:3739  [+0x0B739]  00 01                    add     [bx+di],al
F000:373B  [+0x0B73B]  9C                       pushf
F000:373C  [+0x0B73C]  FF 1E 8E 05              call    far [58Eh]
F000:3740  [+0x0B740]  C3                       ret
F000:3741  [+0x0B741]  E8 53 00                 call    3797h
F000:3744  [+0x0B744]  25 00 08                 and     ax,800h
F000:3747  [+0x0B747]  C1 E8 0B                 shr     ax,0Bh
F000:374A  [+0x0B74A]  81 E3 80 00              and     bx,80h
F000:374E  [+0x0B74E]  C1 EB 06                 shr     bx,6
F000:3751  [+0x0B751]  0B D8                    or      bx,ax
F000:3753  [+0x0B753]  B4 01                    mov     ah,1
F000:3755  [+0x0B755]  BA CC 03                 mov     dx,3CCh
F000:3758  [+0x0B758]  EC                       in      al,dx
F000:3759  [+0x0B759]  A8 04                    test    al,4
F000:375B  [+0x0B75B]  0F 85 02 00              jne     near 3761h
F000:375F  [+0x0B75F]  B4 02                    mov     ah,2
F000:3761  [+0x0B761]  32 DC                    xor     bl,ah
F000:3763  [+0x0B763]  2E 8A 87 6E 37           mov     al,[cs:bx+376Eh]
F000:3768  [+0x0B768]  B3 89                    mov     bl,89h
F000:376A  [+0x0B76A]  E8 2C 00                 call    3799h
F000:376D  [+0x0B76D]  C3                       ret
F000:376E  [+0x0B76E]  02 03                    add     al,[bp+di]
F000:3770  [+0x0B770]  00 01                    add     [bx+di],al
F000:3772  [+0x0B772]  E8 0F 00                 call    3784h
F000:3775  [+0x0B775]  2E 8A 87 80 37           mov     al,[cs:bx+3780h]
F000:377A  [+0x0B77A]  B3 92                    mov     bl,92h
F000:377C  [+0x0B77C]  E8 1A 00                 call    3799h
F000:377F  [+0x0B77F]  C3                       ret
F000:3780  [+0x0B780]  02 00                    add     al,[bx+si]
F000:3782  [+0x0B782]  01 02                    add     [bp+si],ax
F000:3784  [+0x0B784]  E8 10 00                 call    3797h
F000:3787  [+0x0B787]  25 00 01                 and     ax,100h
F000:378A  [+0x0B78A]  C1 E8 08                 shr     ax,8
F000:378D  [+0x0B78D]  81 E3 00 02              and     bx,200h
F000:3791  [+0x0B791]  C1 EB 08                 shr     bx,8
F000:3794  [+0x0B794]  0B D8                    or      bx,ax
F000:3796  [+0x0B796]  C3                       ret
F000:3797  [+0x0B797]  B3 9A                    mov     bl,9Ah
F000:3799  [+0x0B799]  B4 12                    mov     ah,12h
F000:379B  [+0x0B79B]  E8 9D FF                 call    373Bh
F000:379E  [+0x0B79E]  C3                       ret
F000:379F  [+0x0B79F]  50                       push    ax
F000:37A0  [+0x0B7A0]  52                       push    dx
F000:37A1  [+0x0B7A1]  BA D4 03                 mov     dx,3D4h
F000:37A4  [+0x0B7A4]  E8 09 00                 call    37B0h
F000:37A7  [+0x0B7A7]  BA B4 03                 mov     dx,3B4h
F000:37AA  [+0x0B7AA]  E8 03 00                 call    37B0h
F000:37AD  [+0x0B7AD]  5A                       pop     dx
F000:37AE  [+0x0B7AE]  58                       pop     ax
F000:37AF  [+0x0B7AF]  C3                       ret
F000:37B0  [+0x0B7B0]  FA                       cli
F000:37B1  [+0x0B7B1]  EC                       in      al,dx
F000:37B2  [+0x0B7B2]  50                       push    ax
F000:37B3  [+0x0B7B3]  B8 11 11                 mov     ax,1111h
F000:37B6  [+0x0B7B6]  EE                       out     dx,al
F000:37B7  [+0x0B7B7]  42                       inc     dx
F000:37B8  [+0x0B7B8]  EC                       in      al,dx
F000:37B9  [+0x0B7B9]  24 7F                    and     al,7Fh
F000:37BB  [+0x0B7BB]  86 E0                    xchg    ah,al
F000:37BD  [+0x0B7BD]  4A                       dec     dx
F000:37BE  [+0x0B7BE]  EE                       out     dx,al
F000:37BF  [+0x0B7BF]  86 E0                    xchg    ah,al
F000:37C1  [+0x0B7C1]  42                       inc     dx
F000:37C2  [+0x0B7C2]  EE                       out     dx,al
F000:37C3  [+0x0B7C3]  4A                       dec     dx
F000:37C4  [+0x0B7C4]  58                       pop     ax
F000:37C5  [+0x0B7C5]  EE                       out     dx,al
F000:37C6  [+0x0B7C6]  C3                       ret
F000:37C7  [+0x0B7C7]  50                       push    ax
F000:37C8  [+0x0B7C8]  52                       push    dx
F000:37C9  [+0x0B7C9]  BA D4 03                 mov     dx,3D4h
F000:37CC  [+0x0B7CC]  E8 09 00                 call    37D8h
F000:37CF  [+0x0B7CF]  BA B4 03                 mov     dx,3B4h
F000:37D2  [+0x0B7D2]  E8 03 00                 call    37D8h
F000:37D5  [+0x0B7D5]  5A                       pop     dx
F000:37D6  [+0x0B7D6]  58                       pop     ax
F000:37D7  [+0x0B7D7]  C3                       ret
F000:37D8  [+0x0B7D8]  FA                       cli
F000:37D9  [+0x0B7D9]  EC                       in      al,dx
F000:37DA  [+0x0B7DA]  50                       push    ax
F000:37DB  [+0x0B7DB]  B8 11 11                 mov     ax,1111h
F000:37DE  [+0x0B7DE]  EE                       out     dx,al
F000:37DF  [+0x0B7DF]  42                       inc     dx
F000:37E0  [+0x0B7E0]  EC                       in      al,dx
F000:37E1  [+0x0B7E1]  0C 80                    or      al,80h
F000:37E3  [+0x0B7E3]  86 E0                    xchg    ah,al
F000:37E5  [+0x0B7E5]  4A                       dec     dx
F000:37E6  [+0x0B7E6]  EE                       out     dx,al
F000:37E7  [+0x0B7E7]  86 E0                    xchg    ah,al
F000:37E9  [+0x0B7E9]  42                       inc     dx
F000:37EA  [+0x0B7EA]  EE                       out     dx,al
F000:37EB  [+0x0B7EB]  4A                       dec     dx
F000:37EC  [+0x0B7EC]  58                       pop     ax
F000:37ED  [+0x0B7ED]  EE                       out     dx,al
F000:37EE  [+0x0B7EE]  C3                       ret
F000:37EF  [+0x0B7EF]  52                       push    dx
F000:37F0  [+0x0B7F0]  50                       push    ax
F000:37F1  [+0x0B7F1]  BA C4 03                 mov     dx,3C4h
F000:37F4  [+0x0B7F4]  EC                       in      al,dx
F000:37F5  [+0x0B7F5]  50                       push    ax
F000:37F6  [+0x0B7F6]  B0 06                    mov     al,6
F000:37F8  [+0x0B7F8]  EE                       out     dx,al
F000:37F9  [+0x0B7F9]  42                       inc     dx
F000:37FA  [+0x0B7FA]  B0 12                    mov     al,12h
F000:37FC  [+0x0B7FC]  EE                       out     dx,al
F000:37FD  [+0x0B7FD]  58                       pop     ax
F000:37FE  [+0x0B7FE]  4A                       dec     dx
F000:37FF  [+0x0B7FF]  EE                       out     dx,al
F000:3800  [+0x0B800]  58                       pop     ax
F000:3801  [+0x0B801]  5A                       pop     dx
F000:3802  [+0x0B802]  C3                       ret
F000:3803  [+0x0B803]  50                       push    ax
F000:3804  [+0x0B804]  53                       push    bx
F000:3805  [+0x0B805]  B0 4C                    mov     al,4Ch
F000:3807  [+0x0B807]  E8 E2 E7                 call    1FECh
F000:380A  [+0x0B80A]  80 E4 C0                 and     ah,0C0h
F000:380D  [+0x0B80D]  C0 EC 06                 shr     ah,6
F000:3810  [+0x0B810]  8A DC                    mov     bl,ah
F000:3812  [+0x0B812]  32 FF                    xor     bh,bh
F000:3814  [+0x0B814]  2E 8A 87 21 38           mov     al,[cs:bx+3821h]
F000:3819  [+0x0B819]  B3 89                    mov     bl,89h
F000:381B  [+0x0B81B]  E8 7B FF                 call    3799h
F000:381E  [+0x0B81E]  5B                       pop     bx
F000:381F  [+0x0B81F]  58                       pop     ax
F000:3820  [+0x0B820]  C3                       ret
F000:3821  [+0x0B821]  01 00                    add     [bx+si],ax
F000:3823  [+0x0B823]  03 02                    add     ax,[bp+si]
F000:3825  [+0x0B825]  50                       push    ax
F000:3826  [+0x0B826]  53                       push    bx
F000:3827  [+0x0B827]  51                       push    cx
F000:3828  [+0x0B828]  52                       push    dx
F000:3829  [+0x0B829]  B0 5E                    mov     al,5Eh
F000:382B  [+0x0B82B]  E8 BE E7                 call    1FECh
F000:382E  [+0x0B82E]  86 C4                    xchg    al,ah
F000:3830  [+0x0B830]  24 C0                    and     al,0C0h
F000:3832  [+0x0B832]  B1 06                    mov     cl,6
F000:3834  [+0x0B834]  D2 E8                    shr     al,cl
F000:3836  [+0x0B836]  3C 02                    cmp     al,2
F000:3838  [+0x0B838]  76 0C                    jbe     short 3846h
F000:383A  [+0x0B83A]  B8 51 5F                 mov     ax,5F51h
F000:383D  [+0x0B83D]  BB 01 01                 mov     bx,101h
F000:3840  [+0x0B840]  E8 F8 FE                 call    373Bh
F000:3843  [+0x0B843]  EB 0B                    jmp     short 3850h
F000:3845  [+0x0B845]  90                       nop
F000:3846  [+0x0B846]  8A D8                    mov     bl,al
F000:3848  [+0x0B848]  B7 01                    mov     bh,1
F000:384A  [+0x0B84A]  B8 51 5F                 mov     ax,5F51h
F000:384D  [+0x0B84D]  E8 EB FE                 call    373Bh
F000:3850  [+0x0B850]  B9 10 27                 mov     cx,2710h
F000:3853  [+0x0B853]  E8 EB E7                 call    2041h
F000:3856  [+0x0B856]  5A                       pop     dx
F000:3857  [+0x0B857]  59                       pop     cx
F000:3858  [+0x0B858]  5B                       pop     bx
F000:3859  [+0x0B859]  58                       pop     ax
F000:385A  [+0x0B85A]  C3                       ret
F000:385B  [+0x0B85B]  60                       pusha
F000:385C  [+0x0B85C]  BA D6 03                 mov     dx,3D6h
F000:385F  [+0x0B85F]  B0 52                    mov     al,52h
F000:3861  [+0x0B861]  EE                       out     dx,al
F000:3862  [+0x0B862]  EB 00                    jmp     short 3864h
F000:3864  [+0x0B864]  EB 00                    jmp     short 3866h
F000:3866  [+0x0B866]  42                       inc     dx
F000:3867  [+0x0B867]  EC                       in      al,dx
F000:3868  [+0x0B868]  A8 08                    test    al,8
F000:386A  [+0x0B86A]  0F 84 05 00              je      near 3873h
F000:386E  [+0x0B86E]  24 F7                    and     al,0F7h
F000:3870  [+0x0B870]  EE                       out     dx,al
F000:3871  [+0x0B871]  EB 00                    jmp     short 3873h
F000:3873  [+0x0B873]  B0 3F                    mov     al,3Fh
F000:3875  [+0x0B875]  E8 74 E7                 call    1FECh
F000:3878  [+0x0B878]  86 C4                    xchg    al,ah
F000:387A  [+0x0B87A]  BA FF 01                 mov     dx,1FFh
F000:387D  [+0x0B87D]  EE                       out     dx,al
F000:387E  [+0x0B87E]  EB 00                    jmp     short 3880h
F000:3880  [+0x0B880]  EB 00                    jmp     short 3882h
F000:3882  [+0x0B882]  61                       popa
F000:3883  [+0x0B883]  C3                       ret
F000:3884  [+0x0B884]  50                       push    ax
F000:3885  [+0x0B885]  53                       push    bx
F000:3886  [+0x0B886]  52                       push    dx
F000:3887  [+0x0B887]  BA D6 03                 mov     dx,3D6h
F000:388A  [+0x0B88A]  B0 52                    mov     al,52h
F000:388C  [+0x0B88C]  EE                       out     dx,al
F000:388D  [+0x0B88D]  EB 00                    jmp     short 388Fh
F000:388F  [+0x0B88F]  EB 00                    jmp     short 3891h
F000:3891  [+0x0B891]  42                       inc     dx
F000:3892  [+0x0B892]  EC                       in      al,dx
F000:3893  [+0x0B893]  A8 08                    test    al,8
F000:3895  [+0x0B895]  0F 85 2D 00              jne     near 38C6h
F000:3899  [+0x0B899]  0C 08                    or      al,8
F000:389B  [+0x0B89B]  50                       push    ax
F000:389C  [+0x0B89C]  52                       push    dx
F000:389D  [+0x0B89D]  B8 09 00                 mov     ax,9
F000:38A0  [+0x0B8A0]  BA 00 02                 mov     dx,200h
F000:38A3  [+0x0B8A3]  E8 9B DA                 call    1341h
F000:38A6  [+0x0B8A6]  B8 0A 00                 mov     ax,0Ah
F000:38A9  [+0x0B8A9]  BA 00 02                 mov     dx,200h
F000:38AC  [+0x0B8AC]  E8 92 DA                 call    1341h
F000:38AF  [+0x0B8AF]  5A                       pop     dx
F000:38B0  [+0x0B8B0]  58                       pop     ax
F000:38B1  [+0x0B8B1]  EE                       out     dx,al
F000:38B2  [+0x0B8B2]  EB 00                    jmp     short 38B4h
F000:38B4  [+0x0B8B4]  B8 09 00                 mov     ax,9
F000:38B7  [+0x0B8B7]  BA 00 02                 mov     dx,200h
F000:38BA  [+0x0B8BA]  E8 7B DA                 call    1338h
F000:38BD  [+0x0B8BD]  B8 0A 00                 mov     ax,0Ah
F000:38C0  [+0x0B8C0]  BA 00 02                 mov     dx,200h
F000:38C3  [+0x0B8C3]  E8 72 DA                 call    1338h
F000:38C6  [+0x0B8C6]  5A                       pop     dx
F000:38C7  [+0x0B8C7]  5B                       pop     bx
F000:38C8  [+0x0B8C8]  58                       pop     ax
F000:38C9  [+0x0B8C9]  C3                       ret
F000:38CA  [+0x0B8CA]  50                       push    ax
F000:38CB  [+0x0B8CB]  B0 3F                    mov     al,3Fh
F000:38CD  [+0x0B8CD]  E8 1C E7                 call    1FECh
F000:38D0  [+0x0B8D0]  86 C4                    xchg    al,ah
F000:38D2  [+0x0B8D2]  BA FF 01                 mov     dx,1FFh
F000:38D5  [+0x0B8D5]  EE                       out     dx,al
F000:38D6  [+0x0B8D6]  EB 00                    jmp     short 38D8h
F000:38D8  [+0x0B8D8]  EB 00                    jmp     short 38DAh
F000:38DA  [+0x0B8DA]  EB 00                    jmp     short 38DCh
F000:38DC  [+0x0B8DC]  58                       pop     ax
F000:38DD  [+0x0B8DD]  C3                       ret
F000:38DE  [+0x0B8DE]  51                       push    cx
F000:38DF  [+0x0B8DF]  1E                       push    ds
F000:38E0  [+0x0B8E0]  06                       push    es
F000:38E1  [+0x0B8E1]  56                       push    si
F000:38E2  [+0x0B8E2]  57                       push    di
F000:38E3  [+0x0B8E3]  FC                       cld
F000:38E4  [+0x0B8E4]  B8 40 00                 mov     ax,40h
F000:38E7  [+0x0B8E7]  8E D8                    mov     ds,ax
F000:38E9  [+0x0B8E9]  B8 00 DC                 mov     ax,0DC00h
F000:38EC  [+0x0B8EC]  8E C0                    mov     es,ax
F000:38EE  [+0x0B8EE]  B9 04 00                 mov     cx,4
F000:38F1  [+0x0B8F1]  BE 00 00                 mov     si,0
F000:38F4  [+0x0B8F4]  BF C2 05                 mov     di,5C2h
F000:38F7  [+0x0B8F7]  F3 A5                    rep movsw
F000:38F9  [+0x0B8F9]  B9 03 00                 mov     cx,3
F000:38FC  [+0x0B8FC]  BE 08 00                 mov     si,8
F000:38FF  [+0x0B8FF]  BF EA 05                 mov     di,5EAh
F000:3902  [+0x0B902]  F3 A5                    rep movsw
F000:3904  [+0x0B904]  5F                       pop     di
F000:3905  [+0x0B905]  5E                       pop     si
F000:3906  [+0x0B906]  07                       pop     es
F000:3907  [+0x0B907]  1F                       pop     ds
F000:3908  [+0x0B908]  59                       pop     cx
F000:3909  [+0x0B909]  C3                       ret
F000:390A  [+0x0B90A]  50                       push    ax
F000:390B  [+0x0B90B]  53                       push    bx
F000:390C  [+0x0B90C]  52                       push    dx
F000:390D  [+0x0B90D]  BB FE FF                 mov     bx,0FFFEh
F000:3910  [+0x0B910]  83 C3 02                 add     bx,2
F000:3913  [+0x0B913]  83 FB 06                 cmp     bx,6
F000:3916  [+0x0B916]  77 44                    ja      short 395Ch
F000:3918  [+0x0B918]  8B 97 C2 05              mov     dx,[bx+5C2h]
F000:391C  [+0x0B91C]  F7 C2 FF 03              test    dx,3FFh
F000:3920  [+0x0B920]  74 EE                    je      short 3910h
F000:3922  [+0x0B922]  C1 E3 02                 shl     bx,2
F000:3925  [+0x0B925]  83 C2 03                 add     dx,3
F000:3928  [+0x0B928]  EC                       in      al,dx
F000:3929  [+0x0B929]  88 87 CA 05              mov     [bx+5CAh],al
F000:392D  [+0x0B92D]  24 7F                    and     al,7Fh
F000:392F  [+0x0B92F]  EE                       out     dx,al
F000:3930  [+0x0B930]  83 EA 02                 sub     dx,2
F000:3933  [+0x0B933]  EC                       in      al,dx
F000:3934  [+0x0B934]  88 87 CB 05              mov     [bx+5CBh],al
F000:3938  [+0x0B938]  32 C0                    xor     al,al
F000:393A  [+0x0B93A]  EE                       out     dx,al
F000:393B  [+0x0B93B]  83 C2 02                 add     dx,2
F000:393E  [+0x0B93E]  B0 80                    mov     al,80h
F000:3940  [+0x0B940]  EE                       out     dx,al
F000:3941  [+0x0B941]  83 EA 02                 sub     dx,2
F000:3944  [+0x0B944]  EC                       in      al,dx
F000:3945  [+0x0B945]  88 87 CD 05              mov     [bx+5CDh],al
F000:3949  [+0x0B949]  4A                       dec     dx
F000:394A  [+0x0B94A]  EC                       in      al,dx
F000:394B  [+0x0B94B]  88 87 CC 05              mov     [bx+5CCh],al
F000:394F  [+0x0B94F]  83 C2 04                 add     dx,4
F000:3952  [+0x0B952]  EC                       in      al,dx
F000:3953  [+0x0B953]  88 87 CE 05              mov     [bx+5CEh],al
F000:3957  [+0x0B957]  C1 EB 02                 shr     bx,2
F000:395A  [+0x0B95A]  EB B4                    jmp     short 3910h
F000:395C  [+0x0B95C]  BB FE FF                 mov     bx,0FFFEh
F000:395F  [+0x0B95F]  83 C3 02                 add     bx,2
F000:3962  [+0x0B962]  83 FB 04                 cmp     bx,4
F000:3965  [+0x0B965]  77 1A                    ja      short 3981h
F000:3967  [+0x0B967]  8B 97 EA 05              mov     dx,[bx+5EAh]
F000:396B  [+0x0B96B]  F7 C2 FF 03              test    dx,3FFh
F000:396F  [+0x0B96F]  74 EE                    je      short 395Fh
F000:3971  [+0x0B971]  83 C2 02                 add     dx,2
F000:3974  [+0x0B974]  EC                       in      al,dx
F000:3975  [+0x0B975]  24 1F                    and     al,1Fh
F000:3977  [+0x0B977]  D1 E3                    shl     bx,1
F000:3979  [+0x0B979]  88 87 F0 05              mov     [bx+5F0h],al
F000:397D  [+0x0B97D]  D1 EB                    shr     bx,1
F000:397F  [+0x0B97F]  EB DE                    jmp     short 395Fh
F000:3981  [+0x0B981]  5A                       pop     dx
F000:3982  [+0x0B982]  5B                       pop     bx
F000:3983  [+0x0B983]  58                       pop     ax
F000:3984  [+0x0B984]  C3                       ret
F000:3985  [+0x0B985]  50                       push    ax
F000:3986  [+0x0B986]  53                       push    bx
F000:3987  [+0x0B987]  52                       push    dx
F000:3988  [+0x0B988]  BB FE FF                 mov     bx,0FFFEh
F000:398B  [+0x0B98B]  83 C3 02                 add     bx,2
F000:398E  [+0x0B98E]  83 FB 06                 cmp     bx,6
F000:3991  [+0x0B991]  77 6D                    ja      short 3A00h
F000:3993  [+0x0B993]  8B 97 C2 05              mov     dx,[bx+5C2h]
F000:3997  [+0x0B997]  F7 C2 FF 03              test    dx,3FFh
F000:399B  [+0x0B99B]  74 EE                    je      short 398Bh
F000:399D  [+0x0B99D]  C1 E3 02                 shl     bx,2
F000:39A0  [+0x0B9A0]  83 C2 03                 add     dx,3
F000:39A3  [+0x0B9A3]  B0 00                    mov     al,0
F000:39A5  [+0x0B9A5]  EE                       out     dx,al
F000:39A6  [+0x0B9A6]  EB 00                    jmp     short 39A8h
F000:39A8  [+0x0B9A8]  83 EA 02                 sub     dx,2
F000:39AB  [+0x0B9AB]  EE                       out     dx,al
F000:39AC  [+0x0B9AC]  EB 00                    jmp     short 39AEh
F000:39AE  [+0x0B9AE]  83 C2 02                 add     dx,2
F000:39B1  [+0x0B9B1]  B0 80                    mov     al,80h
F000:39B3  [+0x0B9B3]  EE                       out     dx,al
F000:39B4  [+0x0B9B4]  EB 00                    jmp     short 39B6h
F000:39B6  [+0x0B9B6]  83 EA 02                 sub     dx,2
F000:39B9  [+0x0B9B9]  8A 87 CD 05              mov     al,[bx+5CDh]
F000:39BD  [+0x0B9BD]  EE                       out     dx,al
F000:39BE  [+0x0B9BE]  EB 00                    jmp     short 39C0h
F000:39C0  [+0x0B9C0]  4A                       dec     dx
F000:39C1  [+0x0B9C1]  8A 87 CC 05              mov     al,[bx+5CCh]
F000:39C5  [+0x0B9C5]  EE                       out     dx,al
F000:39C6  [+0x0B9C6]  EB 00                    jmp     short 39C8h
F000:39C8  [+0x0B9C8]  83 C2 02                 add     dx,2
F000:39CB  [+0x0B9CB]  83 C2 01                 add     dx,1
F000:39CE  [+0x0B9CE]  8A 87 CA 05              mov     al,[bx+5CAh]
F000:39D2  [+0x0B9D2]  24 7F                    and     al,7Fh
F000:39D4  [+0x0B9D4]  EE                       out     dx,al
F000:39D5  [+0x0B9D5]  EB 00                    jmp     short 39D7h
F000:39D7  [+0x0B9D7]  83 C2 01                 add     dx,1
F000:39DA  [+0x0B9DA]  8A 87 CE 05              mov     al,[bx+5CEh]
F000:39DE  [+0x0B9DE]  EE                       out     dx,al
F000:39DF  [+0x0B9DF]  EB 00                    jmp     short 39E1h
F000:39E1  [+0x0B9E1]  83 EA 03                 sub     dx,3
F000:39E4  [+0x0B9E4]  8A 87 CB 05              mov     al,[bx+5CBh]
F000:39E8  [+0x0B9E8]  EE                       out     dx,al
F000:39E9  [+0x0B9E9]  EB 00                    jmp     short 39EBh
F000:39EB  [+0x0B9EB]  83 C2 02                 add     dx,2
F000:39EE  [+0x0B9EE]  8A 87 CA 05              mov     al,[bx+5CAh]
F000:39F2  [+0x0B9F2]  EE                       out     dx,al
F000:39F3  [+0x0B9F3]  EB 00                    jmp     short 39F5h
F000:39F5  [+0x0B9F5]  83 EA 03                 sub     dx,3
F000:39F8  [+0x0B9F8]  E8 2D 00                 call    3A28h
F000:39FB  [+0x0B9FB]  C1 EB 02                 shr     bx,2
F000:39FE  [+0x0B9FE]  EB 8B                    jmp     short 398Bh
F000:3A00  [+0x0BA00]  BB FE FF                 mov     bx,0FFFEh
F000:3A03  [+0x0BA03]  83 C3 02                 add     bx,2
F000:3A06  [+0x0BA06]  83 FB 04                 cmp     bx,4
F000:3A09  [+0x0BA09]  77 18                    ja      short 3A23h
F000:3A0B  [+0x0BA0B]  8B 97 EA 05              mov     dx,[bx+5EAh]
F000:3A0F  [+0x0BA0F]  F7 C2 FF 03              test    dx,3FFh
F000:3A13  [+0x0BA13]  74 EE                    je      short 3A03h
F000:3A15  [+0x0BA15]  83 C2 02                 add     dx,2
F000:3A18  [+0x0BA18]  D1 E3                    shl     bx,1
F000:3A1A  [+0x0BA1A]  8A 87 F0 05              mov     al,[bx+5F0h]
F000:3A1E  [+0x0BA1E]  EE                       out     dx,al
F000:3A1F  [+0x0BA1F]  D1 EB                    shr     bx,1
F000:3A21  [+0x0BA21]  EB E0                    jmp     short 3A03h
F000:3A23  [+0x0BA23]  5A                       pop     dx
F000:3A24  [+0x0BA24]  5B                       pop     bx
F000:3A25  [+0x0BA25]  58                       pop     ax
F000:3A26  [+0x0BA26]  C3                       ret
F000:3A27  [+0x0BA27]  C3                       ret
F000:3A28  [+0x0BA28]  50                       push    ax
F000:3A29  [+0x0BA29]  52                       push    dx
F000:3A2A  [+0x0BA2A]  83 C2 05                 add     dx,5
F000:3A2D  [+0x0BA2D]  EC                       in      al,dx
F000:3A2E  [+0x0BA2E]  EB 00                    jmp     short 3A30h
F000:3A30  [+0x0BA30]  42                       inc     dx
F000:3A31  [+0x0BA31]  EC                       in      al,dx
F000:3A32  [+0x0BA32]  EB 00                    jmp     short 3A34h
F000:3A34  [+0x0BA34]  83 EA 06                 sub     dx,6
F000:3A37  [+0x0BA37]  EC                       in      al,dx
F000:3A38  [+0x0BA38]  5A                       pop     dx
F000:3A39  [+0x0BA39]  58                       pop     ax
F000:3A3A  [+0x0BA3A]  C3                       ret
F000:3A3B  [+0x0BA3B]  50                       push    ax
F000:3A3C  [+0x0BA3C]  52                       push    dx
F000:3A3D  [+0x0BA3D]  BA E0 03                 mov     dx,3E0h
F000:3A40  [+0x0BA40]  B8 1E 04                 mov     ax,41Eh
F000:3A43  [+0x0BA43]  EF                       out     dx,ax
F000:3A44  [+0x0BA44]  EB 00                    jmp     short 3A46h
F000:3A46  [+0x0BA46]  EB 00                    jmp     short 3A48h
F000:3A48  [+0x0BA48]  5A                       pop     dx
F000:3A49  [+0x0BA49]  58                       pop     ax
F000:3A4A  [+0x0BA4A]  C3                       ret
F000:3A4B  [+0x0BA4B]  50                       push    ax
F000:3A4C  [+0x0BA4C]  53                       push    bx
F000:3A4D  [+0x0BA4D]  51                       push    cx
F000:3A4E  [+0x0BA4E]  52                       push    dx
F000:3A4F  [+0x0BA4F]  BA E0 03                 mov     dx,3E0h
F000:3A52  [+0x0BA52]  B8 1E 02                 mov     ax,21Eh
F000:3A55  [+0x0BA55]  EF                       out     dx,ax
F000:3A56  [+0x0BA56]  EB 00                    jmp     short 3A58h
F000:3A58  [+0x0BA58]  EB 00                    jmp     short 3A5Ah
F000:3A5A  [+0x0BA5A]  B9 FF FF                 mov     cx,0FFFFh
F000:3A5D  [+0x0BA5D]  EB 00                    jmp     short 3A5Fh
F000:3A5F  [+0x0BA5F]  EB 00                    jmp     short 3A61h
F000:3A61  [+0x0BA61]  E2 FA                    loop    3A5Dh
F000:3A63  [+0x0BA63]  B0 02                    mov     al,2
F000:3A65  [+0x0BA65]  E8 A1 00                 call    3B09h
F000:3A68  [+0x0BA68]  80 CC 08                 or      ah,8
F000:3A6B  [+0x0BA6B]  E8 B6 00                 call    3B24h
F000:3A6E  [+0x0BA6E]  B0 59                    mov     al,59h
F000:3A70  [+0x0BA70]  E8 79 E5                 call    1FECh
F000:3A73  [+0x0BA73]  86 C4                    xchg    al,ah
F000:3A75  [+0x0BA75]  8A F8                    mov     bh,al
F000:3A77  [+0x0BA77]  24 03                    and     al,3
F000:3A79  [+0x0BA79]  3C 01                    cmp     al,1
F000:3A7B  [+0x0BA7B]  0F 84 3A 00              je      near 3AB9h
F000:3A7F  [+0x0BA7F]  3C 02                    cmp     al,2
F000:3A81  [+0x0BA81]  0F 84 4D 00              je      near 3AD2h
F000:3A85  [+0x0BA85]  B0 03                    mov     al,3
F000:3A87  [+0x0BA87]  E8 7F 00                 call    3B09h
F000:3A8A  [+0x0BA8A]  80 E4 FB                 and     ah,0FBh
F000:3A8D  [+0x0BA8D]  E8 94 00                 call    3B24h
F000:3A90  [+0x0BA90]  B0 04                    mov     al,4
F000:3A92  [+0x0BA92]  E8 74 00                 call    3B09h
F000:3A95  [+0x0BA95]  80 E4 FC                 and     ah,0FCh
F000:3A98  [+0x0BA98]  E8 89 00                 call    3B24h
F000:3A9B  [+0x0BA9B]  8A C7                    mov     al,bh
F000:3A9D  [+0x0BA9D]  24 04                    and     al,4
F000:3A9F  [+0x0BA9F]  B1 02                    mov     cl,2
F000:3AA1  [+0x0BAA1]  D2 E8                    shr     al,cl
F000:3AA3  [+0x0BAA3]  B1 07                    mov     cl,7
F000:3AA5  [+0x0BAA5]  D2 E0                    shl     al,cl
F000:3AA7  [+0x0BAA7]  8A C8                    mov     cl,al
F000:3AA9  [+0x0BAA9]  B0 02                    mov     al,2
F000:3AAB  [+0x0BAAB]  E8 5B 00                 call    3B09h
F000:3AAE  [+0x0BAAE]  0A E1                    or      ah,cl
F000:3AB0  [+0x0BAB0]  80 CC 08                 or      ah,8
F000:3AB3  [+0x0BAB3]  E8 6E 00                 call    3B24h
F000:3AB6  [+0x0BAB6]  EB 4C                    jmp     short 3B04h
F000:3AB8  [+0x0BAB8]  90                       nop
F000:3AB9  [+0x0BAB9]  B0 03                    mov     al,3
F000:3ABB  [+0x0BABB]  E8 4B 00                 call    3B09h
F000:3ABE  [+0x0BABE]  80 CC 04                 or      ah,4
F000:3AC1  [+0x0BAC1]  E8 60 00                 call    3B24h
F000:3AC4  [+0x0BAC4]  B0 04                    mov     al,4
F000:3AC6  [+0x0BAC6]  E8 40 00                 call    3B09h
F000:3AC9  [+0x0BAC9]  80 E4 FC                 and     ah,0FCh
F000:3ACC  [+0x0BACC]  E8 55 00                 call    3B24h
F000:3ACF  [+0x0BACF]  EB 33                    jmp     short 3B04h
F000:3AD1  [+0x0BAD1]  90                       nop
F000:3AD2  [+0x0BAD2]  B0 03                    mov     al,3
F000:3AD4  [+0x0BAD4]  E8 32 00                 call    3B09h
F000:3AD7  [+0x0BAD7]  80 E4 FB                 and     ah,0FBh
F000:3ADA  [+0x0BADA]  E8 47 00                 call    3B24h
F000:3ADD  [+0x0BADD]  B0 04                    mov     al,4
F000:3ADF  [+0x0BADF]  E8 27 00                 call    3B09h
F000:3AE2  [+0x0BAE2]  80 E4 FC                 and     ah,0FCh
F000:3AE5  [+0x0BAE5]  80 CC 01                 or      ah,1
F000:3AE8  [+0x0BAE8]  8A C7                    mov     al,bh
F000:3AEA  [+0x0BAEA]  24 08                    and     al,8
F000:3AEC  [+0x0BAEC]  B1 03                    mov     cl,3
F000:3AEE  [+0x0BAEE]  FE C9                    dec     cl
F000:3AF0  [+0x0BAF0]  D2 E8                    shr     al,cl
F000:3AF2  [+0x0BAF2]  0A E0                    or      ah,al
F000:3AF4  [+0x0BAF4]  B0 04                    mov     al,4
F000:3AF6  [+0x0BAF6]  E8 2B 00                 call    3B24h
F000:3AF9  [+0x0BAF9]  B0 02                    mov     al,2
F000:3AFB  [+0x0BAFB]  E8 0B 00                 call    3B09h
F000:3AFE  [+0x0BAFE]  80 CC 80                 or      ah,80h
F000:3B01  [+0x0BB01]  E8 20 00                 call    3B24h
F000:3B04  [+0x0BB04]  5A                       pop     dx
F000:3B05  [+0x0BB05]  59                       pop     cx
F000:3B06  [+0x0BB06]  5B                       pop     bx
F000:3B07  [+0x0BB07]  58                       pop     ax
F000:3B08  [+0x0BB08]  C3                       ret
F000:3B09  [+0x0BB09]  BA 6E 02                 mov     dx,26Eh
F000:3B0C  [+0x0BB0C]  EE                       out     dx,al
F000:3B0D  [+0x0BB0D]  EB 00                    jmp     short 3B0Fh
F000:3B0F  [+0x0BB0F]  EB 00                    jmp     short 3B11h
F000:3B11  [+0x0BB11]  EB 00                    jmp     short 3B13h
F000:3B13  [+0x0BB13]  EB 00                    jmp     short 3B15h
F000:3B15  [+0x0BB15]  42                       inc     dx
F000:3B16  [+0x0BB16]  86 E0                    xchg    ah,al
F000:3B18  [+0x0BB18]  EC                       in      al,dx
F000:3B19  [+0x0BB19]  EB 00                    jmp     short 3B1Bh
F000:3B1B  [+0x0BB1B]  EB 00                    jmp     short 3B1Dh
F000:3B1D  [+0x0BB1D]  EB 00                    jmp     short 3B1Fh
F000:3B1F  [+0x0BB1F]  EB 00                    jmp     short 3B21h
F000:3B21  [+0x0BB21]  86 E0                    xchg    ah,al
F000:3B23  [+0x0BB23]  C3                       ret
F000:3B24  [+0x0BB24]  BA 6E 02                 mov     dx,26Eh
F000:3B27  [+0x0BB27]  EE                       out     dx,al
F000:3B28  [+0x0BB28]  EB 00                    jmp     short 3B2Ah
F000:3B2A  [+0x0BB2A]  EB 00                    jmp     short 3B2Ch
F000:3B2C  [+0x0BB2C]  EB 00                    jmp     short 3B2Eh
F000:3B2E  [+0x0BB2E]  EB 00                    jmp     short 3B30h
F000:3B30  [+0x0BB30]  8A C4                    mov     al,ah
F000:3B32  [+0x0BB32]  42                       inc     dx
F000:3B33  [+0x0BB33]  EE                       out     dx,al
F000:3B34  [+0x0BB34]  EB 00                    jmp     short 3B36h
F000:3B36  [+0x0BB36]  EE                       out     dx,al
F000:3B37  [+0x0BB37]  EB 00                    jmp     short 3B39h
F000:3B39  [+0x0BB39]  EB 00                    jmp     short 3B3Bh
F000:3B3B  [+0x0BB3B]  EB 00                    jmp     short 3B3Dh
F000:3B3D  [+0x0BB3D]  EB 00                    jmp     short 3B3Fh
F000:3B3F  [+0x0BB3F]  C3                       ret
F000:3B40  [+0x0BB40]  BA E0 03                 mov     dx,3E0h
F000:3B43  [+0x0BB43]  B0 01                    mov     al,1
F000:3B45  [+0x0BB45]  EE                       out     dx,al
F000:3B46  [+0x0BB46]  EB 00                    jmp     short 3B48h
F000:3B48  [+0x0BB48]  EB 00                    jmp     short 3B4Ah
F000:3B4A  [+0x0BB4A]  EB 00                    jmp     short 3B4Ch
F000:3B4C  [+0x0BB4C]  EB 00                    jmp     short 3B4Eh
F000:3B4E  [+0x0BB4E]  42                       inc     dx
F000:3B4F  [+0x0BB4F]  EC                       in      al,dx
F000:3B50  [+0x0BB50]  EB 00                    jmp     short 3B52h
F000:3B52  [+0x0BB52]  EB 00                    jmp     short 3B54h
F000:3B54  [+0x0BB54]  EB 00                    jmp     short 3B56h
F000:3B56  [+0x0BB56]  EB 00                    jmp     short 3B58h
F000:3B58  [+0x0BB58]  24 0C                    and     al,0Ch
F000:3B5A  [+0x0BB5A]  0A C0                    or      al,al
F000:3B5C  [+0x0BB5C]  0F 84 01 00              je      near 3B61h
F000:3B60  [+0x0BB60]  C3                       ret
F000:3B61  [+0x0BB61]  BA E0 03                 mov     dx,3E0h
F000:3B64  [+0x0BB64]  B0 41                    mov     al,41h
F000:3B66  [+0x0BB66]  EE                       out     dx,al
F000:3B67  [+0x0BB67]  EB 00                    jmp     short 3B69h
F000:3B69  [+0x0BB69]  EB 00                    jmp     short 3B6Bh
F000:3B6B  [+0x0BB6B]  EB 00                    jmp     short 3B6Dh
F000:3B6D  [+0x0BB6D]  EB 00                    jmp     short 3B6Fh
F000:3B6F  [+0x0BB6F]  42                       inc     dx
F000:3B70  [+0x0BB70]  EC                       in      al,dx
F000:3B71  [+0x0BB71]  EB 00                    jmp     short 3B73h
F000:3B73  [+0x0BB73]  EB 00                    jmp     short 3B75h
F000:3B75  [+0x0BB75]  EB 00                    jmp     short 3B77h
F000:3B77  [+0x0BB77]  EB 00                    jmp     short 3B79h
F000:3B79  [+0x0BB79]  24 0C                    and     al,0Ch
F000:3B7B  [+0x0BB7B]  0A C0                    or      al,al
F000:3B7D  [+0x0BB7D]  C3                       ret
F000:3B7E  [+0x0BB7E]  50                       push    ax
F000:3B7F  [+0x0BB7F]  53                       push    bx
F000:3B80  [+0x0BB80]  B8 0E 00                 mov     ax,0Eh
F000:3B83  [+0x0BB83]  BA 00 01                 mov     dx,100h
F000:3B86  [+0x0BB86]  22 DB                    and     bl,bl
F000:3B88  [+0x0BB88]  74 05                    je      short 3B8Fh
F000:3B8A  [+0x0BB8A]  E8 B4 D7                 call    1341h
F000:3B8D  [+0x0BB8D]  EB 03                    jmp     short 3B92h
F000:3B8F  [+0x0BB8F]  E8 A6 D7                 call    1338h
F000:3B92  [+0x0BB92]  5B                       pop     bx
F000:3B93  [+0x0BB93]  58                       pop     ax
F000:3B94  [+0x0BB94]  C3                       ret
F000:3B95  [+0x0BB95]  FA                       cli
F000:3B96  [+0x0BB96]  C6 06 F7 05 00           mov     byte [5F7h],0
F000:3B9B  [+0x0BB9B]  1E                       push    ds
F000:3B9C  [+0x0BB9C]  B8 00 00                 mov     ax,0
F000:3B9F  [+0x0BB9F]  8E D8                    mov     ds,ax
F000:3BA1  [+0x0BBA1]  B8 AD 3B                 mov     ax,3BADh
F000:3BA4  [+0x0BBA4]  A3 70 00                 mov     [70h],ax
F000:3BA7  [+0x0BBA7]  8C 0E 72 00              mov     [72h],cs
F000:3BAB  [+0x0BBAB]  1F                       pop     ds
F000:3BAC  [+0x0BBAC]  C3                       ret
F000:3BAD  [+0x0BBAD]  60                       pusha
F000:3BAE  [+0x0BBAE]  1E                       push    ds
F000:3BAF  [+0x0BBAF]  B8 00 DC                 mov     ax,0DC00h
F000:3BB2  [+0x0BBB2]  8E D8                    mov     ds,ax
F000:3BB4  [+0x0BBB4]  80 3E F7 05 00           cmp     byte [5F7h],0
F000:3BB9  [+0x0BBB9]  74 26                    je      short 3BE1h
F000:3BBB  [+0x0BBBB]  B4 01                    mov     ah,1
F000:3BBD  [+0x0BBBD]  8B 0E FB 05              mov     cx,[5FBh]
F000:3BC1  [+0x0BBC1]  8B 16 F9 05              mov     dx,[5F9h]
F000:3BC5  [+0x0BBC5]  CD 1A                    int     1Ah
F000:3BC7  [+0x0BBC7]  06                       push    es
F000:3BC8  [+0x0BBC8]  B8 00 00                 mov     ax,0
F000:3BCB  [+0x0BBCB]  8E C0                    mov     es,ax
F000:3BCD  [+0x0BBCD]  A0 F8 05                 mov     al,[5F8h]
F000:3BD0  [+0x0BBD0]  26 00 06 70 04           add     [es:470h],al
F000:3BD5  [+0x0BBD5]  07                       pop     es
F000:3BD6  [+0x0BBD6]  E8 71 D7                 call    134Ah
F000:3BD9  [+0x0BBD9]  C6 06 F7 05 00           mov     byte [5F7h],0
F000:3BDE  [+0x0BBDE]  E8 7D D7                 call    135Eh
F000:3BE1  [+0x0BBE1]  1F                       pop     ds
F000:3BE2  [+0x0BBE2]  61                       popa
F000:3BE3  [+0x0BBE3]  CF                       iret
F000:3BE4  [+0x0BBE4]  60                       pusha
F000:3BE5  [+0x0BBE5]  C6 06 F7 05 01           mov     byte [5F7h],1
F000:3BEA  [+0x0BBEA]  E8 57 01                 call    3D44h
F000:3BED  [+0x0BBED]  8A C2                    mov     al,dl
F000:3BEF  [+0x0BBEF]  D4 10                    aam     10h
F000:3BF1  [+0x0BBF1]  D5 0A                    aad
F000:3BF3  [+0x0BBF3]  A3 FD 05                 mov     [5FDh],ax
F000:3BF6  [+0x0BBF6]  8A C6                    mov     al,dh
F000:3BF8  [+0x0BBF8]  D4 10                    aam     10h
F000:3BFA  [+0x0BBFA]  D5 0A                    aad
F000:3BFC  [+0x0BBFC]  A3 FF 05                 mov     [5FFh],ax
F000:3BFF  [+0x0BBFF]  8A C5                    mov     al,ch
F000:3C01  [+0x0BC01]  D4 10                    aam     10h
F000:3C03  [+0x0BC03]  D5 0A                    aad
F000:3C05  [+0x0BC05]  B4 64                    mov     ah,64h
F000:3C07  [+0x0BC07]  F6 E4                    mul     ah
F000:3C09  [+0x0BC09]  8B D8                    mov     bx,ax
F000:3C0B  [+0x0BC0B]  8A C1                    mov     al,cl
F000:3C0D  [+0x0BC0D]  D4 10                    aam     10h
F000:3C0F  [+0x0BC0F]  D5 0A                    aad
F000:3C11  [+0x0BC11]  03 C3                    add     ax,bx
F000:3C13  [+0x0BC13]  A3 01 06                 mov     [601h],ax
F000:3C16  [+0x0BC16]  61                       popa
F000:3C17  [+0x0BC17]  C3                       ret
F000:3C18  [+0x0BC18]  60                       pusha
F000:3C19  [+0x0BC19]  E8 6D 00                 call    3C89h
F000:3C1C  [+0x0BC1C]  E8 08 00                 call    3C27h
F000:3C1F  [+0x0BC1F]  61                       popa
F000:3C20  [+0x0BC20]  C3                       ret
F000:3C21  [+0x0BC21]  3C 00                    cmp     al,0
F000:3C23  [+0x0BC23]  DC 34                    fdiv    qword [si]
F000:3C25  [+0x0BC25]  12 00                    adc     al,[bx+si]
F000:3C27  [+0x0BC27]  E8 4B 01                 call    3D75h
F000:3C2A  [+0x0BC2A]  8A C5                    mov     al,ch
F000:3C2C  [+0x0BC2C]  D4 10                    aam     10h
F000:3C2E  [+0x0BC2E]  D5 0A                    aad
F000:3C30  [+0x0BC30]  2E F6 26 21 3C           mul     byte [cs:3C21h]
F000:3C35  [+0x0BC35]  91                       xchg    cx,ax
F000:3C36  [+0x0BC36]  D4 10                    aam     10h
F000:3C38  [+0x0BC38]  D5 0A                    aad
F000:3C3A  [+0x0BC3A]  03 C1                    add     ax,cx
F000:3C3C  [+0x0BC3C]  8A DE                    mov     bl,dh
F000:3C3E  [+0x0BC3E]  2E F7 26 21 3C           mul     word [cs:3C21h]
F000:3C43  [+0x0BC43]  8B C8                    mov     cx,ax
F000:3C45  [+0x0BC45]  8A C3                    mov     al,bl
F000:3C47  [+0x0BC47]  D4 10                    aam     10h
F000:3C49  [+0x0BC49]  D5 0A                    aad
F000:3C4B  [+0x0BC4B]  03 C1                    add     ax,cx
F000:3C4D  [+0x0BC4D]  83 D2 00                 adc     dx,0
F000:3C50  [+0x0BC50]  C7 06 FB 05 00 00        mov     word [5FBh],0
F000:3C56  [+0x0BC56]  52                       push    dx
F000:3C57  [+0x0BC57]  50                       push    ax
F000:3C58  [+0x0BC58]  2E F7 26 23 3C           mul     word [cs:3C23h]
F000:3C5D  [+0x0BC5D]  89 16 F9 05              mov     [5F9h],dx
F000:3C61  [+0x0BC61]  58                       pop     ax
F000:3C62  [+0x0BC62]  2E F7 26 25 3C           mul     word [cs:3C25h]
F000:3C67  [+0x0BC67]  01 06 F9 05              add     [5F9h],ax
F000:3C6B  [+0x0BC6B]  11 16 FB 05              adc     [5FBh],dx
F000:3C6F  [+0x0BC6F]  58                       pop     ax
F000:3C70  [+0x0BC70]  50                       push    ax
F000:3C71  [+0x0BC71]  2E F7 26 23 3C           mul     word [cs:3C23h]
F000:3C76  [+0x0BC76]  01 06 F9 05              add     [5F9h],ax
F000:3C7A  [+0x0BC7A]  11 16 FB 05              adc     [5FBh],dx
F000:3C7E  [+0x0BC7E]  58                       pop     ax
F000:3C7F  [+0x0BC7F]  2E F6 26 25 3C           mul     byte [cs:3C25h]
F000:3C84  [+0x0BC84]  01 06 FB 05              add     [5FBh],ax
F000:3C88  [+0x0BC88]  C3                       ret
F000:3C89  [+0x0BC89]  E8 B8 00                 call    3D44h
F000:3C8C  [+0x0BC8C]  8A C2                    mov     al,dl
F000:3C8E  [+0x0BC8E]  D4 10                    aam     10h
F000:3C90  [+0x0BC90]  D5 0A                    aad
F000:3C92  [+0x0BC92]  A3 03 06                 mov     [603h],ax
F000:3C95  [+0x0BC95]  8A C6                    mov     al,dh
F000:3C97  [+0x0BC97]  D4 10                    aam     10h
F000:3C99  [+0x0BC99]  D5 0A                    aad
F000:3C9B  [+0x0BC9B]  A3 05 06                 mov     [605h],ax
F000:3C9E  [+0x0BC9E]  8A C5                    mov     al,ch
F000:3CA0  [+0x0BCA0]  D4 10                    aam     10h
F000:3CA2  [+0x0BCA2]  D5 0A                    aad
F000:3CA4  [+0x0BCA4]  B4 64                    mov     ah,64h
F000:3CA6  [+0x0BCA6]  F6 E4                    mul     ah
F000:3CA8  [+0x0BCA8]  8B D8                    mov     bx,ax
F000:3CAA  [+0x0BCAA]  8A C1                    mov     al,cl
F000:3CAC  [+0x0BCAC]  D4 10                    aam     10h
F000:3CAE  [+0x0BCAE]  D5 0A                    aad
F000:3CB0  [+0x0BCB0]  03 C3                    add     ax,bx
F000:3CB2  [+0x0BCB2]  A3 07 06                 mov     [607h],ax
F000:3CB5  [+0x0BCB5]  33 FF                    xor     di,di
F000:3CB7  [+0x0BCB7]  8B 1E FF 05              mov     bx,[5FFh]
F000:3CBB  [+0x0BCBB]  8B 0E FD 05              mov     cx,[5FDh]
F000:3CBF  [+0x0BCBF]  8B 16 01 06              mov     dx,[601h]
F000:3CC3  [+0x0BCC3]  E8 36 00                 call    3CFCh
F000:3CC6  [+0x0BCC6]  03 F8                    add     di,ax
F000:3CC8  [+0x0BCC8]  E8 43 00                 call    3D0Eh
F000:3CCB  [+0x0BCCB]  03 F8                    add     di,ax
F000:3CCD  [+0x0BCCD]  8B 1E 07 06              mov     bx,[607h]
F000:3CD1  [+0x0BCD1]  E8 57 00                 call    3D2Bh
F000:3CD4  [+0x0BCD4]  03 F8                    add     di,ax
F000:3CD6  [+0x0BCD6]  8B D3                    mov     dx,bx
F000:3CD8  [+0x0BCD8]  8B 1E 05 06              mov     bx,[605h]
F000:3CDC  [+0x0BCDC]  8B 0E 03 06              mov     cx,[603h]
F000:3CE0  [+0x0BCE0]  E8 19 00                 call    3CFCh
F000:3CE3  [+0x0BCE3]  2B F8                    sub     di,ax
F000:3CE5  [+0x0BCE5]  E8 26 00                 call    3D0Eh
F000:3CE8  [+0x0BCE8]  2B F8                    sub     di,ax
F000:3CEA  [+0x0BCEA]  97                       xchg    di,ax
F000:3CEB  [+0x0BCEB]  A2 F8 05                 mov     [5F8h],al
F000:3CEE  [+0x0BCEE]  C3                       ret
F000:3CEF  [+0x0BCEF]  FF 1F                    call    far [bx]
F000:3CF1  [+0x0BCF1]  1C 1F                    sbb     al,1Fh
F000:3CF3  [+0x0BCF3]  1E                       push    ds
F000:3CF4  [+0x0BCF4]  1F                       pop     ds
F000:3CF5  [+0x0BCF5]  1E                       push    ds
F000:3CF6  [+0x0BCF6]  1F                       pop     ds
F000:3CF7  [+0x0BCF7]  1F                       pop     ds
F000:3CF8  [+0x0BCF8]  1E                       push    ds
F000:3CF9  [+0x0BCF9]  1F                       pop     ds
F000:3CFA  [+0x0BCFA]  1E                       push    ds
F000:3CFB  [+0x0BCFB]  1F                       pop     ds
F000:3CFC  [+0x0BCFC]  32 E4                    xor     ah,ah
F000:3CFE  [+0x0BCFE]  2E 8A 87 EF 3C           mov     al,[cs:bx+3CEFh]
F000:3D03  [+0x0BD03]  2B C1                    sub     ax,cx
F000:3D05  [+0x0BD05]  83 FB 02                 cmp     bx,2
F000:3D08  [+0x0BD08]  75 03                    jne     short 3D0Dh
F000:3D0A  [+0x0BD0A]  E8 30 00                 call    3D3Dh
F000:3D0D  [+0x0BD0D]  C3                       ret
F000:3D0E  [+0x0BD0E]  53                       push    bx
F000:3D0F  [+0x0BD0F]  33 C0                    xor     ax,ax
F000:3D11  [+0x0BD11]  83 FB 0C                 cmp     bx,0Ch
F000:3D14  [+0x0BD14]  74 0B                    je      short 3D21h
F000:3D16  [+0x0BD16]  43                       inc     bx
F000:3D17  [+0x0BD17]  2E 02 87 EF 3C           add     al,[cs:bx+3CEFh]
F000:3D1C  [+0x0BD1C]  80 D4 00                 adc     ah,0
F000:3D1F  [+0x0BD1F]  EB F0                    jmp     short 3D11h
F000:3D21  [+0x0BD21]  5B                       pop     bx
F000:3D22  [+0x0BD22]  83 FB 02                 cmp     bx,2
F000:3D25  [+0x0BD25]  77 03                    ja      short 3D2Ah
F000:3D27  [+0x0BD27]  E8 13 00                 call    3D3Dh
F000:3D2A  [+0x0BD2A]  C3                       ret
F000:3D2B  [+0x0BD2B]  52                       push    dx
F000:3D2C  [+0x0BD2C]  33 C0                    xor     ax,ax
F000:3D2E  [+0x0BD2E]  3B D3                    cmp     dx,bx
F000:3D30  [+0x0BD30]  73 09                    jae     short 3D3Bh
F000:3D32  [+0x0BD32]  42                       inc     dx
F000:3D33  [+0x0BD33]  E8 07 00                 call    3D3Dh
F000:3D36  [+0x0BD36]  05 6D 01                 add     ax,16Dh
F000:3D39  [+0x0BD39]  EB F3                    jmp     short 3D2Eh
F000:3D3B  [+0x0BD3B]  5A                       pop     dx
F000:3D3C  [+0x0BD3C]  C3                       ret
F000:3D3D  [+0x0BD3D]  F6 C2 03                 test    dl,3
F000:3D40  [+0x0BD40]  75 01                    jne     short 3D43h
F000:3D42  [+0x0BD42]  40                       inc     ax
F000:3D43  [+0x0BD43]  C3                       ret
F000:3D44  [+0x0BD44]  B0 8A                    mov     al,8Ah
F000:3D46  [+0x0BD46]  E8 A3 E2                 call    1FECh
F000:3D49  [+0x0BD49]  F6 C4 80                 test    ah,80h
F000:3D4C  [+0x0BD4C]  75 F6                    jne     short 3D44h
F000:3D4E  [+0x0BD4E]  B0 87                    mov     al,87h
F000:3D50  [+0x0BD50]  E8 99 E2                 call    1FECh
F000:3D53  [+0x0BD53]  8A D4                    mov     dl,ah
F000:3D55  [+0x0BD55]  B0 88                    mov     al,88h
F000:3D57  [+0x0BD57]  E8 92 E2                 call    1FECh
F000:3D5A  [+0x0BD5A]  8A F4                    mov     dh,ah
F000:3D5C  [+0x0BD5C]  B0 89                    mov     al,89h
F000:3D5E  [+0x0BD5E]  E8 8B E2                 call    1FECh
F000:3D61  [+0x0BD61]  8A CC                    mov     cl,ah
F000:3D63  [+0x0BD63]  B0 B2                    mov     al,0B2h
F000:3D65  [+0x0BD65]  E8 84 E2                 call    1FECh
F000:3D68  [+0x0BD68]  8A EC                    mov     ch,ah
F000:3D6A  [+0x0BD6A]  B0 8A                    mov     al,8Ah
F000:3D6C  [+0x0BD6C]  E8 7D E2                 call    1FECh
F000:3D6F  [+0x0BD6F]  F6 C4 80                 test    ah,80h
F000:3D72  [+0x0BD72]  75 D0                    jne     short 3D44h
F000:3D74  [+0x0BD74]  C3                       ret
F000:3D75  [+0x0BD75]  B0 8A                    mov     al,8Ah
F000:3D77  [+0x0BD77]  E8 72 E2                 call    1FECh
F000:3D7A  [+0x0BD7A]  F6 C4 80                 test    ah,80h
F000:3D7D  [+0x0BD7D]  75 F6                    jne     short 3D75h
F000:3D7F  [+0x0BD7F]  B0 80                    mov     al,80h
F000:3D81  [+0x0BD81]  E8 68 E2                 call    1FECh
F000:3D84  [+0x0BD84]  8A F4                    mov     dh,ah
F000:3D86  [+0x0BD86]  B0 82                    mov     al,82h
F000:3D88  [+0x0BD88]  E8 61 E2                 call    1FECh
F000:3D8B  [+0x0BD8B]  8A CC                    mov     cl,ah
F000:3D8D  [+0x0BD8D]  B0 84                    mov     al,84h
F000:3D8F  [+0x0BD8F]  E8 5A E2                 call    1FECh
F000:3D92  [+0x0BD92]  8A EC                    mov     ch,ah
F000:3D94  [+0x0BD94]  B0 8A                    mov     al,8Ah
F000:3D96  [+0x0BD96]  E8 53 E2                 call    1FECh
F000:3D99  [+0x0BD99]  F6 C4 80                 test    ah,80h
F000:3D9C  [+0x0BD9C]  75 D7                    jne     short 3D75h
F000:3D9E  [+0x0BD9E]  C3                       ret
F000:3D9F  [+0x0BD9F]  00 B0 01 00              add     [bx+si+1],dh
F000:3DA3  [+0x0BDA3]  00 00                    add     [bx+si],al
F000:3DA5  [+0x0BDA5]  70 07                    jo      short 3DAEh
F000:3DA7  [+0x0BDA7]  07                       pop     es
F000:3DA8  [+0x0BDA8]  0F 70 1F 1F              pshufw  mm3,[bx],1Fh
F000:3DAC  [+0x0BDAC]  1E                       push    ds
F000:3DAD  [+0x0BDAD]  00 00                    add     [bx+si],al
F000:3DAF  [+0x0BDAF]  82 41 5E 41              add     byte [bx+di+5Eh],41h
F000:3DB3  [+0x0BDB3]  00 B0 0E 00              add     [bx+si+0Eh],dh
F000:3DB7  [+0x0BDB7]  00 00                    add     [bx+si],al
F000:3DB9  [+0x0BDB9]  70 07                    jo      short 3DC2h
F000:3DBB  [+0x0BDBB]  07                       pop     es
F000:3DBC  [+0x0BDBC]  0F 70 1F 1F              pshufw  mm3,[bx],1Fh
F000:3DC0  [+0x0BDC0]  1E                       push    ds
F000:3DC1  [+0x0BDC1]  00 00                    add     [bx+si],al
F000:3DC3  [+0x0BDC3]  E3 41                    jcxz    3E06h
F000:3DC5  [+0x0BDC5]  5E                       pop     si
F000:3DC6  [+0x0BDC6]  41                       inc     cx
F000:3DC7  [+0x0BDC7]  00 B0 08 00              add     [bx+si+8],dh
F000:3DCB  [+0x0BDCB]  00 00                    add     [bx+si],al
F000:3DCD  [+0x0BDCD]  70 07                    jo      short 3DD6h
F000:3DCF  [+0x0BDCF]  07                       pop     es
F000:3DD0  [+0x0BDD0]  0F 70 1F 1F              pshufw  mm3,[bx],1Fh
F000:3DD4  [+0x0BDD4]  1E                       push    ds
F000:3DD5  [+0x0BDD5]  6B 41 A0 42              imul    ax,[bx+di-60h],42h
F000:3DD9  [+0x0BDD9]  5E                       pop     si
F000:3DDA  [+0x0BDDA]  41                       inc     cx
F000:3DDB  [+0x0BDDB]  00 B0 08 00              add     [bx+si+8],dh
F000:3DDF  [+0x0BDDF]  00 00                    add     [bx+si],al
F000:3DE1  [+0x0BDE1]  70 07                    jo      short 3DEAh
F000:3DE3  [+0x0BDE3]  07                       pop     es
F000:3DE4  [+0x0BDE4]  0F 70 1F 1F              pshufw  mm3,[bx],1Fh
F000:3DE8  [+0x0BDE8]  1E                       push    ds
F000:3DE9  [+0x0BDE9]  6B 41 CF 42              imul    ax,[bx+di-31h],42h
F000:3DED  [+0x0BDED]  5E                       pop     si
F000:3DEE  [+0x0BDEE]  41                       inc     cx
F000:3DEF  [+0x0BDEF]  00 B0 09 00              add     [bx+si+9],dh
F000:3DF3  [+0x0BDF3]  00 00                    add     [bx+si],al
F000:3DF5  [+0x0BDF5]  70 07                    jo      short 3DFEh
F000:3DF7  [+0x0BDF7]  07                       pop     es
F000:3DF8  [+0x0BDF8]  0F 70 4F 4F 4F           pshufw  mm1,[bx+4Fh],4Fh
F000:3DFD  [+0x0BDFD]  77 41                    ja      short 3E40h
F000:3DFF  [+0x0BDFF]  DC 44 5E                 fadd    qword [si+5Eh]
F000:3E02  [+0x0BE02]  41                       inc     cx
F000:3E03  [+0x0BE03]  00 F0                    add     al,dh
F000:3E05  [+0x0BE05]  00 00                    add     [bx+si],al
F000:3E07  [+0x0BE07]  00 00                    add     [bx+si],al
F000:3E09  [+0x0BE09]  70 07                    jo      short 3E12h
F000:3E0B  [+0x0BE0B]  07                       pop     es
F000:3E0C  [+0x0BE0C]  0F 70 1F 1F              pshufw  mm3,[bx],1Fh
F000:3E10  [+0x0BE10]  1E                       push    ds
F000:3E11  [+0x0BE11]  00 00                    add     [bx+si],al
F000:3E13  [+0x0BE13]  03 43 5E                 add     ax,[bp+di+5Eh]
F000:3E16  [+0x0BE16]  41                       inc     cx
F000:3E17  [+0x0BE17]  00 00                    add     [bx+si],al
F000:3E19  [+0x0BE19]  02 3F                    add     bh,[bx]
F000:3E1B  [+0x0BE1B]  13 0E 70 07              adc     cx,[770h]
F000:3E1F  [+0x0BE1F]  07                       pop     es
F000:3E20  [+0x0BE20]  0F 70 4F 4F 4F           pshufw  mm1,[bx+4Fh],4Fh
F000:3E25  [+0x0BE25]  00 00                    add     [bx+si],al
F000:3E27  [+0x0BE27]  27                       daa
F000:3E28  [+0x0BE28]  43                       inc     bx
F000:3E29  [+0x0BE29]  5E                       pop     si
F000:3E2A  [+0x0BE2A]  41                       inc     cx
F000:3E2B  [+0x0BE2B]  00 B0 15 00              add     [bx+si+15h],dh
F000:3E2F  [+0x0BE2F]  00 00                    add     [bx+si],al
F000:3E31  [+0x0BE31]  70 07                    jo      short 3E3Ah
F000:3E33  [+0x0BE33]  07                       pop     es
F000:3E34  [+0x0BE34]  0F 70 1F 1F              pshufw  mm3,[bx],1Fh
F000:3E38  [+0x0BE38]  1E                       push    ds
F000:3E39  [+0x0BE39]  6B 41 CF 42              imul    ax,[bx+di-31h],42h
F000:3E3D  [+0x0BE3D]  5E                       pop     si
F000:3E3E  [+0x0BE3E]  41                       inc     cx
F000:3E3F  [+0x0BE3F]  00 B8 00 00              add     [bx+si],bh
F000:3E43  [+0x0BE43]  00 00                    add     [bx+si],al
F000:3E45  [+0x0BE45]  70 07                    jo      short 3E4Eh
F000:3E47  [+0x0BE47]  07                       pop     es
F000:3E48  [+0x0BE48]  0F 70 4F 4F 4F           pshufw  mm1,[bx+4Fh],4Fh
F000:3E4D  [+0x0BE4D]  77 41                    ja      short 3E90h
F000:3E4F  [+0x0BE4F]  0F 45 5E 41              cmovne  bx,[bp+41h]
F000:3E53  [+0x0BE53]  7A 43                    jp      short 3E98h
F000:3E55  [+0x0BE55]  8B 43 AF                 mov     ax,[bp+di-51h]
F000:3E58  [+0x0BE58]  43                       inc     bx
F000:3E59  [+0x0BE59]  D6                       salc
F000:3E5A  [+0x0BE5A]  43                       inc     bx
F000:3E5B  [+0x0BE5B]  FB                       sti
F000:3E5C  [+0x0BE5C]  43                       inc     bx
F000:3E5D  [+0x0BE5D]  2A 44 57                 sub     al,[si+57h]
F000:3E60  [+0x0BE60]  44                       inc     sp
F000:3E61  [+0x0BE61]  78 44                    js      short 3EA7h
F000:3E63  [+0x0BE63]  95                       xchg    bp,ax
F000:3E64  [+0x0BE64]  44                       inc     sp
F000:3E65  [+0x0BE65]  C1 44 E8 4C              rol     word [si-18h],4Ch
F000:3E69  [+0x0BE69]  00 0E 07 BF              add     [0BF07h],cl
F000:3E6D  [+0x0BE6D]  DB 0xC7  (bad)
F000:3E6F  [+0x0BE6F]  E8 31 0F                 call    4DA3h
F000:3E72  [+0x0BE72]  C3                       ret
F000:3E73  [+0x0BE73]  E8 40 00                 call    3EB6h
F000:3E76  [+0x0BE76]  BF DB 3D                 mov     di,3DDBh
F000:3E79  [+0x0BE79]  E8 27 0F                 call    4DA3h
F000:3E7C  [+0x0BE7C]  C3                       ret
F000:3E7D  [+0x0BE7D]  B4 00                    mov     ah,0
F000:3E7F  [+0x0BE7F]  3C 0A                    cmp     al,0Ah
F000:3E81  [+0x0BE81]  72 02                    jb      short 3E85h
F000:3E83  [+0x0BE83]  B0 00                    mov     al,0
F000:3E85  [+0x0BE85]  0E                       push    cs
F000:3E86  [+0x0BE86]  07                       pop     es
F000:3E87  [+0x0BE87]  BF EF 3D                 mov     di,3DEFh
F000:3E8A  [+0x0BE8A]  E8 16 0F                 call    4DA3h
F000:3E8D  [+0x0BE8D]  8B D8                    mov     bx,ax
F000:3E8F  [+0x0BE8F]  D1 E3                    shl     bx,1
F000:3E91  [+0x0BE91]  2E 8B BF 53 3E           mov     di,[cs:bx+3E53h]
F000:3E96  [+0x0BE96]  E8 6C 08                 call    4705h
F000:3E99  [+0x0BE99]  E8 63 07                 call    45FFh
F000:3E9C  [+0x0BE9C]  E8 A7 10                 call    4F46h
F000:3E9F  [+0x0BE9F]  2E 8A 36 F1 3D           mov     dh,[cs:3DF1h]
F000:3EA4  [+0x0BEA4]  FE C6                    inc     dh
F000:3EA6  [+0x0BEA6]  E8 23 02                 call    40CCh
F000:3EA9  [+0x0BEA9]  C3                       ret
F000:3EAA  [+0x0BEAA]  E8 55 00                 call    3F02h
F000:3EAD  [+0x0BEAD]  0E                       push    cs
F000:3EAE  [+0x0BEAE]  07                       pop     es
F000:3EAF  [+0x0BEAF]  BF 03 3E                 mov     di,3E03h
F000:3EB2  [+0x0BEB2]  E8 EE 0E                 call    4DA3h
F000:3EB5  [+0x0BEB5]  C3                       ret
F000:3EB6  [+0x0BEB6]  E8 37 02                 call    40F0h
F000:3EB9  [+0x0BEB9]  E8 46 00                 call    3F02h
F000:3EBC  [+0x0BEBC]  BF 9F 3D                 mov     di,3D9Fh
F000:3EBF  [+0x0BEBF]  E8 E1 0E                 call    4DA3h
F000:3EC2  [+0x0BEC2]  BF B3 3D                 mov     di,3DB3h
F000:3EC5  [+0x0BEC5]  E8 DB 0E                 call    4DA3h
F000:3EC8  [+0x0BEC8]  BF B3 3D                 mov     di,3DB3h
F000:3ECB  [+0x0BECB]  E8 36 0F                 call    4E04h
F000:3ECE  [+0x0BECE]  BF E3 41                 mov     di,41E3h
F000:3ED1  [+0x0BED1]  E8 31 08                 call    4705h
F000:3ED4  [+0x0BED4]  B0 30                    mov     al,30h
F000:3ED6  [+0x0BED6]  E8 52 07                 call    462Bh
F000:3ED9  [+0x0BED9]  FE C1                    inc     cl
F000:3EDB  [+0x0BEDB]  02 CA                    add     cl,dl
F000:3EDD  [+0x0BEDD]  36 88 0E 0B 00           mov     [ss:0Bh],cl
F000:3EE2  [+0x0BEE2]  33 C0                    xor     ax,ax
F000:3EE4  [+0x0BEE4]  36 A2 00 00              mov     [ss:0],al
F000:3EE8  [+0x0BEE8]  36 A3 01 00              mov     [ss:1],ax
F000:3EEC  [+0x0BEEC]  36 A3 05 00              mov     [ss:5],ax
F000:3EF0  [+0x0BEF0]  36 A3 03 00              mov     [ss:3],ax
F000:3EF4  [+0x0BEF4]  36 A3 07 00              mov     [ss:7],ax
F000:3EF8  [+0x0BEF8]  36 A3 09 00              mov     [ss:9],ax
F000:3EFC  [+0x0BEFC]  8B C8                    mov     cx,ax
F000:3EFE  [+0x0BEFE]  E8 27 00                 call    3F28h
F000:3F01  [+0x0BF01]  C3                       ret
F000:3F02  [+0x0BF02]  0E                       push    cs
F000:3F03  [+0x0BF03]  07                       pop     es
F000:3F04  [+0x0BF04]  BF 5E 41                 mov     di,415Eh
F000:3F07  [+0x0BF07]  E8 FB 07                 call    4705h
F000:3F0A  [+0x0BF0A]  26 8A 45 08              mov     al,[es:di+8]
F000:3F0E  [+0x0BF0E]  B4 03                    mov     ah,3
F000:3F10  [+0x0BF10]  E8 FB 01                 call    410Eh
F000:3F13  [+0x0BF13]  74 02                    je      short 3F17h
F000:3F15  [+0x0BF15]  B4 07                    mov     ah,7
F000:3F17  [+0x0BF17]  E8 67 01                 call    4081h
F000:3F1A  [+0x0BF1A]  C3                       ret
F000:3F1B  [+0x0BF1B]  36 A2 00 00              mov     [ss:0],al
F000:3F1F  [+0x0BF1F]  C3                       ret
F000:3F20  [+0x0BF20]  01 00                    add     [bx+si],ax
F000:3F22  [+0x0BF22]  03 00                    add     ax,[bx+si]
F000:3F24  [+0x0BF24]  05 00 07                 add     ax,700h
F000:3F27  [+0x0BF27]  00 60 06                 add     [bx+si+6],ah
F000:3F2A  [+0x0BF2A]  33 C0                    xor     ax,ax
F000:3F2C  [+0x0BF2C]  8A C1                    mov     al,cl
F000:3F2E  [+0x0BF2E]  B7 00                    mov     bh,0
F000:3F30  [+0x0BF30]  36 8A 1E 00 00           mov     bl,[ss:0]
F000:3F35  [+0x0BF35]  8B CB                    mov     cx,bx
F000:3F37  [+0x0BF37]  D1 E3                    shl     bx,1
F000:3F39  [+0x0BF39]  2E 8B 9F 20 3F           mov     bx,[cs:bx+3F20h]
F000:3F3E  [+0x0BF3E]  36 01 07                 add     [ss:bx],ax
F000:3F41  [+0x0BF41]  36 01 06 09 00           add     [ss:9],ax
F000:3F46  [+0x0BF46]  B8 06 00                 mov     ax,6
F000:3F49  [+0x0BF49]  E8 A2 06                 call    45EEh
F000:3F4C  [+0x0BF4C]  36 8B 07                 mov     ax,[ss:bx]
F000:3F4F  [+0x0BF4F]  B3 20                    mov     bl,20h
F000:3F51  [+0x0BF51]  E8 62 07                 call    46B6h
F000:3F54  [+0x0BF54]  36 8A 36 00 00           mov     dh,[ss:0]
F000:3F59  [+0x0BF59]  2E 02 36 B5 3D           add     dh,[cs:3DB5h]
F000:3F5E  [+0x0BF5E]  FE C6                    inc     dh
F000:3F60  [+0x0BF60]  36 8A 16 0B 00           mov     dl,[ss:0Bh]
F000:3F65  [+0x0BF65]  B9 05 00                 mov     cx,5
F000:3F68  [+0x0BF68]  E8 61 01                 call    40CCh
F000:3F6B  [+0x0BF6B]  36 A1 09 00              mov     ax,[ss:9]
F000:3F6F  [+0x0BF6F]  E8 44 07                 call    46B6h
F000:3F72  [+0x0BF72]  2E 8A 36 B5 3D           mov     dh,[cs:3DB5h]
F000:3F77  [+0x0BF77]  80 C6 06                 add     dh,6
F000:3F7A  [+0x0BF7A]  E8 4F 01                 call    40CCh
F000:3F7D  [+0x0BF7D]  C9                       leave
F000:3F7E  [+0x0BF7E]  07                       pop     es
F000:3F7F  [+0x0BF7F]  61                       popa
F000:3F80  [+0x0BF80]  C3                       ret
F000:3F81  [+0x0BF81]  AC                       lodsb
F000:3F82  [+0x0BF82]  A0 A8 A4                 mov     al,[0A4A8h]
F000:3F85  [+0x0BF85]  9C                       pushf
F000:3F86  [+0x0BF86]  98                       cbw
F000:3F87  [+0x0BF87]  94                       xchg    sp,ax
F000:3F88  [+0x0BF88]  90                       nop
F000:3F89  [+0x0BF89]  0A 08                    or      cl,[bx+si]
F000:3F8B  [+0x0BF8B]  06                       push    es
F000:3F8C  [+0x0BF8C]  04 02                    add     al,2
F000:3F8E  [+0x0BF8E]  32 30                    xor     dh,[bx+si]
F000:3F90  [+0x0BF90]  8C 0B                    mov     [bp+di],cs
F000:3F92  [+0x0BF92]  4E                       dec     si
F000:3F93  [+0x0BF93]  56                       push    si
F000:3F94  [+0x0BF94]  00 4F 56                 add     [bx+56h],cl
F000:3F97  [+0x0BF97]  00 0A                    add     [bp+si],cl
F000:3F99  [+0x0BF99]  55                       push    bp
F000:3F9A  [+0x0BF9A]  50                       push    ax
F000:3F9B  [+0x0BF9B]  00 44 4E                 add     [si+4Eh],al
F000:3F9E  [+0x0BF9E]  00 09                    add     [bx+di],cl
F000:3FA0  [+0x0BFA0]  44                       inc     sp
F000:3FA1  [+0x0BFA1]  49                       dec     cx
F000:3FA2  [+0x0BFA2]  00 45 49                 add     [di+49h],al
F000:3FA5  [+0x0BFA5]  00 07                    add     [bx],al
F000:3FA7  [+0x0BFA7]  50                       push    ax
F000:3FA8  [+0x0BFA8]  4C                       dec     sp
F000:3FA9  [+0x0BFA9]  00 4E 47                 add     [bp+47h],cl
F000:3FAC  [+0x0BFAC]  00 06 4E 5A              add     [5A4Eh],al
F000:3FB0  [+0x0BFB0]  00 5A 52                 add     [bp+si+52h],bl
F000:3FB3  [+0x0BFB3]  00 04                    add     [si],al
F000:3FB5  [+0x0BFB5]  4E                       dec     si
F000:3FB6  [+0x0BFB6]  41                       inc     cx
F000:3FB7  [+0x0BFB7]  00 41 43                 add     [bx+di+43h],al
F000:3FBA  [+0x0BFBA]  00 02                    add     [bp+si],al
F000:3FBC  [+0x0BFBC]  50                       push    ax
F000:3FBD  [+0x0BFBD]  4F                       dec     di
F000:3FBE  [+0x0BFBE]  00 50 45                 add     [bx+si+45h],dl
F000:3FC1  [+0x0BFC1]  00 00                    add     [bx+si],al
F000:3FC3  [+0x0BFC3]  4E                       dec     si
F000:3FC4  [+0x0BFC4]  43                       inc     bx
F000:3FC5  [+0x0BFC5]  00 43 59                 add     [bp+di+59h],al
F000:3FC8  [+0x0BFC8]  00 66 60                 add     [bp+60h],ah
F000:3FCB  [+0x0BFCB]  66 9C                    pushfd
F000:3FCD  [+0x0BFCD]  1E                       push    ds
F000:3FCE  [+0x0BFCE]  06                       push    es
F000:3FCF  [+0x0BFCF]  0F A0                    push    fs
F000:3FD1  [+0x0BFD1]  0F A8                    push    gs
F000:3FD3  [+0x0BFD3]  16                       push    ss
F000:3FD4  [+0x0BFD4]  0E                       push    cs
F000:3FD5  [+0x0BFD5]  07                       pop     es
F000:3FD6  [+0x0BFD6]  BF 17 3E                 mov     di,3E17h
F000:3FD9  [+0x0BFD9]  E8 C7 0D                 call    4DA3h
F000:3FDC  [+0x0BFDC]  B8 0A 00                 mov     ax,0Ah
F000:3FDF  [+0x0BFDF]  E8 0C 06                 call    45EEh
F000:3FE2  [+0x0BFE2]  FF 76 30                 push    word [bp+30h]
F000:3FE5  [+0x0BFE5]  83 6E 30 05              sub     word [bp+30h],5
F000:3FE9  [+0x0BFE9]  83 46 1C 04              add     word [bp+1Ch],4
F000:3FED  [+0x0BFED]  2E 8A 36 19 3E           mov     dh,[cs:3E19h]
F000:3FF2  [+0x0BFF2]  2E 8A 16 1A 3E           mov     dl,[cs:3E1Ah]
F000:3FF7  [+0x0BFF7]  81 C2 06 01              add     dx,106h
F000:3FFB  [+0x0BFFB]  B9 10 00                 mov     cx,10h
F000:3FFE  [+0x0BFFE]  BB 81 3F                 mov     bx,3F81h
F000:4001  [+0x0C001]  51                       push    cx
F000:4002  [+0x0C002]  2E 0F B6 37              movzx   si,byte [cs:bx]
F000:4006  [+0x0C006]  0F BA F6 07              btr     si,7
F000:400A  [+0x0C00A]  8D 32                    lea     si,[bp+si]
F000:400C  [+0x0C00C]  36 66 8B 04              mov     eax,[ss:si]
F000:4010  [+0x0C010]  68 20 40                 push    4020h
F000:4013  [+0x0C013]  B9 08 00                 mov     cx,8
F000:4016  [+0x0C016]  0F 82 54 06              jb      near 466Eh
F000:401A  [+0x0C01A]  B9 04 00                 mov     cx,4
F000:401D  [+0x0C01D]  E9 3F 06                 jmp     465Fh
F000:4020  [+0x0C020]  E8 A9 00                 call    40CCh
F000:4023  [+0x0C023]  FE C6                    inc     dh
F000:4025  [+0x0C025]  43                       inc     bx
F000:4026  [+0x0C026]  59                       pop     cx
F000:4027  [+0x0C027]  E2 D8                    loop    4001h
F000:4029  [+0x0C029]  0E                       push    cs
F000:402A  [+0x0C02A]  07                       pop     es
F000:402B  [+0x0C02B]  80 EA 04                 sub     dl,4
F000:402E  [+0x0C02E]  80 C6 01                 add     dh,1
F000:4031  [+0x0C031]  BB 91 3F                 mov     bx,3F91h
F000:4034  [+0x0C034]  B9 02 00                 mov     cx,2
F000:4037  [+0x0C037]  51                       push    cx
F000:4038  [+0x0C038]  52                       push    dx
F000:4039  [+0x0C039]  B9 04 00                 mov     cx,4
F000:403C  [+0x0C03C]  2E 66 0F B6 37           movzx   esi,byte [cs:bx]
F000:4041  [+0x0C041]  8D 7F 01                 lea     di,[bx+1]
F000:4044  [+0x0C044]  66 0F A3 76 0C           bt      [bp+0Ch],esi
F000:4049  [+0x0C049]  73 03                    jae     short 404Eh
F000:404B  [+0x0C04B]  83 C7 03                 add     di,3
F000:404E  [+0x0C04E]  51                       push    cx
F000:404F  [+0x0C04F]  B9 02 00                 mov     cx,2
F000:4052  [+0x0C052]  E8 77 00                 call    40CCh
F000:4055  [+0x0C055]  59                       pop     cx
F000:4056  [+0x0C056]  83 C2 03                 add     dx,3
F000:4059  [+0x0C059]  83 C3 07                 add     bx,7
F000:405C  [+0x0C05C]  E2 DE                    loop    403Ch
F000:405E  [+0x0C05E]  5A                       pop     dx
F000:405F  [+0x0C05F]  59                       pop     cx
F000:4060  [+0x0C060]  FE C6                    inc     dh
F000:4062  [+0x0C062]  E2 D3                    loop    4037h
F000:4064  [+0x0C064]  8F 46 30                 pop     word [bp+30h]
F000:4067  [+0x0C067]  C9                       leave
F000:4068  [+0x0C068]  83 C4 06                 add     sp,6
F000:406B  [+0x0C06B]  07                       pop     es
F000:406C  [+0x0C06C]  1F                       pop     ds
F000:406D  [+0x0C06D]  66 9D                    popfd
F000:406F  [+0x0C06F]  66 61                    popad
F000:4071  [+0x0C071]  CB                       retf
F000:4072  [+0x0C072]  60                       pusha
F000:4073  [+0x0C073]  1E                       push    ds
F000:4074  [+0x0C074]  06                       push    es
F000:4075  [+0x0C075]  0E                       push    cs
F000:4076  [+0x0C076]  07                       pop     es
F000:4077  [+0x0C077]  BF 2B 3E                 mov     di,3E2Bh
F000:407A  [+0x0C07A]  E8 26 0D                 call    4DA3h
F000:407D  [+0x0C07D]  07                       pop     es
F000:407E  [+0x0C07E]  1F                       pop     ds
F000:407F  [+0x0C07F]  61                       popa
F000:4080  [+0x0C080]  C3                       ret
F000:4081  [+0x0C081]  51                       push    cx
F000:4082  [+0x0C082]  52                       push    dx
F000:4083  [+0x0C083]  50                       push    ax
F000:4084  [+0x0C084]  E8 97 00                 call    411Eh
F000:4087  [+0x0C087]  8A C1                    mov     al,cl
F000:4089  [+0x0C089]  F6 E5                    mul     ch
F000:408B  [+0x0C08B]  8B C8                    mov     cx,ax
F000:408D  [+0x0C08D]  58                       pop     ax
F000:408E  [+0x0C08E]  33 D2                    xor     dx,dx
F000:4090  [+0x0C090]  E8 18 00                 call    40ABh
F000:4093  [+0x0C093]  5A                       pop     dx
F000:4094  [+0x0C094]  59                       pop     cx
F000:4095  [+0x0C095]  C3                       ret
F000:4096  [+0x0C096]  57                       push    di
F000:4097  [+0x0C097]  06                       push    es
F000:4098  [+0x0C098]  E8 93 00                 call    412Eh
F000:409B  [+0x0C09B]  AA                       stosb
F000:409C  [+0x0C09C]  07                       pop     es
F000:409D  [+0x0C09D]  5F                       pop     di
F000:409E  [+0x0C09E]  C3                       ret
F000:409F  [+0x0C09F]  57                       push    di
F000:40A0  [+0x0C0A0]  06                       push    es
F000:40A1  [+0x0C0A1]  E8 8A 00                 call    412Eh
F000:40A4  [+0x0C0A4]  26 88 65 01              mov     [es:di+1],ah
F000:40A8  [+0x0C0A8]  07                       pop     es
F000:40A9  [+0x0C0A9]  5F                       pop     di
F000:40AA  [+0x0C0AA]  C3                       ret
F000:40AB  [+0x0C0AB]  51                       push    cx
F000:40AC  [+0x0C0AC]  57                       push    di
F000:40AD  [+0x0C0AD]  06                       push    es
F000:40AE  [+0x0C0AE]  FC                       cld
F000:40AF  [+0x0C0AF]  E8 7C 00                 call    412Eh
F000:40B2  [+0x0C0B2]  F3 AB                    rep stosw
F000:40B4  [+0x0C0B4]  07                       pop     es
F000:40B5  [+0x0C0B5]  5F                       pop     di
F000:40B6  [+0x0C0B6]  59                       pop     cx
F000:40B7  [+0x0C0B7]  C3                       ret
F000:40B8  [+0x0C0B8]  FC                       cld
F000:40B9  [+0x0C0B9]  60                       pusha
F000:40BA  [+0x0C0BA]  1E                       push    ds
F000:40BB  [+0x0C0BB]  06                       push    es
F000:40BC  [+0x0C0BC]  E8 9A 00                 call    4159h
F000:40BF  [+0x0C0BF]  E8 6C 00                 call    412Eh
F000:40C2  [+0x0C0C2]  8A C4                    mov     al,ah
F000:40C4  [+0x0C0C4]  A4                       movsb
F000:40C5  [+0x0C0C5]  AA                       stosb
F000:40C6  [+0x0C0C6]  E2 FC                    loop    40C4h
F000:40C8  [+0x0C0C8]  07                       pop     es
F000:40C9  [+0x0C0C9]  1F                       pop     ds
F000:40CA  [+0x0C0CA]  61                       popa
F000:40CB  [+0x0C0CB]  C3                       ret
F000:40CC  [+0x0C0CC]  FC                       cld
F000:40CD  [+0x0C0CD]  60                       pusha
F000:40CE  [+0x0C0CE]  1E                       push    ds
F000:40CF  [+0x0C0CF]  06                       push    es
F000:40D0  [+0x0C0D0]  E8 86 00                 call    4159h
F000:40D3  [+0x0C0D3]  E8 58 00                 call    412Eh
F000:40D6  [+0x0C0D6]  A4                       movsb
F000:40D7  [+0x0C0D7]  47                       inc     di
F000:40D8  [+0x0C0D8]  E2 FC                    loop    40D6h
F000:40DA  [+0x0C0DA]  07                       pop     es
F000:40DB  [+0x0C0DB]  1F                       pop     ds
F000:40DC  [+0x0C0DC]  61                       popa
F000:40DD  [+0x0C0DD]  C3                       ret
F000:40DE  [+0x0C0DE]  51                       push    cx
F000:40DF  [+0x0C0DF]  52                       push    dx
F000:40E0  [+0x0C0E0]  51                       push    cx
F000:40E1  [+0x0C0E1]  B5 00                    mov     ch,0
F000:40E3  [+0x0C0E3]  E8 C5 FF                 call    40ABh
F000:40E6  [+0x0C0E6]  FE C6                    inc     dh
F000:40E8  [+0x0C0E8]  59                       pop     cx
F000:40E9  [+0x0C0E9]  FE CD                    dec     ch
F000:40EB  [+0x0C0EB]  75 F3                    jne     short 40E0h
F000:40ED  [+0x0C0ED]  5A                       pop     dx
F000:40EE  [+0x0C0EE]  59                       pop     cx
F000:40EF  [+0x0C0EF]  C3                       ret
F000:40F0  [+0x0C0F0]  50                       push    ax
F000:40F1  [+0x0C0F1]  52                       push    dx
F000:40F2  [+0x0C0F2]  B8 0A 1F                 mov     ax,1F0Ah
F000:40F5  [+0x0C0F5]  BA D4 03                 mov     dx,3D4h
F000:40F8  [+0x0C0F8]  E8 08 00                 call    4103h
F000:40FB  [+0x0C0FB]  74 02                    je      short 40FFh
F000:40FD  [+0x0C0FD]  B6 3B                    mov     dh,3Bh
F000:40FF  [+0x0C0FF]  EF                       out     dx,ax
F000:4100  [+0x0C100]  5A                       pop     dx
F000:4101  [+0x0C101]  58                       pop     ax
F000:4102  [+0x0C102]  C3                       ret
F000:4103  [+0x0C103]  1E                       push    ds
F000:4104  [+0x0C104]  6A 00                    push    0
F000:4106  [+0x0C106]  1F                       pop     ds
F000:4107  [+0x0C107]  80 3E 49 04 03           cmp     byte [449h],3
F000:410C  [+0x0C10C]  1F                       pop     ds
F000:410D  [+0x0C10D]  C3                       ret
F000:410E  [+0x0C10E]  1E                       push    ds
F000:410F  [+0x0C10F]  6A 00                    push    0
F000:4111  [+0x0C111]  1F                       pop     ds
F000:4112  [+0x0C112]  F6 06 89 04 04           test    byte [489h],4
F000:4117  [+0x0C117]  75 03                    jne     short 411Ch
F000:4119  [+0x0C119]  E8 E7 FF                 call    4103h
F000:411C  [+0x0C11C]  1F                       pop     ds
F000:411D  [+0x0C11D]  C3                       ret
F000:411E  [+0x0C11E]  1E                       push    ds
F000:411F  [+0x0C11F]  6A 00                    push    0
F000:4121  [+0x0C121]  1F                       pop     ds
F000:4122  [+0x0C122]  8B 0E 4A 04              mov     cx,[44Ah]
F000:4126  [+0x0C126]  8A 2E 84 04              mov     ch,[484h]
F000:412A  [+0x0C12A]  FE C5                    inc     ch
F000:412C  [+0x0C12C]  1F                       pop     ds
F000:412D  [+0x0C12D]  C3                       ret
F000:412E  [+0x0C12E]  50                       push    ax
F000:412F  [+0x0C12F]  53                       push    bx
F000:4130  [+0x0C130]  52                       push    dx
F000:4131  [+0x0C131]  33 C0                    xor     ax,ax
F000:4133  [+0x0C133]  8E C0                    mov     es,ax
F000:4135  [+0x0C135]  8B DA                    mov     bx,dx
F000:4137  [+0x0C137]  86 C7                    xchg    al,bh
F000:4139  [+0x0C139]  26 F7 26 4A 04           mul     word [es:44Ah]
F000:413E  [+0x0C13E]  03 C3                    add     ax,bx
F000:4140  [+0x0C140]  D1 E0                    shl     ax,1
F000:4142  [+0x0C142]  26 03 06 4E 04           add     ax,[es:44Eh]
F000:4147  [+0x0C147]  8B F8                    mov     di,ax
F000:4149  [+0x0C149]  B8 00 B8                 mov     ax,0B800h
F000:414C  [+0x0C14C]  E8 B4 FF                 call    4103h
F000:414F  [+0x0C14F]  74 02                    je      short 4153h
F000:4151  [+0x0C151]  B4 B0                    mov     ah,0B0h
F000:4153  [+0x0C153]  8E C0                    mov     es,ax
F000:4155  [+0x0C155]  5A                       pop     dx
F000:4156  [+0x0C156]  5B                       pop     bx
F000:4157  [+0x0C157]  58                       pop     ax
F000:4158  [+0x0C158]  C3                       ret
F000:4159  [+0x0C159]  06                       push    es
F000:415A  [+0x0C15A]  1F                       pop     ds
F000:415B  [+0x0C15B]  8B F7                    mov     si,di
F000:415D  [+0x0C15D]  C3                       ret
F000:415E  [+0x0C15E]  01 09                    add     [bx+di],cx
F000:4160  [+0x0C160]  DB DB                    fcmovnu st3
F000:4162  [+0x0C162]  DB DB                    fcmovnu st3
F000:4164  [+0x0C164]  DF DC                    fstp    st4
F000:4166  [+0x0C166]  DB DB                    fcmovnu st3
F000:4168  [+0x0C168]  B1 00                    mov     cl,0
F000:416A  [+0x0C16A]  00 01                    add     [bx+di],al
F000:416C  [+0x0C16C]  08 20                    or      [bx+si],ah
F000:416E  [+0x0C16E]  53                       push    bx
F000:416F  [+0x0C16F]  74 61                    je      short 41D2h
F000:4171  [+0x0C171]  74 75                    je      short 41E8h
F000:4173  [+0x0C173]  73 20                    jae     short 4195h
F000:4175  [+0x0C175]  00 00                    add     [bx+si],al
F000:4177  [+0x0C177]  01 07                    add     [bx],ax
F000:4179  [+0x0C179]  20 45 72                 and     [di+72h],al
F000:417C  [+0x0C17C]  72 6F                    jb      short 41EDh
F000:417E  [+0x0C17E]  72 20                    jb      short 41A0h
F000:4180  [+0x0C180]  00 00                    add     [bx+si],al
F000:4182  [+0x0C182]  01 5D 20                 add     [di+20h],bx
F000:4185  [+0x0C185]  20 20                    and     [bx+si],ah
F000:4187  [+0x0C187]  20 20                    and     [bx+si],ah
F000:4189  [+0x0C189]  20 20                    and     [bx+si],ah
F000:418B  [+0x0C18B]  20 20                    and     [bx+si],ah
F000:418D  [+0x0C18D]  20 20                    and     [bx+si],ah
F000:418F  [+0x0C18F]  20 20                    and     [bx+si],ah
F000:4191  [+0x0C191]  50                       push    ax
F000:4192  [+0x0C192]  68 6F 65                 push    656Fh
F000:4195  [+0x0C195]  6E                       outsb
F000:4196  [+0x0C196]  69 78 4D 49 53           imul    di,[bx+si+4Dh],5349h
F000:419B  [+0x0C19B]  45                       inc     bp
F000:419C  [+0x0C19C]  52                       push    dx
F000:419D  [+0x0C19D]  28 54 4D                 sub     [si+4Dh],dl
F000:41A0  [+0x0C1A0]  29 20                    sub     [bx+si],sp
F000:41A2  [+0x0C1A2]  50                       push    ax
F000:41A3  [+0x0C1A3]  54                       push    sp
F000:41A4  [+0x0C1A4]  36 38 43 32              cmp     [bp+di+32h],al
F000:41A8  [+0x0C1A8]  36 38 20                 cmp     [ss:bx+si],ah
F000:41AB  [+0x0C1AB]  20 00                    and     [bx+si],al
F000:41AD  [+0x0C1AD]  20 43 6F                 and     [bp+di+6Fh],al
F000:41B0  [+0x0C1B0]  70 79                    jo      short 422Bh
F000:41B2  [+0x0C1B2]  72 69                    jb      short 421Dh
F000:41B4  [+0x0C1B4]  67 68 74 20              push    2074h
F000:41B8  [+0x0C1B8]  28 63 29                 sub     [bp+di+29h],ah
F000:41BB  [+0x0C1BB]  20 31                    and     [bx+di],dh
F000:41BD  [+0x0C1BD]  39 39                    cmp     [bx+di],di
F000:41BF  [+0x0C1BF]  31 2C                    xor     [si],bp
F000:41C1  [+0x0C1C1]  20 31                    and     [bx+di],dh
F000:41C3  [+0x0C1C3]  39 39                    cmp     [bx+di],di
F000:41C5  [+0x0C1C5]  32 20                    xor     ah,[bx+si]
F000:41C7  [+0x0C1C7]  50                       push    ax
F000:41C8  [+0x0C1C8]  68 6F 65                 push    656Fh
F000:41CB  [+0x0C1CB]  6E                       outsb
F000:41CC  [+0x0C1CC]  69 78 20 54 65           imul    di,[bx+si+20h],6554h
F000:41D1  [+0x0C1D1]  63 68 6E                 arpl    [bx+si+6Eh],bp
F000:41D4  [+0x0C1D4]  6F                       outsw
F000:41D5  [+0x0C1D5]  6C                       insb
F000:41D6  [+0x0C1D6]  6F                       outsw
F000:41D7  [+0x0C1D7]  67 69 65 73 20 4C        imul    sp,[ebp+73h],4C20h
F000:41DD  [+0x0C1DD]  74 64                    je      short 4243h
F000:41DF  [+0x0C1DF]  2E 20 00                 and     [cs:bx+si],al
F000:41E2  [+0x0C1E2]  00 01                    add     [bx+di],al
F000:41E4  [+0x0C1E4]  B9 20 43                 mov     cx,4320h
F000:41E7  [+0x0C1E7]  6F                       outsw
F000:41E8  [+0x0C1E8]  6E                       outsb
F000:41E9  [+0x0C1E9]  76 65                    jbe     short 4250h
F000:41EB  [+0x0C1EB]  6E                       outsb
F000:41EC  [+0x0C1EC]  74 69                    je      short 4257h
F000:41EE  [+0x0C1EE]  6F                       outsw
F000:41EF  [+0x0C1EF]  6E                       outsb
F000:41F0  [+0x0C1F0]  61                       popa
F000:41F1  [+0x0C1F1]  6C                       insb
F000:41F2  [+0x0C1F2]  20 4D 65                 and     [di+65h],cl
F000:41F5  [+0x0C1F5]  6D                       insw
F000:41F6  [+0x0C1F6]  6F                       outsw
F000:41F7  [+0x0C1F7]  72 79                    jb      short 4272h
F000:41F9  [+0x0C1F9]  20 20                    and     [bx+si],ah
F000:41FB  [+0x0C1FB]  20 30                    and     [bx+si],dh
F000:41FD  [+0x0C1FD]  30 30                    xor     [bx+si],dh
F000:41FF  [+0x0C1FF]  30 30                    xor     [bx+si],dh
F000:4201  [+0x0C201]  4B                       dec     bx
F000:4202  [+0x0C202]  20 00                    and     [bx+si],al
F000:4204  [+0x0C204]  20 45 78                 and     [di+78h],al
F000:4207  [+0x0C207]  74 65                    je      short 426Eh
F000:4209  [+0x0C209]  6E                       outsb
F000:420A  [+0x0C20A]  64 65 64 20 4D 65        and     [fs:di+65h],cl
F000:4210  [+0x0C210]  6D                       insw
F000:4211  [+0x0C211]  6F                       outsw
F000:4212  [+0x0C212]  72 79                    jb      short 428Dh
F000:4214  [+0x0C214]  20 20                    and     [bx+si],ah
F000:4216  [+0x0C216]  20 20                    and     [bx+si],ah
F000:4218  [+0x0C218]  20 20                    and     [bx+si],ah
F000:421A  [+0x0C21A]  20 20                    and     [bx+si],ah
F000:421C  [+0x0C21C]  20 20                    and     [bx+si],ah
F000:421E  [+0x0C21E]  20 30                    and     [bx+si],dh
F000:4220  [+0x0C220]  4B                       dec     bx
F000:4221  [+0x0C221]  20 00                    and     [bx+si],al
F000:4223  [+0x0C223]  20 45 78                 and     [di+78h],al
F000:4226  [+0x0C226]  70 61                    jo      short 4289h
F000:4228  [+0x0C228]  6E                       outsb
F000:4229  [+0x0C229]  64 65 64 20 4D 65        and     [fs:di+65h],cl
F000:422F  [+0x0C22F]  6D                       insw
F000:4230  [+0x0C230]  6F                       outsw
F000:4231  [+0x0C231]  72 79                    jb      short 42ACh
F000:4233  [+0x0C233]  20 20                    and     [bx+si],ah
F000:4235  [+0x0C235]  20 20                    and     [bx+si],ah
F000:4237  [+0x0C237]  20 20                    and     [bx+si],ah
F000:4239  [+0x0C239]  20 20                    and     [bx+si],ah
F000:423B  [+0x0C23B]  20 20                    and     [bx+si],ah
F000:423D  [+0x0C23D]  20 30                    and     [bx+si],dh
F000:423F  [+0x0C23F]  4B                       dec     bx
F000:4240  [+0x0C240]  20 00                    and     [bx+si],al
F000:4242  [+0x0C242]  20 53 79                 and     [bp+di+79h],dl
F000:4245  [+0x0C245]  73 74                    jae     short 42BBh
F000:4247  [+0x0C247]  65 6D                    insw
F000:4249  [+0x0C249]  20 4D 65                 and     [di+65h],cl
F000:424C  [+0x0C24C]  6D                       insw
F000:424D  [+0x0C24D]  6F                       outsw
F000:424E  [+0x0C24E]  72 79                    jb      short 42C9h
F000:4250  [+0x0C250]  20 20                    and     [bx+si],ah
F000:4252  [+0x0C252]  20 20                    and     [bx+si],ah
F000:4254  [+0x0C254]  20 20                    and     [bx+si],ah
F000:4256  [+0x0C256]  20 20                    and     [bx+si],ah
F000:4258  [+0x0C258]  20 20                    and     [bx+si],ah
F000:425A  [+0x0C25A]  20 20                    and     [bx+si],ah
F000:425C  [+0x0C25C]  20 30                    and     [bx+si],dh
F000:425E  [+0x0C25E]  4B                       dec     bx
F000:425F  [+0x0C25F]  20 00                    and     [bx+si],al
F000:4261  [+0x0C261]  20 20                    and     [bx+si],ah
F000:4263  [+0x0C263]  20 20                    and     [bx+si],ah
F000:4265  [+0x0C265]  20 20                    and     [bx+si],ah
F000:4267  [+0x0C267]  20 20                    and     [bx+si],ah
F000:4269  [+0x0C269]  20 20                    and     [bx+si],ah
F000:426B  [+0x0C26B]  20 20                    and     [bx+si],ah
F000:426D  [+0x0C26D]  20 20                    and     [bx+si],ah
F000:426F  [+0x0C26F]  20 20                    and     [bx+si],ah
F000:4271  [+0x0C271]  20 20                    and     [bx+si],ah
F000:4273  [+0x0C273]  20 20                    and     [bx+si],ah
F000:4275  [+0x0C275]  20 20                    and     [bx+si],ah
F000:4277  [+0x0C277]  DB 0xC4  (bad)
F000:427B  [+0x0C27B]  DB 0xC4  (bad)
F000:427F  [+0x0C27F]  00 20                    add     [bx+si],ah
F000:4281  [+0x0C281]  54                       push    sp
F000:4282  [+0x0C282]  6F                       outsw
F000:4283  [+0x0C283]  74 61                    je      short 42E6h
F000:4285  [+0x0C285]  6C                       insb
F000:4286  [+0x0C286]  20 4D 65                 and     [di+65h],cl
F000:4289  [+0x0C289]  6D                       insw
F000:428A  [+0x0C28A]  6F                       outsw
F000:428B  [+0x0C28B]  72 79                    jb      short 4306h
F000:428D  [+0x0C28D]  20 20                    and     [bx+si],ah
F000:428F  [+0x0C28F]  20 20                    and     [bx+si],ah
F000:4291  [+0x0C291]  20 20                    and     [bx+si],ah
F000:4293  [+0x0C293]  20 20                    and     [bx+si],ah
F000:4295  [+0x0C295]  20 20                    and     [bx+si],ah
F000:4297  [+0x0C297]  20 20                    and     [bx+si],ah
F000:4299  [+0x0C299]  20 20                    and     [bx+si],ah
F000:429B  [+0x0C29B]  30 4B 20                 xor     [bp+di+20h],cl
F000:429E  [+0x0C29E]  00 00                    add     [bx+si],al
F000:42A0  [+0x0C2A0]  01 2B                    add     [bp+di],bp
F000:42A2  [+0x0C2A2]  20 53 61                 and     [bp+di+61h],dl
F000:42A5  [+0x0C2A5]  76 65                    jbe     short 430Ch
F000:42A7  [+0x0C2A7]  20 74 6F                 and     [si+6Fh],dh
F000:42AA  [+0x0C2AA]  20 64 69                 and     [si+69h],ah
F000:42AD  [+0x0C2AD]  73 6B                    jae     short 431Ah
F000:42AF  [+0x0C2AF]  20 69 6E                 and     [bx+di+6Eh],ch
F000:42B2  [+0x0C2B2]  20 70 72                 and     [bx+si+72h],dh
F000:42B5  [+0x0C2B5]  6F                       outsw
F000:42B6  [+0x0C2B6]  67 72 65                 jb      short 431Eh
F000:42B9  [+0x0C2B9]  73 73                    jae     short 432Eh
F000:42BB  [+0x0C2BB]  2E 20 20                 and     [cs:bx+si],ah
F000:42BE  [+0x0C2BE]  50                       push    ax
F000:42BF  [+0x0C2BF]  6C                       insb
F000:42C0  [+0x0C2C0]  65 61                    popa
F000:42C2  [+0x0C2C2]  73 65                    jae     short 4329h
F000:42C4  [+0x0C2C4]  20 77 61                 and     [bx+61h],dh
F000:42C7  [+0x0C2C7]  69 74 2E 2E 2E           imul    si,[si+2Eh],2E2Eh
F000:42CC  [+0x0C2CC]  20 00                    and     [bx+si],al
F000:42CE  [+0x0C2CE]  00 01                    add     [bx+di],al
F000:42D0  [+0x0C2D0]  30 20                    xor     [bx+si],ah
F000:42D2  [+0x0C2D2]  52                       push    dx
F000:42D3  [+0x0C2D3]  65 73 74                 jae     short 434Ah
F000:42D6  [+0x0C2D6]  6F                       outsw
F000:42D7  [+0x0C2D7]  72 65                    jb      short 433Eh
F000:42D9  [+0x0C2D9]  20 66 72                 and     [bp+72h],ah
F000:42DC  [+0x0C2DC]  6F                       outsw
F000:42DD  [+0x0C2DD]  6D                       insw
F000:42DE  [+0x0C2DE]  20 64 69                 and     [si+69h],ah
F000:42E1  [+0x0C2E1]  73 6B                    jae     short 434Eh
F000:42E3  [+0x0C2E3]  20 69 6E                 and     [bx+di+6Eh],ch
F000:42E6  [+0x0C2E6]  20 70 72                 and     [bx+si+72h],dh
F000:42E9  [+0x0C2E9]  6F                       outsw
F000:42EA  [+0x0C2EA]  67 72 65                 jb      short 4352h
F000:42ED  [+0x0C2ED]  73 73                    jae     short 4362h
F000:42EF  [+0x0C2EF]  2E 20 20                 and     [cs:bx+si],ah
F000:42F2  [+0x0C2F2]  50                       push    ax
F000:42F3  [+0x0C2F3]  6C                       insb
F000:42F4  [+0x0C2F4]  65 61                    popa
F000:42F6  [+0x0C2F6]  73 65                    jae     short 435Dh
F000:42F8  [+0x0C2F8]  20 77 61                 and     [bx+61h],dh
F000:42FB  [+0x0C2FB]  69 74 2E 2E 2E           imul    si,[si+2Eh],2E2Eh
F000:4300  [+0x0C300]  20 00                    and     [bx+si],al
F000:4302  [+0x0C302]  00 01                    add     [bx+di],al
F000:4304  [+0x0C304]  20 20                    and     [bx+si],ah
F000:4306  [+0x0C306]  50                       push    ax
F000:4307  [+0x0C307]  6C                       insb
F000:4308  [+0x0C308]  65 61                    popa
F000:430A  [+0x0C30A]  73 65                    jae     short 4371h
F000:430C  [+0x0C30C]  20 74 75                 and     [si+75h],dh
F000:430F  [+0x0C30F]  72 6E                    jb      short 437Fh
F000:4311  [+0x0C311]  20 6F 66                 and     [bx+66h],ch
F000:4314  [+0x0C314]  66 20 79 6F              and     [bx+di+6Fh],bh
F000:4318  [+0x0C318]  75 72                    jne     short 438Ch
F000:431A  [+0x0C31A]  20 63 6F                 and     [bp+di+6Fh],ah
F000:431D  [+0x0C31D]  6D                       insw
F000:431E  [+0x0C31E]  70 75                    jo      short 4395h
F000:4320  [+0x0C320]  74 65                    je      short 4387h
F000:4322  [+0x0C322]  72 2E                    jb      short 4352h
F000:4324  [+0x0C324]  20 00                    and     [bx+si],al
F000:4326  [+0x0C326]  00 01                    add     [bx+di],al
F000:4328  [+0x0C328]  4F                       dec     di
F000:4329  [+0x0C329]  20 45 41                 and     [di+41h],al
F000:432C  [+0x0C32C]  58                       pop     ax
F000:432D  [+0x0C32D]  00 20                    add     [bx+si],ah
F000:432F  [+0x0C32F]  45                       inc     bp
F000:4330  [+0x0C330]  42                       inc     dx
F000:4331  [+0x0C331]  58                       pop     ax
F000:4332  [+0x0C332]  00 20                    add     [bx+si],ah
F000:4334  [+0x0C334]  45                       inc     bp
F000:4335  [+0x0C335]  43                       inc     bx
F000:4336  [+0x0C336]  58                       pop     ax
F000:4337  [+0x0C337]  00 20                    add     [bx+si],ah
F000:4339  [+0x0C339]  45                       inc     bp
F000:433A  [+0x0C33A]  44                       inc     sp
F000:433B  [+0x0C33B]  58                       pop     ax
F000:433C  [+0x0C33C]  00 20                    add     [bx+si],ah
F000:433E  [+0x0C33E]  45                       inc     bp
F000:433F  [+0x0C33F]  53                       push    bx
F000:4340  [+0x0C340]  50                       push    ax
F000:4341  [+0x0C341]  00 20                    add     [bx+si],ah
F000:4343  [+0x0C343]  45                       inc     bp
F000:4344  [+0x0C344]  42                       inc     dx
F000:4345  [+0x0C345]  50                       push    ax
F000:4346  [+0x0C346]  00 20                    add     [bx+si],ah
F000:4348  [+0x0C348]  45                       inc     bp
F000:4349  [+0x0C349]  53                       push    bx
F000:434A  [+0x0C34A]  49                       dec     cx
F000:434B  [+0x0C34B]  00 20                    add     [bx+si],ah
F000:434D  [+0x0C34D]  45                       inc     bp
F000:434E  [+0x0C34E]  44                       inc     sp
F000:434F  [+0x0C34F]  49                       dec     cx
F000:4350  [+0x0C350]  00 20                    add     [bx+si],ah
F000:4352  [+0x0C352]  20 44 53                 and     [si+53h],al
F000:4355  [+0x0C355]  00 20                    add     [bx+si],ah
F000:4357  [+0x0C357]  20 45 53                 and     [di+53h],al
F000:435A  [+0x0C35A]  00 20                    add     [bx+si],ah
F000:435C  [+0x0C35C]  20 46 53                 and     [bp+53h],al
F000:435F  [+0x0C35F]  00 20                    add     [bx+si],ah
F000:4361  [+0x0C361]  20 47 53                 and     [bx+53h],al
F000:4364  [+0x0C364]  00 20                    add     [bx+si],ah
F000:4366  [+0x0C366]  20 53 53                 and     [bp+di+53h],dl
F000:4369  [+0x0C369]  00 20                    add     [bx+si],ah
F000:436B  [+0x0C36B]  20 43 53                 and     [bp+di+53h],al
F000:436E  [+0x0C36E]  00 20                    add     [bx+si],ah
F000:4370  [+0x0C370]  20 49 50                 and     [bx+di+50h],cl
F000:4373  [+0x0C373]  00 20                    add     [bx+si],ah
F000:4375  [+0x0C375]  45                       inc     bp
F000:4376  [+0x0C376]  46                       inc     si
F000:4377  [+0x0C377]  4C                       dec     sp
F000:4378  [+0x0C378]  00 00                    add     [bx+si],al
F000:437A  [+0x0C37A]  01 0D                    add     [di],cx
F000:437C  [+0x0C37C]  55                       push    bp
F000:437D  [+0x0C37D]  6E                       outsb
F000:437E  [+0x0C37E]  6B 6E 6F 77              imul    bp,[bp+6Fh],77h
F000:4382  [+0x0C382]  6E                       outsb
F000:4383  [+0x0C383]  20 65 72                 and     [di+72h],ah
F000:4386  [+0x0C386]  72 6F                    jb      short 43F7h
F000:4388  [+0x0C388]  72 00                    jb      short 438Ah
F000:438A  [+0x0C38A]  00 01                    add     [bx+di],al
F000:438C  [+0x0C38C]  20 43 6F                 and     [bp+di+6Fh],al
F000:438F  [+0x0C38F]  75 6C                    jne     short 43FDh
F000:4391  [+0x0C391]  64 6E                    fs outsb
F000:4393  [+0x0C393]  27                       daa
F000:4394  [+0x0C394]  74 20                    je      short 43B6h
F000:4396  [+0x0C396]  72 65                    jb      short 43FDh
F000:4398  [+0x0C398]  73 65                    jae     short 43FFh
F000:439A  [+0x0C39A]  74 20                    je      short 43BCh
F000:439C  [+0x0C39C]  68 61 72                 push    7261h
F000:439F  [+0x0C39F]  64 20 64 69              and     [fs:si+69h],ah
F000:43A3  [+0x0C3A3]  73 6B                    jae     short 4410h
F000:43A5  [+0x0C3A5]  20 73 79                 and     [bp+di+79h],dh
F000:43A8  [+0x0C3A8]  73 74                    jae     short 441Eh
F000:43AA  [+0x0C3AA]  65 6D                    insw
F000:43AC  [+0x0C3AC]  2E 00 00                 add     [cs:bx+si],al
F000:43AF  [+0x0C3AF]  01 23                    add     [bp+di],sp
F000:43B1  [+0x0C3B1]  46                       inc     si
F000:43B2  [+0x0C3B2]  61                       popa
F000:43B3  [+0x0C3B3]  74 61                    je      short 4416h
F000:43B5  [+0x0C3B5]  6C                       insb
F000:43B6  [+0x0C3B6]  20 65 72                 and     [di+72h],ah
F000:43B9  [+0x0C3B9]  72 6F                    jb      short 442Ah
F000:43BB  [+0x0C3BB]  72 20                    jb      short 43DDh
F000:43BD  [+0x0C3BD]  72 65                    jb      short 4424h
F000:43BF  [+0x0C3BF]  61                       popa
F000:43C0  [+0x0C3C0]  64 69 6E 67 20 66        imul    bp,[fs:bp+67h],6620h
F000:43C6  [+0x0C3C6]  72 6F                    jb      short 4437h
F000:43C8  [+0x0C3C8]  6D                       insw
F000:43C9  [+0x0C3C9]  20 68 61                 and     [bx+si+61h],ch
F000:43CC  [+0x0C3CC]  72 64                    jb      short 4432h
F000:43CE  [+0x0C3CE]  20 64 69                 and     [si+69h],ah
F000:43D1  [+0x0C3D1]  73 6B                    jae     short 443Eh
F000:43D3  [+0x0C3D3]  2E 00 00                 add     [cs:bx+si],al
F000:43D6  [+0x0C3D6]  01 21                    add     [bx+di],sp
F000:43D8  [+0x0C3D8]  46                       inc     si
F000:43D9  [+0x0C3D9]  61                       popa
F000:43DA  [+0x0C3DA]  74 61                    je      short 443Dh
F000:43DC  [+0x0C3DC]  6C                       insb
F000:43DD  [+0x0C3DD]  20 65 72                 and     [di+72h],ah
F000:43E0  [+0x0C3E0]  72 6F                    jb      short 4451h
F000:43E2  [+0x0C3E2]  72 20                    jb      short 4404h
F000:43E4  [+0x0C3E4]  77 72                    ja      short 4458h
F000:43E6  [+0x0C3E6]  69 74 69 6E 67           imul    si,[si+69h],676Eh
F000:43EB  [+0x0C3EB]  20 74 6F                 and     [si+6Fh],dh
F000:43EE  [+0x0C3EE]  20 68 61                 and     [bx+si+61h],ch
F000:43F1  [+0x0C3F1]  72 64                    jb      short 4457h
F000:43F3  [+0x0C3F3]  20 64 69                 and     [si+69h],ah
F000:43F6  [+0x0C3F6]  73 6B                    jae     short 4463h
F000:43F8  [+0x0C3F8]  2E 00 00                 add     [cs:bx+si],al
F000:43FB  [+0x0C3FB]  01 2B                    add     [bp+di],bp
F000:43FD  [+0x0C3FD]  50                       push    ax
F000:43FE  [+0x0C3FE]  61                       popa
F000:43FF  [+0x0C3FF]  72 74                    jb      short 4475h
F000:4401  [+0x0C401]  69 74 69 6F 6E           imul    si,[si+69h],6E6Fh
F000:4406  [+0x0C406]  20 74 61                 and     [si+61h],dh
F000:4409  [+0x0C409]  62 6C 65                 bound   bp,[si+65h]
F000:440C  [+0x0C40C]  20 63 6F                 and     [bp+di+6Fh],ah
F000:440F  [+0x0C40F]  72 72                    jb      short 4483h
F000:4411  [+0x0C411]  75 70                    jne     short 4483h
F000:4413  [+0x0C413]  74 65                    je      short 447Ah
F000:4415  [+0x0C415]  64 20 6F 72              and     [fs:bx+72h],ch
F000:4419  [+0x0C419]  20 64 6F                 and     [si+6Fh],ah
F000:441C  [+0x0C41C]  65 73 6E                 jae     short 448Dh
F000:441F  [+0x0C41F]  27                       daa
F000:4420  [+0x0C420]  74 20                    je      short 4442h
F000:4422  [+0x0C422]  65 78 69                 js      short 448Eh
F000:4425  [+0x0C425]  73 74                    jae     short 449Bh
F000:4427  [+0x0C427]  2E 00 00                 add     [cs:bx+si],al
F000:442A  [+0x0C42A]  01 29                    add     [bx+di],bp
F000:442C  [+0x0C42C]  50                       push    ax
F000:442D  [+0x0C42D]  68 6F 65                 push    656Fh
F000:4430  [+0x0C430]  6E                       outsb
F000:4431  [+0x0C431]  69 78 4D 49 53           imul    di,[bx+si+4Dh],5349h
F000:4436  [+0x0C436]  45                       inc     bp
F000:4437  [+0x0C437]  52                       push    dx
F000:4438  [+0x0C438]  28 54 4D                 sub     [si+4Dh],dl
F000:443B  [+0x0C43B]  29 20                    sub     [bx+si],sp
F000:443D  [+0x0C43D]  70 61                    jo      short 44A0h
F000:443F  [+0x0C43F]  72 74                    jb      short 44B5h
F000:4441  [+0x0C441]  69 74 69 6F 6E           imul    si,[si+69h],6E6Fh
F000:4446  [+0x0C446]  20 64 6F                 and     [si+6Fh],ah
F000:4449  [+0x0C449]  65 73 6E                 jae     short 44BAh
F000:444C  [+0x0C44C]  27                       daa
F000:444D  [+0x0C44D]  74 20                    je      short 446Fh
F000:444F  [+0x0C44F]  65 78 69                 js      short 44BBh
F000:4452  [+0x0C452]  73 74                    jae     short 44C8h
F000:4454  [+0x0C454]  2E 00 00                 add     [cs:bx+si],al
F000:4457  [+0x0C457]  01 1D                    add     [di],bx
F000:4459  [+0x0C459]  47                       inc     di
F000:445A  [+0x0C45A]  6F                       outsw
F000:445B  [+0x0C45B]  6F                       outsw
F000:445C  [+0x0C45C]  64 20 73 70              and     [fs:bp+di+70h],dh
F000:4460  [+0x0C460]  61                       popa
F000:4461  [+0x0C461]  63 65 20                 arpl    [di+20h],sp
F000:4464  [+0x0C464]  6D                       insw
F000:4465  [+0x0C465]  61                       popa
F000:4466  [+0x0C466]  70 20                    jo      short 4488h
F000:4468  [+0x0C468]  64 6F                    fs outsw
F000:446A  [+0x0C46A]  65 73 6E                 jae     short 44DBh
F000:446D  [+0x0C46D]  27                       daa
F000:446E  [+0x0C46E]  74 20                    je      short 4490h
F000:4470  [+0x0C470]  65 78 69                 js      short 44DCh
F000:4473  [+0x0C473]  73 74                    jae     short 44E9h
F000:4475  [+0x0C475]  2E 00 00                 add     [cs:bx+si],al
F000:4478  [+0x0C478]  01 19                    add     [bx+di],bx
F000:447A  [+0x0C47A]  47                       inc     di
F000:447B  [+0x0C47B]  6F                       outsw
F000:447C  [+0x0C47C]  6F                       outsw
F000:447D  [+0x0C47D]  64 20 73 70              and     [fs:bp+di+70h],dh
F000:4481  [+0x0C481]  61                       popa
F000:4482  [+0x0C482]  63 65 20                 arpl    [di+20h],sp
F000:4485  [+0x0C485]  6D                       insw
F000:4486  [+0x0C486]  61                       popa
F000:4487  [+0x0C487]  70 20                    jo      short 44A9h
F000:4489  [+0x0C489]  63 6F 72                 arpl    [bx+72h],bp
F000:448C  [+0x0C48C]  72 75                    jb      short 4503h
F000:448E  [+0x0C48E]  70 74                    jo      short 4504h
F000:4490  [+0x0C490]  65 64 2E 00 00           add     [cs:bx+si],al
F000:4495  [+0x0C495]  01 28                    add     [bx+si],bp
F000:4497  [+0x0C497]  49                       dec     cx
F000:4498  [+0x0C498]  6E                       outsb
F000:4499  [+0x0C499]  74 65                    je      short 4500h
F000:449B  [+0x0C49B]  72 6E                    jb      short 450Bh
F000:449D  [+0x0C49D]  61                       popa
F000:449E  [+0x0C49E]  6C                       insb
F000:449F  [+0x0C49F]  20 65 72                 and     [di+72h],ah
F000:44A2  [+0x0C4A2]  72 6F                    jb      short 4513h
F000:44A4  [+0x0C4A4]  72 3A                    jb      short 44E0h
F000:44A6  [+0x0C4A6]  20 52 65                 and     [bp+si+65h],dl
F000:44A9  [+0x0C4A9]  61                       popa
F000:44AA  [+0x0C4AA]  64 20 70 61              and     [fs:bx+si+61h],dh
F000:44AE  [+0x0C4AE]  73 74                    jae     short 4524h
F000:44B0  [+0x0C4B0]  20 70 61                 and     [bx+si+61h],dh
F000:44B3  [+0x0C4B3]  72 74                    jb      short 4529h
F000:44B5  [+0x0C4B5]  69 74 69 6F 6E           imul    si,[si+69h],6E6Fh
F000:44BA  [+0x0C4BA]  20 65 6E                 and     [di+6Eh],ah
F000:44BD  [+0x0C4BD]  64 2E 00 00              add     [cs:bx+si],al
F000:44C1  [+0x0C4C1]  01 17                    add     [bx],dx
F000:44C3  [+0x0C4C3]  4F                       dec     di
F000:44C4  [+0x0C4C4]  75 74                    jne     short 453Ah
F000:44C6  [+0x0C4C6]  20 6F 66                 and     [bx+66h],ch
F000:44C9  [+0x0C4C9]  20 68 61                 and     [bx+si+61h],ch
F000:44CC  [+0x0C4CC]  72 64                    jb      short 4532h
F000:44CE  [+0x0C4CE]  20 64 69                 and     [si+69h],ah
F000:44D1  [+0x0C4D1]  73 6B                    jae     short 453Eh
F000:44D3  [+0x0C4D3]  20 73 70                 and     [bp+di+70h],dh
F000:44D6  [+0x0C4D6]  61                       popa
F000:44D7  [+0x0C4D7]  63 65 2E                 arpl    [di+2Eh],sp
F000:44DA  [+0x0C4DA]  00 00                    add     [bx+si],al
F000:44DC  [+0x0C4DC]  01 2F                    add     [bx],bp
F000:44DE  [+0x0C4DE]  20 00                    and     [bx+si],al
F000:44E0  [+0x0C4E0]  20 20                    and     [bx+si],ah
F000:44E2  [+0x0C4E2]  50                       push    ax
F000:44E3  [+0x0C4E3]  6C                       insb
F000:44E4  [+0x0C4E4]  65 61                    popa
F000:44E6  [+0x0C4E6]  73 65                    jae     short 454Dh
F000:44E8  [+0x0C4E8]  20 70 6F                 and     [bx+si+6Fh],dh
F000:44EB  [+0x0C4EB]  77 65                    ja      short 4552h
F000:44ED  [+0x0C4ED]  72 2D                    jb      short 451Ch
F000:44EF  [+0x0C4EF]  6F                       outsw
F000:44F0  [+0x0C4F0]  66 66 20 61 6E           and     [bx+di+6Eh],ah
F000:44F5  [+0x0C4F5]  64 20 63 6F              and     [fs:bp+di+6Fh],ah
F000:44F9  [+0x0C4F9]  72 72                    jb      short 456Dh
F000:44FB  [+0x0C4FB]  65 63 74 20              arpl    [gs:si+20h],si
F000:44FF  [+0x0C4FF]  74 68                    je      short 4569h
F000:4501  [+0x0C501]  65 20 70 72              and     [gs:bx+si+72h],dh
F000:4505  [+0x0C505]  6F                       outsw
F000:4506  [+0x0C506]  62 6C 65                 bound   bp,[si+65h]
F000:4509  [+0x0C509]  6D                       insw
F000:450A  [+0x0C50A]  2E 20 20                 and     [cs:bx+si],ah
F000:450D  [+0x0C50D]  00 00                    add     [bx+si],al
F000:450F  [+0x0C50F]  01 CB                    add     bx,cx
F000:4511  [+0x0C511]  20 00                    and     [bx+si],al
F000:4513  [+0x0C513]  20 00                    and     [bx+si],al
F000:4515  [+0x0C515]  20 54 68                 and     [si+68h],dl
F000:4518  [+0x0C518]  69 73 20 70 72           imul    si,[bp+di+20h],7270h
F000:451D  [+0x0C51D]  6F                       outsw
F000:451E  [+0x0C51E]  62 6C 65                 bound   bp,[si+65h]
F000:4521  [+0x0C521]  6D                       insw
F000:4522  [+0x0C522]  20 72 65                 and     [bp+si+65h],dh
F000:4525  [+0x0C525]  71 75                    jno     short 459Ch
F000:4527  [+0x0C527]  69 72 65 73 20           imul    si,[bp+si+65h],2073h
F000:452C  [+0x0C52C]  50                       push    ax
F000:452D  [+0x0C52D]  68 6F 65                 push    656Fh
F000:4530  [+0x0C530]  6E                       outsb
F000:4531  [+0x0C531]  69 78 4D 49 53           imul    di,[bx+si+4Dh],5349h
F000:4536  [+0x0C536]  45                       inc     bp
F000:4537  [+0x0C537]  52                       push    dx
F000:4538  [+0x0C538]  28 54 4D                 sub     [si+4Dh],dl
F000:453B  [+0x0C53B]  29 20                    sub     [bx+si],sp
F000:453D  [+0x0C53D]  74 6F                    je      short 45AEh
F000:453F  [+0x0C53F]  20 64 69                 and     [si+69h],ah
F000:4542  [+0x0C542]  73 61                    jae     short 45A5h
F000:4544  [+0x0C544]  62 6C 65                 bound   bp,[si+65h]
F000:4547  [+0x0C547]  20 73 61                 and     [bp+di+61h],dh
F000:454A  [+0x0C54A]  76 65                    jbe     short 45B1h
F000:454C  [+0x0C54C]  20 74 6F                 and     [si+6Fh],dh
F000:454F  [+0x0C54F]  20 64 69                 and     [si+69h],ah
F000:4552  [+0x0C552]  73 6B                    jae     short 45BFh
F000:4554  [+0x0C554]  2E 00 20                 add     [cs:bx+si],ah
F000:4557  [+0x0C557]  43                       inc     bx
F000:4558  [+0x0C558]  6F                       outsw
F000:4559  [+0x0C559]  72 72                    jb      short 45CDh
F000:455B  [+0x0C55B]  65 63 74 69              arpl    [gs:si+69h],si
F000:455F  [+0x0C55F]  6E                       outsb
F000:4560  [+0x0C560]  67 20 74 68 69           and     [eax+ebp*2+69h],dh
F000:4565  [+0x0C565]  73 20                    jae     short 4587h
F000:4567  [+0x0C567]  70 72                    jo      short 45DBh
F000:4569  [+0x0C569]  6F                       outsw
F000:456A  [+0x0C56A]  62 6C 65                 bound   bp,[si+65h]
F000:456D  [+0x0C56D]  6D                       insw
F000:456E  [+0x0C56E]  20 28                    and     [bx+si],ch
F000:4570  [+0x0C570]  72 75                    jb      short 45E7h
F000:4572  [+0x0C572]  6E                       outsb
F000:4573  [+0x0C573]  6E                       outsb
F000:4574  [+0x0C574]  69 6E 67 20 50           imul    bp,[bp+67h],5020h
F000:4579  [+0x0C579]  48                       dec     ax
F000:457A  [+0x0C57A]  44                       inc     sp
F000:457B  [+0x0C57B]  49                       dec     cx
F000:457C  [+0x0C57C]  53                       push    bx
F000:457D  [+0x0C57D]  4B                       dec     bx
F000:457E  [+0x0C57E]  20 69 66                 and     [bx+di+66h],ch
F000:4581  [+0x0C581]  20 6E 65                 and     [bp+65h],ch
F000:4584  [+0x0C584]  63 65 73                 arpl    [di+73h],sp
F000:4587  [+0x0C587]  73 61                    jae     short 45EAh
F000:4589  [+0x0C589]  72 79                    jb      short 4604h
F000:458B  [+0x0C58B]  29 20                    sub     [bx+si],sp
F000:458D  [+0x0C58D]  6F                       outsw
F000:458E  [+0x0C58E]  72 20                    jb      short 45B0h
F000:4590  [+0x0C590]  64 69 73 61 62 6C        imul    si,[fs:bp+di+61h],6C62h
F000:4596  [+0x0C596]  69 6E 67 20 00           imul    bp,[bp+67h],20h
F000:459B  [+0x0C59B]  20 74 68                 and     [si+68h],dh
F000:459E  [+0x0C59E]  69 73 20 66 65           imul    si,[bp+di+20h],6566h
F000:45A3  [+0x0C5A3]  61                       popa
F000:45A4  [+0x0C5A4]  74 75                    je      short 461Bh
F000:45A6  [+0x0C5A6]  72 65                    jb      short 460Dh
F000:45A8  [+0x0C5A8]  20 69 6E                 and     [bx+di+6Eh],ch
F000:45AB  [+0x0C5AB]  20 53 45                 and     [bp+di+45h],dl
F000:45AE  [+0x0C5AE]  54                       push    sp
F000:45AF  [+0x0C5AF]  55                       push    bp
F000:45B0  [+0x0C5B0]  50                       push    ax
F000:45B1  [+0x0C5B1]  20 77 69                 and     [bx+69h],dh
F000:45B4  [+0x0C5B4]  6C                       insb
F000:45B5  [+0x0C5B5]  6C                       insb
F000:45B6  [+0x0C5B6]  20 70 72                 and     [bx+si+72h],dh
F000:45B9  [+0x0C5B9]  65 76 65                 jbe     short 4621h
F000:45BC  [+0x0C5BC]  6E                       outsb
F000:45BD  [+0x0C5BD]  74 20                    je      short 45DFh
F000:45BF  [+0x0C5BF]  74 68                    je      short 4629h
F000:45C1  [+0x0C5C1]  69 73 20 6D 65           imul    si,[bp+di+20h],656Dh
F000:45C6  [+0x0C5C6]  73 73                    jae     short 463Bh
F000:45C8  [+0x0C5C8]  61                       popa
F000:45C9  [+0x0C5C9]  67 65 20 66 72           and     [gs:esi+72h],ah
F000:45CE  [+0x0C5CE]  6F                       outsw
F000:45CF  [+0x0C5CF]  6D                       insw
F000:45D0  [+0x0C5D0]  20 72 65                 and     [bp+si+65h],dh
F000:45D3  [+0x0C5D3]  6F                       outsw
F000:45D4  [+0x0C5D4]  63 63 75                 arpl    [bp+di+75h],sp
F000:45D7  [+0x0C5D7]  72 69                    jb      short 4642h
F000:45D9  [+0x0C5D9]  6E                       outsb
F000:45DA  [+0x0C5DA]  67 2E 00 00              add     [cs:eax],al
F000:45DE  [+0x0C5DE]  51                       push    cx
F000:45DF  [+0x0C5DF]  56                       push    si
F000:45E0  [+0x0C5E0]  57                       push    di
F000:45E1  [+0x0C5E1]  FC                       cld
F000:45E2  [+0x0C5E2]  D1 E9                    shr     cx,1
F000:45E4  [+0x0C5E4]  F3 A5                    rep movsw
F000:45E6  [+0x0C5E6]  D1 E1                    shl     cx,1
F000:45E8  [+0x0C5E8]  F3 A4                    rep movsb
F000:45EA  [+0x0C5EA]  5F                       pop     di
F000:45EB  [+0x0C5EB]  5E                       pop     si
F000:45EC  [+0x0C5EC]  59                       pop     cx
F000:45ED  [+0x0C5ED]  C3                       ret
F000:45EE  [+0x0C5EE]  5F                       pop     di
F000:45EF  [+0x0C5EF]  55                       push    bp
F000:45F0  [+0x0C5F0]  8B EC                    mov     bp,sp
F000:45F2  [+0x0C5F2]  40                       inc     ax
F000:45F3  [+0x0C5F3]  24 FE                    and     al,0FEh
F000:45F5  [+0x0C5F5]  2B E0                    sub     sp,ax
F000:45F7  [+0x0C5F7]  57                       push    di
F000:45F8  [+0x0C5F8]  16                       push    ss
F000:45F9  [+0x0C5F9]  07                       pop     es
F000:45FA  [+0x0C5FA]  8B FC                    mov     di,sp
F000:45FC  [+0x0C5FC]  47                       inc     di
F000:45FD  [+0x0C5FD]  47                       inc     di
F000:45FE  [+0x0C5FE]  C3                       ret
F000:45FF  [+0x0C5FF]  FC                       cld
F000:4600  [+0x0C600]  50                       push    ax
F000:4601  [+0x0C601]  57                       push    di
F000:4602  [+0x0C602]  33 C0                    xor     ax,ax
F000:4604  [+0x0C604]  B9 FF FF                 mov     cx,0FFFFh
F000:4607  [+0x0C607]  F2 AE                    repne scasb
F000:4609  [+0x0C609]  F7 D1                    not     cx
F000:460B  [+0x0C60B]  49                       dec     cx
F000:460C  [+0x0C60C]  5F                       pop     di
F000:460D  [+0x0C60D]  58                       pop     ax
F000:460E  [+0x0C60E]  C3                       ret
F000:460F  [+0x0C60F]  50                       push    ax
F000:4610  [+0x0C610]  57                       push    di
F000:4611  [+0x0C611]  33 C0                    xor     ax,ax
F000:4613  [+0x0C613]  33 DB                    xor     bx,bx
F000:4615  [+0x0C615]  E8 E7 FF                 call    45FFh
F000:4618  [+0x0C618]  E3 0C                    jcxz    4626h
F000:461A  [+0x0C61A]  40                       inc     ax
F000:461B  [+0x0C61B]  03 F9                    add     di,cx
F000:461D  [+0x0C61D]  47                       inc     di
F000:461E  [+0x0C61E]  3B CB                    cmp     cx,bx
F000:4620  [+0x0C620]  76 F3                    jbe     short 4615h
F000:4622  [+0x0C622]  8B D9                    mov     bx,cx
F000:4624  [+0x0C624]  EB EF                    jmp     short 4615h
F000:4626  [+0x0C626]  8B C8                    mov     cx,ax
F000:4628  [+0x0C628]  5F                       pop     di
F000:4629  [+0x0C629]  58                       pop     ax
F000:462A  [+0x0C62A]  C3                       ret
F000:462B  [+0x0C62B]  FC                       cld
F000:462C  [+0x0C62C]  57                       push    di
F000:462D  [+0x0C62D]  33 C9                    xor     cx,cx
F000:462F  [+0x0C62F]  26 80 3D 00              cmp     byte [es:di],0
F000:4633  [+0x0C633]  74 06                    je      short 463Bh
F000:4635  [+0x0C635]  AE                       scasb
F000:4636  [+0x0C636]  74 05                    je      short 463Dh
F000:4638  [+0x0C638]  41                       inc     cx
F000:4639  [+0x0C639]  EB F4                    jmp     short 462Fh
F000:463B  [+0x0C63B]  0B E4                    or      sp,sp
F000:463D  [+0x0C63D]  5F                       pop     di
F000:463E  [+0x0C63E]  C3                       ret
F000:463F  [+0x0C63F]  50                       push    ax
F000:4640  [+0x0C640]  57                       push    di
F000:4641  [+0x0C641]  FC                       cld
F000:4642  [+0x0C642]  8A E0                    mov     ah,al
F000:4644  [+0x0C644]  C0 E8 04                 shr     al,4
F000:4647  [+0x0C647]  04 90                    add     al,90h
F000:4649  [+0x0C649]  27                       daa
F000:464A  [+0x0C64A]  14 40                    adc     al,40h
F000:464C  [+0x0C64C]  27                       daa
F000:464D  [+0x0C64D]  AA                       stosb
F000:464E  [+0x0C64E]  8A C4                    mov     al,ah
F000:4650  [+0x0C650]  24 0F                    and     al,0Fh
F000:4652  [+0x0C652]  04 90                    add     al,90h
F000:4654  [+0x0C654]  27                       daa
F000:4655  [+0x0C655]  14 40                    adc     al,40h
F000:4657  [+0x0C657]  27                       daa
F000:4658  [+0x0C658]  AA                       stosb
F000:4659  [+0x0C659]  32 C0                    xor     al,al
F000:465B  [+0x0C65B]  AA                       stosb
F000:465C  [+0x0C65C]  5F                       pop     di
F000:465D  [+0x0C65D]  58                       pop     ax
F000:465E  [+0x0C65E]  C3                       ret
F000:465F  [+0x0C65F]  57                       push    di
F000:4660  [+0x0C660]  86 E0                    xchg    ah,al
F000:4662  [+0x0C662]  E8 DA FF                 call    463Fh
F000:4665  [+0x0C665]  47                       inc     di
F000:4666  [+0x0C666]  47                       inc     di
F000:4667  [+0x0C667]  86 E0                    xchg    ah,al
F000:4669  [+0x0C669]  E8 D3 FF                 call    463Fh
F000:466C  [+0x0C66C]  5F                       pop     di
F000:466D  [+0x0C66D]  C3                       ret
F000:466E  [+0x0C66E]  57                       push    di
F000:466F  [+0x0C66F]  66 C1 C8 10              ror     eax,10h
F000:4673  [+0x0C673]  E8 E9 FF                 call    465Fh
F000:4676  [+0x0C676]  83 C7 04                 add     di,4
F000:4679  [+0x0C679]  66 C1 C8 10              ror     eax,10h
F000:467D  [+0x0C67D]  E8 DF FF                 call    465Fh
F000:4680  [+0x0C680]  5F                       pop     di
F000:4681  [+0x0C681]  C3                       ret
F000:4682  [+0x0C682]  50                       push    ax
F000:4683  [+0x0C683]  51                       push    cx
F000:4684  [+0x0C684]  57                       push    di
F000:4685  [+0x0C685]  FC                       cld
F000:4686  [+0x0C686]  B9 02 00                 mov     cx,2
F000:4689  [+0x0C689]  86 E0                    xchg    ah,al
F000:468B  [+0x0C68B]  F3 AA                    rep stosb
F000:468D  [+0x0C68D]  4F                       dec     di
F000:468E  [+0x0C68E]  4F                       dec     di
F000:468F  [+0x0C68F]  0A C0                    or      al,al
F000:4691  [+0x0C691]  74 0C                    je      short 469Fh
F000:4693  [+0x0C693]  80 FC 64                 cmp     ah,64h
F000:4696  [+0x0C696]  73 07                    jae     short 469Fh
F000:4698  [+0x0C698]  47                       inc     di
F000:4699  [+0x0C699]  80 FC 0A                 cmp     ah,0Ah
F000:469C  [+0x0C69C]  73 01                    jae     short 469Fh
F000:469E  [+0x0C69E]  47                       inc     di
F000:469F  [+0x0C69F]  8A C4                    mov     al,ah
F000:46A1  [+0x0C6A1]  41                       inc     cx
F000:46A2  [+0x0C6A2]  D4 0A                    aam
F000:46A4  [+0x0C6A4]  04 30                    add     al,30h
F000:46A6  [+0x0C6A6]  50                       push    ax
F000:46A7  [+0x0C6A7]  0A E4                    or      ah,ah
F000:46A9  [+0x0C6A9]  75 F4                    jne     short 469Fh
F000:46AB  [+0x0C6AB]  58                       pop     ax
F000:46AC  [+0x0C6AC]  AA                       stosb
F000:46AD  [+0x0C6AD]  E2 FC                    loop    46ABh
F000:46AF  [+0x0C6AF]  26 88 0D                 mov     [es:di],cl
F000:46B2  [+0x0C6B2]  5F                       pop     di
F000:46B3  [+0x0C6B3]  59                       pop     cx
F000:46B4  [+0x0C6B4]  58                       pop     ax
F000:46B5  [+0x0C6B5]  C3                       ret
F000:46B6  [+0x0C6B6]  50                       push    ax
F000:46B7  [+0x0C6B7]  53                       push    bx
F000:46B8  [+0x0C6B8]  51                       push    cx
F000:46B9  [+0x0C6B9]  52                       push    dx
F000:46BA  [+0x0C6BA]  57                       push    di
F000:46BB  [+0x0C6BB]  FC                       cld
F000:46BC  [+0x0C6BC]  B9 04 00                 mov     cx,4
F000:46BF  [+0x0C6BF]  93                       xchg    bx,ax
F000:46C0  [+0x0C6C0]  57                       push    di
F000:46C1  [+0x0C6C1]  F3 AA                    rep stosb
F000:46C3  [+0x0C6C3]  5F                       pop     di
F000:46C4  [+0x0C6C4]  93                       xchg    bx,ax
F000:46C5  [+0x0C6C5]  0A DB                    or      bl,bl
F000:46C7  [+0x0C6C7]  BB 0A 00                 mov     bx,0Ah
F000:46CA  [+0x0C6CA]  74 17                    je      short 46E3h
F000:46CC  [+0x0C6CC]  3D 10 27                 cmp     ax,2710h
F000:46CF  [+0x0C6CF]  73 12                    jae     short 46E3h
F000:46D1  [+0x0C6D1]  47                       inc     di
F000:46D2  [+0x0C6D2]  3D E8 03                 cmp     ax,3E8h
F000:46D5  [+0x0C6D5]  73 0C                    jae     short 46E3h
F000:46D7  [+0x0C6D7]  47                       inc     di
F000:46D8  [+0x0C6D8]  3D 64 00                 cmp     ax,64h
F000:46DB  [+0x0C6DB]  73 06                    jae     short 46E3h
F000:46DD  [+0x0C6DD]  47                       inc     di
F000:46DE  [+0x0C6DE]  3B C3                    cmp     ax,bx
F000:46E0  [+0x0C6E0]  73 01                    jae     short 46E3h
F000:46E2  [+0x0C6E2]  47                       inc     di
F000:46E3  [+0x0C6E3]  33 D2                    xor     dx,dx
F000:46E5  [+0x0C6E5]  41                       inc     cx
F000:46E6  [+0x0C6E6]  F7 F3                    div     bx
F000:46E8  [+0x0C6E8]  80 C2 30                 add     dl,30h
F000:46EB  [+0x0C6EB]  52                       push    dx
F000:46EC  [+0x0C6EC]  0B C0                    or      ax,ax
F000:46EE  [+0x0C6EE]  75 F3                    jne     short 46E3h
F000:46F0  [+0x0C6F0]  58                       pop     ax
F000:46F1  [+0x0C6F1]  AA                       stosb
F000:46F2  [+0x0C6F2]  E2 FC                    loop    46F0h
F000:46F4  [+0x0C6F4]  26 88 0D                 mov     [es:di],cl
F000:46F7  [+0x0C6F7]  5F                       pop     di
F000:46F8  [+0x0C6F8]  5A                       pop     dx
F000:46F9  [+0x0C6F9]  59                       pop     cx
F000:46FA  [+0x0C6FA]  5B                       pop     bx
F000:46FB  [+0x0C6FB]  58                       pop     ax
F000:46FC  [+0x0C6FC]  C3                       ret
F000:46FD  [+0x0C6FD]  B8 01 00                 mov     ax,1
F000:4700  [+0x0C700]  C3                       ret
F000:4701  [+0x0C701]  B8 01 00                 mov     ax,1
F000:4704  [+0x0C704]  C3                       ret
F000:4705  [+0x0C705]  50                       push    ax
F000:4706  [+0x0C706]  53                       push    bx
F000:4707  [+0x0C707]  51                       push    cx
F000:4708  [+0x0C708]  8B CF                    mov     cx,di
F000:470A  [+0x0C70A]  E8 F0 FF                 call    46FDh
F000:470D  [+0x0C70D]  B7 00                    mov     bh,0
F000:470F  [+0x0C70F]  26 38 3D                 cmp     [es:di],bh
F000:4712  [+0x0C712]  74 0E                    je      short 4722h
F000:4714  [+0x0C714]  26 38 05                 cmp     [es:di],al
F000:4717  [+0x0C717]  74 23                    je      short 473Ch
F000:4719  [+0x0C719]  26 8A 5D 01              mov     bl,[es:di+1]
F000:471D  [+0x0C71D]  8D 79 03                 lea     di,[bx+di+3]
F000:4720  [+0x0C720]  EB ED                    jmp     short 470Fh
F000:4722  [+0x0C722]  E8 DC FF                 call    4701h
F000:4725  [+0x0C725]  8B F9                    mov     di,cx
F000:4727  [+0x0C727]  26 38 3D                 cmp     [es:di],bh
F000:472A  [+0x0C72A]  F9                       stc
F000:472B  [+0x0C72B]  74 11                    je      short 473Eh
F000:472D  [+0x0C72D]  26 38 05                 cmp     [es:di],al
F000:4730  [+0x0C730]  F9                       stc
F000:4731  [+0x0C731]  74 09                    je      short 473Ch
F000:4733  [+0x0C733]  26 8A 5D 01              mov     bl,[es:di+1]
F000:4737  [+0x0C737]  8D 79 03                 lea     di,[bx+di+3]
F000:473A  [+0x0C73A]  EB EB                    jmp     short 4727h
F000:473C  [+0x0C73C]  47                       inc     di
F000:473D  [+0x0C73D]  47                       inc     di
F000:473E  [+0x0C73E]  59                       pop     cx
F000:473F  [+0x0C73F]  5B                       pop     bx
F000:4740  [+0x0C740]  58                       pop     ax
F000:4741  [+0x0C741]  C3                       ret
F000:4742  [+0x0C742]  60                       pusha
F000:4743  [+0x0C743]  1E                       push    ds
F000:4744  [+0x0C744]  06                       push    es
F000:4745  [+0x0C745]  B8 04 4F                 mov     ax,4F04h
F000:4748  [+0x0C748]  B2 01                    mov     dl,1
F000:474A  [+0x0C74A]  B9 0F 00                 mov     cx,0Fh
F000:474D  [+0x0C74D]  8C DB                    mov     bx,ds
F000:474F  [+0x0C74F]  8E C3                    mov     es,bx
F000:4751  [+0x0C751]  BB 09 06                 mov     bx,609h
F000:4754  [+0x0C754]  E8 A4 00                 call    47FBh
F000:4757  [+0x0C757]  3D 4F 00                 cmp     ax,4Fh
F000:475A  [+0x0C75A]  0F 84 0C 00              je      near 476Ah
F000:475E  [+0x0C75E]  B8 01 1C                 mov     ax,1C01h
F000:4761  [+0x0C761]  B9 07 00                 mov     cx,7
F000:4764  [+0x0C764]  BB 09 06                 mov     bx,609h
F000:4767  [+0x0C767]  E8 91 00                 call    47FBh
F000:476A  [+0x0C76A]  07                       pop     es
F000:476B  [+0x0C76B]  1F                       pop     ds
F000:476C  [+0x0C76C]  61                       popa
F000:476D  [+0x0C76D]  C3                       ret
F000:476E  [+0x0C76E]  60                       pusha
F000:476F  [+0x0C76F]  1E                       push    ds
F000:4770  [+0x0C770]  06                       push    es
F000:4771  [+0x0C771]  B8 04 4F                 mov     ax,4F04h
F000:4774  [+0x0C774]  B2 02                    mov     dl,2
F000:4776  [+0x0C776]  B9 0F 00                 mov     cx,0Fh
F000:4779  [+0x0C779]  8C DB                    mov     bx,ds
F000:477B  [+0x0C77B]  8E C3                    mov     es,bx
F000:477D  [+0x0C77D]  BB 09 06                 mov     bx,609h
F000:4780  [+0x0C780]  E8 78 00                 call    47FBh
F000:4783  [+0x0C783]  3D 4F 00                 cmp     ax,4Fh
F000:4786  [+0x0C786]  0F 84 0C 00              je      near 4796h
F000:478A  [+0x0C78A]  B8 02 1C                 mov     ax,1C02h
F000:478D  [+0x0C78D]  B9 07 00                 mov     cx,7
F000:4790  [+0x0C790]  BB 09 06                 mov     bx,609h
F000:4793  [+0x0C793]  E8 65 00                 call    47FBh
F000:4796  [+0x0C796]  07                       pop     es
F000:4797  [+0x0C797]  1F                       pop     ds
F000:4798  [+0x0C798]  61                       popa
F000:4799  [+0x0C799]  C3                       ret
F000:479A  [+0x0C79A]  50                       push    ax
F000:479B  [+0x0C79B]  51                       push    cx
F000:479C  [+0x0C79C]  52                       push    dx
F000:479D  [+0x0C79D]  57                       push    di
F000:479E  [+0x0C79E]  06                       push    es
F000:479F  [+0x0C79F]  B8 90 00                 mov     ax,90h
F000:47A2  [+0x0C7A2]  E8 56 00                 call    47FBh
F000:47A5  [+0x0C7A5]  BA DA 03                 mov     dx,3DAh
F000:47A8  [+0x0C7A8]  EC                       in      al,dx
F000:47A9  [+0x0C7A9]  B2 C0                    mov     dl,0C0h
F000:47AB  [+0x0C7AB]  B0 00                    mov     al,0
F000:47AD  [+0x0C7AD]  EE                       out     dx,al
F000:47AE  [+0x0C7AE]  B8 00 A0                 mov     ax,0A000h
F000:47B1  [+0x0C7B1]  8E C0                    mov     es,ax
F000:47B3  [+0x0C7B3]  33 FF                    xor     di,di
F000:47B5  [+0x0C7B5]  B1 80                    mov     cl,80h
F000:47B7  [+0x0C7B7]  B2 CE                    mov     dl,0CEh
F000:47B9  [+0x0C7B9]  B8 04 03                 mov     ax,304h
F000:47BC  [+0x0C7BC]  EF                       out     dx,ax
F000:47BD  [+0x0C7BD]  E8 25 14                 call    5BE5h
F000:47C0  [+0x0C7C0]  80 EC 01                 sub     ah,1
F000:47C3  [+0x0C7C3]  73 F7                    jae     short 47BCh
F000:47C5  [+0x0C7C5]  07                       pop     es
F000:47C6  [+0x0C7C6]  5F                       pop     di
F000:47C7  [+0x0C7C7]  5A                       pop     dx
F000:47C8  [+0x0C7C8]  59                       pop     cx
F000:47C9  [+0x0C7C9]  58                       pop     ax
F000:47CA  [+0x0C7CA]  C3                       ret
F000:47CB  [+0x0C7CB]  50                       push    ax
F000:47CC  [+0x0C7CC]  51                       push    cx
F000:47CD  [+0x0C7CD]  52                       push    dx
F000:47CE  [+0x0C7CE]  57                       push    di
F000:47CF  [+0x0C7CF]  06                       push    es
F000:47D0  [+0x0C7D0]  B8 10 00                 mov     ax,10h
F000:47D3  [+0x0C7D3]  E8 25 00                 call    47FBh
F000:47D6  [+0x0C7D6]  BA DA 03                 mov     dx,3DAh
F000:47D9  [+0x0C7D9]  EC                       in      al,dx
F000:47DA  [+0x0C7DA]  B2 C0                    mov     dl,0C0h
F000:47DC  [+0x0C7DC]  B0 00                    mov     al,0
F000:47DE  [+0x0C7DE]  EE                       out     dx,al
F000:47DF  [+0x0C7DF]  B8 00 A0                 mov     ax,0A000h
F000:47E2  [+0x0C7E2]  8E C0                    mov     es,ax
F000:47E4  [+0x0C7E4]  33 FF                    xor     di,di
F000:47E6  [+0x0C7E6]  B1 80                    mov     cl,80h
F000:47E8  [+0x0C7E8]  B2 C4                    mov     dl,0C4h
F000:47EA  [+0x0C7EA]  B8 02 08                 mov     ax,802h
F000:47ED  [+0x0C7ED]  EF                       out     dx,ax
F000:47EE  [+0x0C7EE]  E8 D8 13                 call    5BC9h
F000:47F1  [+0x0C7F1]  D0 EC                    shr     ah,1
F000:47F3  [+0x0C7F3]  73 F8                    jae     short 47EDh
F000:47F5  [+0x0C7F5]  07                       pop     es
F000:47F6  [+0x0C7F6]  5F                       pop     di
F000:47F7  [+0x0C7F7]  5A                       pop     dx
F000:47F8  [+0x0C7F8]  59                       pop     cx
F000:47F9  [+0x0C7F9]  58                       pop     ax
F000:47FA  [+0x0C7FA]  C3                       ret
F000:47FB  [+0x0C7FB]  9C                       pushf
F000:47FC  [+0x0C7FC]  36 FF 1E 10 00           call    far [ss:10h]
F000:4801  [+0x0C801]  C3                       ret
F000:4802  [+0x0C802]  50                       push    ax
F000:4803  [+0x0C803]  B8 03 00                 mov     ax,3
F000:4806  [+0x0C806]  E8 F2 FF                 call    47FBh
F000:4809  [+0x0C809]  58                       pop     ax
F000:480A  [+0x0C80A]  C3                       ret
F000:480B  [+0x0C80B]  66 50                    push    eax
F000:480D  [+0x0C80D]  06                       push    es
F000:480E  [+0x0C80E]  33 C0                    xor     ax,ax
F000:4810  [+0x0C810]  8E C0                    mov     es,ax
F000:4812  [+0x0C812]  26 66 A1 B4 01           mov     eax,[es:1B4h]
F000:4817  [+0x0C817]  36 66 A3 10 00           mov     [ss:10h],eax
F000:481C  [+0x0C81C]  07                       pop     es
F000:481D  [+0x0C81D]  66 58                    pop     eax
F000:481F  [+0x0C81F]  C3                       ret
F000:4820  [+0x0C820]  B8 00 01                 mov     ax,100h
F000:4823  [+0x0C823]  C3                       ret
F000:4824  [+0x0C824]  50                       push    ax
F000:4825  [+0x0C825]  53                       push    bx
F000:4826  [+0x0C826]  E4 64                    in      al,64h
F000:4828  [+0x0C828]  A8 01                    test    al,1
F000:482A  [+0x0C82A]  0F 84 04 00              je      near 4832h
F000:482E  [+0x0C82E]  E4 60                    in      al,60h
F000:4830  [+0x0C830]  EB F4                    jmp     short 4826h
F000:4832  [+0x0C832]  E4 64                    in      al,64h
F000:4834  [+0x0C834]  A8 02                    test    al,2
F000:4836  [+0x0C836]  0F 84 02 00              je      near 483Ch
F000:483A  [+0x0C83A]  EB F6                    jmp     short 4832h
F000:483C  [+0x0C83C]  B0 D0                    mov     al,0D0h
F000:483E  [+0x0C83E]  E6 64                    out     64h,al
F000:4840  [+0x0C840]  E4 64                    in      al,64h
F000:4842  [+0x0C842]  A8 01                    test    al,1
F000:4844  [+0x0C844]  74 FA                    je      short 4840h
F000:4846  [+0x0C846]  E4 60                    in      al,60h
F000:4848  [+0x0C848]  0C 02                    or      al,2
F000:484A  [+0x0C84A]  8A D8                    mov     bl,al
F000:484C  [+0x0C84C]  B0 D1                    mov     al,0D1h
F000:484E  [+0x0C84E]  E6 64                    out     64h,al
F000:4850  [+0x0C850]  E4 64                    in      al,64h
F000:4852  [+0x0C852]  A8 02                    test    al,2
F000:4854  [+0x0C854]  0F 84 02 00              je      near 485Ah
F000:4858  [+0x0C858]  EB F6                    jmp     short 4850h
F000:485A  [+0x0C85A]  8A C3                    mov     al,bl
F000:485C  [+0x0C85C]  E6 60                    out     60h,al
F000:485E  [+0x0C85E]  5B                       pop     bx
F000:485F  [+0x0C85F]  58                       pop     ax
F000:4860  [+0x0C860]  C3                       ret
F000:4861  [+0x0C861]  50                       push    ax
F000:4862  [+0x0C862]  53                       push    bx
F000:4863  [+0x0C863]  E4 64                    in      al,64h
F000:4865  [+0x0C865]  A8 01                    test    al,1
F000:4867  [+0x0C867]  0F 84 04 00              je      near 486Fh
F000:486B  [+0x0C86B]  E4 60                    in      al,60h
F000:486D  [+0x0C86D]  EB F4                    jmp     short 4863h
F000:486F  [+0x0C86F]  E4 64                    in      al,64h
F000:4871  [+0x0C871]  A8 02                    test    al,2
F000:4873  [+0x0C873]  0F 84 02 00              je      near 4879h
F000:4877  [+0x0C877]  EB F6                    jmp     short 486Fh
F000:4879  [+0x0C879]  B0 D1                    mov     al,0D1h
F000:487B  [+0x0C87B]  E6 64                    out     64h,al
F000:487D  [+0x0C87D]  EB 00                    jmp     short 487Fh
F000:487F  [+0x0C87F]  A0 09 0C                 mov     al,[0C09h]
F000:4882  [+0x0C882]  E6 60                    out     60h,al
F000:4884  [+0x0C884]  5B                       pop     bx
F000:4885  [+0x0C885]  58                       pop     ax
F000:4886  [+0x0C886]  C3                       ret
F000:4887  [+0x0C887]  50                       push    ax
F000:4888  [+0x0C888]  53                       push    bx
F000:4889  [+0x0C889]  E4 64                    in      al,64h
F000:488B  [+0x0C88B]  A8 01                    test    al,1
F000:488D  [+0x0C88D]  0F 84 04 00              je      near 4895h
F000:4891  [+0x0C891]  E4 60                    in      al,60h
F000:4893  [+0x0C893]  EB F4                    jmp     short 4889h
F000:4895  [+0x0C895]  E4 64                    in      al,64h
F000:4897  [+0x0C897]  A8 02                    test    al,2
F000:4899  [+0x0C899]  0F 84 02 00              je      near 489Fh
F000:489D  [+0x0C89D]  EB F6                    jmp     short 4895h
F000:489F  [+0x0C89F]  B0 D0                    mov     al,0D0h
F000:48A1  [+0x0C8A1]  E6 64                    out     64h,al
F000:48A3  [+0x0C8A3]  E4 64                    in      al,64h
F000:48A5  [+0x0C8A5]  A8 01                    test    al,1
F000:48A7  [+0x0C8A7]  74 FA                    je      short 48A3h
F000:48A9  [+0x0C8A9]  E4 60                    in      al,60h
F000:48AB  [+0x0C8AB]  A2 09 0C                 mov     [0C09h],al
F000:48AE  [+0x0C8AE]  5B                       pop     bx
F000:48AF  [+0x0C8AF]  58                       pop     ax
F000:48B0  [+0x0C8B0]  C3                       ret
F000:48B1  [+0x0C8B1]  50                       push    ax
F000:48B2  [+0x0C8B2]  53                       push    bx
F000:48B3  [+0x0C8B3]  56                       push    si
F000:48B4  [+0x0C8B4]  BE 0A 0C                 mov     si,0C0Ah
F000:48B7  [+0x0C8B7]  33 DB                    xor     bx,bx
F000:48B9  [+0x0C8B9]  B9 0D 00                 mov     cx,0Dh
F000:48BC  [+0x0C8BC]  53                       push    bx
F000:48BD  [+0x0C8BD]  B4 01                    mov     ah,1
F000:48BF  [+0x0C8BF]  8A C3                    mov     al,bl
F000:48C1  [+0x0C8C1]  E8 13 D0                 call    18D7h
F000:48C4  [+0x0C8C4]  B8 07 02                 mov     ax,207h
F000:48C7  [+0x0C8C7]  E7 24                    out     24h,ax
F000:48C9  [+0x0C8C9]  EB 00                    jmp     short 48CBh
F000:48CB  [+0x0C8CB]  E5 26                    in      ax,26h
F000:48CD  [+0x0C8CD]  0D 80 00                 or      ax,80h
F000:48D0  [+0x0C8D0]  8B D0                    mov     dx,ax
F000:48D2  [+0x0C8D2]  B8 07 02                 mov     ax,207h
F000:48D5  [+0x0C8D5]  E7 24                    out     24h,ax
F000:48D7  [+0x0C8D7]  8B C2                    mov     ax,dx
F000:48D9  [+0x0C8D9]  E7 26                    out     26h,ax
F000:48DB  [+0x0C8DB]  89 1C                    mov     [si],bx
F000:48DD  [+0x0C8DD]  83 C6 02                 add     si,2
F000:48E0  [+0x0C8E0]  5B                       pop     bx
F000:48E1  [+0x0C8E1]  FE C3                    inc     bl
F000:48E3  [+0x0C8E3]  E2 D7                    loop    48BCh
F000:48E5  [+0x0C8E5]  5E                       pop     si
F000:48E6  [+0x0C8E6]  5B                       pop     bx
F000:48E7  [+0x0C8E7]  58                       pop     ax
F000:48E8  [+0x0C8E8]  C3                       ret
F000:48E9  [+0x0C8E9]  50                       push    ax
F000:48EA  [+0x0C8EA]  53                       push    bx
F000:48EB  [+0x0C8EB]  56                       push    si
F000:48EC  [+0x0C8EC]  BE 0A 0C                 mov     si,0C0Ah
F000:48EF  [+0x0C8EF]  33 DB                    xor     bx,bx
F000:48F1  [+0x0C8F1]  B9 0D 00                 mov     cx,0Dh
F000:48F4  [+0x0C8F4]  53                       push    bx
F000:48F5  [+0x0C8F5]  B4 03                    mov     ah,3
F000:48F7  [+0x0C8F7]  8A C3                    mov     al,bl
F000:48F9  [+0x0C8F9]  8B 1C                    mov     bx,[si]
F000:48FB  [+0x0C8FB]  E8 D9 CF                 call    18D7h
F000:48FE  [+0x0C8FE]  B8 07 02                 mov     ax,207h
F000:4901  [+0x0C901]  E7 24                    out     24h,ax
F000:4903  [+0x0C903]  EB 00                    jmp     short 4905h
F000:4905  [+0x0C905]  E5 26                    in      ax,26h
F000:4907  [+0x0C907]  0D 80 00                 or      ax,80h
F000:490A  [+0x0C90A]  8B D0                    mov     dx,ax
F000:490C  [+0x0C90C]  B8 07 02                 mov     ax,207h
F000:490F  [+0x0C90F]  E7 24                    out     24h,ax
F000:4911  [+0x0C911]  8B C2                    mov     ax,dx
F000:4913  [+0x0C913]  E7 26                    out     26h,ax
F000:4915  [+0x0C915]  83 C6 02                 add     si,2
F000:4918  [+0x0C918]  5B                       pop     bx
F000:4919  [+0x0C919]  FE C3                    inc     bl
F000:491B  [+0x0C91B]  E2 D7                    loop    48F4h
F000:491D  [+0x0C91D]  5E                       pop     si
F000:491E  [+0x0C91E]  5B                       pop     bx
F000:491F  [+0x0C91F]  58                       pop     ax
F000:4920  [+0x0C920]  C3                       ret
F000:4921  [+0x0C921]  1E                       push    ds
F000:4922  [+0x0C922]  60                       pusha
F000:4923  [+0x0C923]  B8 00 DC                 mov     ax,0DC00h
F000:4926  [+0x0C926]  8E D8                    mov     ds,ax
F000:4928  [+0x0C928]  8C 16 27 14              mov     [1427h],ss
F000:492C  [+0x0C92C]  89 26 25 14              mov     [1425h],sp
F000:4930  [+0x0C930]  8C D0                    mov     ax,ss
F000:4932  [+0x0C932]  3D 80 DF                 cmp     ax,0DF80h
F000:4935  [+0x0C935]  74 08                    je      short 493Fh
F000:4937  [+0x0C937]  B8 80 DF                 mov     ax,0DF80h
F000:493A  [+0x0C93A]  8E D0                    mov     ss,ax
F000:493C  [+0x0C93C]  BC FF 07                 mov     sp,7FFh
F000:493F  [+0x0C93F]  50                       push    ax
F000:4940  [+0x0C940]  B0 50                    mov     al,50h
F000:4942  [+0x0C942]  E6 80                    out     80h,al
F000:4944  [+0x0C944]  58                       pop     ax
F000:4945  [+0x0C945]  BA 0E 40                 mov     dx,400Eh
F000:4948  [+0x0C948]  E8 36 0C                 call    5581h
F000:494B  [+0x0C94B]  50                       push    ax
F000:494C  [+0x0C94C]  B0 51                    mov     al,51h
F000:494E  [+0x0C94E]  E6 80                    out     80h,al
F000:4950  [+0x0C950]  58                       pop     ax
F000:4951  [+0x0C951]  75 1E                    jne     short 4971h
F000:4953  [+0x0C953]  BA 4C 10                 mov     dx,104Ch
F000:4956  [+0x0C956]  E8 28 0C                 call    5581h
F000:4959  [+0x0C959]  A2 24 0C                 mov     [0C24h],al
F000:495C  [+0x0C95C]  74 13                    je      short 4971h
F000:495E  [+0x0C95E]  50                       push    ax
F000:495F  [+0x0C95F]  B0 D1                    mov     al,0D1h
F000:4961  [+0x0C961]  E6 80                    out     80h,al
F000:4963  [+0x0C963]  58                       pop     ax
F000:4964  [+0x0C964]  BA 4C 10                 mov     dx,104Ch
F000:4967  [+0x0C967]  B0 00                    mov     al,0
F000:4969  [+0x0C969]  E8 31 0C                 call    559Dh
F000:496C  [+0x0C96C]  C6 06 24 0C 00           mov     byte [0C24h],0
F000:4971  [+0x0C971]  50                       push    ax
F000:4972  [+0x0C972]  B0 D3                    mov     al,0D3h
F000:4974  [+0x0C974]  E6 80                    out     80h,al
F000:4976  [+0x0C976]  58                       pop     ax
F000:4977  [+0x0C977]  0F B2 26 25 14           lss     sp,[1425h]
F000:497C  [+0x0C97C]  61                       popa
F000:497D  [+0x0C97D]  1F                       pop     ds
F000:497E  [+0x0C97E]  C3                       ret
F000:497F  [+0x0C97F]  50                       push    ax
F000:4980  [+0x0C980]  1E                       push    ds
F000:4981  [+0x0C981]  B8 00 DC                 mov     ax,0DC00h
F000:4984  [+0x0C984]  8E D8                    mov     ds,ax
F000:4986  [+0x0C986]  80 3E 24 0C 01           cmp     byte [0C24h],1
F000:498B  [+0x0C98B]  74 03                    je      short 4990h
F000:498D  [+0x0C98D]  1F                       pop     ds
F000:498E  [+0x0C98E]  58                       pop     ax
F000:498F  [+0x0C98F]  C3                       ret
F000:4990  [+0x0C990]  FA                       cli
F000:4991  [+0x0C991]  E8 B6 C9                 call    134Ah
F000:4994  [+0x0C994]  B8 00 DC                 mov     ax,0DC00h
F000:4997  [+0x0C997]  8E D8                    mov     ds,ax
F000:4999  [+0x0C999]  8E C0                    mov     es,ax
F000:499B  [+0x0C99B]  B8 80 DF                 mov     ax,0DF80h
F000:499E  [+0x0C99E]  8E D0                    mov     ss,ax
F000:49A0  [+0x0C9A0]  BC FF 07                 mov     sp,7FFh
F000:49A3  [+0x0C9A3]  B8 00 02                 mov     ax,200h
F000:49A6  [+0x0C9A6]  BA 00 1C                 mov     dx,1C00h
F000:49A9  [+0x0C9A9]  E8 8C C9                 call    1338h
F000:49AC  [+0x0C9AC]  E8 AF 05                 call    4F5Eh
F000:49AF  [+0x0C9AF]  FA                       cli
F000:49B0  [+0x0C9B0]  B8 00 DC                 mov     ax,0DC00h
F000:49B3  [+0x0C9B3]  8E D8                    mov     ds,ax
F000:49B5  [+0x0C9B5]  8E C0                    mov     es,ax
F000:49B7  [+0x0C9B7]  B8 80 DF                 mov     ax,0DF80h
F000:49BA  [+0x0C9BA]  8E D0                    mov     ss,ax
F000:49BC  [+0x0C9BC]  BC FF 07                 mov     sp,7FFh
F000:49BF  [+0x0C9BF]  E8 B1 03                 call    4D73h
F000:49C2  [+0x0C9C2]  E8 09 D7                 call    20CEh
F000:49C5  [+0x0C9C5]  E8 56 08                 call    521Eh
F000:49C8  [+0x0C9C8]  E8 40 FE                 call    480Bh
F000:49CB  [+0x0C9CB]  E8 74 FD                 call    4742h
F000:49CE  [+0x0C9CE]  E8 2F 07                 call    5100h
F000:49D1  [+0x0C9D1]  E8 EF 06                 call    50C3h
F000:49D4  [+0x0C9D4]  E8 DA FE                 call    48B1h
F000:49D7  [+0x0C9D7]  E8 AD FE                 call    4887h
F000:49DA  [+0x0C9DA]  E8 81 0B                 call    555Eh
F000:49DD  [+0x0C9DD]  E8 16 0C                 call    55F6h
F000:49E0  [+0x0C9E0]  E8 23 0C                 call    5606h
F000:49E3  [+0x0C9E3]  E8 2B 0C                 call    5611h
F000:49E6  [+0x0C9E6]  E8 CB 11                 call    5BB4h
F000:49E9  [+0x0C9E9]  E8 AE FD                 call    479Ah
F000:49EC  [+0x0C9EC]  E8 13 FE                 call    4802h
F000:49EF  [+0x0C9EF]  E8 75 F4                 call    3E67h
F000:49F2  [+0x0C9F2]  B8 00 00                 mov     ax,0
F000:49F5  [+0x0C9F5]  E8 23 F5                 call    3F1Bh
F000:49F8  [+0x0C9F8]  B8 00 00                 mov     ax,0
F000:49FB  [+0x0C9FB]  36 A3 20 00              mov     [ss:20h],ax
F000:49FF  [+0x0C9FF]  8E C0                    mov     es,ax
F000:4A01  [+0x0CA01]  33 FF                    xor     di,di
F000:4A03  [+0x0CA03]  B9 0A 00                 mov     cx,0Ah
F000:4A06  [+0x0CA06]  51                       push    cx
F000:4A07  [+0x0CA07]  B9 80 00                 mov     cx,80h
F000:4A0A  [+0x0CA0A]  E8 D8 11                 call    5BE5h
F000:4A0D  [+0x0CA0D]  36 81 06 20 00 00 10     add     word [ss:20h],1000h
F000:4A14  [+0x0CA14]  36 8E 06 20 00           mov     es,[ss:20h]
F000:4A19  [+0x0CA19]  33 FF                    xor     di,di
F000:4A1B  [+0x0CA1B]  59                       pop     cx
F000:4A1C  [+0x0CA1C]  E2 E8                    loop    4A06h
F000:4A1E  [+0x0CA1E]  B8 03 00                 mov     ax,3
F000:4A21  [+0x0CA21]  E8 F7 F4                 call    3F1Bh
F000:4A24  [+0x0CA24]  B8 00 C0                 mov     ax,0C000h
F000:4A27  [+0x0CA27]  B9 04 00                 mov     cx,4
F000:4A2A  [+0x0CA2A]  36 A3 20 00              mov     [ss:20h],ax
F000:4A2E  [+0x0CA2E]  8E C0                    mov     es,ax
F000:4A30  [+0x0CA30]  33 FF                    xor     di,di
F000:4A32  [+0x0CA32]  51                       push    cx
F000:4A33  [+0x0CA33]  B9 80 00                 mov     cx,80h
F000:4A36  [+0x0CA36]  E8 AC 11                 call    5BE5h
F000:4A39  [+0x0CA39]  36 81 06 20 00 00 10     add     word [ss:20h],1000h
F000:4A40  [+0x0CA40]  36 8E 06 20 00           mov     es,[ss:20h]
F000:4A45  [+0x0CA45]  33 FF                    xor     di,di
F000:4A47  [+0x0CA47]  59                       pop     cx
F000:4A48  [+0x0CA48]  E2 E8                    loop    4A32h
F000:4A4A  [+0x0CA4A]  B8 01 00                 mov     ax,1
F000:4A4D  [+0x0CA4D]  E8 CB F4                 call    3F1Bh
F000:4A50  [+0x0CA50]  E8 1F 07                 call    5172h
F000:4A53  [+0x0CA53]  0B C0                    or      ax,ax
F000:4A55  [+0x0CA55]  75 03                    jne     short 4A5Ah
F000:4A57  [+0x0CA57]  EB 6E                    jmp     short 4AC7h
F000:4A59  [+0x0CA59]  90                       nop
F000:4A5A  [+0x0CA5A]  BE 26 00                 mov     si,26h
F000:4A5D  [+0x0CA5D]  66 B8 00 00 10 00        mov     eax,100000h
F000:4A63  [+0x0CA63]  36 66 89 04              mov     [ss:si],eax
F000:4A67  [+0x0CA67]  E8 BA FD                 call    4824h
F000:4A6A  [+0x0CA6A]  E8 67 05                 call    4FD4h
F000:4A6D  [+0x0CA6D]  FC                       cld
F000:4A6E  [+0x0CA6E]  36 66 8B 36 26 00        mov     esi,[ss:26h]
F000:4A74  [+0x0CA74]  66 BF 00 00 01 00        mov     edi,10000h
F000:4A7A  [+0x0CA7A]  E8 EB 05                 call    5068h
F000:4A7D  [+0x0CA7D]  67 E3 35                 jecxz   4AB5h
F000:4A80  [+0x0CA80]  67 F3 66 A5              a32 rep movsd
F000:4A84  [+0x0CA84]  36 8B 0E 2E 00           mov     cx,[ss:2Eh]
F000:4A89  [+0x0CA89]  B8 00 10                 mov     ax,1000h
F000:4A8C  [+0x0CA8C]  36 A3 20 00              mov     [ss:20h],ax
F000:4A90  [+0x0CA90]  8E C0                    mov     es,ax
F000:4A92  [+0x0CA92]  8E D8                    mov     ds,ax
F000:4A94  [+0x0CA94]  33 FF                    xor     di,di
F000:4A96  [+0x0CA96]  51                       push    cx
F000:4A97  [+0x0CA97]  B9 80 00                 mov     cx,80h
F000:4A9A  [+0x0CA9A]  E8 48 11                 call    5BE5h
F000:4A9D  [+0x0CA9D]  36 81 06 20 00 00 10     add     word [ss:20h],1000h
F000:4AA4  [+0x0CAA4]  36 8E 06 20 00           mov     es,[ss:20h]
F000:4AA9  [+0x0CAA9]  33 FF                    xor     di,di
F000:4AAB  [+0x0CAAB]  59                       pop     cx
F000:4AAC  [+0x0CAAC]  E2 E8                    loop    4A96h
F000:4AAE  [+0x0CAAE]  BB 2A 00                 mov     bx,2Ah
F000:4AB1  [+0x0CAB1]  36 66 8B 0F              mov     ecx,[ss:bx]
F000:4AB5  [+0x0CAB5]  67 E3 0C                 jecxz   4AC4h
F000:4AB8  [+0x0CAB8]  36 66 81 06 26 00 00 00 08 00 add     dword [ss:26h],80000h
F000:4AC2  [+0x0CAC2]  EB A6                    jmp     short 4A6Ah
F000:4AC4  [+0x0CAC4]  E8 9A FD                 call    4861h
F000:4AC7  [+0x0CAC7]  B8 02 00                 mov     ax,2
F000:4ACA  [+0x0CACA]  E8 4E F4                 call    3F1Bh
F000:4ACD  [+0x0CACD]  B8 03 01                 mov     ax,103h
F000:4AD0  [+0x0CAD0]  B2 01                    mov     dl,1
F000:4AD2  [+0x0CAD2]  E8 63 C8                 call    1338h
F000:4AD5  [+0x0CAD5]  B8 00 60                 mov     ax,6000h
F000:4AD8  [+0x0CAD8]  8E D8                    mov     ds,ax
F000:4ADA  [+0x0CADA]  B8 00 10                 mov     ax,1000h
F000:4ADD  [+0x0CADD]  8E C0                    mov     es,ax
F000:4ADF  [+0x0CADF]  33 FF                    xor     di,di
F000:4AE1  [+0x0CAE1]  33 F6                    xor     si,si
F000:4AE3  [+0x0CAE3]  B9 00 80                 mov     cx,8000h
F000:4AE6  [+0x0CAE6]  F3 A5                    rep movsw
F000:4AE8  [+0x0CAE8]  B8 03 01                 mov     ax,103h
F000:4AEB  [+0x0CAEB]  B2 01                    mov     dl,1
F000:4AED  [+0x0CAED]  E8 51 C8                 call    1341h
F000:4AF0  [+0x0CAF0]  33 FF                    xor     di,di
F000:4AF2  [+0x0CAF2]  B9 80 00                 mov     cx,80h
F000:4AF5  [+0x0CAF5]  E8 ED 10                 call    5BE5h
F000:4AF8  [+0x0CAF8]  B0 01                    mov     al,1
F000:4AFA  [+0x0CAFA]  E8 3F 0B                 call    563Ch
F000:4AFD  [+0x0CAFD]  E8 AA F3                 call    3EAAh
F000:4B00  [+0x0CB00]  BA 58 80                 mov     dx,8058h
F000:4B03  [+0x0CB03]  B0 01                    mov     al,1
F000:4B05  [+0x0CB05]  E8 95 0A                 call    559Dh
F000:4B08  [+0x0CB08]  E8 C6 0A                 call    55D1h
F000:4B0B  [+0x0CB0B]  B8 0E 00                 mov     ax,0Eh
F000:4B0E  [+0x0CB0E]  E8 D2 C7                 call    12E3h
F000:4B11  [+0x0CB11]  81 E3 EF 0A              and     bx,0AEFh
F000:4B15  [+0x0CB15]  81 CB 00 08              or      bx,800h
F000:4B19  [+0x0CB19]  E8 CE C7                 call    12EAh
F000:4B1C  [+0x0CB1C]  E8 B8 DE                 call    29D7h
F000:4B1F  [+0x0CB1F]  FA                       cli
F000:4B20  [+0x0CB20]  E8 49 D5                 call    206Ch
F000:4B23  [+0x0CB23]  B8 00 02                 mov     ax,200h
F000:4B26  [+0x0CB26]  E8 BA C7                 call    12E3h
F000:4B29  [+0x0CB29]  81 E3 00 E0              and     bx,0E000h
F000:4B2D  [+0x0CB2D]  81 CB 80 00              or      bx,80h
F000:4B31  [+0x0CB31]  E8 B6 C7                 call    12EAh
F000:4B34  [+0x0CB34]  B8 07 02                 mov     ax,207h
F000:4B37  [+0x0CB37]  E8 A9 C7                 call    12E3h
F000:4B3A  [+0x0CB3A]  81 E3 00 E0              and     bx,0E000h
F000:4B3E  [+0x0CB3E]  81 CB 80 00              or      bx,80h
F000:4B42  [+0x0CB42]  E8 A5 C7                 call    12EAh
F000:4B45  [+0x0CB45]  B8 34 12                 mov     ax,1234h
F000:4B48  [+0x0CB48]  E7 8D                    out     8Dh,ax
F000:4B4A  [+0x0CB4A]  E6 80                    out     80h,al
F000:4B4C  [+0x0CB4C]  B8 07 00                 mov     ax,7
F000:4B4F  [+0x0CB4F]  E8 91 C7                 call    12E3h
F000:4B52  [+0x0CB52]  80 CB 18                 or      bl,18h
F000:4B55  [+0x0CB55]  80 E3 DF                 and     bl,0DFh
F000:4B58  [+0x0CB58]  E8 8F C7                 call    12EAh
F000:4B5B  [+0x0CB5B]  B8 01 00                 mov     ax,1
F000:4B5E  [+0x0CB5E]  E8 82 C7                 call    12E3h
F000:4B61  [+0x0CB61]  80 E7 1F                 and     bh,1Fh
F000:4B64  [+0x0CB64]  80 CF AF                 or      bh,0AFh
F000:4B67  [+0x0CB67]  E8 80 C7                 call    12EAh
F000:4B6A  [+0x0CB6A]  F4                       hlt
F000:4B6B  [+0x0CB6B]  EB FE                    jmp     short 4B6Bh
F000:4B6D  [+0x0CB6D]  60                       pusha
F000:4B6E  [+0x0CB6E]  1E                       push    ds
F000:4B6F  [+0x0CB6F]  B8 00 DC                 mov     ax,0DC00h
F000:4B72  [+0x0CB72]  8E D8                    mov     ds,ax
F000:4B74  [+0x0CB74]  8A 1E 24 0C              mov     bl,[0C24h]
F000:4B78  [+0x0CB78]  0A DB                    or      bl,bl
F000:4B7A  [+0x0CB7A]  1F                       pop     ds
F000:4B7B  [+0x0CB7B]  61                       popa
F000:4B7C  [+0x0CB7C]  75 02                    jne     short 4B80h
F000:4B7E  [+0x0CB7E]  F9                       stc
F000:4B7F  [+0x0CB7F]  C3                       ret
F000:4B80  [+0x0CB80]  52                       push    dx
F000:4B81  [+0x0CB81]  50                       push    ax
F000:4B82  [+0x0CB82]  BA 0E 40                 mov     dx,400Eh
F000:4B85  [+0x0CB85]  E8 F9 09                 call    5581h
F000:4B88  [+0x0CB88]  58                       pop     ax
F000:4B89  [+0x0CB89]  5A                       pop     dx
F000:4B8A  [+0x0CB8A]  74 02                    je      short 4B8Eh
F000:4B8C  [+0x0CB8C]  F9                       stc
F000:4B8D  [+0x0CB8D]  C3                       ret
F000:4B8E  [+0x0CB8E]  50                       push    ax
F000:4B8F  [+0x0CB8F]  E8 A1 0A                 call    5633h
F000:4B92  [+0x0CB92]  0A C0                    or      al,al
F000:4B94  [+0x0CB94]  58                       pop     ax
F000:4B95  [+0x0CB95]  75 01                    jne     short 4B98h
F000:4B97  [+0x0CB97]  C3                       ret
F000:4B98  [+0x0CB98]  32 C0                    xor     al,al
F000:4B9A  [+0x0CB9A]  E8 9F 0A                 call    563Ch
F000:4B9D  [+0x0CB9D]  E8 E4 07                 call    5384h
F000:4BA0  [+0x0CBA0]  E8 A7 C7                 call    134Ah
F000:4BA3  [+0x0CBA3]  B8 00 DC                 mov     ax,0DC00h
F000:4BA6  [+0x0CBA6]  8E D8                    mov     ds,ax
F000:4BA8  [+0x0CBA8]  8E C0                    mov     es,ax
F000:4BAA  [+0x0CBAA]  B8 80 DF                 mov     ax,0DF80h
F000:4BAD  [+0x0CBAD]  8E D0                    mov     ss,ax
F000:4BAF  [+0x0CBAF]  B8 FF 07                 mov     ax,7FFh
F000:4BB2  [+0x0CBB2]  8B E0                    mov     sp,ax
F000:4BB4  [+0x0CBB4]  36 C6 06 30 00 01        mov     byte [ss:30h],1
F000:4BBA  [+0x0CBBA]  B8 0D 00                 mov     ax,0Dh
F000:4BBD  [+0x0CBBD]  BB 00 00                 mov     bx,0
F000:4BC0  [+0x0CBC0]  E8 27 C7                 call    12EAh
F000:4BC3  [+0x0CBC3]  E8 45 FC                 call    480Bh
F000:4BC6  [+0x0CBC6]  E8 39 FC                 call    4802h
F000:4BC9  [+0x0CBC9]  E8 A7 F2                 call    3E73h
F000:4BCC  [+0x0CBCC]  E8 E5 0F                 call    5BB4h
F000:4BCF  [+0x0CBCF]  E8 4E FC                 call    4820h
F000:4BD2  [+0x0CBD2]  D1 E0                    shl     ax,1
F000:4BD4  [+0x0CBD4]  66 0F B7 C8              movzx   ecx,ax
F000:4BD8  [+0x0CBD8]  66 81 C1 00 05 00 00     add     ecx,500h
F000:4BDF  [+0x0CBDF]  66 81 C1 00 02 00 00     add     ecx,200h
F000:4BE6  [+0x0CBE6]  E8 D9 0F                 call    5BC2h
F000:4BE9  [+0x0CBE9]  B8 01 00                 mov     ax,1
F000:4BEC  [+0x0CBEC]  E8 2C F3                 call    3F1Bh
F000:4BEF  [+0x0CBEF]  E8 80 05                 call    5172h
F000:4BF2  [+0x0CBF2]  0B C0                    or      ax,ax
F000:4BF4  [+0x0CBF4]  75 03                    jne     short 4BF9h
F000:4BF6  [+0x0CBF6]  EB 6D                    jmp     short 4C65h
F000:4BF8  [+0x0CBF8]  90                       nop
F000:4BF9  [+0x0CBF9]  BE 26 00                 mov     si,26h
F000:4BFC  [+0x0CBFC]  66 B8 00 00 10 00        mov     eax,100000h
F000:4C02  [+0x0CC02]  36 66 89 04              mov     [ss:si],eax
F000:4C06  [+0x0CC06]  E8 1B FC                 call    4824h
F000:4C09  [+0x0CC09]  E8 5C 04                 call    5068h
F000:4C0C  [+0x0CC0C]  67 E3 4F                 jecxz   4C5Eh
F000:4C0F  [+0x0CC0F]  66 51                    push    ecx
F000:4C11  [+0x0CC11]  36 8B 0E 2E 00           mov     cx,[ss:2Eh]
F000:4C16  [+0x0CC16]  B8 00 10                 mov     ax,1000h
F000:4C19  [+0x0CC19]  36 A3 20 00              mov     [ss:20h],ax
F000:4C1D  [+0x0CC1D]  8E C0                    mov     es,ax
F000:4C1F  [+0x0CC1F]  33 FF                    xor     di,di
F000:4C21  [+0x0CC21]  51                       push    cx
F000:4C22  [+0x0CC22]  B9 80 00                 mov     cx,80h
F000:4C25  [+0x0CC25]  E8 A1 0F                 call    5BC9h
F000:4C28  [+0x0CC28]  36 81 06 20 00 00 10     add     word [ss:20h],1000h
F000:4C2F  [+0x0CC2F]  36 8E 06 20 00           mov     es,[ss:20h]
F000:4C34  [+0x0CC34]  33 FF                    xor     di,di
F000:4C36  [+0x0CC36]  59                       pop     cx
F000:4C37  [+0x0CC37]  E2 E8                    loop    4C21h
F000:4C39  [+0x0CC39]  66 59                    pop     ecx
F000:4C3B  [+0x0CC3B]  67 E3 20                 jecxz   4C5Eh
F000:4C3E  [+0x0CC3E]  E8 93 03                 call    4FD4h
F000:4C41  [+0x0CC41]  FC                       cld
F000:4C42  [+0x0CC42]  36 66 8B 3E 26 00        mov     edi,[ss:26h]
F000:4C48  [+0x0CC48]  66 BE 00 00 01 00        mov     esi,10000h
F000:4C4E  [+0x0CC4E]  67 F3 66 A5              a32 rep movsd
F000:4C52  [+0x0CC52]  36 66 81 06 26 00 00 00 08 00 add     dword [ss:26h],80000h
F000:4C5C  [+0x0CC5C]  EB AB                    jmp     short 4C09h
F000:4C5E  [+0x0CC5E]  B8 00 DC                 mov     ax,0DC00h
F000:4C61  [+0x0CC61]  8E D8                    mov     ds,ax
F000:4C63  [+0x0CC63]  8E C0                    mov     es,ax
F000:4C65  [+0x0CC65]  B8 02 00                 mov     ax,2
F000:4C68  [+0x0CC68]  E8 B0 F2                 call    3F1Bh
F000:4C6B  [+0x0CC6B]  B8 00 10                 mov     ax,1000h
F000:4C6E  [+0x0CC6E]  8E C0                    mov     es,ax
F000:4C70  [+0x0CC70]  33 FF                    xor     di,di
F000:4C72  [+0x0CC72]  B9 80 00                 mov     cx,80h
F000:4C75  [+0x0CC75]  E8 51 0F                 call    5BC9h
F000:4C78  [+0x0CC78]  B8 03 01                 mov     ax,103h
F000:4C7B  [+0x0CC7B]  B2 01                    mov     dl,1
F000:4C7D  [+0x0CC7D]  E8 B8 C6                 call    1338h
F000:4C80  [+0x0CC80]  B8 00 60                 mov     ax,6000h
F000:4C83  [+0x0CC83]  8E C0                    mov     es,ax
F000:4C85  [+0x0CC85]  B8 00 10                 mov     ax,1000h
F000:4C88  [+0x0CC88]  8E D8                    mov     ds,ax
F000:4C8A  [+0x0CC8A]  33 FF                    xor     di,di
F000:4C8C  [+0x0CC8C]  33 F6                    xor     si,si
F000:4C8E  [+0x0CC8E]  B9 00 80                 mov     cx,8000h
F000:4C91  [+0x0CC91]  F3 A5                    rep movsw
F000:4C93  [+0x0CC93]  B8 03 01                 mov     ax,103h
F000:4C96  [+0x0CC96]  B2 01                    mov     dl,1
F000:4C98  [+0x0CC98]  E8 A6 C6                 call    1341h
F000:4C9B  [+0x0CC9B]  E8 82 FB                 call    4820h
F000:4C9E  [+0x0CC9E]  D1 E0                    shl     ax,1
F000:4CA0  [+0x0CCA0]  66 0F B7 C8              movzx   ecx,ax
F000:4CA4  [+0x0CCA4]  E8 1B 0F                 call    5BC2h
F000:4CA7  [+0x0CCA7]  B8 00 00                 mov     ax,0
F000:4CAA  [+0x0CCAA]  E8 6E F2                 call    3F1Bh
F000:4CAD  [+0x0CCAD]  B8 00 00                 mov     ax,0
F000:4CB0  [+0x0CCB0]  36 A3 20 00              mov     [ss:20h],ax
F000:4CB4  [+0x0CCB4]  8E C0                    mov     es,ax
F000:4CB6  [+0x0CCB6]  33 FF                    xor     di,di
F000:4CB8  [+0x0CCB8]  B9 0A 00                 mov     cx,0Ah
F000:4CBB  [+0x0CCBB]  51                       push    cx
F000:4CBC  [+0x0CCBC]  B9 80 00                 mov     cx,80h
F000:4CBF  [+0x0CCBF]  E8 07 0F                 call    5BC9h
F000:4CC2  [+0x0CCC2]  36 81 06 20 00 00 10     add     word [ss:20h],1000h
F000:4CC9  [+0x0CCC9]  36 8E 06 20 00           mov     es,[ss:20h]
F000:4CCE  [+0x0CCCE]  33 FF                    xor     di,di
F000:4CD0  [+0x0CCD0]  59                       pop     cx
F000:4CD1  [+0x0CCD1]  E2 E8                    loop    4CBBh
F000:4CD3  [+0x0CCD3]  B8 03 00                 mov     ax,3
F000:4CD6  [+0x0CCD6]  E8 42 F2                 call    3F1Bh
F000:4CD9  [+0x0CCD9]  B8 07 02                 mov     ax,207h
F000:4CDC  [+0x0CCDC]  BB FF 1F                 mov     bx,1FFFh
F000:4CDF  [+0x0CCDF]  E8 08 C6                 call    12EAh
F000:4CE2  [+0x0CCE2]  B8 00 C0                 mov     ax,0C000h
F000:4CE5  [+0x0CCE5]  B9 04 00                 mov     cx,4
F000:4CE8  [+0x0CCE8]  36 A3 20 00              mov     [ss:20h],ax
F000:4CEC  [+0x0CCEC]  8E C0                    mov     es,ax
F000:4CEE  [+0x0CCEE]  33 FF                    xor     di,di
F000:4CF0  [+0x0CCF0]  51                       push    cx
F000:4CF1  [+0x0CCF1]  8C C0                    mov     ax,es
F000:4CF3  [+0x0CCF3]  50                       push    ax
F000:4CF4  [+0x0CCF4]  25 00 F0                 and     ax,0F000h
F000:4CF7  [+0x0CCF7]  B9 80 DF                 mov     cx,0DF80h
F000:4CFA  [+0x0CCFA]  81 E1 00 F0              and     cx,0F000h
F000:4CFE  [+0x0CCFE]  3B C1                    cmp     ax,cx
F000:4D00  [+0x0CD00]  58                       pop     ax
F000:4D01  [+0x0CD01]  0F 85 06 00              jne     near 4D0Bh
F000:4D05  [+0x0CD05]  B9 7C 00                 mov     cx,7Ch
F000:4D08  [+0x0CD08]  EB 04                    jmp     short 4D0Eh
F000:4D0A  [+0x0CD0A]  90                       nop
F000:4D0B  [+0x0CD0B]  B9 80 00                 mov     cx,80h
F000:4D0E  [+0x0CD0E]  E8 B8 0E                 call    5BC9h
F000:4D11  [+0x0CD11]  50                       push    ax
F000:4D12  [+0x0CD12]  51                       push    cx
F000:4D13  [+0x0CD13]  25 00 F0                 and     ax,0F000h
F000:4D16  [+0x0CD16]  B9 80 DF                 mov     cx,0DF80h
F000:4D19  [+0x0CD19]  81 E1 00 F0              and     cx,0F000h
F000:4D1D  [+0x0CD1D]  3B C1                    cmp     ax,cx
F000:4D1F  [+0x0CD1F]  59                       pop     cx
F000:4D20  [+0x0CD20]  58                       pop     ax
F000:4D21  [+0x0CD21]  0F 85 0C 00              jne     near 4D31h
F000:4D25  [+0x0CD25]  66 B8 04 00 00 00        mov     eax,4
F000:4D2B  [+0x0CD2B]  36 66 01 06 90 02        add     [ss:290h],eax
F000:4D31  [+0x0CD31]  36 81 06 20 00 00 10     add     word [ss:20h],1000h
F000:4D38  [+0x0CD38]  36 8E 06 20 00           mov     es,[ss:20h]
F000:4D3D  [+0x0CD3D]  33 FF                    xor     di,di
F000:4D3F  [+0x0CD3F]  59                       pop     cx
F000:4D40  [+0x0CD40]  E2 AE                    loop    4CF0h
F000:4D42  [+0x0CD42]  B8 00 DC                 mov     ax,0DC00h
F000:4D45  [+0x0CD45]  8E D8                    mov     ds,ax
F000:4D47  [+0x0CD47]  8E C0                    mov     es,ax
F000:4D49  [+0x0CD49]  66 33 C9                 xor     ecx,ecx
F000:4D4C  [+0x0CD4C]  E8 73 0E                 call    5BC2h
F000:4D4F  [+0x0CD4F]  E8 79 FA                 call    47CBh
F000:4D52  [+0x0CD52]  E8 CD 08                 call    5622h
F000:4D55  [+0x0CD55]  E8 A6 08                 call    55FEh
F000:4D58  [+0x0CD58]  E8 11 08                 call    556Ch
F000:4D5B  [+0x0CD5B]  E8 10 FA                 call    476Eh
F000:4D5E  [+0x0CD5E]  E8 81 03                 call    50E2h
F000:4D61  [+0x0CD61]  E8 FD FA                 call    4861h
F000:4D64  [+0x0CD64]  E8 25 00                 call    4D8Ch
F000:4D67  [+0x0CD67]  E8 C3 03                 call    512Dh
F000:4D6A  [+0x0CD6A]  E8 7C FB                 call    48E9h
F000:4D6D  [+0x0CD6D]  E8 9B D3                 call    210Bh
F000:4D70  [+0x0CD70]  E9 05 D7                 jmp     2478h
F000:4D73  [+0x0CD73]  60                       pusha
F000:4D74  [+0x0CD74]  1E                       push    ds
F000:4D75  [+0x0CD75]  06                       push    es
F000:4D76  [+0x0CD76]  FC                       cld
F000:4D77  [+0x0CD77]  BF 25 0C                 mov     di,0C25h
F000:4D7A  [+0x0CD7A]  33 F6                    xor     si,si
F000:4D7C  [+0x0CD7C]  8E DE                    mov     ds,si
F000:4D7E  [+0x0CD7E]  B9 00 04                 mov     cx,400h
F000:4D81  [+0x0CD81]  B8 00 DC                 mov     ax,0DC00h
F000:4D84  [+0x0CD84]  8E C0                    mov     es,ax
F000:4D86  [+0x0CD86]  F3 A5                    rep movsw
F000:4D88  [+0x0CD88]  07                       pop     es
F000:4D89  [+0x0CD89]  1F                       pop     ds
F000:4D8A  [+0x0CD8A]  61                       popa
F000:4D8B  [+0x0CD8B]  C3                       ret
F000:4D8C  [+0x0CD8C]  60                       pusha
F000:4D8D  [+0x0CD8D]  06                       push    es
F000:4D8E  [+0x0CD8E]  FC                       cld
F000:4D8F  [+0x0CD8F]  BE 25 0C                 mov     si,0C25h
F000:4D92  [+0x0CD92]  33 FF                    xor     di,di
F000:4D94  [+0x0CD94]  8E C7                    mov     es,di
F000:4D96  [+0x0CD96]  B9 00 04                 mov     cx,400h
F000:4D99  [+0x0CD99]  B8 00 DC                 mov     ax,0DC00h
F000:4D9C  [+0x0CD9C]  8E D8                    mov     ds,ax
F000:4D9E  [+0x0CD9E]  F3 A5                    rep movsw
F000:4DA0  [+0x0CDA0]  07                       pop     es
F000:4DA1  [+0x0CDA1]  61                       popa
F000:4DA2  [+0x0CDA2]  C3                       ret
F000:4DA3  [+0x0CDA3]  60                       pusha
F000:4DA4  [+0x0CDA4]  1E                       push    ds
F000:4DA5  [+0x0CDA5]  06                       push    es
F000:4DA6  [+0x0CDA6]  E8 B0 F3                 call    4159h
F000:4DA9  [+0x0CDA9]  E8 58 00                 call    4E04h
F000:4DAC  [+0x0CDAC]  8B 7C 12                 mov     di,[si+12h]
F000:4DAF  [+0x0CDAF]  E8 53 F9                 call    4705h
F000:4DB2  [+0x0CDB2]  E8 02 01                 call    4EB7h
F000:4DB5  [+0x0CDB5]  8B 7C 0E                 mov     di,[si+0Eh]
F000:4DB8  [+0x0CDB8]  0B FF                    or      di,di
F000:4DBA  [+0x0CDBA]  74 20                    je      short 4DDCh
F000:4DBC  [+0x0CDBC]  51                       push    cx
F000:4DBD  [+0x0CDBD]  52                       push    dx
F000:4DBE  [+0x0CDBE]  D0 E9                    shr     cl,1
F000:4DC0  [+0x0CDC0]  02 D1                    add     dl,cl
F000:4DC2  [+0x0CDC2]  86 DC                    xchg    bl,ah
F000:4DC4  [+0x0CDC4]  8B 7C 0E                 mov     di,[si+0Eh]
F000:4DC7  [+0x0CDC7]  E8 3B F9                 call    4705h
F000:4DCA  [+0x0CDCA]  E8 32 F8                 call    45FFh
F000:4DCD  [+0x0CDCD]  E3 09                    jcxz    4DD8h
F000:4DCF  [+0x0CDCF]  51                       push    cx
F000:4DD0  [+0x0CDD0]  D0 D9                    rcr     cl,1
F000:4DD2  [+0x0CDD2]  2A D1                    sub     dl,cl
F000:4DD4  [+0x0CDD4]  59                       pop     cx
F000:4DD5  [+0x0CDD5]  E8 E0 F2                 call    40B8h
F000:4DD8  [+0x0CDD8]  86 DC                    xchg    bl,ah
F000:4DDA  [+0x0CDDA]  5A                       pop     dx
F000:4DDB  [+0x0CDDB]  59                       pop     cx
F000:4DDC  [+0x0CDDC]  8B 7C 10                 mov     di,[si+10h]
F000:4DDF  [+0x0CDDF]  0B FF                    or      di,di
F000:4DE1  [+0x0CDE1]  74 1D                    je      short 4E00h
F000:4DE3  [+0x0CDE3]  E8 1F F9                 call    4705h
F000:4DE6  [+0x0CDE6]  E8 26 F8                 call    460Fh
F000:4DE9  [+0x0CDE9]  E3 15                    jcxz    4E00h
F000:4DEB  [+0x0CDEB]  81 C2 01 01              add     dx,101h
F000:4DEF  [+0x0CDEF]  51                       push    cx
F000:4DF0  [+0x0CDF0]  E8 0C F8                 call    45FFh
F000:4DF3  [+0x0CDF3]  E3 03                    jcxz    4DF8h
F000:4DF5  [+0x0CDF5]  E8 C0 F2                 call    40B8h
F000:4DF8  [+0x0CDF8]  03 F9                    add     di,cx
F000:4DFA  [+0x0CDFA]  FE C6                    inc     dh
F000:4DFC  [+0x0CDFC]  47                       inc     di
F000:4DFD  [+0x0CDFD]  59                       pop     cx
F000:4DFE  [+0x0CDFE]  E2 EF                    loop    4DEFh
F000:4E00  [+0x0CE00]  07                       pop     es
F000:4E01  [+0x0CE01]  1F                       pop     ds
F000:4E02  [+0x0CE02]  61                       popa
F000:4E03  [+0x0CE03]  C3                       ret
F000:4E04  [+0x0CE04]  56                       push    si
F000:4E05  [+0x0CE05]  57                       push    di
F000:4E06  [+0x0CE06]  1E                       push    ds
F000:4E07  [+0x0CE07]  06                       push    es
F000:4E08  [+0x0CE08]  06                       push    es
F000:4E09  [+0x0CE09]  1F                       pop     ds
F000:4E0A  [+0x0CE0A]  8B F7                    mov     si,di
F000:4E0C  [+0x0CE0C]  8A 6C 04                 mov     ch,[si+4]
F000:4E0F  [+0x0CE0F]  80 C5 02                 add     ch,2
F000:4E12  [+0x0CE12]  8A 4C 05                 mov     cl,[si+5]
F000:4E15  [+0x0CE15]  80 C1 02                 add     cl,2
F000:4E18  [+0x0CE18]  83 7C 10 00              cmp     word [si+10h],0
F000:4E1C  [+0x0CE1C]  74 33                    je      short 4E51h
F000:4E1E  [+0x0CE1E]  F7 04 00 30              test    word [si],3000h
F000:4E22  [+0x0CE22]  74 2D                    je      short 4E51h
F000:4E24  [+0x0CE24]  8B 7C 10                 mov     di,[si+10h]
F000:4E27  [+0x0CE27]  E8 DB F8                 call    4705h
F000:4E2A  [+0x0CE2A]  E8 E2 F7                 call    460Fh
F000:4E2D  [+0x0CE2D]  8A F1                    mov     dh,cl
F000:4E2F  [+0x0CE2F]  8A 6C 04                 mov     ch,[si+4]
F000:4E32  [+0x0CE32]  80 C5 02                 add     ch,2
F000:4E35  [+0x0CE35]  02 F5                    add     dh,ch
F000:4E37  [+0x0CE37]  8A D3                    mov     dl,bl
F000:4E39  [+0x0CE39]  8A 4C 05                 mov     cl,[si+5]
F000:4E3C  [+0x0CE3C]  80 C1 02                 add     cl,2
F000:4E3F  [+0x0CE3F]  02 D1                    add     dl,cl
F000:4E41  [+0x0CE41]  F7 04 00 10              test    word [si],1000h
F000:4E45  [+0x0CE45]  74 02                    je      short 4E49h
F000:4E47  [+0x0CE47]  8A EE                    mov     ch,dh
F000:4E49  [+0x0CE49]  F7 04 00 20              test    word [si],2000h
F000:4E4D  [+0x0CE4D]  74 02                    je      short 4E51h
F000:4E4F  [+0x0CE4F]  8A CA                    mov     cl,dl
F000:4E51  [+0x0CE51]  8A 74 02                 mov     dh,[si+2]
F000:4E54  [+0x0CE54]  8A 54 03                 mov     dl,[si+3]
F000:4E57  [+0x0CE57]  F7 04 00 40              test    word [si],4000h
F000:4E5B  [+0x0CE5B]  74 06                    je      short 4E63h
F000:4E5D  [+0x0CE5D]  E8 F2 00                 call    4F52h
F000:4E60  [+0x0CE60]  02 74 02                 add     dh,[si+2]
F000:4E63  [+0x0CE63]  F7 04 00 08              test    word [si],800h
F000:4E67  [+0x0CE67]  74 0D                    je      short 4E76h
F000:4E69  [+0x0CE69]  1E                       push    ds
F000:4E6A  [+0x0CE6A]  33 C0                    xor     ax,ax
F000:4E6C  [+0x0CE6C]  8E D8                    mov     ds,ax
F000:4E6E  [+0x0CE6E]  8A 36 51 04              mov     dh,[451h]
F000:4E72  [+0x0CE72]  02 74 02                 add     dh,[si+2]
F000:4E75  [+0x0CE75]  1F                       pop     ds
F000:4E76  [+0x0CE76]  F7 04 00 80              test    word [si],8000h
F000:4E7A  [+0x0CE7A]  74 06                    je      short 4E82h
F000:4E7C  [+0x0CE7C]  E8 C7 00                 call    4F46h
F000:4E7F  [+0x0CE7F]  02 54 03                 add     dl,[si+3]
F000:4E82  [+0x0CE82]  F7 04 00 04              test    word [si],400h
F000:4E86  [+0x0CE86]  74 0D                    je      short 4E95h
F000:4E88  [+0x0CE88]  1E                       push    ds
F000:4E89  [+0x0CE89]  33 C0                    xor     ax,ax
F000:4E8B  [+0x0CE8B]  8E D8                    mov     ds,ax
F000:4E8D  [+0x0CE8D]  8A 16 50 04              mov     dl,[450h]
F000:4E91  [+0x0CE91]  02 54 03                 add     dl,[si+3]
F000:4E94  [+0x0CE94]  1F                       pop     ds
F000:4E95  [+0x0CE95]  8A 44 0B                 mov     al,[si+0Bh]
F000:4E98  [+0x0CE98]  8A 64 0C                 mov     ah,[si+0Ch]
F000:4E9B  [+0x0CE9B]  8A 5C 0A                 mov     bl,[si+0Ah]
F000:4E9E  [+0x0CE9E]  8A 7C 0D                 mov     bh,[si+0Dh]
F000:4EA1  [+0x0CEA1]  E8 6A F2                 call    410Eh
F000:4EA4  [+0x0CEA4]  74 0C                    je      short 4EB2h
F000:4EA6  [+0x0CEA6]  8A 44 07                 mov     al,[si+7]
F000:4EA9  [+0x0CEA9]  8A 64 08                 mov     ah,[si+8]
F000:4EAC  [+0x0CEAC]  8A 5C 06                 mov     bl,[si+6]
F000:4EAF  [+0x0CEAF]  8A 7C 09                 mov     bh,[si+9]
F000:4EB2  [+0x0CEB2]  07                       pop     es
F000:4EB3  [+0x0CEB3]  1F                       pop     ds
F000:4EB4  [+0x0CEB4]  5F                       pop     di
F000:4EB5  [+0x0CEB5]  5E                       pop     si
F000:4EB6  [+0x0CEB6]  C3                       ret
F000:4EB7  [+0x0CEB7]  60                       pusha
F000:4EB8  [+0x0CEB8]  80 ED 02                 sub     ch,2
F000:4EBB  [+0x0CEBB]  80 E9 02                 sub     cl,2
F000:4EBE  [+0x0CEBE]  8B F1                    mov     si,cx
F000:4EC0  [+0x0CEC0]  8B EA                    mov     bp,dx
F000:4EC2  [+0x0CEC2]  33 DB                    xor     bx,bx
F000:4EC4  [+0x0CEC4]  86 DD                    xchg    bl,ch
F000:4EC6  [+0x0CEC6]  50                       push    ax
F000:4EC7  [+0x0CEC7]  8A E0                    mov     ah,al
F000:4EC9  [+0x0CEC9]  26 8A 05                 mov     al,[es:di]
F000:4ECC  [+0x0CECC]  E8 C7 F1                 call    4096h
F000:4ECF  [+0x0CECF]  E8 CD F1                 call    409Fh
F000:4ED2  [+0x0CED2]  FE C2                    inc     dl
F000:4ED4  [+0x0CED4]  26 8A 45 04              mov     al,[es:di+4]
F000:4ED8  [+0x0CED8]  E8 D0 F1                 call    40ABh
F000:4EDB  [+0x0CEDB]  02 D1                    add     dl,cl
F000:4EDD  [+0x0CEDD]  26 8A 45 01              mov     al,[es:di+1]
F000:4EE1  [+0x0CEE1]  E8 B2 F1                 call    4096h
F000:4EE4  [+0x0CEE4]  E8 B8 F1                 call    409Fh
F000:4EE7  [+0x0CEE7]  8B D5                    mov     dx,bp
F000:4EE9  [+0x0CEE9]  02 F3                    add     dh,bl
F000:4EEB  [+0x0CEEB]  FE C6                    inc     dh
F000:4EED  [+0x0CEED]  26 8A 45 02              mov     al,[es:di+2]
F000:4EF1  [+0x0CEF1]  E8 A2 F1                 call    4096h
F000:4EF4  [+0x0CEF4]  E8 A8 F1                 call    409Fh
F000:4EF7  [+0x0CEF7]  FE C2                    inc     dl
F000:4EF9  [+0x0CEF9]  26 8A 45 05              mov     al,[es:di+5]
F000:4EFD  [+0x0CEFD]  E8 AB F1                 call    40ABh
F000:4F00  [+0x0CF00]  02 D1                    add     dl,cl
F000:4F02  [+0x0CF02]  26 8A 45 03              mov     al,[es:di+3]
F000:4F06  [+0x0CF06]  E8 8D F1                 call    4096h
F000:4F09  [+0x0CF09]  E8 93 F1                 call    409Fh
F000:4F0C  [+0x0CF0C]  8B D5                    mov     dx,bp
F000:4F0E  [+0x0CF0E]  8B CB                    mov     cx,bx
F000:4F10  [+0x0CF10]  26 8A 45 06              mov     al,[es:di+6]
F000:4F14  [+0x0CF14]  FE C6                    inc     dh
F000:4F16  [+0x0CF16]  E8 7D F1                 call    4096h
F000:4F19  [+0x0CF19]  E8 83 F1                 call    409Fh
F000:4F1C  [+0x0CF1C]  E2 F6                    loop    4F14h
F000:4F1E  [+0x0CF1E]  8B D5                    mov     dx,bp
F000:4F20  [+0x0CF20]  8B CE                    mov     cx,si
F000:4F22  [+0x0CF22]  02 D1                    add     dl,cl
F000:4F24  [+0x0CF24]  FE C2                    inc     dl
F000:4F26  [+0x0CF26]  8B CB                    mov     cx,bx
F000:4F28  [+0x0CF28]  26 8A 45 07              mov     al,[es:di+7]
F000:4F2C  [+0x0CF2C]  FE C6                    inc     dh
F000:4F2E  [+0x0CF2E]  E8 65 F1                 call    4096h
F000:4F31  [+0x0CF31]  E8 6B F1                 call    409Fh
F000:4F34  [+0x0CF34]  E2 F6                    loop    4F2Ch
F000:4F36  [+0x0CF36]  8B D5                    mov     dx,bp
F000:4F38  [+0x0CF38]  8B CE                    mov     cx,si
F000:4F3A  [+0x0CF3A]  58                       pop     ax
F000:4F3B  [+0x0CF3B]  81 C2 01 01              add     dx,101h
F000:4F3F  [+0x0CF3F]  B0 20                    mov     al,20h
F000:4F41  [+0x0CF41]  E8 9A F1                 call    40DEh
F000:4F44  [+0x0CF44]  61                       popa
F000:4F45  [+0x0CF45]  C3                       ret
F000:4F46  [+0x0CF46]  51                       push    cx
F000:4F47  [+0x0CF47]  E8 D4 F1                 call    411Eh
F000:4F4A  [+0x0CF4A]  8A D1                    mov     dl,cl
F000:4F4C  [+0x0CF4C]  59                       pop     cx
F000:4F4D  [+0x0CF4D]  2A D1                    sub     dl,cl
F000:4F4F  [+0x0CF4F]  D0 EA                    shr     dl,1
F000:4F51  [+0x0CF51]  C3                       ret
F000:4F52  [+0x0CF52]  51                       push    cx
F000:4F53  [+0x0CF53]  E8 C8 F1                 call    411Eh
F000:4F56  [+0x0CF56]  8A F5                    mov     dh,ch
F000:4F58  [+0x0CF58]  59                       pop     cx
F000:4F59  [+0x0CF59]  2A F5                    sub     dh,ch
F000:4F5B  [+0x0CF5B]  D0 EE                    shr     dh,1
F000:4F5D  [+0x0CF5D]  C3                       ret
F000:4F5E  [+0x0CF5E]  1E                       push    ds
F000:4F5F  [+0x0CF5F]  53                       push    bx
F000:4F60  [+0x0CF60]  52                       push    dx
F000:4F61  [+0x0CF61]  B8 00 60                 mov     ax,6000h
F000:4F64  [+0x0CF64]  8E D8                    mov     ds,ax
F000:4F66  [+0x0CF66]  B8 03 01                 mov     ax,103h
F000:4F69  [+0x0CF69]  E8 77 C3                 call    12E3h
F000:4F6C  [+0x0CF6C]  8B D3                    mov     dx,bx
F000:4F6E  [+0x0CF6E]  80 E3 FE                 and     bl,0FEh
F000:4F71  [+0x0CF71]  E8 76 C3                 call    12EAh
F000:4F74  [+0x0CF74]  80 3E 00 80 EA           cmp     byte [8000h],0EAh
F000:4F79  [+0x0CF79]  74 0E                    je      short 4F89h
F000:4F7B  [+0x0CF7B]  B8 03 01                 mov     ax,103h
F000:4F7E  [+0x0CF7E]  8B DA                    mov     bx,dx
F000:4F80  [+0x0CF80]  E8 67 C3                 call    12EAh
F000:4F83  [+0x0CF83]  B8 00 00                 mov     ax,0
F000:4F86  [+0x0CF86]  EB 48                    jmp     short 4FD0h
F000:4F88  [+0x0CF88]  90                       nop
F000:4F89  [+0x0CF89]  B8 03 01                 mov     ax,103h
F000:4F8C  [+0x0CF8C]  8B DA                    mov     bx,dx
F000:4F8E  [+0x0CF8E]  E8 59 C3                 call    12EAh
F000:4F91  [+0x0CF91]  B8 00 60                 mov     ax,6000h
F000:4F94  [+0x0CF94]  8E C0                    mov     es,ax
F000:4F96  [+0x0CF96]  8E D8                    mov     ds,ax
F000:4F98  [+0x0CF98]  BF 00 FE                 mov     di,0FE00h
F000:4F9B  [+0x0CF9B]  BE 00 90                 mov     si,9000h
F000:4F9E  [+0x0CF9E]  C7 84 F0 01 AF 49        mov     word [si+1F0h],49AFh
F000:4FA4  [+0x0CFA4]  B9 00 01                 mov     cx,100h
F000:4FA7  [+0x0CFA7]  FC                       cld
F000:4FA8  [+0x0CFA8]  F3 A5                    rep movsw
F000:4FAA  [+0x0CFAA]  B8 06 00                 mov     ax,6
F000:4FAD  [+0x0CFAD]  BB FF 4F                 mov     bx,4FFFh
F000:4FB0  [+0x0CFB0]  E8 37 C3                 call    12EAh
F000:4FB3  [+0x0CFB3]  B8 00 00                 mov     ax,0
F000:4FB6  [+0x0CFB6]  BB 00 00                 mov     bx,0
F000:4FB9  [+0x0CFB9]  E8 2E C3                 call    12EAh
F000:4FBC  [+0x0CFBC]  EB 00                    jmp     short 4FBEh
F000:4FBE  [+0x0CFBE]  B8 01 00                 mov     ax,1
F000:4FC1  [+0x0CFC1]  BB F7 20                 mov     bx,20F7h
F000:4FC4  [+0x0CFC4]  E8 23 C3                 call    12EAh
F000:4FC7  [+0x0CFC7]  B0 99                    mov     al,99h
F000:4FC9  [+0x0CFC9]  E6 80                    out     80h,al
F000:4FCB  [+0x0CFCB]  0F AA                    rsm
F000:4FCD  [+0x0CFCD]  EB FC                    jmp     short 4FCBh
F000:4FCF  [+0x0CFCF]  F4                       hlt
F000:4FD0  [+0x0CFD0]  5A                       pop     dx
F000:4FD1  [+0x0CFD1]  5B                       pop     bx
F000:4FD2  [+0x0CFD2]  1F                       pop     ds
F000:4FD3  [+0x0CFD3]  C3                       ret
F000:4FD4  [+0x0CFD4]  66 50                    push    eax
F000:4FD6  [+0x0CFD6]  53                       push    bx
F000:4FD7  [+0x0CFD7]  56                       push    si
F000:4FD8  [+0x0CFD8]  57                       push    di
F000:4FD9  [+0x0CFD9]  8C D0                    mov     ax,ss
F000:4FDB  [+0x0CFDB]  8A FC                    mov     bh,ah
F000:4FDD  [+0x0CFDD]  C0 EF 04                 shr     bh,4
F000:4FE0  [+0x0CFE0]  C1 E0 04                 shl     ax,4
F000:4FE3  [+0x0CFE3]  05 37 00                 add     ax,37h
F000:4FE6  [+0x0CFE6]  80 D7 00                 adc     bh,0
F000:4FE9  [+0x0CFE9]  36 A3 33 00              mov     [ss:33h],ax
F000:4FED  [+0x0CFED]  36 88 3E 35 00           mov     [ss:35h],bh
F000:4FF2  [+0x0CFF2]  36 C7 06 31 00 20 00     mov     word [ss:31h],20h
F000:4FF9  [+0x0CFF9]  36 C6 06 36 00 00        mov     byte [ss:36h],0
F000:4FFF  [+0x0CFFF]  B9 10 00                 mov     cx,10h
F000:5002  [+0x0D002]  BE 52 50                 mov     si,5052h
F000:5005  [+0x0D005]  BF 37 00                 mov     di,37h
F000:5008  [+0x0D008]  8C C8                    mov     ax,cs
F000:500A  [+0x0D00A]  8E D8                    mov     ds,ax
F000:500C  [+0x0D00C]  8C D0                    mov     ax,ss
F000:500E  [+0x0D00E]  8E C0                    mov     es,ax
F000:5010  [+0x0D010]  F3 A4                    rep movsb
F000:5012  [+0x0D012]  FA                       cli
F000:5013  [+0x0D013]  8D 36 31 00              lea     si,[31h]
F000:5017  [+0x0D017]  26 0F 01 14              lgdt    [es:si]
F000:501B  [+0x0D01B]  0F 20 C0                 mov     eax,cr0
F000:501E  [+0x0D01E]  66 83 C8 01              or      eax,1
F000:5022  [+0x0D022]  0F 22 C0                 mov     cr0,eax
F000:5025  [+0x0D025]  EB 00                    jmp     short 5027h
F000:5027  [+0x0D027]  EB 00                    jmp     short 5029h
F000:5029  [+0x0D029]  B8 08 00                 mov     ax,8
F000:502C  [+0x0D02C]  8E C0                    mov     es,ax
F000:502E  [+0x0D02E]  8E D8                    mov     ds,ax
F000:5030  [+0x0D030]  EB 00                    jmp     short 5032h
F000:5032  [+0x0D032]  0F 20 C0                 mov     eax,cr0
F000:5035  [+0x0D035]  66 83 E0 FE              and     eax,0FFFFFFFEh
F000:5039  [+0x0D039]  0F 22 C0                 mov     cr0,eax
F000:503C  [+0x0D03C]  BE 52 71                 mov     si,7152h
F000:503F  [+0x0D03F]  EA 44 50 00 E8           jmp     0E800h:5044h
F000:5044  [+0x0D044]  8D 36 62 50              lea     si,[5062h]
F000:5048  [+0x0D048]  2E 0F 01 1C              lidt    [cs:si]
F000:504C  [+0x0D04C]  5F                       pop     di
F000:504D  [+0x0D04D]  5E                       pop     si
F000:504E  [+0x0D04E]  5B                       pop     bx
F000:504F  [+0x0D04F]  66 58                    pop     eax
F000:5051  [+0x0D051]  C3                       ret
F000:5052  [+0x0D052]  00 00                    add     [bx+si],al
F000:5054  [+0x0D054]  00 00                    add     [bx+si],al
F000:5056  [+0x0D056]  00 00                    add     [bx+si],al
F000:5058  [+0x0D058]  00 00                    add     [bx+si],al
F000:505A  [+0x0D05A]  DB 0xFF  (bad)
F000:505C  [+0x0D05C]  00 00                    add     [bx+si],al
F000:505E  [+0x0D05E]  00 92 8F 00              add     [bp+si+8Fh],dl
F000:5062  [+0x0D062]  FF 03                    inc     word [bp+di]
F000:5064  [+0x0D064]  00 00                    add     [bx+si],al
F000:5066  [+0x0D066]  00 00                    add     [bx+si],al
F000:5068  [+0x0D068]  66 50                    push    eax
F000:506A  [+0x0D06A]  66 53                    push    ebx
F000:506C  [+0x0D06C]  66 52                    push    edx
F000:506E  [+0x0D06E]  56                       push    si
F000:506F  [+0x0D06F]  BE 2A 00                 mov     si,2Ah
F000:5072  [+0x0D072]  36 66 8B 0C              mov     ecx,[ss:si]
F000:5076  [+0x0D076]  67 E3 42                 jecxz   50BBh
F000:5079  [+0x0D079]  66 81 F9 00 00 08 00     cmp     ecx,80000h
F000:5080  [+0x0D080]  76 10                    jbe     short 5092h
F000:5082  [+0x0D082]  66 B9 00 00 08 00        mov     ecx,80000h
F000:5088  [+0x0D088]  36 66 81 2C 00 00 08 00  sub     dword [ss:si],80000h
F000:5090  [+0x0D090]  EB 0D                    jmp     short 509Fh
F000:5092  [+0x0D092]  66 B8 00 00 00 00        mov     eax,0
F000:5098  [+0x0D098]  BE 2A 00                 mov     si,2Ah
F000:509B  [+0x0D09B]  36 66 89 04              mov     [ss:si],eax
F000:509F  [+0x0D09F]  66 8B C1                 mov     eax,ecx
F000:50A2  [+0x0D0A2]  66 BB 00 00 01 00        mov     ebx,10000h
F000:50A8  [+0x0D0A8]  66 BA 00 00 00 00        mov     edx,0
F000:50AE  [+0x0D0AE]  66 F7 F3                 div     ebx
F000:50B1  [+0x0D0B1]  36 A3 2E 00              mov     [ss:2Eh],ax
F000:50B5  [+0x0D0B5]  66 D1 E9                 shr     ecx,1
F000:50B8  [+0x0D0B8]  66 D1 E9                 shr     ecx,1
F000:50BB  [+0x0D0BB]  5E                       pop     si
F000:50BC  [+0x0D0BC]  66 5A                    pop     edx
F000:50BE  [+0x0D0BE]  66 5B                    pop     ebx
F000:50C0  [+0x0D0C0]  66 58                    pop     eax
F000:50C2  [+0x0D0C2]  C3                       ret
F000:50C3  [+0x0D0C3]  60                       pusha
F000:50C4  [+0x0D0C4]  BE 44 51                 mov     si,5144h
F000:50C7  [+0x0D0C7]  BF 29 14                 mov     di,1429h
F000:50CA  [+0x0D0CA]  FC                       cld
F000:50CB  [+0x0D0CB]  2E 8B 04                 mov     ax,[cs:si]
F000:50CE  [+0x0D0CE]  3D FF FF                 cmp     ax,0FFFFh
F000:50D1  [+0x0D0D1]  74 0D                    je      short 50E0h
F000:50D3  [+0x0D0D3]  E8 0D C2                 call    12E3h
F000:50D6  [+0x0D0D6]  89 1D                    mov     [di],bx
F000:50D8  [+0x0D0D8]  83 C6 02                 add     si,2
F000:50DB  [+0x0D0DB]  83 C7 02                 add     di,2
F000:50DE  [+0x0D0DE]  EB EA                    jmp     short 50CAh
F000:50E0  [+0x0D0E0]  61                       popa
F000:50E1  [+0x0D0E1]  C3                       ret
F000:50E2  [+0x0D0E2]  60                       pusha
F000:50E3  [+0x0D0E3]  BE 44 51                 mov     si,5144h
F000:50E6  [+0x0D0E6]  BF 29 14                 mov     di,1429h
F000:50E9  [+0x0D0E9]  2E 8B 04                 mov     ax,[cs:si]
F000:50EC  [+0x0D0EC]  3D FF FF                 cmp     ax,0FFFFh
F000:50EF  [+0x0D0EF]  74 0D                    je      short 50FEh
F000:50F1  [+0x0D0F1]  8B 1D                    mov     bx,[di]
F000:50F3  [+0x0D0F3]  E8 F4 C1                 call    12EAh
F000:50F6  [+0x0D0F6]  83 C6 02                 add     si,2
F000:50F9  [+0x0D0F9]  83 C7 02                 add     di,2
F000:50FC  [+0x0D0FC]  EB EB                    jmp     short 50E9h
F000:50FE  [+0x0D0FE]  61                       popa
F000:50FF  [+0x0D0FF]  C3                       ret
F000:5100  [+0x0D100]  60                       pusha
F000:5101  [+0x0D101]  BF 47 14                 mov     di,1447h
F000:5104  [+0x0D104]  B9 10 00                 mov     cx,10h
F000:5107  [+0x0D107]  BA 80 00                 mov     dx,80h
F000:510A  [+0x0D10A]  FC                       cld
F000:510B  [+0x0D10B]  6C                       insb
F000:510C  [+0x0D10C]  42                       inc     dx
F000:510D  [+0x0D10D]  E2 FC                    loop    510Bh
F000:510F  [+0x0D10F]  BE 64 51                 mov     si,5164h
F000:5112  [+0x0D112]  B9 06 00                 mov     cx,6
F000:5115  [+0x0D115]  BA 81 00                 mov     dx,81h
F000:5118  [+0x0D118]  2E 8B 04                 mov     ax,[cs:si]
F000:511B  [+0x0D11B]  E8 C5 C1                 call    12E3h
F000:511E  [+0x0D11E]  8B C3                    mov     ax,bx
F000:5120  [+0x0D120]  EE                       out     dx,al
F000:5121  [+0x0D121]  86 E0                    xchg    ah,al
F000:5123  [+0x0D123]  42                       inc     dx
F000:5124  [+0x0D124]  EE                       out     dx,al
F000:5125  [+0x0D125]  83 C6 02                 add     si,2
F000:5128  [+0x0D128]  42                       inc     dx
F000:5129  [+0x0D129]  E2 ED                    loop    5118h
F000:512B  [+0x0D12B]  61                       popa
F000:512C  [+0x0D12C]  C3                       ret
F000:512D  [+0x0D12D]  51                       push    cx
F000:512E  [+0x0D12E]  52                       push    dx
F000:512F  [+0x0D12F]  56                       push    si
F000:5130  [+0x0D130]  FC                       cld
F000:5131  [+0x0D131]  BE 47 14                 mov     si,1447h
F000:5134  [+0x0D134]  B9 08 00                 mov     cx,8
F000:5137  [+0x0D137]  BA 80 00                 mov     dx,80h
F000:513A  [+0x0D13A]  6F                       outsw
F000:513B  [+0x0D13B]  83 C2 02                 add     dx,2
F000:513E  [+0x0D13E]  E2 FA                    loop    513Ah
F000:5140  [+0x0D140]  5E                       pop     si
F000:5141  [+0x0D141]  5A                       pop     dx
F000:5142  [+0x0D142]  59                       pop     cx
F000:5143  [+0x0D143]  C3                       ret
F000:5144  [+0x0D144]  01 01                    add     [bx+di],ax
F000:5146  [+0x0D146]  02 01                    add     al,[bx+di]
F000:5148  [+0x0D148]  00 03                    add     [bp+di],al
F000:514A  [+0x0D14A]  01 03                    add     [bp+di],ax
F000:514C  [+0x0D14C]  04 03                    add     al,3
F000:514E  [+0x0D14E]  05 03 06                 add     ax,603h
F000:5151  [+0x0D151]  03 07                    add     ax,[bx]
F000:5153  [+0x0D153]  03 00                    add     ax,[bx+si]
F000:5155  [+0x0D155]  02 07                    add     al,[bx]
F000:5157  [+0x0D157]  02 01                    add     al,[bx+di]
F000:5159  [+0x0D159]  02 02                    add     al,[bp+si]
F000:515B  [+0x0D15B]  02 02                    add     al,[bp+si]
F000:515D  [+0x0D15D]  00 03                    add     [bp+di],al
F000:515F  [+0x0D15F]  00 12                    add     [bp+si],dl
F000:5161  [+0x0D161]  00 FF                    add     bh,bh
F000:5163  [+0x0D163]  FF 01                    inc     word [bx+di]
F000:5165  [+0x0D165]  02 02                    add     al,[bp+si]
F000:5167  [+0x0D167]  02 03                    add     al,[bp+di]
F000:5169  [+0x0D169]  02 04                    add     al,[si]
F000:516B  [+0x0D16B]  02 05                    add     al,[di]
F000:516D  [+0x0D16D]  02 06 02 FF              add     al,[0FF02h]
F000:5171  [+0x0D171]  FF 53 51                 call    word [bp+di+51h]
F000:5174  [+0x0D174]  52                       push    dx
F000:5175  [+0x0D175]  56                       push    si
F000:5176  [+0x0D176]  BB 03 02                 mov     bx,203h
F000:5179  [+0x0D179]  B9 04 00                 mov     cx,4
F000:517C  [+0x0D17C]  36 C6 06 47 00 00        mov     byte [ss:47h],0
F000:5182  [+0x0D182]  8B C3                    mov     ax,bx
F000:5184  [+0x0D184]  E7 24                    out     24h,ax
F000:5186  [+0x0D186]  EB 00                    jmp     short 5188h
F000:5188  [+0x0D188]  E5 26                    in      ax,26h
F000:518A  [+0x0D18A]  F6 C4 01                 test    ah,1
F000:518D  [+0x0D18D]  74 14                    je      short 51A3h
F000:518F  [+0x0D18F]  24 3F                    and     al,3Fh
F000:5191  [+0x0D191]  36 3A 06 47 00           cmp     al,[ss:47h]
F000:5196  [+0x0D196]  73 02                    jae     short 519Ah
F000:5198  [+0x0D198]  EB 09                    jmp     short 51A3h
F000:519A  [+0x0D19A]  36 A2 47 00              mov     [ss:47h],al
F000:519E  [+0x0D19E]  36 89 1E 48 00           mov     [ss:48h],bx
F000:51A3  [+0x0D1A3]  43                       inc     bx
F000:51A4  [+0x0D1A4]  E2 DC                    loop    5182h
F000:51A6  [+0x0D1A6]  36 8A 16 47 00           mov     dl,[ss:47h]
F000:51AB  [+0x0D1AB]  36 A1 48 00              mov     ax,[ss:48h]
F000:51AF  [+0x0D1AF]  E7 24                    out     24h,ax
F000:51B1  [+0x0D1B1]  EB 00                    jmp     short 51B3h
F000:51B3  [+0x0D1B3]  E5 26                    in      ax,26h
F000:51B5  [+0x0D1B5]  24 C0                    and     al,0C0h
F000:51B7  [+0x0D1B7]  B1 06                    mov     cl,6
F000:51B9  [+0x0D1B9]  D2 E8                    shr     al,cl
F000:51BB  [+0x0D1BB]  32 FF                    xor     bh,bh
F000:51BD  [+0x0D1BD]  8A D8                    mov     bl,al
F000:51BF  [+0x0D1BF]  BE 03 52                 mov     si,5203h
F000:51C2  [+0x0D1C2]  2E 8A 00                 mov     al,[cs:bx+si]
F000:51C5  [+0x0D1C5]  02 D0                    add     dl,al
F000:51C7  [+0x0D1C7]  80 EA 01                 sub     dl,1
F000:51CA  [+0x0D1CA]  32 F6                    xor     dh,dh
F000:51CC  [+0x0D1CC]  B1 04                    mov     cl,4
F000:51CE  [+0x0D1CE]  D3 E2                    shl     dx,cl
F000:51D0  [+0x0D1D0]  83 FA 00                 cmp     dx,0
F000:51D3  [+0x0D1D3]  75 04                    jne     short 51D9h
F000:51D5  [+0x0D1D5]  8B C2                    mov     ax,dx
F000:51D7  [+0x0D1D7]  EB 17                    jmp     short 51F0h
F000:51D9  [+0x0D1D9]  33 C0                    xor     ax,ax
F000:51DB  [+0x0D1DB]  36 C7 06 2A 00 00 00     mov     word [ss:2Ah],0
F000:51E2  [+0x0D1E2]  36 89 16 2C 00           mov     [ss:2Ch],dx
F000:51E7  [+0x0D1E7]  BB 00 04                 mov     bx,400h
F000:51EA  [+0x0D1EA]  F7 F3                    div     bx
F000:51EC  [+0x0D1EC]  0B C0                    or      ax,ax
F000:51EE  [+0x0D1EE]  EB 0E                    jmp     short 51FEh
F000:51F0  [+0x0D1F0]  36 C7 06 2A 00 00 00     mov     word [ss:2Ah],0
F000:51F7  [+0x0D1F7]  36 C7 06 2C 00 00 00     mov     word [ss:2Ch],0
F000:51FE  [+0x0D1FE]  5E                       pop     si
F000:51FF  [+0x0D1FF]  5A                       pop     dx
F000:5200  [+0x0D200]  59                       pop     cx
F000:5201  [+0x0D201]  5B                       pop     bx
F000:5202  [+0x0D202]  C3                       ret
F000:5203  [+0x0D203]  01 02                    add     [bp+si],ax
F000:5205  [+0x0D205]  04 10                    add     al,10h
F000:5207  [+0x0D207]  50                       push    ax
F000:5208  [+0x0D208]  53                       push    bx
F000:5209  [+0x0D209]  B8 86 00                 mov     ax,86h
F000:520C  [+0x0D20C]  E8 D4 C0                 call    12E3h
F000:520F  [+0x0D20F]  88 1E 57 14              mov     [1457h],bl
F000:5213  [+0x0D213]  B0 94                    mov     al,94h
F000:5215  [+0x0D215]  E6 70                    out     70h,al
F000:5217  [+0x0D217]  EB 00                    jmp     short 5219h
F000:5219  [+0x0D219]  E4 71                    in      al,71h
F000:521B  [+0x0D21B]  5B                       pop     bx
F000:521C  [+0x0D21C]  58                       pop     ax
F000:521D  [+0x0D21D]  C3                       ret
F000:521E  [+0x0D21E]  FC                       cld
F000:521F  [+0x0D21F]  60                       pusha
F000:5220  [+0x0D220]  1E                       push    ds
F000:5221  [+0x0D221]  06                       push    es
F000:5222  [+0x0D222]  B0 22                    mov     al,22h
F000:5224  [+0x0D224]  E6 80                    out     80h,al
F000:5226  [+0x0D226]  BF 25 0C                 mov     di,0C25h
F000:5229  [+0x0D229]  33 F6                    xor     si,si
F000:522B  [+0x0D22B]  8E DE                    mov     ds,si
F000:522D  [+0x0D22D]  B9 00 01                 mov     cx,100h
F000:5230  [+0x0D230]  B8 00 DC                 mov     ax,0DC00h
F000:5233  [+0x0D233]  8E C0                    mov     es,ax
F000:5235  [+0x0D235]  F3 66 A5                 rep movsd
F000:5238  [+0x0D238]  B8 00 50                 mov     ax,5000h
F000:523B  [+0x0D23B]  8E D8                    mov     ds,ax
F000:523D  [+0x0D23D]  BE 00 80                 mov     si,8000h
F000:5240  [+0x0D240]  B8 00 DC                 mov     ax,0DC00h
F000:5243  [+0x0D243]  8E C0                    mov     es,ax
F000:5245  [+0x0D245]  BF 5E 14                 mov     di,145Eh
F000:5248  [+0x0D248]  B9 34 00                 mov     cx,34h
F000:524B  [+0x0D24B]  90                       nop
F000:524C  [+0x0D24C]  F3 A4                    rep movsb
F000:524E  [+0x0D24E]  1E                       push    ds
F000:524F  [+0x0D24F]  07                       pop     es
F000:5250  [+0x0D250]  0E                       push    cs
F000:5251  [+0x0D251]  1F                       pop     ds
F000:5252  [+0x0D252]  BF 00 80                 mov     di,8000h
F000:5255  [+0x0D255]  BE 2B 53                 mov     si,532Bh
F000:5258  [+0x0D258]  B9 34 00                 mov     cx,34h
F000:525B  [+0x0D25B]  90                       nop
F000:525C  [+0x0D25C]  F3 A4                    rep movsb
F000:525E  [+0x0D25E]  33 C0                    xor     ax,ax
F000:5260  [+0x0D260]  8E C0                    mov     es,ax
F000:5262  [+0x0D262]  BF 00 00                 mov     di,0
F000:5265  [+0x0D265]  BB 00 80                 mov     bx,8000h
F000:5268  [+0x0D268]  BA 00 50                 mov     dx,5000h
F000:526B  [+0x0D26B]  B9 00 01                 mov     cx,100h
F000:526E  [+0x0D26E]  8B C3                    mov     ax,bx
F000:5270  [+0x0D270]  AB                       stosw
F000:5271  [+0x0D271]  8B C2                    mov     ax,dx
F000:5273  [+0x0D273]  AB                       stosw
F000:5274  [+0x0D274]  83 EB 10                 sub     bx,10h
F000:5277  [+0x0D277]  42                       inc     dx
F000:5278  [+0x0D278]  E2 F4                    loop    526Eh
F000:527A  [+0x0D27A]  FA                       cli
F000:527B  [+0x0D27B]  B8 00 DC                 mov     ax,0DC00h
F000:527E  [+0x0D27E]  8E C0                    mov     es,ax
F000:5280  [+0x0D280]  8E D8                    mov     ds,ax
F000:5282  [+0x0D282]  C6 06 59 14 00           mov     byte [1459h],0
F000:5287  [+0x0D287]  C6 06 58 14 00           mov     byte [1458h],0
F000:528C  [+0x0D28C]  B0 FE                    mov     al,0FEh
F000:528E  [+0x0D28E]  E6 21                    out     21h,al
F000:5290  [+0x0D290]  FB                       sti
F000:5291  [+0x0D291]  80 3E 59 14 01           cmp     byte [1459h],1
F000:5296  [+0x0D296]  75 F9                    jne     short 5291h
F000:5298  [+0x0D298]  B0 FB                    mov     al,0FBh
F000:529A  [+0x0D29A]  E6 21                    out     21h,al
F000:529C  [+0x0D29C]  B0 FF                    mov     al,0FFh
F000:529E  [+0x0D29E]  E6 A1                    out     0A1h,al
F000:52A0  [+0x0D2A0]  B0 8B                    mov     al,8Bh
F000:52A2  [+0x0D2A2]  E8 47 CD                 call    1FECh
F000:52A5  [+0x0D2A5]  88 26 5D 14              mov     [145Dh],ah
F000:52A9  [+0x0D2A9]  80 CC 80                 or      ah,80h
F000:52AC  [+0x0D2AC]  80 E4 8F                 and     ah,8Fh
F000:52AF  [+0x0D2AF]  E8 4C CD                 call    1FFEh
F000:52B2  [+0x0D2B2]  B0 8A                    mov     al,8Ah
F000:52B4  [+0x0D2B4]  E8 35 CD                 call    1FECh
F000:52B7  [+0x0D2B7]  88 26 5C 14              mov     [145Ch],ah
F000:52BB  [+0x0D2BB]  80 E4 F0                 and     ah,0F0h
F000:52BE  [+0x0D2BE]  80 CC 03                 or      ah,3
F000:52C1  [+0x0D2C1]  E8 3A CD                 call    1FFEh
F000:52C4  [+0x0D2C4]  B0 FE                    mov     al,0FEh
F000:52C6  [+0x0D2C6]  E6 A1                    out     0A1h,al
F000:52C8  [+0x0D2C8]  B0 8B                    mov     al,8Bh
F000:52CA  [+0x0D2CA]  E8 1F CD                 call    1FECh
F000:52CD  [+0x0D2CD]  80 CC 40                 or      ah,40h
F000:52D0  [+0x0D2D0]  80 E4 7F                 and     ah,7Fh
F000:52D3  [+0x0D2D3]  E8 28 CD                 call    1FFEh
F000:52D6  [+0x0D2D6]  80 3E 58 14 01           cmp     byte [1458h],1
F000:52DB  [+0x0D2DB]  75 F9                    jne     short 52D6h
F000:52DD  [+0x0D2DD]  B0 8C                    mov     al,8Ch
F000:52DF  [+0x0D2DF]  E8 0A CD                 call    1FECh
F000:52E2  [+0x0D2E2]  FA                       cli
F000:52E3  [+0x0D2E3]  B0 FF                    mov     al,0FFh
F000:52E5  [+0x0D2E5]  E6 21                    out     21h,al
F000:52E7  [+0x0D2E7]  E6 A1                    out     0A1h,al
F000:52E9  [+0x0D2E9]  E6 80                    out     80h,al
F000:52EB  [+0x0D2EB]  B0 8B                    mov     al,8Bh
F000:52ED  [+0x0D2ED]  8A 26 5D 14              mov     ah,[145Dh]
F000:52F1  [+0x0D2F1]  E8 0A CD                 call    1FFEh
F000:52F4  [+0x0D2F4]  B0 8A                    mov     al,8Ah
F000:52F6  [+0x0D2F6]  8A 26 5C 14              mov     ah,[145Ch]
F000:52FA  [+0x0D2FA]  E8 01 CD                 call    1FFEh
F000:52FD  [+0x0D2FD]  33 C0                    xor     ax,ax
F000:52FF  [+0x0D2FF]  8E C0                    mov     es,ax
F000:5301  [+0x0D301]  8B F8                    mov     di,ax
F000:5303  [+0x0D303]  B8 00 DC                 mov     ax,0DC00h
F000:5306  [+0x0D306]  8E D8                    mov     ds,ax
F000:5308  [+0x0D308]  BE 25 0C                 mov     si,0C25h
F000:530B  [+0x0D30B]  B9 00 01                 mov     cx,100h
F000:530E  [+0x0D30E]  F3 66 A5                 rep movsd
F000:5311  [+0x0D311]  B8 00 50                 mov     ax,5000h
F000:5314  [+0x0D314]  8E C0                    mov     es,ax
F000:5316  [+0x0D316]  BF 00 80                 mov     di,8000h
F000:5319  [+0x0D319]  B8 00 DC                 mov     ax,0DC00h
F000:531C  [+0x0D31C]  8E D8                    mov     ds,ax
F000:531E  [+0x0D31E]  BE 5E 14                 mov     si,145Eh
F000:5321  [+0x0D321]  B9 34 00                 mov     cx,34h
F000:5324  [+0x0D324]  90                       nop
F000:5325  [+0x0D325]  F3 A4                    rep movsb
F000:5327  [+0x0D327]  07                       pop     es
F000:5328  [+0x0D328]  1F                       pop     ds
F000:5329  [+0x0D329]  61                       popa
F000:532A  [+0x0D32A]  C3                       ret
F000:532B  [+0x0D32B]  50                       push    ax
F000:532C  [+0x0D32C]  B0 77                    mov     al,77h
F000:532E  [+0x0D32E]  E6 80                    out     80h,al
F000:5330  [+0x0D330]  80 3E 59 14 01           cmp     byte [1459h],1
F000:5335  [+0x0D335]  74 11                    je      short 5348h
F000:5337  [+0x0D337]  C6 06 59 14 01           mov     byte [1459h],1
F000:533C  [+0x0D33C]  8C C8                    mov     ax,cs
F000:533E  [+0x0D33E]  25 FF 00                 and     ax,0FFh
F000:5341  [+0x0D341]  A2 5A 14                 mov     [145Ah],al
F000:5344  [+0x0D344]  B0 20                    mov     al,20h
F000:5346  [+0x0D346]  EB 11                    jmp     short 5359h
F000:5348  [+0x0D348]  C6 06 58 14 01           mov     byte [1458h],1
F000:534D  [+0x0D34D]  8C C8                    mov     ax,cs
F000:534F  [+0x0D34F]  25 FF 00                 and     ax,0FFh
F000:5352  [+0x0D352]  A2 5B 14                 mov     [145Bh],al
F000:5355  [+0x0D355]  B0 20                    mov     al,20h
F000:5357  [+0x0D357]  E6 A0                    out     0A0h,al
F000:5359  [+0x0D359]  EB 00                    jmp     short 535Bh
F000:535B  [+0x0D35B]  E6 20                    out     20h,al
F000:535D  [+0x0D35D]  58                       pop     ax
F000:535E  [+0x0D35E]  CF                       iret
F000:535F  [+0x0D35F]  9C                       pushf
F000:5360  [+0x0D360]  50                       push    ax
F000:5361  [+0x0D361]  FA                       cli
F000:5362  [+0x0D362]  B0 15                    mov     al,15h
F000:5364  [+0x0D364]  E6 A0                    out     0A0h,al
F000:5366  [+0x0D366]  E6 20                    out     20h,al
F000:5368  [+0x0D368]  B0 70                    mov     al,70h
F000:536A  [+0x0D36A]  E6 A1                    out     0A1h,al
F000:536C  [+0x0D36C]  B0 08                    mov     al,8
F000:536E  [+0x0D36E]  E6 21                    out     21h,al
F000:5370  [+0x0D370]  B0 02                    mov     al,2
F000:5372  [+0x0D372]  E6 A1                    out     0A1h,al
F000:5374  [+0x0D374]  B0 04                    mov     al,4
F000:5376  [+0x0D376]  E6 21                    out     21h,al
F000:5378  [+0x0D378]  B0 01                    mov     al,1
F000:537A  [+0x0D37A]  E6 A1                    out     0A1h,al
F000:537C  [+0x0D37C]  E6 21                    out     21h,al
F000:537E  [+0x0D37E]  E8 03 00                 call    5384h
F000:5381  [+0x0D381]  58                       pop     ax
F000:5382  [+0x0D382]  9D                       popf
F000:5383  [+0x0D383]  C3                       ret
F000:5384  [+0x0D384]  50                       push    ax
F000:5385  [+0x0D385]  B0 FF                    mov     al,0FFh
F000:5387  [+0x0D387]  E6 21                    out     21h,al
F000:5389  [+0x0D389]  E6 A1                    out     0A1h,al
F000:538B  [+0x0D38B]  58                       pop     ax
F000:538C  [+0x0D38C]  C3                       ret
F000:538D  [+0x0D38D]  B8 01 00                 mov     ax,1
F000:5390  [+0x0D390]  E7 24                    out     24h,ax
F000:5392  [+0x0D392]  EB 00                    jmp     short 5394h
F000:5394  [+0x0D394]  E5 26                    in      ax,26h
F000:5396  [+0x0D396]  0D 07 00                 or      ax,7
F000:5399  [+0x0D399]  8B D8                    mov     bx,ax
F000:539B  [+0x0D39B]  B8 01 00                 mov     ax,1
F000:539E  [+0x0D39E]  E7 24                    out     24h,ax
F000:53A0  [+0x0D3A0]  8B C3                    mov     ax,bx
F000:53A2  [+0x0D3A2]  E7 26                    out     26h,ax
F000:53A4  [+0x0D3A4]  B0 EE                    mov     al,0EEh
F000:53A6  [+0x0D3A6]  E6 80                    out     80h,al
F000:53A8  [+0x0D3A8]  B0 8F                    mov     al,8Fh
F000:53AA  [+0x0D3AA]  E6 70                    out     70h,al
F000:53AC  [+0x0D3AC]  EB 00                    jmp     short 53AEh
F000:53AE  [+0x0D3AE]  E4 71                    in      al,71h
F000:53B0  [+0x0D3B0]  FA                       cli
F000:53B1  [+0x0D3B1]  BA 81 00                 mov     dx,81h
F000:53B4  [+0x0D3B4]  B9 06 00                 mov     cx,6
F000:53B7  [+0x0D3B7]  8C C8                    mov     ax,cs
F000:53B9  [+0x0D3B9]  8E D8                    mov     ds,ax
F000:53BB  [+0x0D3BB]  BE 20 55                 mov     si,5520h
F000:53BE  [+0x0D3BE]  ED                       in      ax,dx
F000:53BF  [+0x0D3BF]  8B D8                    mov     bx,ax
F000:53C1  [+0x0D3C1]  8B 04                    mov     ax,[si]
F000:53C3  [+0x0D3C3]  E7 24                    out     24h,ax
F000:53C5  [+0x0D3C5]  EB 00                    jmp     short 53C7h
F000:53C7  [+0x0D3C7]  8B C3                    mov     ax,bx
F000:53C9  [+0x0D3C9]  E7 26                    out     26h,ax
F000:53CB  [+0x0D3CB]  83 C6 02                 add     si,2
F000:53CE  [+0x0D3CE]  83 C2 02                 add     dx,2
F000:53D1  [+0x0D3D1]  E2 EB                    loop    53BEh
F000:53D3  [+0x0D3D3]  E4 61                    in      al,61h
F000:53D5  [+0x0D3D5]  0C 0C                    or      al,0Ch
F000:53D7  [+0x0D3D7]  E6 61                    out     61h,al
F000:53D9  [+0x0D3D9]  B8 07 00                 mov     ax,7
F000:53DC  [+0x0D3DC]  E7 24                    out     24h,ax
F000:53DE  [+0x0D3DE]  EB 00                    jmp     short 53E0h
F000:53E0  [+0x0D3E0]  E5 26                    in      ax,26h
F000:53E2  [+0x0D3E2]  24 E7                    and     al,0E7h
F000:53E4  [+0x0D3E4]  8B D8                    mov     bx,ax
F000:53E6  [+0x0D3E6]  B8 07 00                 mov     ax,7
F000:53E9  [+0x0D3E9]  E7 24                    out     24h,ax
F000:53EB  [+0x0D3EB]  8B C3                    mov     ax,bx
F000:53ED  [+0x0D3ED]  E7 26                    out     26h,ax
F000:53EF  [+0x0D3EF]  B0 DD                    mov     al,0DDh
F000:53F1  [+0x0D3F1]  E6 80                    out     80h,al
F000:53F3  [+0x0D3F3]  33 C9                    xor     cx,cx
F000:53F5  [+0x0D3F5]  E2 FE                    loop    53F5h
F000:53F7  [+0x0D3F7]  BB 04 00                 mov     bx,4
F000:53FA  [+0x0D3FA]  FC                       cld
F000:53FB  [+0x0D3FB]  33 C0                    xor     ax,ax
F000:53FD  [+0x0D3FD]  8E C0                    mov     es,ax
F000:53FF  [+0x0D3FF]  BF 00 00                 mov     di,0
F000:5402  [+0x0D402]  B9 00 80                 mov     cx,8000h
F000:5405  [+0x0D405]  F3 AB                    rep stosw
F000:5407  [+0x0D407]  4B                       dec     bx
F000:5408  [+0x0D408]  74 02                    je      short 540Ch
F000:540A  [+0x0D40A]  EB EE                    jmp     short 53FAh
F000:540C  [+0x0D40C]  BB 03 00                 mov     bx,3
F000:540F  [+0x0D40F]  B8 11 00                 mov     ax,11h
F000:5412  [+0x0D412]  E6 80                    out     80h,al
F000:5414  [+0x0D414]  33 C0                    xor     ax,ax
F000:5416  [+0x0D416]  BF 00 00                 mov     di,0
F000:5419  [+0x0D419]  B9 00 80                 mov     cx,8000h
F000:541C  [+0x0D41C]  F3 AF                    repe scasw
F000:541E  [+0x0D41E]  E3 0E                    jcxz    542Eh
F000:5420  [+0x0D420]  B8 66 00                 mov     ax,66h
F000:5423  [+0x0D423]  E6 80                    out     80h,al
F000:5425  [+0x0D425]  33 C0                    xor     ax,ax
F000:5427  [+0x0D427]  E7 8D                    out     8Dh,ax
F000:5429  [+0x0D429]  EA 5B E0 00 F0           jmp     0F000h:0E05Bh
F000:542E  [+0x0D42E]  75 F0                    jne     short 5420h
F000:5430  [+0x0D430]  4B                       dec     bx
F000:5431  [+0x0D431]  74 02                    je      short 5435h
F000:5433  [+0x0D433]  EB E1                    jmp     short 5416h
F000:5435  [+0x0D435]  B0 12                    mov     al,12h
F000:5437  [+0x0D437]  E6 80                    out     80h,al
F000:5439  [+0x0D439]  33 C0                    xor     ax,ax
F000:543B  [+0x0D43B]  8E C0                    mov     es,ax
F000:543D  [+0x0D43D]  BF 00 00                 mov     di,0
F000:5440  [+0x0D440]  B9 00 01                 mov     cx,100h
F000:5443  [+0x0D443]  B8 4E 54                 mov     ax,544Eh
F000:5446  [+0x0D446]  AB                       stosw
F000:5447  [+0x0D447]  8C C8                    mov     ax,cs
F000:5449  [+0x0D449]  AB                       stosw
F000:544A  [+0x0D44A]  E2 F7                    loop    5443h
F000:544C  [+0x0D44C]  EB 01                    jmp     short 544Fh
F000:544E  [+0x0D44E]  CF                       iret
F000:544F  [+0x0D44F]  FC                       cld
F000:5450  [+0x0D450]  B8 00 08                 mov     ax,800h
F000:5453  [+0x0D453]  8E D0                    mov     ss,ax
F000:5455  [+0x0D455]  BC 00 00                 mov     sp,0
F000:5458  [+0x0D458]  B8 00 00                 mov     ax,0
F000:545B  [+0x0D45B]  BB 00 00                 mov     bx,0
F000:545E  [+0x0D45E]  E8 89 BE                 call    12EAh
F000:5461  [+0x0D461]  EB 00                    jmp     short 5463h
F000:5463  [+0x0D463]  50                       push    ax
F000:5464  [+0x0D464]  B0 13                    mov     al,13h
F000:5466  [+0x0D466]  E6 80                    out     80h,al
F000:5468  [+0x0D468]  58                       pop     ax
F000:5469  [+0x0D469]  B8 00 C0                 mov     ax,0C000h
F000:546C  [+0x0D46C]  8E D8                    mov     ds,ax
F000:546E  [+0x0D46E]  33 DB                    xor     bx,bx
F000:5470  [+0x0D470]  81 3F 55 AA              cmp     word [bx],0AA55h
F000:5474  [+0x0D474]  75 07                    jne     short 547Dh
F000:5476  [+0x0D476]  9A 03 00 00 C0           call    0C000h:3
F000:547B  [+0x0D47B]  EB 1C                    jmp     short 5499h
F000:547D  [+0x0D47D]  B8 00 E0                 mov     ax,0E000h
F000:5480  [+0x0D480]  8E D8                    mov     ds,ax
F000:5482  [+0x0D482]  33 DB                    xor     bx,bx
F000:5484  [+0x0D484]  81 3F 55 AA              cmp     word [bx],0AA55h
F000:5488  [+0x0D488]  75 07                    jne     short 5491h
F000:548A  [+0x0D48A]  9A 03 00 00 E0           call    0E000h:3
F000:548F  [+0x0D48F]  EB 08                    jmp     short 5499h
F000:5491  [+0x0D491]  50                       push    ax
F000:5492  [+0x0D492]  B0 19                    mov     al,19h
F000:5494  [+0x0D494]  E6 80                    out     80h,al
F000:5496  [+0x0D496]  58                       pop     ax
F000:5497  [+0x0D497]  EB 8C                    jmp     short 5425h
F000:5499  [+0x0D499]  B0 22                    mov     al,22h
F000:549B  [+0x0D49B]  E6 80                    out     80h,al
F000:549D  [+0x0D49D]  B0 15                    mov     al,15h
F000:549F  [+0x0D49F]  E6 A0                    out     0A0h,al
F000:54A1  [+0x0D4A1]  E6 20                    out     20h,al
F000:54A3  [+0x0D4A3]  B0 70                    mov     al,70h
F000:54A5  [+0x0D4A5]  E6 A1                    out     0A1h,al
F000:54A7  [+0x0D4A7]  B0 08                    mov     al,8
F000:54A9  [+0x0D4A9]  E6 21                    out     21h,al
F000:54AB  [+0x0D4AB]  B0 02                    mov     al,2
F000:54AD  [+0x0D4AD]  E6 A1                    out     0A1h,al
F000:54AF  [+0x0D4AF]  B0 04                    mov     al,4
F000:54B1  [+0x0D4B1]  E6 21                    out     21h,al
F000:54B3  [+0x0D4B3]  B0 01                    mov     al,1
F000:54B5  [+0x0D4B5]  E6 A1                    out     0A1h,al
F000:54B7  [+0x0D4B7]  E6 21                    out     21h,al
F000:54B9  [+0x0D4B9]  B0 FF                    mov     al,0FFh
F000:54BB  [+0x0D4BB]  E6 21                    out     21h,al
F000:54BD  [+0x0D4BD]  E6 A1                    out     0A1h,al
F000:54BF  [+0x0D4BF]  FA                       cli
F000:54C0  [+0x0D4C0]  B8 07 02                 mov     ax,207h
F000:54C3  [+0x0D4C3]  BA 80 10                 mov     dx,1080h
F000:54C6  [+0x0D4C6]  E8 6F BE                 call    1338h
F000:54C9  [+0x0D4C9]  B8 00 F0                 mov     ax,0F000h
F000:54CC  [+0x0D4CC]  8E D8                    mov     ds,ax
F000:54CE  [+0x0D4CE]  8E C0                    mov     es,ax
F000:54D0  [+0x0D4D0]  33 FF                    xor     di,di
F000:54D2  [+0x0D4D2]  8B F7                    mov     si,di
F000:54D4  [+0x0D4D4]  B9 00 80                 mov     cx,8000h
F000:54D7  [+0x0D4D7]  F3 A5                    rep movsw
F000:54D9  [+0x0D4D9]  B8 00 DC                 mov     ax,0DC00h
F000:54DC  [+0x0D4DC]  8E D8                    mov     ds,ax
F000:54DE  [+0x0D4DE]  8E C0                    mov     es,ax
F000:54E0  [+0x0D4E0]  33 FF                    xor     di,di
F000:54E2  [+0x0D4E2]  8B F7                    mov     si,di
F000:54E4  [+0x0D4E4]  B9 00 20                 mov     cx,2000h
F000:54E7  [+0x0D4E7]  F3 A5                    rep movsw
F000:54E9  [+0x0D4E9]  B8 00 02                 mov     ax,200h
F000:54EC  [+0x0D4EC]  BA 80 10                 mov     dx,1080h
F000:54EF  [+0x0D4EF]  E8 46 BE                 call    1338h
F000:54F2  [+0x0D4F2]  BB 00 02                 mov     bx,200h
F000:54F5  [+0x0D4F5]  BA F7 01                 mov     dx,1F7h
F000:54F8  [+0x0D4F8]  EC                       in      al,dx
F000:54F9  [+0x0D4F9]  E6 80                    out     80h,al
F000:54FB  [+0x0D4FB]  3C 50                    cmp     al,50h
F000:54FD  [+0x0D4FD]  74 03                    je      short 5502h
F000:54FF  [+0x0D4FF]  4B                       dec     bx
F000:5500  [+0x0D500]  75 F0                    jne     short 54F2h
F000:5502  [+0x0D502]  B0 33                    mov     al,33h
F000:5504  [+0x0D504]  E6 80                    out     80h,al
F000:5506  [+0x0D506]  B8 78 56                 mov     ax,5678h
F000:5509  [+0x0D509]  E7 8D                    out     8Dh,ax
F000:550B  [+0x0D50B]  EA 5B E0 00 F0           jmp     0F000h:0E05Bh
F000:5510  [+0x0D510]  B0 55                    mov     al,55h
F000:5512  [+0x0D512]  E6 80                    out     80h,al
F000:5514  [+0x0D514]  9A 10 00 00 E8           call    0E800h:0010h
F000:5519  [+0x0D519]  B0 13                    mov     al,13h
F000:551B  [+0x0D51B]  E6 80                    out     80h,al
F000:551D  [+0x0D51D]  E9 05 FF                 jmp     5425h
F000:5520  [+0x0D520]  01 02                    add     [bp+si],ax
F000:5522  [+0x0D522]  02 02                    add     al,[bp+si]
F000:5524  [+0x0D524]  03 02                    add     ax,[bp+si]
F000:5526  [+0x0D526]  04 02                    add     al,2
F000:5528  [+0x0D528]  05 02 06                 add     ax,602h
F000:552B  [+0x0D52B]  02 50 1E                 add     dl,[bx+si+1Eh]
F000:552E  [+0x0D52E]  B8 80 DF                 mov     ax,0DF80h
F000:5531  [+0x0D531]  8E D8                    mov     ds,ax
F000:5533  [+0x0D533]  80 3E 30 00 00           cmp     byte [30h],0
F000:5538  [+0x0D538]  1F                       pop     ds
F000:5539  [+0x0D539]  58                       pop     ax
F000:553A  [+0x0D53A]  C3                       ret
F000:553B  [+0x0D53B]  06                       push    es
F000:553C  [+0x0D53C]  51                       push    cx
F000:553D  [+0x0D53D]  57                       push    di
F000:553E  [+0x0D53E]  B8 00 DC                 mov     ax,0DC00h
F000:5541  [+0x0D541]  8E C0                    mov     es,ax
F000:5543  [+0x0D543]  33 C0                    xor     ax,ax
F000:5545  [+0x0D545]  B9 3C 00                 mov     cx,3Ch
F000:5548  [+0x0D548]  BF 94 14                 mov     di,1494h
F000:554B  [+0x0D54B]  F3 AB                    rep stosw
F000:554D  [+0x0D54D]  1E                       push    ds
F000:554E  [+0x0D54E]  B8 40 00                 mov     ax,40h
F000:5551  [+0x0D551]  8E D8                    mov     ds,ax
F000:5553  [+0x0D553]  A1 10 00                 mov     ax,[10h]
F000:5556  [+0x0D556]  1F                       pop     ds
F000:5557  [+0x0D557]  A3 92 14                 mov     [1492h],ax
F000:555A  [+0x0D55A]  5F                       pop     di
F000:555B  [+0x0D55B]  59                       pop     cx
F000:555C  [+0x0D55C]  07                       pop     es
F000:555D  [+0x0D55D]  C3                       ret
F000:555E  [+0x0D55E]  F7 06 92 14 02 00        test    word [1492h],2
F000:5564  [+0x0D564]  74 05                    je      short 556Bh
F000:5566  [+0x0D566]  9B                       wait
F000:5567  [+0x0D567]  DD 36 94 14              fnsave  [1494h]
F000:556B  [+0x0D56B]  C3                       ret
F000:556C  [+0x0D56C]  F7 06 92 14 02 00        test    word [1492h],2
F000:5572  [+0x0D572]  74 0C                    je      short 5580h
F000:5574  [+0x0D574]  EB 00                    jmp     short 5576h
F000:5576  [+0x0D576]  E6 F0                    out     0F0h,al
F000:5578  [+0x0D578]  E8 C6 CA                 call    2041h
F000:557B  [+0x0D57B]  9B                       wait
F000:557C  [+0x0D57C]  DD 26 94 14              frstor  [1494h]
F000:5580  [+0x0D580]  C3                       ret
F000:5581  [+0x0D581]  9C                       pushf
F000:5582  [+0x0D582]  52                       push    dx
F000:5583  [+0x0D583]  FA                       cli
F000:5584  [+0x0D584]  8A C2                    mov     al,dl
F000:5586  [+0x0D586]  E6 70                    out     70h,al
F000:5588  [+0x0D588]  EB 00                    jmp     short 558Ah
F000:558A  [+0x0D58A]  E4 71                    in      al,71h
F000:558C  [+0x0D58C]  22 C6                    and     al,dh
F000:558E  [+0x0D58E]  74 08                    je      short 5598h
F000:5590  [+0x0D590]  D0 EE                    shr     dh,1
F000:5592  [+0x0D592]  72 04                    jb      short 5598h
F000:5594  [+0x0D594]  D0 E8                    shr     al,1
F000:5596  [+0x0D596]  EB F8                    jmp     short 5590h
F000:5598  [+0x0D598]  5A                       pop     dx
F000:5599  [+0x0D599]  9D                       popf
F000:559A  [+0x0D59A]  0A C0                    or      al,al
F000:559C  [+0x0D59C]  C3                       ret
F000:559D  [+0x0D59D]  9C                       pushf
F000:559E  [+0x0D59E]  50                       push    ax
F000:559F  [+0x0D59F]  52                       push    dx
F000:55A0  [+0x0D5A0]  FA                       cli
F000:55A1  [+0x0D5A1]  0A F6                    or      dh,dh
F000:55A3  [+0x0D5A3]  74 28                    je      short 55CDh
F000:55A5  [+0x0D5A5]  8A E6                    mov     ah,dh
F000:55A7  [+0x0D5A7]  D0 EE                    shr     dh,1
F000:55A9  [+0x0D5A9]  72 04                    jb      short 55AFh
F000:55AB  [+0x0D5AB]  D0 E0                    shl     al,1
F000:55AD  [+0x0D5AD]  EB F8                    jmp     short 55A7h
F000:55AF  [+0x0D5AF]  8A F4                    mov     dh,ah
F000:55B1  [+0x0D5B1]  8A E0                    mov     ah,al
F000:55B3  [+0x0D5B3]  22 E6                    and     ah,dh
F000:55B5  [+0x0D5B5]  8A C2                    mov     al,dl
F000:55B7  [+0x0D5B7]  E6 70                    out     70h,al
F000:55B9  [+0x0D5B9]  EB 00                    jmp     short 55BBh
F000:55BB  [+0x0D5BB]  E4 71                    in      al,71h
F000:55BD  [+0x0D5BD]  F6 D6                    not     dh
F000:55BF  [+0x0D5BF]  22 C6                    and     al,dh
F000:55C1  [+0x0D5C1]  0A E0                    or      ah,al
F000:55C3  [+0x0D5C3]  8A C2                    mov     al,dl
F000:55C5  [+0x0D5C5]  E6 70                    out     70h,al
F000:55C7  [+0x0D5C7]  EB 00                    jmp     short 55C9h
F000:55C9  [+0x0D5C9]  8A C4                    mov     al,ah
F000:55CB  [+0x0D5CB]  E6 71                    out     71h,al
F000:55CD  [+0x0D5CD]  5A                       pop     dx
F000:55CE  [+0x0D5CE]  58                       pop     ax
F000:55CF  [+0x0D5CF]  9D                       popf
F000:55D0  [+0x0D5D0]  C3                       ret
F000:55D1  [+0x0D5D1]  50                       push    ax
F000:55D2  [+0x0D5D2]  53                       push    bx
F000:55D3  [+0x0D5D3]  33 DB                    xor     bx,bx
F000:55D5  [+0x0D5D5]  B0 40                    mov     al,40h
F000:55D7  [+0x0D5D7]  E8 12 CA                 call    1FECh
F000:55DA  [+0x0D5DA]  02 DC                    add     bl,ah
F000:55DC  [+0x0D5DC]  80 D7 00                 adc     bh,0
F000:55DF  [+0x0D5DF]  FE C0                    inc     al
F000:55E1  [+0x0D5E1]  3C 7D                    cmp     al,7Dh
F000:55E3  [+0x0D5E3]  76 F2                    jbe     short 55D7h
F000:55E5  [+0x0D5E5]  B0 7E                    mov     al,7Eh
F000:55E7  [+0x0D5E7]  8A E7                    mov     ah,bh
F000:55E9  [+0x0D5E9]  E8 12 CA                 call    1FFEh
F000:55EC  [+0x0D5EC]  B0 7F                    mov     al,7Fh
F000:55EE  [+0x0D5EE]  8A E3                    mov     ah,bl
F000:55F0  [+0x0D5F0]  E8 0B CA                 call    1FFEh
F000:55F3  [+0x0D5F3]  5B                       pop     bx
F000:55F4  [+0x0D5F4]  58                       pop     ax
F000:55F5  [+0x0D5F5]  C3                       ret
F000:55F6  [+0x0D5F6]  50                       push    ax
F000:55F7  [+0x0D5F7]  E4 61                    in      al,61h
F000:55F9  [+0x0D5F9]  A2 0C 15                 mov     [150Ch],al
F000:55FC  [+0x0D5FC]  58                       pop     ax
F000:55FD  [+0x0D5FD]  C3                       ret
F000:55FE  [+0x0D5FE]  50                       push    ax
F000:55FF  [+0x0D5FF]  A0 0C 15                 mov     al,[150Ch]
F000:5602  [+0x0D602]  E6 61                    out     61h,al
F000:5604  [+0x0D604]  58                       pop     ax
F000:5605  [+0x0D605]  C3                       ret
F000:5606  [+0x0D606]  50                       push    ax
F000:5607  [+0x0D607]  E4 61                    in      al,61h
F000:5609  [+0x0D609]  24 FC                    and     al,0FCh
F000:560B  [+0x0D60B]  E6 61                    out     61h,al
F000:560D  [+0x0D60D]  58                       pop     ax
F000:560E  [+0x0D60E]  C3                       ret
F000:560F  [+0x0D60F]  F8                       clc
F000:5610  [+0x0D610]  C3                       ret
F000:5611  [+0x0D611]  50                       push    ax
F000:5612  [+0x0D612]  52                       push    dx
F000:5613  [+0x0D613]  BA 41 08                 mov     dx,841h
F000:5616  [+0x0D616]  E8 68 FF                 call    5581h
F000:5619  [+0x0D619]  A2 0D 15                 mov     [150Dh],al
F000:561C  [+0x0D61C]  E8 E8 FB                 call    5207h
F000:561F  [+0x0D61F]  5A                       pop     dx
F000:5620  [+0x0D620]  58                       pop     ax
F000:5621  [+0x0D621]  C3                       ret
F000:5622  [+0x0D622]  50                       push    ax
F000:5623  [+0x0D623]  52                       push    dx
F000:5624  [+0x0D624]  BA 41 08                 mov     dx,841h
F000:5627  [+0x0D627]  A0 0D 15                 mov     al,[150Dh]
F000:562A  [+0x0D62A]  E8 70 FF                 call    559Dh
F000:562D  [+0x0D62D]  E8 A1 FF                 call    55D1h
F000:5630  [+0x0D630]  5A                       pop     dx
F000:5631  [+0x0D631]  58                       pop     ax
F000:5632  [+0x0D632]  C3                       ret
F000:5633  [+0x0D633]  52                       push    dx
F000:5634  [+0x0D634]  BA 58 80                 mov     dx,8058h
F000:5637  [+0x0D637]  E8 47 FF                 call    5581h
F000:563A  [+0x0D63A]  5A                       pop     dx
F000:563B  [+0x0D63B]  C3                       ret
F000:563C  [+0x0D63C]  50                       push    ax
F000:563D  [+0x0D63D]  52                       push    dx
F000:563E  [+0x0D63E]  BA 58 80                 mov     dx,8058h
F000:5641  [+0x0D641]  E8 59 FF                 call    559Dh
F000:5644  [+0x0D644]  E8 8A FF                 call    55D1h
F000:5647  [+0x0D647]  5A                       pop     dx
F000:5648  [+0x0D648]  58                       pop     ax
F000:5649  [+0x0D649]  C3                       ret
F000:564A  [+0x0D64A]  50                       push    ax
F000:564B  [+0x0D64B]  53                       push    bx
F000:564C  [+0x0D64C]  1E                       push    ds
F000:564D  [+0x0D64D]  33 C0                    xor     ax,ax
F000:564F  [+0x0D64F]  8E D8                    mov     ds,ax
F000:5651  [+0x0D651]  BB 4C 00                 mov     bx,4Ch
F000:5654  [+0x0D654]  C7 07 FE E3              mov     word [bx],0E3FEh
F000:5658  [+0x0D658]  C7 47 02 00 F0           mov     word [bx+2],0F000h
F000:565D  [+0x0D65D]  BB 54 00                 mov     bx,54h
F000:5660  [+0x0D660]  C7 07 59 F8              mov     word [bx],0F859h
F000:5664  [+0x0D664]  C7 47 02 00 F0           mov     word [bx+2],0F000h
F000:5669  [+0x0D669]  BB D8 01                 mov     bx,1D8h
F000:566C  [+0x0D66C]  C7 07 A0 5B              mov     word [bx],5BA0h
F000:5670  [+0x0D670]  8C 4F 02                 mov     [bx+2],cs
F000:5673  [+0x0D673]  E8 E9 FC                 call    535Fh
F000:5676  [+0x0D676]  E8 0B 00                 call    5684h
F000:5679  [+0x0D679]  0F 82 18 05              jb      near 5B95h
F000:567D  [+0x0D67D]  E8 C6 04                 call    5B46h
F000:5680  [+0x0D680]  1F                       pop     ds
F000:5681  [+0x0D681]  5B                       pop     bx
F000:5682  [+0x0D682]  58                       pop     ax
F000:5683  [+0x0D683]  C3                       ret
F000:5684  [+0x0D684]  66 50                    push    eax
F000:5686  [+0x0D686]  58                       pop     ax
F000:5687  [+0x0D687]  53                       push    bx
F000:5688  [+0x0D688]  51                       push    cx
F000:5689  [+0x0D689]  52                       push    dx
F000:568A  [+0x0D68A]  66 56                    push    esi
F000:568C  [+0x0D68C]  1E                       push    ds
F000:568D  [+0x0D68D]  06                       push    es
F000:568E  [+0x0D68E]  33 C0                    xor     ax,ax
F000:5690  [+0x0D690]  8E D8                    mov     ds,ax
F000:5692  [+0x0D692]  E8 A3 00                 call    5738h
F000:5695  [+0x0D695]  BA 80 00                 mov     dx,80h
F000:5698  [+0x0D698]  B8 01 00                 mov     ax,1
F000:569B  [+0x0D69B]  0F 82 87 00              jb      near 5726h
F000:569F  [+0x0D69F]  8C D0                    mov     ax,ss
F000:56A1  [+0x0D6A1]  8E C0                    mov     es,ax
F000:56A3  [+0x0D6A3]  BB 8D 00                 mov     bx,8Dh
F000:56A6  [+0x0D6A6]  B8 01 02                 mov     ax,201h
F000:56A9  [+0x0D6A9]  B9 01 00                 mov     cx,1
F000:56AC  [+0x0D6AC]  CD 13                    int     13h
F000:56AE  [+0x0D6AE]  B8 02 00                 mov     ax,2
F000:56B1  [+0x0D6B1]  72 73                    jb      short 5726h
F000:56B3  [+0x0D6B3]  26 81 BF FE 01 55 AA     cmp     word [es:bx+1FEh],0AA55h
F000:56BA  [+0x0D6BA]  B8 04 00                 mov     ax,4
F000:56BD  [+0x0D6BD]  75 03                    jne     short 56C2h
F000:56BF  [+0x0D6BF]  EB 04                    jmp     short 56C5h
F000:56C1  [+0x0D6C1]  90                       nop
F000:56C2  [+0x0D6C2]  F9                       stc
F000:56C3  [+0x0D6C3]  EB 61                    jmp     short 5726h
F000:56C5  [+0x0D6C5]  B9 04 00                 mov     cx,4
F000:56C8  [+0x0D6C8]  8D B7 AE 01              lea     si,[bx+1AEh]
F000:56CC  [+0x0D6CC]  83 C6 10                 add     si,10h
F000:56CF  [+0x0D6CF]  26 80 7C 04 A0           cmp     byte [es:si+4],0A0h
F000:56D4  [+0x0D6D4]  E0 F6                    loopne  56CCh
F000:56D6  [+0x0D6D6]  B8 05 00                 mov     ax,5
F000:56D9  [+0x0D6D9]  75 E7                    jne     short 56C2h
F000:56DB  [+0x0D6DB]  26 66 8B 44 08           mov     eax,[es:si+8]
F000:56E0  [+0x0D6E0]  36 66 A3 50 00           mov     [ss:50h],eax
F000:56E5  [+0x0D6E5]  26 66 8B 44 0C           mov     eax,[es:si+0Ch]
F000:56EA  [+0x0D6EA]  36 66 A3 58 00           mov     [ss:58h],eax
F000:56EF  [+0x0D6EF]  33 C0                    xor     ax,ax
F000:56F1  [+0x0D6F1]  C5 36 04 01              lds     si,[104h]
F000:56F5  [+0x0D6F5]  8A 44 02                 mov     al,[si+2]
F000:56F8  [+0x0D6F8]  36 A3 54 00              mov     [ss:54h],ax
F000:56FC  [+0x0D6FC]  8A 44 0E                 mov     al,[si+0Eh]
F000:56FF  [+0x0D6FF]  36 A3 56 00              mov     [ss:56h],ax
F000:5703  [+0x0D703]  66 33 F6                 xor     esi,esi
F000:5706  [+0x0D706]  E8 C0 03                 call    5AC9h
F000:5709  [+0x0D709]  B8 01 02                 mov     ax,201h
F000:570C  [+0x0D70C]  CD 13                    int     13h
F000:570E  [+0x0D70E]  72 05                    jb      short 5715h
F000:5710  [+0x0D710]  E8 E9 03                 call    5AFCh
F000:5713  [+0x0D713]  73 11                    jae     short 5726h
F000:5715  [+0x0D715]  46                       inc     si
F000:5716  [+0x0D716]  E8 B0 03                 call    5AC9h
F000:5719  [+0x0D719]  B8 01 02                 mov     ax,201h
F000:571C  [+0x0D71C]  CD 13                    int     13h
F000:571E  [+0x0D71E]  B8 02 00                 mov     ax,2
F000:5721  [+0x0D721]  72 03                    jb      short 5726h
F000:5723  [+0x0D723]  E8 D6 03                 call    5AFCh
F000:5726  [+0x0D726]  0F 83 03 00              jae     near 572Dh
F000:572A  [+0x0D72A]  E8 74 00                 call    57A1h
F000:572D  [+0x0D72D]  07                       pop     es
F000:572E  [+0x0D72E]  1F                       pop     ds
F000:572F  [+0x0D72F]  66 5E                    pop     esi
F000:5731  [+0x0D731]  5A                       pop     dx
F000:5732  [+0x0D732]  59                       pop     cx
F000:5733  [+0x0D733]  5B                       pop     bx
F000:5734  [+0x0D734]  50                       push    ax
F000:5735  [+0x0D735]  66 58                    pop     eax
F000:5737  [+0x0D737]  C3                       ret
F000:5738  [+0x0D738]  60                       pusha
F000:5739  [+0x0D739]  FA                       cli
F000:573A  [+0x0D73A]  E4 A1                    in      al,0A1h
F000:573C  [+0x0D73C]  EB 00                    jmp     short 573Eh
F000:573E  [+0x0D73E]  24 BF                    and     al,0BFh
F000:5740  [+0x0D740]  E6 A1                    out     0A1h,al
F000:5742  [+0x0D742]  E4 21                    in      al,21h
F000:5744  [+0x0D744]  24 FB                    and     al,0FBh
F000:5746  [+0x0D746]  E6 21                    out     21h,al
F000:5748  [+0x0D748]  FB                       sti
F000:5749  [+0x0D749]  BA F6 03                 mov     dx,3F6h
F000:574C  [+0x0D74C]  B0 04                    mov     al,4
F000:574E  [+0x0D74E]  EE                       out     dx,al
F000:574F  [+0x0D74F]  33 C9                    xor     cx,cx
F000:5751  [+0x0D751]  E2 FE                    loop    5751h
F000:5753  [+0x0D753]  BA F6 03                 mov     dx,3F6h
F000:5756  [+0x0D756]  32 C0                    xor     al,al
F000:5758  [+0x0D758]  EE                       out     dx,al
F000:5759  [+0x0D759]  90                       nop
F000:575A  [+0x0D75A]  33 C9                    xor     cx,cx
F000:575C  [+0x0D75C]  E2 FE                    loop    575Ch
F000:575E  [+0x0D75E]  B4 09                    mov     ah,9
F000:5760  [+0x0D760]  BA 80 00                 mov     dx,80h
F000:5763  [+0x0D763]  CD 13                    int     13h
F000:5765  [+0x0D765]  0F 83 17 00              jae     near 5780h
F000:5769  [+0x0D769]  9C                       pushf
F000:576A  [+0x0D76A]  B0 AA                    mov     al,0AAh
F000:576C  [+0x0D76C]  E6 80                    out     80h,al
F000:576E  [+0x0D76E]  B8 55 00                 mov     ax,55h
F000:5771  [+0x0D771]  33 C9                    xor     cx,cx
F000:5773  [+0x0D773]  E2 FE                    loop    5773h
F000:5775  [+0x0D775]  48                       dec     ax
F000:5776  [+0x0D776]  0F 84 02 00              je      near 577Ch
F000:577A  [+0x0D77A]  EB F7                    jmp     short 5773h
F000:577C  [+0x0D77C]  9D                       popf
F000:577D  [+0x0D77D]  EB 20                    jmp     short 579Fh
F000:577F  [+0x0D77F]  90                       nop
F000:5780  [+0x0D780]  B4 11                    mov     ah,11h
F000:5782  [+0x0D782]  BA 80 00                 mov     dx,80h
F000:5785  [+0x0D785]  CD 13                    int     13h
F000:5787  [+0x0D787]  0F 83 14 00              jae     near 579Fh
F000:578B  [+0x0D78B]  9C                       pushf
F000:578C  [+0x0D78C]  B0 BB                    mov     al,0BBh
F000:578E  [+0x0D78E]  E6 80                    out     80h,al
F000:5790  [+0x0D790]  B8 55 00                 mov     ax,55h
F000:5793  [+0x0D793]  33 C9                    xor     cx,cx
F000:5795  [+0x0D795]  E2 FE                    loop    5795h
F000:5797  [+0x0D797]  48                       dec     ax
F000:5798  [+0x0D798]  0F 84 02 00              je      near 579Eh
F000:579C  [+0x0D79C]  EB F7                    jmp     short 5795h
F000:579E  [+0x0D79E]  9D                       popf
F000:579F  [+0x0D79F]  61                       popa
F000:57A0  [+0x0D7A0]  C3                       ret
F000:57A1  [+0x0D7A1]  1E                       push    ds
F000:57A2  [+0x0D7A2]  06                       push    es
F000:57A3  [+0x0D7A3]  53                       push    bx
F000:57A4  [+0x0D7A4]  51                       push    cx
F000:57A5  [+0x0D7A5]  52                       push    dx
F000:57A6  [+0x0D7A6]  66 56                    push    esi
F000:57A8  [+0x0D7A8]  8C D0                    mov     ax,ss
F000:57AA  [+0x0D7AA]  8E C0                    mov     es,ax
F000:57AC  [+0x0D7AC]  8E D8                    mov     ds,ax
F000:57AE  [+0x0D7AE]  E4 80                    in      al,80h
F000:57B0  [+0x0D7B0]  36 A2 84 00              mov     [ss:84h],al
F000:57B4  [+0x0D7B4]  1E                       push    ds
F000:57B5  [+0x0D7B5]  33 C0                    xor     ax,ax
F000:57B7  [+0x0D7B7]  8E D8                    mov     ds,ax
F000:57B9  [+0x0D7B9]  C5 36 04 01              lds     si,[104h]
F000:57BD  [+0x0D7BD]  8A 44 02                 mov     al,[si+2]
F000:57C0  [+0x0D7C0]  36 A3 54 00              mov     [ss:54h],ax
F000:57C4  [+0x0D7C4]  8A 44 0E                 mov     al,[si+0Eh]
F000:57C7  [+0x0D7C7]  36 A3 56 00              mov     [ss:56h],ax
F000:57CB  [+0x0D7CB]  1F                       pop     ds
F000:57CC  [+0x0D7CC]  BB 8D 00                 mov     bx,8Dh
F000:57CF  [+0x0D7CF]  B8 01 02                 mov     ax,201h
F000:57D2  [+0x0D7D2]  BA 80 00                 mov     dx,80h
F000:57D5  [+0x0D7D5]  B9 01 00                 mov     cx,1
F000:57D8  [+0x0D7D8]  CD 13                    int     13h
F000:57DA  [+0x0D7DA]  73 0B                    jae     short 57E7h
F000:57DC  [+0x0D7DC]  B0 11                    mov     al,11h
F000:57DE  [+0x0D7DE]  E8 CC 01                 call    59ADh
F000:57E1  [+0x0D7E1]  B8 02 00                 mov     ax,2
F000:57E4  [+0x0D7E4]  E9 09 01                 jmp     58F0h
F000:57E7  [+0x0D7E7]  26 81 BF FE 01 55 AA     cmp     word [es:bx+1FEh],0AA55h
F000:57EE  [+0x0D7EE]  0F 84 0B 00              je      near 57FDh
F000:57F2  [+0x0D7F2]  B0 22                    mov     al,22h
F000:57F4  [+0x0D7F4]  E8 B6 01                 call    59ADh
F000:57F7  [+0x0D7F7]  B8 04 00                 mov     ax,4
F000:57FA  [+0x0D7FA]  E9 F3 00                 jmp     58F0h
F000:57FD  [+0x0D7FD]  B9 04 00                 mov     cx,4
F000:5800  [+0x0D800]  BE 4B 02                 mov     si,24Bh
F000:5803  [+0x0D803]  8A 04                    mov     al,[si]
F000:5805  [+0x0D805]  3C 80                    cmp     al,80h
F000:5807  [+0x0D807]  0F 84 10 00              je      near 581Bh
F000:580B  [+0x0D80B]  83 C6 10                 add     si,10h
F000:580E  [+0x0D80E]  E2 F3                    loop    5803h
F000:5810  [+0x0D810]  B0 33                    mov     al,33h
F000:5812  [+0x0D812]  E8 98 01                 call    59ADh
F000:5815  [+0x0D815]  B8 04 00                 mov     ax,4
F000:5818  [+0x0D818]  E9 D5 00                 jmp     58F0h
F000:581B  [+0x0D81B]  66 8B 44 08              mov     eax,[si+8]
F000:581F  [+0x0D81F]  36 66 A3 50 00           mov     [ss:50h],eax
F000:5824  [+0x0D824]  B8 01 02                 mov     ax,201h
F000:5827  [+0x0D827]  BB 8D 00                 mov     bx,8Dh
F000:582A  [+0x0D82A]  8A 6C 03                 mov     ch,[si+3]
F000:582D  [+0x0D82D]  8A 4C 02                 mov     cl,[si+2]
F000:5830  [+0x0D830]  8A 74 01                 mov     dh,[si+1]
F000:5833  [+0x0D833]  B2 80                    mov     dl,80h
F000:5835  [+0x0D835]  CD 13                    int     13h
F000:5837  [+0x0D837]  73 0B                    jae     short 5844h
F000:5839  [+0x0D839]  B0 33                    mov     al,33h
F000:583B  [+0x0D83B]  E8 6F 01                 call    59ADh
F000:583E  [+0x0D83E]  B8 04 00                 mov     ax,4
F000:5841  [+0x0D841]  E9 AC 00                 jmp     58F0h
F000:5844  [+0x0D844]  BE 98 00                 mov     si,98h
F000:5847  [+0x0D847]  BF 5C 00                 mov     di,5Ch
F000:584A  [+0x0D84A]  B9 28 00                 mov     cx,28h
F000:584D  [+0x0D84D]  F3 A4                    rep movsb
F000:584F  [+0x0D84F]  66 33 C0                 xor     eax,eax
F000:5852  [+0x0D852]  36 8B 1E 5F 00           mov     bx,[ss:5Fh]
F000:5857  [+0x0D857]  36 A0 61 00              mov     al,[ss:61h]
F000:585B  [+0x0D85B]  36 8B 0E 67 00           mov     cx,[ss:67h]
F000:5860  [+0x0D860]  F7 E1                    mul     cx
F000:5862  [+0x0D862]  03 C3                    add     ax,bx
F000:5864  [+0x0D864]  36 66 A3 85 00           mov     [ss:85h],eax
F000:5869  [+0x0D869]  B9 20 00                 mov     cx,20h
F000:586C  [+0x0D86C]  36 A1 62 00              mov     ax,[ss:62h]
F000:5870  [+0x0D870]  F7 E1                    mul     cx
F000:5872  [+0x0D872]  BB 00 02                 mov     bx,200h
F000:5875  [+0x0D875]  F7 F3                    div     bx
F000:5877  [+0x0D877]  83 FA 00                 cmp     dx,0
F000:587A  [+0x0D87A]  0F 84 01 00              je      near 587Fh
F000:587E  [+0x0D87E]  40                       inc     ax
F000:587F  [+0x0D87F]  36 A3 89 00              mov     [ss:89h],ax
F000:5883  [+0x0D883]  36 A3 8B 00              mov     [ss:8Bh],ax
F000:5887  [+0x0D887]  BB 8D 00                 mov     bx,8Dh
F000:588A  [+0x0D88A]  36 66 8B 36 85 00        mov     esi,[ss:85h]
F000:5890  [+0x0D890]  E8 36 02                 call    5AC9h
F000:5893  [+0x0D893]  B8 01 02                 mov     ax,201h
F000:5896  [+0x0D896]  B2 80                    mov     dl,80h
F000:5898  [+0x0D898]  CD 13                    int     13h
F000:589A  [+0x0D89A]  73 0A                    jae     short 58A6h
F000:589C  [+0x0D89C]  B0 55                    mov     al,55h
F000:589E  [+0x0D89E]  E8 0C 01                 call    59ADh
F000:58A1  [+0x0D8A1]  B8 04 00                 mov     ax,4
F000:58A4  [+0x0D8A4]  EB 4A                    jmp     short 58F0h
F000:58A6  [+0x0D8A6]  E8 57 00                 call    5900h
F000:58A9  [+0x0D8A9]  0F 84 17 00              je      near 58C4h
F000:58AD  [+0x0D8AD]  36 66 FF 06 85 00        inc     dword [ss:85h]
F000:58B3  [+0x0D8B3]  36 FF 0E 8B 00           dec     word [ss:8Bh]
F000:58B8  [+0x0D8B8]  75 CD                    jne     short 5887h
F000:58BA  [+0x0D8BA]  B0 66                    mov     al,66h
F000:58BC  [+0x0D8BC]  E8 EE 00                 call    59ADh
F000:58BF  [+0x0D8BF]  B8 04 00                 mov     ax,4
F000:58C2  [+0x0D8C2]  EB 2C                    jmp     short 58F0h
F000:58C4  [+0x0D8C4]  BB 8D 00                 mov     bx,8Dh
F000:58C7  [+0x0D8C7]  66 33 F6                 xor     esi,esi
F000:58CA  [+0x0D8CA]  B2 80                    mov     dl,80h
F000:58CC  [+0x0D8CC]  E8 FA 01                 call    5AC9h
F000:58CF  [+0x0D8CF]  B8 01 02                 mov     ax,201h
F000:58D2  [+0x0D8D2]  CD 13                    int     13h
F000:58D4  [+0x0D8D4]  72 05                    jb      short 58DBh
F000:58D6  [+0x0D8D6]  E8 23 02                 call    5AFCh
F000:58D9  [+0x0D8D9]  73 15                    jae     short 58F0h
F000:58DB  [+0x0D8DB]  46                       inc     si
F000:58DC  [+0x0D8DC]  E8 EA 01                 call    5AC9h
F000:58DF  [+0x0D8DF]  B8 01 02                 mov     ax,201h
F000:58E2  [+0x0D8E2]  CD 13                    int     13h
F000:58E4  [+0x0D8E4]  0F 83 08 00              jae     near 58F0h
F000:58E8  [+0x0D8E8]  B0 77                    mov     al,77h
F000:58EA  [+0x0D8EA]  E8 C0 00                 call    59ADh
F000:58ED  [+0x0D8ED]  B8 02 00                 mov     ax,2
F000:58F0  [+0x0D8F0]  50                       push    ax
F000:58F1  [+0x0D8F1]  36 A0 84 00              mov     al,[ss:84h]
F000:58F5  [+0x0D8F5]  E6 80                    out     80h,al
F000:58F7  [+0x0D8F7]  58                       pop     ax
F000:58F8  [+0x0D8F8]  66 5E                    pop     esi
F000:58FA  [+0x0D8FA]  5A                       pop     dx
F000:58FB  [+0x0D8FB]  59                       pop     cx
F000:58FC  [+0x0D8FC]  5B                       pop     bx
F000:58FD  [+0x0D8FD]  07                       pop     es
F000:58FE  [+0x0D8FE]  1F                       pop     ds
F000:58FF  [+0x0D8FF]  C3                       ret
F000:5900  [+0x0D900]  66 50                    push    eax
F000:5902  [+0x0D902]  66 53                    push    ebx
F000:5904  [+0x0D904]  51                       push    cx
F000:5905  [+0x0D905]  B9 10 00                 mov     cx,10h
F000:5908  [+0x0D908]  B0 53                    mov     al,53h
F000:590A  [+0x0D90A]  B4 41                    mov     ah,41h
F000:590C  [+0x0D90C]  3B 07                    cmp     ax,[bx]
F000:590E  [+0x0D90E]  0F 84 08 00              je      near 591Ah
F000:5912  [+0x0D912]  83 C3 20                 add     bx,20h
F000:5915  [+0x0D915]  E2 F1                    loop    5908h
F000:5917  [+0x0D917]  EB 4A                    jmp     short 5963h
F000:5919  [+0x0D919]  90                       nop
F000:591A  [+0x0D91A]  B0 56                    mov     al,56h
F000:591C  [+0x0D91C]  B4 45                    mov     ah,45h
F000:591E  [+0x0D91E]  3B 47 02                 cmp     ax,[bx+2]
F000:5921  [+0x0D921]  0F 84 08 00              je      near 592Dh
F000:5925  [+0x0D925]  83 C3 20                 add     bx,20h
F000:5928  [+0x0D928]  E2 DE                    loop    5908h
F000:592A  [+0x0D92A]  EB 37                    jmp     short 5963h
F000:592C  [+0x0D92C]  90                       nop
F000:592D  [+0x0D92D]  B0 32                    mov     al,32h
F000:592F  [+0x0D92F]  B4 44                    mov     ah,44h
F000:5931  [+0x0D931]  3B 47 04                 cmp     ax,[bx+4]
F000:5934  [+0x0D934]  0F 84 08 00              je      near 5940h
F000:5938  [+0x0D938]  83 C3 20                 add     bx,20h
F000:593B  [+0x0D93B]  E2 CB                    loop    5908h
F000:593D  [+0x0D93D]  EB 24                    jmp     short 5963h
F000:593F  [+0x0D93F]  90                       nop
F000:5940  [+0x0D940]  B0 53                    mov     al,53h
F000:5942  [+0x0D942]  B4 4B                    mov     ah,4Bh
F000:5944  [+0x0D944]  3B 47 06                 cmp     ax,[bx+6]
F000:5947  [+0x0D947]  0F 84 08 00              je      near 5953h
F000:594B  [+0x0D94B]  83 C3 20                 add     bx,20h
F000:594E  [+0x0D94E]  E2 B8                    loop    5908h
F000:5950  [+0x0D950]  EB 11                    jmp     short 5963h
F000:5952  [+0x0D952]  90                       nop
F000:5953  [+0x0D953]  B0 42                    mov     al,42h
F000:5955  [+0x0D955]  B4 49                    mov     ah,49h
F000:5957  [+0x0D957]  3B 47 08                 cmp     ax,[bx+8]
F000:595A  [+0x0D95A]  0F 84 0C 00              je      near 596Ah
F000:595E  [+0x0D95E]  83 C3 20                 add     bx,20h
F000:5961  [+0x0D961]  E2 A5                    loop    5908h
F000:5963  [+0x0D963]  B0 FF                    mov     al,0FFh
F000:5965  [+0x0D965]  A8 FF                    test    al,0FFh
F000:5967  [+0x0D967]  EB 3E                    jmp     short 59A7h
F000:5969  [+0x0D969]  90                       nop
F000:596A  [+0x0D96A]  8B 47 1A                 mov     ax,[bx+1Ah]
F000:596D  [+0x0D96D]  2D 02 00                 sub     ax,2
F000:5970  [+0x0D970]  32 ED                    xor     ch,ch
F000:5972  [+0x0D972]  36 8A 0E 5E 00           mov     cl,[ss:5Eh]
F000:5977  [+0x0D977]  F7 E1                    mul     cx
F000:5979  [+0x0D979]  52                       push    dx
F000:597A  [+0x0D97A]  50                       push    ax
F000:597B  [+0x0D97B]  66 33 C0                 xor     eax,eax
F000:597E  [+0x0D97E]  36 8B 1E 5F 00           mov     bx,[ss:5Fh]
F000:5983  [+0x0D983]  36 A0 61 00              mov     al,[ss:61h]
F000:5987  [+0x0D987]  36 8B 0E 67 00           mov     cx,[ss:67h]
F000:598C  [+0x0D98C]  F7 E1                    mul     cx
F000:598E  [+0x0D98E]  03 C3                    add     ax,bx
F000:5990  [+0x0D990]  36 03 06 89 00           add     ax,[ss:89h]
F000:5995  [+0x0D995]  66 5B                    pop     ebx
F000:5997  [+0x0D997]  66 03 C3                 add     eax,ebx
F000:599A  [+0x0D99A]  36 66 03 06 50 00        add     eax,[ss:50h]
F000:59A0  [+0x0D9A0]  36 66 A3 50 00           mov     [ss:50h],eax
F000:59A5  [+0x0D9A5]  33 C0                    xor     ax,ax
F000:59A7  [+0x0D9A7]  59                       pop     cx
F000:59A8  [+0x0D9A8]  66 5B                    pop     ebx
F000:59AA  [+0x0D9AA]  66 58                    pop     eax
F000:59AC  [+0x0D9AC]  C3                       ret
F000:59AD  [+0x0D9AD]  50                       push    ax
F000:59AE  [+0x0D9AE]  51                       push    cx
F000:59AF  [+0x0D9AF]  E6 80                    out     80h,al
F000:59B1  [+0x0D9B1]  B8 00 02                 mov     ax,200h
F000:59B4  [+0x0D9B4]  B9 00 00                 mov     cx,0
F000:59B7  [+0x0D9B7]  E2 FE                    loop    59B7h
F000:59B9  [+0x0D9B9]  48                       dec     ax
F000:59BA  [+0x0D9BA]  75 F8                    jne     short 59B4h
F000:59BC  [+0x0D9BC]  F9                       stc
F000:59BD  [+0x0D9BD]  59                       pop     cx
F000:59BE  [+0x0D9BE]  58                       pop     ax
F000:59BF  [+0x0D9BF]  C3                       ret
F000:59C0  [+0x0D9C0]  66 50                    push    eax
F000:59C2  [+0x0D9C2]  66 53                    push    ebx
F000:59C4  [+0x0D9C4]  66 51                    push    ecx
F000:59C6  [+0x0D9C6]  52                       push    dx
F000:59C7  [+0x0D9C7]  66 56                    push    esi
F000:59C9  [+0x0D9C9]  66 0F B6 C9              movzx   ecx,cl
F000:59CD  [+0x0D9CD]  66 56                    push    esi
F000:59CF  [+0x0D9CF]  66 53                    push    ebx
F000:59D1  [+0x0D9D1]  66 03 F1                 add     esi,ecx
F000:59D4  [+0x0D9D4]  66 4E                    dec     esi
F000:59D6  [+0x0D9D6]  E8 D1 00                 call    5AAAh
F000:59D9  [+0x0D9D9]  66 5B                    pop     ebx
F000:59DB  [+0x0D9DB]  66 5E                    pop     esi
F000:59DD  [+0x0D9DD]  B8 08 00                 mov     ax,8
F000:59E0  [+0x0D9E0]  0F 82 B1 01              jb      near 5B95h
F000:59E4  [+0x0D9E4]  8C C0                    mov     ax,es
F000:59E6  [+0x0D9E6]  3D 00 A0                 cmp     ax,0A000h
F000:59E9  [+0x0D9E9]  74 07                    je      short 59F2h
F000:59EB  [+0x0D9EB]  D1 C9                    ror     cx,1
F000:59ED  [+0x0D9ED]  E8 38 E5                 call    3F28h
F000:59F0  [+0x0D9F0]  D1 C1                    rol     cx,1
F000:59F2  [+0x0D9F2]  E3 37                    jcxz    5A2Bh
F000:59F4  [+0x0D9F4]  66 56                    push    esi
F000:59F6  [+0x0D9F6]  53                       push    bx
F000:59F7  [+0x0D9F7]  E8 B0 00                 call    5AAAh
F000:59FA  [+0x0D9FA]  66 3B D9                 cmp     ebx,ecx
F000:59FD  [+0x0D9FD]  76 03                    jbe     short 5A02h
F000:59FF  [+0x0D9FF]  66 8B D9                 mov     ebx,ecx
F000:5A02  [+0x0DA02]  8A C3                    mov     al,bl
F000:5A04  [+0x0DA04]  5B                       pop     bx
F000:5A05  [+0x0DA05]  51                       push    cx
F000:5A06  [+0x0DA06]  E8 C0 00                 call    5AC9h
F000:5A09  [+0x0DA09]  B4 02                    mov     ah,2
F000:5A0B  [+0x0DA0B]  B2 80                    mov     dl,80h
F000:5A0D  [+0x0DA0D]  CD 13                    int     13h
F000:5A0F  [+0x0DA0F]  59                       pop     cx
F000:5A10  [+0x0DA10]  66 5E                    pop     esi
F000:5A12  [+0x0DA12]  73 07                    jae     short 5A1Bh
F000:5A14  [+0x0DA14]  B8 02 00                 mov     ax,2
F000:5A17  [+0x0DA17]  0F 82 7A 01              jb      near 5B95h
F000:5A1B  [+0x0DA1B]  66 0F B6 C0              movzx   eax,al
F000:5A1F  [+0x0DA1F]  2A C8                    sub     cl,al
F000:5A21  [+0x0DA21]  66 03 F0                 add     esi,eax
F000:5A24  [+0x0DA24]  C1 E0 09                 shl     ax,9
F000:5A27  [+0x0DA27]  03 D8                    add     bx,ax
F000:5A29  [+0x0DA29]  EB C7                    jmp     short 59F2h
F000:5A2B  [+0x0DA2B]  66 5E                    pop     esi
F000:5A2D  [+0x0DA2D]  5A                       pop     dx
F000:5A2E  [+0x0DA2E]  66 59                    pop     ecx
F000:5A30  [+0x0DA30]  66 5B                    pop     ebx
F000:5A32  [+0x0DA32]  66 58                    pop     eax
F000:5A34  [+0x0DA34]  C3                       ret
F000:5A35  [+0x0DA35]  66 50                    push    eax
F000:5A37  [+0x0DA37]  66 53                    push    ebx
F000:5A39  [+0x0DA39]  66 51                    push    ecx
F000:5A3B  [+0x0DA3B]  52                       push    dx
F000:5A3C  [+0x0DA3C]  66 56                    push    esi
F000:5A3E  [+0x0DA3E]  66 0F B6 C9              movzx   ecx,cl
F000:5A42  [+0x0DA42]  66 56                    push    esi
F000:5A44  [+0x0DA44]  66 53                    push    ebx
F000:5A46  [+0x0DA46]  66 03 F1                 add     esi,ecx
F000:5A49  [+0x0DA49]  66 4E                    dec     esi
F000:5A4B  [+0x0DA4B]  E8 5C 00                 call    5AAAh
F000:5A4E  [+0x0DA4E]  66 5B                    pop     ebx
F000:5A50  [+0x0DA50]  66 5E                    pop     esi
F000:5A52  [+0x0DA52]  B8 09 00                 mov     ax,9
F000:5A55  [+0x0DA55]  0F 82 3C 01              jb      near 5B95h
F000:5A59  [+0x0DA59]  8C C0                    mov     ax,es
F000:5A5B  [+0x0DA5B]  3D 00 A0                 cmp     ax,0A000h
F000:5A5E  [+0x0DA5E]  74 07                    je      short 5A67h
F000:5A60  [+0x0DA60]  D1 C9                    ror     cx,1
F000:5A62  [+0x0DA62]  E8 C3 E4                 call    3F28h
F000:5A65  [+0x0DA65]  D1 C1                    rol     cx,1
F000:5A67  [+0x0DA67]  E3 37                    jcxz    5AA0h
F000:5A69  [+0x0DA69]  66 56                    push    esi
F000:5A6B  [+0x0DA6B]  53                       push    bx
F000:5A6C  [+0x0DA6C]  E8 3B 00                 call    5AAAh
F000:5A6F  [+0x0DA6F]  66 3B D9                 cmp     ebx,ecx
F000:5A72  [+0x0DA72]  76 03                    jbe     short 5A77h
F000:5A74  [+0x0DA74]  66 8B D9                 mov     ebx,ecx
F000:5A77  [+0x0DA77]  8A C3                    mov     al,bl
F000:5A79  [+0x0DA79]  5B                       pop     bx
F000:5A7A  [+0x0DA7A]  51                       push    cx
F000:5A7B  [+0x0DA7B]  E8 4B 00                 call    5AC9h
F000:5A7E  [+0x0DA7E]  B4 03                    mov     ah,3
F000:5A80  [+0x0DA80]  B2 80                    mov     dl,80h
F000:5A82  [+0x0DA82]  CD 13                    int     13h
F000:5A84  [+0x0DA84]  59                       pop     cx
F000:5A85  [+0x0DA85]  66 5E                    pop     esi
F000:5A87  [+0x0DA87]  73 07                    jae     short 5A90h
F000:5A89  [+0x0DA89]  B8 03 00                 mov     ax,3
F000:5A8C  [+0x0DA8C]  0F 82 05 01              jb      near 5B95h
F000:5A90  [+0x0DA90]  66 0F B6 C0              movzx   eax,al
F000:5A94  [+0x0DA94]  2A C8                    sub     cl,al
F000:5A96  [+0x0DA96]  66 03 F0                 add     esi,eax
F000:5A99  [+0x0DA99]  C1 E0 09                 shl     ax,9
F000:5A9C  [+0x0DA9C]  03 D8                    add     bx,ax
F000:5A9E  [+0x0DA9E]  EB C7                    jmp     short 5A67h
F000:5AA0  [+0x0DAA0]  66 5E                    pop     esi
F000:5AA2  [+0x0DAA2]  5A                       pop     dx
F000:5AA3  [+0x0DAA3]  66 59                    pop     ecx
F000:5AA5  [+0x0DAA5]  66 5B                    pop     ebx
F000:5AA7  [+0x0DAA7]  66 58                    pop     eax
F000:5AA9  [+0x0DAA9]  C3                       ret
F000:5AAA  [+0x0DAAA]  1E                       push    ds
F000:5AAB  [+0x0DAAB]  57                       push    di
F000:5AAC  [+0x0DAAC]  8C D7                    mov     di,ss
F000:5AAE  [+0x0DAAE]  8E DF                    mov     ds,di
F000:5AB0  [+0x0DAB0]  BF 8D 00                 mov     di,8Dh
F000:5AB3  [+0x0DAB3]  83 C7 08                 add     di,8
F000:5AB6  [+0x0DAB6]  66 39 35                 cmp     [di],esi
F000:5AB9  [+0x0DAB9]  77 F8                    ja      short 5AB3h
F000:5ABB  [+0x0DABB]  66 8B 5D F8              mov     ebx,[di-8]
F000:5ABF  [+0x0DABF]  66 2B DE                 sub     ebx,esi
F000:5AC2  [+0x0DAC2]  66 03 75 04              add     esi,[di+4]
F000:5AC6  [+0x0DAC6]  5F                       pop     di
F000:5AC7  [+0x0DAC7]  1F                       pop     ds
F000:5AC8  [+0x0DAC8]  C3                       ret
F000:5AC9  [+0x0DAC9]  50                       push    ax
F000:5ACA  [+0x0DACA]  53                       push    bx
F000:5ACB  [+0x0DACB]  66 56                    push    esi
F000:5ACD  [+0x0DACD]  8A DA                    mov     bl,dl
F000:5ACF  [+0x0DACF]  36 66 03 36 50 00        add     esi,[ss:50h]
F000:5AD5  [+0x0DAD5]  8B C6                    mov     ax,si
F000:5AD7  [+0x0DAD7]  66 C1 EE 10              shr     esi,10h
F000:5ADB  [+0x0DADB]  8B D6                    mov     dx,si
F000:5ADD  [+0x0DADD]  36 F7 36 56 00           div     word [ss:56h]
F000:5AE2  [+0x0DAE2]  42                       inc     dx
F000:5AE3  [+0x0DAE3]  8B CA                    mov     cx,dx
F000:5AE5  [+0x0DAE5]  33 D2                    xor     dx,dx
F000:5AE7  [+0x0DAE7]  36 F7 36 54 00           div     word [ss:54h]
F000:5AEC  [+0x0DAEC]  8A F2                    mov     dh,dl
F000:5AEE  [+0x0DAEE]  86 E0                    xchg    ah,al
F000:5AF0  [+0x0DAF0]  C0 C8 02                 ror     al,2
F000:5AF3  [+0x0DAF3]  0B C8                    or      cx,ax
F000:5AF5  [+0x0DAF5]  8A D3                    mov     dl,bl
F000:5AF7  [+0x0DAF7]  66 5E                    pop     esi
F000:5AF9  [+0x0DAF9]  5B                       pop     bx
F000:5AFA  [+0x0DAFA]  58                       pop     ax
F000:5AFB  [+0x0DAFB]  C3                       ret
F000:5AFC  [+0x0DAFC]  55                       push    bp
F000:5AFD  [+0x0DAFD]  51                       push    cx
F000:5AFE  [+0x0DAFE]  36 66 81 3E 8D 00 54 69 6D 4F cmp     dword [ss:8Dh],4F6D6954h
F000:5B08  [+0x0DB08]  B8 06 00                 mov     ax,6
F000:5B0B  [+0x0DB0B]  75 35                    jne     short 5B42h
F000:5B0D  [+0x0DB0D]  B8 07 00                 mov     ax,7
F000:5B10  [+0x0DB10]  36 80 3E 91 00 00        cmp     byte [ss:91h],0
F000:5B16  [+0x0DB16]  75 2A                    jne     short 5B42h
F000:5B18  [+0x0DB18]  36 66 83 3E 95 00 00     cmp     dword [ss:95h],0
F000:5B1F  [+0x0DB1F]  75 21                    jne     short 5B42h
F000:5B21  [+0x0DB21]  33 C0                    xor     ax,ax
F000:5B23  [+0x0DB23]  BD 95 00                 mov     bp,95h
F000:5B26  [+0x0DB26]  B9 FC 00                 mov     cx,0FCh
F000:5B29  [+0x0DB29]  03 46 00                 add     ax,[bp]
F000:5B2C  [+0x0DB2C]  83 C5 02                 add     bp,2
F000:5B2F  [+0x0DB2F]  E2 F8                    loop    5B29h
F000:5B31  [+0x0DB31]  F7 D0                    not     ax
F000:5B33  [+0x0DB33]  36 39 06 93 00           cmp     [ss:93h],ax
F000:5B38  [+0x0DB38]  B8 07 00                 mov     ax,7
F000:5B3B  [+0x0DB3B]  75 05                    jne     short 5B42h
F000:5B3D  [+0x0DB3D]  33 C0                    xor     ax,ax
F000:5B3F  [+0x0DB3F]  59                       pop     cx
F000:5B40  [+0x0DB40]  5D                       pop     bp
F000:5B41  [+0x0DB41]  C3                       ret
F000:5B42  [+0x0DB42]  F9                       stc
F000:5B43  [+0x0DB43]  59                       pop     cx
F000:5B44  [+0x0DB44]  5D                       pop     bp
F000:5B45  [+0x0DB45]  C3                       ret
F000:5B46  [+0x0DB46]  66 50                    push    eax
F000:5B48  [+0x0DB48]  53                       push    bx
F000:5B49  [+0x0DB49]  51                       push    cx
F000:5B4A  [+0x0DB4A]  56                       push    si
F000:5B4B  [+0x0DB4B]  1E                       push    ds
F000:5B4C  [+0x0DB4C]  8C D0                    mov     ax,ss
F000:5B4E  [+0x0DB4E]  8E D8                    mov     ds,ax
F000:5B50  [+0x0DB50]  B9 3F 00                 mov     cx,3Fh
F000:5B53  [+0x0DB53]  BB 8D 00                 mov     bx,8Dh
F000:5B56  [+0x0DB56]  83 C3 08                 add     bx,8
F000:5B59  [+0x0DB59]  66 83 3F FF              cmp     dword [bx],0FFFFFFFFh
F000:5B5D  [+0x0DB5D]  E0 F7                    loopne  5B56h
F000:5B5F  [+0x0DB5F]  75 03                    jne     short 5B64h
F000:5B61  [+0x0DB61]  41                       inc     cx
F000:5B62  [+0x0DB62]  F7 D9                    neg     cx
F000:5B64  [+0x0DB64]  83 C1 3F                 add     cx,3Fh
F000:5B67  [+0x0DB67]  D1 E9                    shr     cx,1
F000:5B69  [+0x0DB69]  74 23                    je      short 5B8Eh
F000:5B6B  [+0x0DB6B]  83 EB 08                 sub     bx,8
F000:5B6E  [+0x0DB6E]  BE 95 00                 mov     si,95h
F000:5B71  [+0x0DB71]  66 8B 04                 mov     eax,[si]
F000:5B74  [+0x0DB74]  66 87 07                 xchg    eax,[bx]
F000:5B77  [+0x0DB77]  66 89 04                 mov     [si],eax
F000:5B7A  [+0x0DB7A]  66 8B 44 04              mov     eax,[si+4]
F000:5B7E  [+0x0DB7E]  66 87 47 04              xchg    eax,[bx+4]
F000:5B82  [+0x0DB82]  66 89 44 04              mov     [si+4],eax
F000:5B86  [+0x0DB86]  83 C6 08                 add     si,8
F000:5B89  [+0x0DB89]  83 EB 08                 sub     bx,8
F000:5B8C  [+0x0DB8C]  E2 E3                    loop    5B71h
F000:5B8E  [+0x0DB8E]  1F                       pop     ds
F000:5B8F  [+0x0DB8F]  5E                       pop     si
F000:5B90  [+0x0DB90]  59                       pop     cx
F000:5B91  [+0x0DB91]  5B                       pop     bx
F000:5B92  [+0x0DB92]  66 58                    pop     eax
F000:5B94  [+0x0DB94]  C3                       ret
F000:5B95  [+0x0DB95]  50                       push    ax
F000:5B96  [+0x0DB96]  B0 EE                    mov     al,0EEh
F000:5B98  [+0x0DB98]  E6 80                    out     80h,al
F000:5B9A  [+0x0DB9A]  58                       pop     ax
F000:5B9B  [+0x0DB9B]  E8 DF E2                 call    3E7Dh
F000:5B9E  [+0x0DB9E]  EB FE                    jmp     short 5B9Eh
F000:5BA0  [+0x0DBA0]  50                       push    ax
F000:5BA1  [+0x0DBA1]  1E                       push    ds
F000:5BA2  [+0x0DBA2]  33 C0                    xor     ax,ax
F000:5BA4  [+0x0DBA4]  8E D8                    mov     ds,ax
F000:5BA6  [+0x0DBA6]  C6 06 8E 04 FF           mov     byte [48Eh],0FFh
F000:5BAB  [+0x0DBAB]  B0 20                    mov     al,20h
F000:5BAD  [+0x0DBAD]  E6 A0                    out     0A0h,al
F000:5BAF  [+0x0DBAF]  E6 20                    out     20h,al
F000:5BB1  [+0x0DBB1]  1F                       pop     ds
F000:5BB2  [+0x0DBB2]  58                       pop     ax
F000:5BB3  [+0x0DBB3]  CF                       iret
F000:5BB4  [+0x0DBB4]  36 66 C7 06 90 02 00 00 00 00 mov     dword [ss:290h],0
F000:5BBE  [+0x0DBBE]  E8 89 FA                 call    564Ah
F000:5BC1  [+0x0DBC1]  C3                       ret
F000:5BC2  [+0x0DBC2]  36 66 89 0E 90 02        mov     [ss:290h],ecx
F000:5BC8  [+0x0DBC8]  C3                       ret
F000:5BC9  [+0x0DBC9]  66 56                    push    esi
F000:5BCB  [+0x0DBCB]  53                       push    bx
F000:5BCC  [+0x0DBCC]  8B DF                    mov     bx,di
F000:5BCE  [+0x0DBCE]  36 66 8B 36 90 02        mov     esi,[ss:290h]
F000:5BD4  [+0x0DBD4]  E8 E9 FD                 call    59C0h
F000:5BD7  [+0x0DBD7]  66 0F B6 F1              movzx   esi,cl
F000:5BDB  [+0x0DBDB]  36 66 01 36 90 02        add     [ss:290h],esi
F000:5BE1  [+0x0DBE1]  5B                       pop     bx
F000:5BE2  [+0x0DBE2]  66 5E                    pop     esi
F000:5BE4  [+0x0DBE4]  C3                       ret
F000:5BE5  [+0x0DBE5]  66 56                    push    esi
F000:5BE7  [+0x0DBE7]  53                       push    bx
F000:5BE8  [+0x0DBE8]  8B DF                    mov     bx,di
F000:5BEA  [+0x0DBEA]  36 66 8B 36 90 02        mov     esi,[ss:290h]
F000:5BF0  [+0x0DBF0]  E8 42 FE                 call    5A35h
F000:5BF3  [+0x0DBF3]  66 0F B6 F1              movzx   esi,cl
F000:5BF7  [+0x0DBF7]  36 66 01 36 90 02        add     [ss:290h],esi
F000:5BFD  [+0x0DBFD]  5B                       pop     bx
F000:5BFE  [+0x0DBFE]  66 5E                    pop     esi
F000:5C00  [+0x0DC00]  C3                       ret
F000:5C01  [+0x0DC01]  00 1E 56 0E              add     [0E56h],bl
F000:5C05  [+0x0DC05]  BE 26 5C                 mov     si,5C26h
F000:5C08  [+0x0DC08]  00 00                    add     [bx+si],al
F000:5C0A  [+0x0DC0A]  56                       push    si
F000:5C0B  [+0x0DC0B]  66 8C CE                 mov     esi,cs
F000:5C0E  [+0x0DC0E]  66 83 C6 08              add     esi,8
F000:5C12  [+0x0DC12]  66 56                    push    esi
F000:5C14  [+0x0DC14]  66 BE DC 04 66 56        mov     esi,566604DCh
F000:5C1A  [+0x0DC1A]  66 8C CE                 mov     esi,cs
F000:5C1D  [+0x0DC1D]  66 83 C6 10              add     esi,10h
F000:5C21  [+0x0DC21]  66 8E DE                 mov     ds,esi
F000:5C24  [+0x0DC24]  66 CB                    retfd
F000:5C26  [+0x0DC26]  5E                       pop     si
F000:5C27  [+0x0DC27]  1F                       pop     ds
F000:5C28  [+0x0DC28]  CB                       retf
F000:5C29  [+0x0DC29]  00 00                    add     [bx+si],al
F000:5C2B  [+0x0DC2B]  00 00                    add     [bx+si],al
F000:5C2D  [+0x0DC2D]  00 00                    add     [bx+si],al
F000:5C2F  [+0x0DC2F]  00 00                    add     [bx+si],al
F000:5C31  [+0x0DC31]  00 00                    add     [bx+si],al
F000:5C33  [+0x0DC33]  00 00                    add     [bx+si],al
F000:5C35  [+0x0DC35]  00 00                    add     [bx+si],al
F000:5C37  [+0x0DC37]  00 00                    add     [bx+si],al
F000:5C39  [+0x0DC39]  00 00                    add     [bx+si],al
F000:5C3B  [+0x0DC3B]  00 00                    add     [bx+si],al
F000:5C3D  [+0x0DC3D]  00 00                    add     [bx+si],al
F000:5C3F  [+0x0DC3F]  00 00                    add     [bx+si],al
F000:5C41  [+0x0DC41]  00 00                    add     [bx+si],al
F000:5C43  [+0x0DC43]  00 00                    add     [bx+si],al
F000:5C45  [+0x0DC45]  00 00                    add     [bx+si],al
F000:5C47  [+0x0DC47]  00 00                    add     [bx+si],al
F000:5C49  [+0x0DC49]  00 00                    add     [bx+si],al
F000:5C4B  [+0x0DC4B]  00 00                    add     [bx+si],al
F000:5C4D  [+0x0DC4D]  00 00                    add     [bx+si],al
F000:5C4F  [+0x0DC4F]  00 00                    add     [bx+si],al
F000:5C51  [+0x0DC51]  00 00                    add     [bx+si],al
F000:5C53  [+0x0DC53]  00 00                    add     [bx+si],al
F000:5C55  [+0x0DC55]  00 00                    add     [bx+si],al
F000:5C57  [+0x0DC57]  00 00                    add     [bx+si],al
F000:5C59  [+0x0DC59]  00 00                    add     [bx+si],al
F000:5C5B  [+0x0DC5B]  00 00                    add     [bx+si],al
F000:5C5D  [+0x0DC5D]  00 00                    add     [bx+si],al
F000:5C5F  [+0x0DC5F]  00 00                    add     [bx+si],al
F000:5C61  [+0x0DC61]  00 00                    add     [bx+si],al
F000:5C63  [+0x0DC63]  00 00                    add     [bx+si],al
F000:5C65  [+0x0DC65]  00 00                    add     [bx+si],al
F000:5C67  [+0x0DC67]  00 00                    add     [bx+si],al
F000:5C69  [+0x0DC69]  00 00                    add     [bx+si],al
F000:5C6B  [+0x0DC6B]  00 00                    add     [bx+si],al
F000:5C6D  [+0x0DC6D]  00 00                    add     [bx+si],al
F000:5C6F  [+0x0DC6F]  00 00                    add     [bx+si],al
F000:5C71  [+0x0DC71]  00 00                    add     [bx+si],al
F000:5C73  [+0x0DC73]  00 00                    add     [bx+si],al
F000:5C75  [+0x0DC75]  00 00                    add     [bx+si],al
F000:5C77  [+0x0DC77]  00 00                    add     [bx+si],al
F000:5C79  [+0x0DC79]  00 00                    add     [bx+si],al
F000:5C7B  [+0x0DC7B]  00 00                    add     [bx+si],al
F000:5C7D  [+0x0DC7D]  00 00                    add     [bx+si],al
F000:5C7F  [+0x0DC7F]  00 00                    add     [bx+si],al
F000:5C81  [+0x0DC81]  00 00                    add     [bx+si],al
F000:5C83  [+0x0DC83]  00 00                    add     [bx+si],al
F000:5C85  [+0x0DC85]  00 00                    add     [bx+si],al
F000:5C87  [+0x0DC87]  00 00                    add     [bx+si],al
F000:5C89  [+0x0DC89]  00 00                    add     [bx+si],al
F000:5C8B  [+0x0DC8B]  00 00                    add     [bx+si],al
F000:5C8D  [+0x0DC8D]  00 00                    add     [bx+si],al
F000:5C8F  [+0x0DC8F]  00 00                    add     [bx+si],al
F000:5C91  [+0x0DC91]  00 00                    add     [bx+si],al
F000:5C93  [+0x0DC93]  00 00                    add     [bx+si],al
F000:5C95  [+0x0DC95]  00 00                    add     [bx+si],al
F000:5C97  [+0x0DC97]  00 00                    add     [bx+si],al
F000:5C99  [+0x0DC99]  00 00                    add     [bx+si],al
F000:5C9B  [+0x0DC9B]  00 00                    add     [bx+si],al
F000:5C9D  [+0x0DC9D]  00 00                    add     [bx+si],al
F000:5C9F  [+0x0DC9F]  00 00                    add     [bx+si],al
F000:5CA1  [+0x0DCA1]  00 00                    add     [bx+si],al
F000:5CA3  [+0x0DCA3]  00 00                    add     [bx+si],al
F000:5CA5  [+0x0DCA5]  00 00                    add     [bx+si],al
F000:5CA7  [+0x0DCA7]  00 00                    add     [bx+si],al
F000:5CA9  [+0x0DCA9]  00 00                    add     [bx+si],al
F000:5CAB  [+0x0DCAB]  00 00                    add     [bx+si],al
F000:5CAD  [+0x0DCAD]  00 00                    add     [bx+si],al
F000:5CAF  [+0x0DCAF]  00 00                    add     [bx+si],al
F000:5CB1  [+0x0DCB1]  00 00                    add     [bx+si],al
F000:5CB3  [+0x0DCB3]  00 00                    add     [bx+si],al
F000:5CB5  [+0x0DCB5]  00 00                    add     [bx+si],al
F000:5CB7  [+0x0DCB7]  00 00                    add     [bx+si],al
F000:5CB9  [+0x0DCB9]  00 00                    add     [bx+si],al
F000:5CBB  [+0x0DCBB]  00 00                    add     [bx+si],al
F000:5CBD  [+0x0DCBD]  00 00                    add     [bx+si],al
F000:5CBF  [+0x0DCBF]  00 00                    add     [bx+si],al
F000:5CC1  [+0x0DCC1]  00 00                    add     [bx+si],al
F000:5CC3  [+0x0DCC3]  00 00                    add     [bx+si],al
F000:5CC5  [+0x0DCC5]  00 00                    add     [bx+si],al
F000:5CC7  [+0x0DCC7]  00 00                    add     [bx+si],al
F000:5CC9  [+0x0DCC9]  00 00                    add     [bx+si],al
F000:5CCB  [+0x0DCCB]  00 00                    add     [bx+si],al
F000:5CCD  [+0x0DCCD]  00 00                    add     [bx+si],al
F000:5CCF  [+0x0DCCF]  00 00                    add     [bx+si],al
F000:5CD1  [+0x0DCD1]  00 00                    add     [bx+si],al
F000:5CD3  [+0x0DCD3]  00 00                    add     [bx+si],al
F000:5CD5  [+0x0DCD5]  00 00                    add     [bx+si],al
F000:5CD7  [+0x0DCD7]  00 00                    add     [bx+si],al
F000:5CD9  [+0x0DCD9]  00 00                    add     [bx+si],al
F000:5CDB  [+0x0DCDB]  00 00                    add     [bx+si],al
F000:5CDD  [+0x0DCDD]  00 00                    add     [bx+si],al
F000:5CDF  [+0x0DCDF]  00 00                    add     [bx+si],al
F000:5CE1  [+0x0DCE1]  00 00                    add     [bx+si],al
F000:5CE3  [+0x0DCE3]  00 00                    add     [bx+si],al
F000:5CE5  [+0x0DCE5]  00 00                    add     [bx+si],al
F000:5CE7  [+0x0DCE7]  00 00                    add     [bx+si],al
F000:5CE9  [+0x0DCE9]  00 00                    add     [bx+si],al
F000:5CEB  [+0x0DCEB]  00 00                    add     [bx+si],al
F000:5CED  [+0x0DCED]  00 00                    add     [bx+si],al
F000:5CEF  [+0x0DCEF]  00 00                    add     [bx+si],al
F000:5CF1  [+0x0DCF1]  00 00                    add     [bx+si],al
F000:5CF3  [+0x0DCF3]  00 00                    add     [bx+si],al
F000:5CF5  [+0x0DCF5]  00 00                    add     [bx+si],al
F000:5CF7  [+0x0DCF7]  00 00                    add     [bx+si],al
F000:5CF9  [+0x0DCF9]  00 00                    add     [bx+si],al
F000:5CFB  [+0x0DCFB]  00 00                    add     [bx+si],al
F000:5CFD  [+0x0DCFD]  00 00                    add     [bx+si],al
F000:5CFF  [+0x0DCFF]  00 00                    add     [bx+si],al
F000:5D01  [+0x0DD01]  00 00                    add     [bx+si],al
F000:5D03  [+0x0DD03]  00 00                    add     [bx+si],al
F000:5D05  [+0x0DD05]  00 00                    add     [bx+si],al
F000:5D07  [+0x0DD07]  00 00                    add     [bx+si],al
F000:5D09  [+0x0DD09]  00 00                    add     [bx+si],al
F000:5D0B  [+0x0DD0B]  00 00                    add     [bx+si],al
F000:5D0D  [+0x0DD0D]  00 00                    add     [bx+si],al
F000:5D0F  [+0x0DD0F]  00 00                    add     [bx+si],al
F000:5D11  [+0x0DD11]  00 00                    add     [bx+si],al
F000:5D13  [+0x0DD13]  00 00                    add     [bx+si],al
F000:5D15  [+0x0DD15]  00 00                    add     [bx+si],al
F000:5D17  [+0x0DD17]  00 00                    add     [bx+si],al
F000:5D19  [+0x0DD19]  00 00                    add     [bx+si],al
F000:5D1B  [+0x0DD1B]  00 00                    add     [bx+si],al
F000:5D1D  [+0x0DD1D]  00 00                    add     [bx+si],al
F000:5D1F  [+0x0DD1F]  00 00                    add     [bx+si],al
F000:5D21  [+0x0DD21]  00 00                    add     [bx+si],al
F000:5D23  [+0x0DD23]  00 00                    add     [bx+si],al
F000:5D25  [+0x0DD25]  00 00                    add     [bx+si],al
F000:5D27  [+0x0DD27]  00 00                    add     [bx+si],al
F000:5D29  [+0x0DD29]  00 00                    add     [bx+si],al
F000:5D2B  [+0x0DD2B]  00 00                    add     [bx+si],al
F000:5D2D  [+0x0DD2D]  00 00                    add     [bx+si],al
F000:5D2F  [+0x0DD2F]  00 00                    add     [bx+si],al
F000:5D31  [+0x0DD31]  00 00                    add     [bx+si],al
F000:5D33  [+0x0DD33]  00 00                    add     [bx+si],al
F000:5D35  [+0x0DD35]  00 00                    add     [bx+si],al
F000:5D37  [+0x0DD37]  00 00                    add     [bx+si],al
F000:5D39  [+0x0DD39]  00 00                    add     [bx+si],al
F000:5D3B  [+0x0DD3B]  00 00                    add     [bx+si],al
F000:5D3D  [+0x0DD3D]  00 00                    add     [bx+si],al
F000:5D3F  [+0x0DD3F]  00 00                    add     [bx+si],al
F000:5D41  [+0x0DD41]  00 00                    add     [bx+si],al
F000:5D43  [+0x0DD43]  00 00                    add     [bx+si],al
F000:5D45  [+0x0DD45]  00 00                    add     [bx+si],al
F000:5D47  [+0x0DD47]  00 00                    add     [bx+si],al
F000:5D49  [+0x0DD49]  00 00                    add     [bx+si],al
F000:5D4B  [+0x0DD4B]  00 00                    add     [bx+si],al
F000:5D4D  [+0x0DD4D]  00 00                    add     [bx+si],al
F000:5D4F  [+0x0DD4F]  00 00                    add     [bx+si],al
F000:5D51  [+0x0DD51]  00 00                    add     [bx+si],al
F000:5D53  [+0x0DD53]  00 00                    add     [bx+si],al
F000:5D55  [+0x0DD55]  00 00                    add     [bx+si],al
F000:5D57  [+0x0DD57]  00 00                    add     [bx+si],al
F000:5D59  [+0x0DD59]  00 00                    add     [bx+si],al
F000:5D5B  [+0x0DD5B]  00 00                    add     [bx+si],al
F000:5D5D  [+0x0DD5D]  00 00                    add     [bx+si],al
F000:5D5F  [+0x0DD5F]  00 00                    add     [bx+si],al
F000:5D61  [+0x0DD61]  00 00                    add     [bx+si],al
F000:5D63  [+0x0DD63]  00 00                    add     [bx+si],al
F000:5D65  [+0x0DD65]  00 00                    add     [bx+si],al
F000:5D67  [+0x0DD67]  00 00                    add     [bx+si],al
F000:5D69  [+0x0DD69]  00 00                    add     [bx+si],al
F000:5D6B  [+0x0DD6B]  00 00                    add     [bx+si],al
F000:5D6D  [+0x0DD6D]  00 00                    add     [bx+si],al
F000:5D6F  [+0x0DD6F]  00 00                    add     [bx+si],al
F000:5D71  [+0x0DD71]  00 00                    add     [bx+si],al
F000:5D73  [+0x0DD73]  00 00                    add     [bx+si],al
F000:5D75  [+0x0DD75]  00 00                    add     [bx+si],al
F000:5D77  [+0x0DD77]  00 00                    add     [bx+si],al
F000:5D79  [+0x0DD79]  00 00                    add     [bx+si],al
F000:5D7B  [+0x0DD7B]  00 00                    add     [bx+si],al
F000:5D7D  [+0x0DD7D]  00 00                    add     [bx+si],al
F000:5D7F  [+0x0DD7F]  00 00                    add     [bx+si],al
F000:5D81  [+0x0DD81]  00 00                    add     [bx+si],al
F000:5D83  [+0x0DD83]  00 00                    add     [bx+si],al
F000:5D85  [+0x0DD85]  00 00                    add     [bx+si],al
F000:5D87  [+0x0DD87]  00 00                    add     [bx+si],al
F000:5D89  [+0x0DD89]  00 00                    add     [bx+si],al
F000:5D8B  [+0x0DD8B]  00 00                    add     [bx+si],al
F000:5D8D  [+0x0DD8D]  00 00                    add     [bx+si],al
F000:5D8F  [+0x0DD8F]  00 00                    add     [bx+si],al
F000:5D91  [+0x0DD91]  00 00                    add     [bx+si],al
F000:5D93  [+0x0DD93]  00 00                    add     [bx+si],al
F000:5D95  [+0x0DD95]  00 00                    add     [bx+si],al
F000:5D97  [+0x0DD97]  00 00                    add     [bx+si],al
F000:5D99  [+0x0DD99]  00 00                    add     [bx+si],al
F000:5D9B  [+0x0DD9B]  00 00                    add     [bx+si],al
F000:5D9D  [+0x0DD9D]  00 00                    add     [bx+si],al
F000:5D9F  [+0x0DD9F]  00 00                    add     [bx+si],al
F000:5DA1  [+0x0DDA1]  00 00                    add     [bx+si],al
F000:5DA3  [+0x0DDA3]  00 00                    add     [bx+si],al
F000:5DA5  [+0x0DDA5]  00 00                    add     [bx+si],al
F000:5DA7  [+0x0DDA7]  00 00                    add     [bx+si],al
F000:5DA9  [+0x0DDA9]  00 00                    add     [bx+si],al
F000:5DAB  [+0x0DDAB]  00 00                    add     [bx+si],al
F000:5DAD  [+0x0DDAD]  00 00                    add     [bx+si],al
F000:5DAF  [+0x0DDAF]  00 00                    add     [bx+si],al
F000:5DB1  [+0x0DDB1]  00 00                    add     [bx+si],al
F000:5DB3  [+0x0DDB3]  00 00                    add     [bx+si],al
F000:5DB5  [+0x0DDB5]  00 00                    add     [bx+si],al
F000:5DB7  [+0x0DDB7]  00 00                    add     [bx+si],al
F000:5DB9  [+0x0DDB9]  00 00                    add     [bx+si],al
F000:5DBB  [+0x0DDBB]  00 00                    add     [bx+si],al
F000:5DBD  [+0x0DDBD]  00 00                    add     [bx+si],al
F000:5DBF  [+0x0DDBF]  00 00                    add     [bx+si],al
F000:5DC1  [+0x0DDC1]  00 00                    add     [bx+si],al
F000:5DC3  [+0x0DDC3]  00 00                    add     [bx+si],al
F000:5DC5  [+0x0DDC5]  00 00                    add     [bx+si],al
F000:5DC7  [+0x0DDC7]  00 00                    add     [bx+si],al
F000:5DC9  [+0x0DDC9]  00 00                    add     [bx+si],al
F000:5DCB  [+0x0DDCB]  00 00                    add     [bx+si],al
F000:5DCD  [+0x0DDCD]  00 00                    add     [bx+si],al
F000:5DCF  [+0x0DDCF]  00 00                    add     [bx+si],al
F000:5DD1  [+0x0DDD1]  00 00                    add     [bx+si],al
F000:5DD3  [+0x0DDD3]  00 00                    add     [bx+si],al
F000:5DD5  [+0x0DDD5]  00 00                    add     [bx+si],al
F000:5DD7  [+0x0DDD7]  00 00                    add     [bx+si],al
F000:5DD9  [+0x0DDD9]  00 00                    add     [bx+si],al
F000:5DDB  [+0x0DDDB]  00 00                    add     [bx+si],al
F000:5DDD  [+0x0DDDD]  00 00                    add     [bx+si],al
F000:5DDF  [+0x0DDDF]  00 00                    add     [bx+si],al
F000:5DE1  [+0x0DDE1]  00 00                    add     [bx+si],al
F000:5DE3  [+0x0DDE3]  00 00                    add     [bx+si],al
F000:5DE5  [+0x0DDE5]  00 00                    add     [bx+si],al
F000:5DE7  [+0x0DDE7]  00 00                    add     [bx+si],al
F000:5DE9  [+0x0DDE9]  00 00                    add     [bx+si],al
F000:5DEB  [+0x0DDEB]  00 00                    add     [bx+si],al
F000:5DED  [+0x0DDED]  00 00                    add     [bx+si],al
F000:5DEF  [+0x0DDEF]  00 00                    add     [bx+si],al
F000:5DF1  [+0x0DDF1]  00 00                    add     [bx+si],al
F000:5DF3  [+0x0DDF3]  00 00                    add     [bx+si],al
F000:5DF5  [+0x0DDF5]  00 00                    add     [bx+si],al
F000:5DF7  [+0x0DDF7]  00 00                    add     [bx+si],al
F000:5DF9  [+0x0DDF9]  00 00                    add     [bx+si],al
F000:5DFB  [+0x0DDFB]  00 00                    add     [bx+si],al
F000:5DFD  [+0x0DDFD]  00 00                    add     [bx+si],al
F000:5DFF  [+0x0DDFF]  00 00                    add     [bx+si],al
F000:5E01  [+0x0DE01]  00 00                    add     [bx+si],al
F000:5E03  [+0x0DE03]  00 00                    add     [bx+si],al
F000:5E05  [+0x0DE05]  00 00                    add     [bx+si],al
F000:5E07  [+0x0DE07]  00 00                    add     [bx+si],al
F000:5E09  [+0x0DE09]  00 00                    add     [bx+si],al
F000:5E0B  [+0x0DE0B]  00 00                    add     [bx+si],al
F000:5E0D  [+0x0DE0D]  00 00                    add     [bx+si],al
F000:5E0F  [+0x0DE0F]  00 00                    add     [bx+si],al
F000:5E11  [+0x0DE11]  00 00                    add     [bx+si],al
F000:5E13  [+0x0DE13]  00 00                    add     [bx+si],al
F000:5E15  [+0x0DE15]  00 00                    add     [bx+si],al
F000:5E17  [+0x0DE17]  00 00                    add     [bx+si],al
F000:5E19  [+0x0DE19]  00 00                    add     [bx+si],al
F000:5E1B  [+0x0DE1B]  00 00                    add     [bx+si],al
F000:5E1D  [+0x0DE1D]  00 00                    add     [bx+si],al
F000:5E1F  [+0x0DE1F]  00 00                    add     [bx+si],al
F000:5E21  [+0x0DE21]  00 00                    add     [bx+si],al
F000:5E23  [+0x0DE23]  00 00                    add     [bx+si],al
F000:5E25  [+0x0DE25]  00 00                    add     [bx+si],al
F000:5E27  [+0x0DE27]  00 00                    add     [bx+si],al
F000:5E29  [+0x0DE29]  00 00                    add     [bx+si],al
F000:5E2B  [+0x0DE2B]  00 00                    add     [bx+si],al
F000:5E2D  [+0x0DE2D]  00 00                    add     [bx+si],al
F000:5E2F  [+0x0DE2F]  00 00                    add     [bx+si],al
F000:5E31  [+0x0DE31]  00 00                    add     [bx+si],al
F000:5E33  [+0x0DE33]  00 00                    add     [bx+si],al
F000:5E35  [+0x0DE35]  00 00                    add     [bx+si],al
F000:5E37  [+0x0DE37]  00 00                    add     [bx+si],al
F000:5E39  [+0x0DE39]  00 00                    add     [bx+si],al
F000:5E3B  [+0x0DE3B]  00 00                    add     [bx+si],al
F000:5E3D  [+0x0DE3D]  00 00                    add     [bx+si],al
F000:5E3F  [+0x0DE3F]  00 00                    add     [bx+si],al
F000:5E41  [+0x0DE41]  00 00                    add     [bx+si],al
F000:5E43  [+0x0DE43]  00 00                    add     [bx+si],al
F000:5E45  [+0x0DE45]  00 00                    add     [bx+si],al
F000:5E47  [+0x0DE47]  00 00                    add     [bx+si],al
F000:5E49  [+0x0DE49]  00 00                    add     [bx+si],al
F000:5E4B  [+0x0DE4B]  00 00                    add     [bx+si],al
F000:5E4D  [+0x0DE4D]  00 00                    add     [bx+si],al
F000:5E4F  [+0x0DE4F]  00 00                    add     [bx+si],al
F000:5E51  [+0x0DE51]  00 00                    add     [bx+si],al
F000:5E53  [+0x0DE53]  00 00                    add     [bx+si],al
F000:5E55  [+0x0DE55]  00 00                    add     [bx+si],al
F000:5E57  [+0x0DE57]  00 00                    add     [bx+si],al
F000:5E59  [+0x0DE59]  00 00                    add     [bx+si],al
F000:5E5B  [+0x0DE5B]  00 00                    add     [bx+si],al
F000:5E5D  [+0x0DE5D]  00 00                    add     [bx+si],al
F000:5E5F  [+0x0DE5F]  00 00                    add     [bx+si],al
F000:5E61  [+0x0DE61]  00 00                    add     [bx+si],al
F000:5E63  [+0x0DE63]  00 00                    add     [bx+si],al
F000:5E65  [+0x0DE65]  00 00                    add     [bx+si],al
F000:5E67  [+0x0DE67]  00 00                    add     [bx+si],al
F000:5E69  [+0x0DE69]  00 00                    add     [bx+si],al
F000:5E6B  [+0x0DE6B]  00 00                    add     [bx+si],al
F000:5E6D  [+0x0DE6D]  00 00                    add     [bx+si],al
F000:5E6F  [+0x0DE6F]  00 00                    add     [bx+si],al
F000:5E71  [+0x0DE71]  00 00                    add     [bx+si],al
F000:5E73  [+0x0DE73]  00 00                    add     [bx+si],al
F000:5E75  [+0x0DE75]  00 00                    add     [bx+si],al
F000:5E77  [+0x0DE77]  00 00                    add     [bx+si],al
F000:5E79  [+0x0DE79]  00 00                    add     [bx+si],al
F000:5E7B  [+0x0DE7B]  00 00                    add     [bx+si],al
F000:5E7D  [+0x0DE7D]  00 00                    add     [bx+si],al
F000:5E7F  [+0x0DE7F]  00 00                    add     [bx+si],al
F000:5E81  [+0x0DE81]  00 00                    add     [bx+si],al
F000:5E83  [+0x0DE83]  00 00                    add     [bx+si],al
F000:5E85  [+0x0DE85]  00 00                    add     [bx+si],al
F000:5E87  [+0x0DE87]  00 00                    add     [bx+si],al
F000:5E89  [+0x0DE89]  00 00                    add     [bx+si],al
F000:5E8B  [+0x0DE8B]  00 00                    add     [bx+si],al
F000:5E8D  [+0x0DE8D]  00 00                    add     [bx+si],al
F000:5E8F  [+0x0DE8F]  00 00                    add     [bx+si],al
F000:5E91  [+0x0DE91]  00 00                    add     [bx+si],al
F000:5E93  [+0x0DE93]  00 00                    add     [bx+si],al
F000:5E95  [+0x0DE95]  00 00                    add     [bx+si],al
F000:5E97  [+0x0DE97]  00 00                    add     [bx+si],al
F000:5E99  [+0x0DE99]  00 00                    add     [bx+si],al
F000:5E9B  [+0x0DE9B]  00 00                    add     [bx+si],al
F000:5E9D  [+0x0DE9D]  00 00                    add     [bx+si],al
F000:5E9F  [+0x0DE9F]  00 00                    add     [bx+si],al
F000:5EA1  [+0x0DEA1]  00 00                    add     [bx+si],al
F000:5EA3  [+0x0DEA3]  00 00                    add     [bx+si],al
F000:5EA5  [+0x0DEA5]  00 00                    add     [bx+si],al
F000:5EA7  [+0x0DEA7]  00 00                    add     [bx+si],al
F000:5EA9  [+0x0DEA9]  00 00                    add     [bx+si],al
F000:5EAB  [+0x0DEAB]  00 00                    add     [bx+si],al
F000:5EAD  [+0x0DEAD]  00 00                    add     [bx+si],al
F000:5EAF  [+0x0DEAF]  00 00                    add     [bx+si],al
F000:5EB1  [+0x0DEB1]  00 00                    add     [bx+si],al
F000:5EB3  [+0x0DEB3]  00 00                    add     [bx+si],al
F000:5EB5  [+0x0DEB5]  00 00                    add     [bx+si],al
F000:5EB7  [+0x0DEB7]  00 00                    add     [bx+si],al
F000:5EB9  [+0x0DEB9]  00 00                    add     [bx+si],al
F000:5EBB  [+0x0DEBB]  00 00                    add     [bx+si],al
F000:5EBD  [+0x0DEBD]  00 00                    add     [bx+si],al
F000:5EBF  [+0x0DEBF]  00 00                    add     [bx+si],al
F000:5EC1  [+0x0DEC1]  00 00                    add     [bx+si],al
F000:5EC3  [+0x0DEC3]  00 00                    add     [bx+si],al
F000:5EC5  [+0x0DEC5]  00 00                    add     [bx+si],al
F000:5EC7  [+0x0DEC7]  00 00                    add     [bx+si],al
F000:5EC9  [+0x0DEC9]  00 00                    add     [bx+si],al
F000:5ECB  [+0x0DECB]  00 00                    add     [bx+si],al
F000:5ECD  [+0x0DECD]  00 00                    add     [bx+si],al
F000:5ECF  [+0x0DECF]  00 00                    add     [bx+si],al
F000:5ED1  [+0x0DED1]  00 00                    add     [bx+si],al
F000:5ED3  [+0x0DED3]  00 00                    add     [bx+si],al
F000:5ED5  [+0x0DED5]  00 00                    add     [bx+si],al
F000:5ED7  [+0x0DED7]  00 00                    add     [bx+si],al
F000:5ED9  [+0x0DED9]  00 00                    add     [bx+si],al
F000:5EDB  [+0x0DEDB]  00 00                    add     [bx+si],al
F000:5EDD  [+0x0DEDD]  00 00                    add     [bx+si],al
F000:5EDF  [+0x0DEDF]  00 00                    add     [bx+si],al
F000:5EE1  [+0x0DEE1]  00 00                    add     [bx+si],al
F000:5EE3  [+0x0DEE3]  00 00                    add     [bx+si],al
F000:5EE5  [+0x0DEE5]  00 00                    add     [bx+si],al
F000:5EE7  [+0x0DEE7]  00 00                    add     [bx+si],al
F000:5EE9  [+0x0DEE9]  00 00                    add     [bx+si],al
F000:5EEB  [+0x0DEEB]  00 00                    add     [bx+si],al
F000:5EED  [+0x0DEED]  00 00                    add     [bx+si],al
F000:5EEF  [+0x0DEEF]  00 00                    add     [bx+si],al
F000:5EF1  [+0x0DEF1]  00 00                    add     [bx+si],al
F000:5EF3  [+0x0DEF3]  00 00                    add     [bx+si],al
F000:5EF5  [+0x0DEF5]  00 00                    add     [bx+si],al
F000:5EF7  [+0x0DEF7]  00 00                    add     [bx+si],al
F000:5EF9  [+0x0DEF9]  00 00                    add     [bx+si],al
F000:5EFB  [+0x0DEFB]  00 00                    add     [bx+si],al
F000:5EFD  [+0x0DEFD]  00 00                    add     [bx+si],al
F000:5EFF  [+0x0DEFF]  00 00                    add     [bx+si],al
F000:5F01  [+0x0DF01]  00 00                    add     [bx+si],al
F000:5F03  [+0x0DF03]  00 00                    add     [bx+si],al
F000:5F05  [+0x0DF05]  00 00                    add     [bx+si],al
F000:5F07  [+0x0DF07]  00 00                    add     [bx+si],al
F000:5F09  [+0x0DF09]  00 00                    add     [bx+si],al
F000:5F0B  [+0x0DF0B]  00 00                    add     [bx+si],al
F000:5F0D  [+0x0DF0D]  00 00                    add     [bx+si],al
F000:5F0F  [+0x0DF0F]  00 00                    add     [bx+si],al
F000:5F11  [+0x0DF11]  00 00                    add     [bx+si],al
F000:5F13  [+0x0DF13]  00 00                    add     [bx+si],al
F000:5F15  [+0x0DF15]  00 00                    add     [bx+si],al
F000:5F17  [+0x0DF17]  00 00                    add     [bx+si],al
F000:5F19  [+0x0DF19]  00 00                    add     [bx+si],al
F000:5F1B  [+0x0DF1B]  00 00                    add     [bx+si],al
F000:5F1D  [+0x0DF1D]  00 00                    add     [bx+si],al
F000:5F1F  [+0x0DF1F]  00 00                    add     [bx+si],al
F000:5F21  [+0x0DF21]  00 00                    add     [bx+si],al
F000:5F23  [+0x0DF23]  00 00                    add     [bx+si],al
F000:5F25  [+0x0DF25]  00 00                    add     [bx+si],al
F000:5F27  [+0x0DF27]  00 00                    add     [bx+si],al
F000:5F29  [+0x0DF29]  00 00                    add     [bx+si],al
F000:5F2B  [+0x0DF2B]  00 00                    add     [bx+si],al
F000:5F2D  [+0x0DF2D]  00 00                    add     [bx+si],al
F000:5F2F  [+0x0DF2F]  00 00                    add     [bx+si],al
F000:5F31  [+0x0DF31]  00 00                    add     [bx+si],al
F000:5F33  [+0x0DF33]  00 00                    add     [bx+si],al
F000:5F35  [+0x0DF35]  00 00                    add     [bx+si],al
F000:5F37  [+0x0DF37]  00 00                    add     [bx+si],al
F000:5F39  [+0x0DF39]  00 00                    add     [bx+si],al
F000:5F3B  [+0x0DF3B]  00 00                    add     [bx+si],al
F000:5F3D  [+0x0DF3D]  00 00                    add     [bx+si],al
F000:5F3F  [+0x0DF3F]  00 00                    add     [bx+si],al
F000:5F41  [+0x0DF41]  00 00                    add     [bx+si],al
F000:5F43  [+0x0DF43]  00 00                    add     [bx+si],al
F000:5F45  [+0x0DF45]  00 00                    add     [bx+si],al
F000:5F47  [+0x0DF47]  00 00                    add     [bx+si],al
F000:5F49  [+0x0DF49]  00 00                    add     [bx+si],al
F000:5F4B  [+0x0DF4B]  00 00                    add     [bx+si],al
F000:5F4D  [+0x0DF4D]  00 00                    add     [bx+si],al
F000:5F4F  [+0x0DF4F]  00 00                    add     [bx+si],al
F000:5F51  [+0x0DF51]  00 00                    add     [bx+si],al
F000:5F53  [+0x0DF53]  00 00                    add     [bx+si],al
F000:5F55  [+0x0DF55]  00 00                    add     [bx+si],al
F000:5F57  [+0x0DF57]  00 00                    add     [bx+si],al
F000:5F59  [+0x0DF59]  00 00                    add     [bx+si],al
F000:5F5B  [+0x0DF5B]  00 00                    add     [bx+si],al
F000:5F5D  [+0x0DF5D]  00 00                    add     [bx+si],al
F000:5F5F  [+0x0DF5F]  00 00                    add     [bx+si],al
F000:5F61  [+0x0DF61]  00 00                    add     [bx+si],al
F000:5F63  [+0x0DF63]  00 00                    add     [bx+si],al
F000:5F65  [+0x0DF65]  00 00                    add     [bx+si],al
F000:5F67  [+0x0DF67]  00 00                    add     [bx+si],al
F000:5F69  [+0x0DF69]  00 00                    add     [bx+si],al
F000:5F6B  [+0x0DF6B]  00 00                    add     [bx+si],al
F000:5F6D  [+0x0DF6D]  00 00                    add     [bx+si],al
F000:5F6F  [+0x0DF6F]  00 00                    add     [bx+si],al
F000:5F71  [+0x0DF71]  00 00                    add     [bx+si],al
F000:5F73  [+0x0DF73]  00 00                    add     [bx+si],al
F000:5F75  [+0x0DF75]  00 00                    add     [bx+si],al
F000:5F77  [+0x0DF77]  00 00                    add     [bx+si],al
F000:5F79  [+0x0DF79]  00 00                    add     [bx+si],al
F000:5F7B  [+0x0DF7B]  00 00                    add     [bx+si],al
F000:5F7D  [+0x0DF7D]  00 00                    add     [bx+si],al
F000:5F7F  [+0x0DF7F]  00 00                    add     [bx+si],al
F000:5F81  [+0x0DF81]  00 00                    add     [bx+si],al
F000:5F83  [+0x0DF83]  00 00                    add     [bx+si],al
F000:5F85  [+0x0DF85]  00 00                    add     [bx+si],al
F000:5F87  [+0x0DF87]  00 00                    add     [bx+si],al
F000:5F89  [+0x0DF89]  00 00                    add     [bx+si],al
F000:5F8B  [+0x0DF8B]  00 00                    add     [bx+si],al
F000:5F8D  [+0x0DF8D]  00 00                    add     [bx+si],al
F000:5F8F  [+0x0DF8F]  00 00                    add     [bx+si],al
F000:5F91  [+0x0DF91]  00 00                    add     [bx+si],al
F000:5F93  [+0x0DF93]  00 00                    add     [bx+si],al
F000:5F95  [+0x0DF95]  00 00                    add     [bx+si],al
F000:5F97  [+0x0DF97]  00 00                    add     [bx+si],al
F000:5F99  [+0x0DF99]  00 00                    add     [bx+si],al
F000:5F9B  [+0x0DF9B]  00 00                    add     [bx+si],al
F000:5F9D  [+0x0DF9D]  00 00                    add     [bx+si],al
F000:5F9F  [+0x0DF9F]  00 00                    add     [bx+si],al
F000:5FA1  [+0x0DFA1]  00 00                    add     [bx+si],al
F000:5FA3  [+0x0DFA3]  00 00                    add     [bx+si],al
F000:5FA5  [+0x0DFA5]  00 00                    add     [bx+si],al
F000:5FA7  [+0x0DFA7]  00 00                    add     [bx+si],al
F000:5FA9  [+0x0DFA9]  00 00                    add     [bx+si],al
F000:5FAB  [+0x0DFAB]  00 00                    add     [bx+si],al
F000:5FAD  [+0x0DFAD]  00 00                    add     [bx+si],al
F000:5FAF  [+0x0DFAF]  00 00                    add     [bx+si],al
F000:5FB1  [+0x0DFB1]  00 00                    add     [bx+si],al
F000:5FB3  [+0x0DFB3]  00 00                    add     [bx+si],al
F000:5FB5  [+0x0DFB5]  00 00                    add     [bx+si],al
F000:5FB7  [+0x0DFB7]  00 00                    add     [bx+si],al
F000:5FB9  [+0x0DFB9]  00 00                    add     [bx+si],al
F000:5FBB  [+0x0DFBB]  00 00                    add     [bx+si],al
F000:5FBD  [+0x0DFBD]  00 00                    add     [bx+si],al
F000:5FBF  [+0x0DFBF]  00 00                    add     [bx+si],al
F000:5FC1  [+0x0DFC1]  00 00                    add     [bx+si],al
F000:5FC3  [+0x0DFC3]  00 00                    add     [bx+si],al
F000:5FC5  [+0x0DFC5]  00 00                    add     [bx+si],al
F000:5FC7  [+0x0DFC7]  00 00                    add     [bx+si],al
F000:5FC9  [+0x0DFC9]  00 00                    add     [bx+si],al
F000:5FCB  [+0x0DFCB]  00 00                    add     [bx+si],al
F000:5FCD  [+0x0DFCD]  00 00                    add     [bx+si],al
F000:5FCF  [+0x0DFCF]  00 00                    add     [bx+si],al
F000:5FD1  [+0x0DFD1]  00 00                    add     [bx+si],al
F000:5FD3  [+0x0DFD3]  00 00                    add     [bx+si],al
F000:5FD5  [+0x0DFD5]  00 00                    add     [bx+si],al
F000:5FD7  [+0x0DFD7]  00 00                    add     [bx+si],al
F000:5FD9  [+0x0DFD9]  00 00                    add     [bx+si],al
F000:5FDB  [+0x0DFDB]  00 00                    add     [bx+si],al
F000:5FDD  [+0x0DFDD]  00 00                    add     [bx+si],al
F000:5FDF  [+0x0DFDF]  00 00                    add     [bx+si],al
F000:5FE1  [+0x0DFE1]  00 00                    add     [bx+si],al
F000:5FE3  [+0x0DFE3]  00 00                    add     [bx+si],al
F000:5FE5  [+0x0DFE5]  00 00                    add     [bx+si],al
F000:5FE7  [+0x0DFE7]  00 00                    add     [bx+si],al
F000:5FE9  [+0x0DFE9]  00 00                    add     [bx+si],al
F000:5FEB  [+0x0DFEB]  00 00                    add     [bx+si],al
F000:5FED  [+0x0DFED]  00 00                    add     [bx+si],al
F000:5FEF  [+0x0DFEF]  00 00                    add     [bx+si],al
F000:5FF1  [+0x0DFF1]  00 00                    add     [bx+si],al
F000:5FF3  [+0x0DFF3]  00 00                    add     [bx+si],al
F000:5FF5  [+0x0DFF5]  00 00                    add     [bx+si],al
F000:5FF7  [+0x0DFF7]  00 00                    add     [bx+si],al
F000:5FF9  [+0x0DFF9]  00 00                    add     [bx+si],al
F000:5FFB  [+0x0DFFB]  00 00                    add     [bx+si],al
F000:5FFD  [+0x0DFFD]  00 00                    add     [bx+si],al
F000:5FFF  [+0x0DFFF]  00 00                    add     [bx+si],al
F000:6001  [+0x0E001]  00 00                    add     [bx+si],al
F000:6003  [+0x0E003]  00 00                    add     [bx+si],al
F000:6005  [+0x0E005]  00 00                    add     [bx+si],al
F000:6007  [+0x0E007]  00 00                    add     [bx+si],al
F000:6009  [+0x0E009]  00 00                    add     [bx+si],al
F000:600B  [+0x0E00B]  00 00                    add     [bx+si],al
F000:600D  [+0x0E00D]  00 00                    add     [bx+si],al
F000:600F  [+0x0E00F]  00 00                    add     [bx+si],al
F000:6011  [+0x0E011]  00 00                    add     [bx+si],al
F000:6013  [+0x0E013]  00 00                    add     [bx+si],al
F000:6015  [+0x0E015]  00 00                    add     [bx+si],al
F000:6017  [+0x0E017]  00 00                    add     [bx+si],al
F000:6019  [+0x0E019]  00 00                    add     [bx+si],al
F000:601B  [+0x0E01B]  00 00                    add     [bx+si],al
F000:601D  [+0x0E01D]  00 00                    add     [bx+si],al
F000:601F  [+0x0E01F]  00 00                    add     [bx+si],al
F000:6021  [+0x0E021]  00 00                    add     [bx+si],al
F000:6023  [+0x0E023]  00 00                    add     [bx+si],al
F000:6025  [+0x0E025]  00 00                    add     [bx+si],al
F000:6027  [+0x0E027]  00 00                    add     [bx+si],al
F000:6029  [+0x0E029]  00 00                    add     [bx+si],al
F000:602B  [+0x0E02B]  00 00                    add     [bx+si],al
F000:602D  [+0x0E02D]  00 00                    add     [bx+si],al
F000:602F  [+0x0E02F]  00 00                    add     [bx+si],al
F000:6031  [+0x0E031]  00 00                    add     [bx+si],al
F000:6033  [+0x0E033]  00 00                    add     [bx+si],al
F000:6035  [+0x0E035]  00 00                    add     [bx+si],al
F000:6037  [+0x0E037]  00 00                    add     [bx+si],al
F000:6039  [+0x0E039]  00 00                    add     [bx+si],al
F000:603B  [+0x0E03B]  00 00                    add     [bx+si],al
F000:603D  [+0x0E03D]  00 00                    add     [bx+si],al
F000:603F  [+0x0E03F]  00 00                    add     [bx+si],al
F000:6041  [+0x0E041]  00 00                    add     [bx+si],al
F000:6043  [+0x0E043]  00 00                    add     [bx+si],al
F000:6045  [+0x0E045]  00 00                    add     [bx+si],al
F000:6047  [+0x0E047]  00 00                    add     [bx+si],al
F000:6049  [+0x0E049]  00 00                    add     [bx+si],al
F000:604B  [+0x0E04B]  00 00                    add     [bx+si],al
F000:604D  [+0x0E04D]  00 00                    add     [bx+si],al
F000:604F  [+0x0E04F]  00 00                    add     [bx+si],al
F000:6051  [+0x0E051]  00 00                    add     [bx+si],al
F000:6053  [+0x0E053]  00 00                    add     [bx+si],al
F000:6055  [+0x0E055]  00 00                    add     [bx+si],al
F000:6057  [+0x0E057]  00 00                    add     [bx+si],al
F000:6059  [+0x0E059]  00 00                    add     [bx+si],al
F000:605B  [+0x0E05B]  00 00                    add     [bx+si],al
F000:605D  [+0x0E05D]  00 00                    add     [bx+si],al
F000:605F  [+0x0E05F]  00 00                    add     [bx+si],al
F000:6061  [+0x0E061]  00 00                    add     [bx+si],al
F000:6063  [+0x0E063]  00 00                    add     [bx+si],al
F000:6065  [+0x0E065]  00 00                    add     [bx+si],al
F000:6067  [+0x0E067]  00 00                    add     [bx+si],al
F000:6069  [+0x0E069]  00 00                    add     [bx+si],al
F000:606B  [+0x0E06B]  00 00                    add     [bx+si],al
F000:606D  [+0x0E06D]  00 00                    add     [bx+si],al
F000:606F  [+0x0E06F]  00 00                    add     [bx+si],al
F000:6071  [+0x0E071]  00 00                    add     [bx+si],al
F000:6073  [+0x0E073]  00 00                    add     [bx+si],al
F000:6075  [+0x0E075]  00 00                    add     [bx+si],al
F000:6077  [+0x0E077]  00 00                    add     [bx+si],al
F000:6079  [+0x0E079]  00 00                    add     [bx+si],al
F000:607B  [+0x0E07B]  00 00                    add     [bx+si],al
F000:607D  [+0x0E07D]  00 00                    add     [bx+si],al
F000:607F  [+0x0E07F]  00 00                    add     [bx+si],al
F000:6081  [+0x0E081]  00 00                    add     [bx+si],al
F000:6083  [+0x0E083]  00 00                    add     [bx+si],al
F000:6085  [+0x0E085]  00 00                    add     [bx+si],al
F000:6087  [+0x0E087]  00 00                    add     [bx+si],al
F000:6089  [+0x0E089]  00 00                    add     [bx+si],al
F000:608B  [+0x0E08B]  00 00                    add     [bx+si],al
F000:608D  [+0x0E08D]  00 00                    add     [bx+si],al
F000:608F  [+0x0E08F]  00 00                    add     [bx+si],al
F000:6091  [+0x0E091]  00 00                    add     [bx+si],al
F000:6093  [+0x0E093]  00 00                    add     [bx+si],al
F000:6095  [+0x0E095]  00 00                    add     [bx+si],al
F000:6097  [+0x0E097]  00 00                    add     [bx+si],al
F000:6099  [+0x0E099]  00 00                    add     [bx+si],al
F000:609B  [+0x0E09B]  00 00                    add     [bx+si],al
F000:609D  [+0x0E09D]  00 00                    add     [bx+si],al
F000:609F  [+0x0E09F]  00 00                    add     [bx+si],al
F000:60A1  [+0x0E0A1]  00 00                    add     [bx+si],al
F000:60A3  [+0x0E0A3]  00 00                    add     [bx+si],al
F000:60A5  [+0x0E0A5]  00 00                    add     [bx+si],al
F000:60A7  [+0x0E0A7]  00 00                    add     [bx+si],al
F000:60A9  [+0x0E0A9]  00 00                    add     [bx+si],al
F000:60AB  [+0x0E0AB]  00 00                    add     [bx+si],al
F000:60AD  [+0x0E0AD]  00 00                    add     [bx+si],al
F000:60AF  [+0x0E0AF]  00 00                    add     [bx+si],al
F000:60B1  [+0x0E0B1]  00 00                    add     [bx+si],al
F000:60B3  [+0x0E0B3]  00 00                    add     [bx+si],al
F000:60B5  [+0x0E0B5]  00 00                    add     [bx+si],al
F000:60B7  [+0x0E0B7]  00 00                    add     [bx+si],al
F000:60B9  [+0x0E0B9]  00 00                    add     [bx+si],al
F000:60BB  [+0x0E0BB]  00 00                    add     [bx+si],al
F000:60BD  [+0x0E0BD]  00 00                    add     [bx+si],al
F000:60BF  [+0x0E0BF]  00 00                    add     [bx+si],al
F000:60C1  [+0x0E0C1]  00 00                    add     [bx+si],al
F000:60C3  [+0x0E0C3]  00 00                    add     [bx+si],al
F000:60C5  [+0x0E0C5]  00 00                    add     [bx+si],al
F000:60C7  [+0x0E0C7]  00 00                    add     [bx+si],al
F000:60C9  [+0x0E0C9]  00 00                    add     [bx+si],al
F000:60CB  [+0x0E0CB]  00 00                    add     [bx+si],al
F000:60CD  [+0x0E0CD]  00 00                    add     [bx+si],al
F000:60CF  [+0x0E0CF]  00 00                    add     [bx+si],al
F000:60D1  [+0x0E0D1]  00 00                    add     [bx+si],al
F000:60D3  [+0x0E0D3]  00 00                    add     [bx+si],al
F000:60D5  [+0x0E0D5]  00 00                    add     [bx+si],al
F000:60D7  [+0x0E0D7]  00 00                    add     [bx+si],al
F000:60D9  [+0x0E0D9]  00 00                    add     [bx+si],al
F000:60DB  [+0x0E0DB]  00 00                    add     [bx+si],al
F000:60DD  [+0x0E0DD]  00 00                    add     [bx+si],al
F000:60DF  [+0x0E0DF]  00 00                    add     [bx+si],al
F000:60E1  [+0x0E0E1]  00 00                    add     [bx+si],al
F000:60E3  [+0x0E0E3]  00 00                    add     [bx+si],al
F000:60E5  [+0x0E0E5]  00 00                    add     [bx+si],al
F000:60E7  [+0x0E0E7]  00 00                    add     [bx+si],al
F000:60E9  [+0x0E0E9]  00 00                    add     [bx+si],al
F000:60EB  [+0x0E0EB]  00 00                    add     [bx+si],al
F000:60ED  [+0x0E0ED]  00 00                    add     [bx+si],al
F000:60EF  [+0x0E0EF]  00 00                    add     [bx+si],al
F000:60F1  [+0x0E0F1]  00 00                    add     [bx+si],al
F000:60F3  [+0x0E0F3]  00 00                    add     [bx+si],al
F000:60F5  [+0x0E0F5]  00 00                    add     [bx+si],al
F000:60F7  [+0x0E0F7]  00 00                    add     [bx+si],al
F000:60F9  [+0x0E0F9]  00 00                    add     [bx+si],al
F000:60FB  [+0x0E0FB]  00 00                    add     [bx+si],al
F000:60FD  [+0x0E0FD]  00 00                    add     [bx+si],al
F000:60FF  [+0x0E0FF]  00 00                    add     [bx+si],al
F000:6101  [+0x0E101]  00 00                    add     [bx+si],al
F000:6103  [+0x0E103]  00 00                    add     [bx+si],al
F000:6105  [+0x0E105]  00 00                    add     [bx+si],al
F000:6107  [+0x0E107]  00 00                    add     [bx+si],al
F000:6109  [+0x0E109]  00 00                    add     [bx+si],al
F000:610B  [+0x0E10B]  00 00                    add     [bx+si],al
F000:610D  [+0x0E10D]  00 00                    add     [bx+si],al
F000:610F  [+0x0E10F]  00 00                    add     [bx+si],al
F000:6111  [+0x0E111]  00 00                    add     [bx+si],al
F000:6113  [+0x0E113]  00 00                    add     [bx+si],al
F000:6115  [+0x0E115]  00 00                    add     [bx+si],al
F000:6117  [+0x0E117]  00 00                    add     [bx+si],al
F000:6119  [+0x0E119]  00 00                    add     [bx+si],al
F000:611B  [+0x0E11B]  00 00                    add     [bx+si],al
F000:611D  [+0x0E11D]  00 00                    add     [bx+si],al
F000:611F  [+0x0E11F]  00 00                    add     [bx+si],al
F000:6121  [+0x0E121]  00 00                    add     [bx+si],al
F000:6123  [+0x0E123]  00 00                    add     [bx+si],al
F000:6125  [+0x0E125]  00 00                    add     [bx+si],al
F000:6127  [+0x0E127]  00 00                    add     [bx+si],al
F000:6129  [+0x0E129]  00 00                    add     [bx+si],al
F000:612B  [+0x0E12B]  00 00                    add     [bx+si],al
F000:612D  [+0x0E12D]  00 00                    add     [bx+si],al
F000:612F  [+0x0E12F]  00 00                    add     [bx+si],al
F000:6131  [+0x0E131]  00 00                    add     [bx+si],al
F000:6133  [+0x0E133]  00 00                    add     [bx+si],al
F000:6135  [+0x0E135]  00 00                    add     [bx+si],al
F000:6137  [+0x0E137]  00 00                    add     [bx+si],al
F000:6139  [+0x0E139]  00 00                    add     [bx+si],al
F000:613B  [+0x0E13B]  00 00                    add     [bx+si],al
F000:613D  [+0x0E13D]  00 00                    add     [bx+si],al
F000:613F  [+0x0E13F]  00 00                    add     [bx+si],al
F000:6141  [+0x0E141]  00 00                    add     [bx+si],al
F000:6143  [+0x0E143]  00 00                    add     [bx+si],al
F000:6145  [+0x0E145]  00 00                    add     [bx+si],al
F000:6147  [+0x0E147]  00 00                    add     [bx+si],al
F000:6149  [+0x0E149]  00 00                    add     [bx+si],al
F000:614B  [+0x0E14B]  00 00                    add     [bx+si],al
F000:614D  [+0x0E14D]  00 00                    add     [bx+si],al
F000:614F  [+0x0E14F]  00 00                    add     [bx+si],al
F000:6151  [+0x0E151]  00 00                    add     [bx+si],al
F000:6153  [+0x0E153]  00 00                    add     [bx+si],al
F000:6155  [+0x0E155]  00 00                    add     [bx+si],al
F000:6157  [+0x0E157]  00 00                    add     [bx+si],al
F000:6159  [+0x0E159]  00 00                    add     [bx+si],al
F000:615B  [+0x0E15B]  00 00                    add     [bx+si],al
F000:615D  [+0x0E15D]  00 00                    add     [bx+si],al
F000:615F  [+0x0E15F]  00 00                    add     [bx+si],al
F000:6161  [+0x0E161]  00 00                    add     [bx+si],al
F000:6163  [+0x0E163]  00 00                    add     [bx+si],al
F000:6165  [+0x0E165]  00 00                    add     [bx+si],al
F000:6167  [+0x0E167]  00 00                    add     [bx+si],al
F000:6169  [+0x0E169]  00 00                    add     [bx+si],al
F000:616B  [+0x0E16B]  00 00                    add     [bx+si],al
F000:616D  [+0x0E16D]  00 00                    add     [bx+si],al
F000:616F  [+0x0E16F]  00 00                    add     [bx+si],al
F000:6171  [+0x0E171]  00 00                    add     [bx+si],al
F000:6173  [+0x0E173]  00 00                    add     [bx+si],al
F000:6175  [+0x0E175]  00 00                    add     [bx+si],al
F000:6177  [+0x0E177]  00 00                    add     [bx+si],al
F000:6179  [+0x0E179]  00 00                    add     [bx+si],al
F000:617B  [+0x0E17B]  00 00                    add     [bx+si],al
F000:617D  [+0x0E17D]  00 00                    add     [bx+si],al
F000:617F  [+0x0E17F]  00 00                    add     [bx+si],al
F000:6181  [+0x0E181]  00 00                    add     [bx+si],al
F000:6183  [+0x0E183]  00 00                    add     [bx+si],al
F000:6185  [+0x0E185]  00 00                    add     [bx+si],al
F000:6187  [+0x0E187]  00 00                    add     [bx+si],al
F000:6189  [+0x0E189]  00 00                    add     [bx+si],al
F000:618B  [+0x0E18B]  00 00                    add     [bx+si],al
F000:618D  [+0x0E18D]  00 00                    add     [bx+si],al
F000:618F  [+0x0E18F]  00 00                    add     [bx+si],al
F000:6191  [+0x0E191]  00 00                    add     [bx+si],al
F000:6193  [+0x0E193]  00 00                    add     [bx+si],al
F000:6195  [+0x0E195]  00 00                    add     [bx+si],al
F000:6197  [+0x0E197]  00 00                    add     [bx+si],al
F000:6199  [+0x0E199]  00 00                    add     [bx+si],al
F000:619B  [+0x0E19B]  00 00                    add     [bx+si],al
F000:619D  [+0x0E19D]  00 00                    add     [bx+si],al
F000:619F  [+0x0E19F]  00 00                    add     [bx+si],al
F000:61A1  [+0x0E1A1]  00 00                    add     [bx+si],al
F000:61A3  [+0x0E1A3]  00 00                    add     [bx+si],al
F000:61A5  [+0x0E1A5]  00 00                    add     [bx+si],al
F000:61A7  [+0x0E1A7]  00 00                    add     [bx+si],al
F000:61A9  [+0x0E1A9]  00 00                    add     [bx+si],al
F000:61AB  [+0x0E1AB]  00 00                    add     [bx+si],al
F000:61AD  [+0x0E1AD]  00 00                    add     [bx+si],al
F000:61AF  [+0x0E1AF]  00 00                    add     [bx+si],al
F000:61B1  [+0x0E1B1]  00 00                    add     [bx+si],al
F000:61B3  [+0x0E1B3]  00 00                    add     [bx+si],al
F000:61B5  [+0x0E1B5]  00 00                    add     [bx+si],al
F000:61B7  [+0x0E1B7]  00 00                    add     [bx+si],al
F000:61B9  [+0x0E1B9]  00 00                    add     [bx+si],al
F000:61BB  [+0x0E1BB]  00 00                    add     [bx+si],al
F000:61BD  [+0x0E1BD]  00 00                    add     [bx+si],al
F000:61BF  [+0x0E1BF]  00 00                    add     [bx+si],al
F000:61C1  [+0x0E1C1]  00 00                    add     [bx+si],al
F000:61C3  [+0x0E1C3]  00 00                    add     [bx+si],al
F000:61C5  [+0x0E1C5]  00 00                    add     [bx+si],al
F000:61C7  [+0x0E1C7]  00 00                    add     [bx+si],al
F000:61C9  [+0x0E1C9]  00 00                    add     [bx+si],al
F000:61CB  [+0x0E1CB]  00 00                    add     [bx+si],al
F000:61CD  [+0x0E1CD]  00 00                    add     [bx+si],al
F000:61CF  [+0x0E1CF]  00 00                    add     [bx+si],al
F000:61D1  [+0x0E1D1]  00 00                    add     [bx+si],al
F000:61D3  [+0x0E1D3]  00 00                    add     [bx+si],al
F000:61D5  [+0x0E1D5]  00 00                    add     [bx+si],al
F000:61D7  [+0x0E1D7]  00 00                    add     [bx+si],al
F000:61D9  [+0x0E1D9]  00 00                    add     [bx+si],al
F000:61DB  [+0x0E1DB]  00 00                    add     [bx+si],al
F000:61DD  [+0x0E1DD]  00 00                    add     [bx+si],al
F000:61DF  [+0x0E1DF]  00 00                    add     [bx+si],al
F000:61E1  [+0x0E1E1]  00 00                    add     [bx+si],al
F000:61E3  [+0x0E1E3]  00 00                    add     [bx+si],al
F000:61E5  [+0x0E1E5]  00 00                    add     [bx+si],al
F000:61E7  [+0x0E1E7]  00 00                    add     [bx+si],al
F000:61E9  [+0x0E1E9]  00 00                    add     [bx+si],al
F000:61EB  [+0x0E1EB]  00 00                    add     [bx+si],al
F000:61ED  [+0x0E1ED]  00 00                    add     [bx+si],al
F000:61EF  [+0x0E1EF]  00 00                    add     [bx+si],al
F000:61F1  [+0x0E1F1]  00 00                    add     [bx+si],al
F000:61F3  [+0x0E1F3]  00 00                    add     [bx+si],al
F000:61F5  [+0x0E1F5]  00 00                    add     [bx+si],al
F000:61F7  [+0x0E1F7]  00 00                    add     [bx+si],al
F000:61F9  [+0x0E1F9]  00 00                    add     [bx+si],al
F000:61FB  [+0x0E1FB]  00 00                    add     [bx+si],al
F000:61FD  [+0x0E1FD]  00 00                    add     [bx+si],al
F000:61FF  [+0x0E1FF]  00 00                    add     [bx+si],al
F000:6201  [+0x0E201]  00 00                    add     [bx+si],al
F000:6203  [+0x0E203]  00 00                    add     [bx+si],al
F000:6205  [+0x0E205]  00 00                    add     [bx+si],al
F000:6207  [+0x0E207]  00 00                    add     [bx+si],al
F000:6209  [+0x0E209]  00 00                    add     [bx+si],al
F000:620B  [+0x0E20B]  00 00                    add     [bx+si],al
F000:620D  [+0x0E20D]  00 00                    add     [bx+si],al
F000:620F  [+0x0E20F]  00 00                    add     [bx+si],al
F000:6211  [+0x0E211]  00 00                    add     [bx+si],al
F000:6213  [+0x0E213]  00 00                    add     [bx+si],al
F000:6215  [+0x0E215]  00 00                    add     [bx+si],al
F000:6217  [+0x0E217]  00 00                    add     [bx+si],al
F000:6219  [+0x0E219]  00 00                    add     [bx+si],al
F000:621B  [+0x0E21B]  00 00                    add     [bx+si],al
F000:621D  [+0x0E21D]  00 00                    add     [bx+si],al
F000:621F  [+0x0E21F]  00 00                    add     [bx+si],al
F000:6221  [+0x0E221]  00 00                    add     [bx+si],al
F000:6223  [+0x0E223]  00 00                    add     [bx+si],al
F000:6225  [+0x0E225]  00 00                    add     [bx+si],al
F000:6227  [+0x0E227]  00 00                    add     [bx+si],al
F000:6229  [+0x0E229]  00 00                    add     [bx+si],al
F000:622B  [+0x0E22B]  00 00                    add     [bx+si],al
F000:622D  [+0x0E22D]  00 00                    add     [bx+si],al
F000:622F  [+0x0E22F]  00 00                    add     [bx+si],al
F000:6231  [+0x0E231]  00 00                    add     [bx+si],al
F000:6233  [+0x0E233]  00 00                    add     [bx+si],al
F000:6235  [+0x0E235]  00 00                    add     [bx+si],al
F000:6237  [+0x0E237]  00 00                    add     [bx+si],al
F000:6239  [+0x0E239]  00 00                    add     [bx+si],al
F000:623B  [+0x0E23B]  00 00                    add     [bx+si],al
F000:623D  [+0x0E23D]  00 00                    add     [bx+si],al
F000:623F  [+0x0E23F]  00 00                    add     [bx+si],al
F000:6241  [+0x0E241]  00 00                    add     [bx+si],al
F000:6243  [+0x0E243]  00 00                    add     [bx+si],al
F000:6245  [+0x0E245]  00 00                    add     [bx+si],al
F000:6247  [+0x0E247]  00 00                    add     [bx+si],al
F000:6249  [+0x0E249]  00 00                    add     [bx+si],al
F000:624B  [+0x0E24B]  00 00                    add     [bx+si],al
F000:624D  [+0x0E24D]  00 00                    add     [bx+si],al
F000:624F  [+0x0E24F]  00 00                    add     [bx+si],al
F000:6251  [+0x0E251]  00 00                    add     [bx+si],al
F000:6253  [+0x0E253]  00 00                    add     [bx+si],al
F000:6255  [+0x0E255]  00 00                    add     [bx+si],al
F000:6257  [+0x0E257]  00 00                    add     [bx+si],al
F000:6259  [+0x0E259]  00 00                    add     [bx+si],al
F000:625B  [+0x0E25B]  00 00                    add     [bx+si],al
F000:625D  [+0x0E25D]  00 00                    add     [bx+si],al
F000:625F  [+0x0E25F]  00 00                    add     [bx+si],al
F000:6261  [+0x0E261]  00 00                    add     [bx+si],al
F000:6263  [+0x0E263]  00 00                    add     [bx+si],al
F000:6265  [+0x0E265]  00 00                    add     [bx+si],al
F000:6267  [+0x0E267]  00 00                    add     [bx+si],al
F000:6269  [+0x0E269]  00 00                    add     [bx+si],al
F000:626B  [+0x0E26B]  00 00                    add     [bx+si],al
F000:626D  [+0x0E26D]  00 00                    add     [bx+si],al
F000:626F  [+0x0E26F]  00 00                    add     [bx+si],al
F000:6271  [+0x0E271]  00 00                    add     [bx+si],al
F000:6273  [+0x0E273]  00 00                    add     [bx+si],al
F000:6275  [+0x0E275]  00 00                    add     [bx+si],al
F000:6277  [+0x0E277]  00 00                    add     [bx+si],al
F000:6279  [+0x0E279]  00 00                    add     [bx+si],al
F000:627B  [+0x0E27B]  00 00                    add     [bx+si],al
F000:627D  [+0x0E27D]  00 00                    add     [bx+si],al
F000:627F  [+0x0E27F]  00 00                    add     [bx+si],al
F000:6281  [+0x0E281]  00 00                    add     [bx+si],al
F000:6283  [+0x0E283]  00 00                    add     [bx+si],al
F000:6285  [+0x0E285]  00 00                    add     [bx+si],al
F000:6287  [+0x0E287]  00 00                    add     [bx+si],al
F000:6289  [+0x0E289]  00 00                    add     [bx+si],al
F000:628B  [+0x0E28B]  00 00                    add     [bx+si],al
F000:628D  [+0x0E28D]  00 00                    add     [bx+si],al
F000:628F  [+0x0E28F]  00 00                    add     [bx+si],al
F000:6291  [+0x0E291]  00 00                    add     [bx+si],al
F000:6293  [+0x0E293]  00 00                    add     [bx+si],al
F000:6295  [+0x0E295]  00 00                    add     [bx+si],al
F000:6297  [+0x0E297]  00 00                    add     [bx+si],al
F000:6299  [+0x0E299]  00 00                    add     [bx+si],al
F000:629B  [+0x0E29B]  00 00                    add     [bx+si],al
F000:629D  [+0x0E29D]  00 00                    add     [bx+si],al
F000:629F  [+0x0E29F]  00 00                    add     [bx+si],al
F000:62A1  [+0x0E2A1]  00 00                    add     [bx+si],al
F000:62A3  [+0x0E2A3]  00 00                    add     [bx+si],al
F000:62A5  [+0x0E2A5]  00 00                    add     [bx+si],al
F000:62A7  [+0x0E2A7]  00 00                    add     [bx+si],al
F000:62A9  [+0x0E2A9]  00 00                    add     [bx+si],al
F000:62AB  [+0x0E2AB]  00 00                    add     [bx+si],al
F000:62AD  [+0x0E2AD]  00 00                    add     [bx+si],al
F000:62AF  [+0x0E2AF]  00 00                    add     [bx+si],al
F000:62B1  [+0x0E2B1]  00 00                    add     [bx+si],al
F000:62B3  [+0x0E2B3]  00 00                    add     [bx+si],al
F000:62B5  [+0x0E2B5]  00 00                    add     [bx+si],al
F000:62B7  [+0x0E2B7]  00 00                    add     [bx+si],al
F000:62B9  [+0x0E2B9]  00 00                    add     [bx+si],al
F000:62BB  [+0x0E2BB]  00 00                    add     [bx+si],al
F000:62BD  [+0x0E2BD]  00 00                    add     [bx+si],al
F000:62BF  [+0x0E2BF]  00 00                    add     [bx+si],al
F000:62C1  [+0x0E2C1]  00 00                    add     [bx+si],al
F000:62C3  [+0x0E2C3]  00 00                    add     [bx+si],al
F000:62C5  [+0x0E2C5]  00 00                    add     [bx+si],al
F000:62C7  [+0x0E2C7]  00 00                    add     [bx+si],al
F000:62C9  [+0x0E2C9]  00 00                    add     [bx+si],al
F000:62CB  [+0x0E2CB]  00 00                    add     [bx+si],al
F000:62CD  [+0x0E2CD]  00 00                    add     [bx+si],al
F000:62CF  [+0x0E2CF]  00 00                    add     [bx+si],al
F000:62D1  [+0x0E2D1]  00 00                    add     [bx+si],al
F000:62D3  [+0x0E2D3]  00 00                    add     [bx+si],al
F000:62D5  [+0x0E2D5]  00 00                    add     [bx+si],al
F000:62D7  [+0x0E2D7]  00 00                    add     [bx+si],al
F000:62D9  [+0x0E2D9]  00 00                    add     [bx+si],al
F000:62DB  [+0x0E2DB]  00 00                    add     [bx+si],al
F000:62DD  [+0x0E2DD]  00 00                    add     [bx+si],al
F000:62DF  [+0x0E2DF]  00 00                    add     [bx+si],al
F000:62E1  [+0x0E2E1]  00 00                    add     [bx+si],al
F000:62E3  [+0x0E2E3]  00 00                    add     [bx+si],al
F000:62E5  [+0x0E2E5]  00 00                    add     [bx+si],al
F000:62E7  [+0x0E2E7]  00 00                    add     [bx+si],al
F000:62E9  [+0x0E2E9]  00 00                    add     [bx+si],al
F000:62EB  [+0x0E2EB]  00 00                    add     [bx+si],al
F000:62ED  [+0x0E2ED]  00 00                    add     [bx+si],al
F000:62EF  [+0x0E2EF]  00 00                    add     [bx+si],al
F000:62F1  [+0x0E2F1]  00 00                    add     [bx+si],al
F000:62F3  [+0x0E2F3]  00 00                    add     [bx+si],al
F000:62F5  [+0x0E2F5]  00 00                    add     [bx+si],al
F000:62F7  [+0x0E2F7]  00 00                    add     [bx+si],al
F000:62F9  [+0x0E2F9]  00 00                    add     [bx+si],al
F000:62FB  [+0x0E2FB]  00 00                    add     [bx+si],al
F000:62FD  [+0x0E2FD]  00 00                    add     [bx+si],al
F000:62FF  [+0x0E2FF]  00 00                    add     [bx+si],al
F000:6301  [+0x0E301]  00 00                    add     [bx+si],al
F000:6303  [+0x0E303]  00 00                    add     [bx+si],al
F000:6305  [+0x0E305]  00 00                    add     [bx+si],al
F000:6307  [+0x0E307]  00 00                    add     [bx+si],al
F000:6309  [+0x0E309]  00 00                    add     [bx+si],al
F000:630B  [+0x0E30B]  00 00                    add     [bx+si],al
F000:630D  [+0x0E30D]  00 00                    add     [bx+si],al
F000:630F  [+0x0E30F]  00 00                    add     [bx+si],al
F000:6311  [+0x0E311]  00 00                    add     [bx+si],al
F000:6313  [+0x0E313]  00 00                    add     [bx+si],al
F000:6315  [+0x0E315]  00 00                    add     [bx+si],al
F000:6317  [+0x0E317]  00 00                    add     [bx+si],al
F000:6319  [+0x0E319]  00 00                    add     [bx+si],al
F000:631B  [+0x0E31B]  00 00                    add     [bx+si],al
F000:631D  [+0x0E31D]  00 00                    add     [bx+si],al
F000:631F  [+0x0E31F]  00 00                    add     [bx+si],al
F000:6321  [+0x0E321]  00 00                    add     [bx+si],al
F000:6323  [+0x0E323]  00 00                    add     [bx+si],al
F000:6325  [+0x0E325]  00 00                    add     [bx+si],al
F000:6327  [+0x0E327]  00 00                    add     [bx+si],al
F000:6329  [+0x0E329]  00 00                    add     [bx+si],al
F000:632B  [+0x0E32B]  00 00                    add     [bx+si],al
F000:632D  [+0x0E32D]  00 00                    add     [bx+si],al
F000:632F  [+0x0E32F]  00 00                    add     [bx+si],al
F000:6331  [+0x0E331]  00 00                    add     [bx+si],al
F000:6333  [+0x0E333]  00 00                    add     [bx+si],al
F000:6335  [+0x0E335]  00 00                    add     [bx+si],al
F000:6337  [+0x0E337]  00 00                    add     [bx+si],al
F000:6339  [+0x0E339]  00 00                    add     [bx+si],al
F000:633B  [+0x0E33B]  00 00                    add     [bx+si],al
F000:633D  [+0x0E33D]  00 00                    add     [bx+si],al
F000:633F  [+0x0E33F]  00 00                    add     [bx+si],al
F000:6341  [+0x0E341]  00 00                    add     [bx+si],al
F000:6343  [+0x0E343]  00 00                    add     [bx+si],al
F000:6345  [+0x0E345]  00 00                    add     [bx+si],al
F000:6347  [+0x0E347]  00 00                    add     [bx+si],al
F000:6349  [+0x0E349]  00 00                    add     [bx+si],al
F000:634B  [+0x0E34B]  00 00                    add     [bx+si],al
F000:634D  [+0x0E34D]  00 00                    add     [bx+si],al
F000:634F  [+0x0E34F]  00 00                    add     [bx+si],al
F000:6351  [+0x0E351]  00 00                    add     [bx+si],al
F000:6353  [+0x0E353]  00 00                    add     [bx+si],al
F000:6355  [+0x0E355]  00 00                    add     [bx+si],al
F000:6357  [+0x0E357]  00 00                    add     [bx+si],al
F000:6359  [+0x0E359]  00 00                    add     [bx+si],al
F000:635B  [+0x0E35B]  00 00                    add     [bx+si],al
F000:635D  [+0x0E35D]  00 00                    add     [bx+si],al
F000:635F  [+0x0E35F]  00 00                    add     [bx+si],al
F000:6361  [+0x0E361]  00 00                    add     [bx+si],al
F000:6363  [+0x0E363]  00 00                    add     [bx+si],al
F000:6365  [+0x0E365]  00 00                    add     [bx+si],al
F000:6367  [+0x0E367]  00 00                    add     [bx+si],al
F000:6369  [+0x0E369]  00 00                    add     [bx+si],al
F000:636B  [+0x0E36B]  00 00                    add     [bx+si],al
F000:636D  [+0x0E36D]  00 00                    add     [bx+si],al
F000:636F  [+0x0E36F]  00 00                    add     [bx+si],al
F000:6371  [+0x0E371]  00 00                    add     [bx+si],al
F000:6373  [+0x0E373]  00 00                    add     [bx+si],al
F000:6375  [+0x0E375]  00 00                    add     [bx+si],al
F000:6377  [+0x0E377]  00 00                    add     [bx+si],al
F000:6379  [+0x0E379]  00 00                    add     [bx+si],al
F000:637B  [+0x0E37B]  00 00                    add     [bx+si],al
F000:637D  [+0x0E37D]  00 00                    add     [bx+si],al
F000:637F  [+0x0E37F]  00 00                    add     [bx+si],al
F000:6381  [+0x0E381]  00 00                    add     [bx+si],al
F000:6383  [+0x0E383]  00 00                    add     [bx+si],al
F000:6385  [+0x0E385]  00 00                    add     [bx+si],al
F000:6387  [+0x0E387]  00 00                    add     [bx+si],al
F000:6389  [+0x0E389]  00 00                    add     [bx+si],al
F000:638B  [+0x0E38B]  00 00                    add     [bx+si],al
F000:638D  [+0x0E38D]  00 00                    add     [bx+si],al
F000:638F  [+0x0E38F]  00 00                    add     [bx+si],al
F000:6391  [+0x0E391]  00 00                    add     [bx+si],al
F000:6393  [+0x0E393]  00 00                    add     [bx+si],al
F000:6395  [+0x0E395]  00 00                    add     [bx+si],al
F000:6397  [+0x0E397]  00 00                    add     [bx+si],al
F000:6399  [+0x0E399]  00 00                    add     [bx+si],al
F000:639B  [+0x0E39B]  00 00                    add     [bx+si],al
F000:639D  [+0x0E39D]  00 00                    add     [bx+si],al
F000:639F  [+0x0E39F]  00 00                    add     [bx+si],al
F000:63A1  [+0x0E3A1]  00 00                    add     [bx+si],al
F000:63A3  [+0x0E3A3]  00 00                    add     [bx+si],al
F000:63A5  [+0x0E3A5]  00 00                    add     [bx+si],al
F000:63A7  [+0x0E3A7]  00 00                    add     [bx+si],al
F000:63A9  [+0x0E3A9]  00 00                    add     [bx+si],al
F000:63AB  [+0x0E3AB]  00 00                    add     [bx+si],al
F000:63AD  [+0x0E3AD]  00 00                    add     [bx+si],al
F000:63AF  [+0x0E3AF]  00 00                    add     [bx+si],al
F000:63B1  [+0x0E3B1]  00 00                    add     [bx+si],al
F000:63B3  [+0x0E3B3]  00 00                    add     [bx+si],al
F000:63B5  [+0x0E3B5]  00 00                    add     [bx+si],al
F000:63B7  [+0x0E3B7]  00 00                    add     [bx+si],al
F000:63B9  [+0x0E3B9]  00 00                    add     [bx+si],al
F000:63BB  [+0x0E3BB]  00 00                    add     [bx+si],al
F000:63BD  [+0x0E3BD]  00 00                    add     [bx+si],al
F000:63BF  [+0x0E3BF]  00 00                    add     [bx+si],al
F000:63C1  [+0x0E3C1]  00 00                    add     [bx+si],al
F000:63C3  [+0x0E3C3]  00 00                    add     [bx+si],al
F000:63C5  [+0x0E3C5]  00 00                    add     [bx+si],al
F000:63C7  [+0x0E3C7]  00 00                    add     [bx+si],al
F000:63C9  [+0x0E3C9]  00 00                    add     [bx+si],al
F000:63CB  [+0x0E3CB]  00 00                    add     [bx+si],al
F000:63CD  [+0x0E3CD]  00 00                    add     [bx+si],al
F000:63CF  [+0x0E3CF]  00 00                    add     [bx+si],al
F000:63D1  [+0x0E3D1]  00 00                    add     [bx+si],al
F000:63D3  [+0x0E3D3]  00 00                    add     [bx+si],al
F000:63D5  [+0x0E3D5]  00 00                    add     [bx+si],al
F000:63D7  [+0x0E3D7]  00 00                    add     [bx+si],al
F000:63D9  [+0x0E3D9]  00 00                    add     [bx+si],al
F000:63DB  [+0x0E3DB]  00 00                    add     [bx+si],al
F000:63DD  [+0x0E3DD]  00 00                    add     [bx+si],al
F000:63DF  [+0x0E3DF]  00 00                    add     [bx+si],al
F000:63E1  [+0x0E3E1]  00 00                    add     [bx+si],al
F000:63E3  [+0x0E3E3]  00 00                    add     [bx+si],al
F000:63E5  [+0x0E3E5]  00 00                    add     [bx+si],al
F000:63E7  [+0x0E3E7]  00 00                    add     [bx+si],al
F000:63E9  [+0x0E3E9]  00 00                    add     [bx+si],al
F000:63EB  [+0x0E3EB]  00 00                    add     [bx+si],al
F000:63ED  [+0x0E3ED]  00 00                    add     [bx+si],al
F000:63EF  [+0x0E3EF]  00 00                    add     [bx+si],al
F000:63F1  [+0x0E3F1]  00 00                    add     [bx+si],al
F000:63F3  [+0x0E3F3]  00 00                    add     [bx+si],al
F000:63F5  [+0x0E3F5]  00 00                    add     [bx+si],al
F000:63F7  [+0x0E3F7]  00 00                    add     [bx+si],al
F000:63F9  [+0x0E3F9]  00 00                    add     [bx+si],al
F000:63FB  [+0x0E3FB]  00 00                    add     [bx+si],al
F000:63FD  [+0x0E3FD]  00 00                    add     [bx+si],al
F000:63FF  [+0x0E3FF]  00 00                    add     [bx+si],al
F000:6401  [+0x0E401]  00 00                    add     [bx+si],al
F000:6403  [+0x0E403]  00 00                    add     [bx+si],al
F000:6405  [+0x0E405]  00 00                    add     [bx+si],al
F000:6407  [+0x0E407]  00 00                    add     [bx+si],al
F000:6409  [+0x0E409]  00 00                    add     [bx+si],al
F000:640B  [+0x0E40B]  00 00                    add     [bx+si],al
F000:640D  [+0x0E40D]  00 00                    add     [bx+si],al
F000:640F  [+0x0E40F]  00 00                    add     [bx+si],al
F000:6411  [+0x0E411]  00 00                    add     [bx+si],al
F000:6413  [+0x0E413]  00 00                    add     [bx+si],al
F000:6415  [+0x0E415]  00 00                    add     [bx+si],al
F000:6417  [+0x0E417]  00 00                    add     [bx+si],al
F000:6419  [+0x0E419]  00 00                    add     [bx+si],al
F000:641B  [+0x0E41B]  00 00                    add     [bx+si],al
F000:641D  [+0x0E41D]  00 00                    add     [bx+si],al
F000:641F  [+0x0E41F]  00 00                    add     [bx+si],al
F000:6421  [+0x0E421]  00 00                    add     [bx+si],al
F000:6423  [+0x0E423]  00 00                    add     [bx+si],al
F000:6425  [+0x0E425]  00 00                    add     [bx+si],al
F000:6427  [+0x0E427]  00 00                    add     [bx+si],al
F000:6429  [+0x0E429]  00 00                    add     [bx+si],al
F000:642B  [+0x0E42B]  00 00                    add     [bx+si],al
F000:642D  [+0x0E42D]  00 00                    add     [bx+si],al
F000:642F  [+0x0E42F]  00 00                    add     [bx+si],al
F000:6431  [+0x0E431]  00 00                    add     [bx+si],al
F000:6433  [+0x0E433]  00 00                    add     [bx+si],al
F000:6435  [+0x0E435]  00 00                    add     [bx+si],al
F000:6437  [+0x0E437]  00 00                    add     [bx+si],al
F000:6439  [+0x0E439]  00 00                    add     [bx+si],al
F000:643B  [+0x0E43B]  00 00                    add     [bx+si],al
F000:643D  [+0x0E43D]  00 00                    add     [bx+si],al
F000:643F  [+0x0E43F]  00 00                    add     [bx+si],al
F000:6441  [+0x0E441]  00 00                    add     [bx+si],al
F000:6443  [+0x0E443]  00 00                    add     [bx+si],al
F000:6445  [+0x0E445]  00 00                    add     [bx+si],al
F000:6447  [+0x0E447]  00 00                    add     [bx+si],al
F000:6449  [+0x0E449]  00 00                    add     [bx+si],al
F000:644B  [+0x0E44B]  00 00                    add     [bx+si],al
F000:644D  [+0x0E44D]  00 00                    add     [bx+si],al
F000:644F  [+0x0E44F]  00 00                    add     [bx+si],al
F000:6451  [+0x0E451]  00 00                    add     [bx+si],al
F000:6453  [+0x0E453]  00 00                    add     [bx+si],al
F000:6455  [+0x0E455]  00 00                    add     [bx+si],al
F000:6457  [+0x0E457]  00 00                    add     [bx+si],al
F000:6459  [+0x0E459]  00 00                    add     [bx+si],al
F000:645B  [+0x0E45B]  00 00                    add     [bx+si],al
F000:645D  [+0x0E45D]  00 00                    add     [bx+si],al
F000:645F  [+0x0E45F]  00 00                    add     [bx+si],al
F000:6461  [+0x0E461]  00 00                    add     [bx+si],al
F000:6463  [+0x0E463]  00 00                    add     [bx+si],al
F000:6465  [+0x0E465]  00 00                    add     [bx+si],al
F000:6467  [+0x0E467]  00 00                    add     [bx+si],al
F000:6469  [+0x0E469]  00 00                    add     [bx+si],al
F000:646B  [+0x0E46B]  00 00                    add     [bx+si],al
F000:646D  [+0x0E46D]  00 00                    add     [bx+si],al
F000:646F  [+0x0E46F]  00 00                    add     [bx+si],al
F000:6471  [+0x0E471]  00 00                    add     [bx+si],al
F000:6473  [+0x0E473]  00 00                    add     [bx+si],al
F000:6475  [+0x0E475]  00 00                    add     [bx+si],al
F000:6477  [+0x0E477]  00 00                    add     [bx+si],al
F000:6479  [+0x0E479]  00 00                    add     [bx+si],al
F000:647B  [+0x0E47B]  00 00                    add     [bx+si],al
F000:647D  [+0x0E47D]  00 00                    add     [bx+si],al
F000:647F  [+0x0E47F]  00 00                    add     [bx+si],al
F000:6481  [+0x0E481]  00 00                    add     [bx+si],al
F000:6483  [+0x0E483]  00 00                    add     [bx+si],al
F000:6485  [+0x0E485]  00 00                    add     [bx+si],al
F000:6487  [+0x0E487]  00 00                    add     [bx+si],al
F000:6489  [+0x0E489]  00 00                    add     [bx+si],al
F000:648B  [+0x0E48B]  00 00                    add     [bx+si],al
F000:648D  [+0x0E48D]  00 00                    add     [bx+si],al
F000:648F  [+0x0E48F]  00 00                    add     [bx+si],al
F000:6491  [+0x0E491]  00 00                    add     [bx+si],al
F000:6493  [+0x0E493]  00 00                    add     [bx+si],al
F000:6495  [+0x0E495]  00 00                    add     [bx+si],al
F000:6497  [+0x0E497]  00 00                    add     [bx+si],al
F000:6499  [+0x0E499]  00 00                    add     [bx+si],al
F000:649B  [+0x0E49B]  00 00                    add     [bx+si],al
F000:649D  [+0x0E49D]  00 00                    add     [bx+si],al
F000:649F  [+0x0E49F]  00 00                    add     [bx+si],al
F000:64A1  [+0x0E4A1]  00 00                    add     [bx+si],al
F000:64A3  [+0x0E4A3]  00 00                    add     [bx+si],al
F000:64A5  [+0x0E4A5]  00 00                    add     [bx+si],al
F000:64A7  [+0x0E4A7]  00 00                    add     [bx+si],al
F000:64A9  [+0x0E4A9]  00 00                    add     [bx+si],al
F000:64AB  [+0x0E4AB]  00 00                    add     [bx+si],al
F000:64AD  [+0x0E4AD]  00 00                    add     [bx+si],al
F000:64AF  [+0x0E4AF]  00 00                    add     [bx+si],al
F000:64B1  [+0x0E4B1]  00 00                    add     [bx+si],al
F000:64B3  [+0x0E4B3]  00 00                    add     [bx+si],al
F000:64B5  [+0x0E4B5]  00 00                    add     [bx+si],al
F000:64B7  [+0x0E4B7]  00 00                    add     [bx+si],al
F000:64B9  [+0x0E4B9]  00 00                    add     [bx+si],al
F000:64BB  [+0x0E4BB]  00 00                    add     [bx+si],al
F000:64BD  [+0x0E4BD]  00 00                    add     [bx+si],al
F000:64BF  [+0x0E4BF]  00 00                    add     [bx+si],al
F000:64C1  [+0x0E4C1]  00 00                    add     [bx+si],al
F000:64C3  [+0x0E4C3]  00 00                    add     [bx+si],al
F000:64C5  [+0x0E4C5]  00 00                    add     [bx+si],al
F000:64C7  [+0x0E4C7]  00 00                    add     [bx+si],al
F000:64C9  [+0x0E4C9]  00 00                    add     [bx+si],al
F000:64CB  [+0x0E4CB]  00 00                    add     [bx+si],al
F000:64CD  [+0x0E4CD]  00 00                    add     [bx+si],al
F000:64CF  [+0x0E4CF]  00 00                    add     [bx+si],al
F000:64D1  [+0x0E4D1]  00 00                    add     [bx+si],al
F000:64D3  [+0x0E4D3]  00 00                    add     [bx+si],al
F000:64D5  [+0x0E4D5]  00 00                    add     [bx+si],al
F000:64D7  [+0x0E4D7]  00 00                    add     [bx+si],al
F000:64D9  [+0x0E4D9]  00 00                    add     [bx+si],al
F000:64DB  [+0x0E4DB]  00 00                    add     [bx+si],al
F000:64DD  [+0x0E4DD]  00 00                    add     [bx+si],al
F000:64DF  [+0x0E4DF]  00 00                    add     [bx+si],al
F000:64E1  [+0x0E4E1]  00 00                    add     [bx+si],al
F000:64E3  [+0x0E4E3]  00 00                    add     [bx+si],al
F000:64E5  [+0x0E4E5]  00 00                    add     [bx+si],al
F000:64E7  [+0x0E4E7]  00 00                    add     [bx+si],al
F000:64E9  [+0x0E4E9]  00 00                    add     [bx+si],al
F000:64EB  [+0x0E4EB]  00 00                    add     [bx+si],al
F000:64ED  [+0x0E4ED]  00 00                    add     [bx+si],al
F000:64EF  [+0x0E4EF]  00 00                    add     [bx+si],al
F000:64F1  [+0x0E4F1]  00 00                    add     [bx+si],al
F000:64F3  [+0x0E4F3]  00 00                    add     [bx+si],al
F000:64F5  [+0x0E4F5]  00 00                    add     [bx+si],al
F000:64F7  [+0x0E4F7]  00 00                    add     [bx+si],al
F000:64F9  [+0x0E4F9]  00 00                    add     [bx+si],al
F000:64FB  [+0x0E4FB]  00 00                    add     [bx+si],al
F000:64FD  [+0x0E4FD]  00 00                    add     [bx+si],al
F000:64FF  [+0x0E4FF]  00 00                    add     [bx+si],al
F000:6501  [+0x0E501]  00 00                    add     [bx+si],al
F000:6503  [+0x0E503]  00 00                    add     [bx+si],al
F000:6505  [+0x0E505]  00 00                    add     [bx+si],al
F000:6507  [+0x0E507]  00 00                    add     [bx+si],al
F000:6509  [+0x0E509]  00 00                    add     [bx+si],al
F000:650B  [+0x0E50B]  00 00                    add     [bx+si],al
F000:650D  [+0x0E50D]  00 00                    add     [bx+si],al
F000:650F  [+0x0E50F]  00 00                    add     [bx+si],al
F000:6511  [+0x0E511]  00 00                    add     [bx+si],al
F000:6513  [+0x0E513]  00 00                    add     [bx+si],al
F000:6515  [+0x0E515]  00 00                    add     [bx+si],al
F000:6517  [+0x0E517]  00 00                    add     [bx+si],al
F000:6519  [+0x0E519]  00 00                    add     [bx+si],al
F000:651B  [+0x0E51B]  00 00                    add     [bx+si],al
F000:651D  [+0x0E51D]  00 00                    add     [bx+si],al
F000:651F  [+0x0E51F]  00 00                    add     [bx+si],al
F000:6521  [+0x0E521]  00 00                    add     [bx+si],al
F000:6523  [+0x0E523]  00 00                    add     [bx+si],al
F000:6525  [+0x0E525]  00 00                    add     [bx+si],al
F000:6527  [+0x0E527]  00 00                    add     [bx+si],al
F000:6529  [+0x0E529]  00 00                    add     [bx+si],al
F000:652B  [+0x0E52B]  00 00                    add     [bx+si],al
F000:652D  [+0x0E52D]  00 00                    add     [bx+si],al
F000:652F  [+0x0E52F]  00 00                    add     [bx+si],al
F000:6531  [+0x0E531]  00 00                    add     [bx+si],al
F000:6533  [+0x0E533]  00 00                    add     [bx+si],al
F000:6535  [+0x0E535]  00 00                    add     [bx+si],al
F000:6537  [+0x0E537]  00 00                    add     [bx+si],al
F000:6539  [+0x0E539]  00 00                    add     [bx+si],al
F000:653B  [+0x0E53B]  00 00                    add     [bx+si],al
F000:653D  [+0x0E53D]  00 00                    add     [bx+si],al
F000:653F  [+0x0E53F]  00 00                    add     [bx+si],al
F000:6541  [+0x0E541]  00 00                    add     [bx+si],al
F000:6543  [+0x0E543]  00 00                    add     [bx+si],al
F000:6545  [+0x0E545]  00 00                    add     [bx+si],al
F000:6547  [+0x0E547]  00 00                    add     [bx+si],al
F000:6549  [+0x0E549]  00 00                    add     [bx+si],al
F000:654B  [+0x0E54B]  00 00                    add     [bx+si],al
F000:654D  [+0x0E54D]  00 00                    add     [bx+si],al
F000:654F  [+0x0E54F]  00 00                    add     [bx+si],al
F000:6551  [+0x0E551]  00 00                    add     [bx+si],al
F000:6553  [+0x0E553]  00 00                    add     [bx+si],al
F000:6555  [+0x0E555]  00 00                    add     [bx+si],al
F000:6557  [+0x0E557]  00 00                    add     [bx+si],al
F000:6559  [+0x0E559]  00 00                    add     [bx+si],al
F000:655B  [+0x0E55B]  00 00                    add     [bx+si],al
F000:655D  [+0x0E55D]  00 00                    add     [bx+si],al
F000:655F  [+0x0E55F]  00 00                    add     [bx+si],al
F000:6561  [+0x0E561]  00 00                    add     [bx+si],al
F000:6563  [+0x0E563]  00 00                    add     [bx+si],al
F000:6565  [+0x0E565]  00 00                    add     [bx+si],al
F000:6567  [+0x0E567]  00 00                    add     [bx+si],al
F000:6569  [+0x0E569]  00 00                    add     [bx+si],al
F000:656B  [+0x0E56B]  00 00                    add     [bx+si],al
F000:656D  [+0x0E56D]  00 00                    add     [bx+si],al
F000:656F  [+0x0E56F]  00 00                    add     [bx+si],al
F000:6571  [+0x0E571]  00 00                    add     [bx+si],al
F000:6573  [+0x0E573]  00 00                    add     [bx+si],al
F000:6575  [+0x0E575]  00 00                    add     [bx+si],al
F000:6577  [+0x0E577]  00 00                    add     [bx+si],al
F000:6579  [+0x0E579]  00 00                    add     [bx+si],al
F000:657B  [+0x0E57B]  00 00                    add     [bx+si],al
F000:657D  [+0x0E57D]  00 00                    add     [bx+si],al
F000:657F  [+0x0E57F]  00 00                    add     [bx+si],al
F000:6581  [+0x0E581]  00 00                    add     [bx+si],al
F000:6583  [+0x0E583]  00 00                    add     [bx+si],al
F000:6585  [+0x0E585]  00 00                    add     [bx+si],al
F000:6587  [+0x0E587]  00 00                    add     [bx+si],al
F000:6589  [+0x0E589]  00 00                    add     [bx+si],al
F000:658B  [+0x0E58B]  00 00                    add     [bx+si],al
F000:658D  [+0x0E58D]  00 00                    add     [bx+si],al
F000:658F  [+0x0E58F]  00 00                    add     [bx+si],al
F000:6591  [+0x0E591]  00 00                    add     [bx+si],al
F000:6593  [+0x0E593]  00 00                    add     [bx+si],al
F000:6595  [+0x0E595]  00 00                    add     [bx+si],al
F000:6597  [+0x0E597]  00 00                    add     [bx+si],al
F000:6599  [+0x0E599]  00 00                    add     [bx+si],al
F000:659B  [+0x0E59B]  00 00                    add     [bx+si],al
F000:659D  [+0x0E59D]  00 00                    add     [bx+si],al
F000:659F  [+0x0E59F]  00 00                    add     [bx+si],al
F000:65A1  [+0x0E5A1]  00 00                    add     [bx+si],al
F000:65A3  [+0x0E5A3]  00 00                    add     [bx+si],al
F000:65A5  [+0x0E5A5]  00 00                    add     [bx+si],al
F000:65A7  [+0x0E5A7]  00 00                    add     [bx+si],al
F000:65A9  [+0x0E5A9]  00 00                    add     [bx+si],al
F000:65AB  [+0x0E5AB]  00 00                    add     [bx+si],al
F000:65AD  [+0x0E5AD]  00 00                    add     [bx+si],al
F000:65AF  [+0x0E5AF]  00 00                    add     [bx+si],al
F000:65B1  [+0x0E5B1]  00 00                    add     [bx+si],al
F000:65B3  [+0x0E5B3]  00 00                    add     [bx+si],al
F000:65B5  [+0x0E5B5]  00 00                    add     [bx+si],al
F000:65B7  [+0x0E5B7]  00 00                    add     [bx+si],al
F000:65B9  [+0x0E5B9]  00 00                    add     [bx+si],al
F000:65BB  [+0x0E5BB]  00 00                    add     [bx+si],al
F000:65BD  [+0x0E5BD]  00 00                    add     [bx+si],al
F000:65BF  [+0x0E5BF]  00 00                    add     [bx+si],al
F000:65C1  [+0x0E5C1]  00 00                    add     [bx+si],al
F000:65C3  [+0x0E5C3]  00 00                    add     [bx+si],al
F000:65C5  [+0x0E5C5]  00 00                    add     [bx+si],al
F000:65C7  [+0x0E5C7]  00 00                    add     [bx+si],al
F000:65C9  [+0x0E5C9]  00 00                    add     [bx+si],al
F000:65CB  [+0x0E5CB]  00 00                    add     [bx+si],al
F000:65CD  [+0x0E5CD]  00 00                    add     [bx+si],al
F000:65CF  [+0x0E5CF]  00 00                    add     [bx+si],al
F000:65D1  [+0x0E5D1]  00 00                    add     [bx+si],al
F000:65D3  [+0x0E5D3]  00 00                    add     [bx+si],al
F000:65D5  [+0x0E5D5]  00 00                    add     [bx+si],al
F000:65D7  [+0x0E5D7]  00 00                    add     [bx+si],al
F000:65D9  [+0x0E5D9]  00 00                    add     [bx+si],al
F000:65DB  [+0x0E5DB]  00 00                    add     [bx+si],al
F000:65DD  [+0x0E5DD]  00 00                    add     [bx+si],al
F000:65DF  [+0x0E5DF]  00 00                    add     [bx+si],al
F000:65E1  [+0x0E5E1]  00 00                    add     [bx+si],al
F000:65E3  [+0x0E5E3]  00 00                    add     [bx+si],al
F000:65E5  [+0x0E5E5]  00 00                    add     [bx+si],al
F000:65E7  [+0x0E5E7]  00 00                    add     [bx+si],al
F000:65E9  [+0x0E5E9]  00 00                    add     [bx+si],al
F000:65EB  [+0x0E5EB]  00 00                    add     [bx+si],al
F000:65ED  [+0x0E5ED]  00 00                    add     [bx+si],al
F000:65EF  [+0x0E5EF]  00 00                    add     [bx+si],al
F000:65F1  [+0x0E5F1]  00 00                    add     [bx+si],al
F000:65F3  [+0x0E5F3]  00 00                    add     [bx+si],al
F000:65F5  [+0x0E5F5]  00 00                    add     [bx+si],al
F000:65F7  [+0x0E5F7]  00 00                    add     [bx+si],al
F000:65F9  [+0x0E5F9]  00 00                    add     [bx+si],al
F000:65FB  [+0x0E5FB]  00 00                    add     [bx+si],al
F000:65FD  [+0x0E5FD]  00 00                    add     [bx+si],al
F000:65FF  [+0x0E5FF]  00 00                    add     [bx+si],al
F000:6601  [+0x0E601]  00 00                    add     [bx+si],al
F000:6603  [+0x0E603]  00 00                    add     [bx+si],al
F000:6605  [+0x0E605]  00 00                    add     [bx+si],al
F000:6607  [+0x0E607]  00 00                    add     [bx+si],al
F000:6609  [+0x0E609]  00 00                    add     [bx+si],al
F000:660B  [+0x0E60B]  00 00                    add     [bx+si],al
F000:660D  [+0x0E60D]  00 00                    add     [bx+si],al
F000:660F  [+0x0E60F]  00 00                    add     [bx+si],al
F000:6611  [+0x0E611]  00 00                    add     [bx+si],al
F000:6613  [+0x0E613]  00 00                    add     [bx+si],al
F000:6615  [+0x0E615]  00 00                    add     [bx+si],al
F000:6617  [+0x0E617]  00 00                    add     [bx+si],al
F000:6619  [+0x0E619]  00 00                    add     [bx+si],al
F000:661B  [+0x0E61B]  00 00                    add     [bx+si],al
F000:661D  [+0x0E61D]  00 00                    add     [bx+si],al
F000:661F  [+0x0E61F]  00 00                    add     [bx+si],al
F000:6621  [+0x0E621]  00 00                    add     [bx+si],al
F000:6623  [+0x0E623]  00 00                    add     [bx+si],al
F000:6625  [+0x0E625]  00 00                    add     [bx+si],al
F000:6627  [+0x0E627]  00 00                    add     [bx+si],al
F000:6629  [+0x0E629]  00 00                    add     [bx+si],al
F000:662B  [+0x0E62B]  00 00                    add     [bx+si],al
F000:662D  [+0x0E62D]  00 00                    add     [bx+si],al
F000:662F  [+0x0E62F]  00 00                    add     [bx+si],al
F000:6631  [+0x0E631]  00 00                    add     [bx+si],al
F000:6633  [+0x0E633]  00 00                    add     [bx+si],al
F000:6635  [+0x0E635]  00 00                    add     [bx+si],al
F000:6637  [+0x0E637]  00 00                    add     [bx+si],al
F000:6639  [+0x0E639]  00 00                    add     [bx+si],al
F000:663B  [+0x0E63B]  00 00                    add     [bx+si],al
F000:663D  [+0x0E63D]  00 00                    add     [bx+si],al
F000:663F  [+0x0E63F]  00 00                    add     [bx+si],al
F000:6641  [+0x0E641]  00 00                    add     [bx+si],al
F000:6643  [+0x0E643]  00 00                    add     [bx+si],al
F000:6645  [+0x0E645]  00 00                    add     [bx+si],al
F000:6647  [+0x0E647]  00 00                    add     [bx+si],al
F000:6649  [+0x0E649]  00 00                    add     [bx+si],al
F000:664B  [+0x0E64B]  00 00                    add     [bx+si],al
F000:664D  [+0x0E64D]  00 00                    add     [bx+si],al
F000:664F  [+0x0E64F]  00 00                    add     [bx+si],al
F000:6651  [+0x0E651]  00 00                    add     [bx+si],al
F000:6653  [+0x0E653]  00 00                    add     [bx+si],al
F000:6655  [+0x0E655]  00 00                    add     [bx+si],al
F000:6657  [+0x0E657]  00 00                    add     [bx+si],al
F000:6659  [+0x0E659]  00 00                    add     [bx+si],al
F000:665B  [+0x0E65B]  00 00                    add     [bx+si],al
F000:665D  [+0x0E65D]  00 00                    add     [bx+si],al
F000:665F  [+0x0E65F]  00 00                    add     [bx+si],al
F000:6661  [+0x0E661]  00 00                    add     [bx+si],al
F000:6663  [+0x0E663]  00 00                    add     [bx+si],al
F000:6665  [+0x0E665]  00 00                    add     [bx+si],al
F000:6667  [+0x0E667]  00 00                    add     [bx+si],al
F000:6669  [+0x0E669]  00 00                    add     [bx+si],al
F000:666B  [+0x0E66B]  00 00                    add     [bx+si],al
F000:666D  [+0x0E66D]  00 00                    add     [bx+si],al
F000:666F  [+0x0E66F]  00 00                    add     [bx+si],al
F000:6671  [+0x0E671]  00 00                    add     [bx+si],al
F000:6673  [+0x0E673]  00 00                    add     [bx+si],al
F000:6675  [+0x0E675]  00 00                    add     [bx+si],al
F000:6677  [+0x0E677]  00 00                    add     [bx+si],al
F000:6679  [+0x0E679]  00 00                    add     [bx+si],al
F000:667B  [+0x0E67B]  00 00                    add     [bx+si],al
F000:667D  [+0x0E67D]  00 00                    add     [bx+si],al
F000:667F  [+0x0E67F]  00 00                    add     [bx+si],al
F000:6681  [+0x0E681]  00 00                    add     [bx+si],al
F000:6683  [+0x0E683]  00 00                    add     [bx+si],al
F000:6685  [+0x0E685]  00 00                    add     [bx+si],al
F000:6687  [+0x0E687]  00 00                    add     [bx+si],al
F000:6689  [+0x0E689]  00 00                    add     [bx+si],al
F000:668B  [+0x0E68B]  00 00                    add     [bx+si],al
F000:668D  [+0x0E68D]  00 00                    add     [bx+si],al
F000:668F  [+0x0E68F]  00 00                    add     [bx+si],al
F000:6691  [+0x0E691]  00 00                    add     [bx+si],al
F000:6693  [+0x0E693]  00 00                    add     [bx+si],al
F000:6695  [+0x0E695]  00 00                    add     [bx+si],al
F000:6697  [+0x0E697]  00 00                    add     [bx+si],al
F000:6699  [+0x0E699]  00 00                    add     [bx+si],al
F000:669B  [+0x0E69B]  00 00                    add     [bx+si],al
F000:669D  [+0x0E69D]  00 00                    add     [bx+si],al
F000:669F  [+0x0E69F]  00 00                    add     [bx+si],al
F000:66A1  [+0x0E6A1]  00 00                    add     [bx+si],al
F000:66A3  [+0x0E6A3]  00 00                    add     [bx+si],al
F000:66A5  [+0x0E6A5]  00 00                    add     [bx+si],al
F000:66A7  [+0x0E6A7]  00 00                    add     [bx+si],al
F000:66A9  [+0x0E6A9]  00 00                    add     [bx+si],al
F000:66AB  [+0x0E6AB]  00 00                    add     [bx+si],al
F000:66AD  [+0x0E6AD]  00 00                    add     [bx+si],al
F000:66AF  [+0x0E6AF]  00 00                    add     [bx+si],al
F000:66B1  [+0x0E6B1]  00 00                    add     [bx+si],al
F000:66B3  [+0x0E6B3]  00 00                    add     [bx+si],al
F000:66B5  [+0x0E6B5]  00 00                    add     [bx+si],al
F000:66B7  [+0x0E6B7]  00 00                    add     [bx+si],al
F000:66B9  [+0x0E6B9]  00 00                    add     [bx+si],al
F000:66BB  [+0x0E6BB]  00 00                    add     [bx+si],al
F000:66BD  [+0x0E6BD]  00 00                    add     [bx+si],al
F000:66BF  [+0x0E6BF]  00 00                    add     [bx+si],al
F000:66C1  [+0x0E6C1]  00 00                    add     [bx+si],al
F000:66C3  [+0x0E6C3]  00 00                    add     [bx+si],al
F000:66C5  [+0x0E6C5]  00 00                    add     [bx+si],al
F000:66C7  [+0x0E6C7]  00 00                    add     [bx+si],al
F000:66C9  [+0x0E6C9]  00 00                    add     [bx+si],al
F000:66CB  [+0x0E6CB]  00 00                    add     [bx+si],al
F000:66CD  [+0x0E6CD]  00 00                    add     [bx+si],al
F000:66CF  [+0x0E6CF]  00 00                    add     [bx+si],al
F000:66D1  [+0x0E6D1]  00 00                    add     [bx+si],al
F000:66D3  [+0x0E6D3]  00 00                    add     [bx+si],al
F000:66D5  [+0x0E6D5]  00 00                    add     [bx+si],al
F000:66D7  [+0x0E6D7]  00 00                    add     [bx+si],al
F000:66D9  [+0x0E6D9]  00 00                    add     [bx+si],al
F000:66DB  [+0x0E6DB]  00 00                    add     [bx+si],al
F000:66DD  [+0x0E6DD]  00 00                    add     [bx+si],al
F000:66DF  [+0x0E6DF]  00 00                    add     [bx+si],al
F000:66E1  [+0x0E6E1]  00 00                    add     [bx+si],al
F000:66E3  [+0x0E6E3]  00 00                    add     [bx+si],al
F000:66E5  [+0x0E6E5]  00 00                    add     [bx+si],al
F000:66E7  [+0x0E6E7]  00 00                    add     [bx+si],al
F000:66E9  [+0x0E6E9]  00 00                    add     [bx+si],al
F000:66EB  [+0x0E6EB]  00 00                    add     [bx+si],al
F000:66ED  [+0x0E6ED]  00 00                    add     [bx+si],al
F000:66EF  [+0x0E6EF]  00 00                    add     [bx+si],al
F000:66F1  [+0x0E6F1]  00 00                    add     [bx+si],al
F000:66F3  [+0x0E6F3]  00 00                    add     [bx+si],al
F000:66F5  [+0x0E6F5]  00 00                    add     [bx+si],al
F000:66F7  [+0x0E6F7]  00 00                    add     [bx+si],al
F000:66F9  [+0x0E6F9]  00 00                    add     [bx+si],al
F000:66FB  [+0x0E6FB]  00 00                    add     [bx+si],al
F000:66FD  [+0x0E6FD]  00 00                    add     [bx+si],al
F000:66FF  [+0x0E6FF]  00 00                    add     [bx+si],al
F000:6701  [+0x0E701]  00 00                    add     [bx+si],al
F000:6703  [+0x0E703]  00 00                    add     [bx+si],al
F000:6705  [+0x0E705]  00 00                    add     [bx+si],al
F000:6707  [+0x0E707]  00 00                    add     [bx+si],al
F000:6709  [+0x0E709]  00 00                    add     [bx+si],al
F000:670B  [+0x0E70B]  00 00                    add     [bx+si],al
F000:670D  [+0x0E70D]  00 00                    add     [bx+si],al
F000:670F  [+0x0E70F]  00 00                    add     [bx+si],al
F000:6711  [+0x0E711]  00 00                    add     [bx+si],al
F000:6713  [+0x0E713]  00 00                    add     [bx+si],al
F000:6715  [+0x0E715]  00 00                    add     [bx+si],al
F000:6717  [+0x0E717]  00 00                    add     [bx+si],al
F000:6719  [+0x0E719]  00 00                    add     [bx+si],al
F000:671B  [+0x0E71B]  00 00                    add     [bx+si],al
F000:671D  [+0x0E71D]  00 00                    add     [bx+si],al
F000:671F  [+0x0E71F]  00 00                    add     [bx+si],al
F000:6721  [+0x0E721]  00 00                    add     [bx+si],al
F000:6723  [+0x0E723]  00 00                    add     [bx+si],al
F000:6725  [+0x0E725]  00 00                    add     [bx+si],al
F000:6727  [+0x0E727]  00 00                    add     [bx+si],al
F000:6729  [+0x0E729]  00 00                    add     [bx+si],al
F000:672B  [+0x0E72B]  00 00                    add     [bx+si],al
F000:672D  [+0x0E72D]  00 00                    add     [bx+si],al
F000:672F  [+0x0E72F]  00 00                    add     [bx+si],al
F000:6731  [+0x0E731]  00 00                    add     [bx+si],al
F000:6733  [+0x0E733]  00 00                    add     [bx+si],al
F000:6735  [+0x0E735]  00 00                    add     [bx+si],al
F000:6737  [+0x0E737]  00 00                    add     [bx+si],al
F000:6739  [+0x0E739]  00 00                    add     [bx+si],al
F000:673B  [+0x0E73B]  00 00                    add     [bx+si],al
F000:673D  [+0x0E73D]  00 00                    add     [bx+si],al
F000:673F  [+0x0E73F]  00 00                    add     [bx+si],al
F000:6741  [+0x0E741]  00 00                    add     [bx+si],al
F000:6743  [+0x0E743]  00 00                    add     [bx+si],al
F000:6745  [+0x0E745]  00 00                    add     [bx+si],al
F000:6747  [+0x0E747]  00 00                    add     [bx+si],al
F000:6749  [+0x0E749]  00 00                    add     [bx+si],al
F000:674B  [+0x0E74B]  00 00                    add     [bx+si],al
F000:674D  [+0x0E74D]  00 00                    add     [bx+si],al
F000:674F  [+0x0E74F]  00 00                    add     [bx+si],al
F000:6751  [+0x0E751]  00 00                    add     [bx+si],al
F000:6753  [+0x0E753]  00 00                    add     [bx+si],al
F000:6755  [+0x0E755]  00 00                    add     [bx+si],al
F000:6757  [+0x0E757]  00 00                    add     [bx+si],al
F000:6759  [+0x0E759]  00 00                    add     [bx+si],al
F000:675B  [+0x0E75B]  00 00                    add     [bx+si],al
F000:675D  [+0x0E75D]  00 00                    add     [bx+si],al
F000:675F  [+0x0E75F]  00 00                    add     [bx+si],al
F000:6761  [+0x0E761]  00 00                    add     [bx+si],al
F000:6763  [+0x0E763]  00 00                    add     [bx+si],al
F000:6765  [+0x0E765]  00 00                    add     [bx+si],al
F000:6767  [+0x0E767]  00 00                    add     [bx+si],al
F000:6769  [+0x0E769]  00 00                    add     [bx+si],al
F000:676B  [+0x0E76B]  00 00                    add     [bx+si],al
F000:676D  [+0x0E76D]  00 00                    add     [bx+si],al
F000:676F  [+0x0E76F]  00 00                    add     [bx+si],al
F000:6771  [+0x0E771]  00 00                    add     [bx+si],al
F000:6773  [+0x0E773]  00 00                    add     [bx+si],al
F000:6775  [+0x0E775]  00 00                    add     [bx+si],al
F000:6777  [+0x0E777]  00 00                    add     [bx+si],al
F000:6779  [+0x0E779]  00 00                    add     [bx+si],al
F000:677B  [+0x0E77B]  00 00                    add     [bx+si],al
F000:677D  [+0x0E77D]  00 00                    add     [bx+si],al
F000:677F  [+0x0E77F]  00 00                    add     [bx+si],al
F000:6781  [+0x0E781]  00 00                    add     [bx+si],al
F000:6783  [+0x0E783]  00 00                    add     [bx+si],al
F000:6785  [+0x0E785]  00 00                    add     [bx+si],al
F000:6787  [+0x0E787]  00 00                    add     [bx+si],al
F000:6789  [+0x0E789]  00 00                    add     [bx+si],al
F000:678B  [+0x0E78B]  00 00                    add     [bx+si],al
F000:678D  [+0x0E78D]  00 00                    add     [bx+si],al
F000:678F  [+0x0E78F]  00 00                    add     [bx+si],al
F000:6791  [+0x0E791]  00 00                    add     [bx+si],al
F000:6793  [+0x0E793]  00 00                    add     [bx+si],al
F000:6795  [+0x0E795]  00 00                    add     [bx+si],al
F000:6797  [+0x0E797]  00 00                    add     [bx+si],al
F000:6799  [+0x0E799]  00 00                    add     [bx+si],al
F000:679B  [+0x0E79B]  00 00                    add     [bx+si],al
F000:679D  [+0x0E79D]  00 00                    add     [bx+si],al
F000:679F  [+0x0E79F]  00 00                    add     [bx+si],al
F000:67A1  [+0x0E7A1]  00 00                    add     [bx+si],al
F000:67A3  [+0x0E7A3]  00 00                    add     [bx+si],al
F000:67A5  [+0x0E7A5]  00 00                    add     [bx+si],al
F000:67A7  [+0x0E7A7]  00 00                    add     [bx+si],al
F000:67A9  [+0x0E7A9]  00 00                    add     [bx+si],al
F000:67AB  [+0x0E7AB]  00 00                    add     [bx+si],al
F000:67AD  [+0x0E7AD]  00 00                    add     [bx+si],al
F000:67AF  [+0x0E7AF]  00 00                    add     [bx+si],al
F000:67B1  [+0x0E7B1]  00 00                    add     [bx+si],al
F000:67B3  [+0x0E7B3]  00 00                    add     [bx+si],al
F000:67B5  [+0x0E7B5]  00 00                    add     [bx+si],al
F000:67B7  [+0x0E7B7]  00 00                    add     [bx+si],al
F000:67B9  [+0x0E7B9]  00 00                    add     [bx+si],al
F000:67BB  [+0x0E7BB]  00 00                    add     [bx+si],al
F000:67BD  [+0x0E7BD]  00 00                    add     [bx+si],al
F000:67BF  [+0x0E7BF]  00 00                    add     [bx+si],al
F000:67C1  [+0x0E7C1]  00 00                    add     [bx+si],al
F000:67C3  [+0x0E7C3]  00 00                    add     [bx+si],al
F000:67C5  [+0x0E7C5]  00 00                    add     [bx+si],al
F000:67C7  [+0x0E7C7]  00 00                    add     [bx+si],al
F000:67C9  [+0x0E7C9]  00 00                    add     [bx+si],al
F000:67CB  [+0x0E7CB]  00 00                    add     [bx+si],al
F000:67CD  [+0x0E7CD]  00 00                    add     [bx+si],al
F000:67CF  [+0x0E7CF]  00 00                    add     [bx+si],al
F000:67D1  [+0x0E7D1]  00 00                    add     [bx+si],al
F000:67D3  [+0x0E7D3]  00 00                    add     [bx+si],al
F000:67D5  [+0x0E7D5]  00 00                    add     [bx+si],al
F000:67D7  [+0x0E7D7]  00 00                    add     [bx+si],al
F000:67D9  [+0x0E7D9]  00 00                    add     [bx+si],al
F000:67DB  [+0x0E7DB]  00 00                    add     [bx+si],al
F000:67DD  [+0x0E7DD]  00 00                    add     [bx+si],al
F000:67DF  [+0x0E7DF]  00 00                    add     [bx+si],al
F000:67E1  [+0x0E7E1]  00 00                    add     [bx+si],al
F000:67E3  [+0x0E7E3]  00 00                    add     [bx+si],al
F000:67E5  [+0x0E7E5]  00 00                    add     [bx+si],al
F000:67E7  [+0x0E7E7]  00 00                    add     [bx+si],al
F000:67E9  [+0x0E7E9]  00 00                    add     [bx+si],al
F000:67EB  [+0x0E7EB]  00 00                    add     [bx+si],al
F000:67ED  [+0x0E7ED]  00 00                    add     [bx+si],al
F000:67EF  [+0x0E7EF]  00 00                    add     [bx+si],al
F000:67F1  [+0x0E7F1]  00 00                    add     [bx+si],al
F000:67F3  [+0x0E7F3]  00 00                    add     [bx+si],al
F000:67F5  [+0x0E7F5]  00 00                    add     [bx+si],al
F000:67F7  [+0x0E7F7]  00 00                    add     [bx+si],al
F000:67F9  [+0x0E7F9]  00 00                    add     [bx+si],al
F000:67FB  [+0x0E7FB]  00 00                    add     [bx+si],al
F000:67FD  [+0x0E7FD]  00 00                    add     [bx+si],al
F000:67FF  [+0x0E7FF]  00 00                    add     [bx+si],al
F000:6801  [+0x0E801]  00 00                    add     [bx+si],al
F000:6803  [+0x0E803]  00 00                    add     [bx+si],al
F000:6805  [+0x0E805]  00 00                    add     [bx+si],al
F000:6807  [+0x0E807]  00 00                    add     [bx+si],al
F000:6809  [+0x0E809]  00 00                    add     [bx+si],al
F000:680B  [+0x0E80B]  00 00                    add     [bx+si],al
F000:680D  [+0x0E80D]  00 00                    add     [bx+si],al
F000:680F  [+0x0E80F]  00 00                    add     [bx+si],al
F000:6811  [+0x0E811]  00 00                    add     [bx+si],al
F000:6813  [+0x0E813]  00 00                    add     [bx+si],al
F000:6815  [+0x0E815]  00 00                    add     [bx+si],al
F000:6817  [+0x0E817]  00 00                    add     [bx+si],al
F000:6819  [+0x0E819]  00 00                    add     [bx+si],al
F000:681B  [+0x0E81B]  00 00                    add     [bx+si],al
F000:681D  [+0x0E81D]  00 00                    add     [bx+si],al
F000:681F  [+0x0E81F]  00 00                    add     [bx+si],al
F000:6821  [+0x0E821]  00 00                    add     [bx+si],al
F000:6823  [+0x0E823]  00 00                    add     [bx+si],al
F000:6825  [+0x0E825]  00 00                    add     [bx+si],al
F000:6827  [+0x0E827]  00 00                    add     [bx+si],al
F000:6829  [+0x0E829]  00 00                    add     [bx+si],al
F000:682B  [+0x0E82B]  00 00                    add     [bx+si],al
F000:682D  [+0x0E82D]  00 00                    add     [bx+si],al
F000:682F  [+0x0E82F]  00 00                    add     [bx+si],al
F000:6831  [+0x0E831]  00 00                    add     [bx+si],al
F000:6833  [+0x0E833]  00 00                    add     [bx+si],al
F000:6835  [+0x0E835]  00 00                    add     [bx+si],al
F000:6837  [+0x0E837]  00 00                    add     [bx+si],al
F000:6839  [+0x0E839]  00 00                    add     [bx+si],al
F000:683B  [+0x0E83B]  00 00                    add     [bx+si],al
F000:683D  [+0x0E83D]  00 00                    add     [bx+si],al
F000:683F  [+0x0E83F]  00 00                    add     [bx+si],al
F000:6841  [+0x0E841]  00 00                    add     [bx+si],al
F000:6843  [+0x0E843]  00 00                    add     [bx+si],al
F000:6845  [+0x0E845]  00 00                    add     [bx+si],al
F000:6847  [+0x0E847]  00 00                    add     [bx+si],al
F000:6849  [+0x0E849]  00 00                    add     [bx+si],al
F000:684B  [+0x0E84B]  00 00                    add     [bx+si],al
F000:684D  [+0x0E84D]  00 00                    add     [bx+si],al
F000:684F  [+0x0E84F]  00 00                    add     [bx+si],al
F000:6851  [+0x0E851]  00 00                    add     [bx+si],al
F000:6853  [+0x0E853]  00 00                    add     [bx+si],al
F000:6855  [+0x0E855]  00 00                    add     [bx+si],al
F000:6857  [+0x0E857]  00 00                    add     [bx+si],al
F000:6859  [+0x0E859]  00 00                    add     [bx+si],al
F000:685B  [+0x0E85B]  00 00                    add     [bx+si],al
F000:685D  [+0x0E85D]  00 00                    add     [bx+si],al
F000:685F  [+0x0E85F]  00 00                    add     [bx+si],al
F000:6861  [+0x0E861]  00 00                    add     [bx+si],al
F000:6863  [+0x0E863]  00 00                    add     [bx+si],al
F000:6865  [+0x0E865]  00 00                    add     [bx+si],al
F000:6867  [+0x0E867]  00 00                    add     [bx+si],al
F000:6869  [+0x0E869]  00 00                    add     [bx+si],al
F000:686B  [+0x0E86B]  00 00                    add     [bx+si],al
F000:686D  [+0x0E86D]  00 00                    add     [bx+si],al
F000:686F  [+0x0E86F]  00 00                    add     [bx+si],al
F000:6871  [+0x0E871]  00 00                    add     [bx+si],al
F000:6873  [+0x0E873]  00 00                    add     [bx+si],al
F000:6875  [+0x0E875]  00 00                    add     [bx+si],al
F000:6877  [+0x0E877]  00 00                    add     [bx+si],al
F000:6879  [+0x0E879]  00 00                    add     [bx+si],al
F000:687B  [+0x0E87B]  00 00                    add     [bx+si],al
F000:687D  [+0x0E87D]  00 00                    add     [bx+si],al
F000:687F  [+0x0E87F]  00 00                    add     [bx+si],al
F000:6881  [+0x0E881]  00 00                    add     [bx+si],al
F000:6883  [+0x0E883]  00 00                    add     [bx+si],al
F000:6885  [+0x0E885]  00 00                    add     [bx+si],al
F000:6887  [+0x0E887]  00 00                    add     [bx+si],al
F000:6889  [+0x0E889]  00 00                    add     [bx+si],al
F000:688B  [+0x0E88B]  00 00                    add     [bx+si],al
F000:688D  [+0x0E88D]  00 00                    add     [bx+si],al
F000:688F  [+0x0E88F]  00 00                    add     [bx+si],al
F000:6891  [+0x0E891]  00 00                    add     [bx+si],al
F000:6893  [+0x0E893]  00 00                    add     [bx+si],al
F000:6895  [+0x0E895]  00 00                    add     [bx+si],al
F000:6897  [+0x0E897]  00 00                    add     [bx+si],al
F000:6899  [+0x0E899]  00 00                    add     [bx+si],al
F000:689B  [+0x0E89B]  00 00                    add     [bx+si],al
F000:689D  [+0x0E89D]  00 00                    add     [bx+si],al
F000:689F  [+0x0E89F]  00 00                    add     [bx+si],al
F000:68A1  [+0x0E8A1]  00 00                    add     [bx+si],al
F000:68A3  [+0x0E8A3]  00 00                    add     [bx+si],al
F000:68A5  [+0x0E8A5]  00 00                    add     [bx+si],al
F000:68A7  [+0x0E8A7]  00 00                    add     [bx+si],al
F000:68A9  [+0x0E8A9]  00 00                    add     [bx+si],al
F000:68AB  [+0x0E8AB]  00 00                    add     [bx+si],al
F000:68AD  [+0x0E8AD]  00 00                    add     [bx+si],al
F000:68AF  [+0x0E8AF]  00 00                    add     [bx+si],al
F000:68B1  [+0x0E8B1]  00 00                    add     [bx+si],al
F000:68B3  [+0x0E8B3]  00 00                    add     [bx+si],al
F000:68B5  [+0x0E8B5]  00 00                    add     [bx+si],al
F000:68B7  [+0x0E8B7]  00 00                    add     [bx+si],al
F000:68B9  [+0x0E8B9]  00 00                    add     [bx+si],al
F000:68BB  [+0x0E8BB]  00 00                    add     [bx+si],al
F000:68BD  [+0x0E8BD]  00 00                    add     [bx+si],al
F000:68BF  [+0x0E8BF]  00 00                    add     [bx+si],al
F000:68C1  [+0x0E8C1]  00 00                    add     [bx+si],al
F000:68C3  [+0x0E8C3]  00 00                    add     [bx+si],al
F000:68C5  [+0x0E8C5]  00 00                    add     [bx+si],al
F000:68C7  [+0x0E8C7]  00 00                    add     [bx+si],al
F000:68C9  [+0x0E8C9]  00 00                    add     [bx+si],al
F000:68CB  [+0x0E8CB]  00 00                    add     [bx+si],al
F000:68CD  [+0x0E8CD]  00 00                    add     [bx+si],al
F000:68CF  [+0x0E8CF]  00 00                    add     [bx+si],al
F000:68D1  [+0x0E8D1]  00 00                    add     [bx+si],al
F000:68D3  [+0x0E8D3]  00 00                    add     [bx+si],al
F000:68D5  [+0x0E8D5]  00 00                    add     [bx+si],al
F000:68D7  [+0x0E8D7]  00 00                    add     [bx+si],al
F000:68D9  [+0x0E8D9]  00 00                    add     [bx+si],al
F000:68DB  [+0x0E8DB]  00 00                    add     [bx+si],al
F000:68DD  [+0x0E8DD]  00 00                    add     [bx+si],al
F000:68DF  [+0x0E8DF]  00 00                    add     [bx+si],al
F000:68E1  [+0x0E8E1]  00 00                    add     [bx+si],al
F000:68E3  [+0x0E8E3]  00 00                    add     [bx+si],al
F000:68E5  [+0x0E8E5]  00 00                    add     [bx+si],al
F000:68E7  [+0x0E8E7]  00 00                    add     [bx+si],al
F000:68E9  [+0x0E8E9]  00 00                    add     [bx+si],al
F000:68EB  [+0x0E8EB]  00 00                    add     [bx+si],al
F000:68ED  [+0x0E8ED]  00 00                    add     [bx+si],al
F000:68EF  [+0x0E8EF]  00 00                    add     [bx+si],al
F000:68F1  [+0x0E8F1]  00 00                    add     [bx+si],al
F000:68F3  [+0x0E8F3]  00 00                    add     [bx+si],al
F000:68F5  [+0x0E8F5]  00 00                    add     [bx+si],al
F000:68F7  [+0x0E8F7]  00 00                    add     [bx+si],al
F000:68F9  [+0x0E8F9]  00 00                    add     [bx+si],al
F000:68FB  [+0x0E8FB]  00 00                    add     [bx+si],al
F000:68FD  [+0x0E8FD]  00 00                    add     [bx+si],al
F000:68FF  [+0x0E8FF]  00 00                    add     [bx+si],al
F000:6901  [+0x0E901]  00 00                    add     [bx+si],al
F000:6903  [+0x0E903]  00 00                    add     [bx+si],al
F000:6905  [+0x0E905]  00 00                    add     [bx+si],al
F000:6907  [+0x0E907]  00 00                    add     [bx+si],al
F000:6909  [+0x0E909]  00 00                    add     [bx+si],al
F000:690B  [+0x0E90B]  00 00                    add     [bx+si],al
F000:690D  [+0x0E90D]  00 00                    add     [bx+si],al
F000:690F  [+0x0E90F]  00 00                    add     [bx+si],al
F000:6911  [+0x0E911]  00 00                    add     [bx+si],al
F000:6913  [+0x0E913]  00 00                    add     [bx+si],al
F000:6915  [+0x0E915]  00 00                    add     [bx+si],al
F000:6917  [+0x0E917]  00 00                    add     [bx+si],al
F000:6919  [+0x0E919]  00 00                    add     [bx+si],al
F000:691B  [+0x0E91B]  00 00                    add     [bx+si],al
F000:691D  [+0x0E91D]  00 00                    add     [bx+si],al
F000:691F  [+0x0E91F]  00 00                    add     [bx+si],al
F000:6921  [+0x0E921]  00 00                    add     [bx+si],al
F000:6923  [+0x0E923]  00 00                    add     [bx+si],al
F000:6925  [+0x0E925]  00 00                    add     [bx+si],al
F000:6927  [+0x0E927]  00 00                    add     [bx+si],al
F000:6929  [+0x0E929]  00 00                    add     [bx+si],al
F000:692B  [+0x0E92B]  00 00                    add     [bx+si],al
F000:692D  [+0x0E92D]  00 00                    add     [bx+si],al
F000:692F  [+0x0E92F]  00 00                    add     [bx+si],al
F000:6931  [+0x0E931]  00 00                    add     [bx+si],al
F000:6933  [+0x0E933]  00 00                    add     [bx+si],al
F000:6935  [+0x0E935]  00 00                    add     [bx+si],al
F000:6937  [+0x0E937]  00 00                    add     [bx+si],al
F000:6939  [+0x0E939]  00 00                    add     [bx+si],al
F000:693B  [+0x0E93B]  00 00                    add     [bx+si],al
F000:693D  [+0x0E93D]  00 00                    add     [bx+si],al
F000:693F  [+0x0E93F]  00 00                    add     [bx+si],al
F000:6941  [+0x0E941]  00 00                    add     [bx+si],al
F000:6943  [+0x0E943]  00 00                    add     [bx+si],al
F000:6945  [+0x0E945]  00 00                    add     [bx+si],al
F000:6947  [+0x0E947]  00 00                    add     [bx+si],al
F000:6949  [+0x0E949]  00 00                    add     [bx+si],al
F000:694B  [+0x0E94B]  00 00                    add     [bx+si],al
F000:694D  [+0x0E94D]  00 00                    add     [bx+si],al
F000:694F  [+0x0E94F]  00 00                    add     [bx+si],al
F000:6951  [+0x0E951]  00 00                    add     [bx+si],al
F000:6953  [+0x0E953]  00 00                    add     [bx+si],al
F000:6955  [+0x0E955]  00 00                    add     [bx+si],al
F000:6957  [+0x0E957]  00 00                    add     [bx+si],al
F000:6959  [+0x0E959]  00 00                    add     [bx+si],al
F000:695B  [+0x0E95B]  00 00                    add     [bx+si],al
F000:695D  [+0x0E95D]  00 00                    add     [bx+si],al
F000:695F  [+0x0E95F]  00 00                    add     [bx+si],al
F000:6961  [+0x0E961]  00 00                    add     [bx+si],al
F000:6963  [+0x0E963]  00 00                    add     [bx+si],al
F000:6965  [+0x0E965]  00 00                    add     [bx+si],al
F000:6967  [+0x0E967]  00 00                    add     [bx+si],al
F000:6969  [+0x0E969]  00 00                    add     [bx+si],al
F000:696B  [+0x0E96B]  00 00                    add     [bx+si],al
F000:696D  [+0x0E96D]  00 00                    add     [bx+si],al
F000:696F  [+0x0E96F]  00 00                    add     [bx+si],al
F000:6971  [+0x0E971]  00 00                    add     [bx+si],al
F000:6973  [+0x0E973]  00 00                    add     [bx+si],al
F000:6975  [+0x0E975]  00 00                    add     [bx+si],al
F000:6977  [+0x0E977]  00 00                    add     [bx+si],al
F000:6979  [+0x0E979]  00 00                    add     [bx+si],al
F000:697B  [+0x0E97B]  00 00                    add     [bx+si],al
F000:697D  [+0x0E97D]  00 00                    add     [bx+si],al
F000:697F  [+0x0E97F]  00 00                    add     [bx+si],al
F000:6981  [+0x0E981]  00 00                    add     [bx+si],al
F000:6983  [+0x0E983]  00 00                    add     [bx+si],al
F000:6985  [+0x0E985]  00 00                    add     [bx+si],al
F000:6987  [+0x0E987]  00 00                    add     [bx+si],al
F000:6989  [+0x0E989]  00 00                    add     [bx+si],al
F000:698B  [+0x0E98B]  00 00                    add     [bx+si],al
F000:698D  [+0x0E98D]  00 00                    add     [bx+si],al
F000:698F  [+0x0E98F]  00 00                    add     [bx+si],al
F000:6991  [+0x0E991]  00 00                    add     [bx+si],al
F000:6993  [+0x0E993]  00 00                    add     [bx+si],al
F000:6995  [+0x0E995]  00 00                    add     [bx+si],al
F000:6997  [+0x0E997]  00 00                    add     [bx+si],al
F000:6999  [+0x0E999]  00 00                    add     [bx+si],al
F000:699B  [+0x0E99B]  00 00                    add     [bx+si],al
F000:699D  [+0x0E99D]  00 00                    add     [bx+si],al
F000:699F  [+0x0E99F]  00 00                    add     [bx+si],al
F000:69A1  [+0x0E9A1]  00 00                    add     [bx+si],al
F000:69A3  [+0x0E9A3]  00 00                    add     [bx+si],al
F000:69A5  [+0x0E9A5]  00 00                    add     [bx+si],al
F000:69A7  [+0x0E9A7]  00 00                    add     [bx+si],al
F000:69A9  [+0x0E9A9]  00 00                    add     [bx+si],al
F000:69AB  [+0x0E9AB]  00 00                    add     [bx+si],al
F000:69AD  [+0x0E9AD]  00 00                    add     [bx+si],al
F000:69AF  [+0x0E9AF]  00 00                    add     [bx+si],al
F000:69B1  [+0x0E9B1]  00 00                    add     [bx+si],al
F000:69B3  [+0x0E9B3]  00 00                    add     [bx+si],al
F000:69B5  [+0x0E9B5]  00 00                    add     [bx+si],al
F000:69B7  [+0x0E9B7]  00 00                    add     [bx+si],al
F000:69B9  [+0x0E9B9]  00 00                    add     [bx+si],al
F000:69BB  [+0x0E9BB]  00 00                    add     [bx+si],al
F000:69BD  [+0x0E9BD]  00 00                    add     [bx+si],al
F000:69BF  [+0x0E9BF]  00 00                    add     [bx+si],al
F000:69C1  [+0x0E9C1]  00 00                    add     [bx+si],al
F000:69C3  [+0x0E9C3]  00 00                    add     [bx+si],al
F000:69C5  [+0x0E9C5]  00 00                    add     [bx+si],al
F000:69C7  [+0x0E9C7]  00 00                    add     [bx+si],al
F000:69C9  [+0x0E9C9]  00 00                    add     [bx+si],al
F000:69CB  [+0x0E9CB]  00 00                    add     [bx+si],al
F000:69CD  [+0x0E9CD]  00 00                    add     [bx+si],al
F000:69CF  [+0x0E9CF]  00 00                    add     [bx+si],al
F000:69D1  [+0x0E9D1]  00 00                    add     [bx+si],al
F000:69D3  [+0x0E9D3]  00 00                    add     [bx+si],al
F000:69D5  [+0x0E9D5]  00 00                    add     [bx+si],al
F000:69D7  [+0x0E9D7]  00 00                    add     [bx+si],al
F000:69D9  [+0x0E9D9]  00 00                    add     [bx+si],al
F000:69DB  [+0x0E9DB]  00 00                    add     [bx+si],al
F000:69DD  [+0x0E9DD]  00 00                    add     [bx+si],al
F000:69DF  [+0x0E9DF]  00 00                    add     [bx+si],al
F000:69E1  [+0x0E9E1]  00 00                    add     [bx+si],al
F000:69E3  [+0x0E9E3]  00 00                    add     [bx+si],al
F000:69E5  [+0x0E9E5]  00 00                    add     [bx+si],al
F000:69E7  [+0x0E9E7]  00 00                    add     [bx+si],al
F000:69E9  [+0x0E9E9]  00 00                    add     [bx+si],al
F000:69EB  [+0x0E9EB]  00 00                    add     [bx+si],al
F000:69ED  [+0x0E9ED]  00 00                    add     [bx+si],al
F000:69EF  [+0x0E9EF]  00 00                    add     [bx+si],al
F000:69F1  [+0x0E9F1]  00 00                    add     [bx+si],al
F000:69F3  [+0x0E9F3]  00 00                    add     [bx+si],al
F000:69F5  [+0x0E9F5]  00 00                    add     [bx+si],al
F000:69F7  [+0x0E9F7]  00 00                    add     [bx+si],al
F000:69F9  [+0x0E9F9]  00 00                    add     [bx+si],al
F000:69FB  [+0x0E9FB]  00 00                    add     [bx+si],al
F000:69FD  [+0x0E9FD]  00 00                    add     [bx+si],al
F000:69FF  [+0x0E9FF]  00 00                    add     [bx+si],al
F000:6A01  [+0x0EA01]  00 00                    add     [bx+si],al
F000:6A03  [+0x0EA03]  00 00                    add     [bx+si],al
F000:6A05  [+0x0EA05]  00 00                    add     [bx+si],al
F000:6A07  [+0x0EA07]  00 00                    add     [bx+si],al
F000:6A09  [+0x0EA09]  00 00                    add     [bx+si],al
F000:6A0B  [+0x0EA0B]  00 00                    add     [bx+si],al
F000:6A0D  [+0x0EA0D]  00 00                    add     [bx+si],al
F000:6A0F  [+0x0EA0F]  00 00                    add     [bx+si],al
F000:6A11  [+0x0EA11]  00 00                    add     [bx+si],al
F000:6A13  [+0x0EA13]  00 00                    add     [bx+si],al
F000:6A15  [+0x0EA15]  00 00                    add     [bx+si],al
F000:6A17  [+0x0EA17]  00 00                    add     [bx+si],al
F000:6A19  [+0x0EA19]  00 00                    add     [bx+si],al
F000:6A1B  [+0x0EA1B]  00 00                    add     [bx+si],al
F000:6A1D  [+0x0EA1D]  00 00                    add     [bx+si],al
F000:6A1F  [+0x0EA1F]  00 00                    add     [bx+si],al
F000:6A21  [+0x0EA21]  00 00                    add     [bx+si],al
F000:6A23  [+0x0EA23]  00 00                    add     [bx+si],al
F000:6A25  [+0x0EA25]  00 00                    add     [bx+si],al
F000:6A27  [+0x0EA27]  00 00                    add     [bx+si],al
F000:6A29  [+0x0EA29]  00 00                    add     [bx+si],al
F000:6A2B  [+0x0EA2B]  00 00                    add     [bx+si],al
F000:6A2D  [+0x0EA2D]  00 00                    add     [bx+si],al
F000:6A2F  [+0x0EA2F]  00 00                    add     [bx+si],al
F000:6A31  [+0x0EA31]  00 00                    add     [bx+si],al
F000:6A33  [+0x0EA33]  00 00                    add     [bx+si],al
F000:6A35  [+0x0EA35]  00 00                    add     [bx+si],al
F000:6A37  [+0x0EA37]  00 00                    add     [bx+si],al
F000:6A39  [+0x0EA39]  00 00                    add     [bx+si],al
F000:6A3B  [+0x0EA3B]  00 00                    add     [bx+si],al
F000:6A3D  [+0x0EA3D]  00 00                    add     [bx+si],al
F000:6A3F  [+0x0EA3F]  00 00                    add     [bx+si],al
F000:6A41  [+0x0EA41]  00 00                    add     [bx+si],al
F000:6A43  [+0x0EA43]  00 00                    add     [bx+si],al
F000:6A45  [+0x0EA45]  00 00                    add     [bx+si],al
F000:6A47  [+0x0EA47]  00 00                    add     [bx+si],al
F000:6A49  [+0x0EA49]  00 00                    add     [bx+si],al
F000:6A4B  [+0x0EA4B]  00 00                    add     [bx+si],al
F000:6A4D  [+0x0EA4D]  00 00                    add     [bx+si],al
F000:6A4F  [+0x0EA4F]  00 00                    add     [bx+si],al
F000:6A51  [+0x0EA51]  00 00                    add     [bx+si],al
F000:6A53  [+0x0EA53]  00 00                    add     [bx+si],al
F000:6A55  [+0x0EA55]  00 00                    add     [bx+si],al
F000:6A57  [+0x0EA57]  00 00                    add     [bx+si],al
F000:6A59  [+0x0EA59]  00 00                    add     [bx+si],al
F000:6A5B  [+0x0EA5B]  00 00                    add     [bx+si],al
F000:6A5D  [+0x0EA5D]  00 00                    add     [bx+si],al
F000:6A5F  [+0x0EA5F]  00 00                    add     [bx+si],al
F000:6A61  [+0x0EA61]  00 00                    add     [bx+si],al
F000:6A63  [+0x0EA63]  00 00                    add     [bx+si],al
F000:6A65  [+0x0EA65]  00 00                    add     [bx+si],al
F000:6A67  [+0x0EA67]  00 00                    add     [bx+si],al
F000:6A69  [+0x0EA69]  00 00                    add     [bx+si],al
F000:6A6B  [+0x0EA6B]  00 00                    add     [bx+si],al
F000:6A6D  [+0x0EA6D]  00 00                    add     [bx+si],al
F000:6A6F  [+0x0EA6F]  00 00                    add     [bx+si],al
F000:6A71  [+0x0EA71]  00 00                    add     [bx+si],al
F000:6A73  [+0x0EA73]  00 00                    add     [bx+si],al
F000:6A75  [+0x0EA75]  00 00                    add     [bx+si],al
F000:6A77  [+0x0EA77]  00 00                    add     [bx+si],al
F000:6A79  [+0x0EA79]  00 00                    add     [bx+si],al
F000:6A7B  [+0x0EA7B]  00 00                    add     [bx+si],al
F000:6A7D  [+0x0EA7D]  00 00                    add     [bx+si],al
F000:6A7F  [+0x0EA7F]  00 00                    add     [bx+si],al
F000:6A81  [+0x0EA81]  00 00                    add     [bx+si],al
F000:6A83  [+0x0EA83]  00 00                    add     [bx+si],al
F000:6A85  [+0x0EA85]  00 00                    add     [bx+si],al
F000:6A87  [+0x0EA87]  00 00                    add     [bx+si],al
F000:6A89  [+0x0EA89]  00 00                    add     [bx+si],al
F000:6A8B  [+0x0EA8B]  00 00                    add     [bx+si],al
F000:6A8D  [+0x0EA8D]  00 00                    add     [bx+si],al
F000:6A8F  [+0x0EA8F]  00 00                    add     [bx+si],al
F000:6A91  [+0x0EA91]  00 00                    add     [bx+si],al
F000:6A93  [+0x0EA93]  00 00                    add     [bx+si],al
F000:6A95  [+0x0EA95]  00 00                    add     [bx+si],al
F000:6A97  [+0x0EA97]  00 00                    add     [bx+si],al
F000:6A99  [+0x0EA99]  00 00                    add     [bx+si],al
F000:6A9B  [+0x0EA9B]  00 00                    add     [bx+si],al
F000:6A9D  [+0x0EA9D]  00 00                    add     [bx+si],al
F000:6A9F  [+0x0EA9F]  00 00                    add     [bx+si],al
F000:6AA1  [+0x0EAA1]  00 00                    add     [bx+si],al
F000:6AA3  [+0x0EAA3]  00 00                    add     [bx+si],al
F000:6AA5  [+0x0EAA5]  00 00                    add     [bx+si],al
F000:6AA7  [+0x0EAA7]  00 00                    add     [bx+si],al
F000:6AA9  [+0x0EAA9]  00 00                    add     [bx+si],al
F000:6AAB  [+0x0EAAB]  00 00                    add     [bx+si],al
F000:6AAD  [+0x0EAAD]  00 00                    add     [bx+si],al
F000:6AAF  [+0x0EAAF]  00 00                    add     [bx+si],al
F000:6AB1  [+0x0EAB1]  00 00                    add     [bx+si],al
F000:6AB3  [+0x0EAB3]  00 00                    add     [bx+si],al
F000:6AB5  [+0x0EAB5]  00 00                    add     [bx+si],al
F000:6AB7  [+0x0EAB7]  00 00                    add     [bx+si],al
F000:6AB9  [+0x0EAB9]  00 00                    add     [bx+si],al
F000:6ABB  [+0x0EABB]  00 00                    add     [bx+si],al
F000:6ABD  [+0x0EABD]  00 00                    add     [bx+si],al
F000:6ABF  [+0x0EABF]  00 00                    add     [bx+si],al
F000:6AC1  [+0x0EAC1]  00 00                    add     [bx+si],al
F000:6AC3  [+0x0EAC3]  00 00                    add     [bx+si],al
F000:6AC5  [+0x0EAC5]  00 00                    add     [bx+si],al
F000:6AC7  [+0x0EAC7]  00 00                    add     [bx+si],al
F000:6AC9  [+0x0EAC9]  00 00                    add     [bx+si],al
F000:6ACB  [+0x0EACB]  00 00                    add     [bx+si],al
F000:6ACD  [+0x0EACD]  00 00                    add     [bx+si],al
F000:6ACF  [+0x0EACF]  00 00                    add     [bx+si],al
F000:6AD1  [+0x0EAD1]  00 00                    add     [bx+si],al
F000:6AD3  [+0x0EAD3]  00 00                    add     [bx+si],al
F000:6AD5  [+0x0EAD5]  00 00                    add     [bx+si],al
F000:6AD7  [+0x0EAD7]  00 00                    add     [bx+si],al
F000:6AD9  [+0x0EAD9]  00 00                    add     [bx+si],al
F000:6ADB  [+0x0EADB]  00 00                    add     [bx+si],al
F000:6ADD  [+0x0EADD]  00 00                    add     [bx+si],al
F000:6ADF  [+0x0EADF]  00 00                    add     [bx+si],al
F000:6AE1  [+0x0EAE1]  00 00                    add     [bx+si],al
F000:6AE3  [+0x0EAE3]  00 00                    add     [bx+si],al
F000:6AE5  [+0x0EAE5]  00 00                    add     [bx+si],al
F000:6AE7  [+0x0EAE7]  00 00                    add     [bx+si],al
F000:6AE9  [+0x0EAE9]  00 00                    add     [bx+si],al
F000:6AEB  [+0x0EAEB]  00 00                    add     [bx+si],al
F000:6AED  [+0x0EAED]  00 00                    add     [bx+si],al
F000:6AEF  [+0x0EAEF]  00 00                    add     [bx+si],al
F000:6AF1  [+0x0EAF1]  00 00                    add     [bx+si],al
F000:6AF3  [+0x0EAF3]  00 00                    add     [bx+si],al
F000:6AF5  [+0x0EAF5]  00 00                    add     [bx+si],al
F000:6AF7  [+0x0EAF7]  00 00                    add     [bx+si],al
F000:6AF9  [+0x0EAF9]  00 00                    add     [bx+si],al
F000:6AFB  [+0x0EAFB]  00 00                    add     [bx+si],al
F000:6AFD  [+0x0EAFD]  00 00                    add     [bx+si],al
F000:6AFF  [+0x0EAFF]  00 00                    add     [bx+si],al
F000:6B01  [+0x0EB01]  00 00                    add     [bx+si],al
F000:6B03  [+0x0EB03]  00 00                    add     [bx+si],al
F000:6B05  [+0x0EB05]  00 00                    add     [bx+si],al
F000:6B07  [+0x0EB07]  00 00                    add     [bx+si],al
F000:6B09  [+0x0EB09]  00 00                    add     [bx+si],al
F000:6B0B  [+0x0EB0B]  00 00                    add     [bx+si],al
F000:6B0D  [+0x0EB0D]  00 00                    add     [bx+si],al
F000:6B0F  [+0x0EB0F]  00 00                    add     [bx+si],al
F000:6B11  [+0x0EB11]  00 00                    add     [bx+si],al
F000:6B13  [+0x0EB13]  00 00                    add     [bx+si],al
F000:6B15  [+0x0EB15]  00 00                    add     [bx+si],al
F000:6B17  [+0x0EB17]  00 00                    add     [bx+si],al
F000:6B19  [+0x0EB19]  00 00                    add     [bx+si],al
F000:6B1B  [+0x0EB1B]  00 00                    add     [bx+si],al
F000:6B1D  [+0x0EB1D]  00 00                    add     [bx+si],al
F000:6B1F  [+0x0EB1F]  00 00                    add     [bx+si],al
F000:6B21  [+0x0EB21]  00 00                    add     [bx+si],al
F000:6B23  [+0x0EB23]  00 00                    add     [bx+si],al
F000:6B25  [+0x0EB25]  00 00                    add     [bx+si],al
F000:6B27  [+0x0EB27]  00 00                    add     [bx+si],al
F000:6B29  [+0x0EB29]  00 00                    add     [bx+si],al
F000:6B2B  [+0x0EB2B]  00 00                    add     [bx+si],al
F000:6B2D  [+0x0EB2D]  00 00                    add     [bx+si],al
F000:6B2F  [+0x0EB2F]  00 00                    add     [bx+si],al
F000:6B31  [+0x0EB31]  00 00                    add     [bx+si],al
F000:6B33  [+0x0EB33]  00 00                    add     [bx+si],al
F000:6B35  [+0x0EB35]  00 00                    add     [bx+si],al
F000:6B37  [+0x0EB37]  00 00                    add     [bx+si],al
F000:6B39  [+0x0EB39]  00 00                    add     [bx+si],al
F000:6B3B  [+0x0EB3B]  00 00                    add     [bx+si],al
F000:6B3D  [+0x0EB3D]  00 00                    add     [bx+si],al
F000:6B3F  [+0x0EB3F]  00 00                    add     [bx+si],al
F000:6B41  [+0x0EB41]  00 00                    add     [bx+si],al
F000:6B43  [+0x0EB43]  00 00                    add     [bx+si],al
F000:6B45  [+0x0EB45]  00 00                    add     [bx+si],al
F000:6B47  [+0x0EB47]  00 00                    add     [bx+si],al
F000:6B49  [+0x0EB49]  00 00                    add     [bx+si],al
F000:6B4B  [+0x0EB4B]  00 00                    add     [bx+si],al
F000:6B4D  [+0x0EB4D]  00 00                    add     [bx+si],al
F000:6B4F  [+0x0EB4F]  00 00                    add     [bx+si],al
F000:6B51  [+0x0EB51]  00 00                    add     [bx+si],al
F000:6B53  [+0x0EB53]  00 00                    add     [bx+si],al
F000:6B55  [+0x0EB55]  00 00                    add     [bx+si],al
F000:6B57  [+0x0EB57]  00 00                    add     [bx+si],al
F000:6B59  [+0x0EB59]  00 00                    add     [bx+si],al
F000:6B5B  [+0x0EB5B]  00 00                    add     [bx+si],al
F000:6B5D  [+0x0EB5D]  00 00                    add     [bx+si],al
F000:6B5F  [+0x0EB5F]  00 00                    add     [bx+si],al
F000:6B61  [+0x0EB61]  00 00                    add     [bx+si],al
F000:6B63  [+0x0EB63]  00 00                    add     [bx+si],al
F000:6B65  [+0x0EB65]  00 00                    add     [bx+si],al
F000:6B67  [+0x0EB67]  00 00                    add     [bx+si],al
F000:6B69  [+0x0EB69]  00 00                    add     [bx+si],al
F000:6B6B  [+0x0EB6B]  00 00                    add     [bx+si],al
F000:6B6D  [+0x0EB6D]  00 00                    add     [bx+si],al
F000:6B6F  [+0x0EB6F]  00 00                    add     [bx+si],al
F000:6B71  [+0x0EB71]  00 00                    add     [bx+si],al
F000:6B73  [+0x0EB73]  00 00                    add     [bx+si],al
F000:6B75  [+0x0EB75]  00 00                    add     [bx+si],al
F000:6B77  [+0x0EB77]  00 00                    add     [bx+si],al
F000:6B79  [+0x0EB79]  00 00                    add     [bx+si],al
F000:6B7B  [+0x0EB7B]  00 00                    add     [bx+si],al
F000:6B7D  [+0x0EB7D]  00 00                    add     [bx+si],al
F000:6B7F  [+0x0EB7F]  00 00                    add     [bx+si],al
F000:6B81  [+0x0EB81]  00 00                    add     [bx+si],al
F000:6B83  [+0x0EB83]  00 00                    add     [bx+si],al
F000:6B85  [+0x0EB85]  00 00                    add     [bx+si],al
F000:6B87  [+0x0EB87]  00 00                    add     [bx+si],al
F000:6B89  [+0x0EB89]  00 00                    add     [bx+si],al
F000:6B8B  [+0x0EB8B]  00 00                    add     [bx+si],al
F000:6B8D  [+0x0EB8D]  00 00                    add     [bx+si],al
F000:6B8F  [+0x0EB8F]  00 00                    add     [bx+si],al
F000:6B91  [+0x0EB91]  00 00                    add     [bx+si],al
F000:6B93  [+0x0EB93]  00 00                    add     [bx+si],al
F000:6B95  [+0x0EB95]  00 00                    add     [bx+si],al
F000:6B97  [+0x0EB97]  00 00                    add     [bx+si],al
F000:6B99  [+0x0EB99]  00 00                    add     [bx+si],al
F000:6B9B  [+0x0EB9B]  00 00                    add     [bx+si],al
F000:6B9D  [+0x0EB9D]  00 00                    add     [bx+si],al
F000:6B9F  [+0x0EB9F]  00 00                    add     [bx+si],al
F000:6BA1  [+0x0EBA1]  00 00                    add     [bx+si],al
F000:6BA3  [+0x0EBA3]  00 00                    add     [bx+si],al
F000:6BA5  [+0x0EBA5]  00 00                    add     [bx+si],al
F000:6BA7  [+0x0EBA7]  00 00                    add     [bx+si],al
F000:6BA9  [+0x0EBA9]  00 00                    add     [bx+si],al
F000:6BAB  [+0x0EBAB]  00 00                    add     [bx+si],al
F000:6BAD  [+0x0EBAD]  00 00                    add     [bx+si],al
F000:6BAF  [+0x0EBAF]  00 00                    add     [bx+si],al
F000:6BB1  [+0x0EBB1]  00 00                    add     [bx+si],al
F000:6BB3  [+0x0EBB3]  00 00                    add     [bx+si],al
F000:6BB5  [+0x0EBB5]  00 00                    add     [bx+si],al
F000:6BB7  [+0x0EBB7]  00 00                    add     [bx+si],al
F000:6BB9  [+0x0EBB9]  00 00                    add     [bx+si],al
F000:6BBB  [+0x0EBBB]  00 00                    add     [bx+si],al
F000:6BBD  [+0x0EBBD]  00 00                    add     [bx+si],al
F000:6BBF  [+0x0EBBF]  00 00                    add     [bx+si],al
F000:6BC1  [+0x0EBC1]  00 00                    add     [bx+si],al
F000:6BC3  [+0x0EBC3]  00 00                    add     [bx+si],al
F000:6BC5  [+0x0EBC5]  00 00                    add     [bx+si],al
F000:6BC7  [+0x0EBC7]  00 00                    add     [bx+si],al
F000:6BC9  [+0x0EBC9]  00 00                    add     [bx+si],al
F000:6BCB  [+0x0EBCB]  00 00                    add     [bx+si],al
F000:6BCD  [+0x0EBCD]  00 00                    add     [bx+si],al
F000:6BCF  [+0x0EBCF]  00 00                    add     [bx+si],al
F000:6BD1  [+0x0EBD1]  00 00                    add     [bx+si],al
F000:6BD3  [+0x0EBD3]  00 00                    add     [bx+si],al
F000:6BD5  [+0x0EBD5]  00 00                    add     [bx+si],al
F000:6BD7  [+0x0EBD7]  00 00                    add     [bx+si],al
F000:6BD9  [+0x0EBD9]  00 00                    add     [bx+si],al
F000:6BDB  [+0x0EBDB]  00 00                    add     [bx+si],al
F000:6BDD  [+0x0EBDD]  00 00                    add     [bx+si],al
F000:6BDF  [+0x0EBDF]  00 00                    add     [bx+si],al
F000:6BE1  [+0x0EBE1]  00 00                    add     [bx+si],al
F000:6BE3  [+0x0EBE3]  00 00                    add     [bx+si],al
F000:6BE5  [+0x0EBE5]  00 00                    add     [bx+si],al
F000:6BE7  [+0x0EBE7]  00 00                    add     [bx+si],al
F000:6BE9  [+0x0EBE9]  00 00                    add     [bx+si],al
F000:6BEB  [+0x0EBEB]  00 00                    add     [bx+si],al
F000:6BED  [+0x0EBED]  00 00                    add     [bx+si],al
F000:6BEF  [+0x0EBEF]  00 00                    add     [bx+si],al
F000:6BF1  [+0x0EBF1]  00 00                    add     [bx+si],al
F000:6BF3  [+0x0EBF3]  00 00                    add     [bx+si],al
F000:6BF5  [+0x0EBF5]  00 00                    add     [bx+si],al
F000:6BF7  [+0x0EBF7]  00 00                    add     [bx+si],al
F000:6BF9  [+0x0EBF9]  00 00                    add     [bx+si],al
F000:6BFB  [+0x0EBFB]  00 00                    add     [bx+si],al
F000:6BFD  [+0x0EBFD]  00 00                    add     [bx+si],al
F000:6BFF  [+0x0EBFF]  00 00                    add     [bx+si],al
F000:6C01  [+0x0EC01]  00 00                    add     [bx+si],al
F000:6C03  [+0x0EC03]  00 00                    add     [bx+si],al
F000:6C05  [+0x0EC05]  00 00                    add     [bx+si],al
F000:6C07  [+0x0EC07]  00 00                    add     [bx+si],al
F000:6C09  [+0x0EC09]  00 00                    add     [bx+si],al
F000:6C0B  [+0x0EC0B]  00 00                    add     [bx+si],al
F000:6C0D  [+0x0EC0D]  00 00                    add     [bx+si],al
F000:6C0F  [+0x0EC0F]  00 00                    add     [bx+si],al
F000:6C11  [+0x0EC11]  00 00                    add     [bx+si],al
F000:6C13  [+0x0EC13]  00 00                    add     [bx+si],al
F000:6C15  [+0x0EC15]  00 00                    add     [bx+si],al
F000:6C17  [+0x0EC17]  00 00                    add     [bx+si],al
F000:6C19  [+0x0EC19]  00 00                    add     [bx+si],al
F000:6C1B  [+0x0EC1B]  00 00                    add     [bx+si],al
F000:6C1D  [+0x0EC1D]  00 00                    add     [bx+si],al
F000:6C1F  [+0x0EC1F]  00 00                    add     [bx+si],al
F000:6C21  [+0x0EC21]  00 00                    add     [bx+si],al
F000:6C23  [+0x0EC23]  00 00                    add     [bx+si],al
F000:6C25  [+0x0EC25]  00 00                    add     [bx+si],al
F000:6C27  [+0x0EC27]  00 00                    add     [bx+si],al
F000:6C29  [+0x0EC29]  00 00                    add     [bx+si],al
F000:6C2B  [+0x0EC2B]  00 00                    add     [bx+si],al
F000:6C2D  [+0x0EC2D]  00 00                    add     [bx+si],al
F000:6C2F  [+0x0EC2F]  00 00                    add     [bx+si],al
F000:6C31  [+0x0EC31]  00 00                    add     [bx+si],al
F000:6C33  [+0x0EC33]  00 00                    add     [bx+si],al
F000:6C35  [+0x0EC35]  00 00                    add     [bx+si],al
F000:6C37  [+0x0EC37]  00 00                    add     [bx+si],al
F000:6C39  [+0x0EC39]  00 00                    add     [bx+si],al
F000:6C3B  [+0x0EC3B]  00 00                    add     [bx+si],al
F000:6C3D  [+0x0EC3D]  00 00                    add     [bx+si],al
F000:6C3F  [+0x0EC3F]  00 00                    add     [bx+si],al
F000:6C41  [+0x0EC41]  00 00                    add     [bx+si],al
F000:6C43  [+0x0EC43]  00 00                    add     [bx+si],al
F000:6C45  [+0x0EC45]  00 00                    add     [bx+si],al
F000:6C47  [+0x0EC47]  00 00                    add     [bx+si],al
F000:6C49  [+0x0EC49]  00 00                    add     [bx+si],al
F000:6C4B  [+0x0EC4B]  00 00                    add     [bx+si],al
F000:6C4D  [+0x0EC4D]  00 00                    add     [bx+si],al
F000:6C4F  [+0x0EC4F]  00 00                    add     [bx+si],al
F000:6C51  [+0x0EC51]  00 00                    add     [bx+si],al
F000:6C53  [+0x0EC53]  00 00                    add     [bx+si],al
F000:6C55  [+0x0EC55]  00 00                    add     [bx+si],al
F000:6C57  [+0x0EC57]  00 00                    add     [bx+si],al
F000:6C59  [+0x0EC59]  00 00                    add     [bx+si],al
F000:6C5B  [+0x0EC5B]  00 00                    add     [bx+si],al
F000:6C5D  [+0x0EC5D]  00 00                    add     [bx+si],al
F000:6C5F  [+0x0EC5F]  00 00                    add     [bx+si],al
F000:6C61  [+0x0EC61]  00 00                    add     [bx+si],al
F000:6C63  [+0x0EC63]  00 00                    add     [bx+si],al
F000:6C65  [+0x0EC65]  00 00                    add     [bx+si],al
F000:6C67  [+0x0EC67]  00 00                    add     [bx+si],al
F000:6C69  [+0x0EC69]  00 00                    add     [bx+si],al
F000:6C6B  [+0x0EC6B]  00 00                    add     [bx+si],al
F000:6C6D  [+0x0EC6D]  00 00                    add     [bx+si],al
F000:6C6F  [+0x0EC6F]  00 00                    add     [bx+si],al
F000:6C71  [+0x0EC71]  00 00                    add     [bx+si],al
F000:6C73  [+0x0EC73]  00 00                    add     [bx+si],al
F000:6C75  [+0x0EC75]  00 00                    add     [bx+si],al
F000:6C77  [+0x0EC77]  00 00                    add     [bx+si],al
F000:6C79  [+0x0EC79]  00 00                    add     [bx+si],al
F000:6C7B  [+0x0EC7B]  00 00                    add     [bx+si],al
F000:6C7D  [+0x0EC7D]  00 00                    add     [bx+si],al
F000:6C7F  [+0x0EC7F]  00 00                    add     [bx+si],al
F000:6C81  [+0x0EC81]  00 00                    add     [bx+si],al
F000:6C83  [+0x0EC83]  00 00                    add     [bx+si],al
F000:6C85  [+0x0EC85]  00 00                    add     [bx+si],al
F000:6C87  [+0x0EC87]  00 00                    add     [bx+si],al
F000:6C89  [+0x0EC89]  00 00                    add     [bx+si],al
F000:6C8B  [+0x0EC8B]  00 00                    add     [bx+si],al
F000:6C8D  [+0x0EC8D]  00 00                    add     [bx+si],al
F000:6C8F  [+0x0EC8F]  00 00                    add     [bx+si],al
F000:6C91  [+0x0EC91]  00 00                    add     [bx+si],al
F000:6C93  [+0x0EC93]  00 00                    add     [bx+si],al
F000:6C95  [+0x0EC95]  00 00                    add     [bx+si],al
F000:6C97  [+0x0EC97]  00 00                    add     [bx+si],al
F000:6C99  [+0x0EC99]  00 00                    add     [bx+si],al
F000:6C9B  [+0x0EC9B]  00 00                    add     [bx+si],al
F000:6C9D  [+0x0EC9D]  00 00                    add     [bx+si],al
F000:6C9F  [+0x0EC9F]  00 00                    add     [bx+si],al
F000:6CA1  [+0x0ECA1]  00 00                    add     [bx+si],al
F000:6CA3  [+0x0ECA3]  00 00                    add     [bx+si],al
F000:6CA5  [+0x0ECA5]  00 00                    add     [bx+si],al
F000:6CA7  [+0x0ECA7]  00 00                    add     [bx+si],al
F000:6CA9  [+0x0ECA9]  00 00                    add     [bx+si],al
F000:6CAB  [+0x0ECAB]  00 00                    add     [bx+si],al
F000:6CAD  [+0x0ECAD]  00 00                    add     [bx+si],al
F000:6CAF  [+0x0ECAF]  00 00                    add     [bx+si],al
F000:6CB1  [+0x0ECB1]  00 00                    add     [bx+si],al
F000:6CB3  [+0x0ECB3]  00 00                    add     [bx+si],al
F000:6CB5  [+0x0ECB5]  00 00                    add     [bx+si],al
F000:6CB7  [+0x0ECB7]  00 00                    add     [bx+si],al
F000:6CB9  [+0x0ECB9]  00 00                    add     [bx+si],al
F000:6CBB  [+0x0ECBB]  00 00                    add     [bx+si],al
F000:6CBD  [+0x0ECBD]  00 00                    add     [bx+si],al
F000:6CBF  [+0x0ECBF]  00 00                    add     [bx+si],al
F000:6CC1  [+0x0ECC1]  00 00                    add     [bx+si],al
F000:6CC3  [+0x0ECC3]  00 00                    add     [bx+si],al
F000:6CC5  [+0x0ECC5]  00 00                    add     [bx+si],al
F000:6CC7  [+0x0ECC7]  00 00                    add     [bx+si],al
F000:6CC9  [+0x0ECC9]  00 00                    add     [bx+si],al
F000:6CCB  [+0x0ECCB]  00 00                    add     [bx+si],al
F000:6CCD  [+0x0ECCD]  00 00                    add     [bx+si],al
F000:6CCF  [+0x0ECCF]  00 00                    add     [bx+si],al
F000:6CD1  [+0x0ECD1]  00 00                    add     [bx+si],al
F000:6CD3  [+0x0ECD3]  00 00                    add     [bx+si],al
F000:6CD5  [+0x0ECD5]  00 00                    add     [bx+si],al
F000:6CD7  [+0x0ECD7]  00 00                    add     [bx+si],al
F000:6CD9  [+0x0ECD9]  00 00                    add     [bx+si],al
F000:6CDB  [+0x0ECDB]  00 00                    add     [bx+si],al
F000:6CDD  [+0x0ECDD]  00 00                    add     [bx+si],al
F000:6CDF  [+0x0ECDF]  00 00                    add     [bx+si],al
F000:6CE1  [+0x0ECE1]  00 00                    add     [bx+si],al
F000:6CE3  [+0x0ECE3]  00 00                    add     [bx+si],al
F000:6CE5  [+0x0ECE5]  00 00                    add     [bx+si],al
F000:6CE7  [+0x0ECE7]  00 00                    add     [bx+si],al
F000:6CE9  [+0x0ECE9]  00 00                    add     [bx+si],al
F000:6CEB  [+0x0ECEB]  00 00                    add     [bx+si],al
F000:6CED  [+0x0ECED]  00 00                    add     [bx+si],al
F000:6CEF  [+0x0ECEF]  00 00                    add     [bx+si],al
F000:6CF1  [+0x0ECF1]  00 00                    add     [bx+si],al
F000:6CF3  [+0x0ECF3]  00 00                    add     [bx+si],al
F000:6CF5  [+0x0ECF5]  00 00                    add     [bx+si],al
F000:6CF7  [+0x0ECF7]  00 00                    add     [bx+si],al
F000:6CF9  [+0x0ECF9]  00 00                    add     [bx+si],al
F000:6CFB  [+0x0ECFB]  00 00                    add     [bx+si],al
F000:6CFD  [+0x0ECFD]  00 00                    add     [bx+si],al
F000:6CFF  [+0x0ECFF]  00 00                    add     [bx+si],al
F000:6D01  [+0x0ED01]  00 00                    add     [bx+si],al
F000:6D03  [+0x0ED03]  00 00                    add     [bx+si],al
F000:6D05  [+0x0ED05]  00 00                    add     [bx+si],al
F000:6D07  [+0x0ED07]  00 00                    add     [bx+si],al
F000:6D09  [+0x0ED09]  00 00                    add     [bx+si],al
F000:6D0B  [+0x0ED0B]  00 00                    add     [bx+si],al
F000:6D0D  [+0x0ED0D]  00 00                    add     [bx+si],al
F000:6D0F  [+0x0ED0F]  00 00                    add     [bx+si],al
F000:6D11  [+0x0ED11]  00 00                    add     [bx+si],al
F000:6D13  [+0x0ED13]  00 00                    add     [bx+si],al
F000:6D15  [+0x0ED15]  00 00                    add     [bx+si],al
F000:6D17  [+0x0ED17]  00 00                    add     [bx+si],al
F000:6D19  [+0x0ED19]  00 00                    add     [bx+si],al
F000:6D1B  [+0x0ED1B]  00 00                    add     [bx+si],al
F000:6D1D  [+0x0ED1D]  00 00                    add     [bx+si],al
F000:6D1F  [+0x0ED1F]  00 00                    add     [bx+si],al
F000:6D21  [+0x0ED21]  00 00                    add     [bx+si],al
F000:6D23  [+0x0ED23]  00 00                    add     [bx+si],al
F000:6D25  [+0x0ED25]  00 00                    add     [bx+si],al
F000:6D27  [+0x0ED27]  00 00                    add     [bx+si],al
F000:6D29  [+0x0ED29]  00 00                    add     [bx+si],al
F000:6D2B  [+0x0ED2B]  00 00                    add     [bx+si],al
F000:6D2D  [+0x0ED2D]  00 00                    add     [bx+si],al
F000:6D2F  [+0x0ED2F]  00 00                    add     [bx+si],al
F000:6D31  [+0x0ED31]  00 00                    add     [bx+si],al
F000:6D33  [+0x0ED33]  00 00                    add     [bx+si],al
F000:6D35  [+0x0ED35]  00 00                    add     [bx+si],al
F000:6D37  [+0x0ED37]  00 00                    add     [bx+si],al
F000:6D39  [+0x0ED39]  00 00                    add     [bx+si],al
F000:6D3B  [+0x0ED3B]  00 00                    add     [bx+si],al
F000:6D3D  [+0x0ED3D]  00 00                    add     [bx+si],al
F000:6D3F  [+0x0ED3F]  00 00                    add     [bx+si],al
F000:6D41  [+0x0ED41]  00 00                    add     [bx+si],al
F000:6D43  [+0x0ED43]  00 00                    add     [bx+si],al
F000:6D45  [+0x0ED45]  00 00                    add     [bx+si],al
F000:6D47  [+0x0ED47]  00 00                    add     [bx+si],al
F000:6D49  [+0x0ED49]  00 00                    add     [bx+si],al
F000:6D4B  [+0x0ED4B]  00 00                    add     [bx+si],al
F000:6D4D  [+0x0ED4D]  00 00                    add     [bx+si],al
F000:6D4F  [+0x0ED4F]  00 00                    add     [bx+si],al
F000:6D51  [+0x0ED51]  00 00                    add     [bx+si],al
F000:6D53  [+0x0ED53]  00 00                    add     [bx+si],al
F000:6D55  [+0x0ED55]  00 00                    add     [bx+si],al
F000:6D57  [+0x0ED57]  00 00                    add     [bx+si],al
F000:6D59  [+0x0ED59]  00 00                    add     [bx+si],al
F000:6D5B  [+0x0ED5B]  00 00                    add     [bx+si],al
F000:6D5D  [+0x0ED5D]  00 00                    add     [bx+si],al
F000:6D5F  [+0x0ED5F]  00 00                    add     [bx+si],al
F000:6D61  [+0x0ED61]  00 00                    add     [bx+si],al
F000:6D63  [+0x0ED63]  00 00                    add     [bx+si],al
F000:6D65  [+0x0ED65]  00 00                    add     [bx+si],al
F000:6D67  [+0x0ED67]  00 00                    add     [bx+si],al
F000:6D69  [+0x0ED69]  00 00                    add     [bx+si],al
F000:6D6B  [+0x0ED6B]  00 00                    add     [bx+si],al
F000:6D6D  [+0x0ED6D]  00 00                    add     [bx+si],al
F000:6D6F  [+0x0ED6F]  00 00                    add     [bx+si],al
F000:6D71  [+0x0ED71]  00 00                    add     [bx+si],al
F000:6D73  [+0x0ED73]  00 00                    add     [bx+si],al
F000:6D75  [+0x0ED75]  00 00                    add     [bx+si],al
F000:6D77  [+0x0ED77]  00 00                    add     [bx+si],al
F000:6D79  [+0x0ED79]  00 00                    add     [bx+si],al
F000:6D7B  [+0x0ED7B]  00 00                    add     [bx+si],al
F000:6D7D  [+0x0ED7D]  00 00                    add     [bx+si],al
F000:6D7F  [+0x0ED7F]  00 00                    add     [bx+si],al
F000:6D81  [+0x0ED81]  00 00                    add     [bx+si],al
F000:6D83  [+0x0ED83]  00 00                    add     [bx+si],al
F000:6D85  [+0x0ED85]  00 00                    add     [bx+si],al
F000:6D87  [+0x0ED87]  00 00                    add     [bx+si],al
F000:6D89  [+0x0ED89]  00 00                    add     [bx+si],al
F000:6D8B  [+0x0ED8B]  00 00                    add     [bx+si],al
F000:6D8D  [+0x0ED8D]  00 00                    add     [bx+si],al
F000:6D8F  [+0x0ED8F]  00 00                    add     [bx+si],al
F000:6D91  [+0x0ED91]  00 00                    add     [bx+si],al
F000:6D93  [+0x0ED93]  00 00                    add     [bx+si],al
F000:6D95  [+0x0ED95]  00 00                    add     [bx+si],al
F000:6D97  [+0x0ED97]  00 00                    add     [bx+si],al
F000:6D99  [+0x0ED99]  00 00                    add     [bx+si],al
F000:6D9B  [+0x0ED9B]  00 00                    add     [bx+si],al
F000:6D9D  [+0x0ED9D]  00 00                    add     [bx+si],al
F000:6D9F  [+0x0ED9F]  00 00                    add     [bx+si],al
F000:6DA1  [+0x0EDA1]  00 00                    add     [bx+si],al
F000:6DA3  [+0x0EDA3]  00 00                    add     [bx+si],al
F000:6DA5  [+0x0EDA5]  00 00                    add     [bx+si],al
F000:6DA7  [+0x0EDA7]  00 00                    add     [bx+si],al
F000:6DA9  [+0x0EDA9]  00 00                    add     [bx+si],al
F000:6DAB  [+0x0EDAB]  00 00                    add     [bx+si],al
F000:6DAD  [+0x0EDAD]  00 00                    add     [bx+si],al
F000:6DAF  [+0x0EDAF]  00 00                    add     [bx+si],al
F000:6DB1  [+0x0EDB1]  00 00                    add     [bx+si],al
F000:6DB3  [+0x0EDB3]  00 00                    add     [bx+si],al
F000:6DB5  [+0x0EDB5]  00 00                    add     [bx+si],al
F000:6DB7  [+0x0EDB7]  00 00                    add     [bx+si],al
F000:6DB9  [+0x0EDB9]  00 00                    add     [bx+si],al
F000:6DBB  [+0x0EDBB]  00 00                    add     [bx+si],al
F000:6DBD  [+0x0EDBD]  00 00                    add     [bx+si],al
F000:6DBF  [+0x0EDBF]  00 00                    add     [bx+si],al
F000:6DC1  [+0x0EDC1]  00 00                    add     [bx+si],al
F000:6DC3  [+0x0EDC3]  00 00                    add     [bx+si],al
F000:6DC5  [+0x0EDC5]  00 00                    add     [bx+si],al
F000:6DC7  [+0x0EDC7]  00 00                    add     [bx+si],al
F000:6DC9  [+0x0EDC9]  00 00                    add     [bx+si],al
F000:6DCB  [+0x0EDCB]  00 00                    add     [bx+si],al
F000:6DCD  [+0x0EDCD]  00 00                    add     [bx+si],al
F000:6DCF  [+0x0EDCF]  00 00                    add     [bx+si],al
F000:6DD1  [+0x0EDD1]  00 00                    add     [bx+si],al
F000:6DD3  [+0x0EDD3]  00 00                    add     [bx+si],al
F000:6DD5  [+0x0EDD5]  00 00                    add     [bx+si],al
F000:6DD7  [+0x0EDD7]  00 00                    add     [bx+si],al
F000:6DD9  [+0x0EDD9]  00 00                    add     [bx+si],al
F000:6DDB  [+0x0EDDB]  00 00                    add     [bx+si],al
F000:6DDD  [+0x0EDDD]  00 00                    add     [bx+si],al
F000:6DDF  [+0x0EDDF]  00 00                    add     [bx+si],al
F000:6DE1  [+0x0EDE1]  00 00                    add     [bx+si],al
F000:6DE3  [+0x0EDE3]  00 00                    add     [bx+si],al
F000:6DE5  [+0x0EDE5]  00 00                    add     [bx+si],al
F000:6DE7  [+0x0EDE7]  00 00                    add     [bx+si],al
F000:6DE9  [+0x0EDE9]  00 00                    add     [bx+si],al
F000:6DEB  [+0x0EDEB]  00 00                    add     [bx+si],al
F000:6DED  [+0x0EDED]  00 00                    add     [bx+si],al
F000:6DEF  [+0x0EDEF]  00 00                    add     [bx+si],al
F000:6DF1  [+0x0EDF1]  00 00                    add     [bx+si],al
F000:6DF3  [+0x0EDF3]  00 00                    add     [bx+si],al
F000:6DF5  [+0x0EDF5]  00 00                    add     [bx+si],al
F000:6DF7  [+0x0EDF7]  00 00                    add     [bx+si],al
F000:6DF9  [+0x0EDF9]  00 00                    add     [bx+si],al
F000:6DFB  [+0x0EDFB]  00 00                    add     [bx+si],al
F000:6DFD  [+0x0EDFD]  00 00                    add     [bx+si],al
F000:6DFF  [+0x0EDFF]  00 00                    add     [bx+si],al
F000:6E01  [+0x0EE01]  00 00                    add     [bx+si],al
F000:6E03  [+0x0EE03]  00 00                    add     [bx+si],al
F000:6E05  [+0x0EE05]  00 00                    add     [bx+si],al
F000:6E07  [+0x0EE07]  00 00                    add     [bx+si],al
F000:6E09  [+0x0EE09]  00 00                    add     [bx+si],al
F000:6E0B  [+0x0EE0B]  00 00                    add     [bx+si],al
F000:6E0D  [+0x0EE0D]  00 00                    add     [bx+si],al
F000:6E0F  [+0x0EE0F]  00 00                    add     [bx+si],al
F000:6E11  [+0x0EE11]  00 00                    add     [bx+si],al
F000:6E13  [+0x0EE13]  00 00                    add     [bx+si],al
F000:6E15  [+0x0EE15]  00 00                    add     [bx+si],al
F000:6E17  [+0x0EE17]  00 00                    add     [bx+si],al
F000:6E19  [+0x0EE19]  00 00                    add     [bx+si],al
F000:6E1B  [+0x0EE1B]  00 00                    add     [bx+si],al
F000:6E1D  [+0x0EE1D]  00 00                    add     [bx+si],al
F000:6E1F  [+0x0EE1F]  00 00                    add     [bx+si],al
F000:6E21  [+0x0EE21]  00 00                    add     [bx+si],al
F000:6E23  [+0x0EE23]  00 00                    add     [bx+si],al
F000:6E25  [+0x0EE25]  00 00                    add     [bx+si],al
F000:6E27  [+0x0EE27]  00 00                    add     [bx+si],al
F000:6E29  [+0x0EE29]  00 00                    add     [bx+si],al
F000:6E2B  [+0x0EE2B]  00 00                    add     [bx+si],al
F000:6E2D  [+0x0EE2D]  00 00                    add     [bx+si],al
F000:6E2F  [+0x0EE2F]  00 00                    add     [bx+si],al
F000:6E31  [+0x0EE31]  00 00                    add     [bx+si],al
F000:6E33  [+0x0EE33]  00 00                    add     [bx+si],al
F000:6E35  [+0x0EE35]  00 00                    add     [bx+si],al
F000:6E37  [+0x0EE37]  00 00                    add     [bx+si],al
F000:6E39  [+0x0EE39]  00 00                    add     [bx+si],al
F000:6E3B  [+0x0EE3B]  00 00                    add     [bx+si],al
F000:6E3D  [+0x0EE3D]  00 00                    add     [bx+si],al
F000:6E3F  [+0x0EE3F]  00 00                    add     [bx+si],al
F000:6E41  [+0x0EE41]  00 00                    add     [bx+si],al
F000:6E43  [+0x0EE43]  00 00                    add     [bx+si],al
F000:6E45  [+0x0EE45]  00 00                    add     [bx+si],al
F000:6E47  [+0x0EE47]  00 00                    add     [bx+si],al
F000:6E49  [+0x0EE49]  00 00                    add     [bx+si],al
F000:6E4B  [+0x0EE4B]  00 00                    add     [bx+si],al
F000:6E4D  [+0x0EE4D]  00 00                    add     [bx+si],al
F000:6E4F  [+0x0EE4F]  00 00                    add     [bx+si],al
F000:6E51  [+0x0EE51]  00 00                    add     [bx+si],al
F000:6E53  [+0x0EE53]  00 00                    add     [bx+si],al
F000:6E55  [+0x0EE55]  00 00                    add     [bx+si],al
F000:6E57  [+0x0EE57]  00 00                    add     [bx+si],al
F000:6E59  [+0x0EE59]  00 00                    add     [bx+si],al
F000:6E5B  [+0x0EE5B]  00 00                    add     [bx+si],al
F000:6E5D  [+0x0EE5D]  00 00                    add     [bx+si],al
F000:6E5F  [+0x0EE5F]  00 00                    add     [bx+si],al
F000:6E61  [+0x0EE61]  00 00                    add     [bx+si],al
F000:6E63  [+0x0EE63]  00 00                    add     [bx+si],al
F000:6E65  [+0x0EE65]  00 00                    add     [bx+si],al
F000:6E67  [+0x0EE67]  00 00                    add     [bx+si],al
F000:6E69  [+0x0EE69]  00 00                    add     [bx+si],al
F000:6E6B  [+0x0EE6B]  00 00                    add     [bx+si],al
F000:6E6D  [+0x0EE6D]  00 00                    add     [bx+si],al
F000:6E6F  [+0x0EE6F]  00 00                    add     [bx+si],al
F000:6E71  [+0x0EE71]  00 00                    add     [bx+si],al
F000:6E73  [+0x0EE73]  00 00                    add     [bx+si],al
F000:6E75  [+0x0EE75]  00 00                    add     [bx+si],al
F000:6E77  [+0x0EE77]  00 00                    add     [bx+si],al
F000:6E79  [+0x0EE79]  00 00                    add     [bx+si],al
F000:6E7B  [+0x0EE7B]  00 00                    add     [bx+si],al
F000:6E7D  [+0x0EE7D]  00 00                    add     [bx+si],al
F000:6E7F  [+0x0EE7F]  00 00                    add     [bx+si],al
F000:6E81  [+0x0EE81]  00 00                    add     [bx+si],al
F000:6E83  [+0x0EE83]  00 00                    add     [bx+si],al
F000:6E85  [+0x0EE85]  00 00                    add     [bx+si],al
F000:6E87  [+0x0EE87]  00 00                    add     [bx+si],al
F000:6E89  [+0x0EE89]  00 00                    add     [bx+si],al
F000:6E8B  [+0x0EE8B]  00 00                    add     [bx+si],al
F000:6E8D  [+0x0EE8D]  00 00                    add     [bx+si],al
F000:6E8F  [+0x0EE8F]  00 00                    add     [bx+si],al
F000:6E91  [+0x0EE91]  00 00                    add     [bx+si],al
F000:6E93  [+0x0EE93]  00 00                    add     [bx+si],al
F000:6E95  [+0x0EE95]  00 00                    add     [bx+si],al
F000:6E97  [+0x0EE97]  00 00                    add     [bx+si],al
F000:6E99  [+0x0EE99]  00 00                    add     [bx+si],al
F000:6E9B  [+0x0EE9B]  00 00                    add     [bx+si],al
F000:6E9D  [+0x0EE9D]  00 00                    add     [bx+si],al
F000:6E9F  [+0x0EE9F]  00 00                    add     [bx+si],al
F000:6EA1  [+0x0EEA1]  00 00                    add     [bx+si],al
F000:6EA3  [+0x0EEA3]  00 00                    add     [bx+si],al
F000:6EA5  [+0x0EEA5]  00 00                    add     [bx+si],al
F000:6EA7  [+0x0EEA7]  00 00                    add     [bx+si],al
F000:6EA9  [+0x0EEA9]  00 00                    add     [bx+si],al
F000:6EAB  [+0x0EEAB]  00 00                    add     [bx+si],al
F000:6EAD  [+0x0EEAD]  00 00                    add     [bx+si],al
F000:6EAF  [+0x0EEAF]  00 00                    add     [bx+si],al
F000:6EB1  [+0x0EEB1]  00 00                    add     [bx+si],al
F000:6EB3  [+0x0EEB3]  00 00                    add     [bx+si],al
F000:6EB5  [+0x0EEB5]  00 00                    add     [bx+si],al
F000:6EB7  [+0x0EEB7]  00 00                    add     [bx+si],al
F000:6EB9  [+0x0EEB9]  00 00                    add     [bx+si],al
F000:6EBB  [+0x0EEBB]  00 00                    add     [bx+si],al
F000:6EBD  [+0x0EEBD]  00 00                    add     [bx+si],al
F000:6EBF  [+0x0EEBF]  00 00                    add     [bx+si],al
F000:6EC1  [+0x0EEC1]  00 00                    add     [bx+si],al
F000:6EC3  [+0x0EEC3]  00 00                    add     [bx+si],al
F000:6EC5  [+0x0EEC5]  00 00                    add     [bx+si],al
F000:6EC7  [+0x0EEC7]  00 00                    add     [bx+si],al
F000:6EC9  [+0x0EEC9]  00 00                    add     [bx+si],al
F000:6ECB  [+0x0EECB]  00 00                    add     [bx+si],al
F000:6ECD  [+0x0EECD]  00 00                    add     [bx+si],al
F000:6ECF  [+0x0EECF]  00 00                    add     [bx+si],al
F000:6ED1  [+0x0EED1]  00 00                    add     [bx+si],al
F000:6ED3  [+0x0EED3]  00 00                    add     [bx+si],al
F000:6ED5  [+0x0EED5]  00 00                    add     [bx+si],al
F000:6ED7  [+0x0EED7]  00 00                    add     [bx+si],al
F000:6ED9  [+0x0EED9]  00 00                    add     [bx+si],al
F000:6EDB  [+0x0EEDB]  00 00                    add     [bx+si],al
F000:6EDD  [+0x0EEDD]  00 00                    add     [bx+si],al
F000:6EDF  [+0x0EEDF]  00 00                    add     [bx+si],al
F000:6EE1  [+0x0EEE1]  00 00                    add     [bx+si],al
F000:6EE3  [+0x0EEE3]  00 00                    add     [bx+si],al
F000:6EE5  [+0x0EEE5]  00 00                    add     [bx+si],al
F000:6EE7  [+0x0EEE7]  00 00                    add     [bx+si],al
F000:6EE9  [+0x0EEE9]  00 00                    add     [bx+si],al
F000:6EEB  [+0x0EEEB]  00 00                    add     [bx+si],al
F000:6EED  [+0x0EEED]  00 00                    add     [bx+si],al
F000:6EEF  [+0x0EEEF]  00 00                    add     [bx+si],al
F000:6EF1  [+0x0EEF1]  00 00                    add     [bx+si],al
F000:6EF3  [+0x0EEF3]  00 00                    add     [bx+si],al
F000:6EF5  [+0x0EEF5]  00 00                    add     [bx+si],al
F000:6EF7  [+0x0EEF7]  00 00                    add     [bx+si],al
F000:6EF9  [+0x0EEF9]  00 00                    add     [bx+si],al
F000:6EFB  [+0x0EEFB]  00 00                    add     [bx+si],al
F000:6EFD  [+0x0EEFD]  00 00                    add     [bx+si],al
F000:6EFF  [+0x0EEFF]  00 00                    add     [bx+si],al
F000:6F01  [+0x0EF01]  00 00                    add     [bx+si],al
F000:6F03  [+0x0EF03]  00 00                    add     [bx+si],al
F000:6F05  [+0x0EF05]  00 00                    add     [bx+si],al
F000:6F07  [+0x0EF07]  00 00                    add     [bx+si],al
F000:6F09  [+0x0EF09]  00 00                    add     [bx+si],al
F000:6F0B  [+0x0EF0B]  00 00                    add     [bx+si],al
F000:6F0D  [+0x0EF0D]  00 00                    add     [bx+si],al
F000:6F0F  [+0x0EF0F]  00 00                    add     [bx+si],al
F000:6F11  [+0x0EF11]  00 00                    add     [bx+si],al
F000:6F13  [+0x0EF13]  00 00                    add     [bx+si],al
F000:6F15  [+0x0EF15]  00 00                    add     [bx+si],al
F000:6F17  [+0x0EF17]  00 00                    add     [bx+si],al
F000:6F19  [+0x0EF19]  00 00                    add     [bx+si],al
F000:6F1B  [+0x0EF1B]  00 00                    add     [bx+si],al
F000:6F1D  [+0x0EF1D]  00 00                    add     [bx+si],al
F000:6F1F  [+0x0EF1F]  00 00                    add     [bx+si],al
F000:6F21  [+0x0EF21]  00 00                    add     [bx+si],al
F000:6F23  [+0x0EF23]  00 00                    add     [bx+si],al
F000:6F25  [+0x0EF25]  00 00                    add     [bx+si],al
F000:6F27  [+0x0EF27]  00 00                    add     [bx+si],al
F000:6F29  [+0x0EF29]  00 00                    add     [bx+si],al
F000:6F2B  [+0x0EF2B]  00 00                    add     [bx+si],al
F000:6F2D  [+0x0EF2D]  00 00                    add     [bx+si],al
F000:6F2F  [+0x0EF2F]  00 00                    add     [bx+si],al
F000:6F31  [+0x0EF31]  00 00                    add     [bx+si],al
F000:6F33  [+0x0EF33]  00 00                    add     [bx+si],al
F000:6F35  [+0x0EF35]  00 00                    add     [bx+si],al
F000:6F37  [+0x0EF37]  00 00                    add     [bx+si],al
F000:6F39  [+0x0EF39]  00 00                    add     [bx+si],al
F000:6F3B  [+0x0EF3B]  00 00                    add     [bx+si],al
F000:6F3D  [+0x0EF3D]  00 00                    add     [bx+si],al
F000:6F3F  [+0x0EF3F]  00 00                    add     [bx+si],al
F000:6F41  [+0x0EF41]  00 00                    add     [bx+si],al
F000:6F43  [+0x0EF43]  00 00                    add     [bx+si],al
F000:6F45  [+0x0EF45]  00 00                    add     [bx+si],al
F000:6F47  [+0x0EF47]  00 00                    add     [bx+si],al
F000:6F49  [+0x0EF49]  00 00                    add     [bx+si],al
F000:6F4B  [+0x0EF4B]  00 00                    add     [bx+si],al
F000:6F4D  [+0x0EF4D]  00 00                    add     [bx+si],al
F000:6F4F  [+0x0EF4F]  00 00                    add     [bx+si],al
F000:6F51  [+0x0EF51]  00 00                    add     [bx+si],al
F000:6F53  [+0x0EF53]  00 00                    add     [bx+si],al
F000:6F55  [+0x0EF55]  00 00                    add     [bx+si],al
F000:6F57  [+0x0EF57]  00 00                    add     [bx+si],al
F000:6F59  [+0x0EF59]  00 00                    add     [bx+si],al
F000:6F5B  [+0x0EF5B]  00 00                    add     [bx+si],al
F000:6F5D  [+0x0EF5D]  00 00                    add     [bx+si],al
F000:6F5F  [+0x0EF5F]  00 00                    add     [bx+si],al
F000:6F61  [+0x0EF61]  00 00                    add     [bx+si],al
F000:6F63  [+0x0EF63]  00 00                    add     [bx+si],al
F000:6F65  [+0x0EF65]  00 00                    add     [bx+si],al
F000:6F67  [+0x0EF67]  00 00                    add     [bx+si],al
F000:6F69  [+0x0EF69]  00 00                    add     [bx+si],al
F000:6F6B  [+0x0EF6B]  00 00                    add     [bx+si],al
F000:6F6D  [+0x0EF6D]  00 00                    add     [bx+si],al
F000:6F6F  [+0x0EF6F]  00 00                    add     [bx+si],al
F000:6F71  [+0x0EF71]  00 00                    add     [bx+si],al
F000:6F73  [+0x0EF73]  00 00                    add     [bx+si],al
F000:6F75  [+0x0EF75]  00 00                    add     [bx+si],al
F000:6F77  [+0x0EF77]  00 00                    add     [bx+si],al
F000:6F79  [+0x0EF79]  00 00                    add     [bx+si],al
F000:6F7B  [+0x0EF7B]  00 00                    add     [bx+si],al
F000:6F7D  [+0x0EF7D]  00 00                    add     [bx+si],al
F000:6F7F  [+0x0EF7F]  00 00                    add     [bx+si],al
F000:6F81  [+0x0EF81]  00 00                    add     [bx+si],al
F000:6F83  [+0x0EF83]  00 00                    add     [bx+si],al
F000:6F85  [+0x0EF85]  00 00                    add     [bx+si],al
F000:6F87  [+0x0EF87]  00 00                    add     [bx+si],al
F000:6F89  [+0x0EF89]  00 00                    add     [bx+si],al
F000:6F8B  [+0x0EF8B]  00 00                    add     [bx+si],al
F000:6F8D  [+0x0EF8D]  00 00                    add     [bx+si],al
F000:6F8F  [+0x0EF8F]  00 00                    add     [bx+si],al
F000:6F91  [+0x0EF91]  00 00                    add     [bx+si],al
F000:6F93  [+0x0EF93]  00 00                    add     [bx+si],al
F000:6F95  [+0x0EF95]  00 00                    add     [bx+si],al
F000:6F97  [+0x0EF97]  00 00                    add     [bx+si],al
F000:6F99  [+0x0EF99]  00 00                    add     [bx+si],al
F000:6F9B  [+0x0EF9B]  00 00                    add     [bx+si],al
F000:6F9D  [+0x0EF9D]  00 00                    add     [bx+si],al
F000:6F9F  [+0x0EF9F]  00 00                    add     [bx+si],al
F000:6FA1  [+0x0EFA1]  00 00                    add     [bx+si],al
F000:6FA3  [+0x0EFA3]  00 00                    add     [bx+si],al
F000:6FA5  [+0x0EFA5]  00 00                    add     [bx+si],al
F000:6FA7  [+0x0EFA7]  00 00                    add     [bx+si],al
F000:6FA9  [+0x0EFA9]  00 00                    add     [bx+si],al
F000:6FAB  [+0x0EFAB]  00 00                    add     [bx+si],al
F000:6FAD  [+0x0EFAD]  00 00                    add     [bx+si],al
F000:6FAF  [+0x0EFAF]  00 00                    add     [bx+si],al
F000:6FB1  [+0x0EFB1]  00 00                    add     [bx+si],al
F000:6FB3  [+0x0EFB3]  00 00                    add     [bx+si],al
F000:6FB5  [+0x0EFB5]  00 00                    add     [bx+si],al
F000:6FB7  [+0x0EFB7]  00 00                    add     [bx+si],al
F000:6FB9  [+0x0EFB9]  00 00                    add     [bx+si],al
F000:6FBB  [+0x0EFBB]  00 00                    add     [bx+si],al
F000:6FBD  [+0x0EFBD]  00 00                    add     [bx+si],al
F000:6FBF  [+0x0EFBF]  00 00                    add     [bx+si],al
F000:6FC1  [+0x0EFC1]  00 00                    add     [bx+si],al
F000:6FC3  [+0x0EFC3]  00 00                    add     [bx+si],al
F000:6FC5  [+0x0EFC5]  00 00                    add     [bx+si],al
F000:6FC7  [+0x0EFC7]  00 00                    add     [bx+si],al
F000:6FC9  [+0x0EFC9]  00 00                    add     [bx+si],al
F000:6FCB  [+0x0EFCB]  00 00                    add     [bx+si],al
F000:6FCD  [+0x0EFCD]  00 00                    add     [bx+si],al
F000:6FCF  [+0x0EFCF]  00 00                    add     [bx+si],al
F000:6FD1  [+0x0EFD1]  00 00                    add     [bx+si],al
F000:6FD3  [+0x0EFD3]  00 00                    add     [bx+si],al
F000:6FD5  [+0x0EFD5]  00 00                    add     [bx+si],al
F000:6FD7  [+0x0EFD7]  00 00                    add     [bx+si],al
F000:6FD9  [+0x0EFD9]  00 00                    add     [bx+si],al
F000:6FDB  [+0x0EFDB]  00 00                    add     [bx+si],al
F000:6FDD  [+0x0EFDD]  00 00                    add     [bx+si],al
F000:6FDF  [+0x0EFDF]  00 00                    add     [bx+si],al
F000:6FE1  [+0x0EFE1]  00 00                    add     [bx+si],al
F000:6FE3  [+0x0EFE3]  00 00                    add     [bx+si],al
F000:6FE5  [+0x0EFE5]  00 00                    add     [bx+si],al
F000:6FE7  [+0x0EFE7]  00 00                    add     [bx+si],al
F000:6FE9  [+0x0EFE9]  00 00                    add     [bx+si],al
F000:6FEB  [+0x0EFEB]  00 00                    add     [bx+si],al
F000:6FED  [+0x0EFED]  00 00                    add     [bx+si],al
F000:6FEF  [+0x0EFEF]  00 00                    add     [bx+si],al
F000:6FF1  [+0x0EFF1]  00 00                    add     [bx+si],al
F000:6FF3  [+0x0EFF3]  00 00                    add     [bx+si],al
F000:6FF5  [+0x0EFF5]  00 00                    add     [bx+si],al
F000:6FF7  [+0x0EFF7]  00 00                    add     [bx+si],al
F000:6FF9  [+0x0EFF9]  00 00                    add     [bx+si],al
F000:6FFB  [+0x0EFFB]  00 00                    add     [bx+si],al
F000:6FFD  [+0x0EFFD]  00 00                    add     [bx+si],al
F000:6FFF  [+0x0EFFF]  00 00                    add     [bx+si],al
F000:7001  [+0x0F001]  00 00                    add     [bx+si],al
F000:7003  [+0x0F003]  00 00                    add     [bx+si],al
F000:7005  [+0x0F005]  00 00                    add     [bx+si],al
F000:7007  [+0x0F007]  00 00                    add     [bx+si],al
F000:7009  [+0x0F009]  00 00                    add     [bx+si],al
F000:700B  [+0x0F00B]  00 00                    add     [bx+si],al
F000:700D  [+0x0F00D]  00 00                    add     [bx+si],al
F000:700F  [+0x0F00F]  00 00                    add     [bx+si],al
F000:7011  [+0x0F011]  00 00                    add     [bx+si],al
F000:7013  [+0x0F013]  00 00                    add     [bx+si],al
F000:7015  [+0x0F015]  00 00                    add     [bx+si],al
F000:7017  [+0x0F017]  00 00                    add     [bx+si],al
F000:7019  [+0x0F019]  00 00                    add     [bx+si],al
F000:701B  [+0x0F01B]  00 00                    add     [bx+si],al
F000:701D  [+0x0F01D]  00 00                    add     [bx+si],al
F000:701F  [+0x0F01F]  00 00                    add     [bx+si],al
F000:7021  [+0x0F021]  00 00                    add     [bx+si],al
F000:7023  [+0x0F023]  00 00                    add     [bx+si],al
F000:7025  [+0x0F025]  00 00                    add     [bx+si],al
F000:7027  [+0x0F027]  00 00                    add     [bx+si],al
F000:7029  [+0x0F029]  00 00                    add     [bx+si],al
F000:702B  [+0x0F02B]  00 00                    add     [bx+si],al
F000:702D  [+0x0F02D]  00 00                    add     [bx+si],al
F000:702F  [+0x0F02F]  00 00                    add     [bx+si],al
F000:7031  [+0x0F031]  00 00                    add     [bx+si],al
F000:7033  [+0x0F033]  00 00                    add     [bx+si],al
F000:7035  [+0x0F035]  00 00                    add     [bx+si],al
F000:7037  [+0x0F037]  00 00                    add     [bx+si],al
F000:7039  [+0x0F039]  00 00                    add     [bx+si],al
F000:703B  [+0x0F03B]  00 00                    add     [bx+si],al
F000:703D  [+0x0F03D]  00 00                    add     [bx+si],al
F000:703F  [+0x0F03F]  00 00                    add     [bx+si],al
F000:7041  [+0x0F041]  00 00                    add     [bx+si],al
F000:7043  [+0x0F043]  00 00                    add     [bx+si],al
F000:7045  [+0x0F045]  00 00                    add     [bx+si],al
F000:7047  [+0x0F047]  00 00                    add     [bx+si],al
F000:7049  [+0x0F049]  00 00                    add     [bx+si],al
F000:704B  [+0x0F04B]  00 00                    add     [bx+si],al
F000:704D  [+0x0F04D]  00 00                    add     [bx+si],al
F000:704F  [+0x0F04F]  00 00                    add     [bx+si],al
F000:7051  [+0x0F051]  00 00                    add     [bx+si],al
F000:7053  [+0x0F053]  00 00                    add     [bx+si],al
F000:7055  [+0x0F055]  00 00                    add     [bx+si],al
F000:7057  [+0x0F057]  00 00                    add     [bx+si],al
F000:7059  [+0x0F059]  00 00                    add     [bx+si],al
F000:705B  [+0x0F05B]  00 00                    add     [bx+si],al
F000:705D  [+0x0F05D]  00 00                    add     [bx+si],al
F000:705F  [+0x0F05F]  00 00                    add     [bx+si],al
F000:7061  [+0x0F061]  00 00                    add     [bx+si],al
F000:7063  [+0x0F063]  00 00                    add     [bx+si],al
F000:7065  [+0x0F065]  00 00                    add     [bx+si],al
F000:7067  [+0x0F067]  00 00                    add     [bx+si],al
F000:7069  [+0x0F069]  00 00                    add     [bx+si],al
F000:706B  [+0x0F06B]  00 00                    add     [bx+si],al
F000:706D  [+0x0F06D]  00 00                    add     [bx+si],al
F000:706F  [+0x0F06F]  00 00                    add     [bx+si],al
F000:7071  [+0x0F071]  00 00                    add     [bx+si],al
F000:7073  [+0x0F073]  00 00                    add     [bx+si],al
F000:7075  [+0x0F075]  00 00                    add     [bx+si],al
F000:7077  [+0x0F077]  00 00                    add     [bx+si],al
F000:7079  [+0x0F079]  00 00                    add     [bx+si],al
F000:707B  [+0x0F07B]  00 00                    add     [bx+si],al
F000:707D  [+0x0F07D]  00 00                    add     [bx+si],al
F000:707F  [+0x0F07F]  00 00                    add     [bx+si],al
F000:7081  [+0x0F081]  00 00                    add     [bx+si],al
F000:7083  [+0x0F083]  00 00                    add     [bx+si],al
F000:7085  [+0x0F085]  00 00                    add     [bx+si],al
F000:7087  [+0x0F087]  00 00                    add     [bx+si],al
F000:7089  [+0x0F089]  00 00                    add     [bx+si],al
F000:708B  [+0x0F08B]  00 00                    add     [bx+si],al
F000:708D  [+0x0F08D]  00 00                    add     [bx+si],al
F000:708F  [+0x0F08F]  00 00                    add     [bx+si],al
F000:7091  [+0x0F091]  00 00                    add     [bx+si],al
F000:7093  [+0x0F093]  00 00                    add     [bx+si],al
F000:7095  [+0x0F095]  00 00                    add     [bx+si],al
F000:7097  [+0x0F097]  00 00                    add     [bx+si],al
F000:7099  [+0x0F099]  00 00                    add     [bx+si],al
F000:709B  [+0x0F09B]  00 00                    add     [bx+si],al
F000:709D  [+0x0F09D]  00 00                    add     [bx+si],al
F000:709F  [+0x0F09F]  00 00                    add     [bx+si],al
F000:70A1  [+0x0F0A1]  00 00                    add     [bx+si],al
F000:70A3  [+0x0F0A3]  00 00                    add     [bx+si],al
F000:70A5  [+0x0F0A5]  00 00                    add     [bx+si],al
F000:70A7  [+0x0F0A7]  00 00                    add     [bx+si],al
F000:70A9  [+0x0F0A9]  00 00                    add     [bx+si],al
F000:70AB  [+0x0F0AB]  00 00                    add     [bx+si],al
F000:70AD  [+0x0F0AD]  00 00                    add     [bx+si],al
F000:70AF  [+0x0F0AF]  00 00                    add     [bx+si],al
F000:70B1  [+0x0F0B1]  00 00                    add     [bx+si],al
F000:70B3  [+0x0F0B3]  00 00                    add     [bx+si],al
F000:70B5  [+0x0F0B5]  00 00                    add     [bx+si],al
F000:70B7  [+0x0F0B7]  00 00                    add     [bx+si],al
F000:70B9  [+0x0F0B9]  00 00                    add     [bx+si],al
F000:70BB  [+0x0F0BB]  00 00                    add     [bx+si],al
F000:70BD  [+0x0F0BD]  00 00                    add     [bx+si],al
F000:70BF  [+0x0F0BF]  00 00                    add     [bx+si],al
F000:70C1  [+0x0F0C1]  00 00                    add     [bx+si],al
F000:70C3  [+0x0F0C3]  00 00                    add     [bx+si],al
F000:70C5  [+0x0F0C5]  00 00                    add     [bx+si],al
F000:70C7  [+0x0F0C7]  00 00                    add     [bx+si],al
F000:70C9  [+0x0F0C9]  00 00                    add     [bx+si],al
F000:70CB  [+0x0F0CB]  00 00                    add     [bx+si],al
F000:70CD  [+0x0F0CD]  00 00                    add     [bx+si],al
F000:70CF  [+0x0F0CF]  00 00                    add     [bx+si],al
F000:70D1  [+0x0F0D1]  00 00                    add     [bx+si],al
F000:70D3  [+0x0F0D3]  00 00                    add     [bx+si],al
F000:70D5  [+0x0F0D5]  00 00                    add     [bx+si],al
F000:70D7  [+0x0F0D7]  00 00                    add     [bx+si],al
F000:70D9  [+0x0F0D9]  00 00                    add     [bx+si],al
F000:70DB  [+0x0F0DB]  00 00                    add     [bx+si],al
F000:70DD  [+0x0F0DD]  00 00                    add     [bx+si],al
F000:70DF  [+0x0F0DF]  00 00                    add     [bx+si],al
F000:70E1  [+0x0F0E1]  00 00                    add     [bx+si],al
F000:70E3  [+0x0F0E3]  00 00                    add     [bx+si],al
F000:70E5  [+0x0F0E5]  00 00                    add     [bx+si],al
F000:70E7  [+0x0F0E7]  00 00                    add     [bx+si],al
F000:70E9  [+0x0F0E9]  00 00                    add     [bx+si],al
F000:70EB  [+0x0F0EB]  00 00                    add     [bx+si],al
F000:70ED  [+0x0F0ED]  00 00                    add     [bx+si],al
F000:70EF  [+0x0F0EF]  00 00                    add     [bx+si],al
F000:70F1  [+0x0F0F1]  00 00                    add     [bx+si],al
F000:70F3  [+0x0F0F3]  00 00                    add     [bx+si],al
F000:70F5  [+0x0F0F5]  00 00                    add     [bx+si],al
F000:70F7  [+0x0F0F7]  00 00                    add     [bx+si],al
F000:70F9  [+0x0F0F9]  00 00                    add     [bx+si],al
F000:70FB  [+0x0F0FB]  00 00                    add     [bx+si],al
F000:70FD  [+0x0F0FD]  00 00                    add     [bx+si],al
F000:70FF  [+0x0F0FF]  00 00                    add     [bx+si],al
F000:7101  [+0x0F101]  00 00                    add     [bx+si],al
F000:7103  [+0x0F103]  00 00                    add     [bx+si],al
F000:7105  [+0x0F105]  00 00                    add     [bx+si],al
F000:7107  [+0x0F107]  00 00                    add     [bx+si],al
F000:7109  [+0x0F109]  00 00                    add     [bx+si],al
F000:710B  [+0x0F10B]  00 00                    add     [bx+si],al
F000:710D  [+0x0F10D]  00 00                    add     [bx+si],al
F000:710F  [+0x0F10F]  00 00                    add     [bx+si],al
F000:7111  [+0x0F111]  00 00                    add     [bx+si],al
F000:7113  [+0x0F113]  00 00                    add     [bx+si],al
F000:7115  [+0x0F115]  00 00                    add     [bx+si],al
F000:7117  [+0x0F117]  00 00                    add     [bx+si],al
F000:7119  [+0x0F119]  00 00                    add     [bx+si],al
F000:711B  [+0x0F11B]  00 00                    add     [bx+si],al
F000:711D  [+0x0F11D]  00 00                    add     [bx+si],al
F000:711F  [+0x0F11F]  00 00                    add     [bx+si],al
F000:7121  [+0x0F121]  00 00                    add     [bx+si],al
F000:7123  [+0x0F123]  00 00                    add     [bx+si],al
F000:7125  [+0x0F125]  00 00                    add     [bx+si],al
F000:7127  [+0x0F127]  00 00                    add     [bx+si],al
F000:7129  [+0x0F129]  00 00                    add     [bx+si],al
F000:712B  [+0x0F12B]  00 00                    add     [bx+si],al
F000:712D  [+0x0F12D]  00 00                    add     [bx+si],al
F000:712F  [+0x0F12F]  00 00                    add     [bx+si],al
F000:7131  [+0x0F131]  00 00                    add     [bx+si],al
F000:7133  [+0x0F133]  00 00                    add     [bx+si],al
F000:7135  [+0x0F135]  00 00                    add     [bx+si],al
F000:7137  [+0x0F137]  00 00                    add     [bx+si],al
F000:7139  [+0x0F139]  00 00                    add     [bx+si],al
F000:713B  [+0x0F13B]  00 00                    add     [bx+si],al
F000:713D  [+0x0F13D]  00 00                    add     [bx+si],al
F000:713F  [+0x0F13F]  00 00                    add     [bx+si],al
F000:7141  [+0x0F141]  00 00                    add     [bx+si],al
F000:7143  [+0x0F143]  00 00                    add     [bx+si],al
F000:7145  [+0x0F145]  00 00                    add     [bx+si],al
F000:7147  [+0x0F147]  00 00                    add     [bx+si],al
F000:7149  [+0x0F149]  00 00                    add     [bx+si],al
F000:714B  [+0x0F14B]  00 00                    add     [bx+si],al
F000:714D  [+0x0F14D]  00 00                    add     [bx+si],al
F000:714F  [+0x0F14F]  00 00                    add     [bx+si],al
F000:7151  [+0x0F151]  00 00                    add     [bx+si],al
F000:7153  [+0x0F153]  00 00                    add     [bx+si],al
F000:7155  [+0x0F155]  00 00                    add     [bx+si],al
F000:7157  [+0x0F157]  00 00                    add     [bx+si],al
F000:7159  [+0x0F159]  00 00                    add     [bx+si],al
F000:715B  [+0x0F15B]  00 00                    add     [bx+si],al
F000:715D  [+0x0F15D]  00 00                    add     [bx+si],al
F000:715F  [+0x0F15F]  00 00                    add     [bx+si],al
F000:7161  [+0x0F161]  00 00                    add     [bx+si],al
F000:7163  [+0x0F163]  00 00                    add     [bx+si],al
F000:7165  [+0x0F165]  00 00                    add     [bx+si],al
F000:7167  [+0x0F167]  00 00                    add     [bx+si],al
F000:7169  [+0x0F169]  00 00                    add     [bx+si],al
F000:716B  [+0x0F16B]  00 00                    add     [bx+si],al
F000:716D  [+0x0F16D]  00 00                    add     [bx+si],al
F000:716F  [+0x0F16F]  DB 0xFF  (bad)
F000:7171  [+0x0F171]  00 00                    add     [bx+si],al
F000:7173  [+0x0F173]  00 92 8F 00              add     [bp+si+8Fh],dl
F000:7177  [+0x0F177]  00 00                    add     [bx+si],al
F000:7179  [+0x0F179]  00 00                    add     [bx+si],al
F000:717B  [+0x0F17B]  00 00                    add     [bx+si],al
F000:717D  [+0x0F17D]  00 00                    add     [bx+si],al
F000:717F  [+0x0F17F]  00 00                    add     [bx+si],al
F000:7181  [+0x0F181]  00 00                    add     [bx+si],al
F000:7183  [+0x0F183]  00 00                    add     [bx+si],al
F000:7185  [+0x0F185]  00 00                    add     [bx+si],al
F000:7187  [+0x0F187]  00 00                    add     [bx+si],al
F000:7189  [+0x0F189]  00 00                    add     [bx+si],al
F000:718B  [+0x0F18B]  00 00                    add     [bx+si],al
F000:718D  [+0x0F18D]  00 00                    add     [bx+si],al
F000:718F  [+0x0F18F]  00 00                    add     [bx+si],al
F000:7191  [+0x0F191]  00 00                    add     [bx+si],al
F000:7193  [+0x0F193]  00 00                    add     [bx+si],al
F000:7195  [+0x0F195]  00 00                    add     [bx+si],al
F000:7197  [+0x0F197]  00 00                    add     [bx+si],al
F000:7199  [+0x0F199]  00 00                    add     [bx+si],al
F000:719B  [+0x0F19B]  00 00                    add     [bx+si],al
F000:719D  [+0x0F19D]  00 00                    add     [bx+si],al
F000:719F  [+0x0F19F]  00 00                    add     [bx+si],al
F000:71A1  [+0x0F1A1]  00 00                    add     [bx+si],al
F000:71A3  [+0x0F1A3]  00 00                    add     [bx+si],al
F000:71A5  [+0x0F1A5]  00 00                    add     [bx+si],al
F000:71A7  [+0x0F1A7]  00 00                    add     [bx+si],al
F000:71A9  [+0x0F1A9]  00 00                    add     [bx+si],al
F000:71AB  [+0x0F1AB]  00 00                    add     [bx+si],al
F000:71AD  [+0x0F1AD]  00 00                    add     [bx+si],al
F000:71AF  [+0x0F1AF]  00 00                    add     [bx+si],al
F000:71B1  [+0x0F1B1]  00 00                    add     [bx+si],al
F000:71B3  [+0x0F1B3]  00 00                    add     [bx+si],al
F000:71B5  [+0x0F1B5]  00 00                    add     [bx+si],al
F000:71B7  [+0x0F1B7]  00 00                    add     [bx+si],al
F000:71B9  [+0x0F1B9]  00 00                    add     [bx+si],al
F000:71BB  [+0x0F1BB]  00 00                    add     [bx+si],al
F000:71BD  [+0x0F1BD]  00 00                    add     [bx+si],al
F000:71BF  [+0x0F1BF]  00 00                    add     [bx+si],al
F000:71C1  [+0x0F1C1]  00 00                    add     [bx+si],al
F000:71C3  [+0x0F1C3]  00 00                    add     [bx+si],al
F000:71C5  [+0x0F1C5]  00 00                    add     [bx+si],al
F000:71C7  [+0x0F1C7]  00 00                    add     [bx+si],al
F000:71C9  [+0x0F1C9]  00 00                    add     [bx+si],al
F000:71CB  [+0x0F1CB]  00 00                    add     [bx+si],al
F000:71CD  [+0x0F1CD]  00 00                    add     [bx+si],al
F000:71CF  [+0x0F1CF]  00 00                    add     [bx+si],al
F000:71D1  [+0x0F1D1]  00 00                    add     [bx+si],al
F000:71D3  [+0x0F1D3]  00 00                    add     [bx+si],al
F000:71D5  [+0x0F1D5]  00 00                    add     [bx+si],al
F000:71D7  [+0x0F1D7]  00 00                    add     [bx+si],al
F000:71D9  [+0x0F1D9]  00 00                    add     [bx+si],al
F000:71DB  [+0x0F1DB]  00 00                    add     [bx+si],al
F000:71DD  [+0x0F1DD]  00 00                    add     [bx+si],al
F000:71DF  [+0x0F1DF]  00 00                    add     [bx+si],al
F000:71E1  [+0x0F1E1]  00 00                    add     [bx+si],al
F000:71E3  [+0x0F1E3]  00 00                    add     [bx+si],al
F000:71E5  [+0x0F1E5]  00 00                    add     [bx+si],al
F000:71E7  [+0x0F1E7]  00 00                    add     [bx+si],al
F000:71E9  [+0x0F1E9]  00 00                    add     [bx+si],al
F000:71EB  [+0x0F1EB]  00 00                    add     [bx+si],al
F000:71ED  [+0x0F1ED]  00 00                    add     [bx+si],al
F000:71EF  [+0x0F1EF]  00 00                    add     [bx+si],al
F000:71F1  [+0x0F1F1]  00 00                    add     [bx+si],al
F000:71F3  [+0x0F1F3]  00 00                    add     [bx+si],al
F000:71F5  [+0x0F1F5]  00 00                    add     [bx+si],al
F000:71F7  [+0x0F1F7]  00 00                    add     [bx+si],al
F000:71F9  [+0x0F1F9]  00 00                    add     [bx+si],al
F000:71FB  [+0x0F1FB]  00 00                    add     [bx+si],al
F000:71FD  [+0x0F1FD]  00 00                    add     [bx+si],al
F000:71FF  [+0x0F1FF]  00 00                    add     [bx+si],al
F000:7201  [+0x0F201]  00 00                    add     [bx+si],al
F000:7203  [+0x0F203]  00 00                    add     [bx+si],al
F000:7205  [+0x0F205]  00 00                    add     [bx+si],al
F000:7207  [+0x0F207]  00 00                    add     [bx+si],al
F000:7209  [+0x0F209]  00 00                    add     [bx+si],al
F000:720B  [+0x0F20B]  00 00                    add     [bx+si],al
F000:720D  [+0x0F20D]  00 00                    add     [bx+si],al
F000:720F  [+0x0F20F]  00 00                    add     [bx+si],al
F000:7211  [+0x0F211]  00 00                    add     [bx+si],al
F000:7213  [+0x0F213]  00 00                    add     [bx+si],al
F000:7215  [+0x0F215]  00 00                    add     [bx+si],al
F000:7217  [+0x0F217]  00 00                    add     [bx+si],al
F000:7219  [+0x0F219]  00 00                    add     [bx+si],al
F000:721B  [+0x0F21B]  00 00                    add     [bx+si],al
F000:721D  [+0x0F21D]  00 00                    add     [bx+si],al
F000:721F  [+0x0F21F]  00 00                    add     [bx+si],al
F000:7221  [+0x0F221]  00 00                    add     [bx+si],al
F000:7223  [+0x0F223]  00 00                    add     [bx+si],al
F000:7225  [+0x0F225]  00 00                    add     [bx+si],al
F000:7227  [+0x0F227]  00 00                    add     [bx+si],al
F000:7229  [+0x0F229]  00 00                    add     [bx+si],al
F000:722B  [+0x0F22B]  00 00                    add     [bx+si],al
F000:722D  [+0x0F22D]  00 00                    add     [bx+si],al
F000:722F  [+0x0F22F]  00 00                    add     [bx+si],al
F000:7231  [+0x0F231]  00 00                    add     [bx+si],al
F000:7233  [+0x0F233]  00 00                    add     [bx+si],al
F000:7235  [+0x0F235]  00 00                    add     [bx+si],al
F000:7237  [+0x0F237]  00 00                    add     [bx+si],al
F000:7239  [+0x0F239]  00 00                    add     [bx+si],al
F000:723B  [+0x0F23B]  00 00                    add     [bx+si],al
F000:723D  [+0x0F23D]  00 00                    add     [bx+si],al
F000:723F  [+0x0F23F]  00 00                    add     [bx+si],al
F000:7241  [+0x0F241]  00 00                    add     [bx+si],al
F000:7243  [+0x0F243]  00 00                    add     [bx+si],al
F000:7245  [+0x0F245]  00 00                    add     [bx+si],al
F000:7247  [+0x0F247]  00 00                    add     [bx+si],al
F000:7249  [+0x0F249]  00 00                    add     [bx+si],al
F000:724B  [+0x0F24B]  00 00                    add     [bx+si],al
F000:724D  [+0x0F24D]  00 00                    add     [bx+si],al
F000:724F  [+0x0F24F]  00 00                    add     [bx+si],al
F000:7251  [+0x0F251]  00 00                    add     [bx+si],al
F000:7253  [+0x0F253]  00 00                    add     [bx+si],al
F000:7255  [+0x0F255]  00 00                    add     [bx+si],al
F000:7257  [+0x0F257]  00 00                    add     [bx+si],al
F000:7259  [+0x0F259]  00 00                    add     [bx+si],al
F000:725B  [+0x0F25B]  00 00                    add     [bx+si],al
F000:725D  [+0x0F25D]  00 00                    add     [bx+si],al
F000:725F  [+0x0F25F]  00 00                    add     [bx+si],al
F000:7261  [+0x0F261]  00 00                    add     [bx+si],al
F000:7263  [+0x0F263]  00 00                    add     [bx+si],al
F000:7265  [+0x0F265]  00 00                    add     [bx+si],al
F000:7267  [+0x0F267]  00 00                    add     [bx+si],al
F000:7269  [+0x0F269]  00 00                    add     [bx+si],al
F000:726B  [+0x0F26B]  00 00                    add     [bx+si],al
F000:726D  [+0x0F26D]  00 00                    add     [bx+si],al
F000:726F  [+0x0F26F]  00 00                    add     [bx+si],al
F000:7271  [+0x0F271]  00 00                    add     [bx+si],al
F000:7273  [+0x0F273]  00 00                    add     [bx+si],al
F000:7275  [+0x0F275]  00 00                    add     [bx+si],al
F000:7277  [+0x0F277]  00 00                    add     [bx+si],al
F000:7279  [+0x0F279]  00 00                    add     [bx+si],al
F000:727B  [+0x0F27B]  00 00                    add     [bx+si],al
F000:727D  [+0x0F27D]  00 00                    add     [bx+si],al
F000:727F  [+0x0F27F]  00 00                    add     [bx+si],al
F000:7281  [+0x0F281]  00 00                    add     [bx+si],al
F000:7283  [+0x0F283]  00 00                    add     [bx+si],al
F000:7285  [+0x0F285]  00 00                    add     [bx+si],al
F000:7287  [+0x0F287]  00 00                    add     [bx+si],al
F000:7289  [+0x0F289]  00 00                    add     [bx+si],al
F000:728B  [+0x0F28B]  00 00                    add     [bx+si],al
F000:728D  [+0x0F28D]  00 00                    add     [bx+si],al
F000:728F  [+0x0F28F]  00 00                    add     [bx+si],al
F000:7291  [+0x0F291]  00 00                    add     [bx+si],al
F000:7293  [+0x0F293]  00 00                    add     [bx+si],al
F000:7295  [+0x0F295]  00 00                    add     [bx+si],al
F000:7297  [+0x0F297]  00 00                    add     [bx+si],al
F000:7299  [+0x0F299]  00 00                    add     [bx+si],al
F000:729B  [+0x0F29B]  00 00                    add     [bx+si],al
F000:729D  [+0x0F29D]  00 00                    add     [bx+si],al
F000:729F  [+0x0F29F]  00 00                    add     [bx+si],al
F000:72A1  [+0x0F2A1]  00 00                    add     [bx+si],al
F000:72A3  [+0x0F2A3]  00 00                    add     [bx+si],al
F000:72A5  [+0x0F2A5]  00 00                    add     [bx+si],al
F000:72A7  [+0x0F2A7]  00 00                    add     [bx+si],al
F000:72A9  [+0x0F2A9]  00 00                    add     [bx+si],al
F000:72AB  [+0x0F2AB]  00 00                    add     [bx+si],al
F000:72AD  [+0x0F2AD]  00 00                    add     [bx+si],al
F000:72AF  [+0x0F2AF]  00 00                    add     [bx+si],al
F000:72B1  [+0x0F2B1]  00 00                    add     [bx+si],al
F000:72B3  [+0x0F2B3]  00 00                    add     [bx+si],al
F000:72B5  [+0x0F2B5]  00 00                    add     [bx+si],al
F000:72B7  [+0x0F2B7]  00 00                    add     [bx+si],al
F000:72B9  [+0x0F2B9]  00 00                    add     [bx+si],al
F000:72BB  [+0x0F2BB]  00 00                    add     [bx+si],al
F000:72BD  [+0x0F2BD]  00 00                    add     [bx+si],al
F000:72BF  [+0x0F2BF]  00 00                    add     [bx+si],al
F000:72C1  [+0x0F2C1]  00 00                    add     [bx+si],al
F000:72C3  [+0x0F2C3]  00 00                    add     [bx+si],al
F000:72C5  [+0x0F2C5]  00 00                    add     [bx+si],al
F000:72C7  [+0x0F2C7]  00 00                    add     [bx+si],al
F000:72C9  [+0x0F2C9]  00 00                    add     [bx+si],al
F000:72CB  [+0x0F2CB]  00 00                    add     [bx+si],al
F000:72CD  [+0x0F2CD]  00 00                    add     [bx+si],al
F000:72CF  [+0x0F2CF]  00 00                    add     [bx+si],al
F000:72D1  [+0x0F2D1]  00 00                    add     [bx+si],al
F000:72D3  [+0x0F2D3]  00 00                    add     [bx+si],al
F000:72D5  [+0x0F2D5]  00 00                    add     [bx+si],al
F000:72D7  [+0x0F2D7]  00 00                    add     [bx+si],al
F000:72D9  [+0x0F2D9]  00 00                    add     [bx+si],al
F000:72DB  [+0x0F2DB]  00 00                    add     [bx+si],al
F000:72DD  [+0x0F2DD]  00 00                    add     [bx+si],al
F000:72DF  [+0x0F2DF]  00 00                    add     [bx+si],al
F000:72E1  [+0x0F2E1]  00 00                    add     [bx+si],al
F000:72E3  [+0x0F2E3]  00 00                    add     [bx+si],al
F000:72E5  [+0x0F2E5]  00 00                    add     [bx+si],al
F000:72E7  [+0x0F2E7]  00 00                    add     [bx+si],al
F000:72E9  [+0x0F2E9]  00 00                    add     [bx+si],al
F000:72EB  [+0x0F2EB]  00 00                    add     [bx+si],al
F000:72ED  [+0x0F2ED]  00 00                    add     [bx+si],al
F000:72EF  [+0x0F2EF]  00 00                    add     [bx+si],al
F000:72F1  [+0x0F2F1]  00 00                    add     [bx+si],al
F000:72F3  [+0x0F2F3]  00 00                    add     [bx+si],al
F000:72F5  [+0x0F2F5]  00 00                    add     [bx+si],al
F000:72F7  [+0x0F2F7]  00 00                    add     [bx+si],al
F000:72F9  [+0x0F2F9]  00 00                    add     [bx+si],al
F000:72FB  [+0x0F2FB]  00 00                    add     [bx+si],al
F000:72FD  [+0x0F2FD]  00 00                    add     [bx+si],al
F000:72FF  [+0x0F2FF]  00 00                    add     [bx+si],al
F000:7301  [+0x0F301]  00 00                    add     [bx+si],al
F000:7303  [+0x0F303]  00 00                    add     [bx+si],al
F000:7305  [+0x0F305]  00 00                    add     [bx+si],al
F000:7307  [+0x0F307]  00 00                    add     [bx+si],al
F000:7309  [+0x0F309]  00 00                    add     [bx+si],al
F000:730B  [+0x0F30B]  00 00                    add     [bx+si],al
F000:730D  [+0x0F30D]  00 00                    add     [bx+si],al
F000:730F  [+0x0F30F]  00 00                    add     [bx+si],al
F000:7311  [+0x0F311]  00 00                    add     [bx+si],al
F000:7313  [+0x0F313]  00 00                    add     [bx+si],al
F000:7315  [+0x0F315]  00 00                    add     [bx+si],al
F000:7317  [+0x0F317]  00 00                    add     [bx+si],al
F000:7319  [+0x0F319]  00 00                    add     [bx+si],al
F000:731B  [+0x0F31B]  00 00                    add     [bx+si],al
F000:731D  [+0x0F31D]  00 00                    add     [bx+si],al
F000:731F  [+0x0F31F]  00 00                    add     [bx+si],al
F000:7321  [+0x0F321]  00 00                    add     [bx+si],al
F000:7323  [+0x0F323]  00 00                    add     [bx+si],al
F000:7325  [+0x0F325]  00 00                    add     [bx+si],al
F000:7327  [+0x0F327]  00 00                    add     [bx+si],al
F000:7329  [+0x0F329]  00 00                    add     [bx+si],al
F000:732B  [+0x0F32B]  00 00                    add     [bx+si],al
F000:732D  [+0x0F32D]  00 00                    add     [bx+si],al
F000:732F  [+0x0F32F]  00 00                    add     [bx+si],al
F000:7331  [+0x0F331]  00 00                    add     [bx+si],al
F000:7333  [+0x0F333]  00 00                    add     [bx+si],al
F000:7335  [+0x0F335]  00 00                    add     [bx+si],al
F000:7337  [+0x0F337]  00 00                    add     [bx+si],al
F000:7339  [+0x0F339]  00 00                    add     [bx+si],al
F000:733B  [+0x0F33B]  00 00                    add     [bx+si],al
F000:733D  [+0x0F33D]  00 00                    add     [bx+si],al
F000:733F  [+0x0F33F]  00 00                    add     [bx+si],al
F000:7341  [+0x0F341]  00 00                    add     [bx+si],al
F000:7343  [+0x0F343]  00 00                    add     [bx+si],al
F000:7345  [+0x0F345]  00 00                    add     [bx+si],al
F000:7347  [+0x0F347]  00 00                    add     [bx+si],al
F000:7349  [+0x0F349]  00 00                    add     [bx+si],al
F000:734B  [+0x0F34B]  00 00                    add     [bx+si],al
F000:734D  [+0x0F34D]  00 00                    add     [bx+si],al
F000:734F  [+0x0F34F]  00 00                    add     [bx+si],al
F000:7351  [+0x0F351]  00 00                    add     [bx+si],al
F000:7353  [+0x0F353]  00 00                    add     [bx+si],al
F000:7355  [+0x0F355]  00 00                    add     [bx+si],al
F000:7357  [+0x0F357]  00 00                    add     [bx+si],al
F000:7359  [+0x0F359]  00 00                    add     [bx+si],al
F000:735B  [+0x0F35B]  00 00                    add     [bx+si],al
F000:735D  [+0x0F35D]  00 00                    add     [bx+si],al
F000:735F  [+0x0F35F]  00 00                    add     [bx+si],al
F000:7361  [+0x0F361]  00 00                    add     [bx+si],al
F000:7363  [+0x0F363]  00 00                    add     [bx+si],al
F000:7365  [+0x0F365]  00 00                    add     [bx+si],al
F000:7367  [+0x0F367]  00 00                    add     [bx+si],al
F000:7369  [+0x0F369]  00 00                    add     [bx+si],al
F000:736B  [+0x0F36B]  00 00                    add     [bx+si],al
F000:736D  [+0x0F36D]  00 00                    add     [bx+si],al
F000:736F  [+0x0F36F]  00 00                    add     [bx+si],al
F000:7371  [+0x0F371]  00 00                    add     [bx+si],al
F000:7373  [+0x0F373]  00 00                    add     [bx+si],al
F000:7375  [+0x0F375]  00 00                    add     [bx+si],al
F000:7377  [+0x0F377]  00 00                    add     [bx+si],al
F000:7379  [+0x0F379]  00 00                    add     [bx+si],al
F000:737B  [+0x0F37B]  00 00                    add     [bx+si],al
F000:737D  [+0x0F37D]  00 00                    add     [bx+si],al
F000:737F  [+0x0F37F]  00 00                    add     [bx+si],al
F000:7381  [+0x0F381]  00 00                    add     [bx+si],al
F000:7383  [+0x0F383]  00 00                    add     [bx+si],al
F000:7385  [+0x0F385]  00 00                    add     [bx+si],al
F000:7387  [+0x0F387]  00 00                    add     [bx+si],al
F000:7389  [+0x0F389]  00 00                    add     [bx+si],al
F000:738B  [+0x0F38B]  00 00                    add     [bx+si],al
F000:738D  [+0x0F38D]  00 00                    add     [bx+si],al
F000:738F  [+0x0F38F]  00 00                    add     [bx+si],al
F000:7391  [+0x0F391]  00 00                    add     [bx+si],al
F000:7393  [+0x0F393]  00 00                    add     [bx+si],al
F000:7395  [+0x0F395]  00 00                    add     [bx+si],al
F000:7397  [+0x0F397]  00 00                    add     [bx+si],al
F000:7399  [+0x0F399]  00 00                    add     [bx+si],al
F000:739B  [+0x0F39B]  00 00                    add     [bx+si],al
F000:739D  [+0x0F39D]  00 00                    add     [bx+si],al
F000:739F  [+0x0F39F]  00 00                    add     [bx+si],al
F000:73A1  [+0x0F3A1]  00 00                    add     [bx+si],al
F000:73A3  [+0x0F3A3]  00 00                    add     [bx+si],al
F000:73A5  [+0x0F3A5]  00 00                    add     [bx+si],al
F000:73A7  [+0x0F3A7]  00 00                    add     [bx+si],al
F000:73A9  [+0x0F3A9]  00 00                    add     [bx+si],al
F000:73AB  [+0x0F3AB]  00 00                    add     [bx+si],al
F000:73AD  [+0x0F3AD]  00 00                    add     [bx+si],al
F000:73AF  [+0x0F3AF]  00 00                    add     [bx+si],al
F000:73B1  [+0x0F3B1]  00 00                    add     [bx+si],al
F000:73B3  [+0x0F3B3]  00 00                    add     [bx+si],al
F000:73B5  [+0x0F3B5]  00 00                    add     [bx+si],al
F000:73B7  [+0x0F3B7]  00 00                    add     [bx+si],al
F000:73B9  [+0x0F3B9]  00 00                    add     [bx+si],al
F000:73BB  [+0x0F3BB]  00 00                    add     [bx+si],al
F000:73BD  [+0x0F3BD]  00 00                    add     [bx+si],al
F000:73BF  [+0x0F3BF]  00 00                    add     [bx+si],al
F000:73C1  [+0x0F3C1]  00 00                    add     [bx+si],al
F000:73C3  [+0x0F3C3]  00 00                    add     [bx+si],al
F000:73C5  [+0x0F3C5]  00 00                    add     [bx+si],al
F000:73C7  [+0x0F3C7]  00 00                    add     [bx+si],al
F000:73C9  [+0x0F3C9]  00 00                    add     [bx+si],al
F000:73CB  [+0x0F3CB]  00 00                    add     [bx+si],al
F000:73CD  [+0x0F3CD]  00 00                    add     [bx+si],al
F000:73CF  [+0x0F3CF]  00 00                    add     [bx+si],al
F000:73D1  [+0x0F3D1]  00 00                    add     [bx+si],al
F000:73D3  [+0x0F3D3]  00 00                    add     [bx+si],al
F000:73D5  [+0x0F3D5]  00 00                    add     [bx+si],al
F000:73D7  [+0x0F3D7]  00 00                    add     [bx+si],al
F000:73D9  [+0x0F3D9]  00 00                    add     [bx+si],al
F000:73DB  [+0x0F3DB]  00 00                    add     [bx+si],al
F000:73DD  [+0x0F3DD]  00 00                    add     [bx+si],al
F000:73DF  [+0x0F3DF]  00 00                    add     [bx+si],al
F000:73E1  [+0x0F3E1]  00 00                    add     [bx+si],al
F000:73E3  [+0x0F3E3]  00 00                    add     [bx+si],al
F000:73E5  [+0x0F3E5]  00 00                    add     [bx+si],al
F000:73E7  [+0x0F3E7]  00 00                    add     [bx+si],al
F000:73E9  [+0x0F3E9]  00 00                    add     [bx+si],al
F000:73EB  [+0x0F3EB]  00 00                    add     [bx+si],al
F000:73ED  [+0x0F3ED]  00 00                    add     [bx+si],al
F000:73EF  [+0x0F3EF]  00 00                    add     [bx+si],al
F000:73F1  [+0x0F3F1]  00 00                    add     [bx+si],al
F000:73F3  [+0x0F3F3]  00 00                    add     [bx+si],al
F000:73F5  [+0x0F3F5]  00 00                    add     [bx+si],al
F000:73F7  [+0x0F3F7]  00 00                    add     [bx+si],al
F000:73F9  [+0x0F3F9]  00 00                    add     [bx+si],al
F000:73FB  [+0x0F3FB]  00 00                    add     [bx+si],al
F000:73FD  [+0x0F3FD]  00 00                    add     [bx+si],al
F000:73FF  [+0x0F3FF]  00 00                    add     [bx+si],al
F000:7401  [+0x0F401]  00 00                    add     [bx+si],al
F000:7403  [+0x0F403]  00 00                    add     [bx+si],al
F000:7405  [+0x0F405]  00 00                    add     [bx+si],al
F000:7407  [+0x0F407]  00 00                    add     [bx+si],al
F000:7409  [+0x0F409]  00 00                    add     [bx+si],al
F000:740B  [+0x0F40B]  00 00                    add     [bx+si],al
F000:740D  [+0x0F40D]  00 00                    add     [bx+si],al
F000:740F  [+0x0F40F]  00 00                    add     [bx+si],al
F000:7411  [+0x0F411]  00 00                    add     [bx+si],al
F000:7413  [+0x0F413]  00 00                    add     [bx+si],al
F000:7415  [+0x0F415]  00 00                    add     [bx+si],al
F000:7417  [+0x0F417]  00 00                    add     [bx+si],al
F000:7419  [+0x0F419]  00 00                    add     [bx+si],al
F000:741B  [+0x0F41B]  00 00                    add     [bx+si],al
F000:741D  [+0x0F41D]  00 00                    add     [bx+si],al
F000:741F  [+0x0F41F]  00 00                    add     [bx+si],al
F000:7421  [+0x0F421]  00 00                    add     [bx+si],al
F000:7423  [+0x0F423]  00 00                    add     [bx+si],al
F000:7425  [+0x0F425]  00 00                    add     [bx+si],al
F000:7427  [+0x0F427]  00 00                    add     [bx+si],al
F000:7429  [+0x0F429]  00 00                    add     [bx+si],al
F000:742B  [+0x0F42B]  00 00                    add     [bx+si],al
F000:742D  [+0x0F42D]  00 00                    add     [bx+si],al
F000:742F  [+0x0F42F]  00 00                    add     [bx+si],al
F000:7431  [+0x0F431]  00 00                    add     [bx+si],al
F000:7433  [+0x0F433]  00 00                    add     [bx+si],al
F000:7435  [+0x0F435]  00 00                    add     [bx+si],al
F000:7437  [+0x0F437]  00 00                    add     [bx+si],al
F000:7439  [+0x0F439]  00 00                    add     [bx+si],al
F000:743B  [+0x0F43B]  00 00                    add     [bx+si],al
F000:743D  [+0x0F43D]  00 00                    add     [bx+si],al
F000:743F  [+0x0F43F]  00 00                    add     [bx+si],al
F000:7441  [+0x0F441]  00 00                    add     [bx+si],al
F000:7443  [+0x0F443]  00 00                    add     [bx+si],al
F000:7445  [+0x0F445]  00 00                    add     [bx+si],al
F000:7447  [+0x0F447]  00 00                    add     [bx+si],al
F000:7449  [+0x0F449]  00 00                    add     [bx+si],al
F000:744B  [+0x0F44B]  00 00                    add     [bx+si],al
F000:744D  [+0x0F44D]  00 00                    add     [bx+si],al
F000:744F  [+0x0F44F]  00 00                    add     [bx+si],al
F000:7451  [+0x0F451]  00 00                    add     [bx+si],al
F000:7453  [+0x0F453]  00 00                    add     [bx+si],al
F000:7455  [+0x0F455]  00 00                    add     [bx+si],al
F000:7457  [+0x0F457]  00 00                    add     [bx+si],al
F000:7459  [+0x0F459]  00 00                    add     [bx+si],al
F000:745B  [+0x0F45B]  00 00                    add     [bx+si],al
F000:745D  [+0x0F45D]  00 00                    add     [bx+si],al
F000:745F  [+0x0F45F]  00 00                    add     [bx+si],al
F000:7461  [+0x0F461]  00 00                    add     [bx+si],al
F000:7463  [+0x0F463]  00 00                    add     [bx+si],al
F000:7465  [+0x0F465]  00 00                    add     [bx+si],al
F000:7467  [+0x0F467]  00 00                    add     [bx+si],al
F000:7469  [+0x0F469]  00 00                    add     [bx+si],al
F000:746B  [+0x0F46B]  00 00                    add     [bx+si],al
F000:746D  [+0x0F46D]  00 00                    add     [bx+si],al
F000:746F  [+0x0F46F]  00 00                    add     [bx+si],al
F000:7471  [+0x0F471]  00 00                    add     [bx+si],al
F000:7473  [+0x0F473]  00 00                    add     [bx+si],al
F000:7475  [+0x0F475]  00 00                    add     [bx+si],al
F000:7477  [+0x0F477]  00 00                    add     [bx+si],al
F000:7479  [+0x0F479]  00 00                    add     [bx+si],al
F000:747B  [+0x0F47B]  00 00                    add     [bx+si],al
F000:747D  [+0x0F47D]  00 00                    add     [bx+si],al
F000:747F  [+0x0F47F]  00 00                    add     [bx+si],al
F000:7481  [+0x0F481]  00 00                    add     [bx+si],al
F000:7483  [+0x0F483]  00 00                    add     [bx+si],al
F000:7485  [+0x0F485]  00 00                    add     [bx+si],al
F000:7487  [+0x0F487]  00 00                    add     [bx+si],al
F000:7489  [+0x0F489]  00 00                    add     [bx+si],al
F000:748B  [+0x0F48B]  00 00                    add     [bx+si],al
F000:748D  [+0x0F48D]  00 00                    add     [bx+si],al
F000:748F  [+0x0F48F]  00 00                    add     [bx+si],al
F000:7491  [+0x0F491]  00 00                    add     [bx+si],al
F000:7493  [+0x0F493]  00 00                    add     [bx+si],al
F000:7495  [+0x0F495]  00 00                    add     [bx+si],al
F000:7497  [+0x0F497]  00 00                    add     [bx+si],al
F000:7499  [+0x0F499]  00 00                    add     [bx+si],al
F000:749B  [+0x0F49B]  00 00                    add     [bx+si],al
F000:749D  [+0x0F49D]  00 00                    add     [bx+si],al
F000:749F  [+0x0F49F]  00 00                    add     [bx+si],al
F000:74A1  [+0x0F4A1]  00 00                    add     [bx+si],al
F000:74A3  [+0x0F4A3]  00 00                    add     [bx+si],al
F000:74A5  [+0x0F4A5]  00 00                    add     [bx+si],al
F000:74A7  [+0x0F4A7]  00 00                    add     [bx+si],al
F000:74A9  [+0x0F4A9]  00 00                    add     [bx+si],al
F000:74AB  [+0x0F4AB]  00 00                    add     [bx+si],al
F000:74AD  [+0x0F4AD]  00 00                    add     [bx+si],al
F000:74AF  [+0x0F4AF]  00 00                    add     [bx+si],al
F000:74B1  [+0x0F4B1]  00 00                    add     [bx+si],al
F000:74B3  [+0x0F4B3]  00 00                    add     [bx+si],al
F000:74B5  [+0x0F4B5]  00 00                    add     [bx+si],al
F000:74B7  [+0x0F4B7]  00 00                    add     [bx+si],al
F000:74B9  [+0x0F4B9]  00 00                    add     [bx+si],al
F000:74BB  [+0x0F4BB]  00 00                    add     [bx+si],al
F000:74BD  [+0x0F4BD]  00 00                    add     [bx+si],al
F000:74BF  [+0x0F4BF]  00 00                    add     [bx+si],al
F000:74C1  [+0x0F4C1]  00 00                    add     [bx+si],al
F000:74C3  [+0x0F4C3]  00 00                    add     [bx+si],al
F000:74C5  [+0x0F4C5]  00 00                    add     [bx+si],al
F000:74C7  [+0x0F4C7]  00 00                    add     [bx+si],al
F000:74C9  [+0x0F4C9]  00 00                    add     [bx+si],al
F000:74CB  [+0x0F4CB]  00 00                    add     [bx+si],al
F000:74CD  [+0x0F4CD]  00 00                    add     [bx+si],al
F000:74CF  [+0x0F4CF]  00 00                    add     [bx+si],al
F000:74D1  [+0x0F4D1]  00 00                    add     [bx+si],al
F000:74D3  [+0x0F4D3]  00 00                    add     [bx+si],al
F000:74D5  [+0x0F4D5]  00 00                    add     [bx+si],al
F000:74D7  [+0x0F4D7]  00 00                    add     [bx+si],al
F000:74D9  [+0x0F4D9]  00 00                    add     [bx+si],al
F000:74DB  [+0x0F4DB]  00 00                    add     [bx+si],al
F000:74DD  [+0x0F4DD]  00 00                    add     [bx+si],al
F000:74DF  [+0x0F4DF]  00 00                    add     [bx+si],al
F000:74E1  [+0x0F4E1]  00 00                    add     [bx+si],al
F000:74E3  [+0x0F4E3]  00 00                    add     [bx+si],al
F000:74E5  [+0x0F4E5]  00 00                    add     [bx+si],al
F000:74E7  [+0x0F4E7]  00 00                    add     [bx+si],al
F000:74E9  [+0x0F4E9]  00 00                    add     [bx+si],al
F000:74EB  [+0x0F4EB]  00 00                    add     [bx+si],al
F000:74ED  [+0x0F4ED]  00 00                    add     [bx+si],al
F000:74EF  [+0x0F4EF]  00 00                    add     [bx+si],al
F000:74F1  [+0x0F4F1]  00 00                    add     [bx+si],al
F000:74F3  [+0x0F4F3]  00 00                    add     [bx+si],al
F000:74F5  [+0x0F4F5]  00 00                    add     [bx+si],al
F000:74F7  [+0x0F4F7]  00 00                    add     [bx+si],al
F000:74F9  [+0x0F4F9]  00 00                    add     [bx+si],al
F000:74FB  [+0x0F4FB]  00 00                    add     [bx+si],al
F000:74FD  [+0x0F4FD]  00 00                    add     [bx+si],al
F000:74FF  [+0x0F4FF]  00 00                    add     [bx+si],al
F000:7501  [+0x0F501]  00 00                    add     [bx+si],al
F000:7503  [+0x0F503]  00 00                    add     [bx+si],al
F000:7505  [+0x0F505]  00 00                    add     [bx+si],al
F000:7507  [+0x0F507]  00 00                    add     [bx+si],al
F000:7509  [+0x0F509]  00 00                    add     [bx+si],al
F000:750B  [+0x0F50B]  00 00                    add     [bx+si],al
F000:750D  [+0x0F50D]  00 00                    add     [bx+si],al
F000:750F  [+0x0F50F]  00 00                    add     [bx+si],al
F000:7511  [+0x0F511]  00 00                    add     [bx+si],al
F000:7513  [+0x0F513]  00 00                    add     [bx+si],al
F000:7515  [+0x0F515]  00 00                    add     [bx+si],al
F000:7517  [+0x0F517]  00 00                    add     [bx+si],al
F000:7519  [+0x0F519]  00 00                    add     [bx+si],al
F000:751B  [+0x0F51B]  00 00                    add     [bx+si],al
F000:751D  [+0x0F51D]  00 00                    add     [bx+si],al
F000:751F  [+0x0F51F]  00 00                    add     [bx+si],al
F000:7521  [+0x0F521]  00 00                    add     [bx+si],al
F000:7523  [+0x0F523]  00 00                    add     [bx+si],al
F000:7525  [+0x0F525]  00 00                    add     [bx+si],al
F000:7527  [+0x0F527]  00 00                    add     [bx+si],al
F000:7529  [+0x0F529]  00 00                    add     [bx+si],al
F000:752B  [+0x0F52B]  00 00                    add     [bx+si],al
F000:752D  [+0x0F52D]  00 00                    add     [bx+si],al
F000:752F  [+0x0F52F]  00 00                    add     [bx+si],al
F000:7531  [+0x0F531]  00 00                    add     [bx+si],al
F000:7533  [+0x0F533]  00 00                    add     [bx+si],al
F000:7535  [+0x0F535]  00 00                    add     [bx+si],al
F000:7537  [+0x0F537]  00 00                    add     [bx+si],al
F000:7539  [+0x0F539]  00 00                    add     [bx+si],al
F000:753B  [+0x0F53B]  00 00                    add     [bx+si],al
F000:753D  [+0x0F53D]  00 00                    add     [bx+si],al
F000:753F  [+0x0F53F]  00 00                    add     [bx+si],al
F000:7541  [+0x0F541]  00 00                    add     [bx+si],al
F000:7543  [+0x0F543]  00 00                    add     [bx+si],al
F000:7545  [+0x0F545]  00 00                    add     [bx+si],al
F000:7547  [+0x0F547]  00 00                    add     [bx+si],al
F000:7549  [+0x0F549]  00 00                    add     [bx+si],al
F000:754B  [+0x0F54B]  00 00                    add     [bx+si],al
F000:754D  [+0x0F54D]  00 00                    add     [bx+si],al
F000:754F  [+0x0F54F]  00 00                    add     [bx+si],al
F000:7551  [+0x0F551]  00 00                    add     [bx+si],al
F000:7553  [+0x0F553]  00 00                    add     [bx+si],al
F000:7555  [+0x0F555]  00 00                    add     [bx+si],al
F000:7557  [+0x0F557]  00 00                    add     [bx+si],al
F000:7559  [+0x0F559]  00 00                    add     [bx+si],al
F000:755B  [+0x0F55B]  00 00                    add     [bx+si],al
F000:755D  [+0x0F55D]  00 00                    add     [bx+si],al
F000:755F  [+0x0F55F]  00 00                    add     [bx+si],al
F000:7561  [+0x0F561]  00 00                    add     [bx+si],al
F000:7563  [+0x0F563]  00 00                    add     [bx+si],al
F000:7565  [+0x0F565]  00 00                    add     [bx+si],al
F000:7567  [+0x0F567]  00 00                    add     [bx+si],al
F000:7569  [+0x0F569]  00 00                    add     [bx+si],al
F000:756B  [+0x0F56B]  00 00                    add     [bx+si],al
F000:756D  [+0x0F56D]  00 00                    add     [bx+si],al
F000:756F  [+0x0F56F]  00 00                    add     [bx+si],al
F000:7571  [+0x0F571]  00 00                    add     [bx+si],al
F000:7573  [+0x0F573]  00 00                    add     [bx+si],al
F000:7575  [+0x0F575]  00 00                    add     [bx+si],al
F000:7577  [+0x0F577]  00 00                    add     [bx+si],al
F000:7579  [+0x0F579]  00 00                    add     [bx+si],al
F000:757B  [+0x0F57B]  00 00                    add     [bx+si],al
F000:757D  [+0x0F57D]  00 00                    add     [bx+si],al
F000:757F  [+0x0F57F]  00 00                    add     [bx+si],al
F000:7581  [+0x0F581]  00 00                    add     [bx+si],al
F000:7583  [+0x0F583]  00 00                    add     [bx+si],al
F000:7585  [+0x0F585]  00 00                    add     [bx+si],al
F000:7587  [+0x0F587]  00 00                    add     [bx+si],al
F000:7589  [+0x0F589]  00 00                    add     [bx+si],al
F000:758B  [+0x0F58B]  00 00                    add     [bx+si],al
F000:758D  [+0x0F58D]  00 00                    add     [bx+si],al
F000:758F  [+0x0F58F]  00 00                    add     [bx+si],al
F000:7591  [+0x0F591]  00 00                    add     [bx+si],al
F000:7593  [+0x0F593]  00 00                    add     [bx+si],al
F000:7595  [+0x0F595]  00 00                    add     [bx+si],al
F000:7597  [+0x0F597]  00 00                    add     [bx+si],al
F000:7599  [+0x0F599]  00 00                    add     [bx+si],al
F000:759B  [+0x0F59B]  00 00                    add     [bx+si],al
F000:759D  [+0x0F59D]  00 00                    add     [bx+si],al
F000:759F  [+0x0F59F]  00 00                    add     [bx+si],al
F000:75A1  [+0x0F5A1]  00 00                    add     [bx+si],al
F000:75A3  [+0x0F5A3]  00 00                    add     [bx+si],al
F000:75A5  [+0x0F5A5]  00 00                    add     [bx+si],al
F000:75A7  [+0x0F5A7]  00 00                    add     [bx+si],al
F000:75A9  [+0x0F5A9]  00 00                    add     [bx+si],al
F000:75AB  [+0x0F5AB]  00 00                    add     [bx+si],al
F000:75AD  [+0x0F5AD]  00 00                    add     [bx+si],al
F000:75AF  [+0x0F5AF]  00 00                    add     [bx+si],al
F000:75B1  [+0x0F5B1]  00 00                    add     [bx+si],al
F000:75B3  [+0x0F5B3]  00 00                    add     [bx+si],al
F000:75B5  [+0x0F5B5]  00 00                    add     [bx+si],al
F000:75B7  [+0x0F5B7]  00 00                    add     [bx+si],al
F000:75B9  [+0x0F5B9]  00 00                    add     [bx+si],al
F000:75BB  [+0x0F5BB]  00 00                    add     [bx+si],al
F000:75BD  [+0x0F5BD]  00 00                    add     [bx+si],al
F000:75BF  [+0x0F5BF]  00 00                    add     [bx+si],al
F000:75C1  [+0x0F5C1]  00 00                    add     [bx+si],al
F000:75C3  [+0x0F5C3]  00 00                    add     [bx+si],al
F000:75C5  [+0x0F5C5]  00 00                    add     [bx+si],al
F000:75C7  [+0x0F5C7]  00 00                    add     [bx+si],al
F000:75C9  [+0x0F5C9]  00 00                    add     [bx+si],al
F000:75CB  [+0x0F5CB]  00 00                    add     [bx+si],al
F000:75CD  [+0x0F5CD]  00 00                    add     [bx+si],al
F000:75CF  [+0x0F5CF]  00 00                    add     [bx+si],al
F000:75D1  [+0x0F5D1]  00 00                    add     [bx+si],al
F000:75D3  [+0x0F5D3]  00 00                    add     [bx+si],al
F000:75D5  [+0x0F5D5]  00 00                    add     [bx+si],al
F000:75D7  [+0x0F5D7]  00 00                    add     [bx+si],al
F000:75D9  [+0x0F5D9]  00 00                    add     [bx+si],al
F000:75DB  [+0x0F5DB]  00 00                    add     [bx+si],al
F000:75DD  [+0x0F5DD]  00 00                    add     [bx+si],al
F000:75DF  [+0x0F5DF]  00 00                    add     [bx+si],al
F000:75E1  [+0x0F5E1]  00 00                    add     [bx+si],al
F000:75E3  [+0x0F5E3]  00 00                    add     [bx+si],al
F000:75E5  [+0x0F5E5]  00 00                    add     [bx+si],al
F000:75E7  [+0x0F5E7]  00 00                    add     [bx+si],al
F000:75E9  [+0x0F5E9]  00 00                    add     [bx+si],al
F000:75EB  [+0x0F5EB]  00 00                    add     [bx+si],al
F000:75ED  [+0x0F5ED]  00 00                    add     [bx+si],al
F000:75EF  [+0x0F5EF]  00 00                    add     [bx+si],al
F000:75F1  [+0x0F5F1]  00 00                    add     [bx+si],al
F000:75F3  [+0x0F5F3]  00 00                    add     [bx+si],al
F000:75F5  [+0x0F5F5]  00 00                    add     [bx+si],al
F000:75F7  [+0x0F5F7]  00 00                    add     [bx+si],al
F000:75F9  [+0x0F5F9]  00 00                    add     [bx+si],al
F000:75FB  [+0x0F5FB]  00 00                    add     [bx+si],al
F000:75FD  [+0x0F5FD]  00 00                    add     [bx+si],al
F000:75FF  [+0x0F5FF]  00 00                    add     [bx+si],al
F000:7601  [+0x0F601]  00 00                    add     [bx+si],al
F000:7603  [+0x0F603]  00 00                    add     [bx+si],al
F000:7605  [+0x0F605]  00 00                    add     [bx+si],al
F000:7607  [+0x0F607]  00 00                    add     [bx+si],al
F000:7609  [+0x0F609]  00 00                    add     [bx+si],al
F000:760B  [+0x0F60B]  00 00                    add     [bx+si],al
F000:760D  [+0x0F60D]  00 00                    add     [bx+si],al
F000:760F  [+0x0F60F]  00 00                    add     [bx+si],al
F000:7611  [+0x0F611]  00 00                    add     [bx+si],al
F000:7613  [+0x0F613]  00 00                    add     [bx+si],al
F000:7615  [+0x0F615]  00 00                    add     [bx+si],al
F000:7617  [+0x0F617]  00 00                    add     [bx+si],al
F000:7619  [+0x0F619]  00 00                    add     [bx+si],al
F000:761B  [+0x0F61B]  00 00                    add     [bx+si],al
F000:761D  [+0x0F61D]  00 00                    add     [bx+si],al
F000:761F  [+0x0F61F]  00 00                    add     [bx+si],al
F000:7621  [+0x0F621]  00 00                    add     [bx+si],al
F000:7623  [+0x0F623]  00 00                    add     [bx+si],al
F000:7625  [+0x0F625]  00 00                    add     [bx+si],al
F000:7627  [+0x0F627]  00 00                    add     [bx+si],al
F000:7629  [+0x0F629]  00 00                    add     [bx+si],al
F000:762B  [+0x0F62B]  00 00                    add     [bx+si],al
F000:762D  [+0x0F62D]  00 00                    add     [bx+si],al
F000:762F  [+0x0F62F]  00 00                    add     [bx+si],al
F000:7631  [+0x0F631]  00 00                    add     [bx+si],al
F000:7633  [+0x0F633]  00 00                    add     [bx+si],al
F000:7635  [+0x0F635]  00 00                    add     [bx+si],al
F000:7637  [+0x0F637]  00 00                    add     [bx+si],al
F000:7639  [+0x0F639]  00 00                    add     [bx+si],al
F000:763B  [+0x0F63B]  00 00                    add     [bx+si],al
F000:763D  [+0x0F63D]  00 00                    add     [bx+si],al
F000:763F  [+0x0F63F]  00 00                    add     [bx+si],al
F000:7641  [+0x0F641]  00 00                    add     [bx+si],al
F000:7643  [+0x0F643]  00 00                    add     [bx+si],al
F000:7645  [+0x0F645]  00 00                    add     [bx+si],al
F000:7647  [+0x0F647]  00 00                    add     [bx+si],al
F000:7649  [+0x0F649]  00 00                    add     [bx+si],al
F000:764B  [+0x0F64B]  00 00                    add     [bx+si],al
F000:764D  [+0x0F64D]  00 00                    add     [bx+si],al
F000:764F  [+0x0F64F]  00 00                    add     [bx+si],al
F000:7651  [+0x0F651]  00 00                    add     [bx+si],al
F000:7653  [+0x0F653]  00 00                    add     [bx+si],al
F000:7655  [+0x0F655]  00 00                    add     [bx+si],al
F000:7657  [+0x0F657]  00 00                    add     [bx+si],al
F000:7659  [+0x0F659]  00 00                    add     [bx+si],al
F000:765B  [+0x0F65B]  00 00                    add     [bx+si],al
F000:765D  [+0x0F65D]  00 00                    add     [bx+si],al
F000:765F  [+0x0F65F]  00 00                    add     [bx+si],al
F000:7661  [+0x0F661]  00 00                    add     [bx+si],al
F000:7663  [+0x0F663]  00 00                    add     [bx+si],al
F000:7665  [+0x0F665]  00 00                    add     [bx+si],al
F000:7667  [+0x0F667]  00 00                    add     [bx+si],al
F000:7669  [+0x0F669]  00 00                    add     [bx+si],al
F000:766B  [+0x0F66B]  00 00                    add     [bx+si],al
F000:766D  [+0x0F66D]  00 00                    add     [bx+si],al
F000:766F  [+0x0F66F]  00 00                    add     [bx+si],al
F000:7671  [+0x0F671]  00 00                    add     [bx+si],al
F000:7673  [+0x0F673]  00 00                    add     [bx+si],al
F000:7675  [+0x0F675]  00 00                    add     [bx+si],al
F000:7677  [+0x0F677]  00 00                    add     [bx+si],al
F000:7679  [+0x0F679]  00 00                    add     [bx+si],al
F000:767B  [+0x0F67B]  00 00                    add     [bx+si],al
F000:767D  [+0x0F67D]  00 00                    add     [bx+si],al
F000:767F  [+0x0F67F]  00 00                    add     [bx+si],al
F000:7681  [+0x0F681]  00 00                    add     [bx+si],al
F000:7683  [+0x0F683]  00 00                    add     [bx+si],al
F000:7685  [+0x0F685]  00 00                    add     [bx+si],al
F000:7687  [+0x0F687]  00 00                    add     [bx+si],al
F000:7689  [+0x0F689]  00 00                    add     [bx+si],al
F000:768B  [+0x0F68B]  00 00                    add     [bx+si],al
F000:768D  [+0x0F68D]  00 00                    add     [bx+si],al
F000:768F  [+0x0F68F]  00 00                    add     [bx+si],al
F000:7691  [+0x0F691]  00 00                    add     [bx+si],al
F000:7693  [+0x0F693]  00 00                    add     [bx+si],al
F000:7695  [+0x0F695]  00 00                    add     [bx+si],al
F000:7697  [+0x0F697]  00 00                    add     [bx+si],al
F000:7699  [+0x0F699]  00 00                    add     [bx+si],al
F000:769B  [+0x0F69B]  00 00                    add     [bx+si],al
F000:769D  [+0x0F69D]  00 00                    add     [bx+si],al
F000:769F  [+0x0F69F]  00 00                    add     [bx+si],al
F000:76A1  [+0x0F6A1]  00 00                    add     [bx+si],al
F000:76A3  [+0x0F6A3]  00 00                    add     [bx+si],al
F000:76A5  [+0x0F6A5]  00 00                    add     [bx+si],al
F000:76A7  [+0x0F6A7]  00 00                    add     [bx+si],al
F000:76A9  [+0x0F6A9]  00 00                    add     [bx+si],al
F000:76AB  [+0x0F6AB]  00 00                    add     [bx+si],al
F000:76AD  [+0x0F6AD]  00 00                    add     [bx+si],al
F000:76AF  [+0x0F6AF]  00 00                    add     [bx+si],al
F000:76B1  [+0x0F6B1]  00 00                    add     [bx+si],al
F000:76B3  [+0x0F6B3]  00 00                    add     [bx+si],al
F000:76B5  [+0x0F6B5]  00 00                    add     [bx+si],al
F000:76B7  [+0x0F6B7]  00 00                    add     [bx+si],al
F000:76B9  [+0x0F6B9]  00 00                    add     [bx+si],al
F000:76BB  [+0x0F6BB]  00 00                    add     [bx+si],al
F000:76BD  [+0x0F6BD]  00 00                    add     [bx+si],al
F000:76BF  [+0x0F6BF]  00 00                    add     [bx+si],al
F000:76C1  [+0x0F6C1]  00 00                    add     [bx+si],al
F000:76C3  [+0x0F6C3]  00 00                    add     [bx+si],al
F000:76C5  [+0x0F6C5]  00 00                    add     [bx+si],al
F000:76C7  [+0x0F6C7]  00 00                    add     [bx+si],al
F000:76C9  [+0x0F6C9]  00 00                    add     [bx+si],al
F000:76CB  [+0x0F6CB]  00 00                    add     [bx+si],al
F000:76CD  [+0x0F6CD]  00 00                    add     [bx+si],al
F000:76CF  [+0x0F6CF]  00 00                    add     [bx+si],al
F000:76D1  [+0x0F6D1]  00 00                    add     [bx+si],al
F000:76D3  [+0x0F6D3]  00 00                    add     [bx+si],al
F000:76D5  [+0x0F6D5]  00 00                    add     [bx+si],al
F000:76D7  [+0x0F6D7]  00 00                    add     [bx+si],al
F000:76D9  [+0x0F6D9]  00 00                    add     [bx+si],al
F000:76DB  [+0x0F6DB]  00 00                    add     [bx+si],al
F000:76DD  [+0x0F6DD]  00 00                    add     [bx+si],al
F000:76DF  [+0x0F6DF]  00 00                    add     [bx+si],al
F000:76E1  [+0x0F6E1]  00 00                    add     [bx+si],al
F000:76E3  [+0x0F6E3]  00 00                    add     [bx+si],al
F000:76E5  [+0x0F6E5]  00 00                    add     [bx+si],al
F000:76E7  [+0x0F6E7]  00 00                    add     [bx+si],al
F000:76E9  [+0x0F6E9]  00 00                    add     [bx+si],al
F000:76EB  [+0x0F6EB]  00 00                    add     [bx+si],al
F000:76ED  [+0x0F6ED]  00 00                    add     [bx+si],al
F000:76EF  [+0x0F6EF]  00 00                    add     [bx+si],al
F000:76F1  [+0x0F6F1]  00 00                    add     [bx+si],al
F000:76F3  [+0x0F6F3]  00 00                    add     [bx+si],al
F000:76F5  [+0x0F6F5]  00 00                    add     [bx+si],al
F000:76F7  [+0x0F6F7]  00 00                    add     [bx+si],al
F000:76F9  [+0x0F6F9]  00 00                    add     [bx+si],al
F000:76FB  [+0x0F6FB]  00 00                    add     [bx+si],al
F000:76FD  [+0x0F6FD]  00 00                    add     [bx+si],al
F000:76FF  [+0x0F6FF]  00 00                    add     [bx+si],al
F000:7701  [+0x0F701]  00 00                    add     [bx+si],al
F000:7703  [+0x0F703]  00 00                    add     [bx+si],al
F000:7705  [+0x0F705]  00 00                    add     [bx+si],al
F000:7707  [+0x0F707]  00 00                    add     [bx+si],al
F000:7709  [+0x0F709]  00 00                    add     [bx+si],al
F000:770B  [+0x0F70B]  00 00                    add     [bx+si],al
F000:770D  [+0x0F70D]  00 00                    add     [bx+si],al
F000:770F  [+0x0F70F]  00 00                    add     [bx+si],al
F000:7711  [+0x0F711]  00 00                    add     [bx+si],al
F000:7713  [+0x0F713]  00 00                    add     [bx+si],al
F000:7715  [+0x0F715]  00 00                    add     [bx+si],al
F000:7717  [+0x0F717]  00 00                    add     [bx+si],al
F000:7719  [+0x0F719]  00 00                    add     [bx+si],al
F000:771B  [+0x0F71B]  00 00                    add     [bx+si],al
F000:771D  [+0x0F71D]  00 00                    add     [bx+si],al
F000:771F  [+0x0F71F]  00 00                    add     [bx+si],al
F000:7721  [+0x0F721]  00 00                    add     [bx+si],al
F000:7723  [+0x0F723]  00 00                    add     [bx+si],al
F000:7725  [+0x0F725]  00 00                    add     [bx+si],al
F000:7727  [+0x0F727]  00 00                    add     [bx+si],al
F000:7729  [+0x0F729]  00 00                    add     [bx+si],al
F000:772B  [+0x0F72B]  00 00                    add     [bx+si],al
F000:772D  [+0x0F72D]  00 00                    add     [bx+si],al
F000:772F  [+0x0F72F]  00 00                    add     [bx+si],al
F000:7731  [+0x0F731]  00 00                    add     [bx+si],al
F000:7733  [+0x0F733]  00 00                    add     [bx+si],al
F000:7735  [+0x0F735]  00 00                    add     [bx+si],al
F000:7737  [+0x0F737]  00 00                    add     [bx+si],al
F000:7739  [+0x0F739]  00 00                    add     [bx+si],al
F000:773B  [+0x0F73B]  00 00                    add     [bx+si],al
F000:773D  [+0x0F73D]  00 00                    add     [bx+si],al
F000:773F  [+0x0F73F]  00 00                    add     [bx+si],al
F000:7741  [+0x0F741]  00 00                    add     [bx+si],al
F000:7743  [+0x0F743]  00 00                    add     [bx+si],al
F000:7745  [+0x0F745]  00 00                    add     [bx+si],al
F000:7747  [+0x0F747]  00 00                    add     [bx+si],al
F000:7749  [+0x0F749]  00 00                    add     [bx+si],al
F000:774B  [+0x0F74B]  00 00                    add     [bx+si],al
F000:774D  [+0x0F74D]  00 00                    add     [bx+si],al
F000:774F  [+0x0F74F]  00 00                    add     [bx+si],al
F000:7751  [+0x0F751]  00 00                    add     [bx+si],al
F000:7753  [+0x0F753]  00 00                    add     [bx+si],al
F000:7755  [+0x0F755]  00 00                    add     [bx+si],al
F000:7757  [+0x0F757]  00 00                    add     [bx+si],al
F000:7759  [+0x0F759]  00 00                    add     [bx+si],al
F000:775B  [+0x0F75B]  00 00                    add     [bx+si],al
F000:775D  [+0x0F75D]  00 00                    add     [bx+si],al
F000:775F  [+0x0F75F]  00 00                    add     [bx+si],al
F000:7761  [+0x0F761]  00 00                    add     [bx+si],al
F000:7763  [+0x0F763]  00 00                    add     [bx+si],al
F000:7765  [+0x0F765]  00 00                    add     [bx+si],al
F000:7767  [+0x0F767]  00 00                    add     [bx+si],al
F000:7769  [+0x0F769]  00 00                    add     [bx+si],al
F000:776B  [+0x0F76B]  00 00                    add     [bx+si],al
F000:776D  [+0x0F76D]  00 00                    add     [bx+si],al
F000:776F  [+0x0F76F]  00 00                    add     [bx+si],al
F000:7771  [+0x0F771]  00 00                    add     [bx+si],al
F000:7773  [+0x0F773]  00 00                    add     [bx+si],al
F000:7775  [+0x0F775]  00 00                    add     [bx+si],al
F000:7777  [+0x0F777]  00 00                    add     [bx+si],al
F000:7779  [+0x0F779]  00 00                    add     [bx+si],al
F000:777B  [+0x0F77B]  00 00                    add     [bx+si],al
F000:777D  [+0x0F77D]  00 00                    add     [bx+si],al
F000:777F  [+0x0F77F]  00 00                    add     [bx+si],al
F000:7781  [+0x0F781]  00 00                    add     [bx+si],al
F000:7783  [+0x0F783]  00 00                    add     [bx+si],al
F000:7785  [+0x0F785]  00 00                    add     [bx+si],al
F000:7787  [+0x0F787]  00 00                    add     [bx+si],al
F000:7789  [+0x0F789]  00 00                    add     [bx+si],al
F000:778B  [+0x0F78B]  00 00                    add     [bx+si],al
F000:778D  [+0x0F78D]  00 00                    add     [bx+si],al
F000:778F  [+0x0F78F]  00 00                    add     [bx+si],al
F000:7791  [+0x0F791]  00 00                    add     [bx+si],al
F000:7793  [+0x0F793]  00 00                    add     [bx+si],al
F000:7795  [+0x0F795]  00 00                    add     [bx+si],al
F000:7797  [+0x0F797]  00 00                    add     [bx+si],al
F000:7799  [+0x0F799]  00 00                    add     [bx+si],al
F000:779B  [+0x0F79B]  00 00                    add     [bx+si],al
F000:779D  [+0x0F79D]  00 00                    add     [bx+si],al
F000:779F  [+0x0F79F]  00 00                    add     [bx+si],al
F000:77A1  [+0x0F7A1]  00 00                    add     [bx+si],al
F000:77A3  [+0x0F7A3]  00 00                    add     [bx+si],al
F000:77A5  [+0x0F7A5]  00 00                    add     [bx+si],al
F000:77A7  [+0x0F7A7]  00 00                    add     [bx+si],al
F000:77A9  [+0x0F7A9]  00 00                    add     [bx+si],al
F000:77AB  [+0x0F7AB]  00 00                    add     [bx+si],al
F000:77AD  [+0x0F7AD]  00 00                    add     [bx+si],al
F000:77AF  [+0x0F7AF]  00 00                    add     [bx+si],al
F000:77B1  [+0x0F7B1]  00 00                    add     [bx+si],al
F000:77B3  [+0x0F7B3]  00 00                    add     [bx+si],al
F000:77B5  [+0x0F7B5]  00 00                    add     [bx+si],al
F000:77B7  [+0x0F7B7]  00 00                    add     [bx+si],al
F000:77B9  [+0x0F7B9]  00 00                    add     [bx+si],al
F000:77BB  [+0x0F7BB]  00 00                    add     [bx+si],al
F000:77BD  [+0x0F7BD]  00 00                    add     [bx+si],al
F000:77BF  [+0x0F7BF]  00 00                    add     [bx+si],al
F000:77C1  [+0x0F7C1]  00 00                    add     [bx+si],al
F000:77C3  [+0x0F7C3]  00 00                    add     [bx+si],al
F000:77C5  [+0x0F7C5]  00 00                    add     [bx+si],al
F000:77C7  [+0x0F7C7]  00 00                    add     [bx+si],al
F000:77C9  [+0x0F7C9]  00 00                    add     [bx+si],al
F000:77CB  [+0x0F7CB]  00 00                    add     [bx+si],al
F000:77CD  [+0x0F7CD]  00 00                    add     [bx+si],al
F000:77CF  [+0x0F7CF]  00 00                    add     [bx+si],al
F000:77D1  [+0x0F7D1]  00 00                    add     [bx+si],al
F000:77D3  [+0x0F7D3]  00 00                    add     [bx+si],al
F000:77D5  [+0x0F7D5]  00 00                    add     [bx+si],al
F000:77D7  [+0x0F7D7]  00 00                    add     [bx+si],al
F000:77D9  [+0x0F7D9]  00 00                    add     [bx+si],al
F000:77DB  [+0x0F7DB]  00 00                    add     [bx+si],al
F000:77DD  [+0x0F7DD]  00 00                    add     [bx+si],al
F000:77DF  [+0x0F7DF]  00 00                    add     [bx+si],al
F000:77E1  [+0x0F7E1]  00 00                    add     [bx+si],al
F000:77E3  [+0x0F7E3]  00 00                    add     [bx+si],al
F000:77E5  [+0x0F7E5]  00 00                    add     [bx+si],al
F000:77E7  [+0x0F7E7]  00 00                    add     [bx+si],al
F000:77E9  [+0x0F7E9]  00 00                    add     [bx+si],al
F000:77EB  [+0x0F7EB]  00 00                    add     [bx+si],al
F000:77ED  [+0x0F7ED]  00 00                    add     [bx+si],al
F000:77EF  [+0x0F7EF]  00 00                    add     [bx+si],al
F000:77F1  [+0x0F7F1]  00 00                    add     [bx+si],al
F000:77F3  [+0x0F7F3]  00 00                    add     [bx+si],al
F000:77F5  [+0x0F7F5]  00 00                    add     [bx+si],al
F000:77F7  [+0x0F7F7]  00 00                    add     [bx+si],al
F000:77F9  [+0x0F7F9]  00 00                    add     [bx+si],al
F000:77FB  [+0x0F7FB]  00 00                    add     [bx+si],al
F000:77FD  [+0x0F7FD]  00 00                    add     [bx+si],al
F000:77FF  [+0x0F7FF]  00 00                    add     [bx+si],al
F000:7801  [+0x0F801]  00 00                    add     [bx+si],al
F000:7803  [+0x0F803]  00 00                    add     [bx+si],al
F000:7805  [+0x0F805]  00 00                    add     [bx+si],al
F000:7807  [+0x0F807]  00 00                    add     [bx+si],al
F000:7809  [+0x0F809]  00 00                    add     [bx+si],al
F000:780B  [+0x0F80B]  00 00                    add     [bx+si],al
F000:780D  [+0x0F80D]  00 00                    add     [bx+si],al
F000:780F  [+0x0F80F]  00 00                    add     [bx+si],al
F000:7811  [+0x0F811]  00 00                    add     [bx+si],al
F000:7813  [+0x0F813]  00 00                    add     [bx+si],al
F000:7815  [+0x0F815]  00 00                    add     [bx+si],al
F000:7817  [+0x0F817]  00 00                    add     [bx+si],al
F000:7819  [+0x0F819]  00 00                    add     [bx+si],al
F000:781B  [+0x0F81B]  00 00                    add     [bx+si],al
F000:781D  [+0x0F81D]  00 00                    add     [bx+si],al
F000:781F  [+0x0F81F]  00 00                    add     [bx+si],al
F000:7821  [+0x0F821]  00 00                    add     [bx+si],al
F000:7823  [+0x0F823]  00 00                    add     [bx+si],al
F000:7825  [+0x0F825]  00 00                    add     [bx+si],al
F000:7827  [+0x0F827]  00 00                    add     [bx+si],al
F000:7829  [+0x0F829]  00 00                    add     [bx+si],al
F000:782B  [+0x0F82B]  00 00                    add     [bx+si],al
F000:782D  [+0x0F82D]  00 00                    add     [bx+si],al
F000:782F  [+0x0F82F]  00 00                    add     [bx+si],al
F000:7831  [+0x0F831]  00 00                    add     [bx+si],al
F000:7833  [+0x0F833]  00 00                    add     [bx+si],al
F000:7835  [+0x0F835]  00 00                    add     [bx+si],al
F000:7837  [+0x0F837]  00 00                    add     [bx+si],al
F000:7839  [+0x0F839]  00 00                    add     [bx+si],al
F000:783B  [+0x0F83B]  00 00                    add     [bx+si],al
F000:783D  [+0x0F83D]  00 00                    add     [bx+si],al
F000:783F  [+0x0F83F]  00 00                    add     [bx+si],al
F000:7841  [+0x0F841]  00 00                    add     [bx+si],al
F000:7843  [+0x0F843]  00 00                    add     [bx+si],al
F000:7845  [+0x0F845]  00 00                    add     [bx+si],al
F000:7847  [+0x0F847]  00 00                    add     [bx+si],al
F000:7849  [+0x0F849]  00 00                    add     [bx+si],al
F000:784B  [+0x0F84B]  00 00                    add     [bx+si],al
F000:784D  [+0x0F84D]  00 00                    add     [bx+si],al
F000:784F  [+0x0F84F]  00 00                    add     [bx+si],al
F000:7851  [+0x0F851]  00 00                    add     [bx+si],al
F000:7853  [+0x0F853]  00 00                    add     [bx+si],al
F000:7855  [+0x0F855]  00 00                    add     [bx+si],al
F000:7857  [+0x0F857]  00 00                    add     [bx+si],al
F000:7859  [+0x0F859]  00 00                    add     [bx+si],al
F000:785B  [+0x0F85B]  00 00                    add     [bx+si],al
F000:785D  [+0x0F85D]  00 00                    add     [bx+si],al
F000:785F  [+0x0F85F]  00 00                    add     [bx+si],al
F000:7861  [+0x0F861]  00 00                    add     [bx+si],al
F000:7863  [+0x0F863]  00 00                    add     [bx+si],al
F000:7865  [+0x0F865]  00 00                    add     [bx+si],al
F000:7867  [+0x0F867]  00 00                    add     [bx+si],al
F000:7869  [+0x0F869]  00 00                    add     [bx+si],al
F000:786B  [+0x0F86B]  00 00                    add     [bx+si],al
F000:786D  [+0x0F86D]  00 00                    add     [bx+si],al
F000:786F  [+0x0F86F]  00 00                    add     [bx+si],al
F000:7871  [+0x0F871]  00 00                    add     [bx+si],al
F000:7873  [+0x0F873]  00 00                    add     [bx+si],al
F000:7875  [+0x0F875]  00 00                    add     [bx+si],al
F000:7877  [+0x0F877]  00 00                    add     [bx+si],al
F000:7879  [+0x0F879]  00 00                    add     [bx+si],al
F000:787B  [+0x0F87B]  00 00                    add     [bx+si],al
F000:787D  [+0x0F87D]  00 00                    add     [bx+si],al
F000:787F  [+0x0F87F]  00 00                    add     [bx+si],al
F000:7881  [+0x0F881]  00 00                    add     [bx+si],al
F000:7883  [+0x0F883]  00 00                    add     [bx+si],al
F000:7885  [+0x0F885]  00 00                    add     [bx+si],al
F000:7887  [+0x0F887]  00 00                    add     [bx+si],al
F000:7889  [+0x0F889]  00 00                    add     [bx+si],al
F000:788B  [+0x0F88B]  00 00                    add     [bx+si],al
F000:788D  [+0x0F88D]  00 00                    add     [bx+si],al
F000:788F  [+0x0F88F]  00 00                    add     [bx+si],al
F000:7891  [+0x0F891]  00 00                    add     [bx+si],al
F000:7893  [+0x0F893]  00 00                    add     [bx+si],al
F000:7895  [+0x0F895]  00 00                    add     [bx+si],al
F000:7897  [+0x0F897]  00 00                    add     [bx+si],al
F000:7899  [+0x0F899]  00 00                    add     [bx+si],al
F000:789B  [+0x0F89B]  00 00                    add     [bx+si],al
F000:789D  [+0x0F89D]  00 00                    add     [bx+si],al
F000:789F  [+0x0F89F]  00 00                    add     [bx+si],al
F000:78A1  [+0x0F8A1]  00 00                    add     [bx+si],al
F000:78A3  [+0x0F8A3]  00 00                    add     [bx+si],al
F000:78A5  [+0x0F8A5]  00 00                    add     [bx+si],al
F000:78A7  [+0x0F8A7]  00 00                    add     [bx+si],al
F000:78A9  [+0x0F8A9]  00 00                    add     [bx+si],al
F000:78AB  [+0x0F8AB]  00 00                    add     [bx+si],al
F000:78AD  [+0x0F8AD]  00 00                    add     [bx+si],al
F000:78AF  [+0x0F8AF]  00 00                    add     [bx+si],al
F000:78B1  [+0x0F8B1]  00 00                    add     [bx+si],al
F000:78B3  [+0x0F8B3]  00 00                    add     [bx+si],al
F000:78B5  [+0x0F8B5]  00 00                    add     [bx+si],al
F000:78B7  [+0x0F8B7]  00 00                    add     [bx+si],al
F000:78B9  [+0x0F8B9]  00 00                    add     [bx+si],al
F000:78BB  [+0x0F8BB]  00 00                    add     [bx+si],al
F000:78BD  [+0x0F8BD]  00 00                    add     [bx+si],al
F000:78BF  [+0x0F8BF]  00 00                    add     [bx+si],al
F000:78C1  [+0x0F8C1]  00 00                    add     [bx+si],al
F000:78C3  [+0x0F8C3]  00 00                    add     [bx+si],al
F000:78C5  [+0x0F8C5]  00 00                    add     [bx+si],al
F000:78C7  [+0x0F8C7]  00 00                    add     [bx+si],al
F000:78C9  [+0x0F8C9]  00 00                    add     [bx+si],al
F000:78CB  [+0x0F8CB]  00 00                    add     [bx+si],al
F000:78CD  [+0x0F8CD]  00 00                    add     [bx+si],al
F000:78CF  [+0x0F8CF]  00 00                    add     [bx+si],al
F000:78D1  [+0x0F8D1]  00 00                    add     [bx+si],al
F000:78D3  [+0x0F8D3]  00 00                    add     [bx+si],al
F000:78D5  [+0x0F8D5]  00 00                    add     [bx+si],al
F000:78D7  [+0x0F8D7]  00 00                    add     [bx+si],al
F000:78D9  [+0x0F8D9]  00 00                    add     [bx+si],al
F000:78DB  [+0x0F8DB]  00 00                    add     [bx+si],al
F000:78DD  [+0x0F8DD]  00 00                    add     [bx+si],al
F000:78DF  [+0x0F8DF]  00 00                    add     [bx+si],al
F000:78E1  [+0x0F8E1]  00 00                    add     [bx+si],al
F000:78E3  [+0x0F8E3]  00 00                    add     [bx+si],al
F000:78E5  [+0x0F8E5]  00 00                    add     [bx+si],al
F000:78E7  [+0x0F8E7]  00 00                    add     [bx+si],al
F000:78E9  [+0x0F8E9]  00 00                    add     [bx+si],al
F000:78EB  [+0x0F8EB]  00 00                    add     [bx+si],al
F000:78ED  [+0x0F8ED]  00 00                    add     [bx+si],al
F000:78EF  [+0x0F8EF]  00 00                    add     [bx+si],al
F000:78F1  [+0x0F8F1]  00 00                    add     [bx+si],al
F000:78F3  [+0x0F8F3]  00 00                    add     [bx+si],al
F000:78F5  [+0x0F8F5]  00 00                    add     [bx+si],al
F000:78F7  [+0x0F8F7]  00 00                    add     [bx+si],al
F000:78F9  [+0x0F8F9]  00 00                    add     [bx+si],al
F000:78FB  [+0x0F8FB]  00 00                    add     [bx+si],al
F000:78FD  [+0x0F8FD]  00 00                    add     [bx+si],al
F000:78FF  [+0x0F8FF]  00 00                    add     [bx+si],al
F000:7901  [+0x0F901]  00 00                    add     [bx+si],al
F000:7903  [+0x0F903]  00 00                    add     [bx+si],al
F000:7905  [+0x0F905]  00 00                    add     [bx+si],al
F000:7907  [+0x0F907]  00 00                    add     [bx+si],al
F000:7909  [+0x0F909]  00 00                    add     [bx+si],al
F000:790B  [+0x0F90B]  00 00                    add     [bx+si],al
F000:790D  [+0x0F90D]  00 00                    add     [bx+si],al
F000:790F  [+0x0F90F]  00 00                    add     [bx+si],al
F000:7911  [+0x0F911]  00 00                    add     [bx+si],al
F000:7913  [+0x0F913]  00 00                    add     [bx+si],al
F000:7915  [+0x0F915]  00 00                    add     [bx+si],al
F000:7917  [+0x0F917]  00 00                    add     [bx+si],al
F000:7919  [+0x0F919]  00 00                    add     [bx+si],al
F000:791B  [+0x0F91B]  00 00                    add     [bx+si],al
F000:791D  [+0x0F91D]  00 00                    add     [bx+si],al
F000:791F  [+0x0F91F]  00 00                    add     [bx+si],al
F000:7921  [+0x0F921]  00 00                    add     [bx+si],al
F000:7923  [+0x0F923]  00 00                    add     [bx+si],al
F000:7925  [+0x0F925]  00 00                    add     [bx+si],al
F000:7927  [+0x0F927]  00 00                    add     [bx+si],al
F000:7929  [+0x0F929]  00 00                    add     [bx+si],al
F000:792B  [+0x0F92B]  00 00                    add     [bx+si],al
F000:792D  [+0x0F92D]  00 00                    add     [bx+si],al
F000:792F  [+0x0F92F]  00 00                    add     [bx+si],al
F000:7931  [+0x0F931]  00 00                    add     [bx+si],al
F000:7933  [+0x0F933]  00 00                    add     [bx+si],al
F000:7935  [+0x0F935]  00 00                    add     [bx+si],al
F000:7937  [+0x0F937]  00 00                    add     [bx+si],al
F000:7939  [+0x0F939]  00 00                    add     [bx+si],al
F000:793B  [+0x0F93B]  00 00                    add     [bx+si],al
F000:793D  [+0x0F93D]  00 00                    add     [bx+si],al
F000:793F  [+0x0F93F]  00 00                    add     [bx+si],al
F000:7941  [+0x0F941]  00 00                    add     [bx+si],al
F000:7943  [+0x0F943]  00 00                    add     [bx+si],al
F000:7945  [+0x0F945]  00 00                    add     [bx+si],al
F000:7947  [+0x0F947]  00 00                    add     [bx+si],al
F000:7949  [+0x0F949]  00 00                    add     [bx+si],al
F000:794B  [+0x0F94B]  00 00                    add     [bx+si],al
F000:794D  [+0x0F94D]  00 00                    add     [bx+si],al
F000:794F  [+0x0F94F]  00 00                    add     [bx+si],al
F000:7951  [+0x0F951]  00 00                    add     [bx+si],al
F000:7953  [+0x0F953]  00 00                    add     [bx+si],al
F000:7955  [+0x0F955]  00 00                    add     [bx+si],al
F000:7957  [+0x0F957]  00 00                    add     [bx+si],al
F000:7959  [+0x0F959]  00 00                    add     [bx+si],al
F000:795B  [+0x0F95B]  00 00                    add     [bx+si],al
F000:795D  [+0x0F95D]  00 00                    add     [bx+si],al
F000:795F  [+0x0F95F]  00 00                    add     [bx+si],al
F000:7961  [+0x0F961]  00 00                    add     [bx+si],al
F000:7963  [+0x0F963]  00 00                    add     [bx+si],al
F000:7965  [+0x0F965]  00 00                    add     [bx+si],al
F000:7967  [+0x0F967]  00 00                    add     [bx+si],al
F000:7969  [+0x0F969]  00 00                    add     [bx+si],al
F000:796B  [+0x0F96B]  00 00                    add     [bx+si],al
F000:796D  [+0x0F96D]  00 00                    add     [bx+si],al
F000:796F  [+0x0F96F]  00 00                    add     [bx+si],al
F000:7971  [+0x0F971]  00 00                    add     [bx+si],al
F000:7973  [+0x0F973]  00 00                    add     [bx+si],al
F000:7975  [+0x0F975]  00 00                    add     [bx+si],al
F000:7977  [+0x0F977]  00 00                    add     [bx+si],al
F000:7979  [+0x0F979]  00 00                    add     [bx+si],al
F000:797B  [+0x0F97B]  00 00                    add     [bx+si],al
F000:797D  [+0x0F97D]  00 00                    add     [bx+si],al
F000:797F  [+0x0F97F]  00 00                    add     [bx+si],al
F000:7981  [+0x0F981]  00 00                    add     [bx+si],al
F000:7983  [+0x0F983]  00 00                    add     [bx+si],al
F000:7985  [+0x0F985]  00 00                    add     [bx+si],al
F000:7987  [+0x0F987]  00 00                    add     [bx+si],al
F000:7989  [+0x0F989]  00 00                    add     [bx+si],al
F000:798B  [+0x0F98B]  00 00                    add     [bx+si],al
F000:798D  [+0x0F98D]  00 00                    add     [bx+si],al
F000:798F  [+0x0F98F]  00 00                    add     [bx+si],al
F000:7991  [+0x0F991]  00 00                    add     [bx+si],al
F000:7993  [+0x0F993]  00 00                    add     [bx+si],al
F000:7995  [+0x0F995]  00 00                    add     [bx+si],al
F000:7997  [+0x0F997]  00 00                    add     [bx+si],al
F000:7999  [+0x0F999]  00 00                    add     [bx+si],al
F000:799B  [+0x0F99B]  00 00                    add     [bx+si],al
F000:799D  [+0x0F99D]  00 00                    add     [bx+si],al
F000:799F  [+0x0F99F]  00 00                    add     [bx+si],al
F000:79A1  [+0x0F9A1]  00 00                    add     [bx+si],al
F000:79A3  [+0x0F9A3]  00 00                    add     [bx+si],al
F000:79A5  [+0x0F9A5]  00 00                    add     [bx+si],al
F000:79A7  [+0x0F9A7]  00 00                    add     [bx+si],al
F000:79A9  [+0x0F9A9]  00 00                    add     [bx+si],al
F000:79AB  [+0x0F9AB]  00 00                    add     [bx+si],al
F000:79AD  [+0x0F9AD]  00 00                    add     [bx+si],al
F000:79AF  [+0x0F9AF]  00 00                    add     [bx+si],al
F000:79B1  [+0x0F9B1]  00 00                    add     [bx+si],al
F000:79B3  [+0x0F9B3]  00 00                    add     [bx+si],al
F000:79B5  [+0x0F9B5]  00 00                    add     [bx+si],al
F000:79B7  [+0x0F9B7]  00 00                    add     [bx+si],al
F000:79B9  [+0x0F9B9]  00 00                    add     [bx+si],al
F000:79BB  [+0x0F9BB]  00 00                    add     [bx+si],al
F000:79BD  [+0x0F9BD]  00 00                    add     [bx+si],al
F000:79BF  [+0x0F9BF]  00 00                    add     [bx+si],al
F000:79C1  [+0x0F9C1]  00 00                    add     [bx+si],al
F000:79C3  [+0x0F9C3]  00 00                    add     [bx+si],al
F000:79C5  [+0x0F9C5]  00 00                    add     [bx+si],al
F000:79C7  [+0x0F9C7]  00 00                    add     [bx+si],al
F000:79C9  [+0x0F9C9]  00 00                    add     [bx+si],al
F000:79CB  [+0x0F9CB]  00 00                    add     [bx+si],al
F000:79CD  [+0x0F9CD]  00 00                    add     [bx+si],al
F000:79CF  [+0x0F9CF]  00 00                    add     [bx+si],al
F000:79D1  [+0x0F9D1]  00 00                    add     [bx+si],al
F000:79D3  [+0x0F9D3]  00 00                    add     [bx+si],al
F000:79D5  [+0x0F9D5]  00 00                    add     [bx+si],al
F000:79D7  [+0x0F9D7]  00 00                    add     [bx+si],al
F000:79D9  [+0x0F9D9]  00 00                    add     [bx+si],al
F000:79DB  [+0x0F9DB]  00 00                    add     [bx+si],al
F000:79DD  [+0x0F9DD]  00 00                    add     [bx+si],al
F000:79DF  [+0x0F9DF]  00 00                    add     [bx+si],al
F000:79E1  [+0x0F9E1]  00 00                    add     [bx+si],al
F000:79E3  [+0x0F9E3]  00 00                    add     [bx+si],al
F000:79E5  [+0x0F9E5]  00 00                    add     [bx+si],al
F000:79E7  [+0x0F9E7]  00 00                    add     [bx+si],al
F000:79E9  [+0x0F9E9]  00 00                    add     [bx+si],al
F000:79EB  [+0x0F9EB]  00 00                    add     [bx+si],al
F000:79ED  [+0x0F9ED]  00 00                    add     [bx+si],al
F000:79EF  [+0x0F9EF]  00 00                    add     [bx+si],al
F000:79F1  [+0x0F9F1]  00 00                    add     [bx+si],al
F000:79F3  [+0x0F9F3]  00 00                    add     [bx+si],al
F000:79F5  [+0x0F9F5]  00 00                    add     [bx+si],al
F000:79F7  [+0x0F9F7]  00 00                    add     [bx+si],al
F000:79F9  [+0x0F9F9]  00 00                    add     [bx+si],al
F000:79FB  [+0x0F9FB]  00 00                    add     [bx+si],al
F000:79FD  [+0x0F9FD]  00 00                    add     [bx+si],al
F000:79FF  [+0x0F9FF]  00 00                    add     [bx+si],al
F000:7A01  [+0x0FA01]  00 00                    add     [bx+si],al
F000:7A03  [+0x0FA03]  00 00                    add     [bx+si],al
F000:7A05  [+0x0FA05]  00 00                    add     [bx+si],al
F000:7A07  [+0x0FA07]  00 00                    add     [bx+si],al
F000:7A09  [+0x0FA09]  00 00                    add     [bx+si],al
F000:7A0B  [+0x0FA0B]  00 00                    add     [bx+si],al
F000:7A0D  [+0x0FA0D]  00 00                    add     [bx+si],al
F000:7A0F  [+0x0FA0F]  00 00                    add     [bx+si],al
F000:7A11  [+0x0FA11]  00 00                    add     [bx+si],al
F000:7A13  [+0x0FA13]  00 00                    add     [bx+si],al
F000:7A15  [+0x0FA15]  00 00                    add     [bx+si],al
F000:7A17  [+0x0FA17]  00 00                    add     [bx+si],al
F000:7A19  [+0x0FA19]  00 00                    add     [bx+si],al
F000:7A1B  [+0x0FA1B]  00 00                    add     [bx+si],al
F000:7A1D  [+0x0FA1D]  00 00                    add     [bx+si],al
F000:7A1F  [+0x0FA1F]  00 00                    add     [bx+si],al
F000:7A21  [+0x0FA21]  00 00                    add     [bx+si],al
F000:7A23  [+0x0FA23]  00 00                    add     [bx+si],al
F000:7A25  [+0x0FA25]  00 00                    add     [bx+si],al
F000:7A27  [+0x0FA27]  00 00                    add     [bx+si],al
F000:7A29  [+0x0FA29]  00 00                    add     [bx+si],al
F000:7A2B  [+0x0FA2B]  00 00                    add     [bx+si],al
F000:7A2D  [+0x0FA2D]  00 00                    add     [bx+si],al
F000:7A2F  [+0x0FA2F]  00 00                    add     [bx+si],al
F000:7A31  [+0x0FA31]  00 00                    add     [bx+si],al
F000:7A33  [+0x0FA33]  00 00                    add     [bx+si],al
F000:7A35  [+0x0FA35]  00 00                    add     [bx+si],al
F000:7A37  [+0x0FA37]  00 00                    add     [bx+si],al
F000:7A39  [+0x0FA39]  00 00                    add     [bx+si],al
F000:7A3B  [+0x0FA3B]  00 00                    add     [bx+si],al
F000:7A3D  [+0x0FA3D]  00 00                    add     [bx+si],al
F000:7A3F  [+0x0FA3F]  00 00                    add     [bx+si],al
F000:7A41  [+0x0FA41]  00 00                    add     [bx+si],al
F000:7A43  [+0x0FA43]  00 00                    add     [bx+si],al
F000:7A45  [+0x0FA45]  00 00                    add     [bx+si],al
F000:7A47  [+0x0FA47]  00 00                    add     [bx+si],al
F000:7A49  [+0x0FA49]  00 00                    add     [bx+si],al
F000:7A4B  [+0x0FA4B]  00 00                    add     [bx+si],al
F000:7A4D  [+0x0FA4D]  00 00                    add     [bx+si],al
F000:7A4F  [+0x0FA4F]  00 00                    add     [bx+si],al
F000:7A51  [+0x0FA51]  00 00                    add     [bx+si],al
F000:7A53  [+0x0FA53]  00 00                    add     [bx+si],al
F000:7A55  [+0x0FA55]  00 00                    add     [bx+si],al
F000:7A57  [+0x0FA57]  00 00                    add     [bx+si],al
F000:7A59  [+0x0FA59]  00 00                    add     [bx+si],al
F000:7A5B  [+0x0FA5B]  00 00                    add     [bx+si],al
F000:7A5D  [+0x0FA5D]  00 00                    add     [bx+si],al
F000:7A5F  [+0x0FA5F]  00 00                    add     [bx+si],al
F000:7A61  [+0x0FA61]  00 00                    add     [bx+si],al
F000:7A63  [+0x0FA63]  00 00                    add     [bx+si],al
F000:7A65  [+0x0FA65]  00 00                    add     [bx+si],al
F000:7A67  [+0x0FA67]  00 00                    add     [bx+si],al
F000:7A69  [+0x0FA69]  00 00                    add     [bx+si],al
F000:7A6B  [+0x0FA6B]  00 00                    add     [bx+si],al
F000:7A6D  [+0x0FA6D]  00 00                    add     [bx+si],al
F000:7A6F  [+0x0FA6F]  00 00                    add     [bx+si],al
F000:7A71  [+0x0FA71]  00 00                    add     [bx+si],al
F000:7A73  [+0x0FA73]  00 00                    add     [bx+si],al
F000:7A75  [+0x0FA75]  00 00                    add     [bx+si],al
F000:7A77  [+0x0FA77]  00 00                    add     [bx+si],al
F000:7A79  [+0x0FA79]  00 00                    add     [bx+si],al
F000:7A7B  [+0x0FA7B]  00 00                    add     [bx+si],al
F000:7A7D  [+0x0FA7D]  00 00                    add     [bx+si],al
F000:7A7F  [+0x0FA7F]  00 00                    add     [bx+si],al
F000:7A81  [+0x0FA81]  00 00                    add     [bx+si],al
F000:7A83  [+0x0FA83]  00 00                    add     [bx+si],al
F000:7A85  [+0x0FA85]  00 00                    add     [bx+si],al
F000:7A87  [+0x0FA87]  00 00                    add     [bx+si],al
F000:7A89  [+0x0FA89]  00 00                    add     [bx+si],al
F000:7A8B  [+0x0FA8B]  00 00                    add     [bx+si],al
F000:7A8D  [+0x0FA8D]  00 00                    add     [bx+si],al
F000:7A8F  [+0x0FA8F]  00 00                    add     [bx+si],al
F000:7A91  [+0x0FA91]  00 00                    add     [bx+si],al
F000:7A93  [+0x0FA93]  00 00                    add     [bx+si],al
F000:7A95  [+0x0FA95]  00 00                    add     [bx+si],al
F000:7A97  [+0x0FA97]  00 00                    add     [bx+si],al
F000:7A99  [+0x0FA99]  00 00                    add     [bx+si],al
F000:7A9B  [+0x0FA9B]  00 00                    add     [bx+si],al
F000:7A9D  [+0x0FA9D]  00 00                    add     [bx+si],al
F000:7A9F  [+0x0FA9F]  00 00                    add     [bx+si],al
F000:7AA1  [+0x0FAA1]  00 00                    add     [bx+si],al
F000:7AA3  [+0x0FAA3]  00 00                    add     [bx+si],al
F000:7AA5  [+0x0FAA5]  00 00                    add     [bx+si],al
F000:7AA7  [+0x0FAA7]  00 00                    add     [bx+si],al
F000:7AA9  [+0x0FAA9]  00 00                    add     [bx+si],al
F000:7AAB  [+0x0FAAB]  00 00                    add     [bx+si],al
F000:7AAD  [+0x0FAAD]  00 00                    add     [bx+si],al
F000:7AAF  [+0x0FAAF]  00 00                    add     [bx+si],al
F000:7AB1  [+0x0FAB1]  00 00                    add     [bx+si],al
F000:7AB3  [+0x0FAB3]  00 00                    add     [bx+si],al
F000:7AB5  [+0x0FAB5]  00 00                    add     [bx+si],al
F000:7AB7  [+0x0FAB7]  00 00                    add     [bx+si],al
F000:7AB9  [+0x0FAB9]  00 00                    add     [bx+si],al
F000:7ABB  [+0x0FABB]  00 00                    add     [bx+si],al
F000:7ABD  [+0x0FABD]  00 00                    add     [bx+si],al
F000:7ABF  [+0x0FABF]  00 00                    add     [bx+si],al
F000:7AC1  [+0x0FAC1]  00 00                    add     [bx+si],al
F000:7AC3  [+0x0FAC3]  00 00                    add     [bx+si],al
F000:7AC5  [+0x0FAC5]  00 00                    add     [bx+si],al
F000:7AC7  [+0x0FAC7]  00 00                    add     [bx+si],al
F000:7AC9  [+0x0FAC9]  00 00                    add     [bx+si],al
F000:7ACB  [+0x0FACB]  00 00                    add     [bx+si],al
F000:7ACD  [+0x0FACD]  00 00                    add     [bx+si],al
F000:7ACF  [+0x0FACF]  00 00                    add     [bx+si],al
F000:7AD1  [+0x0FAD1]  00 00                    add     [bx+si],al
F000:7AD3  [+0x0FAD3]  00 00                    add     [bx+si],al
F000:7AD5  [+0x0FAD5]  00 00                    add     [bx+si],al
F000:7AD7  [+0x0FAD7]  00 00                    add     [bx+si],al
F000:7AD9  [+0x0FAD9]  00 00                    add     [bx+si],al
F000:7ADB  [+0x0FADB]  00 00                    add     [bx+si],al
F000:7ADD  [+0x0FADD]  00 00                    add     [bx+si],al
F000:7ADF  [+0x0FADF]  00 00                    add     [bx+si],al
F000:7AE1  [+0x0FAE1]  00 00                    add     [bx+si],al
F000:7AE3  [+0x0FAE3]  00 00                    add     [bx+si],al
F000:7AE5  [+0x0FAE5]  00 00                    add     [bx+si],al
F000:7AE7  [+0x0FAE7]  00 00                    add     [bx+si],al
F000:7AE9  [+0x0FAE9]  00 00                    add     [bx+si],al
F000:7AEB  [+0x0FAEB]  00 00                    add     [bx+si],al
F000:7AED  [+0x0FAED]  00 00                    add     [bx+si],al
F000:7AEF  [+0x0FAEF]  00 00                    add     [bx+si],al
F000:7AF1  [+0x0FAF1]  00 00                    add     [bx+si],al
F000:7AF3  [+0x0FAF3]  00 00                    add     [bx+si],al
F000:7AF5  [+0x0FAF5]  00 00                    add     [bx+si],al
F000:7AF7  [+0x0FAF7]  00 00                    add     [bx+si],al
F000:7AF9  [+0x0FAF9]  00 00                    add     [bx+si],al
F000:7AFB  [+0x0FAFB]  00 00                    add     [bx+si],al
F000:7AFD  [+0x0FAFD]  00 00                    add     [bx+si],al
F000:7AFF  [+0x0FAFF]  00 00                    add     [bx+si],al
F000:7B01  [+0x0FB01]  00 00                    add     [bx+si],al
F000:7B03  [+0x0FB03]  00 00                    add     [bx+si],al
F000:7B05  [+0x0FB05]  00 00                    add     [bx+si],al
F000:7B07  [+0x0FB07]  00 00                    add     [bx+si],al
F000:7B09  [+0x0FB09]  00 00                    add     [bx+si],al
F000:7B0B  [+0x0FB0B]  00 00                    add     [bx+si],al
F000:7B0D  [+0x0FB0D]  00 00                    add     [bx+si],al
F000:7B0F  [+0x0FB0F]  00 00                    add     [bx+si],al
F000:7B11  [+0x0FB11]  00 00                    add     [bx+si],al
F000:7B13  [+0x0FB13]  00 00                    add     [bx+si],al
F000:7B15  [+0x0FB15]  00 00                    add     [bx+si],al
F000:7B17  [+0x0FB17]  00 00                    add     [bx+si],al
F000:7B19  [+0x0FB19]  00 00                    add     [bx+si],al
F000:7B1B  [+0x0FB1B]  00 00                    add     [bx+si],al
F000:7B1D  [+0x0FB1D]  00 00                    add     [bx+si],al
F000:7B1F  [+0x0FB1F]  00 00                    add     [bx+si],al
F000:7B21  [+0x0FB21]  00 00                    add     [bx+si],al
F000:7B23  [+0x0FB23]  00 00                    add     [bx+si],al
F000:7B25  [+0x0FB25]  00 00                    add     [bx+si],al
F000:7B27  [+0x0FB27]  00 00                    add     [bx+si],al
F000:7B29  [+0x0FB29]  00 00                    add     [bx+si],al
F000:7B2B  [+0x0FB2B]  00 00                    add     [bx+si],al
F000:7B2D  [+0x0FB2D]  00 00                    add     [bx+si],al
F000:7B2F  [+0x0FB2F]  00 00                    add     [bx+si],al
F000:7B31  [+0x0FB31]  00 00                    add     [bx+si],al
F000:7B33  [+0x0FB33]  00 00                    add     [bx+si],al
F000:7B35  [+0x0FB35]  00 00                    add     [bx+si],al
F000:7B37  [+0x0FB37]  00 00                    add     [bx+si],al
F000:7B39  [+0x0FB39]  00 00                    add     [bx+si],al
F000:7B3B  [+0x0FB3B]  00 00                    add     [bx+si],al
F000:7B3D  [+0x0FB3D]  00 00                    add     [bx+si],al
F000:7B3F  [+0x0FB3F]  00 00                    add     [bx+si],al
F000:7B41  [+0x0FB41]  00 00                    add     [bx+si],al
F000:7B43  [+0x0FB43]  00 00                    add     [bx+si],al
F000:7B45  [+0x0FB45]  00 00                    add     [bx+si],al
F000:7B47  [+0x0FB47]  00 00                    add     [bx+si],al
F000:7B49  [+0x0FB49]  00 00                    add     [bx+si],al
F000:7B4B  [+0x0FB4B]  00 00                    add     [bx+si],al
F000:7B4D  [+0x0FB4D]  00 00                    add     [bx+si],al
F000:7B4F  [+0x0FB4F]  00 00                    add     [bx+si],al
F000:7B51  [+0x0FB51]  00 00                    add     [bx+si],al
F000:7B53  [+0x0FB53]  00 00                    add     [bx+si],al
F000:7B55  [+0x0FB55]  00 00                    add     [bx+si],al
F000:7B57  [+0x0FB57]  00 00                    add     [bx+si],al
F000:7B59  [+0x0FB59]  00 00                    add     [bx+si],al
F000:7B5B  [+0x0FB5B]  00 00                    add     [bx+si],al
F000:7B5D  [+0x0FB5D]  00 00                    add     [bx+si],al
F000:7B5F  [+0x0FB5F]  00 00                    add     [bx+si],al
F000:7B61  [+0x0FB61]  00 00                    add     [bx+si],al
F000:7B63  [+0x0FB63]  00 00                    add     [bx+si],al
F000:7B65  [+0x0FB65]  00 00                    add     [bx+si],al
F000:7B67  [+0x0FB67]  00 00                    add     [bx+si],al
F000:7B69  [+0x0FB69]  00 00                    add     [bx+si],al
F000:7B6B  [+0x0FB6B]  00 00                    add     [bx+si],al
F000:7B6D  [+0x0FB6D]  00 00                    add     [bx+si],al
F000:7B6F  [+0x0FB6F]  00 00                    add     [bx+si],al
F000:7B71  [+0x0FB71]  00 00                    add     [bx+si],al
F000:7B73  [+0x0FB73]  00 00                    add     [bx+si],al
F000:7B75  [+0x0FB75]  00 00                    add     [bx+si],al
F000:7B77  [+0x0FB77]  00 00                    add     [bx+si],al
F000:7B79  [+0x0FB79]  00 00                    add     [bx+si],al
F000:7B7B  [+0x0FB7B]  00 00                    add     [bx+si],al
F000:7B7D  [+0x0FB7D]  00 00                    add     [bx+si],al
F000:7B7F  [+0x0FB7F]  00 00                    add     [bx+si],al
F000:7B81  [+0x0FB81]  00 00                    add     [bx+si],al
F000:7B83  [+0x0FB83]  00 00                    add     [bx+si],al
F000:7B85  [+0x0FB85]  00 00                    add     [bx+si],al
F000:7B87  [+0x0FB87]  00 00                    add     [bx+si],al
F000:7B89  [+0x0FB89]  00 00                    add     [bx+si],al
F000:7B8B  [+0x0FB8B]  00 00                    add     [bx+si],al
F000:7B8D  [+0x0FB8D]  00 00                    add     [bx+si],al
F000:7B8F  [+0x0FB8F]  00 00                    add     [bx+si],al
F000:7B91  [+0x0FB91]  00 00                    add     [bx+si],al
F000:7B93  [+0x0FB93]  00 00                    add     [bx+si],al
F000:7B95  [+0x0FB95]  00 00                    add     [bx+si],al
F000:7B97  [+0x0FB97]  00 00                    add     [bx+si],al
F000:7B99  [+0x0FB99]  00 00                    add     [bx+si],al
F000:7B9B  [+0x0FB9B]  00 00                    add     [bx+si],al
F000:7B9D  [+0x0FB9D]  00 00                    add     [bx+si],al
F000:7B9F  [+0x0FB9F]  00 00                    add     [bx+si],al
F000:7BA1  [+0x0FBA1]  00 00                    add     [bx+si],al
F000:7BA3  [+0x0FBA3]  00 00                    add     [bx+si],al
F000:7BA5  [+0x0FBA5]  00 00                    add     [bx+si],al
F000:7BA7  [+0x0FBA7]  00 00                    add     [bx+si],al
F000:7BA9  [+0x0FBA9]  00 00                    add     [bx+si],al
F000:7BAB  [+0x0FBAB]  00 00                    add     [bx+si],al
F000:7BAD  [+0x0FBAD]  00 00                    add     [bx+si],al
F000:7BAF  [+0x0FBAF]  00 00                    add     [bx+si],al
F000:7BB1  [+0x0FBB1]  00 00                    add     [bx+si],al
F000:7BB3  [+0x0FBB3]  00 00                    add     [bx+si],al
F000:7BB5  [+0x0FBB5]  00 00                    add     [bx+si],al
F000:7BB7  [+0x0FBB7]  00 00                    add     [bx+si],al
F000:7BB9  [+0x0FBB9]  00 00                    add     [bx+si],al
F000:7BBB  [+0x0FBBB]  00 00                    add     [bx+si],al
F000:7BBD  [+0x0FBBD]  00 00                    add     [bx+si],al
F000:7BBF  [+0x0FBBF]  00 00                    add     [bx+si],al
F000:7BC1  [+0x0FBC1]  00 00                    add     [bx+si],al
F000:7BC3  [+0x0FBC3]  00 00                    add     [bx+si],al
F000:7BC5  [+0x0FBC5]  00 00                    add     [bx+si],al
F000:7BC7  [+0x0FBC7]  00 00                    add     [bx+si],al
F000:7BC9  [+0x0FBC9]  00 00                    add     [bx+si],al
F000:7BCB  [+0x0FBCB]  00 00                    add     [bx+si],al
F000:7BCD  [+0x0FBCD]  00 00                    add     [bx+si],al
F000:7BCF  [+0x0FBCF]  00 00                    add     [bx+si],al
F000:7BD1  [+0x0FBD1]  00 00                    add     [bx+si],al
F000:7BD3  [+0x0FBD3]  00 00                    add     [bx+si],al
F000:7BD5  [+0x0FBD5]  00 00                    add     [bx+si],al
F000:7BD7  [+0x0FBD7]  00 00                    add     [bx+si],al
F000:7BD9  [+0x0FBD9]  00 00                    add     [bx+si],al
F000:7BDB  [+0x0FBDB]  00 00                    add     [bx+si],al
F000:7BDD  [+0x0FBDD]  00 00                    add     [bx+si],al
F000:7BDF  [+0x0FBDF]  00 00                    add     [bx+si],al
F000:7BE1  [+0x0FBE1]  00 00                    add     [bx+si],al
F000:7BE3  [+0x0FBE3]  00 00                    add     [bx+si],al
F000:7BE5  [+0x0FBE5]  00 00                    add     [bx+si],al
F000:7BE7  [+0x0FBE7]  00 00                    add     [bx+si],al
F000:7BE9  [+0x0FBE9]  00 00                    add     [bx+si],al
F000:7BEB  [+0x0FBEB]  00 00                    add     [bx+si],al
F000:7BED  [+0x0FBED]  00 00                    add     [bx+si],al
F000:7BEF  [+0x0FBEF]  00 00                    add     [bx+si],al
F000:7BF1  [+0x0FBF1]  00 00                    add     [bx+si],al
F000:7BF3  [+0x0FBF3]  00 00                    add     [bx+si],al
F000:7BF5  [+0x0FBF5]  00 00                    add     [bx+si],al
F000:7BF7  [+0x0FBF7]  00 00                    add     [bx+si],al
F000:7BF9  [+0x0FBF9]  00 00                    add     [bx+si],al
F000:7BFB  [+0x0FBFB]  00 00                    add     [bx+si],al
F000:7BFD  [+0x0FBFD]  00 00                    add     [bx+si],al
F000:7BFF  [+0x0FBFF]  00 00                    add     [bx+si],al
F000:7C01  [+0x0FC01]  00 00                    add     [bx+si],al
F000:7C03  [+0x0FC03]  00 00                    add     [bx+si],al
F000:7C05  [+0x0FC05]  00 00                    add     [bx+si],al
F000:7C07  [+0x0FC07]  00 00                    add     [bx+si],al
F000:7C09  [+0x0FC09]  00 00                    add     [bx+si],al
F000:7C0B  [+0x0FC0B]  00 00                    add     [bx+si],al
F000:7C0D  [+0x0FC0D]  00 00                    add     [bx+si],al
F000:7C0F  [+0x0FC0F]  00 00                    add     [bx+si],al
F000:7C11  [+0x0FC11]  00 00                    add     [bx+si],al
F000:7C13  [+0x0FC13]  00 00                    add     [bx+si],al
F000:7C15  [+0x0FC15]  00 00                    add     [bx+si],al
F000:7C17  [+0x0FC17]  00 00                    add     [bx+si],al
F000:7C19  [+0x0FC19]  00 00                    add     [bx+si],al
F000:7C1B  [+0x0FC1B]  00 00                    add     [bx+si],al
F000:7C1D  [+0x0FC1D]  00 00                    add     [bx+si],al
F000:7C1F  [+0x0FC1F]  00 00                    add     [bx+si],al
F000:7C21  [+0x0FC21]  00 00                    add     [bx+si],al
F000:7C23  [+0x0FC23]  00 00                    add     [bx+si],al
F000:7C25  [+0x0FC25]  00 00                    add     [bx+si],al
F000:7C27  [+0x0FC27]  00 00                    add     [bx+si],al
F000:7C29  [+0x0FC29]  00 00                    add     [bx+si],al
F000:7C2B  [+0x0FC2B]  00 00                    add     [bx+si],al
F000:7C2D  [+0x0FC2D]  00 00                    add     [bx+si],al
F000:7C2F  [+0x0FC2F]  00 00                    add     [bx+si],al
F000:7C31  [+0x0FC31]  00 00                    add     [bx+si],al
F000:7C33  [+0x0FC33]  00 00                    add     [bx+si],al
F000:7C35  [+0x0FC35]  00 00                    add     [bx+si],al
F000:7C37  [+0x0FC37]  00 00                    add     [bx+si],al
F000:7C39  [+0x0FC39]  00 00                    add     [bx+si],al
F000:7C3B  [+0x0FC3B]  00 00                    add     [bx+si],al
F000:7C3D  [+0x0FC3D]  00 00                    add     [bx+si],al
F000:7C3F  [+0x0FC3F]  00 00                    add     [bx+si],al
F000:7C41  [+0x0FC41]  00 00                    add     [bx+si],al
F000:7C43  [+0x0FC43]  00 00                    add     [bx+si],al
F000:7C45  [+0x0FC45]  00 00                    add     [bx+si],al
F000:7C47  [+0x0FC47]  00 00                    add     [bx+si],al
F000:7C49  [+0x0FC49]  00 00                    add     [bx+si],al
F000:7C4B  [+0x0FC4B]  00 00                    add     [bx+si],al
F000:7C4D  [+0x0FC4D]  00 00                    add     [bx+si],al
F000:7C4F  [+0x0FC4F]  00 00                    add     [bx+si],al
F000:7C51  [+0x0FC51]  00 00                    add     [bx+si],al
F000:7C53  [+0x0FC53]  00 00                    add     [bx+si],al
F000:7C55  [+0x0FC55]  00 00                    add     [bx+si],al
F000:7C57  [+0x0FC57]  00 00                    add     [bx+si],al
F000:7C59  [+0x0FC59]  00 00                    add     [bx+si],al
F000:7C5B  [+0x0FC5B]  00 00                    add     [bx+si],al
F000:7C5D  [+0x0FC5D]  00 00                    add     [bx+si],al
F000:7C5F  [+0x0FC5F]  00 00                    add     [bx+si],al
F000:7C61  [+0x0FC61]  00 00                    add     [bx+si],al
F000:7C63  [+0x0FC63]  00 00                    add     [bx+si],al
F000:7C65  [+0x0FC65]  00 00                    add     [bx+si],al
F000:7C67  [+0x0FC67]  00 00                    add     [bx+si],al
F000:7C69  [+0x0FC69]  00 00                    add     [bx+si],al
F000:7C6B  [+0x0FC6B]  00 00                    add     [bx+si],al
F000:7C6D  [+0x0FC6D]  00 00                    add     [bx+si],al
F000:7C6F  [+0x0FC6F]  00 00                    add     [bx+si],al
F000:7C71  [+0x0FC71]  00 00                    add     [bx+si],al
F000:7C73  [+0x0FC73]  00 00                    add     [bx+si],al
F000:7C75  [+0x0FC75]  00 00                    add     [bx+si],al
F000:7C77  [+0x0FC77]  00 00                    add     [bx+si],al
F000:7C79  [+0x0FC79]  00 00                    add     [bx+si],al
F000:7C7B  [+0x0FC7B]  00 00                    add     [bx+si],al
F000:7C7D  [+0x0FC7D]  00 00                    add     [bx+si],al
F000:7C7F  [+0x0FC7F]  00 00                    add     [bx+si],al
F000:7C81  [+0x0FC81]  00 00                    add     [bx+si],al
F000:7C83  [+0x0FC83]  00 00                    add     [bx+si],al
F000:7C85  [+0x0FC85]  00 00                    add     [bx+si],al
F000:7C87  [+0x0FC87]  00 00                    add     [bx+si],al
F000:7C89  [+0x0FC89]  00 00                    add     [bx+si],al
F000:7C8B  [+0x0FC8B]  00 00                    add     [bx+si],al
F000:7C8D  [+0x0FC8D]  00 00                    add     [bx+si],al
F000:7C8F  [+0x0FC8F]  00 00                    add     [bx+si],al
F000:7C91  [+0x0FC91]  00 00                    add     [bx+si],al
F000:7C93  [+0x0FC93]  00 00                    add     [bx+si],al
F000:7C95  [+0x0FC95]  00 00                    add     [bx+si],al
F000:7C97  [+0x0FC97]  00 00                    add     [bx+si],al
F000:7C99  [+0x0FC99]  00 00                    add     [bx+si],al
F000:7C9B  [+0x0FC9B]  00 00                    add     [bx+si],al
F000:7C9D  [+0x0FC9D]  00 00                    add     [bx+si],al
F000:7C9F  [+0x0FC9F]  00 00                    add     [bx+si],al
F000:7CA1  [+0x0FCA1]  00 00                    add     [bx+si],al
F000:7CA3  [+0x0FCA3]  00 00                    add     [bx+si],al
F000:7CA5  [+0x0FCA5]  00 00                    add     [bx+si],al
F000:7CA7  [+0x0FCA7]  00 00                    add     [bx+si],al
F000:7CA9  [+0x0FCA9]  00 00                    add     [bx+si],al
F000:7CAB  [+0x0FCAB]  00 00                    add     [bx+si],al
F000:7CAD  [+0x0FCAD]  00 00                    add     [bx+si],al
F000:7CAF  [+0x0FCAF]  00 00                    add     [bx+si],al
F000:7CB1  [+0x0FCB1]  00 00                    add     [bx+si],al
F000:7CB3  [+0x0FCB3]  00 00                    add     [bx+si],al
F000:7CB5  [+0x0FCB5]  00 00                    add     [bx+si],al
F000:7CB7  [+0x0FCB7]  00 00                    add     [bx+si],al
F000:7CB9  [+0x0FCB9]  00 00                    add     [bx+si],al
F000:7CBB  [+0x0FCBB]  00 00                    add     [bx+si],al
F000:7CBD  [+0x0FCBD]  00 00                    add     [bx+si],al
F000:7CBF  [+0x0FCBF]  00 00                    add     [bx+si],al
F000:7CC1  [+0x0FCC1]  00 00                    add     [bx+si],al
F000:7CC3  [+0x0FCC3]  00 00                    add     [bx+si],al
F000:7CC5  [+0x0FCC5]  00 00                    add     [bx+si],al
F000:7CC7  [+0x0FCC7]  00 00                    add     [bx+si],al
F000:7CC9  [+0x0FCC9]  00 00                    add     [bx+si],al
F000:7CCB  [+0x0FCCB]  00 00                    add     [bx+si],al
F000:7CCD  [+0x0FCCD]  00 00                    add     [bx+si],al
F000:7CCF  [+0x0FCCF]  00 00                    add     [bx+si],al
F000:7CD1  [+0x0FCD1]  00 00                    add     [bx+si],al
F000:7CD3  [+0x0FCD3]  00 00                    add     [bx+si],al
F000:7CD5  [+0x0FCD5]  00 00                    add     [bx+si],al
F000:7CD7  [+0x0FCD7]  00 00                    add     [bx+si],al
F000:7CD9  [+0x0FCD9]  00 00                    add     [bx+si],al
F000:7CDB  [+0x0FCDB]  00 00                    add     [bx+si],al
F000:7CDD  [+0x0FCDD]  00 00                    add     [bx+si],al
F000:7CDF  [+0x0FCDF]  00 00                    add     [bx+si],al
F000:7CE1  [+0x0FCE1]  00 00                    add     [bx+si],al
F000:7CE3  [+0x0FCE3]  00 00                    add     [bx+si],al
F000:7CE5  [+0x0FCE5]  00 00                    add     [bx+si],al
F000:7CE7  [+0x0FCE7]  00 00                    add     [bx+si],al
F000:7CE9  [+0x0FCE9]  00 00                    add     [bx+si],al
F000:7CEB  [+0x0FCEB]  00 00                    add     [bx+si],al
F000:7CED  [+0x0FCED]  00 00                    add     [bx+si],al
F000:7CEF  [+0x0FCEF]  00 00                    add     [bx+si],al
F000:7CF1  [+0x0FCF1]  00 00                    add     [bx+si],al
F000:7CF3  [+0x0FCF3]  00 00                    add     [bx+si],al
F000:7CF5  [+0x0FCF5]  00 00                    add     [bx+si],al
F000:7CF7  [+0x0FCF7]  00 00                    add     [bx+si],al
F000:7CF9  [+0x0FCF9]  00 00                    add     [bx+si],al
F000:7CFB  [+0x0FCFB]  00 00                    add     [bx+si],al
F000:7CFD  [+0x0FCFD]  00 00                    add     [bx+si],al
F000:7CFF  [+0x0FCFF]  00 00                    add     [bx+si],al
F000:7D01  [+0x0FD01]  00 00                    add     [bx+si],al
F000:7D03  [+0x0FD03]  00 00                    add     [bx+si],al
F000:7D05  [+0x0FD05]  00 00                    add     [bx+si],al
F000:7D07  [+0x0FD07]  00 00                    add     [bx+si],al
F000:7D09  [+0x0FD09]  00 00                    add     [bx+si],al
F000:7D0B  [+0x0FD0B]  00 00                    add     [bx+si],al
F000:7D0D  [+0x0FD0D]  00 00                    add     [bx+si],al
F000:7D0F  [+0x0FD0F]  00 00                    add     [bx+si],al
F000:7D11  [+0x0FD11]  00 00                    add     [bx+si],al
F000:7D13  [+0x0FD13]  00 00                    add     [bx+si],al
F000:7D15  [+0x0FD15]  00 00                    add     [bx+si],al
F000:7D17  [+0x0FD17]  00 00                    add     [bx+si],al
F000:7D19  [+0x0FD19]  00 00                    add     [bx+si],al
F000:7D1B  [+0x0FD1B]  00 00                    add     [bx+si],al
F000:7D1D  [+0x0FD1D]  00 00                    add     [bx+si],al
F000:7D1F  [+0x0FD1F]  00 00                    add     [bx+si],al
F000:7D21  [+0x0FD21]  00 00                    add     [bx+si],al
F000:7D23  [+0x0FD23]  00 00                    add     [bx+si],al
F000:7D25  [+0x0FD25]  00 00                    add     [bx+si],al
F000:7D27  [+0x0FD27]  00 00                    add     [bx+si],al
F000:7D29  [+0x0FD29]  00 00                    add     [bx+si],al
F000:7D2B  [+0x0FD2B]  00 00                    add     [bx+si],al
F000:7D2D  [+0x0FD2D]  00 00                    add     [bx+si],al
F000:7D2F  [+0x0FD2F]  00 00                    add     [bx+si],al
F000:7D31  [+0x0FD31]  00 00                    add     [bx+si],al
F000:7D33  [+0x0FD33]  00 00                    add     [bx+si],al
F000:7D35  [+0x0FD35]  00 00                    add     [bx+si],al
F000:7D37  [+0x0FD37]  00 00                    add     [bx+si],al
F000:7D39  [+0x0FD39]  00 00                    add     [bx+si],al
F000:7D3B  [+0x0FD3B]  00 00                    add     [bx+si],al
F000:7D3D  [+0x0FD3D]  00 00                    add     [bx+si],al
F000:7D3F  [+0x0FD3F]  00 00                    add     [bx+si],al
F000:7D41  [+0x0FD41]  00 00                    add     [bx+si],al
F000:7D43  [+0x0FD43]  00 00                    add     [bx+si],al
F000:7D45  [+0x0FD45]  00 00                    add     [bx+si],al
F000:7D47  [+0x0FD47]  00 00                    add     [bx+si],al
F000:7D49  [+0x0FD49]  00 00                    add     [bx+si],al
F000:7D4B  [+0x0FD4B]  00 00                    add     [bx+si],al
F000:7D4D  [+0x0FD4D]  00 00                    add     [bx+si],al
F000:7D4F  [+0x0FD4F]  00 00                    add     [bx+si],al
F000:7D51  [+0x0FD51]  00 00                    add     [bx+si],al
F000:7D53  [+0x0FD53]  00 00                    add     [bx+si],al
F000:7D55  [+0x0FD55]  00 00                    add     [bx+si],al
F000:7D57  [+0x0FD57]  00 00                    add     [bx+si],al
F000:7D59  [+0x0FD59]  00 00                    add     [bx+si],al
F000:7D5B  [+0x0FD5B]  00 00                    add     [bx+si],al
F000:7D5D  [+0x0FD5D]  00 00                    add     [bx+si],al
F000:7D5F  [+0x0FD5F]  00 00                    add     [bx+si],al
F000:7D61  [+0x0FD61]  00 00                    add     [bx+si],al
F000:7D63  [+0x0FD63]  00 00                    add     [bx+si],al
F000:7D65  [+0x0FD65]  00 00                    add     [bx+si],al
F000:7D67  [+0x0FD67]  00 00                    add     [bx+si],al
F000:7D69  [+0x0FD69]  00 00                    add     [bx+si],al
F000:7D6B  [+0x0FD6B]  00 00                    add     [bx+si],al
F000:7D6D  [+0x0FD6D]  00 00                    add     [bx+si],al
F000:7D6F  [+0x0FD6F]  00 00                    add     [bx+si],al
F000:7D71  [+0x0FD71]  00 00                    add     [bx+si],al
F000:7D73  [+0x0FD73]  00 00                    add     [bx+si],al
F000:7D75  [+0x0FD75]  00 00                    add     [bx+si],al
F000:7D77  [+0x0FD77]  00 00                    add     [bx+si],al
F000:7D79  [+0x0FD79]  00 00                    add     [bx+si],al
F000:7D7B  [+0x0FD7B]  00 00                    add     [bx+si],al
F000:7D7D  [+0x0FD7D]  00 00                    add     [bx+si],al
F000:7D7F  [+0x0FD7F]  00 00                    add     [bx+si],al
F000:7D81  [+0x0FD81]  00 00                    add     [bx+si],al
F000:7D83  [+0x0FD83]  00 00                    add     [bx+si],al
F000:7D85  [+0x0FD85]  00 00                    add     [bx+si],al
F000:7D87  [+0x0FD87]  00 00                    add     [bx+si],al
F000:7D89  [+0x0FD89]  00 00                    add     [bx+si],al
F000:7D8B  [+0x0FD8B]  00 00                    add     [bx+si],al
F000:7D8D  [+0x0FD8D]  00 00                    add     [bx+si],al
F000:7D8F  [+0x0FD8F]  00 00                    add     [bx+si],al
F000:7D91  [+0x0FD91]  00 00                    add     [bx+si],al
F000:7D93  [+0x0FD93]  00 00                    add     [bx+si],al
F000:7D95  [+0x0FD95]  00 00                    add     [bx+si],al
F000:7D97  [+0x0FD97]  00 00                    add     [bx+si],al
F000:7D99  [+0x0FD99]  00 00                    add     [bx+si],al
F000:7D9B  [+0x0FD9B]  00 00                    add     [bx+si],al
F000:7D9D  [+0x0FD9D]  00 00                    add     [bx+si],al
F000:7D9F  [+0x0FD9F]  00 00                    add     [bx+si],al
F000:7DA1  [+0x0FDA1]  00 00                    add     [bx+si],al
F000:7DA3  [+0x0FDA3]  00 00                    add     [bx+si],al
F000:7DA5  [+0x0FDA5]  00 00                    add     [bx+si],al
F000:7DA7  [+0x0FDA7]  00 00                    add     [bx+si],al
F000:7DA9  [+0x0FDA9]  00 00                    add     [bx+si],al
F000:7DAB  [+0x0FDAB]  00 00                    add     [bx+si],al
F000:7DAD  [+0x0FDAD]  00 00                    add     [bx+si],al
F000:7DAF  [+0x0FDAF]  00 00                    add     [bx+si],al
F000:7DB1  [+0x0FDB1]  00 00                    add     [bx+si],al
F000:7DB3  [+0x0FDB3]  00 00                    add     [bx+si],al
F000:7DB5  [+0x0FDB5]  00 00                    add     [bx+si],al
F000:7DB7  [+0x0FDB7]  00 00                    add     [bx+si],al
F000:7DB9  [+0x0FDB9]  00 00                    add     [bx+si],al
F000:7DBB  [+0x0FDBB]  00 00                    add     [bx+si],al
F000:7DBD  [+0x0FDBD]  00 00                    add     [bx+si],al
F000:7DBF  [+0x0FDBF]  00 00                    add     [bx+si],al
F000:7DC1  [+0x0FDC1]  00 00                    add     [bx+si],al
F000:7DC3  [+0x0FDC3]  00 00                    add     [bx+si],al
F000:7DC5  [+0x0FDC5]  00 00                    add     [bx+si],al
F000:7DC7  [+0x0FDC7]  00 00                    add     [bx+si],al
F000:7DC9  [+0x0FDC9]  00 00                    add     [bx+si],al
F000:7DCB  [+0x0FDCB]  00 00                    add     [bx+si],al
F000:7DCD  [+0x0FDCD]  00 00                    add     [bx+si],al
F000:7DCF  [+0x0FDCF]  00 00                    add     [bx+si],al
F000:7DD1  [+0x0FDD1]  00 00                    add     [bx+si],al
F000:7DD3  [+0x0FDD3]  00 00                    add     [bx+si],al
F000:7DD5  [+0x0FDD5]  00 00                    add     [bx+si],al
F000:7DD7  [+0x0FDD7]  00 00                    add     [bx+si],al
F000:7DD9  [+0x0FDD9]  00 00                    add     [bx+si],al
F000:7DDB  [+0x0FDDB]  00 00                    add     [bx+si],al
F000:7DDD  [+0x0FDDD]  00 00                    add     [bx+si],al
F000:7DDF  [+0x0FDDF]  00 00                    add     [bx+si],al
F000:7DE1  [+0x0FDE1]  00 00                    add     [bx+si],al
F000:7DE3  [+0x0FDE3]  00 00                    add     [bx+si],al
F000:7DE5  [+0x0FDE5]  00 00                    add     [bx+si],al
F000:7DE7  [+0x0FDE7]  00 00                    add     [bx+si],al
F000:7DE9  [+0x0FDE9]  00 00                    add     [bx+si],al
F000:7DEB  [+0x0FDEB]  00 00                    add     [bx+si],al
F000:7DED  [+0x0FDED]  00 00                    add     [bx+si],al
F000:7DEF  [+0x0FDEF]  00 00                    add     [bx+si],al
F000:7DF1  [+0x0FDF1]  00 00                    add     [bx+si],al
F000:7DF3  [+0x0FDF3]  00 00                    add     [bx+si],al
F000:7DF5  [+0x0FDF5]  00 00                    add     [bx+si],al
F000:7DF7  [+0x0FDF7]  00 00                    add     [bx+si],al
F000:7DF9  [+0x0FDF9]  00 00                    add     [bx+si],al
F000:7DFB  [+0x0FDFB]  00 00                    add     [bx+si],al
F000:7DFD  [+0x0FDFD]  00 00                    add     [bx+si],al
F000:7DFF  [+0x0FDFF]  00 00                    add     [bx+si],al
F000:7E01  [+0x0FE01]  00 00                    add     [bx+si],al
F000:7E03  [+0x0FE03]  00 00                    add     [bx+si],al
F000:7E05  [+0x0FE05]  00 00                    add     [bx+si],al
F000:7E07  [+0x0FE07]  00 00                    add     [bx+si],al
F000:7E09  [+0x0FE09]  00 00                    add     [bx+si],al
F000:7E0B  [+0x0FE0B]  00 00                    add     [bx+si],al
F000:7E0D  [+0x0FE0D]  00 00                    add     [bx+si],al
F000:7E0F  [+0x0FE0F]  00 00                    add     [bx+si],al
F000:7E11  [+0x0FE11]  00 00                    add     [bx+si],al
F000:7E13  [+0x0FE13]  00 00                    add     [bx+si],al
F000:7E15  [+0x0FE15]  00 00                    add     [bx+si],al
F000:7E17  [+0x0FE17]  00 00                    add     [bx+si],al
F000:7E19  [+0x0FE19]  00 00                    add     [bx+si],al
F000:7E1B  [+0x0FE1B]  00 00                    add     [bx+si],al
F000:7E1D  [+0x0FE1D]  00 00                    add     [bx+si],al
F000:7E1F  [+0x0FE1F]  00 00                    add     [bx+si],al
F000:7E21  [+0x0FE21]  00 00                    add     [bx+si],al
F000:7E23  [+0x0FE23]  00 00                    add     [bx+si],al
F000:7E25  [+0x0FE25]  00 00                    add     [bx+si],al
F000:7E27  [+0x0FE27]  00 00                    add     [bx+si],al
F000:7E29  [+0x0FE29]  00 00                    add     [bx+si],al
F000:7E2B  [+0x0FE2B]  00 00                    add     [bx+si],al
F000:7E2D  [+0x0FE2D]  00 00                    add     [bx+si],al
F000:7E2F  [+0x0FE2F]  00 00                    add     [bx+si],al
F000:7E31  [+0x0FE31]  00 00                    add     [bx+si],al
F000:7E33  [+0x0FE33]  00 00                    add     [bx+si],al
F000:7E35  [+0x0FE35]  00 00                    add     [bx+si],al
F000:7E37  [+0x0FE37]  00 00                    add     [bx+si],al
F000:7E39  [+0x0FE39]  00 00                    add     [bx+si],al
F000:7E3B  [+0x0FE3B]  00 00                    add     [bx+si],al
F000:7E3D  [+0x0FE3D]  00 00                    add     [bx+si],al
F000:7E3F  [+0x0FE3F]  00 00                    add     [bx+si],al
F000:7E41  [+0x0FE41]  00 00                    add     [bx+si],al
F000:7E43  [+0x0FE43]  00 00                    add     [bx+si],al
F000:7E45  [+0x0FE45]  00 00                    add     [bx+si],al
F000:7E47  [+0x0FE47]  00 00                    add     [bx+si],al
F000:7E49  [+0x0FE49]  00 00                    add     [bx+si],al
F000:7E4B  [+0x0FE4B]  00 00                    add     [bx+si],al
F000:7E4D  [+0x0FE4D]  00 00                    add     [bx+si],al
F000:7E4F  [+0x0FE4F]  00 00                    add     [bx+si],al
F000:7E51  [+0x0FE51]  00 00                    add     [bx+si],al
F000:7E53  [+0x0FE53]  00 00                    add     [bx+si],al
F000:7E55  [+0x0FE55]  00 00                    add     [bx+si],al
F000:7E57  [+0x0FE57]  00 00                    add     [bx+si],al
F000:7E59  [+0x0FE59]  00 00                    add     [bx+si],al
F000:7E5B  [+0x0FE5B]  00 00                    add     [bx+si],al
F000:7E5D  [+0x0FE5D]  00 00                    add     [bx+si],al
F000:7E5F  [+0x0FE5F]  00 00                    add     [bx+si],al
F000:7E61  [+0x0FE61]  00 00                    add     [bx+si],al
F000:7E63  [+0x0FE63]  00 00                    add     [bx+si],al
F000:7E65  [+0x0FE65]  00 00                    add     [bx+si],al
F000:7E67  [+0x0FE67]  00 00                    add     [bx+si],al
F000:7E69  [+0x0FE69]  00 00                    add     [bx+si],al
F000:7E6B  [+0x0FE6B]  00 00                    add     [bx+si],al
F000:7E6D  [+0x0FE6D]  00 00                    add     [bx+si],al
F000:7E6F  [+0x0FE6F]  00 00                    add     [bx+si],al
F000:7E71  [+0x0FE71]  00 00                    add     [bx+si],al
F000:7E73  [+0x0FE73]  00 00                    add     [bx+si],al
F000:7E75  [+0x0FE75]  00 00                    add     [bx+si],al
F000:7E77  [+0x0FE77]  00 00                    add     [bx+si],al
F000:7E79  [+0x0FE79]  00 00                    add     [bx+si],al
F000:7E7B  [+0x0FE7B]  00 00                    add     [bx+si],al
F000:7E7D  [+0x0FE7D]  00 00                    add     [bx+si],al
F000:7E7F  [+0x0FE7F]  00 00                    add     [bx+si],al
F000:7E81  [+0x0FE81]  00 00                    add     [bx+si],al
F000:7E83  [+0x0FE83]  00 00                    add     [bx+si],al
F000:7E85  [+0x0FE85]  00 00                    add     [bx+si],al
F000:7E87  [+0x0FE87]  00 00                    add     [bx+si],al
F000:7E89  [+0x0FE89]  00 00                    add     [bx+si],al
F000:7E8B  [+0x0FE8B]  00 00                    add     [bx+si],al
F000:7E8D  [+0x0FE8D]  00 00                    add     [bx+si],al
F000:7E8F  [+0x0FE8F]  00 00                    add     [bx+si],al
F000:7E91  [+0x0FE91]  00 00                    add     [bx+si],al
F000:7E93  [+0x0FE93]  00 00                    add     [bx+si],al
F000:7E95  [+0x0FE95]  00 00                    add     [bx+si],al
F000:7E97  [+0x0FE97]  00 00                    add     [bx+si],al
F000:7E99  [+0x0FE99]  00 00                    add     [bx+si],al
F000:7E9B  [+0x0FE9B]  00 00                    add     [bx+si],al
F000:7E9D  [+0x0FE9D]  00 00                    add     [bx+si],al
F000:7E9F  [+0x0FE9F]  00 00                    add     [bx+si],al
F000:7EA1  [+0x0FEA1]  00 00                    add     [bx+si],al
F000:7EA3  [+0x0FEA3]  00 00                    add     [bx+si],al
F000:7EA5  [+0x0FEA5]  00 00                    add     [bx+si],al
F000:7EA7  [+0x0FEA7]  00 00                    add     [bx+si],al
F000:7EA9  [+0x0FEA9]  00 00                    add     [bx+si],al
F000:7EAB  [+0x0FEAB]  00 00                    add     [bx+si],al
F000:7EAD  [+0x0FEAD]  00 00                    add     [bx+si],al
F000:7EAF  [+0x0FEAF]  00 00                    add     [bx+si],al
F000:7EB1  [+0x0FEB1]  00 00                    add     [bx+si],al
F000:7EB3  [+0x0FEB3]  00 00                    add     [bx+si],al
F000:7EB5  [+0x0FEB5]  00 00                    add     [bx+si],al
F000:7EB7  [+0x0FEB7]  00 00                    add     [bx+si],al
F000:7EB9  [+0x0FEB9]  00 00                    add     [bx+si],al
F000:7EBB  [+0x0FEBB]  00 00                    add     [bx+si],al
F000:7EBD  [+0x0FEBD]  00 00                    add     [bx+si],al
F000:7EBF  [+0x0FEBF]  00 00                    add     [bx+si],al
F000:7EC1  [+0x0FEC1]  00 00                    add     [bx+si],al
F000:7EC3  [+0x0FEC3]  00 00                    add     [bx+si],al
F000:7EC5  [+0x0FEC5]  00 00                    add     [bx+si],al
F000:7EC7  [+0x0FEC7]  00 00                    add     [bx+si],al
F000:7EC9  [+0x0FEC9]  00 00                    add     [bx+si],al
F000:7ECB  [+0x0FECB]  00 00                    add     [bx+si],al
F000:7ECD  [+0x0FECD]  00 00                    add     [bx+si],al
F000:7ECF  [+0x0FECF]  00 00                    add     [bx+si],al
F000:7ED1  [+0x0FED1]  00 00                    add     [bx+si],al
F000:7ED3  [+0x0FED3]  00 00                    add     [bx+si],al
F000:7ED5  [+0x0FED5]  00 00                    add     [bx+si],al
F000:7ED7  [+0x0FED7]  00 00                    add     [bx+si],al
F000:7ED9  [+0x0FED9]  00 00                    add     [bx+si],al
F000:7EDB  [+0x0FEDB]  00 00                    add     [bx+si],al
F000:7EDD  [+0x0FEDD]  00 00                    add     [bx+si],al
F000:7EDF  [+0x0FEDF]  00 00                    add     [bx+si],al
F000:7EE1  [+0x0FEE1]  00 00                    add     [bx+si],al
F000:7EE3  [+0x0FEE3]  00 00                    add     [bx+si],al
F000:7EE5  [+0x0FEE5]  00 00                    add     [bx+si],al
F000:7EE7  [+0x0FEE7]  00 00                    add     [bx+si],al
F000:7EE9  [+0x0FEE9]  00 00                    add     [bx+si],al
F000:7EEB  [+0x0FEEB]  00 00                    add     [bx+si],al
F000:7EED  [+0x0FEED]  00 00                    add     [bx+si],al
F000:7EEF  [+0x0FEEF]  00 00                    add     [bx+si],al
F000:7EF1  [+0x0FEF1]  00 00                    add     [bx+si],al
F000:7EF3  [+0x0FEF3]  00 00                    add     [bx+si],al
F000:7EF5  [+0x0FEF5]  00 00                    add     [bx+si],al
F000:7EF7  [+0x0FEF7]  00 00                    add     [bx+si],al
F000:7EF9  [+0x0FEF9]  00 00                    add     [bx+si],al
F000:7EFB  [+0x0FEFB]  00 00                    add     [bx+si],al
F000:7EFD  [+0x0FEFD]  00 00                    add     [bx+si],al
F000:7EFF  [+0x0FEFF]  00 00                    add     [bx+si],al
F000:7F01  [+0x0FF01]  00 00                    add     [bx+si],al
F000:7F03  [+0x0FF03]  00 00                    add     [bx+si],al
F000:7F05  [+0x0FF05]  00 00                    add     [bx+si],al
F000:7F07  [+0x0FF07]  00 00                    add     [bx+si],al
F000:7F09  [+0x0FF09]  00 00                    add     [bx+si],al
F000:7F0B  [+0x0FF0B]  00 00                    add     [bx+si],al
F000:7F0D  [+0x0FF0D]  00 00                    add     [bx+si],al
F000:7F0F  [+0x0FF0F]  00 00                    add     [bx+si],al
F000:7F11  [+0x0FF11]  00 00                    add     [bx+si],al
F000:7F13  [+0x0FF13]  00 00                    add     [bx+si],al
F000:7F15  [+0x0FF15]  00 00                    add     [bx+si],al
F000:7F17  [+0x0FF17]  00 00                    add     [bx+si],al
F000:7F19  [+0x0FF19]  00 00                    add     [bx+si],al
F000:7F1B  [+0x0FF1B]  00 00                    add     [bx+si],al
F000:7F1D  [+0x0FF1D]  00 00                    add     [bx+si],al
F000:7F1F  [+0x0FF1F]  00 00                    add     [bx+si],al
F000:7F21  [+0x0FF21]  00 00                    add     [bx+si],al
F000:7F23  [+0x0FF23]  00 00                    add     [bx+si],al
F000:7F25  [+0x0FF25]  00 00                    add     [bx+si],al
F000:7F27  [+0x0FF27]  00 00                    add     [bx+si],al
F000:7F29  [+0x0FF29]  00 00                    add     [bx+si],al
F000:7F2B  [+0x0FF2B]  00 00                    add     [bx+si],al
F000:7F2D  [+0x0FF2D]  00 00                    add     [bx+si],al
F000:7F2F  [+0x0FF2F]  00 00                    add     [bx+si],al
F000:7F31  [+0x0FF31]  00 00                    add     [bx+si],al
F000:7F33  [+0x0FF33]  00 00                    add     [bx+si],al
F000:7F35  [+0x0FF35]  00 00                    add     [bx+si],al
F000:7F37  [+0x0FF37]  00 00                    add     [bx+si],al
F000:7F39  [+0x0FF39]  00 00                    add     [bx+si],al
F000:7F3B  [+0x0FF3B]  00 00                    add     [bx+si],al
F000:7F3D  [+0x0FF3D]  00 00                    add     [bx+si],al
F000:7F3F  [+0x0FF3F]  00 00                    add     [bx+si],al
F000:7F41  [+0x0FF41]  00 00                    add     [bx+si],al
F000:7F43  [+0x0FF43]  00 00                    add     [bx+si],al
F000:7F45  [+0x0FF45]  00 00                    add     [bx+si],al
F000:7F47  [+0x0FF47]  00 00                    add     [bx+si],al
F000:7F49  [+0x0FF49]  00 00                    add     [bx+si],al
F000:7F4B  [+0x0FF4B]  00 00                    add     [bx+si],al
F000:7F4D  [+0x0FF4D]  00 00                    add     [bx+si],al
F000:7F4F  [+0x0FF4F]  00 00                    add     [bx+si],al
F000:7F51  [+0x0FF51]  00 00                    add     [bx+si],al
F000:7F53  [+0x0FF53]  00 00                    add     [bx+si],al
F000:7F55  [+0x0FF55]  00 00                    add     [bx+si],al
F000:7F57  [+0x0FF57]  00 00                    add     [bx+si],al
F000:7F59  [+0x0FF59]  00 00                    add     [bx+si],al
F000:7F5B  [+0x0FF5B]  00 00                    add     [bx+si],al
F000:7F5D  [+0x0FF5D]  00 00                    add     [bx+si],al
F000:7F5F  [+0x0FF5F]  00 00                    add     [bx+si],al
F000:7F61  [+0x0FF61]  00 00                    add     [bx+si],al
F000:7F63  [+0x0FF63]  00 00                    add     [bx+si],al
F000:7F65  [+0x0FF65]  00 00                    add     [bx+si],al
F000:7F67  [+0x0FF67]  00 00                    add     [bx+si],al
F000:7F69  [+0x0FF69]  00 00                    add     [bx+si],al
F000:7F6B  [+0x0FF6B]  00 00                    add     [bx+si],al
F000:7F6D  [+0x0FF6D]  00 00                    add     [bx+si],al
F000:7F6F  [+0x0FF6F]  00 00                    add     [bx+si],al
F000:7F71  [+0x0FF71]  00 00                    add     [bx+si],al
F000:7F73  [+0x0FF73]  00 00                    add     [bx+si],al
F000:7F75  [+0x0FF75]  00 00                    add     [bx+si],al
F000:7F77  [+0x0FF77]  00 00                    add     [bx+si],al
F000:7F79  [+0x0FF79]  00 00                    add     [bx+si],al
F000:7F7B  [+0x0FF7B]  00 00                    add     [bx+si],al
F000:7F7D  [+0x0FF7D]  00 00                    add     [bx+si],al
F000:7F7F  [+0x0FF7F]  00 00                    add     [bx+si],al
F000:7F81  [+0x0FF81]  00 00                    add     [bx+si],al
F000:7F83  [+0x0FF83]  00 00                    add     [bx+si],al
F000:7F85  [+0x0FF85]  00 00                    add     [bx+si],al
F000:7F87  [+0x0FF87]  00 00                    add     [bx+si],al
F000:7F89  [+0x0FF89]  00 00                    add     [bx+si],al
F000:7F8B  [+0x0FF8B]  00 00                    add     [bx+si],al
F000:7F8D  [+0x0FF8D]  00 00                    add     [bx+si],al
F000:7F8F  [+0x0FF8F]  00 00                    add     [bx+si],al
F000:7F91  [+0x0FF91]  00 00                    add     [bx+si],al
F000:7F93  [+0x0FF93]  00 00                    add     [bx+si],al
F000:7F95  [+0x0FF95]  00 00                    add     [bx+si],al
F000:7F97  [+0x0FF97]  00 00                    add     [bx+si],al
F000:7F99  [+0x0FF99]  00 00                    add     [bx+si],al
F000:7F9B  [+0x0FF9B]  00 00                    add     [bx+si],al
F000:7F9D  [+0x0FF9D]  00 00                    add     [bx+si],al
F000:7F9F  [+0x0FF9F]  00 00                    add     [bx+si],al
F000:7FA1  [+0x0FFA1]  00 00                    add     [bx+si],al
F000:7FA3  [+0x0FFA3]  00 00                    add     [bx+si],al
F000:7FA5  [+0x0FFA5]  00 00                    add     [bx+si],al
F000:7FA7  [+0x0FFA7]  00 00                    add     [bx+si],al
F000:7FA9  [+0x0FFA9]  00 00                    add     [bx+si],al
F000:7FAB  [+0x0FFAB]  00 00                    add     [bx+si],al
F000:7FAD  [+0x0FFAD]  00 00                    add     [bx+si],al
F000:7FAF  [+0x0FFAF]  00 00                    add     [bx+si],al
F000:7FB1  [+0x0FFB1]  00 00                    add     [bx+si],al
F000:7FB3  [+0x0FFB3]  00 00                    add     [bx+si],al
F000:7FB5  [+0x0FFB5]  00 00                    add     [bx+si],al
F000:7FB7  [+0x0FFB7]  00 00                    add     [bx+si],al
F000:7FB9  [+0x0FFB9]  00 00                    add     [bx+si],al
F000:7FBB  [+0x0FFBB]  00 00                    add     [bx+si],al
F000:7FBD  [+0x0FFBD]  00 00                    add     [bx+si],al
F000:7FBF  [+0x0FFBF]  00 00                    add     [bx+si],al
F000:7FC1  [+0x0FFC1]  00 00                    add     [bx+si],al
F000:7FC3  [+0x0FFC3]  00 00                    add     [bx+si],al
F000:7FC5  [+0x0FFC5]  00 00                    add     [bx+si],al
F000:7FC7  [+0x0FFC7]  00 00                    add     [bx+si],al
F000:7FC9  [+0x0FFC9]  00 00                    add     [bx+si],al
F000:7FCB  [+0x0FFCB]  00 00                    add     [bx+si],al
F000:7FCD  [+0x0FFCD]  00 00                    add     [bx+si],al
F000:7FCF  [+0x0FFCF]  00 00                    add     [bx+si],al
F000:7FD1  [+0x0FFD1]  00 00                    add     [bx+si],al
F000:7FD3  [+0x0FFD3]  00 00                    add     [bx+si],al
F000:7FD5  [+0x0FFD5]  00 00                    add     [bx+si],al
F000:7FD7  [+0x0FFD7]  00 00                    add     [bx+si],al
F000:7FD9  [+0x0FFD9]  00 00                    add     [bx+si],al
F000:7FDB  [+0x0FFDB]  00 00                    add     [bx+si],al
F000:7FDD  [+0x0FFDD]  00 00                    add     [bx+si],al
F000:7FDF  [+0x0FFDF]  00 00                    add     [bx+si],al
F000:7FE1  [+0x0FFE1]  00 00                    add     [bx+si],al
F000:7FE3  [+0x0FFE3]  00 00                    add     [bx+si],al
F000:7FE5  [+0x0FFE5]  00 00                    add     [bx+si],al
F000:7FE7  [+0x0FFE7]  00 00                    add     [bx+si],al
F000:7FE9  [+0x0FFE9]  00 00                    add     [bx+si],al
F000:7FEB  [+0x0FFEB]  00 00                    add     [bx+si],al
F000:7FED  [+0x0FFED]  00 00                    add     [bx+si],al
F000:7FEF  [+0x0FFEF]  00 00                    add     [bx+si],al
F000:7FF1  [+0x0FFF1]  00 00                    add     [bx+si],al
F000:7FF3  [+0x0FFF3]  00 00                    add     [bx+si],al
F000:7FF5  [+0x0FFF5]  00 00                    add     [bx+si],al
F000:7FF7  [+0x0FFF7]  00 00                    add     [bx+si],al
F000:7FF9  [+0x0FFF9]  00 00                    add     [bx+si],al
F000:7FFB  [+0x0FFFB]  00 00                    add     [bx+si],al
F000:7FFD  [+0x0FFFD]  00 00                    add     [bx+si],al
F000:7FFF  [+0x0FFFF]  DB 0x00  (bad)
