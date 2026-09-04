; VGA BIOS option ROM module (Chips & Technologies 65535, v2.0.0, 1994)
; File offsets 0x00000-0x07FFF. Runs from segment C000 (copied there by system POST
; from its home at E000 in the flash chip) or directly from E000 depending on chipset decode.
; NOTE: address prefix below is a raw IP counter from file start, NOT a confirmed CS value -
; treat 'F000:' labels in this file as '<segment>:' placeholders, real segment is C000/E000.
; Linear disassembly - data regions (tables/strings) will show as nonsense instructions.
;
F000:0000  [+0x00000]  55                       push    bp
F000:0001  [+0x00001]  AA                       stosb
F000:0002  [+0x00002]  40                       inc     ax
F000:0003  [+0x00003]  EB 3F                    jmp     short 0044h
F000:0005  [+0x00005]  37                       aaa
F000:0006  [+0x00006]  34 30                    xor     al,30h
F000:0008  [+0x00008]  30 30                    xor     [bx+si],dh
F000:000A  [+0x0000A]  30 30                    xor     [bx+si],dh
F000:000C  [+0x0000C]  30 30                    xor     [bx+si],dh
F000:000E  [+0x0000E]  30 30                    xor     [bx+si],dh
F000:0010  [+0x00010]  30 30                    xor     [bx+si],dh
F000:0012  [+0x00012]  30 30                    xor     [bx+si],dh
F000:0014  [+0x00014]  30 30                    xor     [bx+si],dh
F000:0016  [+0x00016]  30 30                    xor     [bx+si],dh
F000:0018  [+0x00018]  30 30                    xor     [bx+si],dh
F000:001A  [+0x0001A]  30 30                    xor     [bx+si],dh
F000:001C  [+0x0001C]  30 30                    xor     [bx+si],dh
F000:001E  [+0x0001E]  49                       dec     cx
F000:001F  [+0x0001F]  42                       inc     dx
F000:0020  [+0x00020]  4D                       dec     bp
F000:0021  [+0x00021]  20 56 47                 and     [bp+47h],dl
F000:0024  [+0x00024]  41                       inc     cx
F000:0025  [+0x00025]  20 43 6F                 and     [bp+di+6Fh],al
F000:0028  [+0x00028]  6D                       insw
F000:0029  [+0x00029]  70 61                    jo      short 008Ch
F000:002B  [+0x0002B]  74 69                    je      short 0096h
F000:002D  [+0x0002D]  62 6C 65                 bound   bp,[si+65h]
F000:0030  [+0x00030]  20 42 49                 and     [bp+si+49h],al
F000:0033  [+0x00033]  4F                       dec     di
F000:0034  [+0x00034]  53                       push    bx
F000:0035  [+0x00035]  2E 20 34                 and     [cs:si],dh
F000:0038  [+0x00038]  1A 05                    sbb     al,[di]
F000:003A  [+0x0003A]  81 00 A0 01              add     word [bx+si],1A0h
F000:003E  [+0x0003E]  B0 01                    mov     al,1
F000:0040  [+0x00040]  BE 01 D4                 mov     si,0D401h
F000:0043  [+0x00043]  01 E9                    add     cx,bp
F000:0045  [+0x00045]  36 26 86 D0              xchg    dl,al
F000:0049  [+0x00049]  D2 E0                    shl     al,cl
F000:004B  [+0x0004B]  E6 40                    out     40h,al
F000:004D  [+0x0004D]  C2 DC C8                 ret     0C8DCh
F000:0050  [+0x00050]  40                       inc     ax
F000:0051  [+0x00051]  A8 CA                    test    al,0CAh
F000:0053  [+0x00053]  DB 0xC6  (bad)
F000:0055  [+0x00055]  DC DE                    fcomp   st6
F000:0057  [+0x00057]  D8 DE                    fcomp   st6
F000:0059  [+0x00059]  CE                       into
F000:005A  [+0x0005A]  D2 CA                    ror     dl,cl
F000:005C  [+0x0005C]  E6 58                    out     58h,al
F000:005E  [+0x0005E]  40                       inc     ax
F000:005F  [+0x0005F]  92                       xchg    dx,ax
F000:0060  [+0x00060]  DC C6                    fadd    to st6
F000:0062  [+0x00062]  5C                       pop     sp
F000:0063  [+0x00063]  00 FF                    add     bh,bh
F000:0065  [+0x00065]  01 00                    add     [bx+si],ax
F000:0067  [+0x00067]  43                       inc     bx
F000:0068  [+0x00068]  04 0B                    add     al,0Bh
F000:006A  [+0x0006A]  7C 00                    jl      short 006Ch
F000:006C  [+0x0006C]  00 43 51                 add     [bp+di+51h],al
F000:006F  [+0x0006F]  00 00                    add     [bx+si],al
F000:0071  [+0x00071]  00 00                    add     [bx+si],al
F000:0073  [+0x00073]  07                       pop     es
F000:0074  [+0x00074]  05 CA 07                 add     ax,7CAh
F000:0077  [+0x00077]  0C 11                    or      al,11h
F000:0079  [+0x00079]  31 0A                    xor     [bp+si],cx
F000:007B  [+0x0007B]  00 A0 77 00              add     [bx+si+77h],ah
F000:007F  [+0x0007F]  47                       inc     di
F000:0080  [+0x00080]  00 00                    add     [bx+si],al
F000:0082  [+0x00082]  C0 00 80                 rol     byte [bx+si],80h
F000:0085  [+0x00085]  00 00                    add     [bx+si],al
F000:0087  [+0x00087]  47                       inc     di
F000:0088  [+0x00088]  00 00                    add     [bx+si],al
F000:008A  [+0x0008A]  00 45 2C                 add     [di+2Ch],al
F000:008D  [+0x0008D]  43                       inc     bx
F000:008E  [+0x0008E]  68 69 70                 push    7069h
F000:0091  [+0x00091]  73 20                    jae     short 00B3h
F000:0093  [+0x00093]  36 35 35 33              xor     ax,3335h
F000:0097  [+0x00097]  35 2F 41                 xor     ax,412Fh
F000:009A  [+0x0009A]  20 56 47                 and     [bp+47h],dl
F000:009D  [+0x0009D]  41                       inc     cx
F000:009E  [+0x0009E]  20 33                    and     [bp+di],dh
F000:00A0  [+0x000A0]  32 4B 42                 xor     cl,[bp+di+42h]
F000:00A3  [+0x000A3]  20 42 49                 and     [bp+si+49h],al
F000:00A6  [+0x000A6]  4F                       dec     di
F000:00A7  [+0x000A7]  53                       push    bx
F000:00A8  [+0x000A8]  0D 0A 56                 or      ax,560Ah
F000:00AB  [+0x000AB]  65 72 73                 jb      short 0121h
F000:00AE  [+0x000AE]  69 6F 6E 20 32           imul    bp,[bx+6Eh],3220h
F000:00B3  [+0x000B3]  2E 30 2E 30 0D           xor     [cs:0D30h],ch
F000:00B8  [+0x000B8]  0A 00                    or      al,[bx+si]
F000:00BA  [+0x000BA]  00 00                    add     [bx+si],al
F000:00BC  [+0x000BC]  00 00                    add     [bx+si],al
F000:00BE  [+0x000BE]  00 00                    add     [bx+si],al
F000:00C0  [+0x000C0]  00 00                    add     [bx+si],al
F000:00C2  [+0x000C2]  00 00                    add     [bx+si],al
F000:00C4  [+0x000C4]  00 00                    add     [bx+si],al
F000:00C6  [+0x000C6]  00 00                    add     [bx+si],al
F000:00C8  [+0x000C8]  00 00                    add     [bx+si],al
F000:00CA  [+0x000CA]  00 00                    add     [bx+si],al
F000:00CC  [+0x000CC]  00 00                    add     [bx+si],al
F000:00CE  [+0x000CE]  00 00                    add     [bx+si],al
F000:00D0  [+0x000D0]  00 00                    add     [bx+si],al
F000:00D2  [+0x000D2]  00 00                    add     [bx+si],al
F000:00D4  [+0x000D4]  00 00                    add     [bx+si],al
F000:00D6  [+0x000D6]  00 00                    add     [bx+si],al
F000:00D8  [+0x000D8]  00 00                    add     [bx+si],al
F000:00DA  [+0x000DA]  00 00                    add     [bx+si],al
F000:00DC  [+0x000DC]  00 00                    add     [bx+si],al
F000:00DE  [+0x000DE]  00 00                    add     [bx+si],al
F000:00E0  [+0x000E0]  00 00                    add     [bx+si],al
F000:00E2  [+0x000E2]  00 00                    add     [bx+si],al
F000:00E4  [+0x000E4]  00 00                    add     [bx+si],al
F000:00E6  [+0x000E6]  00 00                    add     [bx+si],al
F000:00E8  [+0x000E8]  00 00                    add     [bx+si],al
F000:00EA  [+0x000EA]  00 00                    add     [bx+si],al
F000:00EC  [+0x000EC]  00 00                    add     [bx+si],al
F000:00EE  [+0x000EE]  00 00                    add     [bx+si],al
F000:00F0  [+0x000F0]  00 00                    add     [bx+si],al
F000:00F2  [+0x000F2]  00 00                    add     [bx+si],al
F000:00F4  [+0x000F4]  00 00                    add     [bx+si],al
F000:00F6  [+0x000F6]  00 00                    add     [bx+si],al
F000:00F8  [+0x000F8]  00 00                    add     [bx+si],al
F000:00FA  [+0x000FA]  00 00                    add     [bx+si],al
F000:00FC  [+0x000FC]  00 00                    add     [bx+si],al
F000:00FE  [+0x000FE]  00 00                    add     [bx+si],al
F000:0100  [+0x00100]  00 00                    add     [bx+si],al
F000:0102  [+0x00102]  00 00                    add     [bx+si],al
F000:0104  [+0x00104]  00 00                    add     [bx+si],al
F000:0106  [+0x00106]  00 00                    add     [bx+si],al
F000:0108  [+0x00108]  00 00                    add     [bx+si],al
F000:010A  [+0x0010A]  00 00                    add     [bx+si],al
F000:010C  [+0x0010C]  00 00                    add     [bx+si],al
F000:010E  [+0x0010E]  00 00                    add     [bx+si],al
F000:0110  [+0x00110]  00 00                    add     [bx+si],al
F000:0112  [+0x00112]  00 00                    add     [bx+si],al
F000:0114  [+0x00114]  00 00                    add     [bx+si],al
F000:0116  [+0x00116]  00 00                    add     [bx+si],al
F000:0118  [+0x00118]  00 00                    add     [bx+si],al
F000:011A  [+0x0011A]  00 00                    add     [bx+si],al
F000:011C  [+0x0011C]  00 00                    add     [bx+si],al
F000:011E  [+0x0011E]  00 00                    add     [bx+si],al
F000:0120  [+0x00120]  00 00                    add     [bx+si],al
F000:0122  [+0x00122]  00 00                    add     [bx+si],al
F000:0124  [+0x00124]  00 00                    add     [bx+si],al
F000:0126  [+0x00126]  00 00                    add     [bx+si],al
F000:0128  [+0x00128]  00 00                    add     [bx+si],al
F000:012A  [+0x0012A]  00 43 6F                 add     [bp+di+6Fh],al
F000:012D  [+0x0012D]  70 79                    jo      short 01A8h
F000:012F  [+0x0012F]  72 69                    jb      short 019Ah
F000:0131  [+0x00131]  67 68 74 20              push    2074h
F000:0135  [+0x00135]  28 43 29                 sub     [bp+di+29h],al
F000:0138  [+0x00138]  20 31                    and     [bx+di],dh
F000:013A  [+0x0013A]  39 39                    cmp     [bx+di],di
F000:013C  [+0x0013C]  34 20                    xor     al,20h
F000:013E  [+0x0013E]  43                       inc     bx
F000:013F  [+0x0013F]  68 69 70                 push    7069h
F000:0142  [+0x00142]  73 20                    jae     short 0164h
F000:0144  [+0x00144]  61                       popa
F000:0145  [+0x00145]  6E                       outsb
F000:0146  [+0x00146]  64 20 54 65              and     [fs:si+65h],dl
F000:014A  [+0x0014A]  63 68 6E                 arpl    [bx+si+6Eh],bp
F000:014D  [+0x0014D]  6F                       outsw
F000:014E  [+0x0014E]  6C                       insb
F000:014F  [+0x0014F]  6F                       outsw
F000:0150  [+0x00150]  67 69 65 73 2C 20        imul    sp,[ebp+73h],202Ch
F000:0156  [+0x00156]  49                       dec     cx
F000:0157  [+0x00157]  6E                       outsb
F000:0158  [+0x00158]  63 2E 20 20              arpl    [2020h],bp
F000:015C  [+0x0015C]  41                       inc     cx
F000:015D  [+0x0015D]  6C                       insb
F000:015E  [+0x0015E]  6C                       insb
F000:015F  [+0x0015F]  20 52 69                 and     [bp+si+69h],dl
F000:0162  [+0x00162]  67 68 74 73              push    7374h
F000:0166  [+0x00166]  20 52 65                 and     [bp+si+65h],dl
F000:0169  [+0x00169]  73 65                    jae     short 01D0h
F000:016B  [+0x0016B]  72 76                    jb      short 01E3h
F000:016D  [+0x0016D]  65 64 2E 0D 0A 0D        or      ax,0D0Ah
F000:0173  [+0x00173]  0A 00                    or      al,[bx+si]
F000:0175  [+0x00175]  00 00                    add     [bx+si],al
F000:0177  [+0x00177]  00 00                    add     [bx+si],al
F000:0179  [+0x00179]  00 00                    add     [bx+si],al
F000:017B  [+0x0017B]  32 00                    xor     al,[bx+si]
F000:017D  [+0x0017D]  61                       popa
F000:017E  [+0x0017E]  12 E1                    adc     ah,cl
F000:0180  [+0x00180]  05 00 41                 add     ax,4100h
F000:0183  [+0x00183]  41                       inc     cx
F000:0184  [+0x00184]  41                       inc     cx
F000:0185  [+0x00185]  00 04                    add     [si],al
F000:0187  [+0x00187]  01 16 4A 18              add     [184Ah],dx
F000:018B  [+0x0018B]  4C                       dec     sp
F000:018C  [+0x0018C]  28 32                    sub     [bp+si],dh
F000:018E  [+0x0018E]  41                       inc     cx
F000:018F  [+0x0018F]  3C 41                    cmp     al,41h
F000:0191  [+0x00191]  41                       inc     cx
F000:0192  [+0x00192]  14 41                    adc     al,41h
F000:0194  [+0x00194]  60                       pusha
F000:0195  [+0x00195]  41                       inc     cx
F000:0196  [+0x00196]  18 06 02 40              sbb     [4002h],al
F000:019A  [+0x0019A]  10 03                    adc     [bp+di],al
F000:019C  [+0x0019C]  00 00                    add     [bx+si],al
F000:019E  [+0x0019E]  1C 02                    sbb     al,2
F000:01A0  [+0x001A0]  00 E0                    add     al,ah
F000:01A2  [+0x001A2]  00 00                    add     [bx+si],al
F000:01A4  [+0x001A4]  00 00                    add     [bx+si],al
F000:01A6  [+0x001A6]  00 00                    add     [bx+si],al
F000:01A8  [+0x001A8]  00 00                    add     [bx+si],al
F000:01AA  [+0x001AA]  00 00                    add     [bx+si],al
F000:01AC  [+0x001AC]  00 00                    add     [bx+si],al
F000:01AE  [+0x001AE]  BA 01 00                 mov     dx,1
F000:01B1  [+0x001B1]  E0 00                    loopne  01B3h
F000:01B3  [+0x001B3]  00 00                    add     [bx+si],al
F000:01B5  [+0x001B5]  00 00                    add     [bx+si],al
F000:01B7  [+0x001B7]  00 00                    add     [bx+si],al
F000:01B9  [+0x001B9]  00 1A                    add     [bp+si],bl
F000:01BB  [+0x001BB]  00 86 7E 00              add     [bp+7Eh],al
F000:01BF  [+0x001BF]  E0 00                    loopne  01C1h
F000:01C1  [+0x001C1]  00 00                    add     [bx+si],al
F000:01C3  [+0x001C3]  00 00                    add     [bx+si],al
F000:01C5  [+0x001C5]  00 00                    add     [bx+si],al
F000:01C7  [+0x001C7]  00 00                    add     [bx+si],al
F000:01C9  [+0x001C9]  00 00                    add     [bx+si],al
F000:01CB  [+0x001CB]  00 00                    add     [bx+si],al
F000:01CD  [+0x001CD]  00 00                    add     [bx+si],al
F000:01CF  [+0x001CF]  00 00                    add     [bx+si],al
F000:01D1  [+0x001D1]  00 00                    add     [bx+si],al
F000:01D3  [+0x001D3]  00 00                    add     [bx+si],al
F000:01D5  [+0x001D5]  C0 80 02 E0 01           rol     byte [bx+si-1FFEh],1
F000:01DA  [+0x001DA]  01 4B 0B                 add     [bp+di+0Bh],cx
F000:01DD  [+0x001DD]  30 00                    xor     [bx+si],al
F000:01DF  [+0x001DF]  31 00                    xor     [bx+si],ax
F000:01E1  [+0x001E1]  AD                       lodsw
F000:01E2  [+0x001E2]  0B 05                    or      ax,[di]
F000:01E4  [+0x001E4]  00 05                    add     [di],al
F000:01E6  [+0x001E6]  00 B9 0B 12              add     [bx+di+120Bh],bh
F000:01EA  [+0x001EA]  00 12                    add     [bp+si],dl
F000:01EC  [+0x001EC]  00 B7 0B 01              add     [bx+10Bh],dh
F000:01F0  [+0x001F0]  00 01                    add     [bx+di],al
F000:01F2  [+0x001F2]  00 DD                    add     ch,bl
F000:01F4  [+0x001F4]  0B 13                    or      dx,[bp+di]
F000:01F6  [+0x001F6]  00 13                    add     [bp+di],dl
F000:01F8  [+0x001F8]  00 03                    add     [bp+di],al
F000:01FA  [+0x001FA]  0C 13                    or      al,13h
F000:01FC  [+0x001FC]  00 13                    add     [bp+di],dl
F000:01FE  [+0x001FE]  00 29                    add     [bx+di],ch
F000:0200  [+0x00200]  0C 00                    or      al,0
F000:0202  [+0x00202]  00 00                    add     [bx+si],al
F000:0204  [+0x00204]  00 29                    add     [bx+di],ch
F000:0206  [+0x00206]  0C 00                    or      al,0
F000:0208  [+0x00208]  00 00                    add     [bx+si],al
F000:020A  [+0x0020A]  00 29                    add     [bx+di],ch
F000:020C  [+0x0020C]  0C 00                    or      al,0
F000:020E  [+0x0020E]  00 00                    add     [bx+si],al
F000:0210  [+0x00210]  00 00                    add     [bx+si],al
F000:0212  [+0x00212]  00 16 4A 00              add     [4Ah],dl
F000:0216  [+0x00216]  00 00                    add     [bx+si],al
F000:0218  [+0x00218]  00 87 DB 90              add     [bx-6F25h],al
F000:021C  [+0x0021C]  28 18                    sub     [bx+si],bl
F000:021E  [+0x0021E]  08 00                    or      [bx+si],al
F000:0220  [+0x00220]  08 09                    or      [bx+di],cl
F000:0222  [+0x00222]  03 00                    add     ax,[bx+si]
F000:0224  [+0x00224]  02 63 2D                 add     ah,[bp+di+2Dh]
F000:0227  [+0x00227]  27                       daa
F000:0228  [+0x00228]  28 90 2B A0              sub     [bx+si-5FD5h],dl
F000:022C  [+0x0022C]  BF 1F 00                 mov     di,1Fh
F000:022F  [+0x0022F]  C7 06 07 00 00 00        mov     word [7],0
F000:0235  [+0x00235]  00 9C 8E 8F              add     [si-7072h],bl
F000:0239  [+0x00239]  14 1F                    adc     al,1Fh
F000:023B  [+0x0023B]  96                       xchg    si,ax
F000:023C  [+0x0023C]  B9 A3 FF                 mov     cx,0FFA3h
F000:023F  [+0x0023F]  00 01                    add     [bx+di],al
F000:0241  [+0x00241]  02 03                    add     al,[bp+di]
F000:0243  [+0x00243]  04 05                    add     al,5
F000:0245  [+0x00245]  06                       push    es
F000:0246  [+0x00246]  07                       pop     es
F000:0247  [+0x00247]  10 11                    adc     [bx+di],dl
F000:0249  [+0x00249]  12 13                    adc     dl,[bp+di]
F000:024B  [+0x0024B]  14 15                    adc     al,15h
F000:024D  [+0x0024D]  16                       push    ss
F000:024E  [+0x0024E]  17                       pop     ss
F000:024F  [+0x0024F]  08 00                    or      [bx+si],al
F000:0251  [+0x00251]  0F 00 00                 sldt    [bx+si]
F000:0254  [+0x00254]  00 00                    add     [bx+si],al
F000:0256  [+0x00256]  00 00                    add     [bx+si],al
F000:0258  [+0x00258]  10 0E 00 FF              adc     [0FF00h],cl
F000:025C  [+0x0025C]  28 18                    sub     [bx+si],bl
F000:025E  [+0x0025E]  08 00                    or      [bx+si],al
F000:0260  [+0x00260]  08 09                    or      [bx+di],cl
F000:0262  [+0x00262]  03 00                    add     ax,[bx+si]
F000:0264  [+0x00264]  02 63 2D                 add     ah,[bp+di+2Dh]
F000:0267  [+0x00267]  27                       daa
F000:0268  [+0x00268]  28 90 2B A0              sub     [bx+si-5FD5h],dl
F000:026C  [+0x0026C]  BF 1F 00                 mov     di,1Fh
F000:026F  [+0x0026F]  C7 06 07 00 00 00        mov     word [7],0
F000:0275  [+0x00275]  00 9C 8E 8F              add     [si-7072h],bl
F000:0279  [+0x00279]  14 1F                    adc     al,1Fh
F000:027B  [+0x0027B]  96                       xchg    si,ax
F000:027C  [+0x0027C]  B9 A3 FF                 mov     cx,0FFA3h
F000:027F  [+0x0027F]  00 01                    add     [bx+di],al
F000:0281  [+0x00281]  02 03                    add     al,[bp+di]
F000:0283  [+0x00283]  04 05                    add     al,5
F000:0285  [+0x00285]  06                       push    es
F000:0286  [+0x00286]  07                       pop     es
F000:0287  [+0x00287]  10 11                    adc     [bx+di],dl
F000:0289  [+0x00289]  12 13                    adc     dl,[bp+di]
F000:028B  [+0x0028B]  14 15                    adc     al,15h
F000:028D  [+0x0028D]  16                       push    ss
F000:028E  [+0x0028E]  17                       pop     ss
F000:028F  [+0x0028F]  08 00                    or      [bx+si],al
F000:0291  [+0x00291]  0F 00 00                 sldt    [bx+si]
F000:0294  [+0x00294]  00 00                    add     [bx+si],al
F000:0296  [+0x00296]  00 00                    add     [bx+si],al
F000:0298  [+0x00298]  10 0E 00 FF              adc     [0FF00h],cl
F000:029C  [+0x0029C]  50                       push    ax
F000:029D  [+0x0029D]  18 08                    sbb     [bx+si],cl
F000:029F  [+0x0029F]  00 10                    add     [bx+si],dl
F000:02A1  [+0x002A1]  01 03                    add     [bp+di],ax
F000:02A3  [+0x002A3]  00 02                    add     [bp+si],al
F000:02A5  [+0x002A5]  63 5F 4F                 arpl    [bx+4Fh],bx
F000:02A8  [+0x002A8]  50                       push    ax
F000:02A9  [+0x002A9]  82 55 81 BF              adc     byte [di-7Fh],0BFh
F000:02AD  [+0x002AD]  1F                       pop     ds
F000:02AE  [+0x002AE]  00 C7                    add     bh,al
F000:02B0  [+0x002B0]  06                       push    es
F000:02B1  [+0x002B1]  07                       pop     es
F000:02B2  [+0x002B2]  00 00                    add     [bx+si],al
F000:02B4  [+0x002B4]  00 00                    add     [bx+si],al
F000:02B6  [+0x002B6]  9C                       pushf
F000:02B7  [+0x002B7]  DB 0x8E  (bad)
F000:02BB  [+0x002BB]  96                       xchg    si,ax
F000:02BC  [+0x002BC]  B9 A3 FF                 mov     cx,0FFA3h
F000:02BF  [+0x002BF]  00 01                    add     [bx+di],al
F000:02C1  [+0x002C1]  02 03                    add     al,[bp+di]
F000:02C3  [+0x002C3]  04 05                    add     al,5
F000:02C5  [+0x002C5]  06                       push    es
F000:02C6  [+0x002C6]  07                       pop     es
F000:02C7  [+0x002C7]  10 11                    adc     [bx+di],dl
F000:02C9  [+0x002C9]  12 13                    adc     dl,[bp+di]
F000:02CB  [+0x002CB]  14 15                    adc     al,15h
F000:02CD  [+0x002CD]  16                       push    ss
F000:02CE  [+0x002CE]  17                       pop     ss
F000:02CF  [+0x002CF]  08 00                    or      [bx+si],al
F000:02D1  [+0x002D1]  0F 00 00                 sldt    [bx+si]
F000:02D4  [+0x002D4]  00 00                    add     [bx+si],al
F000:02D6  [+0x002D6]  00 00                    add     [bx+si],al
F000:02D8  [+0x002D8]  10 0E 00 FF              adc     [0FF00h],cl
F000:02DC  [+0x002DC]  50                       push    ax
F000:02DD  [+0x002DD]  18 08                    sbb     [bx+si],cl
F000:02DF  [+0x002DF]  00 10                    add     [bx+si],dl
F000:02E1  [+0x002E1]  01 03                    add     [bp+di],ax
F000:02E3  [+0x002E3]  00 02                    add     [bp+si],al
F000:02E5  [+0x002E5]  63 5F 4F                 arpl    [bx+4Fh],bx
F000:02E8  [+0x002E8]  50                       push    ax
F000:02E9  [+0x002E9]  82 55 81 BF              adc     byte [di-7Fh],0BFh
F000:02ED  [+0x002ED]  1F                       pop     ds
F000:02EE  [+0x002EE]  00 C7                    add     bh,al
F000:02F0  [+0x002F0]  06                       push    es
F000:02F1  [+0x002F1]  07                       pop     es
F000:02F2  [+0x002F2]  00 00                    add     [bx+si],al
F000:02F4  [+0x002F4]  00 00                    add     [bx+si],al
F000:02F6  [+0x002F6]  9C                       pushf
F000:02F7  [+0x002F7]  DB 0x8E  (bad)
F000:02FB  [+0x002FB]  96                       xchg    si,ax
F000:02FC  [+0x002FC]  B9 A3 FF                 mov     cx,0FFA3h
F000:02FF  [+0x002FF]  00 01                    add     [bx+di],al
F000:0301  [+0x00301]  02 03                    add     al,[bp+di]
F000:0303  [+0x00303]  04 05                    add     al,5
F000:0305  [+0x00305]  06                       push    es
F000:0306  [+0x00306]  07                       pop     es
F000:0307  [+0x00307]  10 11                    adc     [bx+di],dl
F000:0309  [+0x00309]  12 13                    adc     dl,[bp+di]
F000:030B  [+0x0030B]  14 15                    adc     al,15h
F000:030D  [+0x0030D]  16                       push    ss
F000:030E  [+0x0030E]  17                       pop     ss
F000:030F  [+0x0030F]  08 00                    or      [bx+si],al
F000:0311  [+0x00311]  0F 00 00                 sldt    [bx+si]
F000:0314  [+0x00314]  00 00                    add     [bx+si],al
F000:0316  [+0x00316]  00 00                    add     [bx+si],al
F000:0318  [+0x00318]  10 0E 00 FF              adc     [0FF00h],cl
F000:031C  [+0x0031C]  28 18                    sub     [bx+si],bl
F000:031E  [+0x0031E]  08 00                    or      [bx+si],al
F000:0320  [+0x00320]  40                       inc     ax
F000:0321  [+0x00321]  09 03                    or      [bp+di],ax
F000:0323  [+0x00323]  00 02                    add     [bp+si],al
F000:0325  [+0x00325]  63 2D                    arpl    [di],bp
F000:0327  [+0x00327]  27                       daa
F000:0328  [+0x00328]  28 90 2B 80              sub     [bx+si-7FD5h],dl
F000:032C  [+0x0032C]  BF 1F 00                 mov     di,1Fh
F000:032F  [+0x0032F]  C1 00 00                 rol     word [bx+si],0
F000:0332  [+0x00332]  00 00                    add     [bx+si],al
F000:0334  [+0x00334]  00 00                    add     [bx+si],al
F000:0336  [+0x00336]  9C                       pushf
F000:0337  [+0x00337]  DB 0x8E  (bad)
F000:033B  [+0x0033B]  96                       xchg    si,ax
F000:033C  [+0x0033C]  B9 A2 FF                 mov     cx,0FFA2h
F000:033F  [+0x0033F]  00 13                    add     [bp+di],dl
F000:0341  [+0x00341]  15 17 02                 adc     ax,217h
F000:0344  [+0x00344]  04 06                    add     al,6
F000:0346  [+0x00346]  07                       pop     es
F000:0347  [+0x00347]  10 11                    adc     [bx+di],dl
F000:0349  [+0x00349]  12 13                    adc     dl,[bp+di]
F000:034B  [+0x0034B]  14 15                    adc     al,15h
F000:034D  [+0x0034D]  16                       push    ss
F000:034E  [+0x0034E]  17                       pop     ss
F000:034F  [+0x0034F]  01 00                    add     [bx+si],ax
F000:0351  [+0x00351]  03 00                    add     ax,[bx+si]
F000:0353  [+0x00353]  00 00                    add     [bx+si],al
F000:0355  [+0x00355]  00 00                    add     [bx+si],al
F000:0357  [+0x00357]  00 30                    add     [bx+si],dh
F000:0359  [+0x00359]  DB 0x0F  (bad)
F000:035C  [+0x0035C]  28 18                    sub     [bx+si],bl
F000:035E  [+0x0035E]  08 00                    or      [bx+si],al
F000:0360  [+0x00360]  40                       inc     ax
F000:0361  [+0x00361]  09 03                    or      [bp+di],ax
F000:0363  [+0x00363]  00 02                    add     [bp+si],al
F000:0365  [+0x00365]  63 2D                    arpl    [di],bp
F000:0367  [+0x00367]  27                       daa
F000:0368  [+0x00368]  28 90 2B 80              sub     [bx+si-7FD5h],dl
F000:036C  [+0x0036C]  BF 1F 00                 mov     di,1Fh
F000:036F  [+0x0036F]  C1 00 00                 rol     word [bx+si],0
F000:0372  [+0x00372]  00 00                    add     [bx+si],al
F000:0374  [+0x00374]  00 00                    add     [bx+si],al
F000:0376  [+0x00376]  9C                       pushf
F000:0377  [+0x00377]  DB 0x8E  (bad)
F000:037B  [+0x0037B]  96                       xchg    si,ax
F000:037C  [+0x0037C]  B9 A2 FF                 mov     cx,0FFA2h
F000:037F  [+0x0037F]  00 13                    add     [bp+di],dl
F000:0381  [+0x00381]  15 17 02                 adc     ax,217h
F000:0384  [+0x00384]  04 06                    add     al,6
F000:0386  [+0x00386]  07                       pop     es
F000:0387  [+0x00387]  10 11                    adc     [bx+di],dl
F000:0389  [+0x00389]  12 13                    adc     dl,[bp+di]
F000:038B  [+0x0038B]  14 15                    adc     al,15h
F000:038D  [+0x0038D]  16                       push    ss
F000:038E  [+0x0038E]  17                       pop     ss
F000:038F  [+0x0038F]  01 00                    add     [bx+si],ax
F000:0391  [+0x00391]  03 00                    add     ax,[bx+si]
F000:0393  [+0x00393]  00 00                    add     [bx+si],al
F000:0395  [+0x00395]  00 00                    add     [bx+si],al
F000:0397  [+0x00397]  00 30                    add     [bx+si],dh
F000:0399  [+0x00399]  DB 0x0F  (bad)
F000:039C  [+0x0039C]  50                       push    ax
F000:039D  [+0x0039D]  18 08                    sbb     [bx+si],cl
F000:039F  [+0x0039F]  00 40 01                 add     [bx+si+1],al
F000:03A2  [+0x003A2]  01 00                    add     [bx+si],ax
F000:03A4  [+0x003A4]  06                       push    es
F000:03A5  [+0x003A5]  63 5F 4F                 arpl    [bx+4Fh],bx
F000:03A8  [+0x003A8]  50                       push    ax
F000:03A9  [+0x003A9]  82 54 80 BF              adc     byte [si-80h],0BFh
F000:03AD  [+0x003AD]  1F                       pop     ds
F000:03AE  [+0x003AE]  00 C1                    add     cl,al
F000:03B0  [+0x003B0]  00 00                    add     [bx+si],al
F000:03B2  [+0x003B2]  00 00                    add     [bx+si],al
F000:03B4  [+0x003B4]  00 00                    add     [bx+si],al
F000:03B6  [+0x003B6]  9C                       pushf
F000:03B7  [+0x003B7]  DB 0x8E  (bad)
F000:03BB  [+0x003BB]  96                       xchg    si,ax
F000:03BC  [+0x003BC]  B9 C2 FF                 mov     cx,0FFC2h
F000:03BF  [+0x003BF]  00 17                    add     [bx],dl
F000:03C1  [+0x003C1]  17                       pop     ss
F000:03C2  [+0x003C2]  17                       pop     ss
F000:03C3  [+0x003C3]  17                       pop     ss
F000:03C4  [+0x003C4]  17                       pop     ss
F000:03C5  [+0x003C5]  17                       pop     ss
F000:03C6  [+0x003C6]  17                       pop     ss
F000:03C7  [+0x003C7]  17                       pop     ss
F000:03C8  [+0x003C8]  17                       pop     ss
F000:03C9  [+0x003C9]  17                       pop     ss
F000:03CA  [+0x003CA]  17                       pop     ss
F000:03CB  [+0x003CB]  17                       pop     ss
F000:03CC  [+0x003CC]  17                       pop     ss
F000:03CD  [+0x003CD]  17                       pop     ss
F000:03CE  [+0x003CE]  17                       pop     ss
F000:03CF  [+0x003CF]  01 00                    add     [bx+si],ax
F000:03D1  [+0x003D1]  01 00                    add     [bx+si],ax
F000:03D3  [+0x003D3]  00 00                    add     [bx+si],al
F000:03D5  [+0x003D5]  00 00                    add     [bx+si],al
F000:03D7  [+0x003D7]  00 00                    add     [bx+si],al
F000:03D9  [+0x003D9]  0D 00 FF                 or      ax,0FF00h
F000:03DC  [+0x003DC]  50                       push    ax
F000:03DD  [+0x003DD]  18 0E 00 10              sbb     [1000h],cl
F000:03E1  [+0x003E1]  00 03                    add     [bp+di],al
F000:03E3  [+0x003E3]  00 03                    add     [bp+di],al
F000:03E5  [+0x003E5]  A6                       cmpsb
F000:03E6  [+0x003E6]  5F                       pop     di
F000:03E7  [+0x003E7]  4F                       dec     di
F000:03E8  [+0x003E8]  50                       push    ax
F000:03E9  [+0x003E9]  82 55 81 BF              adc     byte [di-7Fh],0BFh
F000:03ED  [+0x003ED]  1F                       pop     ds
F000:03EE  [+0x003EE]  00 4D 0B                 add     [di+0Bh],cl
F000:03F1  [+0x003F1]  0C 00                    or      al,0
F000:03F3  [+0x003F3]  00 00                    add     [bx+si],al
F000:03F5  [+0x003F5]  00 83 85 5D              add     [bp+di+5D85h],al
F000:03F9  [+0x003F9]  28 0D                    sub     [di],cl
F000:03FB  [+0x003FB]  63 BA A3 FF              arpl    [bp+si-5Dh],di
F000:03FF  [+0x003FF]  00 08                    add     [bx+si],cl
F000:0401  [+0x00401]  08 08                    or      [bx+si],cl
F000:0403  [+0x00403]  08 08                    or      [bx+si],cl
F000:0405  [+0x00405]  08 08                    or      [bx+si],cl
F000:0407  [+0x00407]  10 18                    adc     [bx+si],bl
F000:0409  [+0x00409]  18 18                    sbb     [bx+si],bl
F000:040B  [+0x0040B]  18 18                    sbb     [bx+si],bl
F000:040D  [+0x0040D]  18 18                    sbb     [bx+si],bl
F000:040F  [+0x0040F]  0E                       push    cs
F000:0410  [+0x00410]  00 0F                    add     [bx],cl
F000:0412  [+0x00412]  08 00                    or      [bx+si],al
F000:0414  [+0x00414]  00 00                    add     [bx+si],al
F000:0416  [+0x00416]  00 00                    add     [bx+si],al
F000:0418  [+0x00418]  10 0A                    adc     [bp+si],cl
F000:041A  [+0x0041A]  00 FF                    add     bh,bh
F000:041C  [+0x0041C]  64 24 10                 and     al,10h
F000:041F  [+0x0041F]  60                       pusha
F000:0420  [+0x00420]  EA 01 0F 00 06           jmp     0600h:0F01h
F000:0425  [+0x00425]  EB 7F                    jmp     short 04A6h
F000:0427  [+0x00427]  63 64 82                 arpl    [si-7Eh],sp
F000:042A  [+0x0042A]  70 00                    jo      short 042Ch
F000:042C  [+0x0042C]  72 F0                    jb      short 041Eh
F000:042E  [+0x0042E]  00 60 00                 add     [bx+si],ah
F000:0431  [+0x00431]  00 00                    add     [bx+si],al
F000:0433  [+0x00433]  00 00                    add     [bx+si],al
F000:0435  [+0x00435]  00 59 8C                 add     [bx+di-74h],bl
F000:0438  [+0x00438]  57                       push    di
F000:0439  [+0x00439]  32 00                    xor     al,[bx+si]
F000:043B  [+0x0043B]  59                       pop     cx
F000:043C  [+0x0043C]  70 E3                    jo      short 0421h
F000:043E  [+0x0043E]  FF 00                    inc     word [bx+si]
F000:0440  [+0x00440]  01 02                    add     [bp+si],ax
F000:0442  [+0x00442]  03 04                    add     ax,[si]
F000:0444  [+0x00444]  05 14 07                 add     ax,714h
F000:0447  [+0x00447]  38 39                    cmp     [bx+di],bh
F000:0449  [+0x00449]  3A 3B                    cmp     bh,[bp+di]
F000:044B  [+0x0044B]  3C 3D                    cmp     al,3Dh
F000:044D  [+0x0044D]  3E 3F                    aas
F000:044F  [+0x0044F]  01 00                    add     [bx+si],ax
F000:0451  [+0x00451]  0F 00 00                 sldt    [bx+si]
F000:0454  [+0x00454]  00 00                    add     [bx+si],al
F000:0456  [+0x00456]  00 00                    add     [bx+si],al
F000:0458  [+0x00458]  00 05                    add     [di],al
F000:045A  [+0x0045A]  0F FF 50 1D              ud0     dx,[bx+si+1Dh]
F000:045E  [+0x0045E]  10 FF                    adc     bh,bh
F000:0460  [+0x00460]  FF 01                    inc     word [bx+di]
F000:0462  [+0x00462]  0F 00 0E EB 61           str     [61EBh]
F000:0467  [+0x00467]  4F                       dec     di
F000:0468  [+0x00468]  50                       push    ax
F000:0469  [+0x00469]  82 54 80 0B              adc     byte [si-80h],0Bh
F000:046D  [+0x0046D]  3E 00 40 00              add     [bx+si],al
F000:0471  [+0x00471]  00 00                    add     [bx+si],al
F000:0473  [+0x00473]  00 00                    add     [bx+si],al
F000:0475  [+0x00475]  00 EA                    add     dl,ch
F000:0477  [+0x00477]  8C DF                    mov     di,ds
F000:0479  [+0x00479]  50                       push    ax
F000:047A  [+0x0047A]  00 E7                    add     bh,ah
F000:047C  [+0x0047C]  04 E3                    add     al,0E3h
F000:047E  [+0x0047E]  FF 00                    inc     word [bx+si]
F000:0480  [+0x00480]  01 02                    add     [bp+si],ax
F000:0482  [+0x00482]  03 04                    add     ax,[si]
F000:0484  [+0x00484]  05 06 07                 add     ax,706h
F000:0487  [+0x00487]  08 09                    or      [bx+di],cl
F000:0489  [+0x00489]  0A 0B                    or      cl,[bp+di]
F000:048B  [+0x0048B]  0C 0D                    or      al,0Dh
F000:048D  [+0x0048D]  0E                       push    cs
F000:048E  [+0x0048E]  0F 01 00                 sgdt    [bx+si]
F000:0491  [+0x00491]  0F 00 00                 sldt    [bx+si]
F000:0494  [+0x00494]  00 00                    add     [bx+si],al
F000:0496  [+0x00496]  00 00                    add     [bx+si],al
F000:0498  [+0x00498]  00 05                    add     [di],al
F000:049A  [+0x0049A]  0F FF 28                 ud0     bp,[bx+si]
F000:049D  [+0x0049D]  18 08                    sbb     [bx+si],cl
F000:049F  [+0x0049F]  00 40 00                 add     [bx+si],al
F000:04A2  [+0x004A2]  00 00                    add     [bx+si],al
F000:04A4  [+0x004A4]  03 23                    add     sp,[bp+di]
F000:04A6  [+0x004A6]  37                       aaa
F000:04A7  [+0x004A7]  27                       daa
F000:04A8  [+0x004A8]  2D 37 31                 sub     ax,3137h
F000:04AB  [+0x004AB]  15 04 11                 adc     ax,1104h
F000:04AE  [+0x004AE]  00 47 06                 add     [bx+6],al
F000:04B1  [+0x004B1]  07                       pop     es
F000:04B2  [+0x004B2]  00 00                    add     [bx+si],al
F000:04B4  [+0x004B4]  00 00                    add     [bx+si],al
F000:04B6  [+0x004B6]  E1 24                    loope   04DCh
F000:04B8  [+0x004B8]  DB 0xC7  (bad)
F000:04BA  [+0x004BA]  08 E0                    or      al,ah
F000:04BC  [+0x004BC]  DB 0xF0  (bad)
F000:04C0  [+0x004C0]  01 02                    add     [bp+si],ax
F000:04C2  [+0x004C2]  03 04                    add     ax,[si]
F000:04C4  [+0x004C4]  05 06 07                 add     ax,706h
F000:04C7  [+0x004C7]  10 11                    adc     [bx+di],dl
F000:04C9  [+0x004C9]  12 13                    adc     dl,[bp+di]
F000:04CB  [+0x004CB]  14 15                    adc     al,15h
F000:04CD  [+0x004CD]  16                       push    ss
F000:04CE  [+0x004CE]  17                       pop     ss
F000:04CF  [+0x004CF]  08 00                    or      [bx+si],al
F000:04D1  [+0x004D1]  0F 00 00                 sldt    [bx+si]
F000:04D4  [+0x004D4]  00 00                    add     [bx+si],al
F000:04D6  [+0x004D6]  00 00                    add     [bx+si],al
F000:04D8  [+0x004D8]  10 0E 00 FF              adc     [0FF00h],cl
F000:04DC  [+0x004DC]  50                       push    ax
F000:04DD  [+0x004DD]  00 00                    add     [bx+si],al
F000:04DF  [+0x004DF]  00 00                    add     [bx+si],al
F000:04E1  [+0x004E1]  29 0F                    sub     [bx],cx
F000:04E3  [+0x004E3]  00 06 62 5F              add     [5F62h],al
F000:04E7  [+0x004E7]  4F                       dec     di
F000:04E8  [+0x004E8]  50                       push    ax
F000:04E9  [+0x004E9]  82 55 81 BF              adc     byte [di-7Fh],0BFh
F000:04ED  [+0x004ED]  1F                       pop     ds
F000:04EE  [+0x004EE]  00 40 00                 add     [bx+si],al
F000:04F1  [+0x004F1]  00 00                    add     [bx+si],al
F000:04F3  [+0x004F3]  00 00                    add     [bx+si],al
F000:04F5  [+0x004F5]  00 9C 8E 8F              add     [si-7072h],bl
F000:04F9  [+0x004F9]  28 1F                    sub     [bx],bl
F000:04FB  [+0x004FB]  96                       xchg    si,ax
F000:04FC  [+0x004FC]  B9 E3 FF                 mov     cx,0FFE3h
F000:04FF  [+0x004FF]  00 00                    add     [bx+si],al
F000:0501  [+0x00501]  00 00                    add     [bx+si],al
F000:0503  [+0x00503]  00 00                    add     [bx+si],al
F000:0505  [+0x00505]  00 00                    add     [bx+si],al
F000:0507  [+0x00507]  00 00                    add     [bx+si],al
F000:0509  [+0x00509]  00 00                    add     [bx+si],al
F000:050B  [+0x0050B]  00 00                    add     [bx+si],al
F000:050D  [+0x0050D]  00 3F                    add     [bx],bh
F000:050F  [+0x0050F]  01 00                    add     [bx+si],ax
F000:0511  [+0x00511]  0F 00 00                 sldt    [bx+si]
F000:0514  [+0x00514]  00 0F                    add     [bx],cl
F000:0516  [+0x00516]  00 00                    add     [bx+si],al
F000:0518  [+0x00518]  08 05                    or      [di],al
F000:051A  [+0x0051A]  0F FF 50 00              ud0     dx,[bx+si]
F000:051E  [+0x0051E]  00 00                    add     [bx+si],al
F000:0520  [+0x00520]  00 29                    add     [bx+di],ch
F000:0522  [+0x00522]  0F 00 06 63 5F           sldt    [5F63h]
F000:0527  [+0x00527]  4F                       dec     di
F000:0528  [+0x00528]  50                       push    ax
F000:0529  [+0x00529]  82 55 81 BF              adc     byte [di-7Fh],0BFh
F000:052D  [+0x0052D]  1F                       pop     ds
F000:052E  [+0x0052E]  00 40 00                 add     [bx+si],al
F000:0531  [+0x00531]  00 00                    add     [bx+si],al
F000:0533  [+0x00533]  00 00                    add     [bx+si],al
F000:0535  [+0x00535]  00 9C 8E 8F              add     [si-7072h],bl
F000:0539  [+0x00539]  28 1F                    sub     [bx],bl
F000:053B  [+0x0053B]  96                       xchg    si,ax
F000:053C  [+0x0053C]  B9 E3 FF                 mov     cx,0FFE3h
F000:053F  [+0x0053F]  00 00                    add     [bx+si],al
F000:0541  [+0x00541]  00 00                    add     [bx+si],al
F000:0543  [+0x00543]  00 00                    add     [bx+si],al
F000:0545  [+0x00545]  00 00                    add     [bx+si],al
F000:0547  [+0x00547]  00 00                    add     [bx+si],al
F000:0549  [+0x00549]  00 00                    add     [bx+si],al
F000:054B  [+0x0054B]  00 00                    add     [bx+si],al
F000:054D  [+0x0054D]  00 3F                    add     [bx],bh
F000:054F  [+0x0054F]  01 00                    add     [bx+si],ax
F000:0551  [+0x00551]  0F 00 00                 sldt    [bx+si]
F000:0554  [+0x00554]  00 0F                    add     [bx],cl
F000:0556  [+0x00556]  00 00                    add     [bx+si],al
F000:0558  [+0x00558]  08 05                    or      [di],al
F000:055A  [+0x0055A]  0F FF 28                 ud0     bp,[bx+si]
F000:055D  [+0x0055D]  18 08                    sbb     [bx+si],cl
F000:055F  [+0x0055F]  00 20                    add     [bx+si],ah
F000:0561  [+0x00561]  09 0F                    or      [bx],cx
F000:0563  [+0x00563]  00 06 63 2D              add     [2D63h],al
F000:0567  [+0x00567]  27                       daa
F000:0568  [+0x00568]  28 90 2B 80              sub     [bx+si-7FD5h],dl
F000:056C  [+0x0056C]  BF 1F 00                 mov     di,1Fh
F000:056F  [+0x0056F]  C0 00 00                 rol     byte [bx+si],0
F000:0572  [+0x00572]  00 00                    add     [bx+si],al
F000:0574  [+0x00574]  00 00                    add     [bx+si],al
F000:0576  [+0x00576]  9C                       pushf
F000:0577  [+0x00577]  DB 0x8E  (bad)
F000:057B  [+0x0057B]  96                       xchg    si,ax
F000:057C  [+0x0057C]  B9 E3 FF                 mov     cx,0FFE3h
F000:057F  [+0x0057F]  00 01                    add     [bx+di],al
F000:0581  [+0x00581]  02 03                    add     al,[bp+di]
F000:0583  [+0x00583]  04 05                    add     al,5
F000:0585  [+0x00585]  06                       push    es
F000:0586  [+0x00586]  07                       pop     es
F000:0587  [+0x00587]  10 11                    adc     [bx+di],dl
F000:0589  [+0x00589]  12 13                    adc     dl,[bp+di]
F000:058B  [+0x0058B]  14 15                    adc     al,15h
F000:058D  [+0x0058D]  16                       push    ss
F000:058E  [+0x0058E]  17                       pop     ss
F000:058F  [+0x0058F]  01 00                    add     [bx+si],ax
F000:0591  [+0x00591]  0F 00 00                 sldt    [bx+si]
F000:0594  [+0x00594]  00 00                    add     [bx+si],al
F000:0596  [+0x00596]  00 00                    add     [bx+si],al
F000:0598  [+0x00598]  00 05                    add     [di],al
F000:059A  [+0x0059A]  0F FF 50 18              ud0     dx,[bx+si+18h]
F000:059E  [+0x0059E]  08 00                    or      [bx+si],al
F000:05A0  [+0x005A0]  40                       inc     ax
F000:05A1  [+0x005A1]  01 0F                    add     [bx],cx
F000:05A3  [+0x005A3]  00 06 63 5F              add     [5F63h],al
F000:05A7  [+0x005A7]  4F                       dec     di
F000:05A8  [+0x005A8]  50                       push    ax
F000:05A9  [+0x005A9]  82 54 80 BF              adc     byte [si-80h],0BFh
F000:05AD  [+0x005AD]  1F                       pop     ds
F000:05AE  [+0x005AE]  00 C0                    add     al,al
F000:05B0  [+0x005B0]  00 00                    add     [bx+si],al
F000:05B2  [+0x005B2]  00 00                    add     [bx+si],al
F000:05B4  [+0x005B4]  00 00                    add     [bx+si],al
F000:05B6  [+0x005B6]  9C                       pushf
F000:05B7  [+0x005B7]  DB 0x8E  (bad)
F000:05BB  [+0x005BB]  96                       xchg    si,ax
F000:05BC  [+0x005BC]  B9 E3 FF                 mov     cx,0FFE3h
F000:05BF  [+0x005BF]  00 01                    add     [bx+di],al
F000:05C1  [+0x005C1]  02 03                    add     al,[bp+di]
F000:05C3  [+0x005C3]  04 05                    add     al,5
F000:05C5  [+0x005C5]  06                       push    es
F000:05C6  [+0x005C6]  07                       pop     es
F000:05C7  [+0x005C7]  10 11                    adc     [bx+di],dl
F000:05C9  [+0x005C9]  12 13                    adc     dl,[bp+di]
F000:05CB  [+0x005CB]  14 15                    adc     al,15h
F000:05CD  [+0x005CD]  16                       push    ss
F000:05CE  [+0x005CE]  17                       pop     ss
F000:05CF  [+0x005CF]  01 00                    add     [bx+si],ax
F000:05D1  [+0x005D1]  0F 00 00                 sldt    [bx+si]
F000:05D4  [+0x005D4]  00 00                    add     [bx+si],al
F000:05D6  [+0x005D6]  00 00                    add     [bx+si],al
F000:05D8  [+0x005D8]  00 05                    add     [di],al
F000:05DA  [+0x005DA]  0F FF 84 18 10           ud0     ax,[si+1018h]
F000:05DF  [+0x005DF]  D0 19                    rcr     byte [bx+di],1
F000:05E1  [+0x005E1]  01 03                    add     [bp+di],ax
F000:05E3  [+0x005E3]  00 02                    add     [bp+si],al
F000:05E5  [+0x005E5]  6B A0 83 85 82           imul    sp,[bx+si-7A7Dh],0FF82h
F000:05EA  [+0x005EA]  8A 81 BF 1F              mov     al,[bx+di+1FBFh]
F000:05EE  [+0x005EE]  00 4F 0D                 add     [bx+0Dh],cl
F000:05F1  [+0x005F1]  0E                       push    cs
F000:05F2  [+0x005F2]  00 00                    add     [bx+si],al
F000:05F4  [+0x005F4]  00 00                    add     [bx+si],al
F000:05F6  [+0x005F6]  9C                       pushf
F000:05F7  [+0x005F7]  DB 0x8E  (bad)
F000:05FB  [+0x005FB]  96                       xchg    si,ax
F000:05FC  [+0x005FC]  B9 A3 FF                 mov     cx,0FFA3h
F000:05FF  [+0x005FF]  00 01                    add     [bx+di],al
F000:0601  [+0x00601]  02 03                    add     al,[bp+di]
F000:0603  [+0x00603]  04 05                    add     al,5
F000:0605  [+0x00605]  14 07                    adc     al,7
F000:0607  [+0x00607]  38 39                    cmp     [bx+di],bh
F000:0609  [+0x00609]  3A 3B                    cmp     bh,[bp+di]
F000:060B  [+0x0060B]  3C 3D                    cmp     al,3Dh
F000:060D  [+0x0060D]  3E 3F                    aas
F000:060F  [+0x0060F]  0C 00                    or      al,0
F000:0611  [+0x00611]  0F 00 00                 sldt    [bx+si]
F000:0614  [+0x00614]  00 00                    add     [bx+si],al
F000:0616  [+0x00616]  00 00                    add     [bx+si],al
F000:0618  [+0x00618]  10 0E 00 FF              adc     [0FF00h],cl
F000:061C  [+0x0061C]  84 31                    test    [bx+di],dh
F000:061E  [+0x0061E]  08 90 33 01              or      [bx+si+133h],dl
F000:0622  [+0x00622]  03 00                    add     ax,[bx+si]
F000:0624  [+0x00624]  02 6B A0                 add     ch,[bp+di-60h]
F000:0627  [+0x00627]  83 85 82 8A 81           add     word [di-757Eh],0FF81h
F000:062C  [+0x0062C]  BF 1F 00                 mov     di,1Fh
F000:062F  [+0x0062F]  47                       inc     di
F000:0630  [+0x00630]  06                       push    es
F000:0631  [+0x00631]  07                       pop     es
F000:0632  [+0x00632]  00 00                    add     [bx+si],al
F000:0634  [+0x00634]  00 00                    add     [bx+si],al
F000:0636  [+0x00636]  9C                       pushf
F000:0637  [+0x00637]  DB 0x8E  (bad)
F000:063B  [+0x0063B]  96                       xchg    si,ax
F000:063C  [+0x0063C]  B9 A3 FF                 mov     cx,0FFA3h
F000:063F  [+0x0063F]  00 01                    add     [bx+di],al
F000:0641  [+0x00641]  02 03                    add     al,[bp+di]
F000:0643  [+0x00643]  04 05                    add     al,5
F000:0645  [+0x00645]  14 07                    adc     al,7
F000:0647  [+0x00647]  38 39                    cmp     [bx+di],bh
F000:0649  [+0x00649]  3A 3B                    cmp     bh,[bp+di]
F000:064B  [+0x0064B]  3C 3D                    cmp     al,3Dh
F000:064D  [+0x0064D]  3E 3F                    aas
F000:064F  [+0x0064F]  0C 00                    or      al,0
F000:0651  [+0x00651]  0F 00 00                 sldt    [bx+si]
F000:0654  [+0x00654]  00 00                    add     [bx+si],al
F000:0656  [+0x00656]  00 00                    add     [bx+si],al
F000:0658  [+0x00658]  10 0E 00 FF              adc     [0FF00h],cl
F000:065C  [+0x0065C]  50                       push    ax
F000:065D  [+0x0065D]  18 0E 00 80              sbb     [8000h],cl
F000:0661  [+0x00661]  01 0F                    add     [bx],cx
F000:0663  [+0x00663]  00 06 A2 5F              add     [5FA2h],al
F000:0667  [+0x00667]  4F                       dec     di
F000:0668  [+0x00668]  50                       push    ax
F000:0669  [+0x00669]  82 54 80 BF              adc     byte [si-80h],0BFh
F000:066D  [+0x0066D]  1F                       pop     ds
F000:066E  [+0x0066E]  00 40 00                 add     [bx+si],al
F000:0671  [+0x00671]  00 00                    add     [bx+si],al
F000:0673  [+0x00673]  00 00                    add     [bx+si],al
F000:0675  [+0x00675]  00 83 85 5D              add     [bp+di+5D85h],al
F000:0679  [+0x00679]  28 0F                    sub     [bx],cl
F000:067B  [+0x0067B]  63 BA E3 FF              arpl    [bp+si-1Dh],di
F000:067F  [+0x0067F]  00 08                    add     [bx+si],cl
F000:0681  [+0x00681]  00 00                    add     [bx+si],al
F000:0683  [+0x00683]  18 18                    sbb     [bx+si],bl
F000:0685  [+0x00685]  00 00                    add     [bx+si],al
F000:0687  [+0x00687]  00 08                    add     [bx+si],cl
F000:0689  [+0x00689]  00 00                    add     [bx+si],al
F000:068B  [+0x0068B]  00 18                    add     [bx+si],bl
F000:068D  [+0x0068D]  00 00                    add     [bx+si],al
F000:068F  [+0x0068F]  0B 00                    or      ax,[bx+si]
F000:0691  [+0x00691]  05 00 00                 add     ax,0
F000:0694  [+0x00694]  00 00                    add     [bx+si],al
F000:0696  [+0x00696]  00 00                    add     [bx+si],al
F000:0698  [+0x00698]  00 05                    add     [di],al
F000:069A  [+0x0069A]  05 FF 50                 add     ax,50FFh
F000:069D  [+0x0069D]  18 0E 00 80              sbb     [8000h],cl
F000:06A1  [+0x006A1]  01 0F                    add     [bx],cx
F000:06A3  [+0x006A3]  00 06 A3 5F              add     [5FA3h],al
F000:06A7  [+0x006A7]  4F                       dec     di
F000:06A8  [+0x006A8]  50                       push    ax
F000:06A9  [+0x006A9]  82 54 80 BF              adc     byte [si-80h],0BFh
F000:06AD  [+0x006AD]  1F                       pop     ds
F000:06AE  [+0x006AE]  00 40 00                 add     [bx+si],al
F000:06B1  [+0x006B1]  00 00                    add     [bx+si],al
F000:06B3  [+0x006B3]  00 00                    add     [bx+si],al
F000:06B5  [+0x006B5]  00 83 85 5D              add     [bp+di+5D85h],al
F000:06B9  [+0x006B9]  28 0F                    sub     [bx],cl
F000:06BB  [+0x006BB]  63 BA E3 FF              arpl    [bp+si-1Dh],di
F000:06BF  [+0x006BF]  00 01                    add     [bx+di],al
F000:06C1  [+0x006C1]  02 03                    add     al,[bp+di]
F000:06C3  [+0x006C3]  04 05                    add     al,5
F000:06C5  [+0x006C5]  14 07                    adc     al,7
F000:06C7  [+0x006C7]  38 39                    cmp     [bx+di],bh
F000:06C9  [+0x006C9]  3A 3B                    cmp     bh,[bp+di]
F000:06CB  [+0x006CB]  3C 3D                    cmp     al,3Dh
F000:06CD  [+0x006CD]  3E 3F                    aas
F000:06CF  [+0x006CF]  01 00                    add     [bx+si],ax
F000:06D1  [+0x006D1]  0F 00 00                 sldt    [bx+si]
F000:06D4  [+0x006D4]  00 00                    add     [bx+si],al
F000:06D6  [+0x006D6]  00 00                    add     [bx+si],al
F000:06D8  [+0x006D8]  00 05                    add     [di],al
F000:06DA  [+0x006DA]  0F FF 28                 ud0     bp,[bx+si]
F000:06DD  [+0x006DD]  18 0E 00 08              sbb     [800h],cl
F000:06E1  [+0x006E1]  09 03                    or      [bp+di],ax
F000:06E3  [+0x006E3]  00 02                    add     [bp+si],al
F000:06E5  [+0x006E5]  A3 2D 27                 mov     [272Dh],ax
F000:06E8  [+0x006E8]  28 90 2B A0              sub     [bx+si-5FD5h],dl
F000:06EC  [+0x006EC]  BF 1F 00                 mov     di,1Fh
F000:06EF  [+0x006EF]  4D                       dec     bp
F000:06F0  [+0x006F0]  0B 0C                    or      cx,[si]
F000:06F2  [+0x006F2]  00 00                    add     [bx+si],al
F000:06F4  [+0x006F4]  00 00                    add     [bx+si],al
F000:06F6  [+0x006F6]  83 85 5D 14 1F           add     word [di+145Dh],1Fh
F000:06FB  [+0x006FB]  63 BA A3 FF              arpl    [bp+si-5Dh],di
F000:06FF  [+0x006FF]  00 01                    add     [bx+di],al
F000:0701  [+0x00701]  02 03                    add     al,[bp+di]
F000:0703  [+0x00703]  04 05                    add     al,5
F000:0705  [+0x00705]  14 07                    adc     al,7
F000:0707  [+0x00707]  38 39                    cmp     [bx+di],bh
F000:0709  [+0x00709]  3A 3B                    cmp     bh,[bp+di]
F000:070B  [+0x0070B]  3C 3D                    cmp     al,3Dh
F000:070D  [+0x0070D]  3E 3F                    aas
F000:070F  [+0x0070F]  08 00                    or      [bx+si],al
F000:0711  [+0x00711]  0F 00 00                 sldt    [bx+si]
F000:0714  [+0x00714]  00 00                    add     [bx+si],al
F000:0716  [+0x00716]  00 00                    add     [bx+si],al
F000:0718  [+0x00718]  10 0E 00 FF              adc     [0FF00h],cl
F000:071C  [+0x0071C]  28 18                    sub     [bx+si],bl
F000:071E  [+0x0071E]  0E                       push    cs
F000:071F  [+0x0071F]  00 08                    add     [bx+si],cl
F000:0721  [+0x00721]  09 03                    or      [bp+di],ax
F000:0723  [+0x00723]  00 02                    add     [bp+si],al
F000:0725  [+0x00725]  A3 2D 27                 mov     [272Dh],ax
F000:0728  [+0x00728]  28 90 2B A0              sub     [bx+si-5FD5h],dl
F000:072C  [+0x0072C]  BF 1F 00                 mov     di,1Fh
F000:072F  [+0x0072F]  4D                       dec     bp
F000:0730  [+0x00730]  0B 0C                    or      cx,[si]
F000:0732  [+0x00732]  00 00                    add     [bx+si],al
F000:0734  [+0x00734]  00 00                    add     [bx+si],al
F000:0736  [+0x00736]  83 85 5D 14 1F           add     word [di+145Dh],1Fh
F000:073B  [+0x0073B]  63 BA A3 FF              arpl    [bp+si-5Dh],di
F000:073F  [+0x0073F]  00 01                    add     [bx+di],al
F000:0741  [+0x00741]  02 03                    add     al,[bp+di]
F000:0743  [+0x00743]  04 05                    add     al,5
F000:0745  [+0x00745]  14 07                    adc     al,7
F000:0747  [+0x00747]  38 39                    cmp     [bx+di],bh
F000:0749  [+0x00749]  3A 3B                    cmp     bh,[bp+di]
F000:074B  [+0x0074B]  3C 3D                    cmp     al,3Dh
F000:074D  [+0x0074D]  3E 3F                    aas
F000:074F  [+0x0074F]  08 00                    or      [bx+si],al
F000:0751  [+0x00751]  0F 00 00                 sldt    [bx+si]
F000:0754  [+0x00754]  00 00                    add     [bx+si],al
F000:0756  [+0x00756]  00 00                    add     [bx+si],al
F000:0758  [+0x00758]  10 0E 00 FF              adc     [0FF00h],cl
F000:075C  [+0x0075C]  50                       push    ax
F000:075D  [+0x0075D]  18 0E 00 10              sbb     [1000h],cl
F000:0761  [+0x00761]  01 03                    add     [bp+di],ax
F000:0763  [+0x00763]  00 02                    add     [bp+si],al
F000:0765  [+0x00765]  A3 5F 4F                 mov     [4F5Fh],ax
F000:0768  [+0x00768]  50                       push    ax
F000:0769  [+0x00769]  82 55 81 BF              adc     byte [di-7Fh],0BFh
F000:076D  [+0x0076D]  1F                       pop     ds
F000:076E  [+0x0076E]  00 4D 0B                 add     [di+0Bh],cl
F000:0771  [+0x00771]  0C 00                    or      al,0
F000:0773  [+0x00773]  00 00                    add     [bx+si],al
F000:0775  [+0x00775]  00 83 85 5D              add     [bp+di+5D85h],al
F000:0779  [+0x00779]  28 1F                    sub     [bx],bl
F000:077B  [+0x0077B]  63 BA A3 FF              arpl    [bp+si-5Dh],di
F000:077F  [+0x0077F]  00 01                    add     [bx+di],al
F000:0781  [+0x00781]  02 03                    add     al,[bp+di]
F000:0783  [+0x00783]  04 05                    add     al,5
F000:0785  [+0x00785]  14 07                    adc     al,7
F000:0787  [+0x00787]  38 39                    cmp     [bx+di],bh
F000:0789  [+0x00789]  3A 3B                    cmp     bh,[bp+di]
F000:078B  [+0x0078B]  3C 3D                    cmp     al,3Dh
F000:078D  [+0x0078D]  3E 3F                    aas
F000:078F  [+0x0078F]  08 00                    or      [bx+si],al
F000:0791  [+0x00791]  0F 00 00                 sldt    [bx+si]
F000:0794  [+0x00794]  00 00                    add     [bx+si],al
F000:0796  [+0x00796]  00 00                    add     [bx+si],al
F000:0798  [+0x00798]  10 0E 00 FF              adc     [0FF00h],cl
F000:079C  [+0x0079C]  50                       push    ax
F000:079D  [+0x0079D]  18 0E 00 10              sbb     [1000h],cl
F000:07A1  [+0x007A1]  01 03                    add     [bp+di],ax
F000:07A3  [+0x007A3]  00 02                    add     [bp+si],al
F000:07A5  [+0x007A5]  A3 5F 4F                 mov     [4F5Fh],ax
F000:07A8  [+0x007A8]  50                       push    ax
F000:07A9  [+0x007A9]  82 55 81 BF              adc     byte [di-7Fh],0BFh
F000:07AD  [+0x007AD]  1F                       pop     ds
F000:07AE  [+0x007AE]  00 4D 0B                 add     [di+0Bh],cl
F000:07B1  [+0x007B1]  0C 00                    or      al,0
F000:07B3  [+0x007B3]  00 00                    add     [bx+si],al
F000:07B5  [+0x007B5]  00 83 85 5D              add     [bp+di+5D85h],al
F000:07B9  [+0x007B9]  28 1F                    sub     [bx],bl
F000:07BB  [+0x007BB]  63 BA A3 FF              arpl    [bp+si-5Dh],di
F000:07BF  [+0x007BF]  00 01                    add     [bx+di],al
F000:07C1  [+0x007C1]  02 03                    add     al,[bp+di]
F000:07C3  [+0x007C3]  04 05                    add     al,5
F000:07C5  [+0x007C5]  14 07                    adc     al,7
F000:07C7  [+0x007C7]  38 39                    cmp     [bx+di],bh
F000:07C9  [+0x007C9]  3A 3B                    cmp     bh,[bp+di]
F000:07CB  [+0x007CB]  3C 3D                    cmp     al,3Dh
F000:07CD  [+0x007CD]  3E 3F                    aas
F000:07CF  [+0x007CF]  08 00                    or      [bx+si],al
F000:07D1  [+0x007D1]  0F 00 00                 sldt    [bx+si]
F000:07D4  [+0x007D4]  00 00                    add     [bx+si],al
F000:07D6  [+0x007D6]  00 00                    add     [bx+si],al
F000:07D8  [+0x007D8]  10 0E 00 FF              adc     [0FF00h],cl
F000:07DC  [+0x007DC]  28 18                    sub     [bx+si],bl
F000:07DE  [+0x007DE]  10 00                    adc     [bx+si],al
F000:07E0  [+0x007E0]  08 08                    or      [bx+si],cl
F000:07E2  [+0x007E2]  03 00                    add     ax,[bx+si]
F000:07E4  [+0x007E4]  02 67 2D                 add     ah,[bx+2Dh]
F000:07E7  [+0x007E7]  27                       daa
F000:07E8  [+0x007E8]  28 90 2B A0              sub     [bx+si-5FD5h],dl
F000:07EC  [+0x007EC]  BF 1F 00                 mov     di,1Fh
F000:07EF  [+0x007EF]  4F                       dec     di
F000:07F0  [+0x007F0]  0D 0E 00                 or      ax,0Eh
F000:07F3  [+0x007F3]  00 00                    add     [bx+si],al
F000:07F5  [+0x007F5]  00 9C 8E 8F              add     [si-7072h],bl
F000:07F9  [+0x007F9]  14 1F                    adc     al,1Fh
F000:07FB  [+0x007FB]  96                       xchg    si,ax
F000:07FC  [+0x007FC]  B9 A3 FF                 mov     cx,0FFA3h
F000:07FF  [+0x007FF]  00 01                    add     [bx+di],al
F000:0801  [+0x00801]  02 03                    add     al,[bp+di]
F000:0803  [+0x00803]  04 05                    add     al,5
F000:0805  [+0x00805]  14 07                    adc     al,7
F000:0807  [+0x00807]  38 39                    cmp     [bx+di],bh
F000:0809  [+0x00809]  3A 3B                    cmp     bh,[bp+di]
F000:080B  [+0x0080B]  3C 3D                    cmp     al,3Dh
F000:080D  [+0x0080D]  3E 3F                    aas
F000:080F  [+0x0080F]  0C 00                    or      al,0
F000:0811  [+0x00811]  0F 08                    invd
F000:0813  [+0x00813]  00 00                    add     [bx+si],al
F000:0815  [+0x00815]  00 00                    add     [bx+si],al
F000:0817  [+0x00817]  00 10                    add     [bx+si],dl
F000:0819  [+0x00819]  0E                       push    cs
F000:081A  [+0x0081A]  00 FF                    add     bh,bh
F000:081C  [+0x0081C]  50                       push    ax
F000:081D  [+0x0081D]  18 10                    sbb     [bx+si],dl
F000:081F  [+0x0081F]  00 10                    add     [bx+si],dl
F000:0821  [+0x00821]  00 03                    add     [bp+di],al
F000:0823  [+0x00823]  00 02                    add     [bp+si],al
F000:0825  [+0x00825]  67 5F                    pop     di
F000:0827  [+0x00827]  4F                       dec     di
F000:0828  [+0x00828]  50                       push    ax
F000:0829  [+0x00829]  82 55 81 BF              adc     byte [di-7Fh],0BFh
F000:082D  [+0x0082D]  1F                       pop     ds
F000:082E  [+0x0082E]  00 4F 0D                 add     [bx+0Dh],cl
F000:0831  [+0x00831]  0E                       push    cs
F000:0832  [+0x00832]  00 00                    add     [bx+si],al
F000:0834  [+0x00834]  00 00                    add     [bx+si],al
F000:0836  [+0x00836]  9C                       pushf
F000:0837  [+0x00837]  DB 0x8E  (bad)
F000:083B  [+0x0083B]  96                       xchg    si,ax
F000:083C  [+0x0083C]  B9 A3 FF                 mov     cx,0FFA3h
F000:083F  [+0x0083F]  00 01                    add     [bx+di],al
F000:0841  [+0x00841]  02 03                    add     al,[bp+di]
F000:0843  [+0x00843]  04 05                    add     al,5
F000:0845  [+0x00845]  14 07                    adc     al,7
F000:0847  [+0x00847]  38 39                    cmp     [bx+di],bh
F000:0849  [+0x00849]  3A 3B                    cmp     bh,[bp+di]
F000:084B  [+0x0084B]  3C 3D                    cmp     al,3Dh
F000:084D  [+0x0084D]  3E 3F                    aas
F000:084F  [+0x0084F]  0C 00                    or      al,0
F000:0851  [+0x00851]  0F 08                    invd
F000:0853  [+0x00853]  00 00                    add     [bx+si],al
F000:0855  [+0x00855]  00 00                    add     [bx+si],al
F000:0857  [+0x00857]  00 10                    add     [bx+si],dl
F000:0859  [+0x00859]  0E                       push    cs
F000:085A  [+0x0085A]  00 FF                    add     bh,bh
F000:085C  [+0x0085C]  50                       push    ax
F000:085D  [+0x0085D]  18 10                    sbb     [bx+si],dl
F000:085F  [+0x0085F]  00 10                    add     [bx+si],dl
F000:0861  [+0x00861]  00 03                    add     [bp+di],al
F000:0863  [+0x00863]  00 02                    add     [bp+si],al
F000:0865  [+0x00865]  66 5F                    pop     edi
F000:0867  [+0x00867]  4F                       dec     di
F000:0868  [+0x00868]  50                       push    ax
F000:0869  [+0x00869]  82 55 81 BF              adc     byte [di-7Fh],0BFh
F000:086D  [+0x0086D]  1F                       pop     ds
F000:086E  [+0x0086E]  00 4F 0D                 add     [bx+0Dh],cl
F000:0871  [+0x00871]  0E                       push    cs
F000:0872  [+0x00872]  00 00                    add     [bx+si],al
F000:0874  [+0x00874]  00 00                    add     [bx+si],al
F000:0876  [+0x00876]  9C                       pushf
F000:0877  [+0x00877]  DB 0x8E  (bad)
F000:087B  [+0x0087B]  96                       xchg    si,ax
F000:087C  [+0x0087C]  B9 A3 FF                 mov     cx,0FFA3h
F000:087F  [+0x0087F]  00 08                    add     [bx+si],cl
F000:0881  [+0x00881]  08 08                    or      [bx+si],cl
F000:0883  [+0x00883]  08 08                    or      [bx+si],cl
F000:0885  [+0x00885]  08 08                    or      [bx+si],cl
F000:0887  [+0x00887]  10 18                    adc     [bx+si],bl
F000:0889  [+0x00889]  18 18                    sbb     [bx+si],bl
F000:088B  [+0x0088B]  18 18                    sbb     [bx+si],bl
F000:088D  [+0x0088D]  18 18                    sbb     [bx+si],bl
F000:088F  [+0x0088F]  0E                       push    cs
F000:0890  [+0x00890]  00 0F                    add     [bx],cl
F000:0892  [+0x00892]  08 00                    or      [bx+si],al
F000:0894  [+0x00894]  00 00                    add     [bx+si],al
F000:0896  [+0x00896]  00 00                    add     [bx+si],al
F000:0898  [+0x00898]  10 0A                    adc     [bp+si],cl
F000:089A  [+0x0089A]  00 FF                    add     bh,bh
F000:089C  [+0x0089C]  50                       push    ax
F000:089D  [+0x0089D]  1D 10 00                 sbb     ax,10h
F000:08A0  [+0x008A0]  A0 01 0F                 mov     al,[0F01h]
F000:08A3  [+0x008A3]  00 06 E3 5F              add     [5FE3h],al
F000:08A7  [+0x008A7]  4F                       dec     di
F000:08A8  [+0x008A8]  50                       push    ax
F000:08A9  [+0x008A9]  82 54 80 0B              adc     byte [si-80h],0Bh
F000:08AD  [+0x008AD]  3E 00 40 00              add     [bx+si],al
F000:08B1  [+0x008B1]  00 00                    add     [bx+si],al
F000:08B3  [+0x008B3]  00 00                    add     [bx+si],al
F000:08B5  [+0x008B5]  00 EA                    add     dl,ch
F000:08B7  [+0x008B7]  8C DF                    mov     di,ds
F000:08B9  [+0x008B9]  28 00                    sub     [bx+si],al
F000:08BB  [+0x008BB]  E7 04                    out     4,ax
F000:08BD  [+0x008BD]  C3                       ret
F000:08BE  [+0x008BE]  FF 00                    inc     word [bx+si]
F000:08C0  [+0x008C0]  3F                       aas
F000:08C1  [+0x008C1]  3F                       aas
F000:08C2  [+0x008C2]  3F                       aas
F000:08C3  [+0x008C3]  3F                       aas
F000:08C4  [+0x008C4]  3F                       aas
F000:08C5  [+0x008C5]  3F                       aas
F000:08C6  [+0x008C6]  3F                       aas
F000:08C7  [+0x008C7]  3F                       aas
F000:08C8  [+0x008C8]  3F                       aas
F000:08C9  [+0x008C9]  3F                       aas
F000:08CA  [+0x008CA]  3F                       aas
F000:08CB  [+0x008CB]  3F                       aas
F000:08CC  [+0x008CC]  3F                       aas
F000:08CD  [+0x008CD]  3F                       aas
F000:08CE  [+0x008CE]  3F                       aas
F000:08CF  [+0x008CF]  01 00                    add     [bx+si],ax
F000:08D1  [+0x008D1]  0F 00 00                 sldt    [bx+si]
F000:08D4  [+0x008D4]  00 00                    add     [bx+si],al
F000:08D6  [+0x008D6]  00 00                    add     [bx+si],al
F000:08D8  [+0x008D8]  00 05                    add     [di],al
F000:08DA  [+0x008DA]  01 FF                    add     di,di
F000:08DC  [+0x008DC]  50                       push    ax
F000:08DD  [+0x008DD]  1D 10 00                 sbb     ax,10h
F000:08E0  [+0x008E0]  A0 01 0F                 mov     al,[0F01h]
F000:08E3  [+0x008E3]  00 06 E3 5F              add     [5FE3h],al
F000:08E7  [+0x008E7]  4F                       dec     di
F000:08E8  [+0x008E8]  50                       push    ax
F000:08E9  [+0x008E9]  82 54 80 0B              adc     byte [si-80h],0Bh
F000:08ED  [+0x008ED]  3E 00 40 00              add     [bx+si],al
F000:08F1  [+0x008F1]  00 00                    add     [bx+si],al
F000:08F3  [+0x008F3]  00 00                    add     [bx+si],al
F000:08F5  [+0x008F5]  00 EA                    add     dl,ch
F000:08F7  [+0x008F7]  8C DF                    mov     di,ds
F000:08F9  [+0x008F9]  28 00                    sub     [bx+si],al
F000:08FB  [+0x008FB]  E7 04                    out     4,ax
F000:08FD  [+0x008FD]  E3 FF                    jcxz    08FEh
F000:08FF  [+0x008FF]  00 01                    add     [bx+di],al
F000:0901  [+0x00901]  02 03                    add     al,[bp+di]
F000:0903  [+0x00903]  04 05                    add     al,5
F000:0905  [+0x00905]  14 07                    adc     al,7
F000:0907  [+0x00907]  38 39                    cmp     [bx+di],bh
F000:0909  [+0x00909]  3A 3B                    cmp     bh,[bp+di]
F000:090B  [+0x0090B]  3C 3D                    cmp     al,3Dh
F000:090D  [+0x0090D]  3E 3F                    aas
F000:090F  [+0x0090F]  01 00                    add     [bx+si],ax
F000:0911  [+0x00911]  0F 00 00                 sldt    [bx+si]
F000:0914  [+0x00914]  00 00                    add     [bx+si],al
F000:0916  [+0x00916]  00 00                    add     [bx+si],al
F000:0918  [+0x00918]  00 05                    add     [di],al
F000:091A  [+0x0091A]  0F FF 28                 ud0     bp,[bx+si]
F000:091D  [+0x0091D]  18 08                    sbb     [bx+si],cl
F000:091F  [+0x0091F]  00 20                    add     [bx+si],ah
F000:0921  [+0x00921]  01 0F                    add     [bx],cx
F000:0923  [+0x00923]  00 0E 63 5F              add     [5F63h],cl
F000:0927  [+0x00927]  4F                       dec     di
F000:0928  [+0x00928]  50                       push    ax
F000:0929  [+0x00929]  82 54 80 BF              adc     byte [si-80h],0BFh
F000:092D  [+0x0092D]  1F                       pop     ds
F000:092E  [+0x0092E]  00 41 00                 add     [bx+di],al
F000:0931  [+0x00931]  00 00                    add     [bx+si],al
F000:0933  [+0x00933]  00 00                    add     [bx+si],al
F000:0935  [+0x00935]  00 9C 8E 8F              add     [si-7072h],bl
F000:0939  [+0x00939]  28 40 96                 sub     [bx+si-6Ah],al
F000:093C  [+0x0093C]  B9 A3 FF                 mov     cx,0FFA3h
F000:093F  [+0x0093F]  00 01                    add     [bx+di],al
F000:0941  [+0x00941]  02 03                    add     al,[bp+di]
F000:0943  [+0x00943]  04 05                    add     al,5
F000:0945  [+0x00945]  06                       push    es
F000:0946  [+0x00946]  07                       pop     es
F000:0947  [+0x00947]  08 09                    or      [bx+di],cl
F000:0949  [+0x00949]  0A 0B                    or      cl,[bp+di]
F000:094B  [+0x0094B]  0C 0D                    or      al,0Dh
F000:094D  [+0x0094D]  0E                       push    cs
F000:094E  [+0x0094E]  0F 41 00                 cmovno  ax,[bx+si]
F000:0951  [+0x00951]  0F 00 00                 sldt    [bx+si]
F000:0954  [+0x00954]  00 00                    add     [bx+si],al
F000:0956  [+0x00956]  00 00                    add     [bx+si],al
F000:0958  [+0x00958]  40                       inc     ax
F000:0959  [+0x00959]  05 0F FF                 add     ax,0FF0Fh
F000:095C  [+0x0095C]  80 2F 10                 sub     byte [bx],10h
F000:095F  [+0x0095F]  DB 0xFF  (bad)
F000:0961  [+0x00961]  01 0F                    add     [bx],cx
F000:0963  [+0x00963]  00 06 2B A3              add     [0A32Bh],al
F000:0967  [+0x00967]  7F 81                    jg      short 08EAh
F000:0969  [+0x00969]  85 88 99 25              test    [bx+si+2599h],cx
F000:096D  [+0x0096D]  FD                       std
F000:096E  [+0x0096E]  00 60 00                 add     [bx+si],ah
F000:0971  [+0x00971]  00 00                    add     [bx+si],al
F000:0973  [+0x00973]  00 00                    add     [bx+si],al
F000:0975  [+0x00975]  00 03                    add     [bp+di],al
F000:0977  [+0x00977]  8A FF                    mov     bh,bh
F000:0979  [+0x00979]  40                       inc     ax
F000:097A  [+0x0097A]  00 03                    add     [bp+di],al
F000:097C  [+0x0097C]  23 E3                    and     sp,bx
F000:097E  [+0x0097E]  FF 00                    inc     word [bx+si]
F000:0980  [+0x00980]  01 02                    add     [bp+si],ax
F000:0982  [+0x00982]  03 04                    add     ax,[si]
F000:0984  [+0x00984]  05 14 07                 add     ax,714h
F000:0987  [+0x00987]  38 39                    cmp     [bx+di],bh
F000:0989  [+0x00989]  3A 3B                    cmp     bh,[bp+di]
F000:098B  [+0x0098B]  3C 3D                    cmp     al,3Dh
F000:098D  [+0x0098D]  3E 3F                    aas
F000:098F  [+0x0098F]  01 00                    add     [bx+si],ax
F000:0991  [+0x00991]  0F 00 00                 sldt    [bx+si]
F000:0994  [+0x00994]  00 00                    add     [bx+si],al
F000:0996  [+0x00996]  00 00                    add     [bx+si],al
F000:0998  [+0x00998]  00 05                    add     [di],al
F000:099A  [+0x0099A]  0F FF 80 2F 10           ud0     ax,[bx+si+102Fh]
F000:099F  [+0x0099F]  DB 0xFF  (bad)
F000:09A1  [+0x009A1]  01 0F                    add     [bx],cx
F000:09A3  [+0x009A3]  00 06 2F 99              add     [992Fh],al
F000:09A7  [+0x009A7]  7F 80                    jg      short 0929h
F000:09A9  [+0x009A9]  9C                       pushf
F000:09AA  [+0x009AA]  88 17                    mov     [bx],dl
F000:09AC  [+0x009AC]  9B                       wait
F000:09AD  [+0x009AD]  1F                       pop     ds
F000:09AE  [+0x009AE]  00 40 00                 add     [bx+si],al
F000:09B1  [+0x009B1]  00 00                    add     [bx+si],al
F000:09B3  [+0x009B3]  00 00                    add     [bx+si],al
F000:09B5  [+0x009B5]  00 84 8E 7F              add     [si+7F8Eh],al
F000:09B9  [+0x009B9]  40                       inc     ax
F000:09BA  [+0x009BA]  00 81 9A E3              add     [bx+di-1C66h],al
F000:09BE  [+0x009BE]  FF 00                    inc     word [bx+si]
F000:09C0  [+0x009C0]  01 02                    add     [bp+si],ax
F000:09C2  [+0x009C2]  03 04                    add     ax,[si]
F000:09C4  [+0x009C4]  05 14 07                 add     ax,714h
F000:09C7  [+0x009C7]  38 39                    cmp     [bx+di],bh
F000:09C9  [+0x009C9]  3A 3B                    cmp     bh,[bp+di]
F000:09CB  [+0x009CB]  3C 3D                    cmp     al,3Dh
F000:09CD  [+0x009CD]  3E 3F                    aas
F000:09CF  [+0x009CF]  01 00                    add     [bx+si],ax
F000:09D1  [+0x009D1]  0F 00 00                 sldt    [bx+si]
F000:09D4  [+0x009D4]  00 00                    add     [bx+si],al
F000:09D6  [+0x009D6]  00 00                    add     [bx+si],al
F000:09D8  [+0x009D8]  00 05                    add     [di],al
F000:09DA  [+0x009DA]  0F FF 64 24              ud0     sp,[si+24h]
F000:09DE  [+0x009DE]  10 60 EA                 adc     [bx+si-16h],ah
F000:09E1  [+0x009E1]  01 0F                    add     [bx],cx
F000:09E3  [+0x009E3]  00 0E EB 7D              add     [7DEBh],cl
F000:09E7  [+0x009E7]  63 64 9E                 arpl    [si-62h],sp
F000:09EA  [+0x009EA]  6A 93                    push    0FF93h
F000:09EC  [+0x009EC]  70 F0                    jo      short 09DEh
F000:09EE  [+0x009EE]  00 60 00                 add     [bx+si],ah
F000:09F1  [+0x009F1]  00 00                    add     [bx+si],al
F000:09F3  [+0x009F3]  00 00                    add     [bx+si],al
F000:09F5  [+0x009F5]  00 59 8B                 add     [bx+di-75h],bl
F000:09F8  [+0x009F8]  57                       push    di
F000:09F9  [+0x009F9]  64 00 59 6C              add     [fs:bx+di+6Ch],bl
F000:09FD  [+0x009FD]  E3 FF                    jcxz    09FEh
F000:09FF  [+0x009FF]  00 01                    add     [bx+di],al
F000:0A01  [+0x00A01]  02 03                    add     al,[bp+di]
F000:0A03  [+0x00A03]  04 05                    add     al,5
F000:0A05  [+0x00A05]  06                       push    es
F000:0A06  [+0x00A06]  07                       pop     es
F000:0A07  [+0x00A07]  08 09                    or      [bx+di],cl
F000:0A09  [+0x00A09]  0A 0B                    or      cl,[bp+di]
F000:0A0B  [+0x00A0B]  0C 0D                    or      al,0Dh
F000:0A0D  [+0x00A0D]  0E                       push    cs
F000:0A0E  [+0x00A0E]  0F 01 00                 sgdt    [bx+si]
F000:0A11  [+0x00A11]  0F 00 00                 sldt    [bx+si]
F000:0A14  [+0x00A14]  00 00                    add     [bx+si],al
F000:0A16  [+0x00A16]  00 00                    add     [bx+si],al
F000:0A18  [+0x00A18]  00 05                    add     [di],al
F000:0A1A  [+0x00A1A]  0F FF 50 1D              ud0     dx,[bx+si+1Dh]
F000:0A1E  [+0x00A1E]  10 FF                    adc     bh,bh
F000:0A20  [+0x00A20]  FF 01                    inc     word [bx+di]
F000:0A22  [+0x00A22]  0F 00 0E EB C3           str     [0C3EBh]
F000:0A27  [+0x00A27]  9F                       lahf
F000:0A28  [+0x00A28]  A2 82 A6                 mov     [0A682h],al
F000:0A2B  [+0x00A2B]  10 0B                    adc     [bp+di],cl
F000:0A2D  [+0x00A2D]  3E 00 40 00              add     [bx+si],al
F000:0A31  [+0x00A31]  00 00                    add     [bx+si],al
F000:0A33  [+0x00A33]  00 00                    add     [bx+si],al
F000:0A35  [+0x00A35]  00 EA                    add     dl,ch
F000:0A37  [+0x00A37]  8C DF                    mov     di,ds
F000:0A39  [+0x00A39]  A0 00 E7                 mov     al,[0E700h]
F000:0A3C  [+0x00A3C]  04 E3                    add     al,0E3h
F000:0A3E  [+0x00A3E]  FF 00                    inc     word [bx+si]
F000:0A40  [+0x00A40]  01 02                    add     [bp+si],ax
F000:0A42  [+0x00A42]  03 04                    add     ax,[si]
F000:0A44  [+0x00A44]  05 06 07                 add     ax,706h
F000:0A47  [+0x00A47]  08 09                    or      [bx+di],cl
F000:0A49  [+0x00A49]  0A 0B                    or      cl,[bp+di]
F000:0A4B  [+0x00A4B]  0C 0D                    or      al,0Dh
F000:0A4D  [+0x00A4D]  0E                       push    cs
F000:0A4E  [+0x00A4E]  0F 01 00                 sgdt    [bx+si]
F000:0A51  [+0x00A51]  0F 00 00                 sldt    [bx+si]
F000:0A54  [+0x00A54]  00 00                    add     [bx+si],al
F000:0A56  [+0x00A56]  00 00                    add     [bx+si],al
F000:0A58  [+0x00A58]  00 05                    add     [di],al
F000:0A5A  [+0x00A5A]  0F FF 80 2F 10           ud0     ax,[bx+si+102Fh]
F000:0A5F  [+0x00A5F]  DB 0xFF  (bad)
F000:0A61  [+0x00A61]  01 0F                    add     [bx],cx
F000:0A63  [+0x00A63]  00 0E 2F A2              add     [0A22Fh],cl
F000:0A67  [+0x00A67]  7F 80                    jg      short 09E9h
F000:0A69  [+0x00A69]  83 89 82 28 FD           or      word [bx+di+2882h],0FFFDh
F000:0A6E  [+0x00A6E]  00 60 00                 add     [bx+si],ah
F000:0A71  [+0x00A71]  00 00                    add     [bx+si],al
F000:0A73  [+0x00A73]  00 00                    add     [bx+si],al
F000:0A75  [+0x00A75]  00 02                    add     [bp+si],al
F000:0A77  [+0x00A77]  8A FF                    mov     bh,bh
F000:0A79  [+0x00A79]  80 00 02                 add     byte [bx+si],2
F000:0A7C  [+0x00A7C]  25 E3 FF                 and     ax,0FFE3h
F000:0A7F  [+0x00A7F]  00 01                    add     [bx+di],al
F000:0A81  [+0x00A81]  02 03                    add     al,[bp+di]
F000:0A83  [+0x00A83]  04 05                    add     al,5
F000:0A85  [+0x00A85]  06                       push    es
F000:0A86  [+0x00A86]  07                       pop     es
F000:0A87  [+0x00A87]  08 09                    or      [bx+di],cl
F000:0A89  [+0x00A89]  0A 0B                    or      cl,[bp+di]
F000:0A8B  [+0x00A8B]  0C 0D                    or      al,0Dh
F000:0A8D  [+0x00A8D]  0E                       push    cs
F000:0A8E  [+0x00A8E]  0F 01 00                 sgdt    [bx+si]
F000:0A91  [+0x00A91]  0F 00 00                 sldt    [bx+si]
F000:0A94  [+0x00A94]  00 00                    add     [bx+si],al
F000:0A96  [+0x00A96]  00 00                    add     [bx+si],al
F000:0A98  [+0x00A98]  00 05                    add     [di],al
F000:0A9A  [+0x00A9A]  0F FF 80 2F 10           ud0     ax,[bx+si+102Fh]
F000:0A9F  [+0x00A9F]  DB 0xFF  (bad)
F000:0AA1  [+0x00AA1]  01 0F                    add     [bx],cx
F000:0AA3  [+0x00AA3]  00 0E 2F 99              add     [992Fh],cl
F000:0AA7  [+0x00AA7]  7F 80                    jg      short 0A29h
F000:0AA9  [+0x00AA9]  9A 84 17 9B 1F           call    1F9Bh:1784h
F000:0AAE  [+0x00AAE]  00 40 00                 add     [bx+si],al
F000:0AB1  [+0x00AB1]  00 00                    add     [bx+si],al
F000:0AB3  [+0x00AB3]  00 00                    add     [bx+si],al
F000:0AB5  [+0x00AB5]  00 84 8E 7F              add     [si+7F8Eh],al
F000:0AB9  [+0x00AB9]  80 00 81                 add     byte [bx+si],81h
F000:0ABC  [+0x00ABC]  9A E3 FF 00 01           call    0100h:0FFE3h
F000:0AC1  [+0x00AC1]  02 03                    add     al,[bp+di]
F000:0AC3  [+0x00AC3]  04 05                    add     al,5
F000:0AC5  [+0x00AC5]  06                       push    es
F000:0AC6  [+0x00AC6]  07                       pop     es
F000:0AC7  [+0x00AC7]  08 09                    or      [bx+di],cl
F000:0AC9  [+0x00AC9]  0A 0B                    or      cl,[bp+di]
F000:0ACB  [+0x00ACB]  0C 0D                    or      al,0Dh
F000:0ACD  [+0x00ACD]  0E                       push    cs
F000:0ACE  [+0x00ACE]  0F 01 00                 sgdt    [bx+si]
F000:0AD1  [+0x00AD1]  0F 00 00                 sldt    [bx+si]
F000:0AD4  [+0x00AD4]  00 00                    add     [bx+si],al
F000:0AD6  [+0x00AD6]  00 00                    add     [bx+si],al
F000:0AD8  [+0x00AD8]  00 05                    add     [di],al
F000:0ADA  [+0x00ADA]  0F FF 16 20 22           ud0     dx,[2220h]
F000:0ADF  [+0x00ADF]  24 24                    and     al,24h
F000:0AE1  [+0x00AE1]  30 32                    xor     [bp+si],dh
F000:0AE3  [+0x00AE3]  34 34                    xor     al,34h
F000:0AE5  [+0x00AE5]  40                       inc     ax
F000:0AE6  [+0x00AE6]  41                       inc     cx
F000:0AE7  [+0x00AE7]  60                       pusha
F000:0AE8  [+0x00AE8]  61                       popa
F000:0AE9  [+0x00AE9]  6A 70                    push    70h
F000:0AEB  [+0x00AEB]  72 72                    jb      short 0B5Fh
F000:0AED  [+0x00AED]  75 75                    jne     short 0B64h
F000:0AEF  [+0x00AEF]  79 7C                    jns     short 0B6Dh
F000:0AF1  [+0x00AF1]  7E 7E                    jle     short 0B71h
F000:0AF3  [+0x00AF3]  BE 19 5C                 mov     si,5C19h
F000:0AF6  [+0x00AF6]  04 BE                    add     al,0BEh
F000:0AF8  [+0x00AF8]  24 DC                    and     al,0DCh
F000:0AFA  [+0x00AFA]  09 BE 41 5C              or      [bp+5C41h],di
F000:0AFE  [+0x00AFE]  0A BE 2D 9C              or      bh,[bp-63D3h]
F000:0B02  [+0x00B02]  0A BE 19 5C              or      bh,[bp+5C19h]
F000:0B06  [+0x00B06]  04 BE                    add     al,0BEh
F000:0B08  [+0x00B08]  24 DC                    and     al,0DCh
F000:0B0A  [+0x00B0A]  09 BE 41 5C              or      [bp+5C41h],di
F000:0B0E  [+0x00B0E]  0A BE 2D 9C              or      bh,[bp-63D3h]
F000:0B12  [+0x00B12]  0A BE 32 1C              or      bh,[bp+1C32h]
F000:0B16  [+0x00B16]  0A BE 32 1C              or      bh,[bp+1C32h]
F000:0B1A  [+0x00B1A]  0A 33                    or      dh,[bp+di]
F000:0B1C  [+0x00B1C]  28 DC                    sub     ah,bl
F000:0B1E  [+0x00B1E]  05 03 28                 add     ax,2803h
F000:0B21  [+0x00B21]  1C 06                    sbb     al,6
F000:0B23  [+0x00B23]  32 28                    xor     ch,[bx+si]
F000:0B25  [+0x00B25]  1C 04                    sbb     al,4
F000:0B27  [+0x00B27]  32 28                    xor     ch,[bx+si]
F000:0B29  [+0x00B29]  1C 04                    sbb     al,4
F000:0B2B  [+0x00B2B]  BA 41 5C                 mov     dx,5C41h
F000:0B2E  [+0x00B2E]  09 BA 2D 9C              or      [bp+si-63D3h],di
F000:0B32  [+0x00B32]  09 BA 41 5C              or      [bp+si+5C41h],di
F000:0B36  [+0x00B36]  09 BA 2D 9C              or      [bp+si-63D3h],di
F000:0B3A  [+0x00B3A]  09 BE 19 5C              or      [bp+5C19h],di
F000:0B3E  [+0x00B3E]  04 BE                    add     al,0BEh
F000:0B40  [+0x00B40]  24 DC                    and     al,0DCh
F000:0B42  [+0x00B42]  09 BE 41 5C              or      [bp+5C41h],di
F000:0B46  [+0x00B46]  0A BE 2D 9C              or      bh,[bp-63D3h]
F000:0B4A  [+0x00B4A]  0A 02                    or      al,[bp+si]
F000:0B4C  [+0x00B4C]  01 04                    add     [si],ax
F000:0B4E  [+0x00B4E]  A1 05 00                 mov     ax,[5]
F000:0B51  [+0x00B51]  0B 00                    or      ax,[bx+si]
F000:0B53  [+0x00B53]  08 00                    or      [bx+si],al
F000:0B55  [+0x00B55]  0C 00                    or      al,0
F000:0B57  [+0x00B57]  0D 00 0E                 or      ax,0E00h
F000:0B5A  [+0x00B5A]  80 10 00                 adc     byte [bx+si],0
F000:0B5D  [+0x00B5D]  11 00                    adc     [bx+si],ax
F000:0B5F  [+0x00B5F]  51                       push    cx
F000:0B60  [+0x00B60]  63 14                    arpl    [si],dx
F000:0B62  [+0x00B62]  00 15                    add     [di],dl
F000:0B64  [+0x00B64]  00 16 00 17              add     [1700h],dl
F000:0B68  [+0x00B68]  00 1F                    add     [bx],bl
F000:0B6A  [+0x00B6A]  00 24                    add     [si],ah
F000:0B6C  [+0x00B6C]  12 25                    adc     ah,[di]
F000:0B6E  [+0x00B6E]  59                       pop     cx
F000:0B6F  [+0x00B6F]  26 00 28                 add     [es:bx+si],ch
F000:0B72  [+0x00B72]  80 29 4C                 sub     byte [bx+di],4Ch
F000:0B75  [+0x00B75]  2B 00                    sub     ax,[bx+si]
F000:0B77  [+0x00B77]  33 60 30                 xor     sp,[bx+si+30h]
F000:0B7A  [+0x00B7A]  03 31                    add     si,[bx+di]
F000:0B7C  [+0x00B7C]  6B 32 3C                 imul    si,[bp+si],3Ch
F000:0B7F  [+0x00B7F]  33 40 30                 xor     ax,[bx+si+30h]
F000:0B82  [+0x00B82]  03 31                    add     si,[bx+di]
F000:0B84  [+0x00B84]  4E                       dec     si
F000:0B85  [+0x00B85]  32 59 00                 xor     bl,[bx+di]
F000:0B88  [+0x00B88]  00 00                    add     [bx+si],al
F000:0B8A  [+0x00B8A]  00 00                    add     [bx+si],al
F000:0B8C  [+0x00B8C]  00 00                    add     [bx+si],al
F000:0B8E  [+0x00B8E]  00 44 10                 add     [si+10h],al
F000:0B91  [+0x00B91]  45                       inc     bp
F000:0B92  [+0x00B92]  00 4F 04                 add     [bx+4],cl
F000:0B95  [+0x00B95]  58                       pop     ax
F000:0B96  [+0x00B96]  00 59 84                 add     [bx+di-7Ch],bl
F000:0B99  [+0x00B99]  5A                       pop     dx
F000:0B9A  [+0x00B9A]  00 5C 02                 add     [si+2],bl
F000:0B9D  [+0x00B9D]  5F                       pop     di
F000:0B9E  [+0x00B9E]  06                       push    es
F000:0B9F  [+0x00B9F]  60                       pusha
F000:0BA0  [+0x00BA0]  88 61 2E                 mov     [bx+di+2Eh],ah
F000:0BA3  [+0x00BA3]  62 07                    bound   ax,[bx]
F000:0BA5  [+0x00BA5]  63 01                    arpl    [bx+di],ax
F000:0BA7  [+0x00BA7]  70 80                    jo      short 0B29h
F000:0BA9  [+0x00BA9]  72 24                    jb      short 0BCFh
F000:0BAB  [+0x00BAB]  00 00                    add     [bx+si],al
F000:0BAD  [+0x00BAD]  52                       push    dx
F000:0BAE  [+0x00BAE]  41                       inc     cx
F000:0BAF  [+0x00BAF]  53                       push    bx
F000:0BB0  [+0x00BB0]  00 6F 00                 add     [bx],ch
F000:0BB3  [+0x00BB3]  00 00                    add     [bx+si],al
F000:0BB5  [+0x00BB5]  00 00                    add     [bx+si],al
F000:0BB7  [+0x00BB7]  52                       push    dx
F000:0BB8  [+0x00BB8]  41                       inc     cx
F000:0BB9  [+0x00BB9]  06                       push    es
F000:0BBA  [+0x00BBA]  C2 0F 10                 ret     100Fh
F000:0BBD  [+0x00BBD]  4F                       dec     di
F000:0BBE  [+0x00BBE]  04 50                    add     al,50h
F000:0BC0  [+0x00BC0]  15 51 63                 adc     ax,6351h
F000:0BC3  [+0x00BC3]  54                       push    sp
F000:0BC4  [+0x00BC4]  3A 55 E5                 cmp     dl,[di-1Bh]
F000:0BC7  [+0x00BC7]  56                       push    si
F000:0BC8  [+0x00BC8]  00 57 1B                 add     [bx+1Bh],dl
F000:0BCB  [+0x00BCB]  5B                       pop     bx
F000:0BCC  [+0x00BCC]  DB 0x8F  (bad)
F000:0BD0  [+0x00BD0]  80 6C 02 6E              sub     byte [si+2],6Eh
F000:0BD4  [+0x00BD4]  DA 6F 1B                 fisubr  dword [bx+1Bh]
F000:0BD7  [+0x00BD7]  00 00                    add     [bx+si],al
F000:0BD9  [+0x00BD9]  00 00                    add     [bx+si],al
F000:0BDB  [+0x00BDB]  00 00                    add     [bx+si],al
F000:0BDD  [+0x00BDD]  19 55 1A                 sbb     [di+1Ah],dx
F000:0BE0  [+0x00BE0]  00 1B                    add     [bp+di],bl
F000:0BE2  [+0x00BE2]  5E                       pop     si
F000:0BE3  [+0x00BE3]  1C 4F                    sbb     al,4Fh
F000:0BE5  [+0x00BE5]  2C 15                    sub     al,15h
F000:0BE7  [+0x00BE7]  2D 50 2E                 sub     ax,2E50h
F000:0BEA  [+0x00BEA]  50                       push    ax
F000:0BEB  [+0x00BEB]  2F                       das
F000:0BEC  [+0x00BEC]  00 53 1C                 add     [bp+di+1Ch],dl
F000:0BEF  [+0x00BEF]  50                       push    ax
F000:0BF0  [+0x00BF0]  15 64 FF                 adc     ax,0FF64h
F000:0BF3  [+0x00BF3]  65 07                    pop     es
F000:0BF5  [+0x00BF5]  66 EA 67 0C 68 DF 6F 1B  jmp     dword 1B6Fh:0DF680C67h
F000:0BFD  [+0x00BFD]  00 00                    add     [bx+si],al
F000:0BFF  [+0x00BFF]  00 00                    add     [bx+si],al
F000:0C01  [+0x00C01]  00 00                    add     [bx+si],al
F000:0C03  [+0x00C03]  19 57 1A                 sbb     [bx+1Ah],dx
F000:0C06  [+0x00C06]  19 1B                    sbb     [bp+di],bx
F000:0C08  [+0x00C08]  59                       pop     cx
F000:0C09  [+0x00C09]  1C 4F                    sbb     al,4Fh
F000:0C0B  [+0x00C0B]  2C 04                    sub     al,4
F000:0C0D  [+0x00C0D]  2D 50 2E                 sub     ax,2E50h
F000:0C10  [+0x00C10]  50                       push    ax
F000:0C11  [+0x00C11]  2F                       das
F000:0C12  [+0x00C12]  00 50 15                 add     [bx+si+15h],dl
F000:0C15  [+0x00C15]  53                       push    bx
F000:0C16  [+0x00C16]  1C 64                    sbb     al,64h
F000:0C18  [+0x00C18]  E4 65                    in      al,65h
F000:0C1A  [+0x00C1A]  07                       pop     es
F000:0C1B  [+0x00C1B]  66 E0 67                 o32 loopne 00000C85h
F000:0C1E  [+0x00C1E]  01 68 DF                 add     [bx+si-21h],bp
F000:0C21  [+0x00C21]  6F                       outsw
F000:0C22  [+0x00C22]  1B 00                    sbb     ax,[bx+si]
F000:0C24  [+0x00C24]  00 00                    add     [bx+si],al
F000:0C26  [+0x00C26]  00 00                    add     [bx+si],al
F000:0C28  [+0x00C28]  00 00                    add     [bx+si],al
F000:0C2A  [+0x00C2A]  46                       inc     si
F000:0C2B  [+0x00C2B]  6F                       outsw
F000:0C2C  [+0x00C2C]  72 20                    jb      short 0C4Eh
F000:0C2E  [+0x00C2E]  45                       inc     bp
F000:0C2F  [+0x00C2F]  76 61                    jbe     short 0C92h
F000:0C31  [+0x00C31]  6C                       insb
F000:0C32  [+0x00C32]  75 61                    jne     short 0C95h
F000:0C34  [+0x00C34]  74 69                    je      short 0C9Fh
F000:0C36  [+0x00C36]  6F                       outsw
F000:0C37  [+0x00C37]  6E                       outsb
F000:0C38  [+0x00C38]  20 55 73                 and     [di+73h],dl
F000:0C3B  [+0x00C3B]  65 20 4F 6E              and     [gs:bx+6Eh],cl
F000:0C3F  [+0x00C3F]  6C                       insb
F000:0C40  [+0x00C40]  79 2E                    jns     short 0C70h
F000:0C42  [+0x00C42]  0D 0A 00                 or      ax,0Ah
F000:0C45  [+0x00C45]  00 52 50                 add     [bp+si+50h],dl
F000:0C48  [+0x00C48]  BA D6 03                 mov     dx,3D6h
F000:0C4B  [+0x00C4B]  EC                       in      al,dx
F000:0C4C  [+0x00C4C]  50                       push    ax
F000:0C4D  [+0x00C4D]  B0 51                    mov     al,51h
F000:0C4F  [+0x00C4F]  E8 DA 13                 call    202Ch
F000:0C52  [+0x00C52]  F6 C4 04                 test    ah,4
F000:0C55  [+0x00C55]  58                       pop     ax
F000:0C56  [+0x00C56]  BA D6 03                 mov     dx,3D6h
F000:0C59  [+0x00C59]  EE                       out     dx,al
F000:0C5A  [+0x00C5A]  58                       pop     ax
F000:0C5B  [+0x00C5B]  5A                       pop     dx
F000:0C5C  [+0x00C5C]  C3                       ret
F000:0C5D  [+0x00C5D]  50                       push    ax
F000:0C5E  [+0x00C5E]  52                       push    dx
F000:0C5F  [+0x00C5F]  EB 07                    jmp     short 0C68h
F000:0C61  [+0x00C61]  50                       push    ax
F000:0C62  [+0x00C62]  52                       push    dx
F000:0C63  [+0x00C63]  E8 E0 FF                 call    0C46h
F000:0C66  [+0x00C66]  74 21                    je      short 0C89h
F000:0C68  [+0x00C68]  B8 01 00                 mov     ax,1
F000:0C6B  [+0x00C6B]  2E F6 06 7F 01 20        test    byte [cs:17Fh],20h
F000:0C71  [+0x00C71]  74 11                    je      short 0C84h
F000:0C73  [+0x00C73]  B0 06                    mov     al,6
F000:0C75  [+0x00C75]  BA D6 03                 mov     dx,3D6h
F000:0C78  [+0x00C78]  E8 1E 44                 call    5099h
F000:0C7B  [+0x00C7B]  D0 E8                    shr     al,1
F000:0C7D  [+0x00C7D]  A8 01                    test    al,1
F000:0C7F  [+0x00C7F]  75 03                    jne     short 0C84h
F000:0C81  [+0x00C81]  B8 01 01                 mov     ax,101h
F000:0C84  [+0x00C84]  25 01 01                 and     ax,101h
F000:0C87  [+0x00C87]  3A E0                    cmp     ah,al
F000:0C89  [+0x00C89]  5A                       pop     dx
F000:0C8A  [+0x00C8A]  58                       pop     ax
F000:0C8B  [+0x00C8B]  C3                       ret
F000:0C8C  [+0x00C8C]  E8 52 46                 call    52E1h
F000:0C8F  [+0x00C8F]  E8 01 00                 call    0C93h
F000:0C92  [+0x00C92]  C3                       ret
F000:0C93  [+0x00C93]  80 26 89 04 F9           and     byte [489h],0F9h
F000:0C98  [+0x00C98]  33 FF                    xor     di,di
F000:0C9A  [+0x00C9A]  E8 96 13                 call    2033h
F000:0C9D  [+0x00C9D]  80 E4 F3                 and     ah,0F3h
F000:0CA0  [+0x00CA0]  2E F6 06 7D 01 04        test    byte [cs:17Dh],4
F000:0CA6  [+0x00CA6]  74 05                    je      short 0CADh
F000:0CA8  [+0x00CA8]  80 0E 89 04 08           or      byte [489h],8
F000:0CAD  [+0x00CAD]  EB 00                    jmp     short 0CAFh
F000:0CAF  [+0x00CAF]  B0 FF                    mov     al,0FFh
F000:0CB1  [+0x00CB1]  BA C6 03                 mov     dx,3C6h
F000:0CB4  [+0x00CB4]  EE                       out     dx,al
F000:0CB5  [+0x00CB5]  BA 55 00                 mov     dx,55h
F000:0CB8  [+0x00CB8]  B8 35 5F                 mov     ax,5F35h
F000:0CBB  [+0x00CBB]  CD 15                    int     15h
F000:0CBD  [+0x00CBD]  52                       push    dx
F000:0CBE  [+0x00CBE]  B0 00                    mov     al,0
F000:0CC0  [+0x00CC0]  BA C6 03                 mov     dx,3C6h
F000:0CC3  [+0x00CC3]  EE                       out     dx,al
F000:0CC4  [+0x00CC4]  5A                       pop     dx
F000:0CC5  [+0x00CC5]  83 FA 55                 cmp     dx,55h
F000:0CC8  [+0x00CC8]  74 0C                    je      short 0CD6h
F000:0CCA  [+0x00CCA]  80 FA 00                 cmp     dl,0
F000:0CCD  [+0x00CCD]  74 15                    je      short 0CE4h
F000:0CCF  [+0x00CCF]  80 FA 01                 cmp     dl,1
F000:0CD2  [+0x00CD2]  74 4C                    je      short 0D20h
F000:0CD4  [+0x00CD4]  EB 31                    jmp     short 0D07h
F000:0CD6  [+0x00CD6]  32 DB                    xor     bl,bl
F000:0CD8  [+0x00CD8]  2E A0 99 01              mov     al,[cs:199h]
F000:0CDC  [+0x00CDC]  24 C0                    and     al,0C0h
F000:0CDE  [+0x00CDE]  3C C0                    cmp     al,0C0h
F000:0CE0  [+0x00CE0]  74 02                    je      short 0CE4h
F000:0CE2  [+0x00CE2]  EB 1B                    jmp     short 0CFFh
F000:0CE4  [+0x00CE4]  E8 11 13                 call    1FF8h
F000:0CE7  [+0x00CE7]  EB 48                    jmp     short 0D31h
F000:0CE9  [+0x00CE9]  F6 C3 10                 test    bl,10h
F000:0CEC  [+0x00CEC]  75 11                    jne     short 0CFFh
F000:0CEE  [+0x00CEE]  F6 C3 08                 test    bl,8
F000:0CF1  [+0x00CF1]  74 3E                    je      short 0D31h
F000:0CF3  [+0x00CF3]  80 0E 89 04 06           or      byte [489h],6
F000:0CF8  [+0x00CF8]  EB EA                    jmp     short 0CE4h
F000:0CFA  [+0x00CFA]  F6 C3 08                 test    bl,8
F000:0CFD  [+0x00CFD]  75 00                    jne     short 0CFFh
F000:0CFF  [+0x00CFF]  2E F6 06 7F 01 20        test    byte [cs:17Fh],20h
F000:0D05  [+0x00D05]  74 19                    je      short 0D20h
F000:0D07  [+0x00D07]  8A D3                    mov     dl,bl
F000:0D09  [+0x00D09]  0A D2                    or      dl,dl
F000:0D0B  [+0x00D0B]  B1 20                    mov     cl,20h
F000:0D0D  [+0x00D0D]  B3 02                    mov     bl,2
F000:0D0F  [+0x00D0F]  75 0A                    jne     short 0D1Bh
F000:0D11  [+0x00D11]  2E A0 99 01              mov     al,[cs:199h]
F000:0D15  [+0x00D15]  A8 40                    test    al,40h
F000:0D17  [+0x00D17]  75 0B                    jne     short 0D24h
F000:0D19  [+0x00D19]  EB 05                    jmp     short 0D20h
F000:0D1B  [+0x00D1B]  F6 C2 20                 test    dl,20h
F000:0D1E  [+0x00D1E]  75 04                    jne     short 0D24h
F000:0D20  [+0x00D20]  B1 10                    mov     cl,10h
F000:0D22  [+0x00D22]  B3 01                    mov     bl,1
F000:0D24  [+0x00D24]  E8 D1 12                 call    1FF8h
F000:0D27  [+0x00D27]  8A C1                    mov     al,cl
F000:0D29  [+0x00D29]  E8 FA 16                 call    2426h
F000:0D2C  [+0x00D2C]  57                       push    di
F000:0D2D  [+0x00D2D]  E8 0A 00                 call    0D3Ah
F000:0D30  [+0x00D30]  5F                       pop     di
F000:0D31  [+0x00D31]  0B FF                    or      di,di
F000:0D33  [+0x00D33]  C3                       ret
F000:0D34  [+0x00D34]  E8 F5 12                 call    202Ch
F000:0D37  [+0x00D37]  53                       push    bx
F000:0D38  [+0x00D38]  EB 0B                    jmp     short 0D45h
F000:0D3A  [+0x00D3A]  53                       push    bx
F000:0D3B  [+0x00D3B]  B7 03                    mov     bh,3
F000:0D3D  [+0x00D3D]  E8 9A 08                 call    15DAh
F000:0D40  [+0x00D40]  8A DD                    mov     bl,ch
F000:0D42  [+0x00D42]  E8 6E 09                 call    16B3h
F000:0D45  [+0x00D45]  B7 02                    mov     bh,2
F000:0D47  [+0x00D47]  E8 90 08                 call    15DAh
F000:0D4A  [+0x00D4A]  8A D9                    mov     bl,cl
F000:0D4C  [+0x00D4C]  E8 64 09                 call    16B3h
F000:0D4F  [+0x00D4F]  5B                       pop     bx
F000:0D50  [+0x00D50]  C3                       ret
F000:0D51  [+0x00D51]  E8 17 00                 call    0D6Bh
F000:0D54  [+0x00D54]  89 5E 0E                 mov     [bp+0Eh],bx
F000:0D57  [+0x00D57]  89 4E 0C                 mov     [bp+0Ch],cx
F000:0D5A  [+0x00D5A]  89 56 0A                 mov     [bp+0Ah],dx
F000:0D5D  [+0x00D5D]  89 76 08                 mov     [bp+8],si
F000:0D60  [+0x00D60]  89 7E 06                 mov     [bp+6],di
F000:0D63  [+0x00D63]  C7 46 10 5F 01           mov     word [bp+10h],15Fh
F000:0D68  [+0x00D68]  32 C0                    xor     al,al
F000:0D6A  [+0x00D6A]  C3                       ret
F000:0D6B  [+0x00D6B]  E8 C5 12                 call    2033h
F000:0D6E  [+0x00D6E]  80 E4 03                 and     ah,3
F000:0D71  [+0x00D71]  BE 10 00                 mov     si,10h
F000:0D74  [+0x00D74]  80 FC 01                 cmp     ah,1
F000:0D77  [+0x00D77]  77 03                    ja      short 0D7Ch
F000:0D79  [+0x00D79]  BE 08 00                 mov     si,8
F000:0D7C  [+0x00D7C]  33 DB                    xor     bx,bx
F000:0D7E  [+0x00D7E]  2E 8A 1E 96 01           mov     bl,[cs:196h]
F000:0D83  [+0x00D83]  B1 04                    mov     cl,4
F000:0D85  [+0x00D85]  D3 E3                    shl     bx,cl
F000:0D87  [+0x00D87]  2E 0A 3E 81 01           or      bh,[cs:181h]
F000:0D8C  [+0x00D8C]  BA D4 03                 mov     dx,3D4h
F000:0D8F  [+0x00D8F]  B0 01                    mov     al,1
F000:0D91  [+0x00D91]  EE                       out     dx,al
F000:0D92  [+0x00D92]  ED                       in      ax,dx
F000:0D93  [+0x00D93]  8A C4                    mov     al,ah
F000:0D95  [+0x00D95]  FE C0                    inc     al
F000:0D97  [+0x00D97]  B1 08                    mov     cl,8
F000:0D99  [+0x00D99]  F6 E1                    mul     cl
F000:0D9B  [+0x00D9B]  8B D0                    mov     dx,ax
F000:0D9D  [+0x00D9D]  50                       push    ax
F000:0D9E  [+0x00D9E]  E8 77 07                 call    1518h
F000:0DA1  [+0x00DA1]  80 FC 20                 cmp     ah,20h
F000:0DA4  [+0x00DA4]  72 07                    jb      short 0DADh
F000:0DA6  [+0x00DA6]  80 FC 2F                 cmp     ah,2Fh
F000:0DA9  [+0x00DA9]  77 02                    ja      short 0DADh
F000:0DAB  [+0x00DAB]  D1 EA                    shr     dx,1
F000:0DAD  [+0x00DAD]  58                       pop     ax
F000:0DAE  [+0x00DAE]  33 C9                    xor     cx,cx
F000:0DB0  [+0x00DB0]  33 FF                    xor     di,di
F000:0DB2  [+0x00DB2]  C3                       ret
F000:0DB3  [+0x00DB3]  C6 46 10 5F              mov     byte [bp+10h],5Fh
F000:0DB7  [+0x00DB7]  2E A1 D6 01              mov     ax,[cs:1D6h]
F000:0DBB  [+0x00DBB]  89 46 0E                 mov     [bp+0Eh],ax
F000:0DBE  [+0x00DBE]  2E A1 D8 01              mov     ax,[cs:1D8h]
F000:0DC2  [+0x00DC2]  89 46 0C                 mov     [bp+0Ch],ax
F000:0DC5  [+0x00DC5]  2E 8A 1E DA 01           mov     bl,[cs:1DAh]
F000:0DCA  [+0x00DCA]  83 E3 01                 and     bx,1
F000:0DCD  [+0x00DCD]  E8 76 FE                 call    0C46h
F000:0DD0  [+0x00DD0]  74 0B                    je      short 0DDDh
F000:0DD2  [+0x00DD2]  80 CB 02                 or      bl,2
F000:0DD5  [+0x00DD5]  E8 85 FE                 call    0C5Dh
F000:0DD8  [+0x00DD8]  75 03                    jne     short 0DDDh
F000:0DDA  [+0x00DDA]  80 CB 08                 or      bl,8
F000:0DDD  [+0x00DDD]  BA C4 03                 mov     dx,3C4h
F000:0DE0  [+0x00DE0]  B0 04                    mov     al,4
F000:0DE2  [+0x00DE2]  E8 A5 42                 call    508Ah
F000:0DE5  [+0x00DE5]  B0 61                    mov     al,61h
F000:0DE7  [+0x00DE7]  80 FC 02                 cmp     ah,2
F000:0DEA  [+0x00DEA]  74 07                    je      short 0DF3h
F000:0DEC  [+0x00DEC]  80 FC 03                 cmp     ah,3
F000:0DEF  [+0x00DEF]  74 02                    je      short 0DF3h
F000:0DF1  [+0x00DF1]  B0 63                    mov     al,63h
F000:0DF3  [+0x00DF3]  E8 36 12                 call    202Ch
F000:0DF6  [+0x00DF6]  F6 C4 80                 test    ah,80h
F000:0DF9  [+0x00DF9]  74 03                    je      short 0DFEh
F000:0DFB  [+0x00DFB]  80 CB 04                 or      bl,4
F000:0DFE  [+0x00DFE]  E8 32 12                 call    2033h
F000:0E01  [+0x00E01]  F6 C4 80                 test    ah,80h
F000:0E04  [+0x00E04]  74 03                    je      short 0E09h
F000:0E06  [+0x00E06]  80 CF 01                 or      bh,1
F000:0E09  [+0x00E09]  B0 57                    mov     al,57h
F000:0E0B  [+0x00E0B]  E8 1E 12                 call    202Ch
F000:0E0E  [+0x00E0E]  F6 C4 02                 test    ah,2
F000:0E11  [+0x00E11]  74 03                    je      short 0E16h
F000:0E13  [+0x00E13]  80 CF 02                 or      bh,2
F000:0E16  [+0x00E16]  F6 C4 20                 test    ah,20h
F000:0E19  [+0x00E19]  74 03                    je      short 0E1Eh
F000:0E1B  [+0x00E1B]  80 CF 04                 or      bh,4
F000:0E1E  [+0x00E1E]  89 5E 0A                 mov     [bp+0Ah],bx
F000:0E21  [+0x00E21]  C6 46 11 01              mov     byte [bp+11h],1
F000:0E25  [+0x00E25]  32 C0                    xor     al,al
F000:0E27  [+0x00E27]  C3                       ret
F000:0E28  [+0x00E28]  B0 1F                    mov     al,1Fh
F000:0E2A  [+0x00E2A]  E8 FF 11                 call    202Ch
F000:0E2D  [+0x00E2D]  F6 C4 08                 test    ah,8
F000:0E30  [+0x00E30]  74 03                    je      short 0E35h
F000:0E32  [+0x00E32]  E9 AA 00                 jmp     0EDFh
F000:0E35  [+0x00E35]  80 E4 F4                 and     ah,0F4h
F000:0E38  [+0x00E38]  0A E3                    or      ah,bl
F000:0E3A  [+0x00E3A]  FE C4                    inc     ah
F000:0E3C  [+0x00E3C]  50                       push    ax
F000:0E3D  [+0x00E3D]  80 0E 89 04 08           or      byte [489h],8
F000:0E42  [+0x00E42]  E8 72 44                 call    52B7h
F000:0E45  [+0x00E45]  C7 46 10 5F 00           mov     word [bp+10h],5Fh
F000:0E4A  [+0x00E4A]  E8 AB 11                 call    1FF8h
F000:0E4D  [+0x00E4D]  0A DB                    or      bl,bl
F000:0E4F  [+0x00E4F]  74 03                    je      short 0E54h
F000:0E51  [+0x00E51]  E8 E6 FE                 call    0D3Ah
F000:0E54  [+0x00E54]  B0 00                    mov     al,0
F000:0E56  [+0x00E56]  0A DB                    or      bl,bl
F000:0E58  [+0x00E58]  74 02                    je      short 0E5Ch
F000:0E5A  [+0x00E5A]  B0 10                    mov     al,10h
F000:0E5C  [+0x00E5C]  E8 C7 15                 call    2426h
F000:0E5F  [+0x00E5F]  33 C0                    xor     ax,ax
F000:0E61  [+0x00E61]  8E D8                    mov     ds,ax
F000:0E63  [+0x00E63]  E8 96 00                 call    0EFCh
F000:0E66  [+0x00E66]  75 05                    jne     short 0E6Dh
F000:0E68  [+0x00E68]  E8 C9 03                 call    1234h
F000:0E6B  [+0x00E6B]  75 00                    jne     short 0E6Dh
F000:0E6D  [+0x00E6D]  A0 49 04                 mov     al,[449h]
F000:0E70  [+0x00E70]  3C 13                    cmp     al,13h
F000:0E72  [+0x00E72]  76 44                    jbe     short 0EB8h
F000:0E74  [+0x00E74]  50                       push    ax
F000:0E75  [+0x00E75]  E8 6A 09                 call    17E2h
F000:0E78  [+0x00E78]  58                       pop     ax
F000:0E79  [+0x00E79]  E8 65 11                 call    1FE1h
F000:0E7C  [+0x00E7C]  75 3A                    jne     short 0EB8h
F000:0E7E  [+0x00E7E]  50                       push    ax
F000:0E7F  [+0x00E7F]  BA D6 03                 mov     dx,3D6h
F000:0E82  [+0x00E82]  B3 00                    mov     bl,0
F000:0E84  [+0x00E84]  E8 BF FD                 call    0C46h
F000:0E87  [+0x00E87]  75 0E                    jne     short 0E97h
F000:0E89  [+0x00E89]  E8 A7 11                 call    2033h
F000:0E8C  [+0x00E8C]  F6 C4 40                 test    ah,40h
F000:0E8F  [+0x00E8F]  75 06                    jne     short 0E97h
F000:0E91  [+0x00E91]  B3 20                    mov     bl,20h
F000:0E93  [+0x00E93]  B8 19 4C                 mov     ax,4C19h
F000:0E96  [+0x00E96]  EF                       out     dx,ax
F000:0E97  [+0x00E97]  B0 28                    mov     al,28h
F000:0E99  [+0x00E99]  EE                       out     dx,al
F000:0E9A  [+0x00E9A]  ED                       in      ax,dx
F000:0E9B  [+0x00E9B]  80 E4 DF                 and     ah,0DFh
F000:0E9E  [+0x00E9E]  0A E3                    or      ah,bl
F000:0EA0  [+0x00EA0]  EF                       out     dx,ax
F000:0EA1  [+0x00EA1]  A0 49 04                 mov     al,[449h]
F000:0EA4  [+0x00EA4]  E8 74 09                 call    181Bh
F000:0EA7  [+0x00EA7]  0E                       push    cs
F000:0EA8  [+0x00EA8]  07                       pop     es
F000:0EA9  [+0x00EA9]  B9 19 00                 mov     cx,19h
F000:0EAC  [+0x00EAC]  83 C6 0A                 add     si,0Ah
F000:0EAF  [+0x00EAF]  33 C0                    xor     ax,ax
F000:0EB1  [+0x00EB1]  E8 32 00                 call    0EE6h
F000:0EB4  [+0x00EB4]  E8 22 05                 call    13D9h
F000:0EB7  [+0x00EB7]  58                       pop     ax
F000:0EB8  [+0x00EB8]  E8 77 05                 call    1432h
F000:0EBB  [+0x00EBB]  A0 49 04                 mov     al,[449h]
F000:0EBE  [+0x00EBE]  E8 F8 06                 call    15B9h
F000:0EC1  [+0x00EC1]  E8 82 FD                 call    0C46h
F000:0EC4  [+0x00EC4]  75 03                    jne     short 0EC9h
F000:0EC6  [+0x00EC6]  E8 18 04                 call    12E1h
F000:0EC9  [+0x00EC9]  80 26 89 04 F7           and     byte [489h],0F7h
F000:0ECE  [+0x00ECE]  E8 55 06                 call    1526h
F000:0ED1  [+0x00ED1]  E8 A1 05                 call    1475h
F000:0ED4  [+0x00ED4]  E8 D9 41                 call    50B0h
F000:0ED7  [+0x00ED7]  E8 E5 43                 call    52BFh
F000:0EDA  [+0x00EDA]  BA D6 03                 mov     dx,3D6h
F000:0EDD  [+0x00EDD]  58                       pop     ax
F000:0EDE  [+0x00EDE]  EF                       out     dx,ax
F000:0EDF  [+0x00EDF]  C6 46 11 01              mov     byte [bp+11h],1
F000:0EE3  [+0x00EE3]  32 C0                    xor     al,al
F000:0EE5  [+0x00EE5]  C3                       ret
F000:0EE6  [+0x00EE6]  50                       push    ax
F000:0EE7  [+0x00EE7]  8B 16 63 04              mov     dx,[463h]
F000:0EEB  [+0x00EEB]  B8 11 00                 mov     ax,11h
F000:0EEE  [+0x00EEE]  EF                       out     dx,ax
F000:0EEF  [+0x00EEF]  58                       pop     ax
F000:0EF0  [+0x00EF0]  03 F0                    add     si,ax
F000:0EF2  [+0x00EF2]  26 8A 24                 mov     ah,[es:si]
F000:0EF5  [+0x00EF5]  46                       inc     si
F000:0EF6  [+0x00EF6]  EF                       out     dx,ax
F000:0EF7  [+0x00EF7]  FE C0                    inc     al
F000:0EF9  [+0x00EF9]  E2 F7                    loop    0EF2h
F000:0EFB  [+0x00EFB]  C3                       ret
F000:0EFC  [+0x00EFC]  BA CE 03                 mov     dx,3CEh
F000:0EFF  [+0x00EFF]  EC                       in      al,dx
F000:0F00  [+0x00F00]  50                       push    ax
F000:0F01  [+0x00F01]  B0 06                    mov     al,6
F000:0F03  [+0x00F03]  EE                       out     dx,al
F000:0F04  [+0x00F04]  ED                       in      ax,dx
F000:0F05  [+0x00F05]  F6 C4 01                 test    ah,1
F000:0F08  [+0x00F08]  58                       pop     ax
F000:0F09  [+0x00F09]  EE                       out     dx,al
F000:0F0A  [+0x00F0A]  C3                       ret
F000:0F0B  [+0x00F0B]  50                       push    ax
F000:0F0C  [+0x00F0C]  51                       push    cx
F000:0F0D  [+0x00F0D]  52                       push    dx
F000:0F0E  [+0x00F0E]  B0 6C                    mov     al,6Ch
F000:0F10  [+0x00F10]  E8 19 11                 call    202Ch
F000:0F13  [+0x00F13]  8A CC                    mov     cl,ah
F000:0F15  [+0x00F15]  B0 04                    mov     al,4
F000:0F17  [+0x00F17]  E8 12 11                 call    202Ch
F000:0F1A  [+0x00F1A]  80 E4 DF                 and     ah,0DFh
F000:0F1D  [+0x00F1D]  F6 C1 02                 test    cl,2
F000:0F20  [+0x00F20]  75 01                    jne     short 0F23h
F000:0F22  [+0x00F22]  EF                       out     dx,ax
F000:0F23  [+0x00F23]  5A                       pop     dx
F000:0F24  [+0x00F24]  59                       pop     cx
F000:0F25  [+0x00F25]  58                       pop     ax
F000:0F26  [+0x00F26]  C3                       ret
F000:0F27  [+0x00F27]  C7 46 10 5F 00           mov     word [bp+10h],5Fh
F000:0F2C  [+0x00F2C]  C3                       ret
F000:0F2D  [+0x00F2D]  C7 46 10 5F 00           mov     word [bp+10h],5Fh
F000:0F32  [+0x00F32]  C3                       ret
F000:0F33  [+0x00F33]  C6 46 10 5F              mov     byte [bp+10h],5Fh
F000:0F37  [+0x00F37]  BA C4 03                 mov     dx,3C4h
F000:0F3A  [+0x00F3A]  B0 04                    mov     al,4
F000:0F3C  [+0x00F3C]  E8 5F 41                 call    509Eh
F000:0F3F  [+0x00F3F]  B0 61                    mov     al,61h
F000:0F41  [+0x00F41]  80 FC 02                 cmp     ah,2
F000:0F44  [+0x00F44]  74 07                    je      short 0F4Dh
F000:0F46  [+0x00F46]  80 FC 03                 cmp     ah,3
F000:0F49  [+0x00F49]  74 02                    je      short 0F4Dh
F000:0F4B  [+0x00F4B]  B0 63                    mov     al,63h
F000:0F4D  [+0x00F4D]  E8 DC 10                 call    202Ch
F000:0F50  [+0x00F50]  80 E4 7F                 and     ah,7Fh
F000:0F53  [+0x00F53]  D0 CB                    ror     bl,1
F000:0F55  [+0x00F55]  80 E3 80                 and     bl,80h
F000:0F58  [+0x00F58]  0A E3                    or      ah,bl
F000:0F5A  [+0x00F5A]  EF                       out     dx,ax
F000:0F5B  [+0x00F5B]  C6 46 11 01              mov     byte [bp+11h],1
F000:0F5F  [+0x00F5F]  32 C0                    xor     al,al
F000:0F61  [+0x00F61]  C3                       ret
F000:0F62  [+0x00F62]  C6 46 10 5F              mov     byte [bp+10h],5Fh
F000:0F66  [+0x00F66]  C6 46 11 00              mov     byte [bp+11h],0
F000:0F6A  [+0x00F6A]  C3                       ret
F000:0F6B  [+0x00F6B]  FE 0F                    dec     byte [bx]
F000:0F6D  [+0x00F6D]  FE 0F                    dec     byte [bx]
F000:0F6F  [+0x00F6F]  32 10                    xor     dl,[bx+si]
F000:0F71  [+0x00F71]  FE 0F                    dec     byte [bx]
F000:0F73  [+0x00F73]  32 10                    xor     dl,[bx+si]
F000:0F75  [+0x00F75]  75 10                    jne     short 0F87h
F000:0F77  [+0x00F77]  AD                       lodsw
F000:0F78  [+0x00F78]  10 B1 10 B5              adc     [bx+di-4AF0h],dh
F000:0F7C  [+0x00F7C]  10 CE                    adc     dh,cl
F000:0F7E  [+0x00F7E]  10 93 10 75              adc     [bp+di+7510h],dl
F000:0F82  [+0x00F82]  10 E7                    adc     bh,ah
F000:0F84  [+0x00F84]  10 EB                    adc     bl,ch
F000:0F86  [+0x00F86]  10 93 10 2B              adc     [bp+di+2B10h],dl
F000:0F8A  [+0x00F8A]  10 07                    adc     [bx],al
F000:0F8C  [+0x00F8C]  11 1A                    adc     [bp+si],bx
F000:0F8E  [+0x00F8E]  11 C7                    adc     di,ax
F000:0F90  [+0x00F90]  46                       inc     si
F000:0F91  [+0x00F91]  10 5F 00                 adc     [bx],bl
F000:0F94  [+0x00F94]  80 FB 11                 cmp     bl,11h
F000:0F97  [+0x00F97]  77 0D                    ja      short 0FA6h
F000:0F99  [+0x00F99]  32 FF                    xor     bh,bh
F000:0F9B  [+0x00F9B]  D1 E3                    shl     bx,1
F000:0F9D  [+0x00F9D]  C6 46 11 01              mov     byte [bp+11h],1
F000:0FA1  [+0x00FA1]  2E FF 97 6B 0F           call    word [cs:bx+0F6Bh]
F000:0FA6  [+0x00FA6]  C6 46 10 5F              mov     byte [bp+10h],5Fh
F000:0FAA  [+0x00FAA]  C3                       ret
F000:0FAB  [+0x00FAB]  1E                       push    ds
F000:0FAC  [+0x00FAC]  50                       push    ax
F000:0FAD  [+0x00FAD]  2E F6 06 94 01 40        test    byte [cs:194h],40h
F000:0FB3  [+0x00FB3]  74 10                    je      short 0FC5h
F000:0FB5  [+0x00FB5]  E8 60 05                 call    1518h
F000:0FB8  [+0x00FB8]  80 FC 03                 cmp     ah,3
F000:0FBB  [+0x00FBB]  74 05                    je      short 0FC2h
F000:0FBD  [+0x00FBD]  80 FC 07                 cmp     ah,7
F000:0FC0  [+0x00FC0]  75 03                    jne     short 0FC5h
F000:0FC2  [+0x00FC2]  E8 03 00                 call    0FC8h
F000:0FC5  [+0x00FC5]  58                       pop     ax
F000:0FC6  [+0x00FC6]  1F                       pop     ds
F000:0FC7  [+0x00FC7]  C3                       ret
F000:0FC8  [+0x00FC8]  50                       push    ax
F000:0FC9  [+0x00FC9]  53                       push    bx
F000:0FCA  [+0x00FCA]  51                       push    cx
F000:0FCB  [+0x00FCB]  52                       push    dx
F000:0FCC  [+0x00FCC]  E8 49 05                 call    1518h
F000:0FCF  [+0x00FCF]  8A DC                    mov     bl,ah
F000:0FD1  [+0x00FD1]  33 C0                    xor     ax,ax
F000:0FD3  [+0x00FD3]  8E D8                    mov     ds,ax
F000:0FD5  [+0x00FD5]  8B 0E 60 04              mov     cx,[460h]
F000:0FD9  [+0x00FD9]  8B 16 50 04              mov     dx,[450h]
F000:0FDD  [+0x00FDD]  8A 3E 62 04              mov     bh,[462h]
F000:0FE1  [+0x00FE1]  32 E4                    xor     ah,ah
F000:0FE3  [+0x00FE3]  8A C3                    mov     al,bl
F000:0FE5  [+0x00FE5]  8A 1E 87 04              mov     bl,[487h]
F000:0FE9  [+0x00FE9]  0C 80                    or      al,80h
F000:0FEB  [+0x00FEB]  CD 10                    int     10h
F000:0FED  [+0x00FED]  88 1E 87 04              mov     [487h],bl
F000:0FF1  [+0x00FF1]  B4 01                    mov     ah,1
F000:0FF3  [+0x00FF3]  CD 10                    int     10h
F000:0FF5  [+0x00FF5]  B4 02                    mov     ah,2
F000:0FF7  [+0x00FF7]  CD 10                    int     10h
F000:0FF9  [+0x00FF9]  5A                       pop     dx
F000:0FFA  [+0x00FFA]  59                       pop     cx
F000:0FFB  [+0x00FFB]  5B                       pop     bx
F000:0FFC  [+0x00FFC]  58                       pop     ax
F000:0FFD  [+0x00FFD]  C3                       ret
F000:0FFE  [+0x00FFE]  D0 EB                    shr     bl,1
F000:1000  [+0x01000]  B5 40                    mov     ch,40h
F000:1002  [+0x01002]  B0 57                    mov     al,57h
F000:1004  [+0x01004]  E8 25 10                 call    202Ch
F000:1007  [+0x01007]  80 E4 FE                 and     ah,0FEh
F000:100A  [+0x0100A]  32 FF                    xor     bh,bh
F000:100C  [+0x0100C]  0A DB                    or      bl,bl
F000:100E  [+0x0100E]  74 19                    je      short 1029h
F000:1010  [+0x01010]  80 E4 FD                 and     ah,0FDh
F000:1013  [+0x01013]  B7 03                    mov     bh,3
F000:1015  [+0x01015]  80 FB 01                 cmp     bl,1
F000:1018  [+0x01018]  74 02                    je      short 101Ch
F000:101A  [+0x0101A]  B7 01                    mov     bh,1
F000:101C  [+0x0101C]  0A E7                    or      ah,bh
F000:101E  [+0x0101E]  EF                       out     dx,ax
F000:101F  [+0x0101F]  B0 51                    mov     al,51h
F000:1021  [+0x01021]  E8 7A 40                 call    509Eh
F000:1024  [+0x01024]  80 E4 BF                 and     ah,0BFh
F000:1027  [+0x01027]  0A E5                    or      ah,ch
F000:1029  [+0x01029]  EF                       out     dx,ax
F000:102A  [+0x0102A]  C3                       ret
F000:102B  [+0x0102B]  32 ED                    xor     ch,ch
F000:102D  [+0x0102D]  BA D6 03                 mov     dx,3D6h
F000:1030  [+0x01030]  EB ED                    jmp     short 101Fh
F000:1032  [+0x01032]  D0 EB                    shr     bl,1
F000:1034  [+0x01034]  8B FA                    mov     di,dx
F000:1036  [+0x01036]  57                       push    di
F000:1037  [+0x01037]  B0 59                    mov     al,59h
F000:1039  [+0x01039]  E8 F0 0F                 call    202Ch
F000:103C  [+0x0103C]  B5 8F                    mov     ch,8Fh
F000:103E  [+0x0103E]  80 FB 02                 cmp     bl,2
F000:1041  [+0x01041]  74 02                    je      short 1045h
F000:1043  [+0x01043]  B5 E0                    mov     ch,0E0h
F000:1045  [+0x01045]  22 E5                    and     ah,ch
F000:1047  [+0x01047]  BE 00 03                 mov     si,300h
F000:104A  [+0x0104A]  80 FB 02                 cmp     bl,2
F000:104D  [+0x0104D]  74 03                    je      short 1052h
F000:104F  [+0x0104F]  BE 0F 00                 mov     si,0Fh
F000:1052  [+0x01052]  23 FE                    and     di,si
F000:1054  [+0x01054]  80 FB 04                 cmp     bl,4
F000:1057  [+0x01057]  74 06                    je      short 105Fh
F000:1059  [+0x01059]  D1 EF                    shr     di,1
F000:105B  [+0x0105B]  D1 EF                    shr     di,1
F000:105D  [+0x0105D]  D1 EF                    shr     di,1
F000:105F  [+0x0105F]  8B CF                    mov     cx,di
F000:1061  [+0x01061]  0A E1                    or      ah,cl
F000:1063  [+0x01063]  EF                       out     dx,ax
F000:1064  [+0x01064]  5F                       pop     di
F000:1065  [+0x01065]  80 FB 04                 cmp     bl,4
F000:1068  [+0x01068]  74 0A                    je      short 1074h
F000:106A  [+0x0106A]  B0 58                    mov     al,58h
F000:106C  [+0x0106C]  E8 2F 40                 call    509Eh
F000:106F  [+0x0106F]  8B CF                    mov     cx,di
F000:1071  [+0x01071]  0A E1                    or      ah,cl
F000:1073  [+0x01073]  EF                       out     dx,ax
F000:1074  [+0x01074]  C3                       ret
F000:1075  [+0x01075]  D0 EB                    shr     bl,1
F000:1077  [+0x01077]  B5 E0                    mov     ch,0E0h
F000:1079  [+0x01079]  8A CA                    mov     cl,dl
F000:107B  [+0x0107B]  B0 24                    mov     al,24h
F000:107D  [+0x0107D]  80 FB 05                 cmp     bl,5
F000:1080  [+0x01080]  74 04                    je      short 1086h
F000:1082  [+0x01082]  B5 F0                    mov     ch,0F0h
F000:1084  [+0x01084]  B0 5A                    mov     al,5Ah
F000:1086  [+0x01086]  E8 A3 0F                 call    202Ch
F000:1089  [+0x01089]  22 E5                    and     ah,ch
F000:108B  [+0x0108B]  F6 D5                    not     ch
F000:108D  [+0x0108D]  22 CD                    and     cl,ch
F000:108F  [+0x0108F]  0A E1                    or      ah,cl
F000:1091  [+0x01091]  EF                       out     dx,ax
F000:1092  [+0x01092]  C3                       ret
F000:1093  [+0x01093]  D0 EB                    shr     bl,1
F000:1095  [+0x01095]  B5 FB                    mov     ch,0FBh
F000:1097  [+0x01097]  B0 57                    mov     al,57h
F000:1099  [+0x01099]  E8 90 0F                 call    202Ch
F000:109C  [+0x0109C]  80 FB 0A                 cmp     bl,0Ah
F000:109F  [+0x0109F]  74 02                    je      short 10A3h
F000:10A1  [+0x010A1]  B5 DF                    mov     ch,0DFh
F000:10A3  [+0x010A3]  22 E5                    and     ah,ch
F000:10A5  [+0x010A5]  EF                       out     dx,ax
F000:10A6  [+0x010A6]  E8 8A 0F                 call    2033h
F000:10A9  [+0x010A9]  80 E4 7F                 and     ah,7Fh
F000:10AC  [+0x010AC]  C3                       ret
F000:10AD  [+0x010AD]  B7 05                    mov     bh,5
F000:10AF  [+0x010AF]  EB 3C                    jmp     short 10EDh
F000:10B1  [+0x010B1]  B7 0D                    mov     bh,0Dh
F000:10B3  [+0x010B3]  EB 38                    jmp     short 10EDh
F000:10B5  [+0x010B5]  E8 DA 01                 call    1292h
F000:10B8  [+0x010B8]  75 0E                    jne     short 10C8h
F000:10BA  [+0x010BA]  E8 77 01                 call    1234h
F000:10BD  [+0x010BD]  75 09                    jne     short 10C8h
F000:10BF  [+0x010BF]  C6 46 10 08              mov     byte [bp+10h],8
F000:10C3  [+0x010C3]  E8 E6 1D                 call    2EACh
F000:10C6  [+0x010C6]  EB 05                    jmp     short 10CDh
F000:10C8  [+0x010C8]  B7 15                    mov     bh,15h
F000:10CA  [+0x010CA]  E8 20 00                 call    10EDh
F000:10CD  [+0x010CD]  C3                       ret
F000:10CE  [+0x010CE]  E8 C1 01                 call    1292h
F000:10D1  [+0x010D1]  75 0E                    jne     short 10E1h
F000:10D3  [+0x010D3]  E8 5E 01                 call    1234h
F000:10D6  [+0x010D6]  75 09                    jne     short 10E1h
F000:10D8  [+0x010D8]  C6 46 10 09              mov     byte [bp+10h],9
F000:10DC  [+0x010DC]  E8 CD 1D                 call    2EACh
F000:10DF  [+0x010DF]  EB 05                    jmp     short 10E6h
F000:10E1  [+0x010E1]  B7 1D                    mov     bh,1Dh
F000:10E3  [+0x010E3]  E8 07 00                 call    10EDh
F000:10E6  [+0x010E6]  C3                       ret
F000:10E7  [+0x010E7]  B7 21                    mov     bh,21h
F000:10E9  [+0x010E9]  EB 02                    jmp     short 10EDh
F000:10EB  [+0x010EB]  B7 61                    mov     bh,61h
F000:10ED  [+0x010ED]  D0 EB                    shr     bl,1
F000:10EF  [+0x010EF]  B0 57                    mov     al,57h
F000:10F1  [+0x010F1]  E8 38 0F                 call    202Ch
F000:10F4  [+0x010F4]  B5 9E                    mov     ch,9Eh
F000:10F6  [+0x010F6]  80 FB 0C                 cmp     bl,0Ch
F000:10F9  [+0x010F9]  73 02                    jae     short 10FDh
F000:10FB  [+0x010FB]  B5 E2                    mov     ch,0E2h
F000:10FD  [+0x010FD]  22 E5                    and     ah,ch
F000:10FF  [+0x010FF]  0A E7                    or      ah,bh
F000:1101  [+0x01101]  EF                       out     dx,ax
F000:1102  [+0x01102]  B5 40                    mov     ch,40h
F000:1104  [+0x01104]  E9 18 FF                 jmp     101Fh
F000:1107  [+0x01107]  E8 DC 12                 call    23E6h
F000:110A  [+0x0110A]  0C 10                    or      al,10h
F000:110C  [+0x0110C]  E8 E8 12                 call    23F7h
F000:110F  [+0x0110F]  E8 8B 01                 call    129Dh
F000:1112  [+0x01112]  B8 5E 5F                 mov     ax,5F5Eh
F000:1115  [+0x01115]  B3 00                    mov     bl,0
F000:1117  [+0x01117]  CD 10                    int     10h
F000:1119  [+0x01119]  C3                       ret
F000:111A  [+0x0111A]  E8 C9 12                 call    23E6h
F000:111D  [+0x0111D]  24 EF                    and     al,0EFh
F000:111F  [+0x0111F]  E8 D5 12                 call    23F7h
F000:1122  [+0x01122]  E8 9E 01                 call    12C3h
F000:1125  [+0x01125]  B8 5E 5F                 mov     ax,5F5Eh
F000:1128  [+0x01128]  B3 01                    mov     bl,1
F000:112A  [+0x0112A]  CD 10                    int     10h
F000:112C  [+0x0112C]  C3                       ret
F000:112D  [+0x0112D]  5E                       pop     si
F000:112E  [+0x0112E]  11 83 11 79              adc     [bp+di+7911h],ax
F000:1132  [+0x01132]  11 83 11 83              adc     [bp+di-7CEFh],ax
F000:1136  [+0x01136]  11 5E 11                 adc     [bp+11h],bx
F000:1139  [+0x01139]  83 11 5E                 adc     word [bx+di],5Eh
F000:113C  [+0x0113C]  11 2B                    adc     [bp+di],bp
F000:113E  [+0x0113E]  10 C7                    adc     bh,al
F000:1140  [+0x01140]  46                       inc     si
F000:1141  [+0x01141]  10 5F 00                 adc     [bx],bl
F000:1144  [+0x01144]  80 FB 07                 cmp     bl,7
F000:1147  [+0x01147]  76 07                    jbe     short 1150h
F000:1149  [+0x01149]  80 FB 0F                 cmp     bl,0Fh
F000:114C  [+0x0114C]  75 0F                    jne     short 115Dh
F000:114E  [+0x0114E]  B3 08                    mov     bl,8
F000:1150  [+0x01150]  32 FF                    xor     bh,bh
F000:1152  [+0x01152]  D1 E3                    shl     bx,1
F000:1154  [+0x01154]  C6 46 11 01              mov     byte [bp+11h],1
F000:1158  [+0x01158]  2E FF 97 2D 11           call    word [cs:bx+112Dh]
F000:115D  [+0x0115D]  C3                       ret
F000:115E  [+0x0115E]  D0 EB                    shr     bl,1
F000:1160  [+0x01160]  B0 55                    mov     al,55h
F000:1162  [+0x01162]  E8 C7 0E                 call    202Ch
F000:1165  [+0x01165]  B1 FE                    mov     cl,0FEh
F000:1167  [+0x01167]  0A DB                    or      bl,bl
F000:1169  [+0x01169]  74 09                    je      short 1174h
F000:116B  [+0x0116B]  B1 FB                    mov     cl,0FBh
F000:116D  [+0x0116D]  80 FB 05                 cmp     bl,5
F000:1170  [+0x01170]  74 02                    je      short 1174h
F000:1172  [+0x01172]  B1 DF                    mov     cl,0DFh
F000:1174  [+0x01174]  22 E1                    and     ah,cl
F000:1176  [+0x01176]  E9 B0 FE                 jmp     1029h
F000:1179  [+0x01179]  B0 56                    mov     al,56h
F000:117B  [+0x0117B]  E8 AE 0E                 call    202Ch
F000:117E  [+0x0117E]  8A E2                    mov     ah,dl
F000:1180  [+0x01180]  E9 A6 FE                 jmp     1029h
F000:1183  [+0x01183]  D0 EB                    shr     bl,1
F000:1185  [+0x01185]  B0 55                    mov     al,55h
F000:1187  [+0x01187]  E8 A2 0E                 call    202Ch
F000:118A  [+0x0118A]  B5 03                    mov     ch,3
F000:118C  [+0x0118C]  80 FB 01                 cmp     bl,1
F000:118F  [+0x0118F]  74 13                    je      short 11A4h
F000:1191  [+0x01191]  B5 05                    mov     ch,5
F000:1193  [+0x01193]  80 FB 04                 cmp     bl,4
F000:1196  [+0x01196]  74 0C                    je      short 11A4h
F000:1198  [+0x01198]  B5 21                    mov     ch,21h
F000:119A  [+0x0119A]  80 FB 06                 cmp     bl,6
F000:119D  [+0x0119D]  74 05                    je      short 11A4h
F000:119F  [+0x0119F]  B5 01                    mov     ch,1
F000:11A1  [+0x011A1]  80 E4 FD                 and     ah,0FDh
F000:11A4  [+0x011A4]  0A E5                    or      ah,ch
F000:11A6  [+0x011A6]  EF                       out     dx,ax
F000:11A7  [+0x011A7]  B5 40                    mov     ch,40h
F000:11A9  [+0x011A9]  E9 73 FE                 jmp     101Fh
F000:11AC  [+0x011AC]  C6 46 10 5F              mov     byte [bp+10h],5Fh
F000:11B0  [+0x011B0]  C3                       ret
F000:11B1  [+0x011B1]  C7 46 10 5F 00           mov     word [bp+10h],5Fh
F000:11B6  [+0x011B6]  80 FB 01                 cmp     bl,1
F000:11B9  [+0x011B9]  77 41                    ja      short 11FCh
F000:11BB  [+0x011BB]  1E                       push    ds
F000:11BC  [+0x011BC]  33 C0                    xor     ax,ax
F000:11BE  [+0x011BE]  8E D8                    mov     ds,ax
F000:11C0  [+0x011C0]  B0 59                    mov     al,59h
F000:11C2  [+0x011C2]  E8 67 0E                 call    202Ch
F000:11C5  [+0x011C5]  80 E4 7F                 and     ah,7Fh
F000:11C8  [+0x011C8]  80 FB 01                 cmp     bl,1
F000:11CB  [+0x011CB]  74 03                    je      short 11D0h
F000:11CD  [+0x011CD]  80 CC 80                 or      ah,80h
F000:11D0  [+0x011D0]  E8 D6 3E                 call    50A9h
F000:11D3  [+0x011D3]  E8 5D 0E                 call    2033h
F000:11D6  [+0x011D6]  80 E4 7F                 and     ah,7Fh
F000:11D9  [+0x011D9]  80 FB 01                 cmp     bl,1
F000:11DC  [+0x011DC]  74 03                    je      short 11E1h
F000:11DE  [+0x011DE]  80 CC 80                 or      ah,80h
F000:11E1  [+0x011E1]  EF                       out     dx,ax
F000:11E2  [+0x011E2]  B0 57                    mov     al,57h
F000:11E4  [+0x011E4]  E8 45 0E                 call    202Ch
F000:11E7  [+0x011E7]  80 E4 FB                 and     ah,0FBh
F000:11EA  [+0x011EA]  80 FB 01                 cmp     bl,1
F000:11ED  [+0x011ED]  74 03                    je      short 11F2h
F000:11EF  [+0x011EF]  80 CC 04                 or      ah,4
F000:11F2  [+0x011F2]  EF                       out     dx,ax
F000:11F3  [+0x011F3]  1F                       pop     ds
F000:11F4  [+0x011F4]  C7 46 10 5F 01           mov     word [bp+10h],15Fh
F000:11F9  [+0x011F9]  32 C0                    xor     al,al
F000:11FB  [+0x011FB]  C3                       ret
F000:11FC  [+0x011FC]  80 FB 03                 cmp     bl,3
F000:11FF  [+0x011FF]  77 19                    ja      short 121Ah
F000:1201  [+0x01201]  B0 57                    mov     al,57h
F000:1203  [+0x01203]  E8 26 0E                 call    202Ch
F000:1206  [+0x01206]  80 E4 FD                 and     ah,0FDh
F000:1209  [+0x01209]  80 FB 03                 cmp     bl,3
F000:120C  [+0x0120C]  74 03                    je      short 1211h
F000:120E  [+0x0120E]  80 CC 02                 or      ah,2
F000:1211  [+0x01211]  EF                       out     dx,ax
F000:1212  [+0x01212]  C7 46 10 5F 01           mov     word [bp+10h],15Fh
F000:1217  [+0x01217]  32 C0                    xor     al,al
F000:1219  [+0x01219]  C3                       ret
F000:121A  [+0x0121A]  80 FB 05                 cmp     bl,5
F000:121D  [+0x0121D]  77 14                    ja      short 1233h
F000:121F  [+0x0121F]  80 FB 04                 cmp     bl,4
F000:1222  [+0x01222]  74 05                    je      short 1229h
F000:1224  [+0x01224]  E8 F3 01                 call    141Ah
F000:1227  [+0x01227]  EB 03                    jmp     short 122Ch
F000:1229  [+0x01229]  E8 E0 01                 call    140Ch
F000:122C  [+0x0122C]  C7 46 10 5F 01           mov     word [bp+10h],15Fh
F000:1231  [+0x01231]  32 C0                    xor     al,al
F000:1233  [+0x01233]  C3                       ret
F000:1234  [+0x01234]  50                       push    ax
F000:1235  [+0x01235]  52                       push    dx
F000:1236  [+0x01236]  E8 FA 0D                 call    2033h
F000:1239  [+0x01239]  F6 D4                    not     ah
F000:123B  [+0x0123B]  F6 C4 80                 test    ah,80h
F000:123E  [+0x0123E]  5A                       pop     dx
F000:123F  [+0x0123F]  58                       pop     ax
F000:1240  [+0x01240]  C3                       ret
F000:1241  [+0x01241]  50                       push    ax
F000:1242  [+0x01242]  2E A1 D8 01              mov     ax,[cs:1D8h]
F000:1246  [+0x01246]  32 FF                    xor     bh,bh
F000:1248  [+0x01248]  3D E0 01                 cmp     ax,1E0h
F000:124B  [+0x0124B]  76 09                    jbe     short 1256h
F000:124D  [+0x0124D]  B7 01                    mov     bh,1
F000:124F  [+0x0124F]  3D 00 03                 cmp     ax,300h
F000:1252  [+0x01252]  76 02                    jbe     short 1256h
F000:1254  [+0x01254]  B7 03                    mov     bh,3
F000:1256  [+0x01256]  58                       pop     ax
F000:1257  [+0x01257]  C3                       ret
F000:1258  [+0x01258]  B3 14                    mov     bl,14h
F000:125A  [+0x0125A]  75 2C                    jne     short 1288h
F000:125C  [+0x0125C]  E8 E2 FF                 call    1241h
F000:125F  [+0x0125F]  B3 12                    mov     bl,12h
F000:1261  [+0x01261]  F6 C7 01                 test    bh,1
F000:1264  [+0x01264]  74 09                    je      short 126Fh
F000:1266  [+0x01266]  B3 1D                    mov     bl,1Dh
F000:1268  [+0x01268]  80 FF 01                 cmp     bh,1
F000:126B  [+0x0126B]  74 02                    je      short 126Fh
F000:126D  [+0x0126D]  B3 1F                    mov     bl,1Fh
F000:126F  [+0x0126F]  B0 24                    mov     al,24h
F000:1271  [+0x01271]  E8 B8 0D                 call    202Ch
F000:1274  [+0x01274]  8A E3                    mov     ah,bl
F000:1276  [+0x01276]  EF                       out     dx,ax
F000:1277  [+0x01277]  B3 09                    mov     bl,9
F000:1279  [+0x01279]  B7 15                    mov     bh,15h
F000:127B  [+0x0127B]  80 7E 10 08              cmp     byte [bp+10h],8
F000:127F  [+0x0127F]  74 02                    je      short 1283h
F000:1281  [+0x01281]  B7 1D                    mov     bh,1Dh
F000:1283  [+0x01283]  E8 67 FE                 call    10EDh
F000:1286  [+0x01286]  EB 09                    jmp     short 1291h
F000:1288  [+0x01288]  B0 57                    mov     al,57h
F000:128A  [+0x0128A]  E8 9F 0D                 call    202Ch
F000:128D  [+0x0128D]  80 E4 E7                 and     ah,0E7h
F000:1290  [+0x01290]  EF                       out     dx,ax
F000:1291  [+0x01291]  C3                       ret
F000:1292  [+0x01292]  B0 06                    mov     al,6
F000:1294  [+0x01294]  BA CE 03                 mov     dx,3CEh
F000:1297  [+0x01297]  E8 FF 3D                 call    5099h
F000:129A  [+0x0129A]  A8 01                    test    al,1
F000:129C  [+0x0129C]  C3                       ret
F000:129D  [+0x0129D]  B0 57                    mov     al,57h
F000:129F  [+0x0129F]  E8 8A 0D                 call    202Ch
F000:12A2  [+0x012A2]  80 CC 22                 or      ah,22h
F000:12A5  [+0x012A5]  EF                       out     dx,ax
F000:12A6  [+0x012A6]  B4 01                    mov     ah,1
F000:12A8  [+0x012A8]  E8 96 FF                 call    1241h
F000:12AB  [+0x012AB]  F6 C7 01                 test    bh,1
F000:12AE  [+0x012AE]  75 0F                    jne     short 12BFh
F000:12B0  [+0x012B0]  B4 04                    mov     ah,4
F000:12B2  [+0x012B2]  50                       push    ax
F000:12B3  [+0x012B3]  B0 59                    mov     al,59h
F000:12B5  [+0x012B5]  E8 EB 3D                 call    50A3h
F000:12B8  [+0x012B8]  80 CC 80                 or      ah,80h
F000:12BB  [+0x012BB]  E8 EB 3D                 call    50A9h
F000:12BE  [+0x012BE]  58                       pop     ax
F000:12BF  [+0x012BF]  B0 5A                    mov     al,5Ah
F000:12C1  [+0x012C1]  EF                       out     dx,ax
F000:12C2  [+0x012C2]  C3                       ret
F000:12C3  [+0x012C3]  B0 57                    mov     al,57h
F000:12C5  [+0x012C5]  E8 64 0D                 call    202Ch
F000:12C8  [+0x012C8]  80 E4 DF                 and     ah,0DFh
F000:12CB  [+0x012CB]  EF                       out     dx,ax
F000:12CC  [+0x012CC]  B0 5A                    mov     al,5Ah
F000:12CE  [+0x012CE]  B4 00                    mov     ah,0
F000:12D0  [+0x012D0]  EF                       out     dx,ax
F000:12D1  [+0x012D1]  50                       push    ax
F000:12D2  [+0x012D2]  B0 59                    mov     al,59h
F000:12D4  [+0x012D4]  E8 CC 3D                 call    50A3h
F000:12D7  [+0x012D7]  80 E4 7F                 and     ah,7Fh
F000:12DA  [+0x012DA]  E8 CC 3D                 call    50A9h
F000:12DD  [+0x012DD]  58                       pop     ax
F000:12DE  [+0x012DE]  C3                       ret
F000:12DF  [+0x012DF]  00 C3                    add     bl,al
F000:12E1  [+0x012E1]  E8 34 02                 call    1518h
F000:12E4  [+0x012E4]  8A C4                    mov     al,ah
F000:12E6  [+0x012E6]  E8 F9 04                 call    17E2h
F000:12E9  [+0x012E9]  2E 8A 95 F4 0A           mov     dl,[cs:di+0AF4h]
F000:12EE  [+0x012EE]  2E 8A 9D F3 0A           mov     bl,[cs:di+0AF3h]
F000:12F3  [+0x012F3]  80 E2 07                 and     dl,7
F000:12F6  [+0x012F6]  E8 59 03                 call    1652h
F000:12F9  [+0x012F9]  E8 4A F9                 call    0C46h
F000:12FC  [+0x012FC]  74 03                    je      short 1301h
F000:12FE  [+0x012FE]  E8 39 FA                 call    0D3Ah
F000:1301  [+0x01301]  C3                       ret
F000:1302  [+0x01302]  50                       push    ax
F000:1303  [+0x01303]  53                       push    bx
F000:1304  [+0x01304]  51                       push    cx
F000:1305  [+0x01305]  52                       push    dx
F000:1306  [+0x01306]  57                       push    di
F000:1307  [+0x01307]  E8 65 0C                 call    1F6Fh
F000:130A  [+0x0130A]  33 D2                    xor     dx,dx
F000:130C  [+0x0130C]  3C 13                    cmp     al,13h
F000:130E  [+0x0130E]  76 23                    jbe     short 1333h
F000:1310  [+0x01310]  E8 CF 04                 call    17E2h
F000:1313  [+0x01313]  E8 91 0C                 call    1FA7h
F000:1316  [+0x01316]  2E 8A 95 F4 0A           mov     dl,[cs:di+0AF4h]
F000:131B  [+0x0131B]  2E 8A 9D F3 0A           mov     bl,[cs:di+0AF3h]
F000:1320  [+0x01320]  80 E2 07                 and     dl,7
F000:1323  [+0x01323]  F6 C3 04                 test    bl,4
F000:1326  [+0x01326]  74 03                    je      short 132Bh
F000:1328  [+0x01328]  80 CE 04                 or      dh,4
F000:132B  [+0x0132B]  F6 C3 80                 test    bl,80h
F000:132E  [+0x0132E]  74 03                    je      short 1333h
F000:1330  [+0x01330]  80 CE 01                 or      dh,1
F000:1333  [+0x01333]  E8 48 0C                 call    1F7Eh
F000:1336  [+0x01336]  E8 19 03                 call    1652h
F000:1339  [+0x01339]  52                       push    dx
F000:133A  [+0x0133A]  E8 F5 00                 call    1432h
F000:133D  [+0x0133D]  53                       push    bx
F000:133E  [+0x0133E]  E8 05 F9                 call    0C46h
F000:1341  [+0x01341]  74 20                    je      short 1363h
F000:1343  [+0x01343]  E8 ED 0C                 call    2033h
F000:1346  [+0x01346]  F6 C4 20                 test    ah,20h
F000:1349  [+0x01349]  74 18                    je      short 1363h
F000:134B  [+0x0134B]  E8 8C 02                 call    15DAh
F000:134E  [+0x0134E]  B5 02                    mov     ch,2
F000:1350  [+0x01350]  F6 C3 04                 test    bl,4
F000:1353  [+0x01353]  74 02                    je      short 1357h
F000:1355  [+0x01355]  B1 09                    mov     cl,9
F000:1357  [+0x01357]  8B D9                    mov     bx,cx
F000:1359  [+0x01359]  80 FB 09                 cmp     bl,9
F000:135C  [+0x0135C]  75 02                    jne     short 1360h
F000:135E  [+0x0135E]  B3 28                    mov     bl,28h
F000:1360  [+0x01360]  E8 50 03                 call    16B3h
F000:1363  [+0x01363]  5B                       pop     bx
F000:1364  [+0x01364]  5A                       pop     dx
F000:1365  [+0x01365]  8B C2                    mov     ax,dx
F000:1367  [+0x01367]  8B 16 63 04              mov     dx,[463h]
F000:136B  [+0x0136B]  83 C2 06                 add     dx,6
F000:136E  [+0x0136E]  EE                       out     dx,al
F000:136F  [+0x0136F]  B0 0B                    mov     al,0Bh
F000:1371  [+0x01371]  BA D6 03                 mov     dx,3D6h
F000:1374  [+0x01374]  EF                       out     dx,ax
F000:1375  [+0x01375]  B0 04                    mov     al,4
F000:1377  [+0x01377]  E8 24 3D                 call    509Eh
F000:137A  [+0x0137A]  80 E4 FB                 and     ah,0FBh
F000:137D  [+0x0137D]  F6 C3 08                 test    bl,8
F000:1380  [+0x01380]  74 03                    je      short 1385h
F000:1382  [+0x01382]  80 CC 04                 or      ah,4
F000:1385  [+0x01385]  32 FF                    xor     bh,bh
F000:1387  [+0x01387]  80 E4 F7                 and     ah,0F7h
F000:138A  [+0x0138A]  F6 C3 04                 test    bl,4
F000:138D  [+0x0138D]  74 17                    je      short 13A6h
F000:138F  [+0x0138F]  2E F6 06 7F 01 80        test    byte [cs:17Fh],80h
F000:1395  [+0x01395]  75 04                    jne     short 139Bh
F000:1397  [+0x01397]  B7 08                    mov     bh,8
F000:1399  [+0x01399]  EB 09                    jmp     short 13A4h
F000:139B  [+0x0139B]  80 3E 49 04 13           cmp     byte [449h],13h
F000:13A0  [+0x013A0]  76 02                    jbe     short 13A4h
F000:13A2  [+0x013A2]  B7 08                    mov     bh,8
F000:13A4  [+0x013A4]  0A E7                    or      ah,bh
F000:13A6  [+0x013A6]  EF                       out     dx,ax
F000:13A7  [+0x013A7]  E8 52 01                 call    14FCh
F000:13AA  [+0x013AA]  E8 79 01                 call    1526h
F000:13AD  [+0x013AD]  E8 09 02                 call    15B9h
F000:13B0  [+0x013B0]  E8 AF 00                 call    1462h
F000:13B3  [+0x013B3]  8A 0E 49 04              mov     cl,[449h]
F000:13B7  [+0x013B7]  E8 87 FE                 call    1241h
F000:13BA  [+0x013BA]  80 FF 00                 cmp     bh,0
F000:13BD  [+0x013BD]  75 14                    jne     short 13D3h
F000:13BF  [+0x013BF]  BA D6 03                 mov     dx,3D6h
F000:13C2  [+0x013C2]  B4 02                    mov     ah,2
F000:13C4  [+0x013C4]  80 F9 0F                 cmp     cl,0Fh
F000:13C7  [+0x013C7]  74 07                    je      short 13D0h
F000:13C9  [+0x013C9]  80 F9 10                 cmp     cl,10h
F000:13CC  [+0x013CC]  74 02                    je      short 13D0h
F000:13CE  [+0x013CE]  B4 04                    mov     ah,4
F000:13D0  [+0x013D0]  B0 5A                    mov     al,5Ah
F000:13D2  [+0x013D2]  EF                       out     dx,ax
F000:13D3  [+0x013D3]  5F                       pop     di
F000:13D4  [+0x013D4]  5A                       pop     dx
F000:13D5  [+0x013D5]  59                       pop     cx
F000:13D6  [+0x013D6]  5B                       pop     bx
F000:13D7  [+0x013D7]  58                       pop     ax
F000:13D8  [+0x013D8]  C3                       ret
F000:13D9  [+0x013D9]  E8 3C 01                 call    1518h
F000:13DC  [+0x013DC]  80 E4 70                 and     ah,70h
F000:13DF  [+0x013DF]  80 FC 20                 cmp     ah,20h
F000:13E2  [+0x013E2]  75 27                    jne     short 140Bh
F000:13E4  [+0x013E4]  BA CE 03                 mov     dx,3CEh
F000:13E7  [+0x013E7]  B8 05 40                 mov     ax,4005h
F000:13EA  [+0x013EA]  EF                       out     dx,ax
F000:13EB  [+0x013EB]  8B 16 63 04              mov     dx,[463h]
F000:13EF  [+0x013EF]  B0 13                    mov     al,13h
F000:13F1  [+0x013F1]  EE                       out     dx,al
F000:13F2  [+0x013F2]  ED                       in      ax,dx
F000:13F3  [+0x013F3]  D0 EC                    shr     ah,1
F000:13F5  [+0x013F5]  EF                       out     dx,ax
F000:13F6  [+0x013F6]  B8 0C FF                 mov     ax,0FF0Ch
F000:13F9  [+0x013F9]  EF                       out     dx,ax
F000:13FA  [+0x013FA]  B8 0D FF                 mov     ax,0FF0Dh
F000:13FD  [+0x013FD]  EF                       out     dx,ax
F000:13FE  [+0x013FE]  83 C2 06                 add     dx,6
F000:1401  [+0x01401]  EC                       in      al,dx
F000:1402  [+0x01402]  BA C0 03                 mov     dx,3C0h
F000:1405  [+0x01405]  B0 13                    mov     al,13h
F000:1407  [+0x01407]  EE                       out     dx,al
F000:1408  [+0x01408]  B0 07                    mov     al,7
F000:140A  [+0x0140A]  EE                       out     dx,al
F000:140B  [+0x0140B]  C3                       ret
F000:140C  [+0x0140C]  50                       push    ax
F000:140D  [+0x0140D]  B0 57                    mov     al,57h
F000:140F  [+0x0140F]  E8 91 3C                 call    50A3h
F000:1412  [+0x01412]  80 CC 20                 or      ah,20h
F000:1415  [+0x01415]  E8 91 3C                 call    50A9h
F000:1418  [+0x01418]  58                       pop     ax
F000:1419  [+0x01419]  C3                       ret
F000:141A  [+0x0141A]  50                       push    ax
F000:141B  [+0x0141B]  B0 57                    mov     al,57h
F000:141D  [+0x0141D]  E8 83 3C                 call    50A3h
F000:1420  [+0x01420]  80 E4 DF                 and     ah,0DFh
F000:1423  [+0x01423]  E8 83 3C                 call    50A9h
F000:1426  [+0x01426]  58                       pop     ax
F000:1427  [+0x01427]  C3                       ret
F000:1428  [+0x01428]  B0 57                    mov     al,57h
F000:142A  [+0x0142A]  E8 FF 0B                 call    202Ch
F000:142D  [+0x0142D]  80 E4 FB                 and     ah,0FBh
F000:1430  [+0x01430]  EF                       out     dx,ax
F000:1431  [+0x01431]  C3                       ret
F000:1432  [+0x01432]  8A 0E 49 04              mov     cl,[449h]
F000:1436  [+0x01436]  80 F9 60                 cmp     cl,60h
F000:1439  [+0x01439]  72 26                    jb      short 1461h
F000:143B  [+0x0143B]  80 F9 61                 cmp     cl,61h
F000:143E  [+0x0143E]  77 21                    ja      short 1461h
F000:1440  [+0x01440]  8B 16 63 04              mov     dx,[463h]
F000:1444  [+0x01444]  B0 11                    mov     al,11h
F000:1446  [+0x01446]  E8 55 3C                 call    509Eh
F000:1449  [+0x01449]  80 E4 7F                 and     ah,7Fh
F000:144C  [+0x0144C]  EF                       out     dx,ax
F000:144D  [+0x0144D]  B8 01 7F                 mov     ax,7F01h
F000:1450  [+0x01450]  E8 F3 F7                 call    0C46h
F000:1453  [+0x01453]  75 02                    jne     short 1457h
F000:1455  [+0x01455]  B4 83                    mov     ah,83h
F000:1457  [+0x01457]  EF                       out     dx,ax
F000:1458  [+0x01458]  B0 11                    mov     al,11h
F000:145A  [+0x0145A]  E8 41 3C                 call    509Eh
F000:145D  [+0x0145D]  80 CC 80                 or      ah,80h
F000:1460  [+0x01460]  EF                       out     dx,ax
F000:1461  [+0x01461]  C3                       ret
F000:1462  [+0x01462]  E8 10 00                 call    1475h
F000:1465  [+0x01465]  E8 DE F7                 call    0C46h
F000:1468  [+0x01468]  74 0A                    je      short 1474h
F000:146A  [+0x0146A]  E8 79 0F                 call    23E6h
F000:146D  [+0x0146D]  A8 80                    test    al,80h
F000:146F  [+0x0146F]  75 03                    jne     short 1474h
F000:1471  [+0x01471]  E8 C6 F8                 call    0D3Ah
F000:1474  [+0x01474]  C3                       ret
F000:1475  [+0x01475]  E8 A0 00                 call    1518h
F000:1478  [+0x01478]  8A FC                    mov     bh,ah
F000:147A  [+0x0147A]  B0 06                    mov     al,6
F000:147C  [+0x0147C]  E8 AD 0B                 call    202Ch
F000:147F  [+0x0147F]  80 E4 F3                 and     ah,0F3h
F000:1482  [+0x01482]  80 CC 04                 or      ah,4
F000:1485  [+0x01485]  80 FF 40                 cmp     bh,40h
F000:1488  [+0x01488]  74 16                    je      short 14A0h
F000:148A  [+0x0148A]  80 CC 0C                 or      ah,0Ch
F000:148D  [+0x0148D]  80 FF 41                 cmp     bh,41h
F000:1490  [+0x01490]  74 0E                    je      short 14A0h
F000:1492  [+0x01492]  80 E4 F3                 and     ah,0F3h
F000:1495  [+0x01495]  80 CC 08                 or      ah,8
F000:1498  [+0x01498]  80 FF 50                 cmp     bh,50h
F000:149B  [+0x0149B]  74 03                    je      short 14A0h
F000:149D  [+0x0149D]  80 E4 F3                 and     ah,0F3h
F000:14A0  [+0x014A0]  EF                       out     dx,ax
F000:14A1  [+0x014A1]  80 E4 0C                 and     ah,0Ch
F000:14A4  [+0x014A4]  B3 00                    mov     bl,0
F000:14A6  [+0x014A6]  80 FC 00                 cmp     ah,0
F000:14A9  [+0x014A9]  74 1E                    je      short 14C9h
F000:14AB  [+0x014AB]  B3 10                    mov     bl,10h
F000:14AD  [+0x014AD]  53                       push    bx
F000:14AE  [+0x014AE]  B0 1C                    mov     al,1Ch
F000:14B0  [+0x014B0]  E8 79 0B                 call    202Ch
F000:14B3  [+0x014B3]  8A DC                    mov     bl,ah
F000:14B5  [+0x014B5]  FE C3                    inc     bl
F000:14B7  [+0x014B7]  D0 E4                    shl     ah,1
F000:14B9  [+0x014B9]  FE C4                    inc     ah
F000:14BB  [+0x014BB]  80 FF 50                 cmp     bh,50h
F000:14BE  [+0x014BE]  75 02                    jne     short 14C2h
F000:14C0  [+0x014C0]  02 E3                    add     ah,bl
F000:14C2  [+0x014C2]  E8 81 F7                 call    0C46h
F000:14C5  [+0x014C5]  74 01                    je      short 14C8h
F000:14C7  [+0x014C7]  EF                       out     dx,ax
F000:14C8  [+0x014C8]  5B                       pop     bx
F000:14C9  [+0x014C9]  B0 02                    mov     al,2
F000:14CB  [+0x014CB]  EE                       out     dx,al
F000:14CC  [+0x014CC]  ED                       in      ax,dx
F000:14CD  [+0x014CD]  80 E4 FB                 and     ah,0FBh
F000:14D0  [+0x014D0]  80 FB 10                 cmp     bl,10h
F000:14D3  [+0x014D3]  75 03                    jne     short 14D8h
F000:14D5  [+0x014D5]  80 CC 04                 or      ah,4
F000:14D8  [+0x014D8]  EF                       out     dx,ax
F000:14D9  [+0x014D9]  B0 0F                    mov     al,0Fh
F000:14DB  [+0x014DB]  EE                       out     dx,al
F000:14DC  [+0x014DC]  ED                       in      ax,dx
F000:14DD  [+0x014DD]  80 E4 EF                 and     ah,0EFh
F000:14E0  [+0x014E0]  0A E3                    or      ah,bl
F000:14E2  [+0x014E2]  EF                       out     dx,ax
F000:14E3  [+0x014E3]  B8 17 00                 mov     ax,17h
F000:14E6  [+0x014E6]  80 FF 50                 cmp     bh,50h
F000:14E9  [+0x014E9]  75 02                    jne     short 14EDh
F000:14EB  [+0x014EB]  B4 01                    mov     ah,1
F000:14ED  [+0x014ED]  EF                       out     dx,ax
F000:14EE  [+0x014EE]  C3                       ret
F000:14EF  [+0x014EF]  50                       push    ax
F000:14F0  [+0x014F0]  52                       push    dx
F000:14F1  [+0x014F1]  B0 15                    mov     al,15h
F000:14F3  [+0x014F3]  E8 AD 3B                 call    50A3h
F000:14F6  [+0x014F6]  80 FC 18                 cmp     ah,18h
F000:14F9  [+0x014F9]  5A                       pop     dx
F000:14FA  [+0x014FA]  58                       pop     ax
F000:14FB  [+0x014FB]  C3                       ret
F000:14FC  [+0x014FC]  E8 19 00                 call    1518h
F000:14FF  [+0x014FF]  8A FC                    mov     bh,ah
F000:1501  [+0x01501]  B0 0B                    mov     al,0Bh
F000:1503  [+0x01503]  E8 26 0B                 call    202Ch
F000:1506  [+0x01506]  80 E4 EF                 and     ah,0EFh
F000:1509  [+0x01509]  80 FF 20                 cmp     bh,20h
F000:150C  [+0x0150C]  72 08                    jb      short 1516h
F000:150E  [+0x0150E]  80 FF 5F                 cmp     bh,5Fh
F000:1511  [+0x01511]  77 03                    ja      short 1516h
F000:1513  [+0x01513]  80 CC 10                 or      ah,10h
F000:1516  [+0x01516]  EF                       out     dx,ax
F000:1517  [+0x01517]  C3                       ret
F000:1518  [+0x01518]  1E                       push    ds
F000:1519  [+0x01519]  33 C0                    xor     ax,ax
F000:151B  [+0x0151B]  8E D8                    mov     ds,ax
F000:151D  [+0x0151D]  8A 26 49 04              mov     ah,[449h]
F000:1521  [+0x01521]  80 E4 7F                 and     ah,7Fh
F000:1524  [+0x01524]  1F                       pop     ds
F000:1525  [+0x01525]  C3                       ret
F000:1526  [+0x01526]  2E F6 06 94 01 20        test    byte [cs:194h],20h
F000:152C  [+0x0152C]  75 02                    jne     short 1530h
F000:152E  [+0x0152E]  EB 42                    jmp     short 1572h
F000:1530  [+0x01530]  E8 13 F7                 call    0C46h
F000:1533  [+0x01533]  74 3D                    je      short 1572h
F000:1535  [+0x01535]  E8 20 0F                 call    2458h
F000:1538  [+0x01538]  2E 8B 44 06              mov     ax,[cs:si+6]
F000:153C  [+0x0153C]  EF                       out     dx,ax
F000:153D  [+0x0153D]  E8 1D F7                 call    0C5Dh
F000:1540  [+0x01540]  75 30                    jne     short 1572h
F000:1542  [+0x01542]  B9 04 00                 mov     cx,4
F000:1545  [+0x01545]  E8 4A 0F                 call    2492h
F000:1548  [+0x01548]  E8 28 00                 call    1573h
F000:154B  [+0x0154B]  8A F8                    mov     bh,al
F000:154D  [+0x0154D]  BA D6 03                 mov     dx,3D6h
F000:1550  [+0x01550]  B0 1B                    mov     al,1Bh
F000:1552  [+0x01552]  E8 4E 3B                 call    50A3h
F000:1555  [+0x01555]  B3 02                    mov     bl,2
F000:1557  [+0x01557]  80 EC 02                 sub     ah,2
F000:155A  [+0x0155A]  80 FF 01                 cmp     bh,1
F000:155D  [+0x0155D]  74 0A                    je      short 1569h
F000:155F  [+0x0155F]  80 C4 04                 add     ah,4
F000:1562  [+0x01562]  80 FF 02                 cmp     bh,2
F000:1565  [+0x01565]  75 0B                    jne     short 1572h
F000:1567  [+0x01567]  B3 01                    mov     bl,1
F000:1569  [+0x01569]  EF                       out     dx,ax
F000:156A  [+0x0156A]  B0 19                    mov     al,19h
F000:156C  [+0x0156C]  E8 34 3B                 call    50A3h
F000:156F  [+0x0156F]  2A E3                    sub     ah,bl
F000:1571  [+0x01571]  EF                       out     dx,ax
F000:1572  [+0x01572]  C3                       ret
F000:1573  [+0x01573]  B0 28                    mov     al,28h
F000:1575  [+0x01575]  E8 2B 3B                 call    50A3h
F000:1578  [+0x01578]  B0 02                    mov     al,2
F000:157A  [+0x0157A]  F6 C4 10                 test    ah,10h
F000:157D  [+0x0157D]  75 39                    jne     short 15B8h
F000:157F  [+0x0157F]  E8 96 FF                 call    1518h
F000:1582  [+0x01582]  B0 04                    mov     al,4
F000:1584  [+0x01584]  80 FC 6A                 cmp     ah,6Ah
F000:1587  [+0x01587]  73 2F                    jae     short 15B8h
F000:1589  [+0x01589]  B0 01                    mov     al,1
F000:158B  [+0x0158B]  80 FC 0D                 cmp     ah,0Dh
F000:158E  [+0x0158E]  74 28                    je      short 15B8h
F000:1590  [+0x01590]  B0 01                    mov     al,1
F000:1592  [+0x01592]  80 FC 04                 cmp     ah,4
F000:1595  [+0x01595]  74 21                    je      short 15B8h
F000:1597  [+0x01597]  80 FC 05                 cmp     ah,5
F000:159A  [+0x0159A]  74 1C                    je      short 15B8h
F000:159C  [+0x0159C]  80 FC 01                 cmp     ah,1
F000:159F  [+0x0159F]  76 17                    jbe     short 15B8h
F000:15A1  [+0x015A1]  B0 04                    mov     al,4
F000:15A3  [+0x015A3]  80 FC 06                 cmp     ah,6
F000:15A6  [+0x015A6]  74 10                    je      short 15B8h
F000:15A8  [+0x015A8]  B0 00                    mov     al,0
F000:15AA  [+0x015AA]  80 FC 0E                 cmp     ah,0Eh
F000:15AD  [+0x015AD]  72 09                    jb      short 15B8h
F000:15AF  [+0x015AF]  B0 00                    mov     al,0
F000:15B1  [+0x015B1]  80 FC 13                 cmp     ah,13h
F000:15B4  [+0x015B4]  77 02                    ja      short 15B8h
F000:15B6  [+0x015B6]  B0 04                    mov     al,4
F000:15B8  [+0x015B8]  C3                       ret
F000:15B9  [+0x015B9]  2E F6 06 94 01 10        test    byte [cs:194h],10h
F000:15BF  [+0x015BF]  74 18                    je      short 15D9h
F000:15C1  [+0x015C1]  E8 AF FF                 call    1573h
F000:15C4  [+0x015C4]  B4 51                    mov     ah,51h
F000:15C6  [+0x015C6]  3C 01                    cmp     al,1
F000:15C8  [+0x015C8]  75 09                    jne     short 15D3h
F000:15CA  [+0x015CA]  B4 55                    mov     ah,55h
F000:15CC  [+0x015CC]  E8 8E F6                 call    0C5Dh
F000:15CF  [+0x015CF]  75 02                    jne     short 15D3h
F000:15D1  [+0x015D1]  B4 53                    mov     ah,53h
F000:15D3  [+0x015D3]  BA D6 03                 mov     dx,3D6h
F000:15D6  [+0x015D6]  B0 2D                    mov     al,2Dh
F000:15D8  [+0x015D8]  EF                       out     dx,ax
F000:15D9  [+0x015D9]  C3                       ret
F000:15DA  [+0x015DA]  56                       push    si
F000:15DB  [+0x015DB]  50                       push    ax
F000:15DC  [+0x015DC]  53                       push    bx
F000:15DD  [+0x015DD]  E8 38 FF                 call    1518h
F000:15E0  [+0x015E0]  8B D8                    mov     bx,ax
F000:15E2  [+0x015E2]  8A CC                    mov     cl,ah
F000:15E4  [+0x015E4]  B8 39 5F                 mov     ax,5F39h
F000:15E7  [+0x015E7]  E8 A2 18                 call    2E8Ch
F000:15EA  [+0x015EA]  BE 88 01                 mov     si,188h
F000:15ED  [+0x015ED]  2E 8A 0C                 mov     cl,[cs:si]
F000:15F0  [+0x015F0]  2E 8A 6C 01              mov     ch,[cs:si+1]
F000:15F4  [+0x015F4]  E8 66 F6                 call    0C5Dh
F000:15F7  [+0x015F7]  75 08                    jne     short 1601h
F000:15F9  [+0x015F9]  2E 8A 4C 02              mov     cl,[cs:si+2]
F000:15FD  [+0x015FD]  2E 8A 6C 03              mov     ch,[cs:si+3]
F000:1601  [+0x01601]  E8 2F 0A                 call    2033h
F000:1604  [+0x01604]  F6 C4 10                 test    ah,10h
F000:1607  [+0x01607]  74 2F                    je      short 1638h
F000:1609  [+0x01609]  2E 8A 4C 04              mov     cl,[cs:si+4]
F000:160D  [+0x0160D]  2E 8A 6C 06              mov     ch,[cs:si+6]
F000:1611  [+0x01611]  80 FF 50                 cmp     bh,50h
F000:1614  [+0x01614]  75 08                    jne     short 161Eh
F000:1616  [+0x01616]  2E 8A 4C 07              mov     cl,[cs:si+7]
F000:161A  [+0x0161A]  2E 8A 6C 09              mov     ch,[cs:si+9]
F000:161E  [+0x0161E]  E8 3C F6                 call    0C5Dh
F000:1621  [+0x01621]  75 15                    jne     short 1638h
F000:1623  [+0x01623]  2E 8A 4C 05              mov     cl,[cs:si+5]
F000:1627  [+0x01627]  2E 8A 6C 06              mov     ch,[cs:si+6]
F000:162B  [+0x0162B]  80 FF 50                 cmp     bh,50h
F000:162E  [+0x0162E]  75 08                    jne     short 1638h
F000:1630  [+0x01630]  2E 8A 4C 08              mov     cl,[cs:si+8]
F000:1634  [+0x01634]  2E 8A 6C 09              mov     ch,[cs:si+9]
F000:1638  [+0x01638]  EB 00                    jmp     short 163Ah
F000:163A  [+0x0163A]  E8 C7 0D                 call    2404h
F000:163D  [+0x0163D]  75 0F                    jne     short 164Eh
F000:163F  [+0x0163F]  2E 8A 2E 14 02           mov     ch,[cs:214h]
F000:1644  [+0x01644]  E8 16 F6                 call    0C5Dh
F000:1647  [+0x01647]  74 05                    je      short 164Eh
F000:1649  [+0x01649]  2E 8A 0E 13 02           mov     cl,[cs:213h]
F000:164E  [+0x0164E]  5B                       pop     bx
F000:164F  [+0x0164F]  58                       pop     ax
F000:1650  [+0x01650]  5E                       pop     si
F000:1651  [+0x01651]  C3                       ret
F000:1652  [+0x01652]  E8 F1 F5                 call    0C46h
F000:1655  [+0x01655]  75 5B                    jne     short 16B2h
F000:1657  [+0x01657]  53                       push    bx
F000:1658  [+0x01658]  52                       push    dx
F000:1659  [+0x01659]  50                       push    ax
F000:165A  [+0x0165A]  50                       push    ax
F000:165B  [+0x0165B]  51                       push    cx
F000:165C  [+0x0165C]  8A C8                    mov     cl,al
F000:165E  [+0x0165E]  B8 39 5F                 mov     ax,5F39h
F000:1661  [+0x01661]  E8 28 18                 call    2E8Ch
F000:1664  [+0x01664]  59                       pop     cx
F000:1665  [+0x01665]  58                       pop     ax
F000:1666  [+0x01666]  2E 8A 1E 82 01           mov     bl,[cs:182h]
F000:166B  [+0x0166B]  3C 13                    cmp     al,13h
F000:166D  [+0x0166D]  76 0F                    jbe     short 167Eh
F000:166F  [+0x0166F]  2E 8A 1E 84 01           mov     bl,[cs:184h]
F000:1674  [+0x01674]  E8 9A 0D                 call    2411h
F000:1677  [+0x01677]  74 05                    je      short 167Eh
F000:1679  [+0x01679]  2E 8A 1E 83 01           mov     bl,[cs:183h]
F000:167E  [+0x0167E]  3C 50                    cmp     al,50h
F000:1680  [+0x01680]  75 05                    jne     short 1687h
F000:1682  [+0x01682]  2E 8A 1E 95 01           mov     bl,[cs:195h]
F000:1687  [+0x01687]  E8 7A 0D                 call    2404h
F000:168A  [+0x0168A]  75 05                    jne     short 1691h
F000:168C  [+0x0168C]  2E 8A 1E 14 02           mov     bl,[cs:214h]
F000:1691  [+0x01691]  B7 03                    mov     bh,3
F000:1693  [+0x01693]  BA 00 00                 mov     dx,0
F000:1696  [+0x01696]  E8 1A 00                 call    16B3h
F000:1699  [+0x01699]  58                       pop     ax
F000:169A  [+0x0169A]  3C 13                    cmp     al,13h
F000:169C  [+0x0169C]  76 12                    jbe     short 16B0h
F000:169E  [+0x0169E]  E8 41 01                 call    17E2h
F000:16A1  [+0x016A1]  75 0D                    jne     short 16B0h
F000:16A3  [+0x016A3]  BA 00 00                 mov     dx,0
F000:16A6  [+0x016A6]  2E 8A 9D F4 0A           mov     bl,[cs:di+0AF4h]
F000:16AB  [+0x016AB]  B7 02                    mov     bh,2
F000:16AD  [+0x016AD]  E8 03 00                 call    16B3h
F000:16B0  [+0x016B0]  5A                       pop     dx
F000:16B1  [+0x016B1]  5B                       pop     bx
F000:16B2  [+0x016B2]  C3                       ret
F000:16B3  [+0x016B3]  50                       push    ax
F000:16B4  [+0x016B4]  E8 2F 0D                 call    23E6h
F000:16B7  [+0x016B7]  A8 40                    test    al,40h
F000:16B9  [+0x016B9]  58                       pop     ax
F000:16BA  [+0x016BA]  75 4F                    jne     short 170Bh
F000:16BC  [+0x016BC]  50                       push    ax
F000:16BD  [+0x016BD]  53                       push    bx
F000:16BE  [+0x016BE]  51                       push    cx
F000:16BF  [+0x016BF]  57                       push    di
F000:16C0  [+0x016C0]  56                       push    si
F000:16C1  [+0x016C1]  8B F3                    mov     si,bx
F000:16C3  [+0x016C3]  B1 03                    mov     cl,3
F000:16C5  [+0x016C5]  80 FB 18                 cmp     bl,18h
F000:16C8  [+0x016C8]  73 02                    jae     short 16CCh
F000:16CA  [+0x016CA]  B1 05                    mov     cl,5
F000:16CC  [+0x016CC]  51                       push    cx
F000:16CD  [+0x016CD]  BF 58 17                 mov     di,1758h
F000:16D0  [+0x016D0]  8B CB                    mov     cx,bx
F000:16D2  [+0x016D2]  32 ED                    xor     ch,ch
F000:16D4  [+0x016D4]  83 E9 0C                 sub     cx,0Ch
F000:16D7  [+0x016D7]  03 F9                    add     di,cx
F000:16D9  [+0x016D9]  2E 8A 1D                 mov     bl,[cs:di]
F000:16DC  [+0x016DC]  BF 9D 17                 mov     di,179Dh
F000:16DF  [+0x016DF]  03 F9                    add     di,cx
F000:16E1  [+0x016E1]  2E 8A 3D                 mov     bh,[cs:di]
F000:16E4  [+0x016E4]  59                       pop     cx
F000:16E5  [+0x016E5]  E8 24 00                 call    170Ch
F000:16E8  [+0x016E8]  5E                       pop     si
F000:16E9  [+0x016E9]  5F                       pop     di
F000:16EA  [+0x016EA]  59                       pop     cx
F000:16EB  [+0x016EB]  5B                       pop     bx
F000:16EC  [+0x016EC]  B0 04                    mov     al,4
F000:16EE  [+0x016EE]  E8 3B 09                 call    202Ch
F000:16F1  [+0x016F1]  80 E4 DF                 and     ah,0DFh
F000:16F4  [+0x016F4]  50                       push    ax
F000:16F5  [+0x016F5]  E8 04 F8                 call    0EFCh
F000:16F8  [+0x016F8]  BA D6 03                 mov     dx,3D6h
F000:16FB  [+0x016FB]  58                       pop     ax
F000:16FC  [+0x016FC]  74 08                    je      short 1706h
F000:16FE  [+0x016FE]  80 FB 41                 cmp     bl,41h
F000:1701  [+0x01701]  77 03                    ja      short 1706h
F000:1703  [+0x01703]  80 CC 20                 or      ah,20h
F000:1706  [+0x01706]  EF                       out     dx,ax
F000:1707  [+0x01707]  E8 01 F8                 call    0F0Bh
F000:170A  [+0x0170A]  58                       pop     ax
F000:170B  [+0x0170B]  C3                       ret
F000:170C  [+0x0170C]  BA D6 03                 mov     dx,3D6h
F000:170F  [+0x0170F]  8B C6                    mov     ax,si
F000:1711  [+0x01711]  8A EC                    mov     ch,ah
F000:1713  [+0x01713]  B0 33                    mov     al,33h
F000:1715  [+0x01715]  EE                       out     dx,al
F000:1716  [+0x01716]  ED                       in      ax,dx
F000:1717  [+0x01717]  80 E4 DF                 and     ah,0DFh
F000:171A  [+0x0171A]  80 FD 03                 cmp     ch,3
F000:171D  [+0x0171D]  75 03                    jne     short 1722h
F000:171F  [+0x0171F]  80 CC 20                 or      ah,20h
F000:1722  [+0x01722]  EF                       out     dx,ax
F000:1723  [+0x01723]  B0 30                    mov     al,30h
F000:1725  [+0x01725]  8A E1                    mov     ah,cl
F000:1727  [+0x01727]  EF                       out     dx,ax
F000:1728  [+0x01728]  FE C0                    inc     al
F000:172A  [+0x0172A]  80 EB 02                 sub     bl,2
F000:172D  [+0x0172D]  8A E3                    mov     ah,bl
F000:172F  [+0x0172F]  EF                       out     dx,ax
F000:1730  [+0x01730]  FE C0                    inc     al
F000:1732  [+0x01732]  80 EF 02                 sub     bh,2
F000:1735  [+0x01735]  8A E7                    mov     ah,bh
F000:1737  [+0x01737]  EF                       out     dx,ax
F000:1738  [+0x01738]  B9 19 00                 mov     cx,19h
F000:173B  [+0x0173B]  32 C0                    xor     al,al
F000:173D  [+0x0173D]  E8 90 39                 call    50D0h
F000:1740  [+0x01740]  E8 03 F5                 call    0C46h
F000:1743  [+0x01743]  74 12                    je      short 1757h
F000:1745  [+0x01745]  8B DE                    mov     bx,si
F000:1747  [+0x01747]  B7 02                    mov     bh,2
F000:1749  [+0x01749]  75 0C                    jne     short 1757h
F000:174B  [+0x0174B]  B0 54                    mov     al,54h
F000:174D  [+0x0174D]  E8 DC 08                 call    202Ch
F000:1750  [+0x01750]  80 E4 F3                 and     ah,0F3h
F000:1753  [+0x01753]  80 CC 08                 or      ah,8
F000:1756  [+0x01756]  EF                       out     dx,ax
F000:1757  [+0x01757]  C3                       ret
F000:1758  [+0x01758]  39 45 2C                 cmp     [di+2Ch],ax
F000:175B  [+0x0175B]  16                       push    ss
F000:175C  [+0x0175C]  13 13                    adc     dx,[bp+di]
F000:175E  [+0x0175E]  2C 45                    sub     al,45h
F000:1760  [+0x01760]  58                       pop     ax
F000:1761  [+0x01761]  16                       push    ss
F000:1762  [+0x01762]  3F                       aas
F000:1763  [+0x01763]  62 39                    bound   di,[bx+di]
F000:1765  [+0x01765]  50                       push    ax
F000:1766  [+0x01766]  45                       inc     bp
F000:1767  [+0x01767]  21 5A 50                 and     [bp+si+50h],bx
F000:176A  [+0x0176A]  16                       push    ss
F000:176B  [+0x0176B]  5C                       pop     sp
F000:176C  [+0x0176C]  13 44 13                 adc     ax,[si+13h]
F000:176F  [+0x0176F]  0B 2C                    or      bp,[si]
F000:1771  [+0x01771]  73 45                    jae     short 17B8h
F000:1773  [+0x01773]  4F                       dec     di
F000:1774  [+0x01774]  58                       pop     ax
F000:1775  [+0x01775]  3F                       aas
F000:1776  [+0x01776]  16                       push    ss
F000:1777  [+0x01777]  0C 3F                    or      al,3Fh
F000:1779  [+0x01779]  16                       push    ss
F000:177A  [+0x0177A]  62 57 77                 bound   dx,[bx+77h]
F000:177D  [+0x0177D]  4D                       dec     bp
F000:177E  [+0x0177E]  6D                       insw
F000:177F  [+0x0177F]  39 45 7C                 cmp     [di+7Ch],ax
F000:1782  [+0x01782]  42                       inc     dx
F000:1783  [+0x01783]  79 5B                    jns     short 17E0h
F000:1785  [+0x01785]  7F 4F                    jg      short 17D6h
F000:1787  [+0x01787]  44                       inc     sp
F000:1788  [+0x01788]  2C 31                    sub     al,31h
F000:178A  [+0x0178A]  77 16                    ja      short 17A2h
F000:178C  [+0x0178C]  26 54                    push    sp
F000:178E  [+0x0178E]  35 7C 13                 xor     ax,137Ch
F000:1791  [+0x01791]  35 16 77                 xor     ax,7716h
F000:1794  [+0x01794]  58                       pop     ax
F000:1795  [+0x01795]  33 1F                    xor     bx,[bx]
F000:1797  [+0x01797]  7C 45                    jl      short 17DEh
F000:1799  [+0x01799]  79 4F                    jns     short 17EAh
F000:179B  [+0x0179B]  50                       push    ax
F000:179C  [+0x0179C]  5F                       pop     di
F000:179D  [+0x0179D]  44                       inc     sp
F000:179E  [+0x0179E]  4C                       dec     sp
F000:179F  [+0x0179F]  2D 15 11                 sub     ax,1115h
F000:17A2  [+0x017A2]  10 23                    adc     [bp+di],ah
F000:17A4  [+0x017A4]  34 3F                    xor     al,3Fh
F000:17A6  [+0x017A6]  0F 29 3D                 movaps  [di],xmm7
F000:17A9  [+0x017A9]  44                       inc     sp
F000:17AA  [+0x017AA]  5B                       pop     bx
F000:17AB  [+0x017AB]  4C                       dec     sp
F000:17AC  [+0x017AC]  23 5B 4F                 and     bx,[bp+di+4Fh]
F000:17AF  [+0x017AF]  15 55 11                 adc     ax,1155h
F000:17B2  [+0x017B2]  3B 10                    cmp     dx,[bx+si]
F000:17B4  [+0x017B4]  09 23                    or      [bp+di],sp
F000:17B6  [+0x017B6]  59                       pop     cx
F000:17B7  [+0x017B7]  34 3A                    xor     al,3Ah
F000:17B9  [+0x017B9]  3F                       aas
F000:17BA  [+0x017BA]  2C 0F                    sub     al,0Fh
F000:17BC  [+0x017BC]  08 29                    or      [bx+di],ch
F000:17BE  [+0x017BE]  0E                       push    cs
F000:17BF  [+0x017BF]  3D 35 47                 cmp     ax,4735h
F000:17C2  [+0x017C2]  2D 3E 20                 sub     ax,203Eh
F000:17C5  [+0x017C5]  26 43                    inc     bx
F000:17C7  [+0x017C7]  23 3F                    and     di,[bx]
F000:17C9  [+0x017C9]  2E 40                    inc     ax
F000:17CB  [+0x017CB]  27                       daa
F000:17CC  [+0x017CC]  21 15                    and     [di],dx
F000:17CE  [+0x017CE]  17                       pop     ss
F000:17CF  [+0x017CF]  37                       aaa
F000:17D0  [+0x017D0]  0A 11                    or      dl,[bx+di]
F000:17D2  [+0x017D2]  25 17 35                 and     ax,3517h
F000:17D5  [+0x017D5]  08 16 09 30              or      [3009h],dl
F000:17D9  [+0x017D9]  23 14                    and     dx,[si]
F000:17DB  [+0x017DB]  0C 2F                    or      al,2Fh
F000:17DD  [+0x017DD]  1A 2D                    sbb     ch,[di]
F000:17DF  [+0x017DF]  1D 1D 22                 sbb     ax,221Dh
F000:17E2  [+0x017E2]  FC                       cld
F000:17E3  [+0x017E3]  06                       push    es
F000:17E4  [+0x017E4]  51                       push    cx
F000:17E5  [+0x017E5]  0A C0                    or      al,al
F000:17E7  [+0x017E7]  74 20                    je      short 1809h
F000:17E9  [+0x017E9]  8C CF                    mov     di,cs
F000:17EB  [+0x017EB]  8E C7                    mov     es,di
F000:17ED  [+0x017ED]  32 ED                    xor     ch,ch
F000:17EF  [+0x017EF]  BF DD 0A                 mov     di,0ADDh
F000:17F2  [+0x017F2]  2E 8A 0E DC 0A           mov     cl,[cs:0ADCh]
F000:17F7  [+0x017F7]  F2 AE                    repne scasb
F000:17F9  [+0x017F9]  75 0B                    jne     short 1806h
F000:17FB  [+0x017FB]  81 EF DE 0A              sub     di,0ADEh
F000:17FF  [+0x017FF]  D1 E7                    shl     di,1
F000:1801  [+0x01801]  D1 E7                    shl     di,1
F000:1803  [+0x01803]  E8 A9 07                 call    1FAFh
F000:1806  [+0x01806]  59                       pop     cx
F000:1807  [+0x01807]  07                       pop     es
F000:1808  [+0x01808]  C3                       ret
F000:1809  [+0x01809]  80 C9 FF                 or      cl,0FFh
F000:180C  [+0x0180C]  EB F8                    jmp     short 1806h
F000:180E  [+0x0180E]  57                       push    di
F000:180F  [+0x0180F]  E8 D0 FF                 call    17E2h
F000:1812  [+0x01812]  75 05                    jne     short 1819h
F000:1814  [+0x01814]  2E 8A 85 F3 0A           mov     al,[cs:di+0AF3h]
F000:1819  [+0x01819]  5F                       pop     di
F000:181A  [+0x0181A]  C3                       ret
F000:181B  [+0x0181B]  57                       push    di
F000:181C  [+0x0181C]  E8 C3 FF                 call    17E2h
F000:181F  [+0x0181F]  2E 8B B5 F5 0A           mov     si,[cs:di+0AF5h]
F000:1824  [+0x01824]  5F                       pop     di
F000:1825  [+0x01825]  C3                       ret
F000:1826  [+0x01826]  57                       push    di
F000:1827  [+0x01827]  E8 B8 FF                 call    17E2h
F000:182A  [+0x0182A]  74 06                    je      short 1832h
F000:182C  [+0x0182C]  33 C0                    xor     ax,ax
F000:182E  [+0x0182E]  33 DB                    xor     bx,bx
F000:1830  [+0x01830]  EB 17                    jmp     short 1849h
F000:1832  [+0x01832]  B8 10 00                 mov     ax,10h
F000:1835  [+0x01835]  2E 8B 9D F3 0A           mov     bx,[cs:di+0AF3h]
F000:183A  [+0x0183A]  86 FB                    xchg    bh,bl
F000:183C  [+0x0183C]  F6 C7 01                 test    bh,1
F000:183F  [+0x0183F]  75 08                    jne     short 1849h
F000:1841  [+0x01841]  F6 C7 04                 test    bh,4
F000:1844  [+0x01844]  74 03                    je      short 1849h
F000:1846  [+0x01846]  B8 00 01                 mov     ax,100h
F000:1849  [+0x01849]  5F                       pop     di
F000:184A  [+0x0184A]  AB                       stosw
F000:184B  [+0x0184B]  B0 01                    mov     al,1
F000:184D  [+0x0184D]  AA                       stosb
F000:184E  [+0x0184E]  80 E3 F0                 and     bl,0F0h
F000:1851  [+0x01851]  B1 04                    mov     cl,4
F000:1853  [+0x01853]  D2 EB                    shr     bl,cl
F000:1855  [+0x01855]  E9 D7 33                 jmp     4C2Fh
F000:1858  [+0x01858]  50                       push    ax
F000:1859  [+0x01859]  33 C0                    xor     ax,ax
F000:185B  [+0x0185B]  58                       pop     ax
F000:185C  [+0x0185C]  C3                       ret
F000:185D  [+0x0185D]  50                       push    ax
F000:185E  [+0x0185E]  53                       push    bx
F000:185F  [+0x0185F]  52                       push    dx
F000:1860  [+0x01860]  8A D8                    mov     bl,al
F000:1862  [+0x01862]  BA D6 03                 mov     dx,3D6h
F000:1865  [+0x01865]  B0 10                    mov     al,10h
F000:1867  [+0x01867]  E8 20 38                 call    508Ah
F000:186A  [+0x0186A]  88 66 02                 mov     [bp+2],ah
F000:186D  [+0x0186D]  E8 1A 38                 call    508Ah
F000:1870  [+0x01870]  88 66 03                 mov     [bp+3],ah
F000:1873  [+0x01873]  B0 0B                    mov     al,0Bh
F000:1875  [+0x01875]  E8 26 38                 call    509Eh
F000:1878  [+0x01878]  88 66 01                 mov     [bp+1],ah
F000:187B  [+0x0187B]  80 E4 FD                 and     ah,0FDh
F000:187E  [+0x0187E]  F6 C3 04                 test    bl,4
F000:1881  [+0x01881]  74 03                    je      short 1886h
F000:1883  [+0x01883]  80 CC 04                 or      ah,4
F000:1886  [+0x01886]  EF                       out     dx,ax
F000:1887  [+0x01887]  5A                       pop     dx
F000:1888  [+0x01888]  5B                       pop     bx
F000:1889  [+0x01889]  9D                       popf
F000:188A  [+0x0188A]  C3                       ret
F000:188B  [+0x0188B]  50                       push    ax
F000:188C  [+0x0188C]  52                       push    dx
F000:188D  [+0x0188D]  BA D6 03                 mov     dx,3D6h
F000:1890  [+0x01890]  B0 0B                    mov     al,0Bh
F000:1892  [+0x01892]  8A 66 01                 mov     ah,[bp+1]
F000:1895  [+0x01895]  EF                       out     dx,ax
F000:1896  [+0x01896]  B0 10                    mov     al,10h
F000:1898  [+0x01898]  8A 66 02                 mov     ah,[bp+2]
F000:189B  [+0x0189B]  EF                       out     dx,ax
F000:189C  [+0x0189C]  B0 11                    mov     al,11h
F000:189E  [+0x0189E]  8A 66 03                 mov     ah,[bp+3]
F000:18A1  [+0x018A1]  EF                       out     dx,ax
F000:18A2  [+0x018A2]  5A                       pop     dx
F000:18A3  [+0x018A3]  58                       pop     ax
F000:18A4  [+0x018A4]  C3                       ret
F000:18A5  [+0x018A5]  FD                       std
F000:18A6  [+0x018A6]  9C                       pushf
F000:18A7  [+0x018A7]  58                       pop     ax
F000:18A8  [+0x018A8]  8B D8                    mov     bx,ax
F000:18AA  [+0x018AA]  83 EC 04                 sub     sp,4
F000:18AD  [+0x018AD]  8B EC                    mov     bp,sp
F000:18AF  [+0x018AF]  E8 AB FF                 call    185Dh
F000:18B2  [+0x018B2]  83 EC 08                 sub     sp,8
F000:18B5  [+0x018B5]  8B C2                    mov     ax,dx
F000:18B7  [+0x018B7]  2B D1                    sub     dx,cx
F000:18B9  [+0x018B9]  FE C6                    inc     dh
F000:18BB  [+0x018BB]  FE C2                    inc     dl
F000:18BD  [+0x018BD]  B9 00 10                 mov     cx,1000h
F000:18C0  [+0x018C0]  53                       push    bx
F000:18C1  [+0x018C1]  9D                       popf
F000:18C2  [+0x018C2]  7B 03                    jnp     short 18C7h
F000:18C4  [+0x018C4]  B9 03 04                 mov     cx,403h
F000:18C7  [+0x018C7]  88 4E F9                 mov     [bp-7],cl
F000:18CA  [+0x018CA]  88 6E F8                 mov     [bp-8],ch
F000:18CD  [+0x018CD]  32 ED                    xor     ch,ch
F000:18CF  [+0x018CF]  E8 BC 04                 call    1D8Eh
F000:18D2  [+0x018D2]  52                       push    dx
F000:18D3  [+0x018D3]  8B 16 85 04              mov     dx,[485h]
F000:18D7  [+0x018D7]  4A                       dec     dx
F000:18D8  [+0x018D8]  A1 4A 04                 mov     ax,[44Ah]
F000:18DB  [+0x018DB]  D3 E0                    shl     ax,cl
F000:18DD  [+0x018DD]  F7 E2                    mul     dx
F000:18DF  [+0x018DF]  03 F0                    add     si,ax
F000:18E1  [+0x018E1]  80 D2 00                 adc     dl,0
F000:18E4  [+0x018E4]  E3 0A                    jcxz    18F0h
F000:18E6  [+0x018E6]  83 C6 07                 add     si,7
F000:18E9  [+0x018E9]  80 D2 00                 adc     dl,0
F000:18EC  [+0x018EC]  B0 08                    mov     al,8
F000:18EE  [+0x018EE]  EB 06                    jmp     short 18F6h
F000:18F0  [+0x018F0]  D0 E2                    shl     dl,1
F000:18F2  [+0x018F2]  D0 E2                    shl     dl,1
F000:18F4  [+0x018F4]  B0 20                    mov     al,20h
F000:18F6  [+0x018F6]  D0 E2                    shl     dl,1
F000:18F8  [+0x018F8]  D0 E2                    shl     dl,1
F000:18FA  [+0x018FA]  D0 E2                    shl     dl,1
F000:18FC  [+0x018FC]  D0 E2                    shl     dl,1
F000:18FE  [+0x018FE]  02 DA                    add     bl,dl
F000:1900  [+0x01900]  F7 C6 00 80              test    si,8000h
F000:1904  [+0x01904]  74 06                    je      short 190Ch
F000:1906  [+0x01906]  02 D8                    add     bl,al
F000:1908  [+0x01908]  81 E6 FF 7F              and     si,7FFFh
F000:190C  [+0x0190C]  5A                       pop     dx
F000:190D  [+0x0190D]  EB 2C                    jmp     short 193Bh
F000:190F  [+0x0190F]  9C                       pushf
F000:1910  [+0x01910]  58                       pop     ax
F000:1911  [+0x01911]  8B D8                    mov     bx,ax
F000:1913  [+0x01913]  83 EC 04                 sub     sp,4
F000:1916  [+0x01916]  8B EC                    mov     bp,sp
F000:1918  [+0x01918]  E8 42 FF                 call    185Dh
F000:191B  [+0x0191B]  83 EC 08                 sub     sp,8
F000:191E  [+0x0191E]  8B C1                    mov     ax,cx
F000:1920  [+0x01920]  2B D1                    sub     dx,cx
F000:1922  [+0x01922]  FE C6                    inc     dh
F000:1924  [+0x01924]  FE C2                    inc     dl
F000:1926  [+0x01926]  B9 00 10                 mov     cx,1000h
F000:1929  [+0x01929]  53                       push    bx
F000:192A  [+0x0192A]  9D                       popf
F000:192B  [+0x0192B]  7B 03                    jnp     short 1930h
F000:192D  [+0x0192D]  B9 03 04                 mov     cx,403h
F000:1930  [+0x01930]  88 4E F9                 mov     [bp-7],cl
F000:1933  [+0x01933]  88 6E F8                 mov     [bp-8],ch
F000:1936  [+0x01936]  32 ED                    xor     ch,ch
F000:1938  [+0x01938]  E8 53 04                 call    1D8Eh
F000:193B  [+0x0193B]  B8 00 A8                 mov     ax,0A800h
F000:193E  [+0x0193E]  8E C0                    mov     es,ax
F000:1940  [+0x01940]  8B FE                    mov     di,si
F000:1942  [+0x01942]  52                       push    dx
F000:1943  [+0x01943]  53                       push    bx
F000:1944  [+0x01944]  8B 1E 4A 04              mov     bx,[44Ah]
F000:1948  [+0x01948]  8A 46 04                 mov     al,[bp+4]
F000:194B  [+0x0194B]  F6 E3                    mul     bl
F000:194D  [+0x0194D]  F7 26 85 04              mul     word [485h]
F000:1951  [+0x01951]  E3 0C                    jcxz    195Fh
F000:1953  [+0x01953]  D1 E0                    shl     ax,1
F000:1955  [+0x01955]  D0 D2                    rcl     dl,1
F000:1957  [+0x01957]  D1 E0                    shl     ax,1
F000:1959  [+0x01959]  D0 D2                    rcl     dl,1
F000:195B  [+0x0195B]  D1 E0                    shl     ax,1
F000:195D  [+0x0195D]  D0 D2                    rcl     dl,1
F000:195F  [+0x0195F]  80 7E 05 07              cmp     byte [bp+5],7
F000:1963  [+0x01963]  75 09                    jne     short 196Eh
F000:1965  [+0x01965]  2B F0                    sub     si,ax
F000:1967  [+0x01967]  80 D2 00                 adc     dl,0
F000:196A  [+0x0196A]  F6 DA                    neg     dl
F000:196C  [+0x0196C]  EB 05                    jmp     short 1973h
F000:196E  [+0x0196E]  03 F0                    add     si,ax
F000:1970  [+0x01970]  80 D2 00                 adc     dl,0
F000:1973  [+0x01973]  0A C9                    or      cl,cl
F000:1975  [+0x01975]  75 04                    jne     short 197Bh
F000:1977  [+0x01977]  D0 E2                    shl     dl,1
F000:1979  [+0x01979]  D0 E2                    shl     dl,1
F000:197B  [+0x0197B]  D0 E2                    shl     dl,1
F000:197D  [+0x0197D]  D0 E2                    shl     dl,1
F000:197F  [+0x0197F]  D0 E2                    shl     dl,1
F000:1981  [+0x01981]  D0 E2                    shl     dl,1
F000:1983  [+0x01983]  58                       pop     ax
F000:1984  [+0x01984]  8A E0                    mov     ah,al
F000:1986  [+0x01986]  02 C2                    add     al,dl
F000:1988  [+0x01988]  8B D6                    mov     dx,si
F000:198A  [+0x0198A]  D1 C2                    rol     dx,1
F000:198C  [+0x0198C]  D1 C2                    rol     dx,1
F000:198E  [+0x0198E]  D1 C2                    rol     dx,1
F000:1990  [+0x01990]  D1 C2                    rol     dx,1
F000:1992  [+0x01992]  80 E2 0F                 and     dl,0Fh
F000:1995  [+0x01995]  0A C9                    or      cl,cl
F000:1997  [+0x01997]  75 04                    jne     short 199Dh
F000:1999  [+0x01999]  D0 E2                    shl     dl,1
F000:199B  [+0x0199B]  D0 E2                    shl     dl,1
F000:199D  [+0x0199D]  02 C2                    add     al,dl
F000:199F  [+0x0199F]  81 E6 FF 0F              and     si,0FFFh
F000:19A3  [+0x019A3]  5A                       pop     dx
F000:19A4  [+0x019A4]  2A DA                    sub     bl,dl
F000:19A6  [+0x019A6]  80 DF 00                 sbb     bh,0
F000:19A9  [+0x019A9]  D3 E3                    shl     bx,cl
F000:19AB  [+0x019AB]  52                       push    dx
F000:19AC  [+0x019AC]  8A EE                    mov     ch,dh
F000:19AE  [+0x019AE]  32 F6                    xor     dh,dh
F000:19B0  [+0x019B0]  D3 E2                    shl     dx,cl
F000:19B2  [+0x019B2]  89 5E FE                 mov     [bp-2],bx
F000:19B5  [+0x019B5]  89 56 FC                 mov     [bp-4],dx
F000:19B8  [+0x019B8]  8B D8                    mov     bx,ax
F000:19BA  [+0x019BA]  58                       pop     ax
F000:19BB  [+0x019BB]  80 7E 04 00              cmp     byte [bp+4],0
F000:19BF  [+0x019BF]  74 05                    je      short 19C6h
F000:19C1  [+0x019C1]  2A 6E 04                 sub     ch,[bp+4]
F000:19C4  [+0x019C4]  77 06                    ja      short 19CCh
F000:19C6  [+0x019C6]  88 66 04                 mov     [bp+4],ah
F000:19C9  [+0x019C9]  E9 02 01                 jmp     1ACEh
F000:19CC  [+0x019CC]  8A C5                    mov     al,ch
F000:19CE  [+0x019CE]  F6 26 85 04              mul     byte [485h]
F000:19D2  [+0x019D2]  89 46 FA                 mov     [bp-6],ax
F000:19D5  [+0x019D5]  BA 0B 07                 mov     dx,70Bh
F000:19D8  [+0x019D8]  80 7E F9 00              cmp     byte [bp-7],0
F000:19DC  [+0x019DC]  75 12                    jne     short 19F0h
F000:19DE  [+0x019DE]  B8 05 01                 mov     ax,105h
F000:19E1  [+0x019E1]  52                       push    dx
F000:19E2  [+0x019E2]  BA CE 03                 mov     dx,3CEh
F000:19E5  [+0x019E5]  EF                       out     dx,ax
F000:19E6  [+0x019E6]  B8 02 0F                 mov     ax,0F02h
F000:19E9  [+0x019E9]  BA C4 03                 mov     dx,3C4h
F000:19EC  [+0x019EC]  EF                       out     dx,ax
F000:19ED  [+0x019ED]  5A                       pop     dx
F000:19EE  [+0x019EE]  B6 03                    mov     dh,3
F000:19F0  [+0x019F0]  8B C2                    mov     ax,dx
F000:19F2  [+0x019F2]  BA D6 03                 mov     dx,3D6h
F000:19F5  [+0x019F5]  EF                       out     dx,ax
F000:19F6  [+0x019F6]  E8 78 04                 call    1E71h
F000:19F9  [+0x019F9]  A0 85 04                 mov     al,[485h]
F000:19FC  [+0x019FC]  8A E0                    mov     ah,al
F000:19FE  [+0x019FE]  BA 00 A0                 mov     dx,0A000h
F000:1A01  [+0x01A01]  8E DA                    mov     ds,dx
F000:1A03  [+0x01A03]  80 7E 05 07              cmp     byte [bp+5],7
F000:1A07  [+0x01A07]  75 11                    jne     short 1A1Ah
F000:1A09  [+0x01A09]  32 E4                    xor     ah,ah
F000:1A0B  [+0x01A0B]  01 46 FA                 add     [bp-6],ax
F000:1A0E  [+0x01A0E]  FD                       std
F000:1A0F  [+0x01A0F]  80 7E F9 00              cmp     byte [bp-7],0
F000:1A13  [+0x01A13]  74 73                    je      short 1A88h
F000:1A15  [+0x01A15]  FF 46 FE                 inc     word [bp-2]
F000:1A18  [+0x01A18]  EB 6E                    jmp     short 1A88h
F000:1A1A  [+0x01A1A]  8B 4E FC                 mov     cx,[bp-4]
F000:1A1D  [+0x01A1D]  80 7E F9 00              cmp     byte [bp-7],0
F000:1A21  [+0x01A21]  74 06                    je      short 1A29h
F000:1A23  [+0x01A23]  D1 E9                    shr     cx,1
F000:1A25  [+0x01A25]  F3 A5                    rep movsw
F000:1A27  [+0x01A27]  D1 D1                    rcl     cx,1
F000:1A29  [+0x01A29]  F3 A4                    rep movsb
F000:1A2B  [+0x01A2B]  03 76 FE                 add     si,[bp-2]
F000:1A2E  [+0x01A2E]  03 7E FE                 add     di,[bp-2]
F000:1A31  [+0x01A31]  FE CC                    dec     ah
F000:1A33  [+0x01A33]  75 E5                    jne     short 1A1Ah
F000:1A35  [+0x01A35]  BA 00 40                 mov     dx,4000h
F000:1A38  [+0x01A38]  85 F2                    test    dx,si
F000:1A3A  [+0x01A3A]  74 05                    je      short 1A41h
F000:1A3C  [+0x01A3C]  2B F2                    sub     si,dx
F000:1A3E  [+0x01A3E]  02 5E F8                 add     bl,[bp-8]
F000:1A41  [+0x01A41]  85 FA                    test    dx,di
F000:1A43  [+0x01A43]  74 05                    je      short 1A4Ah
F000:1A45  [+0x01A45]  2B FA                    sub     di,dx
F000:1A47  [+0x01A47]  02 7E F8                 add     bh,[bp-8]
F000:1A4A  [+0x01A4A]  29 46 FA                 sub     [bp-6],ax
F000:1A4D  [+0x01A4D]  76 62                    jbe     short 1AB1h
F000:1A4F  [+0x01A4F]  8A E0                    mov     ah,al
F000:1A51  [+0x01A51]  E8 1D 04                 call    1E71h
F000:1A54  [+0x01A54]  EB C4                    jmp     short 1A1Ah
F000:1A56  [+0x01A56]  80 7E F9 00              cmp     byte [bp-7],0
F000:1A5A  [+0x01A5A]  74 1D                    je      short 1A79h
F000:1A5C  [+0x01A5C]  4E                       dec     si
F000:1A5D  [+0x01A5D]  4F                       dec     di
F000:1A5E  [+0x01A5E]  8B 4E FC                 mov     cx,[bp-4]
F000:1A61  [+0x01A61]  D1 E9                    shr     cx,1
F000:1A63  [+0x01A63]  F3 A5                    rep movsw
F000:1A65  [+0x01A65]  D1 D1                    rcl     cx,1
F000:1A67  [+0x01A67]  46                       inc     si
F000:1A68  [+0x01A68]  47                       inc     di
F000:1A69  [+0x01A69]  F3 A4                    rep movsb
F000:1A6B  [+0x01A6B]  2B 76 FE                 sub     si,[bp-2]
F000:1A6E  [+0x01A6E]  2B 7E FE                 sub     di,[bp-2]
F000:1A71  [+0x01A71]  FE CC                    dec     ah
F000:1A73  [+0x01A73]  75 E9                    jne     short 1A5Eh
F000:1A75  [+0x01A75]  46                       inc     si
F000:1A76  [+0x01A76]  47                       inc     di
F000:1A77  [+0x01A77]  EB 0F                    jmp     short 1A88h
F000:1A79  [+0x01A79]  8B 4E FC                 mov     cx,[bp-4]
F000:1A7C  [+0x01A7C]  F3 A4                    rep movsb
F000:1A7E  [+0x01A7E]  2B 76 FE                 sub     si,[bp-2]
F000:1A81  [+0x01A81]  2B 7E FE                 sub     di,[bp-2]
F000:1A84  [+0x01A84]  FE CC                    dec     ah
F000:1A86  [+0x01A86]  75 F1                    jne     short 1A79h
F000:1A88  [+0x01A88]  BA 00 40                 mov     dx,4000h
F000:1A8B  [+0x01A8B]  85 F2                    test    dx,si
F000:1A8D  [+0x01A8D]  75 09                    jne     short 1A98h
F000:1A8F  [+0x01A8F]  0A DB                    or      bl,bl
F000:1A91  [+0x01A91]  74 05                    je      short 1A98h
F000:1A93  [+0x01A93]  03 F2                    add     si,dx
F000:1A95  [+0x01A95]  2A 5E F8                 sub     bl,[bp-8]
F000:1A98  [+0x01A98]  85 FA                    test    dx,di
F000:1A9A  [+0x01A9A]  75 09                    jne     short 1AA5h
F000:1A9C  [+0x01A9C]  0A FF                    or      bh,bh
F000:1A9E  [+0x01A9E]  74 05                    je      short 1AA5h
F000:1AA0  [+0x01AA0]  03 FA                    add     di,dx
F000:1AA2  [+0x01AA2]  2A 7E F8                 sub     bh,[bp-8]
F000:1AA5  [+0x01AA5]  29 46 FA                 sub     [bp-6],ax
F000:1AA8  [+0x01AA8]  76 07                    jbe     short 1AB1h
F000:1AAA  [+0x01AAA]  8A E0                    mov     ah,al
F000:1AAC  [+0x01AAC]  E8 C2 03                 call    1E71h
F000:1AAF  [+0x01AAF]  EB A5                    jmp     short 1A56h
F000:1AB1  [+0x01AB1]  2E 8E 1E 77 26           mov     ds,[cs:2677h]
F000:1AB6  [+0x01AB6]  80 7E F9 00              cmp     byte [bp-7],0
F000:1ABA  [+0x01ABA]  74 0B                    je      short 1AC7h
F000:1ABC  [+0x01ABC]  80 7E 05 07              cmp     byte [bp+5],7
F000:1AC0  [+0x01AC0]  75 2D                    jne     short 1AEFh
F000:1AC2  [+0x01AC2]  FF 4E FE                 dec     word [bp-2]
F000:1AC5  [+0x01AC5]  EB 28                    jmp     short 1AEFh
F000:1AC7  [+0x01AC7]  B8 05 00                 mov     ax,5
F000:1ACA  [+0x01ACA]  BA CE 03                 mov     dx,3CEh
F000:1ACD  [+0x01ACD]  EF                       out     dx,ax
F000:1ACE  [+0x01ACE]  BA 0B 07                 mov     dx,70Bh
F000:1AD1  [+0x01AD1]  80 7E F9 00              cmp     byte [bp-7],0
F000:1AD5  [+0x01AD5]  75 18                    jne     short 1AEFh
F000:1AD7  [+0x01AD7]  B8 02 0F                 mov     ax,0F02h
F000:1ADA  [+0x01ADA]  52                       push    dx
F000:1ADB  [+0x01ADB]  BA C4 03                 mov     dx,3C4h
F000:1ADE  [+0x01ADE]  EF                       out     dx,ax
F000:1ADF  [+0x01ADF]  BA CE 03                 mov     dx,3CEh
F000:1AE2  [+0x01AE2]  8A 66 07                 mov     ah,[bp+7]
F000:1AE5  [+0x01AE5]  32 C0                    xor     al,al
F000:1AE7  [+0x01AE7]  EF                       out     dx,ax
F000:1AE8  [+0x01AE8]  B8 01 0F                 mov     ax,0F01h
F000:1AEB  [+0x01AEB]  EF                       out     dx,ax
F000:1AEC  [+0x01AEC]  5A                       pop     dx
F000:1AED  [+0x01AED]  B6 03                    mov     dh,3
F000:1AEF  [+0x01AEF]  8B C2                    mov     ax,dx
F000:1AF1  [+0x01AF1]  BA D6 03                 mov     dx,3D6h
F000:1AF4  [+0x01AF4]  EF                       out     dx,ax
F000:1AF5  [+0x01AF5]  8A 46 04                 mov     al,[bp+4]
F000:1AF8  [+0x01AF8]  8A 16 85 04              mov     dl,[485h]
F000:1AFC  [+0x01AFC]  F6 E2                    mul     dl
F000:1AFE  [+0x01AFE]  89 46 FA                 mov     [bp-6],ax
F000:1B01  [+0x01B01]  8A F2                    mov     dh,dl
F000:1B03  [+0x01B03]  8A 46 07                 mov     al,[bp+7]
F000:1B06  [+0x01B06]  8A E0                    mov     ah,al
F000:1B08  [+0x01B08]  E8 66 03                 call    1E71h
F000:1B0B  [+0x01B0B]  80 7E 05 07              cmp     byte [bp+5],7
F000:1B0F  [+0x01B0F]  75 0B                    jne     short 1B1Ch
F000:1B11  [+0x01B11]  32 F6                    xor     dh,dh
F000:1B13  [+0x01B13]  01 56 FA                 add     [bp-6],dx
F000:1B16  [+0x01B16]  FF 46 FE                 inc     word [bp-2]
F000:1B19  [+0x01B19]  FD                       std
F000:1B1A  [+0x01B1A]  EB 3F                    jmp     short 1B5Bh
F000:1B1C  [+0x01B1C]  8B 4E FC                 mov     cx,[bp-4]
F000:1B1F  [+0x01B1F]  D1 E9                    shr     cx,1
F000:1B21  [+0x01B21]  F3 AB                    rep stosw
F000:1B23  [+0x01B23]  D1 D1                    rcl     cx,1
F000:1B25  [+0x01B25]  F3 AA                    rep stosb
F000:1B27  [+0x01B27]  03 7E FE                 add     di,[bp-2]
F000:1B2A  [+0x01B2A]  FE CE                    dec     dh
F000:1B2C  [+0x01B2C]  75 EE                    jne     short 1B1Ch
F000:1B2E  [+0x01B2E]  BE 00 40                 mov     si,4000h
F000:1B31  [+0x01B31]  85 FE                    test    si,di
F000:1B33  [+0x01B33]  74 05                    je      short 1B3Ah
F000:1B35  [+0x01B35]  2B FE                    sub     di,si
F000:1B37  [+0x01B37]  02 7E F8                 add     bh,[bp-8]
F000:1B3A  [+0x01B3A]  29 56 FA                 sub     [bp-6],dx
F000:1B3D  [+0x01B3D]  76 38                    jbe     short 1B77h
F000:1B3F  [+0x01B3F]  8A F2                    mov     dh,dl
F000:1B41  [+0x01B41]  E8 2D 03                 call    1E71h
F000:1B44  [+0x01B44]  EB D6                    jmp     short 1B1Ch
F000:1B46  [+0x01B46]  4F                       dec     di
F000:1B47  [+0x01B47]  8B 4E FC                 mov     cx,[bp-4]
F000:1B4A  [+0x01B4A]  D1 E9                    shr     cx,1
F000:1B4C  [+0x01B4C]  F3 AB                    rep stosw
F000:1B4E  [+0x01B4E]  D1 D1                    rcl     cx,1
F000:1B50  [+0x01B50]  47                       inc     di
F000:1B51  [+0x01B51]  F3 AA                    rep stosb
F000:1B53  [+0x01B53]  2B 7E FE                 sub     di,[bp-2]
F000:1B56  [+0x01B56]  FE CE                    dec     dh
F000:1B58  [+0x01B58]  75 ED                    jne     short 1B47h
F000:1B5A  [+0x01B5A]  47                       inc     di
F000:1B5B  [+0x01B5B]  BE 00 40                 mov     si,4000h
F000:1B5E  [+0x01B5E]  85 FE                    test    si,di
F000:1B60  [+0x01B60]  75 09                    jne     short 1B6Bh
F000:1B62  [+0x01B62]  0A FF                    or      bh,bh
F000:1B64  [+0x01B64]  74 05                    je      short 1B6Bh
F000:1B66  [+0x01B66]  03 FE                    add     di,si
F000:1B68  [+0x01B68]  2A 7E F8                 sub     bh,[bp-8]
F000:1B6B  [+0x01B6B]  29 56 FA                 sub     [bp-6],dx
F000:1B6E  [+0x01B6E]  76 07                    jbe     short 1B77h
F000:1B70  [+0x01B70]  8A F2                    mov     dh,dl
F000:1B72  [+0x01B72]  E8 FC 02                 call    1E71h
F000:1B75  [+0x01B75]  EB CF                    jmp     short 1B46h
F000:1B77  [+0x01B77]  80 7E F9 00              cmp     byte [bp-7],0
F000:1B7B  [+0x01B7B]  75 07                    jne     short 1B84h
F000:1B7D  [+0x01B7D]  BA CE 03                 mov     dx,3CEh
F000:1B80  [+0x01B80]  B8 01 00                 mov     ax,1
F000:1B83  [+0x01B83]  EF                       out     dx,ax
F000:1B84  [+0x01B84]  83 C4 08                 add     sp,8
F000:1B87  [+0x01B87]  E8 01 FD                 call    188Bh
F000:1B8A  [+0x01B8A]  83 C4 08                 add     sp,8
F000:1B8D  [+0x01B8D]  C3                       ret
F000:1B8E  [+0x01B8E]  E8 AE 03                 call    1F3Fh
F000:1B91  [+0x01B91]  73 5B                    jae     short 1BEEh
F000:1B93  [+0x01B93]  75 56                    jne     short 1BEBh
F000:1B95  [+0x01B95]  56                       push    si
F000:1B96  [+0x01B96]  53                       push    bx
F000:1B97  [+0x01B97]  51                       push    cx
F000:1B98  [+0x01B98]  52                       push    dx
F000:1B99  [+0x01B99]  55                       push    bp
F000:1B9A  [+0x01B9A]  9C                       pushf
F000:1B9B  [+0x01B9B]  58                       pop     ax
F000:1B9C  [+0x01B9C]  83 EC 04                 sub     sp,4
F000:1B9F  [+0x01B9F]  8B EC                    mov     bp,sp
F000:1BA1  [+0x01BA1]  E8 B9 FC                 call    185Dh
F000:1BA4  [+0x01BA4]  7A 39                    jp      short 1BDFh
F000:1BA6  [+0x01BA6]  8B D9                    mov     bx,cx
F000:1BA8  [+0x01BA8]  E8 7F 02                 call    1E2Ah
F000:1BAB  [+0x01BAB]  8B F3                    mov     si,bx
F000:1BAD  [+0x01BAD]  80 E1 07                 and     cl,7
F000:1BB0  [+0x01BB0]  B3 80                    mov     bl,80h
F000:1BB2  [+0x01BB2]  D2 EB                    shr     bl,cl
F000:1BB4  [+0x01BB4]  B8 00 A0                 mov     ax,0A000h
F000:1BB7  [+0x01BB7]  8E D8                    mov     ds,ax
F000:1BB9  [+0x01BB9]  BA CE 03                 mov     dx,3CEh
F000:1BBC  [+0x01BBC]  32 C9                    xor     cl,cl
F000:1BBE  [+0x01BBE]  B8 04 03                 mov     ax,304h
F000:1BC1  [+0x01BC1]  EF                       out     dx,ax
F000:1BC2  [+0x01BC2]  8A 2C                    mov     ch,[si]
F000:1BC4  [+0x01BC4]  22 EB                    and     ch,bl
F000:1BC6  [+0x01BC6]  F6 DD                    neg     ch
F000:1BC8  [+0x01BC8]  D1 C1                    rol     cx,1
F000:1BCA  [+0x01BCA]  FE CC                    dec     ah
F000:1BCC  [+0x01BCC]  79 F3                    jns     short 1BC1h
F000:1BCE  [+0x01BCE]  8A C1                    mov     al,cl
F000:1BD0  [+0x01BD0]  E8 B8 FC                 call    188Bh
F000:1BD3  [+0x01BD3]  83 C4 04                 add     sp,4
F000:1BD6  [+0x01BD6]  5D                       pop     bp
F000:1BD7  [+0x01BD7]  B4 0D                    mov     ah,0Dh
F000:1BD9  [+0x01BD9]  5A                       pop     dx
F000:1BDA  [+0x01BDA]  59                       pop     cx
F000:1BDB  [+0x01BDB]  5B                       pop     bx
F000:1BDC  [+0x01BDC]  5E                       pop     si
F000:1BDD  [+0x01BDD]  1F                       pop     ds
F000:1BDE  [+0x01BDE]  CF                       iret
F000:1BDF  [+0x01BDF]  E8 16 02                 call    1DF8h
F000:1BE2  [+0x01BE2]  B8 00 A0                 mov     ax,0A000h
F000:1BE5  [+0x01BE5]  8E D8                    mov     ds,ax
F000:1BE7  [+0x01BE7]  8A 07                    mov     al,[bx]
F000:1BE9  [+0x01BE9]  EB E5                    jmp     short 1BD0h
F000:1BEB  [+0x01BEB]  E9 E6 24                 jmp     40D4h
F000:1BEE  [+0x01BEE]  B4 0D                    mov     ah,0Dh
F000:1BF0  [+0x01BF0]  1F                       pop     ds
F000:1BF1  [+0x01BF1]  CF                       iret
F000:1BF2  [+0x01BF2]  E8 4A 03                 call    1F3Fh
F000:1BF5  [+0x01BF5]  73 64                    jae     short 1C5Bh
F000:1BF7  [+0x01BF7]  75 5F                    jne     short 1C58h
F000:1BF9  [+0x01BF9]  53                       push    bx
F000:1BFA  [+0x01BFA]  51                       push    cx
F000:1BFB  [+0x01BFB]  52                       push    dx
F000:1BFC  [+0x01BFC]  55                       push    bp
F000:1BFD  [+0x01BFD]  8B D8                    mov     bx,ax
F000:1BFF  [+0x01BFF]  9C                       pushf
F000:1C00  [+0x01C00]  58                       pop     ax
F000:1C01  [+0x01C01]  83 EC 04                 sub     sp,4
F000:1C04  [+0x01C04]  8B EC                    mov     bp,sp
F000:1C06  [+0x01C06]  E8 54 FC                 call    185Dh
F000:1C09  [+0x01C09]  8B C3                    mov     ax,bx
F000:1C0B  [+0x01C0B]  B7 00                    mov     bh,0
F000:1C0D  [+0x01C0D]  7A 50                    jp      short 1C5Fh
F000:1C0F  [+0x01C0F]  8B D9                    mov     bx,cx
F000:1C11  [+0x01C11]  8A E8                    mov     ch,al
F000:1C13  [+0x01C13]  E8 14 02                 call    1E2Ah
F000:1C16  [+0x01C16]  BA CE 03                 mov     dx,3CEh
F000:1C19  [+0x01C19]  33 C0                    xor     ax,ax
F000:1C1B  [+0x01C1B]  EF                       out     dx,ax
F000:1C1C  [+0x01C1C]  B8 01 0F                 mov     ax,0F01h
F000:1C1F  [+0x01C1F]  EF                       out     dx,ax
F000:1C20  [+0x01C20]  80 E1 07                 and     cl,7
F000:1C23  [+0x01C23]  B8 08 80                 mov     ax,8008h
F000:1C26  [+0x01C26]  D2 EC                    shr     ah,cl
F000:1C28  [+0x01C28]  EF                       out     dx,ax
F000:1C29  [+0x01C29]  B8 00 A0                 mov     ax,0A000h
F000:1C2C  [+0x01C2C]  8E D8                    mov     ds,ax
F000:1C2E  [+0x01C2E]  0A ED                    or      ch,ch
F000:1C30  [+0x01C30]  78 15                    js      short 1C47h
F000:1C32  [+0x01C32]  08 07                    or      [bx],al
F000:1C34  [+0x01C34]  8A E5                    mov     ah,ch
F000:1C36  [+0x01C36]  EF                       out     dx,ax
F000:1C37  [+0x01C37]  08 07                    or      [bx],al
F000:1C39  [+0x01C39]  B8 08 FF                 mov     ax,0FF08h
F000:1C3C  [+0x01C3C]  EF                       out     dx,ax
F000:1C3D  [+0x01C3D]  33 C0                    xor     ax,ax
F000:1C3F  [+0x01C3F]  EF                       out     dx,ax
F000:1C40  [+0x01C40]  FE C0                    inc     al
F000:1C42  [+0x01C42]  EF                       out     dx,ax
F000:1C43  [+0x01C43]  8A C5                    mov     al,ch
F000:1C45  [+0x01C45]  EB 24                    jmp     short 1C6Bh
F000:1C47  [+0x01C47]  B8 03 18                 mov     ax,1803h
F000:1C4A  [+0x01C4A]  EF                       out     dx,ax
F000:1C4B  [+0x01C4B]  8A E5                    mov     ah,ch
F000:1C4D  [+0x01C4D]  32 C0                    xor     al,al
F000:1C4F  [+0x01C4F]  EF                       out     dx,ax
F000:1C50  [+0x01C50]  08 07                    or      [bx],al
F000:1C52  [+0x01C52]  B8 03 00                 mov     ax,3
F000:1C55  [+0x01C55]  EF                       out     dx,ax
F000:1C56  [+0x01C56]  EB E1                    jmp     short 1C39h
F000:1C58  [+0x01C58]  E9 AD 23                 jmp     4008h
F000:1C5B  [+0x01C5B]  B4 0C                    mov     ah,0Ch
F000:1C5D  [+0x01C5D]  1F                       pop     ds
F000:1C5E  [+0x01C5E]  CF                       iret
F000:1C5F  [+0x01C5F]  50                       push    ax
F000:1C60  [+0x01C60]  E8 95 01                 call    1DF8h
F000:1C63  [+0x01C63]  B8 00 A0                 mov     ax,0A000h
F000:1C66  [+0x01C66]  8E D8                    mov     ds,ax
F000:1C68  [+0x01C68]  58                       pop     ax
F000:1C69  [+0x01C69]  88 07                    mov     [bx],al
F000:1C6B  [+0x01C6B]  E8 1D FC                 call    188Bh
F000:1C6E  [+0x01C6E]  83 C4 04                 add     sp,4
F000:1C71  [+0x01C71]  5D                       pop     bp
F000:1C72  [+0x01C72]  B4 0C                    mov     ah,0Ch
F000:1C74  [+0x01C74]  5A                       pop     dx
F000:1C75  [+0x01C75]  59                       pop     cx
F000:1C76  [+0x01C76]  5B                       pop     bx
F000:1C77  [+0x01C77]  1F                       pop     ds
F000:1C78  [+0x01C78]  CF                       iret
F000:1C79  [+0x01C79]  E8 C3 02                 call    1F3Fh
F000:1C7C  [+0x01C7C]  72 12                    jb      short 1C90h
F000:1C7E  [+0x01C7E]  B4 03                    mov     ah,3
F000:1C80  [+0x01C80]  E9 EB 1F                 jmp     3C6Eh
F000:1C83  [+0x01C83]  E8 B9 02                 call    1F3Fh
F000:1C86  [+0x01C86]  72 08                    jb      short 1C90h
F000:1C88  [+0x01C88]  B4 03                    mov     ah,3
F000:1C8A  [+0x01C8A]  E9 5D 1F                 jmp     3BEAh
F000:1C8D  [+0x01C8D]  E9 F1 20                 jmp     3D81h
F000:1C90  [+0x01C90]  75 FB                    jne     short 1C8Dh
F000:1C92  [+0x01C92]  55                       push    bp
F000:1C93  [+0x01C93]  8A F8                    mov     bh,al
F000:1C95  [+0x01C95]  9C                       pushf
F000:1C96  [+0x01C96]  58                       pop     ax
F000:1C97  [+0x01C97]  83 EC 04                 sub     sp,4
F000:1C9A  [+0x01C9A]  8B EC                    mov     bp,sp
F000:1C9C  [+0x01C9C]  E8 BE FB                 call    185Dh
F000:1C9F  [+0x01C9F]  8A C7                    mov     al,bh
F000:1CA1  [+0x01CA1]  B7 00                    mov     bh,0
F000:1CA3  [+0x01CA3]  7A 26                    jp      short 1CCBh
F000:1CA5  [+0x01CA5]  32 E4                    xor     ah,ah
F000:1CA7  [+0x01CA7]  80 CC BA                 or      ah,0BAh
F000:1CAA  [+0x01CAA]  BE C1 1C                 mov     si,1CC1h
F000:1CAD  [+0x01CAD]  56                       push    si
F000:1CAE  [+0x01CAE]  50                       push    ax
F000:1CAF  [+0x01CAF]  8B E9                    mov     bp,cx
F000:1CB1  [+0x01CB1]  8A D3                    mov     dl,bl
F000:1CB3  [+0x01CB3]  33 C9                    xor     cx,cx
F000:1CB5  [+0x01CB5]  E8 2B 01                 call    1DE3h
F000:1CB8  [+0x01CB8]  E8 A9 01                 call    1E64h
F000:1CBB  [+0x01CBB]  8B FE                    mov     di,si
F000:1CBD  [+0x01CBD]  5E                       pop     si
F000:1CBE  [+0x01CBE]  E9 F2 20                 jmp     3DB3h
F000:1CC1  [+0x01CC1]  8B EC                    mov     bp,sp
F000:1CC3  [+0x01CC3]  E8 C5 FB                 call    188Bh
F000:1CC6  [+0x01CC6]  83 C4 04                 add     sp,4
F000:1CC9  [+0x01CC9]  5D                       pop     bp
F000:1CCA  [+0x01CCA]  C3                       ret
F000:1CCB  [+0x01CCB]  83 EC 04                 sub     sp,4
F000:1CCE  [+0x01CCE]  8B EC                    mov     bp,sp
F000:1CD0  [+0x01CD0]  89 4E 00                 mov     [bp],cx
F000:1CD3  [+0x01CD3]  51                       push    cx
F000:1CD4  [+0x01CD4]  52                       push    dx
F000:1CD5  [+0x01CD5]  56                       push    si
F000:1CD6  [+0x01CD6]  57                       push    di
F000:1CD7  [+0x01CD7]  1E                       push    ds
F000:1CD8  [+0x01CD8]  50                       push    ax
F000:1CD9  [+0x01CD9]  B8 00 A0                 mov     ax,0A000h
F000:1CDC  [+0x01CDC]  8E C0                    mov     es,ax
F000:1CDE  [+0x01CDE]  B9 03 00                 mov     cx,3
F000:1CE1  [+0x01CE1]  A1 50 04                 mov     ax,[450h]
F000:1CE4  [+0x01CE4]  53                       push    bx
F000:1CE5  [+0x01CE5]  E8 A6 00                 call    1D8Eh
F000:1CE8  [+0x01CE8]  E8 79 01                 call    1E64h
F000:1CEB  [+0x01CEB]  8B FE                    mov     di,si
F000:1CED  [+0x01CED]  5B                       pop     bx
F000:1CEE  [+0x01CEE]  A1 4A 04                 mov     ax,[44Ah]
F000:1CF1  [+0x01CF1]  48                       dec     ax
F000:1CF2  [+0x01CF2]  D3 E0                    shl     ax,cl
F000:1CF4  [+0x01CF4]  89 46 02                 mov     [bp+2],ax
F000:1CF7  [+0x01CF7]  A1 85 04                 mov     ax,[485h]
F000:1CFA  [+0x01CFA]  8B D0                    mov     dx,ax
F000:1CFC  [+0x01CFC]  59                       pop     cx
F000:1CFD  [+0x01CFD]  F6 E1                    mul     cl
F000:1CFF  [+0x01CFF]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:1D04  [+0x01D04]  C5 36 0C 01              lds     si,[10Ch]
F000:1D08  [+0x01D08]  03 F0                    add     si,ax
F000:1D0A  [+0x01D0A]  56                       push    si
F000:1D0B  [+0x01D0B]  57                       push    di
F000:1D0C  [+0x01D0C]  52                       push    dx
F000:1D0D  [+0x01D0D]  B9 08 00                 mov     cx,8
F000:1D10  [+0x01D10]  8A 24                    mov     ah,[si]
F000:1D12  [+0x01D12]  46                       inc     si
F000:1D13  [+0x01D13]  D0 D4                    rcl     ah,1
F000:1D15  [+0x01D15]  8A C3                    mov     al,bl
F000:1D17  [+0x01D17]  72 02                    jb      short 1D1Bh
F000:1D19  [+0x01D19]  8A C7                    mov     al,bh
F000:1D1B  [+0x01D1B]  AA                       stosb
F000:1D1C  [+0x01D1C]  E2 F5                    loop    1D13h
F000:1D1E  [+0x01D1E]  03 7E 02                 add     di,[bp+2]
F000:1D21  [+0x01D21]  4A                       dec     dx
F000:1D22  [+0x01D22]  75 E9                    jne     short 1D0Dh
F000:1D24  [+0x01D24]  5A                       pop     dx
F000:1D25  [+0x01D25]  5F                       pop     di
F000:1D26  [+0x01D26]  5E                       pop     si
F000:1D27  [+0x01D27]  83 C7 08                 add     di,8
F000:1D2A  [+0x01D2A]  FF 4E 00                 dec     word [bp]
F000:1D2D  [+0x01D2D]  75 DB                    jne     short 1D0Ah
F000:1D2F  [+0x01D2F]  1F                       pop     ds
F000:1D30  [+0x01D30]  5F                       pop     di
F000:1D31  [+0x01D31]  5E                       pop     si
F000:1D32  [+0x01D32]  5A                       pop     dx
F000:1D33  [+0x01D33]  59                       pop     cx
F000:1D34  [+0x01D34]  B4 0D                    mov     ah,0Dh
F000:1D36  [+0x01D36]  83 C4 04                 add     sp,4
F000:1D39  [+0x01D39]  8B EC                    mov     bp,sp
F000:1D3B  [+0x01D3B]  E8 4D FB                 call    188Bh
F000:1D3E  [+0x01D3E]  83 C4 04                 add     sp,4
F000:1D41  [+0x01D41]  5D                       pop     bp
F000:1D42  [+0x01D42]  C3                       ret
F000:1D43  [+0x01D43]  E8 F9 01                 call    1F3Fh
F000:1D46  [+0x01D46]  72 08                    jb      short 1D50h
F000:1D48  [+0x01D48]  B4 03                    mov     ah,3
F000:1D4A  [+0x01D4A]  E9 15 1C                 jmp     3962h
F000:1D4D  [+0x01D4D]  E9 0E 1C                 jmp     395Eh
F000:1D50  [+0x01D50]  75 FB                    jne     short 1D4Dh
F000:1D52  [+0x01D52]  55                       push    bp
F000:1D53  [+0x01D53]  9C                       pushf
F000:1D54  [+0x01D54]  58                       pop     ax
F000:1D55  [+0x01D55]  83 EC 04                 sub     sp,4
F000:1D58  [+0x01D58]  8B EC                    mov     bp,sp
F000:1D5A  [+0x01D5A]  E8 00 FB                 call    185Dh
F000:1D5D  [+0x01D5D]  BE 84 1D                 mov     si,1D84h
F000:1D60  [+0x01D60]  56                       push    si
F000:1D61  [+0x01D61]  7A 0B                    jp      short 1D6Eh
F000:1D63  [+0x01D63]  33 C9                    xor     cx,cx
F000:1D65  [+0x01D65]  E8 7B 00                 call    1DE3h
F000:1D68  [+0x01D68]  E8 F9 00                 call    1E64h
F000:1D6B  [+0x01D6B]  E9 15 1D                 jmp     3A83h
F000:1D6E  [+0x01D6E]  B8 00 A0                 mov     ax,0A000h
F000:1D71  [+0x01D71]  8E C0                    mov     es,ax
F000:1D73  [+0x01D73]  A1 50 04                 mov     ax,[450h]
F000:1D76  [+0x01D76]  B9 03 00                 mov     cx,3
F000:1D79  [+0x01D79]  E8 12 00                 call    1D8Eh
F000:1D7C  [+0x01D7C]  E8 E5 00                 call    1E64h
F000:1D7F  [+0x01D7F]  8B FE                    mov     di,si
F000:1D81  [+0x01D81]  E9 79 1D                 jmp     3AFDh
F000:1D84  [+0x01D84]  8B EC                    mov     bp,sp
F000:1D86  [+0x01D86]  E8 02 FB                 call    188Bh
F000:1D89  [+0x01D89]  83 C4 04                 add     sp,4
F000:1D8C  [+0x01D8C]  5D                       pop     bp
F000:1D8D  [+0x01D8D]  C3                       ret
F000:1D8E  [+0x01D8E]  50                       push    ax
F000:1D8F  [+0x01D8F]  52                       push    dx
F000:1D90  [+0x01D90]  8B F0                    mov     si,ax
F000:1D92  [+0x01D92]  81 E6 FF 00              and     si,0FFh
F000:1D96  [+0x01D96]  8A C4                    mov     al,ah
F000:1D98  [+0x01D98]  F6 26 4A 04              mul     byte [44Ah]
F000:1D9C  [+0x01D9C]  F7 26 85 04              mul     word [485h]
F000:1DA0  [+0x01DA0]  03 F0                    add     si,ax
F000:1DA2  [+0x01DA2]  80 D2 00                 adc     dl,0
F000:1DA5  [+0x01DA5]  E3 15                    jcxz    1DBCh
F000:1DA7  [+0x01DA7]  D1 E6                    shl     si,1
F000:1DA9  [+0x01DA9]  D0 D2                    rcl     dl,1
F000:1DAB  [+0x01DAB]  D1 E6                    shl     si,1
F000:1DAD  [+0x01DAD]  D0 D2                    rcl     dl,1
F000:1DAF  [+0x01DAF]  D1 E6                    shl     si,1
F000:1DB1  [+0x01DB1]  D0 D2                    rcl     dl,1
F000:1DB3  [+0x01DB3]  80 F9 04                 cmp     cl,4
F000:1DB6  [+0x01DB6]  75 04                    jne     short 1DBCh
F000:1DB8  [+0x01DB8]  D1 E6                    shl     si,1
F000:1DBA  [+0x01DBA]  D0 D2                    rcl     dl,1
F000:1DBC  [+0x01DBC]  D0 E2                    shl     dl,1
F000:1DBE  [+0x01DBE]  D0 E2                    shl     dl,1
F000:1DC0  [+0x01DC0]  D0 E2                    shl     dl,1
F000:1DC2  [+0x01DC2]  D0 E2                    shl     dl,1
F000:1DC4  [+0x01DC4]  8B C6                    mov     ax,si
F000:1DC6  [+0x01DC6]  D1 C0                    rol     ax,1
F000:1DC8  [+0x01DC8]  D1 C0                    rol     ax,1
F000:1DCA  [+0x01DCA]  D1 C0                    rol     ax,1
F000:1DCC  [+0x01DCC]  D1 C0                    rol     ax,1
F000:1DCE  [+0x01DCE]  24 0F                    and     al,0Fh
F000:1DD0  [+0x01DD0]  02 D0                    add     dl,al
F000:1DD2  [+0x01DD2]  81 E6 FF 0F              and     si,0FFFh
F000:1DD6  [+0x01DD6]  0A C9                    or      cl,cl
F000:1DD8  [+0x01DD8]  75 04                    jne     short 1DDEh
F000:1DDA  [+0x01DDA]  D0 E2                    shl     dl,1
F000:1DDC  [+0x01DDC]  D0 E2                    shl     dl,1
F000:1DDE  [+0x01DDE]  8A DA                    mov     bl,dl
F000:1DE0  [+0x01DE0]  5A                       pop     dx
F000:1DE1  [+0x01DE1]  58                       pop     ax
F000:1DE2  [+0x01DE2]  C3                       ret
F000:1DE3  [+0x01DE3]  B8 00 A0                 mov     ax,0A000h
F000:1DE6  [+0x01DE6]  8E C0                    mov     es,ax
F000:1DE8  [+0x01DE8]  8A C7                    mov     al,bh
F000:1DEA  [+0x01DEA]  32 E4                    xor     ah,ah
F000:1DEC  [+0x01DEC]  D1 E0                    shl     ax,1
F000:1DEE  [+0x01DEE]  8B F0                    mov     si,ax
F000:1DF0  [+0x01DF0]  8B 84 50 04              mov     ax,[si+450h]
F000:1DF4  [+0x01DF4]  E8 97 FF                 call    1D8Eh
F000:1DF7  [+0x01DF7]  C3                       ret
F000:1DF8  [+0x01DF8]  A1 4A 04                 mov     ax,[44Ah]
F000:1DFB  [+0x01DFB]  D1 E0                    shl     ax,1
F000:1DFD  [+0x01DFD]  D1 E0                    shl     ax,1
F000:1DFF  [+0x01DFF]  D1 E0                    shl     ax,1
F000:1E01  [+0x01E01]  F7 E2                    mul     dx
F000:1E03  [+0x01E03]  03 C1                    add     ax,cx
F000:1E05  [+0x01E05]  83 D2 00                 adc     dx,0
F000:1E08  [+0x01E08]  D0 E2                    shl     dl,1
F000:1E0A  [+0x01E0A]  D0 E2                    shl     dl,1
F000:1E0C  [+0x01E0C]  D0 E2                    shl     dl,1
F000:1E0E  [+0x01E0E]  D0 E2                    shl     dl,1
F000:1E10  [+0x01E10]  8B D8                    mov     bx,ax
F000:1E12  [+0x01E12]  D1 C0                    rol     ax,1
F000:1E14  [+0x01E14]  D1 C0                    rol     ax,1
F000:1E16  [+0x01E16]  D1 C0                    rol     ax,1
F000:1E18  [+0x01E18]  D1 C0                    rol     ax,1
F000:1E1A  [+0x01E1A]  24 0F                    and     al,0Fh
F000:1E1C  [+0x01E1C]  02 D0                    add     dl,al
F000:1E1E  [+0x01E1E]  81 E3 FF 0F              and     bx,0FFFh
F000:1E22  [+0x01E22]  86 DA                    xchg    bl,dl
F000:1E24  [+0x01E24]  E8 3D 00                 call    1E64h
F000:1E27  [+0x01E27]  86 DA                    xchg    bl,dl
F000:1E29  [+0x01E29]  C3                       ret
F000:1E2A  [+0x01E2A]  D1 EB                    shr     bx,1
F000:1E2C  [+0x01E2C]  D1 EB                    shr     bx,1
F000:1E2E  [+0x01E2E]  D1 EB                    shr     bx,1
F000:1E30  [+0x01E30]  8B C2                    mov     ax,dx
F000:1E32  [+0x01E32]  8B 16 4A 04              mov     dx,[44Ah]
F000:1E36  [+0x01E36]  F7 E2                    mul     dx
F000:1E38  [+0x01E38]  03 D8                    add     bx,ax
F000:1E3A  [+0x01E3A]  80 D2 00                 adc     dl,0
F000:1E3D  [+0x01E3D]  8B C3                    mov     ax,bx
F000:1E3F  [+0x01E3F]  D1 E3                    shl     bx,1
F000:1E41  [+0x01E41]  D0 D2                    rcl     dl,1
F000:1E43  [+0x01E43]  D1 E3                    shl     bx,1
F000:1E45  [+0x01E45]  D0 D2                    rcl     dl,1
F000:1E47  [+0x01E47]  D1 E3                    shl     bx,1
F000:1E49  [+0x01E49]  D0 D2                    rcl     dl,1
F000:1E4B  [+0x01E4B]  D1 E3                    shl     bx,1
F000:1E4D  [+0x01E4D]  D0 D2                    rcl     dl,1
F000:1E4F  [+0x01E4F]  D1 E3                    shl     bx,1
F000:1E51  [+0x01E51]  D0 D2                    rcl     dl,1
F000:1E53  [+0x01E53]  D1 E3                    shl     bx,1
F000:1E55  [+0x01E55]  D0 D2                    rcl     dl,1
F000:1E57  [+0x01E57]  25 FF 03                 and     ax,3FFh
F000:1E5A  [+0x01E5A]  8B D8                    mov     bx,ax
F000:1E5C  [+0x01E5C]  86 DA                    xchg    bl,dl
F000:1E5E  [+0x01E5E]  E8 03 00                 call    1E64h
F000:1E61  [+0x01E61]  86 DA                    xchg    bl,dl
F000:1E63  [+0x01E63]  C3                       ret
F000:1E64  [+0x01E64]  50                       push    ax
F000:1E65  [+0x01E65]  52                       push    dx
F000:1E66  [+0x01E66]  BA D6 03                 mov     dx,3D6h
F000:1E69  [+0x01E69]  8A E3                    mov     ah,bl
F000:1E6B  [+0x01E6B]  B0 10                    mov     al,10h
F000:1E6D  [+0x01E6D]  EF                       out     dx,ax
F000:1E6E  [+0x01E6E]  5A                       pop     dx
F000:1E6F  [+0x01E6F]  58                       pop     ax
F000:1E70  [+0x01E70]  C3                       ret
F000:1E71  [+0x01E71]  50                       push    ax
F000:1E72  [+0x01E72]  52                       push    dx
F000:1E73  [+0x01E73]  BA D6 03                 mov     dx,3D6h
F000:1E76  [+0x01E76]  B0 10                    mov     al,10h
F000:1E78  [+0x01E78]  8A E3                    mov     ah,bl
F000:1E7A  [+0x01E7A]  EF                       out     dx,ax
F000:1E7B  [+0x01E7B]  EB 00                    jmp     short 1E7Dh
F000:1E7D  [+0x01E7D]  B0 11                    mov     al,11h
F000:1E7F  [+0x01E7F]  8A E7                    mov     ah,bh
F000:1E81  [+0x01E81]  EF                       out     dx,ax
F000:1E82  [+0x01E82]  5A                       pop     dx
F000:1E83  [+0x01E83]  58                       pop     ax
F000:1E84  [+0x01E84]  C3                       ret
F000:1E85  [+0x01E85]  50                       push    ax
F000:1E86  [+0x01E86]  52                       push    dx
F000:1E87  [+0x01E87]  B0 0B                    mov     al,0Bh
F000:1E89  [+0x01E89]  E8 A0 01                 call    202Ch
F000:1E8C  [+0x01E8C]  8B C8                    mov     cx,ax
F000:1E8E  [+0x01E8E]  80 E4 EF                 and     ah,0EFh
F000:1E91  [+0x01E91]  EF                       out     dx,ax
F000:1E92  [+0x01E92]  5A                       pop     dx
F000:1E93  [+0x01E93]  58                       pop     ax
F000:1E94  [+0x01E94]  51                       push    cx
F000:1E95  [+0x01E95]  55                       push    bp
F000:1E96  [+0x01E96]  83 EC 04                 sub     sp,4
F000:1E99  [+0x01E99]  8B EC                    mov     bp,sp
F000:1E9B  [+0x01E9B]  E8 BF F9                 call    185Dh
F000:1E9E  [+0x01E9E]  33 C9                    xor     cx,cx
F000:1EA0  [+0x01EA0]  B2 40                    mov     dl,40h
F000:1EA2  [+0x01EA2]  F6 C3 04                 test    bl,4
F000:1EA5  [+0x01EA5]  74 0C                    je      short 1EB3h
F000:1EA7  [+0x01EA7]  B1 03                    mov     cl,3
F000:1EA9  [+0x01EA9]  E8 65 05                 call    2411h
F000:1EAC  [+0x01EAC]  75 03                    jne     short 1EB1h
F000:1EAE  [+0x01EAE]  B9 04 00                 mov     cx,4
F000:1EB1  [+0x01EB1]  B2 10                    mov     dl,10h
F000:1EB3  [+0x01EB3]  8A 26 84 04              mov     ah,[484h]
F000:1EB7  [+0x01EB7]  80 3E 49 04 30           cmp     byte [449h],30h
F000:1EBC  [+0x01EBC]  73 09                    jae     short 1EC7h
F000:1EBE  [+0x01EBE]  80 3E 49 04 20           cmp     byte [449h],20h
F000:1EC3  [+0x01EC3]  72 02                    jb      short 1EC7h
F000:1EC5  [+0x01EC5]  D0 EC                    shr     ah,1
F000:1EC7  [+0x01EC7]  80 3E 49 04 50           cmp     byte [449h],50h
F000:1ECC  [+0x01ECC]  75 02                    jne     short 1ED0h
F000:1ECE  [+0x01ECE]  B4 2C                    mov     ah,2Ch
F000:1ED0  [+0x01ED0]  80 C4 01                 add     ah,1
F000:1ED3  [+0x01ED3]  32 C0                    xor     al,al
F000:1ED5  [+0x01ED5]  E8 B6 FE                 call    1D8Eh
F000:1ED8  [+0x01ED8]  80 3E 49 04 7C           cmp     byte [449h],7Ch
F000:1EDD  [+0x01EDD]  74 07                    je      short 1EE6h
F000:1EDF  [+0x01EDF]  80 3E 49 04 32           cmp     byte [449h],32h
F000:1EE4  [+0x01EE4]  75 04                    jne     short 1EEAh
F000:1EE6  [+0x01EE6]  81 C6 00 19              add     si,1900h
F000:1EEA  [+0x01EEA]  56                       push    si
F000:1EEB  [+0x01EEB]  8A FB                    mov     bh,bl
F000:1EED  [+0x01EED]  32 DB                    xor     bl,bl
F000:1EEF  [+0x01EEF]  B8 00 A0                 mov     ax,0A000h
F000:1EF2  [+0x01EF2]  8E C0                    mov     es,ax
F000:1EF4  [+0x01EF4]  33 C0                    xor     ax,ax
F000:1EF6  [+0x01EF6]  8B F8                    mov     di,ax
F000:1EF8  [+0x01EF8]  E8 69 FF                 call    1E64h
F000:1EFB  [+0x01EFB]  3A FA                    cmp     bh,dl
F000:1EFD  [+0x01EFD]  72 0B                    jb      short 1F0Ah
F000:1EFF  [+0x01EFF]  B9 00 80                 mov     cx,8000h
F000:1F02  [+0x01F02]  F3 AB                    rep stosw
F000:1F04  [+0x01F04]  02 DA                    add     bl,dl
F000:1F06  [+0x01F06]  2A FA                    sub     bh,dl
F000:1F08  [+0x01F08]  EB EE                    jmp     short 1EF8h
F000:1F0A  [+0x01F0A]  59                       pop     cx
F000:1F0B  [+0x01F0B]  D0 CF                    ror     bh,1
F000:1F0D  [+0x01F0D]  D0 CF                    ror     bh,1
F000:1F0F  [+0x01F0F]  D0 CF                    ror     bh,1
F000:1F11  [+0x01F11]  D0 CF                    ror     bh,1
F000:1F13  [+0x01F13]  80 FA 10                 cmp     dl,10h
F000:1F16  [+0x01F16]  74 04                    je      short 1F1Ch
F000:1F18  [+0x01F18]  D0 CF                    ror     bh,1
F000:1F1A  [+0x01F1A]  D0 CF                    ror     bh,1
F000:1F1C  [+0x01F1C]  32 DB                    xor     bl,bl
F000:1F1E  [+0x01F1E]  03 CB                    add     cx,bx
F000:1F20  [+0x01F20]  E3 08                    jcxz    1F2Ah
F000:1F22  [+0x01F22]  D1 D9                    rcr     cx,1
F000:1F24  [+0x01F24]  F3 AB                    rep stosw
F000:1F26  [+0x01F26]  D1 D1                    rcl     cx,1
F000:1F28  [+0x01F28]  F3 AA                    rep stosb
F000:1F2A  [+0x01F2A]  32 C0                    xor     al,al
F000:1F2C  [+0x01F2C]  88 46 02                 mov     [bp+2],al
F000:1F2F  [+0x01F2F]  88 46 03                 mov     [bp+3],al
F000:1F32  [+0x01F32]  E8 56 F9                 call    188Bh
F000:1F35  [+0x01F35]  83 C4 04                 add     sp,4
F000:1F38  [+0x01F38]  5D                       pop     bp
F000:1F39  [+0x01F39]  58                       pop     ax
F000:1F3A  [+0x01F3A]  BA D6 03                 mov     dx,3D6h
F000:1F3D  [+0x01F3D]  EF                       out     dx,ax
F000:1F3E  [+0x01F3E]  C3                       ret
F000:1F3F  [+0x01F3F]  53                       push    bx
F000:1F40  [+0x01F40]  9C                       pushf
F000:1F41  [+0x01F41]  5B                       pop     bx
F000:1F42  [+0x01F42]  32 DB                    xor     bl,bl
F000:1F44  [+0x01F44]  80 FC 13                 cmp     ah,13h
F000:1F47  [+0x01F47]  76 22                    jbe     short 1F6Bh
F000:1F49  [+0x01F49]  80 FC 5F                 cmp     ah,5Fh
F000:1F4C  [+0x01F4C]  77 05                    ja      short 1F53h
F000:1F4E  [+0x01F4E]  80 CB 45                 or      bl,45h
F000:1F51  [+0x01F51]  EB 18                    jmp     short 1F6Bh
F000:1F53  [+0x01F53]  80 FC 65                 cmp     ah,65h
F000:1F56  [+0x01F56]  76 13                    jbe     short 1F6Bh
F000:1F58  [+0x01F58]  80 CB 01                 or      bl,1
F000:1F5B  [+0x01F5B]  80 FC 71                 cmp     ah,71h
F000:1F5E  [+0x01F5E]  72 0B                    jb      short 1F6Bh
F000:1F60  [+0x01F60]  80 CB 40                 or      bl,40h
F000:1F63  [+0x01F63]  80 FC 78                 cmp     ah,78h
F000:1F66  [+0x01F66]  72 03                    jb      short 1F6Bh
F000:1F68  [+0x01F68]  80 CB 04                 or      bl,4
F000:1F6B  [+0x01F6B]  53                       push    bx
F000:1F6C  [+0x01F6C]  9D                       popf
F000:1F6D  [+0x01F6D]  5B                       pop     bx
F000:1F6E  [+0x01F6E]  C3                       ret
F000:1F6F  [+0x01F6F]  50                       push    ax
F000:1F70  [+0x01F70]  B5 01                    mov     ch,1
F000:1F72  [+0x01F72]  B0 28                    mov     al,28h
F000:1F74  [+0x01F74]  E8 B5 00                 call    202Ch
F000:1F77  [+0x01F77]  80 E4 DF                 and     ah,0DFh
F000:1F7A  [+0x01F7A]  8A FC                    mov     bh,ah
F000:1F7C  [+0x01F7C]  58                       pop     ax
F000:1F7D  [+0x01F7D]  C3                       ret
F000:1F7E  [+0x01F7E]  50                       push    ax
F000:1F7F  [+0x01F7F]  52                       push    dx
F000:1F80  [+0x01F80]  BA D6 03                 mov     dx,3D6h
F000:1F83  [+0x01F83]  80 E7 EF                 and     bh,0EFh
F000:1F86  [+0x01F86]  3C 30                    cmp     al,30h
F000:1F88  [+0x01F88]  72 0B                    jb      short 1F95h
F000:1F8A  [+0x01F8A]  3C 60                    cmp     al,60h
F000:1F8C  [+0x01F8C]  72 04                    jb      short 1F92h
F000:1F8E  [+0x01F8E]  3C 77                    cmp     al,77h
F000:1F90  [+0x01F90]  76 03                    jbe     short 1F95h
F000:1F92  [+0x01F92]  80 CF 10                 or      bh,10h
F000:1F95  [+0x01F95]  B0 28                    mov     al,28h
F000:1F97  [+0x01F97]  8A E7                    mov     ah,bh
F000:1F99  [+0x01F99]  EF                       out     dx,ax
F000:1F9A  [+0x01F9A]  E8 A9 EC                 call    0C46h
F000:1F9D  [+0x01F9D]  75 05                    jne     short 1FA4h
F000:1F9F  [+0x01F9F]  B0 19                    mov     al,19h
F000:1FA1  [+0x01FA1]  8A E5                    mov     ah,ch
F000:1FA3  [+0x01FA3]  EF                       out     dx,ax
F000:1FA4  [+0x01FA4]  5A                       pop     dx
F000:1FA5  [+0x01FA5]  58                       pop     ax
F000:1FA6  [+0x01FA6]  C3                       ret
F000:1FA7  [+0x01FA7]  73 05                    jae     short 1FAEh
F000:1FA9  [+0x01FA9]  B5 4C                    mov     ch,4Ch
F000:1FAB  [+0x01FAB]  80 CF 20                 or      bh,20h
F000:1FAE  [+0x01FAE]  C3                       ret
F000:1FAF  [+0x01FAF]  50                       push    ax
F000:1FB0  [+0x01FB0]  52                       push    dx
F000:1FB1  [+0x01FB1]  E8 0F 00                 call    1FC3h
F000:1FB4  [+0x01FB4]  74 04                    je      short 1FBAh
F000:1FB6  [+0x01FB6]  32 E4                    xor     ah,ah
F000:1FB8  [+0x01FB8]  EB 06                    jmp     short 1FC0h
F000:1FBA  [+0x01FBA]  83 C7 04                 add     di,4
F000:1FBD  [+0x01FBD]  32 E4                    xor     ah,ah
F000:1FBF  [+0x01FBF]  F9                       stc
F000:1FC0  [+0x01FC0]  5A                       pop     dx
F000:1FC1  [+0x01FC1]  58                       pop     ax
F000:1FC2  [+0x01FC2]  C3                       ret
F000:1FC3  [+0x01FC3]  50                       push    ax
F000:1FC4  [+0x01FC4]  E8 6C 00                 call    2033h
F000:1FC7  [+0x01FC7]  8A C4                    mov     al,ah
F000:1FC9  [+0x01FC9]  D0 E8                    shr     al,1
F000:1FCB  [+0x01FCB]  A8 20                    test    al,20h
F000:1FCD  [+0x01FCD]  58                       pop     ax
F000:1FCE  [+0x01FCE]  75 07                    jne     short 1FD7h
F000:1FD0  [+0x01FD0]  24 7F                    and     al,7Fh
F000:1FD2  [+0x01FD2]  E8 0C 00                 call    1FE1h
F000:1FD5  [+0x01FD5]  74 03                    je      short 1FDAh
F000:1FD7  [+0x01FD7]  F8                       clc
F000:1FD8  [+0x01FD8]  EB 06                    jmp     short 1FE0h
F000:1FDA  [+0x01FDA]  E8 69 EC                 call    0C46h
F000:1FDD  [+0x01FDD]  75 F8                    jne     short 1FD7h
F000:1FDF  [+0x01FDF]  F9                       stc
F000:1FE0  [+0x01FE0]  C3                       ret
F000:1FE1  [+0x01FE1]  3C 24                    cmp     al,24h
F000:1FE3  [+0x01FE3]  74 12                    je      short 1FF7h
F000:1FE5  [+0x01FE5]  3C 34                    cmp     al,34h
F000:1FE7  [+0x01FE7]  74 0E                    je      short 1FF7h
F000:1FE9  [+0x01FE9]  3C 72                    cmp     al,72h
F000:1FEB  [+0x01FEB]  74 0A                    je      short 1FF7h
F000:1FED  [+0x01FED]  3C 75                    cmp     al,75h
F000:1FEF  [+0x01FEF]  74 06                    je      short 1FF7h
F000:1FF1  [+0x01FF1]  3C 74                    cmp     al,74h
F000:1FF3  [+0x01FF3]  74 02                    je      short 1FF7h
F000:1FF5  [+0x01FF5]  3C 7E                    cmp     al,7Eh
F000:1FF7  [+0x01FF7]  C3                       ret
F000:1FF8  [+0x01FF8]  51                       push    cx
F000:1FF9  [+0x01FF9]  53                       push    bx
F000:1FFA  [+0x01FFA]  32 C9                    xor     cl,cl
F000:1FFC  [+0x01FFC]  0A DB                    or      bl,bl
F000:1FFE  [+0x01FFE]  74 09                    je      short 2009h
F000:2000  [+0x02000]  B1 06                    mov     cl,6
F000:2002  [+0x02002]  F6 C3 01                 test    bl,1
F000:2005  [+0x02005]  75 02                    jne     short 2009h
F000:2007  [+0x02007]  B1 04                    mov     cl,4
F000:2009  [+0x02009]  8A D9                    mov     bl,cl
F000:200B  [+0x0200B]  B0 06                    mov     al,6
F000:200D  [+0x0200D]  E8 1C 00                 call    202Ch
F000:2010  [+0x02010]  80 E4 FD                 and     ah,0FDh
F000:2013  [+0x02013]  80 E1 02                 and     cl,2
F000:2016  [+0x02016]  0A E1                    or      ah,cl
F000:2018  [+0x02018]  EF                       out     dx,ax
F000:2019  [+0x02019]  8A CB                    mov     cl,bl
F000:201B  [+0x0201B]  B0 51                    mov     al,51h
F000:201D  [+0x0201D]  E8 7E 30                 call    509Eh
F000:2020  [+0x02020]  80 E4 FB                 and     ah,0FBh
F000:2023  [+0x02023]  80 E1 04                 and     cl,4
F000:2026  [+0x02026]  0A E1                    or      ah,cl
F000:2028  [+0x02028]  EF                       out     dx,ax
F000:2029  [+0x02029]  5B                       pop     bx
F000:202A  [+0x0202A]  59                       pop     cx
F000:202B  [+0x0202B]  C3                       ret
F000:202C  [+0x0202C]  BA D6 03                 mov     dx,3D6h
F000:202F  [+0x0202F]  E8 6C 30                 call    509Eh
F000:2032  [+0x02032]  C3                       ret
F000:2033  [+0x02033]  BA D6 03                 mov     dx,3D6h
F000:2036  [+0x02036]  B0 0F                    mov     al,0Fh
F000:2038  [+0x02038]  E8 63 30                 call    509Eh
F000:203B  [+0x0203B]  C3                       ret
F000:203C  [+0x0203C]  DB 0xC6  (bad)
F000:203E  [+0x0203E]  C3                       ret
F000:203F  [+0x0203F]  20 F2                    and     dl,dh
F000:2041  [+0x02041]  20 51 0D                 and     [bx+di+0Dh],dl
F000:2044  [+0x02044]  B3 0D                    mov     bl,0Dh
F000:2046  [+0x02046]  28 0E C3 20              sub     [20C3h],cl
F000:204A  [+0x0204A]  27                       daa
F000:204B  [+0x0204B]  0F 2D 0F                 cvtps2pi mm1,[bx]
F000:204E  [+0x0204E]  C3                       ret
F000:204F  [+0x0204F]  20 C3                    and     bl,al
F000:2051  [+0x02051]  20 C3                    and     bl,al
F000:2053  [+0x02053]  20 C3                    and     bl,al
F000:2055  [+0x02055]  20 C3                    and     bl,al
F000:2057  [+0x02057]  20 33                    and     [bp+di],dh
F000:2059  [+0x02059]  0F 62 0F                 punpckldq mm1,[bx]
F000:205C  [+0x0205C]  DB 0x8F  (bad)
F000:2060  [+0x02060]  B1 11                    mov     cl,11h
F000:2062  [+0x02062]  3F                       aas
F000:2063  [+0x02063]  11 26 21 3E              adc     [3E21h],sp
F000:2067  [+0x02067]  21 28                    and     [bx+si],bp
F000:2069  [+0x02069]  22 80 FC 5F              and     al,[bx+si+5FFCh]
F000:206D  [+0x0206D]  75 54                    jne     short 20C3h
F000:206F  [+0x0206F]  3C 10                    cmp     al,10h
F000:2071  [+0x02071]  75 02                    jne     short 2075h
F000:2073  [+0x02073]  B0 03                    mov     al,3
F000:2075  [+0x02075]  3C 04                    cmp     al,4
F000:2077  [+0x02077]  76 14                    jbe     short 208Dh
F000:2079  [+0x02079]  2C 50                    sub     al,50h
F000:207B  [+0x0207B]  72 46                    jb      short 20C3h
F000:207D  [+0x0207D]  3C 10                    cmp     al,10h
F000:207F  [+0x0207F]  72 0A                    jb      short 208Bh
F000:2081  [+0x02081]  2C 50                    sub     al,50h
F000:2083  [+0x02083]  72 3E                    jb      short 20C3h
F000:2085  [+0x02085]  3C 03                    cmp     al,3
F000:2087  [+0x02087]  73 3A                    jae     short 20C3h
F000:2089  [+0x02089]  04 10                    add     al,10h
F000:208B  [+0x0208B]  04 04                    add     al,4
F000:208D  [+0x0208D]  32 E4                    xor     ah,ah
F000:208F  [+0x0208F]  8B F0                    mov     si,ax
F000:2091  [+0x02091]  D1 E6                    shl     si,1
F000:2093  [+0x02093]  83 FE 28                 cmp     si,28h
F000:2096  [+0x02096]  72 06                    jb      short 209Eh
F000:2098  [+0x02098]  2E FF 94 3C 20           call    word [cs:si+203Ch]
F000:209D  [+0x0209D]  C3                       ret
F000:209E  [+0x0209E]  FF 36 49 04              push    word [449h]
F000:20A2  [+0x020A2]  1E                       push    ds
F000:20A3  [+0x020A3]  52                       push    dx
F000:20A4  [+0x020A4]  B0 2B                    mov     al,2Bh
F000:20A6  [+0x020A6]  E8 83 FF                 call    202Ch
F000:20A9  [+0x020A9]  88 26 49 04              mov     [449h],ah
F000:20AD  [+0x020AD]  BA C4 03                 mov     dx,3C4h
F000:20B0  [+0x020B0]  EC                       in      al,dx
F000:20B1  [+0x020B1]  5A                       pop     dx
F000:20B2  [+0x020B2]  50                       push    ax
F000:20B3  [+0x020B3]  2E FF 94 3C 20           call    word [cs:si+203Ch]
F000:20B8  [+0x020B8]  58                       pop     ax
F000:20B9  [+0x020B9]  1F                       pop     ds
F000:20BA  [+0x020BA]  BA C4 03                 mov     dx,3C4h
F000:20BD  [+0x020BD]  EE                       out     dx,al
F000:20BE  [+0x020BE]  58                       pop     ax
F000:20BF  [+0x020BF]  A2 49 04                 mov     [449h],al
F000:20C2  [+0x020C2]  C3                       ret
F000:20C3  [+0x020C3]  0C FF                    or      al,0FFh
F000:20C5  [+0x020C5]  C3                       ret
F000:20C6  [+0x020C6]  C6 46 10 5F              mov     byte [bp+10h],5Fh
F000:20CA  [+0x020CA]  BA D6 03                 mov     dx,3D6h
F000:20CD  [+0x020CD]  B0 00                    mov     al,0
F000:20CF  [+0x020CF]  E8 B8 2F                 call    508Ah
F000:20D2  [+0x020D2]  88 66 0E                 mov     [bp+0Eh],ah
F000:20D5  [+0x020D5]  B9 14 01                 mov     cx,114h
F000:20D8  [+0x020D8]  89 4E 0C                 mov     [bp+0Ch],cx
F000:20DB  [+0x020DB]  C7 46 0A 00 00           mov     word [bp+0Ah],0
F000:20E0  [+0x020E0]  B0 04                    mov     al,4
F000:20E2  [+0x020E2]  E8 4E FF                 call    2033h
F000:20E5  [+0x020E5]  80 E4 03                 and     ah,3
F000:20E8  [+0x020E8]  88 66 0F                 mov     [bp+0Fh],ah
F000:20EB  [+0x020EB]  C6 46 11 01              mov     byte [bp+11h],1
F000:20EF  [+0x020EF]  32 C0                    xor     al,al
F000:20F1  [+0x020F1]  C3                       ret
F000:20F2  [+0x020F2]  32 C0                    xor     al,al
F000:20F4  [+0x020F4]  C7 46 10 5F 00           mov     word [bp+10h],5Fh
F000:20F9  [+0x020F9]  80 FF FF                 cmp     bh,0FFh
F000:20FC  [+0x020FC]  75 05                    jne     short 2103h
F000:20FE  [+0x020FE]  E8 E0 F1                 call    12E1h
F000:2101  [+0x02101]  EB 12                    jmp     short 2115h
F000:2103  [+0x02103]  80 FF 02                 cmp     bh,2
F000:2106  [+0x02106]  72 13                    jb      short 211Bh
F000:2108  [+0x02108]  80 FF 04                 cmp     bh,4
F000:210B  [+0x0210B]  76 05                    jbe     short 2112h
F000:210D  [+0x0210D]  80 FF 07                 cmp     bh,7
F000:2110  [+0x02110]  77 09                    ja      short 211Bh
F000:2112  [+0x02112]  E8 9E F5                 call    16B3h
F000:2115  [+0x02115]  C6 46 11 00              mov     byte [bp+11h],0
F000:2119  [+0x02119]  33 C0                    xor     ax,ax
F000:211B  [+0x0211B]  0A C0                    or      al,al
F000:211D  [+0x0211D]  C3                       ret
F000:211E  [+0x0211E]  02 04                    add     al,[si]
F000:2120  [+0x02120]  04 05                    add     al,5
F000:2122  [+0x02122]  0F 10 10                 movups  xmm2,[bx+si]
F000:2125  [+0x02125]  11 C7                    adc     di,ax
F000:2127  [+0x02127]  46                       inc     si
F000:2128  [+0x02128]  10 5F 00                 adc     [bx],bl
F000:212B  [+0x0212B]  33 C0                    xor     ax,ax
F000:212D  [+0x0212D]  81 E1 07 80              and     cx,8007h
F000:2131  [+0x02131]  74 07                    je      short 213Ah
F000:2133  [+0x02133]  E8 36 2C                 call    4D6Ch
F000:2136  [+0x02136]  C6 46 11 01              mov     byte [bp+11h],1
F000:213A  [+0x0213A]  89 46 0E                 mov     [bp+0Eh],ax
F000:213D  [+0x0213D]  C3                       ret
F000:213E  [+0x0213E]  C7 46 10 5F 00           mov     word [bp+10h],5Fh
F000:2143  [+0x02143]  81 E1 07 C0              and     cx,0C007h
F000:2147  [+0x02147]  74 14                    je      short 215Dh
F000:2149  [+0x02149]  83 F9 02                 cmp     cx,2
F000:214C  [+0x0214C]  75 05                    jne     short 2153h
F000:214E  [+0x0214E]  E8 31 2C                 call    4D82h
F000:2151  [+0x02151]  EB 06                    jmp     short 2159h
F000:2153  [+0x02153]  80 CD 20                 or      ch,20h
F000:2156  [+0x02156]  E8 05 00                 call    215Eh
F000:2159  [+0x02159]  C6 46 11 01              mov     byte [bp+11h],1
F000:215D  [+0x0215D]  C3                       ret
F000:215E  [+0x0215E]  BA D6 03                 mov     dx,3D6h
F000:2161  [+0x02161]  8B FB                    mov     di,bx
F000:2163  [+0x02163]  EC                       in      al,dx
F000:2164  [+0x02164]  8A D8                    mov     bl,al
F000:2166  [+0x02166]  B0 14                    mov     al,14h
F000:2168  [+0x02168]  E8 1F 2F                 call    508Ah
F000:216B  [+0x0216B]  8A FC                    mov     bh,ah
F000:216D  [+0x0216D]  E8 1A 2F                 call    508Ah
F000:2170  [+0x02170]  8A C7                    mov     al,bh
F000:2172  [+0x02172]  50                       push    ax
F000:2173  [+0x02173]  F6 C5 80                 test    ch,80h
F000:2176  [+0x02176]  75 11                    jne     short 2189h
F000:2178  [+0x02178]  B8 15 00                 mov     ax,15h
F000:217B  [+0x0217B]  EF                       out     dx,ax
F000:217C  [+0x0217C]  FE C8                    dec     al
F000:217E  [+0x0217E]  8A E7                    mov     ah,bh
F000:2180  [+0x02180]  80 E4 FC                 and     ah,0FCh
F000:2183  [+0x02183]  EF                       out     dx,ax
F000:2184  [+0x02184]  8B DF                    mov     bx,di
F000:2186  [+0x02186]  E9 86 00                 jmp     220Fh
F000:2189  [+0x02189]  8A C3                    mov     al,bl
F000:218B  [+0x0218B]  EE                       out     dx,al
F000:218C  [+0x0218C]  51                       push    cx
F000:218D  [+0x0218D]  8B DF                    mov     bx,di
F000:218F  [+0x0218F]  83 C7 20                 add     di,20h
F000:2192  [+0x02192]  F6 C1 01                 test    cl,1
F000:2195  [+0x02195]  74 03                    je      short 219Ah
F000:2197  [+0x02197]  83 C7 46                 add     di,46h
F000:219A  [+0x0219A]  F6 C1 02                 test    cl,2
F000:219D  [+0x0219D]  74 03                    je      short 21A2h
F000:219F  [+0x0219F]  83 C7 3A                 add     di,3Ah
F000:21A2  [+0x021A2]  F6 C1 04                 test    cl,4
F000:21A5  [+0x021A5]  74 04                    je      short 21ABh
F000:21A7  [+0x021A7]  81 C7 03 03              add     di,303h
F000:21AB  [+0x021AB]  26 89 7F 1E              mov     [es:bx+1Eh],di
F000:21AF  [+0x021AF]  BA D6 03                 mov     dx,3D6h
F000:21B2  [+0x021B2]  EC                       in      al,dx
F000:21B3  [+0x021B3]  AA                       stosb
F000:21B4  [+0x021B4]  B0 02                    mov     al,2
F000:21B6  [+0x021B6]  B9 6F 00                 mov     cx,6Fh
F000:21B9  [+0x021B9]  E8 CE 2E                 call    508Ah
F000:21BC  [+0x021BC]  86 C4                    xchg    al,ah
F000:21BE  [+0x021BE]  AA                       stosb
F000:21BF  [+0x021BF]  86 C4                    xchg    al,ah
F000:21C1  [+0x021C1]  E2 F6                    loop    21B9h
F000:21C3  [+0x021C3]  B0 7E                    mov     al,7Eh
F000:21C5  [+0x021C5]  E8 C2 2E                 call    508Ah
F000:21C8  [+0x021C8]  8A C4                    mov     al,ah
F000:21CA  [+0x021CA]  AA                       stosb
F000:21CB  [+0x021CB]  B0 7F                    mov     al,7Fh
F000:21CD  [+0x021CD]  E8 BA 2E                 call    508Ah
F000:21D0  [+0x021D0]  8A C4                    mov     al,ah
F000:21D2  [+0x021D2]  AA                       stosb
F000:21D3  [+0x021D3]  26 8A 65 A1              mov     ah,[es:di-5Fh]
F000:21D7  [+0x021D7]  80 E4 FC                 and     ah,0FCh
F000:21DA  [+0x021DA]  B0 14                    mov     al,14h
F000:21DC  [+0x021DC]  8B C8                    mov     cx,ax
F000:21DE  [+0x021DE]  BA D6 03                 mov     dx,3D6h
F000:21E1  [+0x021E1]  EF                       out     dx,ax
F000:21E2  [+0x021E2]  FE C0                    inc     al
F000:21E4  [+0x021E4]  32 E4                    xor     ah,ah
F000:21E6  [+0x021E6]  EF                       out     dx,ax
F000:21E7  [+0x021E7]  8B F2                    mov     si,dx
F000:21E9  [+0x021E9]  8A E5                    mov     ah,ch
F000:21EB  [+0x021EB]  BA CC 03                 mov     dx,3CCh
F000:21EE  [+0x021EE]  EC                       in      al,dx
F000:21EF  [+0x021EF]  BA D8 03                 mov     dx,3D8h
F000:21F2  [+0x021F2]  80 CC 01                 or      ah,1
F000:21F5  [+0x021F5]  A8 01                    test    al,1
F000:21F7  [+0x021F7]  75 06                    jne     short 21FFh
F000:21F9  [+0x021F9]  BA B8 03                 mov     dx,3B8h
F000:21FC  [+0x021FC]  80 CC 03                 or      ah,3
F000:21FF  [+0x021FF]  87 D6                    xchg    dx,si
F000:2201  [+0x02201]  8A C1                    mov     al,cl
F000:2203  [+0x02203]  EF                       out     dx,ax
F000:2204  [+0x02204]  87 D6                    xchg    dx,si
F000:2206  [+0x02206]  EC                       in      al,dx
F000:2207  [+0x02207]  AA                       stosb
F000:2208  [+0x02208]  AA                       stosb
F000:2209  [+0x02209]  87 D6                    xchg    dx,si
F000:220B  [+0x0220B]  8B C1                    mov     ax,cx
F000:220D  [+0x0220D]  EF                       out     dx,ax
F000:220E  [+0x0220E]  59                       pop     cx
F000:220F  [+0x0220F]  51                       push    cx
F000:2210  [+0x02210]  E8 6F 2B                 call    4D82h
F000:2213  [+0x02213]  59                       pop     cx
F000:2214  [+0x02214]  F6 C5 40                 test    ch,40h
F000:2217  [+0x02217]  59                       pop     cx
F000:2218  [+0x02218]  75 0D                    jne     short 2227h
F000:221A  [+0x0221A]  BA D6 03                 mov     dx,3D6h
F000:221D  [+0x0221D]  8A E1                    mov     ah,cl
F000:221F  [+0x0221F]  B0 14                    mov     al,14h
F000:2221  [+0x02221]  EF                       out     dx,ax
F000:2222  [+0x02222]  FE C0                    inc     al
F000:2224  [+0x02224]  8A E5                    mov     ah,ch
F000:2226  [+0x02226]  EF                       out     dx,ax
F000:2227  [+0x02227]  C3                       ret
F000:2228  [+0x02228]  C7 46 10 5F 00           mov     word [bp+10h],5Fh
F000:222D  [+0x0222D]  81 E1 07 80              and     cx,8007h
F000:2231  [+0x02231]  75 04                    jne     short 2237h
F000:2233  [+0x02233]  0C FF                    or      al,0FFh
F000:2235  [+0x02235]  EB 16                    jmp     short 224Dh
F000:2237  [+0x02237]  83 F9 02                 cmp     cx,2
F000:223A  [+0x0223A]  75 05                    jne     short 2241h
F000:223C  [+0x0223C]  E8 BD 2C                 call    4EFCh
F000:223F  [+0x0223F]  EB 06                    jmp     short 2247h
F000:2241  [+0x02241]  80 CD 20                 or      ch,20h
F000:2244  [+0x02244]  E8 07 00                 call    224Eh
F000:2247  [+0x02247]  C6 46 11 01              mov     byte [bp+11h],1
F000:224B  [+0x0224B]  32 C0                    xor     al,al
F000:224D  [+0x0224D]  C3                       ret
F000:224E  [+0x0224E]  53                       push    bx
F000:224F  [+0x0224F]  8B FB                    mov     di,bx
F000:2251  [+0x02251]  B0 14                    mov     al,14h
F000:2253  [+0x02253]  E8 D6 FD                 call    202Ch
F000:2256  [+0x02256]  8A FC                    mov     bh,ah
F000:2258  [+0x02258]  80 E4 FC                 and     ah,0FCh
F000:225B  [+0x0225B]  EF                       out     dx,ax
F000:225C  [+0x0225C]  FE C0                    inc     al
F000:225E  [+0x0225E]  E8 3D 2E                 call    509Eh
F000:2261  [+0x02261]  8A DC                    mov     bl,ah
F000:2263  [+0x02263]  53                       push    bx
F000:2264  [+0x02264]  32 E4                    xor     ah,ah
F000:2266  [+0x02266]  EF                       out     dx,ax
F000:2267  [+0x02267]  8B DF                    mov     bx,di
F000:2269  [+0x02269]  E8 90 2C                 call    4EFCh
F000:226C  [+0x0226C]  5B                       pop     bx
F000:226D  [+0x0226D]  F6 C5 80                 test    ch,80h
F000:2270  [+0x02270]  75 10                    jne     short 2282h
F000:2272  [+0x02272]  BA D6 03                 mov     dx,3D6h
F000:2275  [+0x02275]  8A E7                    mov     ah,bh
F000:2277  [+0x02277]  B0 14                    mov     al,14h
F000:2279  [+0x02279]  EF                       out     dx,ax
F000:227A  [+0x0227A]  FE C0                    inc     al
F000:227C  [+0x0227C]  8A E3                    mov     ah,bl
F000:227E  [+0x0227E]  EF                       out     dx,ax
F000:227F  [+0x0227F]  5B                       pop     bx
F000:2280  [+0x02280]  EB 72                    jmp     short 22F4h
F000:2282  [+0x02282]  5B                       pop     bx
F000:2283  [+0x02283]  26 8B 77 1E              mov     si,[es:bx+1Eh]
F000:2287  [+0x02287]  8B FE                    mov     di,si
F000:2289  [+0x02289]  83 C7 72                 add     di,72h
F000:228C  [+0x0228C]  26 8A 64 13              mov     ah,[es:si+13h]
F000:2290  [+0x02290]  8A EC                    mov     ch,ah
F000:2292  [+0x02292]  BA CC 03                 mov     dx,3CCh
F000:2295  [+0x02295]  EC                       in      al,dx
F000:2296  [+0x02296]  8A C8                    mov     cl,al
F000:2298  [+0x02298]  24 FE                    and     al,0FEh
F000:229A  [+0x0229A]  BA C2 03                 mov     dx,3C2h
F000:229D  [+0x0229D]  EE                       out     dx,al
F000:229E  [+0x0229E]  8A E5                    mov     ah,ch
F000:22A0  [+0x022A0]  BB D6 03                 mov     bx,3D6h
F000:22A3  [+0x022A3]  8B D3                    mov     dx,bx
F000:22A5  [+0x022A5]  80 CC 03                 or      ah,3
F000:22A8  [+0x022A8]  B0 14                    mov     al,14h
F000:22AA  [+0x022AA]  EF                       out     dx,ax
F000:22AB  [+0x022AB]  BA B8 03                 mov     dx,3B8h
F000:22AE  [+0x022AE]  26 8A 05                 mov     al,[es:di]
F000:22B1  [+0x022B1]  EE                       out     dx,al
F000:22B2  [+0x022B2]  BA BF 03                 mov     dx,3BFh
F000:22B5  [+0x022B5]  8A C5                    mov     al,ch
F000:22B7  [+0x022B7]  24 0C                    and     al,0Ch
F000:22B9  [+0x022B9]  D0 E8                    shr     al,1
F000:22BB  [+0x022BB]  D0 E8                    shr     al,1
F000:22BD  [+0x022BD]  EE                       out     dx,al
F000:22BE  [+0x022BE]  8B D3                    mov     dx,bx
F000:22C0  [+0x022C0]  B0 14                    mov     al,14h
F000:22C2  [+0x022C2]  8A E5                    mov     ah,ch
F000:22C4  [+0x022C4]  80 E4 FC                 and     ah,0FCh
F000:22C7  [+0x022C7]  EF                       out     dx,ax
F000:22C8  [+0x022C8]  BA C2 03                 mov     dx,3C2h
F000:22CB  [+0x022CB]  8A C1                    mov     al,cl
F000:22CD  [+0x022CD]  EE                       out     dx,al
F000:22CE  [+0x022CE]  8B D3                    mov     dx,bx
F000:22D0  [+0x022D0]  B0 02                    mov     al,2
F000:22D2  [+0x022D2]  8B FE                    mov     di,si
F000:22D4  [+0x022D4]  47                       inc     di
F000:22D5  [+0x022D5]  B9 6F 00                 mov     cx,6Fh
F000:22D8  [+0x022D8]  26 8A 25                 mov     ah,[es:di]
F000:22DB  [+0x022DB]  EF                       out     dx,ax
F000:22DC  [+0x022DC]  47                       inc     di
F000:22DD  [+0x022DD]  FE C0                    inc     al
F000:22DF  [+0x022DF]  E2 F7                    loop    22D8h
F000:22E1  [+0x022E1]  26 8A 25                 mov     ah,[es:di]
F000:22E4  [+0x022E4]  B0 7E                    mov     al,7Eh
F000:22E6  [+0x022E6]  EF                       out     dx,ax
F000:22E7  [+0x022E7]  EB 00                    jmp     short 22E9h
F000:22E9  [+0x022E9]  47                       inc     di
F000:22EA  [+0x022EA]  26 8A 25                 mov     ah,[es:di]
F000:22ED  [+0x022ED]  FE C0                    inc     al
F000:22EF  [+0x022EF]  EF                       out     dx,ax
F000:22F0  [+0x022F0]  26 8A 04                 mov     al,[es:si]
F000:22F3  [+0x022F3]  EE                       out     dx,al
F000:22F4  [+0x022F4]  C3                       ret
F000:22F5  [+0x022F5]  00 B0 05 E8              add     [bx+si-17FBh],dh
F000:22F9  [+0x022F9]  31 FD                    xor     bp,di
F000:22FB  [+0x022FB]  80 E4 E7                 and     ah,0E7h
F000:22FE  [+0x022FE]  B1 04                    mov     cl,4
F000:2300  [+0x02300]  D3 EB                    shr     bx,cl
F000:2302  [+0x02302]  8A CB                    mov     cl,bl
F000:2304  [+0x02304]  80 E1 0F                 and     cl,0Fh
F000:2307  [+0x02307]  D0 E1                    shl     cl,1
F000:2309  [+0x02309]  0A E1                    or      ah,cl
F000:230B  [+0x0230B]  80 E4 DF                 and     ah,0DFh
F000:230E  [+0x0230E]  F6 C4 10                 test    ah,10h
F000:2311  [+0x02311]  74 03                    je      short 2316h
F000:2313  [+0x02313]  80 CC 20                 or      ah,20h
F000:2316  [+0x02316]  EF                       out     dx,ax
F000:2317  [+0x02317]  80 F9 00                 cmp     cl,0
F000:231A  [+0x0231A]  74 03                    je      short 231Fh
F000:231C  [+0x0231C]  80 C9 FF                 or      cl,0FFh
F000:231F  [+0x0231F]  9C                       pushf
F000:2320  [+0x02320]  53                       push    bx
F000:2321  [+0x02321]  B9 08 00                 mov     cx,8
F000:2324  [+0x02324]  32 C0                    xor     al,al
F000:2326  [+0x02326]  E8 A7 2D                 call    50D0h
F000:2329  [+0x02329]  5B                       pop     bx
F000:232A  [+0x0232A]  9D                       popf
F000:232B  [+0x0232B]  C3                       ret
F000:232C  [+0x0232C]  BB DB 01                 mov     bx,1DBh
F000:232F  [+0x0232F]  2E 8B 37                 mov     si,[cs:bx]
F000:2332  [+0x02332]  2E 8B 4F 04              mov     cx,[cs:bx+4]
F000:2336  [+0x02336]  E8 59 01                 call    2492h
F000:2339  [+0x02339]  B9 32 00                 mov     cx,32h
F000:233C  [+0x0233C]  32 C0                    xor     al,al
F000:233E  [+0x0233E]  E8 8F 2D                 call    50D0h
F000:2341  [+0x02341]  2E 8A 0E 85 01           mov     cl,[cs:185h]
F000:2346  [+0x02346]  E8 9D 00                 call    23E6h
F000:2349  [+0x02349]  24 FC                    and     al,0FCh
F000:234B  [+0x0234B]  0A C1                    or      al,cl
F000:234D  [+0x0234D]  E8 A7 00                 call    23F7h
F000:2350  [+0x02350]  E8 52 00                 call    23A5h
F000:2353  [+0x02353]  B0 00                    mov     al,0
F000:2355  [+0x02355]  E8 CE 00                 call    2426h
F000:2358  [+0x02358]  BA D6 03                 mov     dx,3D6h
F000:235B  [+0x0235B]  2E 8A 26 96 01           mov     ah,[cs:196h]
F000:2360  [+0x02360]  B1 03                    mov     cl,3
F000:2362  [+0x02362]  D2 E4                    shl     ah,cl
F000:2364  [+0x02364]  80 E4 7F                 and     ah,7Fh
F000:2367  [+0x02367]  2E 80 3E 81 01 00        cmp     byte [cs:181h],0
F000:236D  [+0x0236D]  74 03                    je      short 2372h
F000:236F  [+0x0236F]  80 CC 80                 or      ah,80h
F000:2372  [+0x02372]  2E 80 3E 96 01 10        cmp     byte [cs:196h],10h
F000:2378  [+0x02378]  72 03                    jb      short 237Dh
F000:237A  [+0x0237A]  80 CC 80                 or      ah,80h
F000:237D  [+0x0237D]  B0 08                    mov     al,8
F000:237F  [+0x0237F]  E8 27 2D                 call    50A9h
F000:2382  [+0x02382]  B1 80                    mov     cl,80h
F000:2384  [+0x02384]  E8 AC FC                 call    2033h
F000:2387  [+0x02387]  F6 C4 80                 test    ah,80h
F000:238A  [+0x0238A]  75 02                    jne     short 238Eh
F000:238C  [+0x0238C]  B1 00                    mov     cl,0
F000:238E  [+0x0238E]  B0 59                    mov     al,59h
F000:2390  [+0x02390]  E8 99 FC                 call    202Ch
F000:2393  [+0x02393]  80 E4 7F                 and     ah,7Fh
F000:2396  [+0x02396]  0A E1                    or      ah,cl
F000:2398  [+0x02398]  EF                       out     dx,ax
F000:2399  [+0x02399]  B9 32 00                 mov     cx,32h
F000:239C  [+0x0239C]  32 C0                    xor     al,al
F000:239E  [+0x0239E]  E8 2F 2D                 call    50D0h
F000:23A1  [+0x023A1]  C3                       ret
F000:23A2  [+0x023A2]  56                       push    si
F000:23A3  [+0x023A3]  5E                       pop     si
F000:23A4  [+0x023A4]  C3                       ret
F000:23A5  [+0x023A5]  52                       push    dx
F000:23A6  [+0x023A6]  B0 6C                    mov     al,6Ch
F000:23A8  [+0x023A8]  E8 81 FC                 call    202Ch
F000:23AB  [+0x023AB]  8B D8                    mov     bx,ax
F000:23AD  [+0x023AD]  80 E7 02                 and     bh,2
F000:23B0  [+0x023B0]  53                       push    bx
F000:23B1  [+0x023B1]  B0 0F                    mov     al,0Fh
F000:23B3  [+0x023B3]  E8 ED 2C                 call    50A3h
F000:23B6  [+0x023B6]  80 E4 03                 and     ah,3
F000:23B9  [+0x023B9]  8B D8                    mov     bx,ax
F000:23BB  [+0x023BB]  53                       push    bx
F000:23BC  [+0x023BC]  BB E7 01                 mov     bx,1E7h
F000:23BF  [+0x023BF]  2E 8B 37                 mov     si,[cs:bx]
F000:23C2  [+0x023C2]  2E 8B 4F 02              mov     cx,[cs:bx+2]
F000:23C6  [+0x023C6]  E8 C9 00                 call    2492h
F000:23C9  [+0x023C9]  5B                       pop     bx
F000:23CA  [+0x023CA]  8A C3                    mov     al,bl
F000:23CC  [+0x023CC]  E8 5D FC                 call    202Ch
F000:23CF  [+0x023CF]  80 E4 FC                 and     ah,0FCh
F000:23D2  [+0x023D2]  80 CC 02                 or      ah,2
F000:23D5  [+0x023D5]  0A E7                    or      ah,bh
F000:23D7  [+0x023D7]  EF                       out     dx,ax
F000:23D8  [+0x023D8]  5B                       pop     bx
F000:23D9  [+0x023D9]  B0 6C                    mov     al,6Ch
F000:23DB  [+0x023DB]  E8 4E FC                 call    202Ch
F000:23DE  [+0x023DE]  80 E4 FD                 and     ah,0FDh
F000:23E1  [+0x023E1]  0A E7                    or      ah,bh
F000:23E3  [+0x023E3]  EF                       out     dx,ax
F000:23E4  [+0x023E4]  5A                       pop     dx
F000:23E5  [+0x023E5]  C3                       ret
F000:23E6  [+0x023E6]  52                       push    dx
F000:23E7  [+0x023E7]  B0 44                    mov     al,44h
F000:23E9  [+0x023E9]  E8 40 FC                 call    202Ch
F000:23EC  [+0x023EC]  86 E0                    xchg    ah,al
F000:23EE  [+0x023EE]  8A D0                    mov     dl,al
F000:23F0  [+0x023F0]  80 E2 03                 and     dl,3
F000:23F3  [+0x023F3]  0A D2                    or      dl,dl
F000:23F5  [+0x023F5]  5A                       pop     dx
F000:23F6  [+0x023F6]  C3                       ret
F000:23F7  [+0x023F7]  50                       push    ax
F000:23F8  [+0x023F8]  52                       push    dx
F000:23F9  [+0x023F9]  BA D6 03                 mov     dx,3D6h
F000:23FC  [+0x023FC]  8A E0                    mov     ah,al
F000:23FE  [+0x023FE]  B0 44                    mov     al,44h
F000:2400  [+0x02400]  EF                       out     dx,ax
F000:2401  [+0x02401]  5A                       pop     dx
F000:2402  [+0x02402]  58                       pop     ax
F000:2403  [+0x02403]  C3                       ret
F000:2404  [+0x02404]  50                       push    ax
F000:2405  [+0x02405]  52                       push    dx
F000:2406  [+0x02406]  B0 6C                    mov     al,6Ch
F000:2408  [+0x02408]  E8 21 FC                 call    202Ch
F000:240B  [+0x0240B]  F6 C4 02                 test    ah,2
F000:240E  [+0x0240E]  5A                       pop     dx
F000:240F  [+0x0240F]  58                       pop     ax
F000:2410  [+0x02410]  C3                       ret
F000:2411  [+0x02411]  50                       push    ax
F000:2412  [+0x02412]  E8 03 F1                 call    1518h
F000:2415  [+0x02415]  80 FC 40                 cmp     ah,40h
F000:2418  [+0x02418]  74 0A                    je      short 2424h
F000:241A  [+0x0241A]  80 FC 41                 cmp     ah,41h
F000:241D  [+0x0241D]  74 05                    je      short 2424h
F000:241F  [+0x0241F]  80 FC 50                 cmp     ah,50h
F000:2422  [+0x02422]  74 00                    je      short 2424h
F000:2424  [+0x02424]  58                       pop     ax
F000:2425  [+0x02425]  C3                       ret
F000:2426  [+0x02426]  53                       push    bx
F000:2427  [+0x02427]  E8 02 00                 call    242Ch
F000:242A  [+0x0242A]  5B                       pop     bx
F000:242B  [+0x0242B]  C3                       ret
F000:242C  [+0x0242C]  BB E1 01                 mov     bx,1E1h
F000:242F  [+0x0242F]  A8 07                    test    al,7
F000:2431  [+0x02431]  75 09                    jne     short 243Ch
F000:2433  [+0x02433]  3C 00                    cmp     al,0
F000:2435  [+0x02435]  74 0B                    je      short 2442h
F000:2437  [+0x02437]  BB ED 01                 mov     bx,1EDh
F000:243A  [+0x0243A]  EB 06                    jmp     short 2442h
F000:243C  [+0x0243C]  B1 06                    mov     cl,6
F000:243E  [+0x0243E]  F6 E1                    mul     cl
F000:2440  [+0x02440]  03 D8                    add     bx,ax
F000:2442  [+0x02442]  2E 8B 37                 mov     si,[cs:bx]
F000:2445  [+0x02445]  2E 8B 4F 04              mov     cx,[cs:bx+4]
F000:2449  [+0x02449]  E8 46 00                 call    2492h
F000:244C  [+0x0244C]  E8 F7 E7                 call    0C46h
F000:244F  [+0x0244F]  74 06                    je      short 2457h
F000:2451  [+0x02451]  E8 04 00                 call    2458h
F000:2454  [+0x02454]  E8 3B 00                 call    2492h
F000:2457  [+0x02457]  C3                       ret
F000:2458  [+0x02458]  E8 8B FF                 call    23E6h
F000:245B  [+0x0245B]  74 22                    je      short 247Fh
F000:245D  [+0x0245D]  25 03 00                 and     ax,3
F000:2460  [+0x02460]  48                       dec     ax
F000:2461  [+0x02461]  BB 11 02                 mov     bx,211h
F000:2464  [+0x02464]  2E 8B 17                 mov     dx,[cs:bx]
F000:2467  [+0x02467]  F7 E2                    mul     dx
F000:2469  [+0x02469]  BB 0B 02                 mov     bx,20Bh
F000:246C  [+0x0246C]  E8 EE E7                 call    0C5Dh
F000:246F  [+0x0246F]  74 03                    je      short 2474h
F000:2471  [+0x02471]  BB 05 02                 mov     bx,205h
F000:2474  [+0x02474]  2E 8B 37                 mov     si,[cs:bx]
F000:2477  [+0x02477]  2E 8B 4F 04              mov     cx,[cs:bx+4]
F000:247B  [+0x0247B]  03 F0                    add     si,ax
F000:247D  [+0x0247D]  EB 12                    jmp     short 2491h
F000:247F  [+0x0247F]  BB F3 01                 mov     bx,1F3h
F000:2482  [+0x02482]  E8 D8 E7                 call    0C5Dh
F000:2485  [+0x02485]  74 03                    je      short 248Ah
F000:2487  [+0x02487]  BB F9 01                 mov     bx,1F9h
F000:248A  [+0x0248A]  2E 8B 37                 mov     si,[cs:bx]
F000:248D  [+0x0248D]  2E 8B 4F 04              mov     cx,[cs:bx+4]
F000:2491  [+0x02491]  C3                       ret
F000:2492  [+0x02492]  52                       push    dx
F000:2493  [+0x02493]  E8 21 2E                 call    52B7h
F000:2496  [+0x02496]  BA D6 03                 mov     dx,3D6h
F000:2499  [+0x02499]  E3 05                    jcxz    24A0h
F000:249B  [+0x0249B]  2E AD                    cs lodsw
F000:249D  [+0x0249D]  EF                       out     dx,ax
F000:249E  [+0x0249E]  E2 FB                    loop    249Bh
F000:24A0  [+0x024A0]  E8 1C 2E                 call    52BFh
F000:24A3  [+0x024A3]  5A                       pop     dx
F000:24A4  [+0x024A4]  C3                       ret
F000:24A5  [+0x024A5]  50                       push    ax
F000:24A6  [+0x024A6]  2E A0 9B 01              mov     al,[cs:19Bh]
F000:24AA  [+0x024AA]  A8 80                    test    al,80h
F000:24AC  [+0x024AC]  74 1E                    je      short 24CCh
F000:24AE  [+0x024AE]  24 7F                    and     al,7Fh
F000:24B0  [+0x024B0]  8A F8                    mov     bh,al
F000:24B2  [+0x024B2]  8A 1E 49 04              mov     bl,[449h]
F000:24B6  [+0x024B6]  53                       push    bx
F000:24B7  [+0x024B7]  32 E4                    xor     ah,ah
F000:24B9  [+0x024B9]  CD 10                    int     10h
F000:24BB  [+0x024BB]  8A 1E 49 04              mov     bl,[449h]
F000:24BF  [+0x024BF]  58                       pop     ax
F000:24C0  [+0x024C0]  3A C3                    cmp     al,bl
F000:24C2  [+0x024C2]  74 08                    je      short 24CCh
F000:24C4  [+0x024C4]  3A E3                    cmp     ah,bl
F000:24C6  [+0x024C6]  74 04                    je      short 24CCh
F000:24C8  [+0x024C8]  32 E4                    xor     ah,ah
F000:24CA  [+0x024CA]  CD 10                    int     10h
F000:24CC  [+0x024CC]  58                       pop     ax
F000:24CD  [+0x024CD]  C3                       ret
F000:24CE  [+0x024CE]  2E F6 06 7E 01 80        test    byte [cs:17Eh],80h
F000:24D4  [+0x024D4]  74 06                    je      short 24DCh
F000:24D6  [+0x024D6]  E4 85                    in      al,85h
F000:24D8  [+0x024D8]  A8 02                    test    al,2
F000:24DA  [+0x024DA]  75 5E                    jne     short 253Ah
F000:24DC  [+0x024DC]  2E F6 06 7B 01 10        test    byte [cs:17Bh],10h
F000:24E2  [+0x024E2]  74 56                    je      short 253Ah
F000:24E4  [+0x024E4]  BE 8D 00                 mov     si,8Dh
F000:24E7  [+0x024E7]  2E 80 3C 00              cmp     byte [cs:si],0
F000:24EB  [+0x024EB]  75 12                    jne     short 24FFh
F000:24ED  [+0x024ED]  2E 80 3E 70 00 FE        cmp     byte [cs:70h],0FEh
F000:24F3  [+0x024F3]  74 15                    je      short 250Ah
F000:24F5  [+0x024F5]  2E F6 06 7B 01 08        test    byte [cs:17Bh],8
F000:24FB  [+0x024FB]  74 13                    je      short 2510h
F000:24FD  [+0x024FD]  EB 3B                    jmp     short 253Ah
F000:24FF  [+0x024FF]  E8 39 00                 call    253Bh
F000:2502  [+0x02502]  2E 80 3E 70 00 FE        cmp     byte [cs:70h],0FEh
F000:2508  [+0x02508]  75 06                    jne     short 2510h
F000:250A  [+0x0250A]  BE 2A 0C                 mov     si,0C2Ah
F000:250D  [+0x0250D]  E8 2B 00                 call    253Bh
F000:2510  [+0x02510]  2E F6 06 7B 01 08        test    byte [cs:17Bh],8
F000:2516  [+0x02516]  75 06                    jne     short 251Eh
F000:2518  [+0x02518]  BE 2B 01                 mov     si,12Bh
F000:251B  [+0x0251B]  E8 1D 00                 call    253Bh
F000:251E  [+0x0251E]  2E F6 06 7B 01 20        test    byte [cs:17Bh],20h
F000:2524  [+0x02524]  74 14                    je      short 253Ah
F000:2526  [+0x02526]  B9 00 18                 mov     cx,1800h
F000:2529  [+0x02529]  B0 00                    mov     al,0
F000:252B  [+0x0252B]  E8 A2 2B                 call    50D0h
F000:252E  [+0x0252E]  E8 54 0D                 call    3285h
F000:2531  [+0x02531]  B7 00                    mov     bh,0
F000:2533  [+0x02533]  BA 00 00                 mov     dx,0
F000:2536  [+0x02536]  B4 02                    mov     ah,2
F000:2538  [+0x02538]  CD 10                    int     10h
F000:253A  [+0x0253A]  C3                       ret
F000:253B  [+0x0253B]  BB 07 00                 mov     bx,7
F000:253E  [+0x0253E]  B4 0E                    mov     ah,0Eh
F000:2540  [+0x02540]  2E AC                    cs lodsb
F000:2542  [+0x02542]  84 C0                    test    al,al
F000:2544  [+0x02544]  74 04                    je      short 254Ah
F000:2546  [+0x02546]  CD 10                    int     10h
F000:2548  [+0x02548]  EB F4                    jmp     short 253Eh
F000:254A  [+0x0254A]  C3                       ret
F000:254B  [+0x0254B]  55                       push    bp
F000:254C  [+0x0254C]  83 EC 04                 sub     sp,4
F000:254F  [+0x0254F]  8B EC                    mov     bp,sp
F000:2551  [+0x02551]  E8 BC 00                 call    2610h
F000:2554  [+0x02554]  BA CE 03                 mov     dx,3CEh
F000:2557  [+0x02557]  B8 02 FF                 mov     ax,0FF02h
F000:255A  [+0x0255A]  EF                       out     dx,ax
F000:255B  [+0x0255B]  BA D6 03                 mov     dx,3D6h
F000:255E  [+0x0255E]  B8 0B 01                 mov     ax,10Bh
F000:2561  [+0x02561]  EF                       out     dx,ax
F000:2562  [+0x02562]  B0 04                    mov     al,4
F000:2564  [+0x02564]  E8 37 2B                 call    509Eh
F000:2567  [+0x02567]  80 E4 FC                 and     ah,0FCh
F000:256A  [+0x0256A]  80 CC 01                 or      ah,1
F000:256D  [+0x0256D]  50                       push    ax
F000:256E  [+0x0256E]  EF                       out     dx,ax
F000:256F  [+0x0256F]  BB 40 40                 mov     bx,4040h
F000:2572  [+0x02572]  E8 7A 00                 call    25EFh
F000:2575  [+0x02575]  58                       pop     ax
F000:2576  [+0x02576]  74 05                    je      short 257Dh
F000:2578  [+0x02578]  BB 00 01                 mov     bx,100h
F000:257B  [+0x0257B]  EB 43                    jmp     short 25C0h
F000:257D  [+0x0257D]  B0 04                    mov     al,4
F000:257F  [+0x0257F]  E8 1C 2B                 call    509Eh
F000:2582  [+0x02582]  80 E4 FC                 and     ah,0FCh
F000:2585  [+0x02585]  EF                       out     dx,ax
F000:2586  [+0x02586]  BB 80 00                 mov     bx,80h
F000:2589  [+0x02589]  E8 63 00                 call    25EFh
F000:258C  [+0x0258C]  75 0C                    jne     short 259Ah
F000:258E  [+0x0258E]  33 DB                    xor     bx,bx
F000:2590  [+0x02590]  E8 E5 04                 call    2A78h
F000:2593  [+0x02593]  75 28                    jne     short 25BDh
F000:2595  [+0x02595]  BB 00 01                 mov     bx,100h
F000:2598  [+0x02598]  EB 26                    jmp     short 25C0h
F000:259A  [+0x0259A]  B3 40                    mov     bl,40h
F000:259C  [+0x0259C]  E8 B9 00                 call    2658h
F000:259F  [+0x0259F]  E8 D6 04                 call    2A78h
F000:25A2  [+0x025A2]  75 F1                    jne     short 2595h
F000:25A4  [+0x025A4]  B3 80                    mov     bl,80h
F000:25A6  [+0x025A6]  E8 AF 00                 call    2658h
F000:25A9  [+0x025A9]  E8 CC 04                 call    2A78h
F000:25AC  [+0x025AC]  75 E7                    jne     short 2595h
F000:25AE  [+0x025AE]  B3 C0                    mov     bl,0C0h
F000:25B0  [+0x025B0]  E8 A5 00                 call    2658h
F000:25B3  [+0x025B3]  E8 C2 04                 call    2A78h
F000:25B6  [+0x025B6]  75 DD                    jne     short 2595h
F000:25B8  [+0x025B8]  BB 00 00                 mov     bx,0
F000:25BB  [+0x025BB]  EB 03                    jmp     short 25C0h
F000:25BD  [+0x025BD]  BB FF 00                 mov     bx,0FFh
F000:25C0  [+0x025C0]  B0 04                    mov     al,4
F000:25C2  [+0x025C2]  E8 67 FA                 call    202Ch
F000:25C5  [+0x025C5]  80 E4 FC                 and     ah,0FCh
F000:25C8  [+0x025C8]  0A E7                    or      ah,bh
F000:25CA  [+0x025CA]  EF                       out     dx,ax
F000:25CB  [+0x025CB]  E8 65 FA                 call    2033h
F000:25CE  [+0x025CE]  80 E4 FC                 and     ah,0FCh
F000:25D1  [+0x025D1]  80 FF 00                 cmp     bh,0
F000:25D4  [+0x025D4]  75 02                    jne     short 25D8h
F000:25D6  [+0x025D6]  B7 02                    mov     bh,2
F000:25D8  [+0x025D8]  0A E7                    or      ah,bh
F000:25DA  [+0x025DA]  EF                       out     dx,ax
F000:25DB  [+0x025DB]  8A D3                    mov     dl,bl
F000:25DD  [+0x025DD]  32 C0                    xor     al,al
F000:25DF  [+0x025DF]  88 46 02                 mov     [bp+2],al
F000:25E2  [+0x025E2]  88 46 03                 mov     [bp+3],al
F000:25E5  [+0x025E5]  E8 56 00                 call    263Eh
F000:25E8  [+0x025E8]  83 C4 04                 add     sp,4
F000:25EB  [+0x025EB]  5D                       pop     bp
F000:25EC  [+0x025EC]  0A D2                    or      dl,dl
F000:25EE  [+0x025EE]  C3                       ret
F000:25EF  [+0x025EF]  E8 66 00                 call    2658h
F000:25F2  [+0x025F2]  B9 10 00                 mov     cx,10h
F000:25F5  [+0x025F5]  33 FF                    xor     di,di
F000:25F7  [+0x025F7]  8A C1                    mov     al,cl
F000:25F9  [+0x025F9]  AA                       stosb
F000:25FA  [+0x025FA]  E2 FB                    loop    25F7h
F000:25FC  [+0x025FC]  3A FB                    cmp     bh,bl
F000:25FE  [+0x025FE]  74 05                    je      short 2605h
F000:2600  [+0x02600]  8A DF                    mov     bl,bh
F000:2602  [+0x02602]  E8 53 00                 call    2658h
F000:2605  [+0x02605]  33 FF                    xor     di,di
F000:2607  [+0x02607]  B9 10 00                 mov     cx,10h
F000:260A  [+0x0260A]  8A C1                    mov     al,cl
F000:260C  [+0x0260C]  AE                       scasb
F000:260D  [+0x0260D]  E1 FB                    loope   260Ah
F000:260F  [+0x0260F]  C3                       ret
F000:2610  [+0x02610]  50                       push    ax
F000:2611  [+0x02611]  53                       push    bx
F000:2612  [+0x02612]  52                       push    dx
F000:2613  [+0x02613]  8A D8                    mov     bl,al
F000:2615  [+0x02615]  BA D6 03                 mov     dx,3D6h
F000:2618  [+0x02618]  B0 10                    mov     al,10h
F000:261A  [+0x0261A]  E8 6D 2A                 call    508Ah
F000:261D  [+0x0261D]  88 66 02                 mov     [bp+2],ah
F000:2620  [+0x02620]  E8 67 2A                 call    508Ah
F000:2623  [+0x02623]  88 66 03                 mov     [bp+3],ah
F000:2626  [+0x02626]  B0 0B                    mov     al,0Bh
F000:2628  [+0x02628]  E8 73 2A                 call    509Eh
F000:262B  [+0x0262B]  88 66 01                 mov     [bp+1],ah
F000:262E  [+0x0262E]  80 E4 FD                 and     ah,0FDh
F000:2631  [+0x02631]  F6 C3 04                 test    bl,4
F000:2634  [+0x02634]  74 03                    je      short 2639h
F000:2636  [+0x02636]  80 CC 04                 or      ah,4
F000:2639  [+0x02639]  EF                       out     dx,ax
F000:263A  [+0x0263A]  5A                       pop     dx
F000:263B  [+0x0263B]  5B                       pop     bx
F000:263C  [+0x0263C]  9D                       popf
F000:263D  [+0x0263D]  C3                       ret
F000:263E  [+0x0263E]  50                       push    ax
F000:263F  [+0x0263F]  52                       push    dx
F000:2640  [+0x02640]  BA D6 03                 mov     dx,3D6h
F000:2643  [+0x02643]  B0 0B                    mov     al,0Bh
F000:2645  [+0x02645]  8A 66 01                 mov     ah,[bp+1]
F000:2648  [+0x02648]  EF                       out     dx,ax
F000:2649  [+0x02649]  B0 10                    mov     al,10h
F000:264B  [+0x0264B]  8A 66 02                 mov     ah,[bp+2]
F000:264E  [+0x0264E]  EF                       out     dx,ax
F000:264F  [+0x0264F]  B0 11                    mov     al,11h
F000:2651  [+0x02651]  8A 66 03                 mov     ah,[bp+3]
F000:2654  [+0x02654]  EF                       out     dx,ax
F000:2655  [+0x02655]  5A                       pop     dx
F000:2656  [+0x02656]  58                       pop     ax
F000:2657  [+0x02657]  C3                       ret
F000:2658  [+0x02658]  50                       push    ax
F000:2659  [+0x02659]  52                       push    dx
F000:265A  [+0x0265A]  BA D6 03                 mov     dx,3D6h
F000:265D  [+0x0265D]  8A E3                    mov     ah,bl
F000:265F  [+0x0265F]  B0 10                    mov     al,10h
F000:2661  [+0x02661]  EF                       out     dx,ax
F000:2662  [+0x02662]  5A                       pop     dx
F000:2663  [+0x02663]  58                       pop     ax
F000:2664  [+0x02664]  C3                       ret
F000:2665  [+0x02665]  50                       push    ax
F000:2666  [+0x02666]  52                       push    dx
F000:2667  [+0x02667]  BA D6 03                 mov     dx,3D6h
F000:266A  [+0x0266A]  B0 10                    mov     al,10h
F000:266C  [+0x0266C]  8A E3                    mov     ah,bl
F000:266E  [+0x0266E]  EF                       out     dx,ax
F000:266F  [+0x0266F]  B0 11                    mov     al,11h
F000:2671  [+0x02671]  8A E7                    mov     ah,bh
F000:2673  [+0x02673]  EF                       out     dx,ax
F000:2674  [+0x02674]  5A                       pop     dx
F000:2675  [+0x02675]  58                       pop     ax
F000:2676  [+0x02676]  C3                       ret
F000:2677  [+0x02677]  00 00                    add     [bx+si],al
F000:2679  [+0x02679]  00 00                    add     [bx+si],al
F000:267B  [+0x0267B]  00 A0 FA 50              add     [bx+si+50FAh],ah
F000:267F  [+0x0267F]  53                       push    bx
F000:2680  [+0x02680]  51                       push    cx
F000:2681  [+0x02681]  52                       push    dx
F000:2682  [+0x02682]  56                       push    si
F000:2683  [+0x02683]  57                       push    di
F000:2684  [+0x02684]  55                       push    bp
F000:2685  [+0x02685]  06                       push    es
F000:2686  [+0x02686]  1E                       push    ds
F000:2687  [+0x02687]  83 EC 02                 sub     sp,2
F000:268A  [+0x0268A]  FC                       cld
F000:268B  [+0x0268B]  2E 8E 1E 77 26           mov     ds,[cs:2677h]
F000:2690  [+0x02690]  8B EC                    mov     bp,sp
F000:2692  [+0x02692]  BA D6 03                 mov     dx,3D6h
F000:2695  [+0x02695]  B8 6F 00                 mov     ax,6Fh
F000:2698  [+0x02698]  EF                       out     dx,ax
F000:2699  [+0x02699]  E8 66 02                 call    2902h
F000:269C  [+0x0269C]  B0 00                    mov     al,0
F000:269E  [+0x0269E]  BA C6 03                 mov     dx,3C6h
F000:26A1  [+0x026A1]  EE                       out     dx,al
F000:26A2  [+0x026A2]  B8 34 5F                 mov     ax,5F34h
F000:26A5  [+0x026A5]  CD 15                    int     15h
F000:26A7  [+0x026A7]  2E F6 06 7D 01 40        test    byte [cs:17Dh],40h
F000:26AD  [+0x026AD]  74 36                    je      short 26E5h
F000:26AF  [+0x026AF]  81 3E 72 04 34 12        cmp     word [472h],1234h
F000:26B5  [+0x026B5]  75 2E                    jne     short 26E5h
F000:26B7  [+0x026B7]  BA CC 03                 mov     dx,3CCh
F000:26BA  [+0x026BA]  EC                       in      al,dx
F000:26BB  [+0x026BB]  A8 01                    test    al,1
F000:26BD  [+0x026BD]  BA D4 03                 mov     dx,3D4h
F000:26C0  [+0x026C0]  75 03                    jne     short 26C5h
F000:26C2  [+0x026C2]  BA B4 03                 mov     dx,3B4h
F000:26C5  [+0x026C5]  B0 18                    mov     al,18h
F000:26C7  [+0x026C7]  E8 CF 29                 call    5099h
F000:26CA  [+0x026CA]  8A E0                    mov     ah,al
F000:26CC  [+0x026CC]  24 0F                    and     al,0Fh
F000:26CE  [+0x026CE]  B1 04                    mov     cl,4
F000:26D0  [+0x026D0]  D2 EC                    shr     ah,cl
F000:26D2  [+0x026D2]  F6 D4                    not     ah
F000:26D4  [+0x026D4]  80 E4 0F                 and     ah,0Fh
F000:26D7  [+0x026D7]  3A E0                    cmp     ah,al
F000:26D9  [+0x026D9]  75 0A                    jne     short 26E5h
F000:26DB  [+0x026DB]  B1 05                    mov     cl,5
F000:26DD  [+0x026DD]  D2 E4                    shl     ah,cl
F000:26DF  [+0x026DF]  32 C0                    xor     al,al
F000:26E1  [+0x026E1]  09 06 72 04              or      [472h],ax
F000:26E5  [+0x026E5]  E8 44 FC                 call    232Ch
F000:26E8  [+0x026E8]  B0 44                    mov     al,44h
F000:26EA  [+0x026EA]  E8 3F F9                 call    202Ch
F000:26ED  [+0x026ED]  80 CC 40                 or      ah,40h
F000:26F0  [+0x026F0]  EF                       out     dx,ax
F000:26F1  [+0x026F1]  BA C2 03                 mov     dx,3C2h
F000:26F4  [+0x026F4]  B0 23                    mov     al,23h
F000:26F6  [+0x026F6]  EE                       out     dx,al
F000:26F7  [+0x026F7]  C6 06 49 04 00           mov     byte [449h],0
F000:26FC  [+0x026FC]  C6 06 87 04 60           mov     byte [487h],60h
F000:2701  [+0x02701]  C6 06 89 04 00           mov     byte [489h],0
F000:2706  [+0x02706]  E8 29 02                 call    2932h
F000:2709  [+0x02709]  E8 75 02                 call    2981h
F000:270C  [+0x0270C]  E8 A8 2B                 call    52B7h
F000:270F  [+0x0270F]  1E                       push    ds
F000:2710  [+0x02710]  B0 0E                    mov     al,0Eh
F000:2712  [+0x02712]  E8 C6 01                 call    28DBh
F000:2715  [+0x02715]  BE 05 00                 mov     si,5
F000:2718  [+0x02718]  BB 80 4C                 mov     bx,4C80h
F000:271B  [+0x0271B]  53                       push    bx
F000:271C  [+0x0271C]  E8 59 03                 call    2A78h
F000:271F  [+0x0271F]  5B                       pop     bx
F000:2720  [+0x02720]  74 07                    je      short 2729h
F000:2722  [+0x02722]  E8 D1 FB                 call    22F6h
F000:2725  [+0x02725]  74 02                    je      short 2729h
F000:2727  [+0x02727]  EB F2                    jmp     short 271Bh
F000:2729  [+0x02729]  E8 93 2B                 call    52BFh
F000:272C  [+0x0272C]  1F                       pop     ds
F000:272D  [+0x0272D]  B8 07 0B                 mov     ax,0B07h
F000:2730  [+0x02730]  F6 06 87 04 02           test    byte [487h],2
F000:2735  [+0x02735]  75 03                    jne     short 273Ah
F000:2737  [+0x02737]  B8 03 09                 mov     ax,903h
F000:273A  [+0x0273A]  88 26 88 04              mov     [488h],ah
F000:273E  [+0x0273E]  32 E4                    xor     ah,ah
F000:2740  [+0x02740]  CD 10                    int     10h
F000:2742  [+0x02742]  E8 CC 02                 call    2A11h
F000:2745  [+0x02745]  80 0E 89 04 10           or      byte [489h],10h
F000:274A  [+0x0274A]  F6 06 89 04 01           test    byte [489h],1
F000:274F  [+0x0274F]  75 2F                    jne     short 2780h
F000:2751  [+0x02751]  A1 10 04                 mov     ax,[410h]
F000:2754  [+0x02754]  50                       push    ax
F000:2755  [+0x02755]  B3 03                    mov     bl,3
F000:2757  [+0x02757]  B8 07 30                 mov     ax,3007h
F000:275A  [+0x0275A]  F6 06 87 04 02           test    byte [487h],2
F000:275F  [+0x0275F]  74 05                    je      short 2766h
F000:2761  [+0x02761]  B8 03 20                 mov     ax,2003h
F000:2764  [+0x02764]  B3 07                    mov     bl,7
F000:2766  [+0x02766]  80 26 10 04 CF           and     byte [410h],0CFh
F000:276B  [+0x0276B]  08 26 10 04              or      [410h],ah
F000:276F  [+0x0276F]  32 E4                    xor     ah,ah
F000:2771  [+0x02771]  CD 42                    int     42h
F000:2773  [+0x02773]  58                       pop     ax
F000:2774  [+0x02774]  A3 10 04                 mov     [410h],ax
F000:2777  [+0x02777]  8A C3                    mov     al,bl
F000:2779  [+0x02779]  32 E4                    xor     ah,ah
F000:277B  [+0x0277B]  CD 10                    int     10h
F000:277D  [+0x0277D]  E8 91 02                 call    2A11h
F000:2780  [+0x02780]  E8 A6 02                 call    2A29h
F000:2783  [+0x02783]  08 06 88 04              or      [488h],al
F000:2787  [+0x02787]  2E F6 06 7D 01 80        test    byte [cs:17Dh],80h
F000:278D  [+0x0278D]  75 53                    jne     short 27E2h
F000:278F  [+0x0278F]  E8 25 2B                 call    52B7h
F000:2792  [+0x02792]  BA C6 03                 mov     dx,3C6h
F000:2795  [+0x02795]  B0 FF                    mov     al,0FFh
F000:2797  [+0x02797]  EE                       out     dx,al
F000:2798  [+0x02798]  BB FF FF                 mov     bx,0FFFFh
F000:279B  [+0x0279B]  BA C8 03                 mov     dx,3C8h
F000:279E  [+0x0279E]  8A C7                    mov     al,bh
F000:27A0  [+0x027A0]  EE                       out     dx,al
F000:27A1  [+0x027A1]  42                       inc     dx
F000:27A2  [+0x027A2]  B9 03 00                 mov     cx,3
F000:27A5  [+0x027A5]  8A C3                    mov     al,bl
F000:27A7  [+0x027A7]  EE                       out     dx,al
F000:27A8  [+0x027A8]  E2 FD                    loop    27A7h
F000:27AA  [+0x027AA]  4A                       dec     dx
F000:27AB  [+0x027AB]  80 EF 01                 sub     bh,1
F000:27AE  [+0x027AE]  73 EE                    jae     short 279Eh
F000:27B0  [+0x027B0]  4A                       dec     dx
F000:27B1  [+0x027B1]  8A C7                    mov     al,bh
F000:27B3  [+0x027B3]  EE                       out     dx,al
F000:27B4  [+0x027B4]  83 C2 02                 add     dx,2
F000:27B7  [+0x027B7]  B9 03 00                 mov     cx,3
F000:27BA  [+0x027BA]  8A E3                    mov     ah,bl
F000:27BC  [+0x027BC]  80 E4 3F                 and     ah,3Fh
F000:27BF  [+0x027BF]  EC                       in      al,dx
F000:27C0  [+0x027C0]  24 3F                    and     al,3Fh
F000:27C2  [+0x027C2]  3A C4                    cmp     al,ah
F000:27C4  [+0x027C4]  E1 F9                    loope   27BFh
F000:27C6  [+0x027C6]  75 10                    jne     short 27D8h
F000:27C8  [+0x027C8]  83 EA 02                 sub     dx,2
F000:27CB  [+0x027CB]  80 EF 01                 sub     bh,1
F000:27CE  [+0x027CE]  73 E1                    jae     short 27B1h
F000:27D0  [+0x027D0]  42                       inc     dx
F000:27D1  [+0x027D1]  80 EB 55                 sub     bl,55h
F000:27D4  [+0x027D4]  73 C8                    jae     short 279Eh
F000:27D6  [+0x027D6]  EB 0A                    jmp     short 27E2h
F000:27D8  [+0x027D8]  B0 03                    mov     al,3
F000:27DA  [+0x027DA]  E8 4F 02                 call    2A2Ch
F000:27DD  [+0x027DD]  C7 46 04 01 00           mov     word [bp+4],1
F000:27E2  [+0x027E2]  B8 07 0B                 mov     ax,0B07h
F000:27E5  [+0x027E5]  F6 06 87 04 02           test    byte [487h],2
F000:27EA  [+0x027EA]  75 03                    jne     short 27EFh
F000:27EC  [+0x027EC]  B8 03 09                 mov     ax,903h
F000:27EF  [+0x027EF]  88 26 88 04              mov     [488h],ah
F000:27F3  [+0x027F3]  32 E4                    xor     ah,ah
F000:27F5  [+0x027F5]  E8 1A 06                 call    2E12h
F000:27F8  [+0x027F8]  BA C6 03                 mov     dx,3C6h
F000:27FB  [+0x027FB]  32 C0                    xor     al,al
F000:27FD  [+0x027FD]  EE                       out     dx,al
F000:27FE  [+0x027FE]  A2 8A 04                 mov     [48Ah],al
F000:2801  [+0x02801]  E8 88 E4                 call    0C8Ch
F000:2804  [+0x02804]  9C                       pushf
F000:2805  [+0x02805]  BA C6 03                 mov     dx,3C6h
F000:2808  [+0x02808]  B0 FF                    mov     al,0FFh
F000:280A  [+0x0280A]  EE                       out     dx,al
F000:280B  [+0x0280B]  B8 07 00                 mov     ax,7
F000:280E  [+0x0280E]  F6 06 87 04 02           test    byte [487h],2
F000:2813  [+0x02813]  75 02                    jne     short 2817h
F000:2815  [+0x02815]  B0 03                    mov     al,3
F000:2817  [+0x02817]  CD 10                    int     10h
F000:2819  [+0x02819]  9D                       popf
F000:281A  [+0x0281A]  74 0A                    je      short 2826h
F000:281C  [+0x0281C]  B0 04                    mov     al,4
F000:281E  [+0x0281E]  E8 0B 02                 call    2A2Ch
F000:2821  [+0x02821]  C7 46 04 01 00           mov     word [bp+4],1
F000:2826  [+0x02826]  B0 0E                    mov     al,0Eh
F000:2828  [+0x02828]  F6 06 87 04 02           test    byte [487h],2
F000:282D  [+0x0282D]  74 02                    je      short 2831h
F000:282F  [+0x0282F]  B0 0F                    mov     al,0Fh
F000:2831  [+0x02831]  E8 A7 00                 call    28DBh
F000:2834  [+0x02834]  E8 1E 02                 call    2A55h
F000:2837  [+0x02837]  75 14                    jne     short 284Dh
F000:2839  [+0x02839]  BE 00 80                 mov     si,8000h
F000:283C  [+0x0283C]  E8 39 02                 call    2A78h
F000:283F  [+0x0283F]  75 0C                    jne     short 284Dh
F000:2841  [+0x02841]  BE 00 10                 mov     si,1000h
F000:2844  [+0x02844]  E8 04 FD                 call    254Bh
F000:2847  [+0x02847]  75 04                    jne     short 284Dh
F000:2849  [+0x02849]  32 D2                    xor     dl,dl
F000:284B  [+0x0284B]  EB 02                    jmp     short 284Fh
F000:284D  [+0x0284D]  B2 03                    mov     dl,3
F000:284F  [+0x0284F]  52                       push    dx
F000:2850  [+0x02850]  B0 03                    mov     al,3
F000:2852  [+0x02852]  F6 06 87 04 02           test    byte [487h],2
F000:2857  [+0x02857]  74 02                    je      short 285Bh
F000:2859  [+0x02859]  B0 07                    mov     al,7
F000:285B  [+0x0285B]  E8 1B 29                 call    5179h
F000:285E  [+0x0285E]  E8 51 29                 call    51B2h
F000:2861  [+0x02861]  5A                       pop     dx
F000:2862  [+0x02862]  BA C4 03                 mov     dx,3C4h
F000:2865  [+0x02865]  B8 00 00                 mov     ax,0
F000:2868  [+0x02868]  EF                       out     dx,ax
F000:2869  [+0x02869]  E3 00                    jcxz    286Bh
F000:286B  [+0x0286B]  E3 00                    jcxz    286Dh
F000:286D  [+0x0286D]  B8 00 03                 mov     ax,300h
F000:2870  [+0x02870]  EF                       out     dx,ax
F000:2871  [+0x02871]  BA D4 03                 mov     dx,3D4h
F000:2874  [+0x02874]  F6 06 87 04 02           test    byte [487h],2
F000:2879  [+0x02879]  74 03                    je      short 287Eh
F000:287B  [+0x0287B]  BA B4 03                 mov     dx,3B4h
F000:287E  [+0x0287E]  B8 01 32                 mov     ax,3201h
F000:2881  [+0x02881]  EF                       out     dx,ax
F000:2882  [+0x02882]  83 C2 06                 add     dx,6
F000:2885  [+0x02885]  E8 29 02                 call    2AB1h
F000:2888  [+0x02888]  75 05                    jne     short 288Fh
F000:288A  [+0x0288A]  E8 3A 02                 call    2AC7h
F000:288D  [+0x0288D]  74 0E                    je      short 289Dh
F000:288F  [+0x0288F]  B0 05                    mov     al,5
F000:2891  [+0x02891]  EB 02                    jmp     short 2895h
F000:2893  [+0x02893]  B0 06                    mov     al,6
F000:2895  [+0x02895]  E8 94 01                 call    2A2Ch
F000:2898  [+0x02898]  C7 46 04 01 00           mov     word [bp+4],1
F000:289D  [+0x0289D]  E8 4A 02                 call    2AEAh
F000:28A0  [+0x028A0]  E8 43 FB                 call    23E6h
F000:28A3  [+0x028A3]  A8 10                    test    al,10h
F000:28A5  [+0x028A5]  74 03                    je      short 28AAh
F000:28A7  [+0x028A7]  E8 5D E8                 call    1107h
F000:28AA  [+0x028AA]  B0 44                    mov     al,44h
F000:28AC  [+0x028AC]  E8 7D F7                 call    202Ch
F000:28AF  [+0x028AF]  80 E4 BF                 and     ah,0BFh
F000:28B2  [+0x028B2]  EF                       out     dx,ax
F000:28B3  [+0x028B3]  E8 2B EA                 call    12E1h
F000:28B6  [+0x028B6]  E8 FE 29                 call    52B7h
F000:28B9  [+0x028B9]  B9 10 00                 mov     cx,10h
F000:28BC  [+0x028BC]  32 C0                    xor     al,al
F000:28BE  [+0x028BE]  E8 0F 28                 call    50D0h
F000:28C1  [+0x028C1]  E8 FB 29                 call    52BFh
F000:28C4  [+0x028C4]  B8 31 5F                 mov     ax,5F31h
F000:28C7  [+0x028C7]  CD 15                    int     15h
F000:28C9  [+0x028C9]  E8 02 FC                 call    24CEh
F000:28CC  [+0x028CC]  8B E5                    mov     sp,bp
F000:28CE  [+0x028CE]  83 C4 02                 add     sp,2
F000:28D1  [+0x028D1]  1F                       pop     ds
F000:28D2  [+0x028D2]  07                       pop     es
F000:28D3  [+0x028D3]  5D                       pop     bp
F000:28D4  [+0x028D4]  5F                       pop     di
F000:28D5  [+0x028D5]  5E                       pop     si
F000:28D6  [+0x028D6]  5A                       pop     dx
F000:28D7  [+0x028D7]  59                       pop     cx
F000:28D8  [+0x028D8]  5B                       pop     bx
F000:28D9  [+0x028D9]  58                       pop     ax
F000:28DA  [+0x028DA]  CB                       retf
F000:28DB  [+0x028DB]  E8 9B 28                 call    5179h
F000:28DE  [+0x028DE]  E8 D1 28                 call    51B2h
F000:28E1  [+0x028E1]  B8 00 A0                 mov     ax,0A000h
F000:28E4  [+0x028E4]  8E C0                    mov     es,ax
F000:28E6  [+0x028E6]  B8 05 08                 mov     ax,805h
F000:28E9  [+0x028E9]  BA CE 03                 mov     dx,3CEh
F000:28EC  [+0x028EC]  EF                       out     dx,ax
F000:28ED  [+0x028ED]  B8 02 0F                 mov     ax,0F02h
F000:28F0  [+0x028F0]  EF                       out     dx,ax
F000:28F1  [+0x028F1]  B8 02 0F                 mov     ax,0F02h
F000:28F4  [+0x028F4]  BA C4 03                 mov     dx,3C4h
F000:28F7  [+0x028F7]  EF                       out     dx,ax
F000:28F8  [+0x028F8]  BE 00 10                 mov     si,1000h
F000:28FB  [+0x028FB]  B0 00                    mov     al,0
F000:28FD  [+0x028FD]  BA C6 03                 mov     dx,3C6h
F000:2900  [+0x02900]  EE                       out     dx,al
F000:2901  [+0x02901]  C3                       ret
F000:2902  [+0x02902]  B0 70                    mov     al,70h
F000:2904  [+0x02904]  E8 25 F7                 call    202Ch
F000:2907  [+0x02907]  80 FC 80                 cmp     ah,80h
F000:290A  [+0x0290A]  74 25                    je      short 2931h
F000:290C  [+0x0290C]  9C                       pushf
F000:290D  [+0x0290D]  FA                       cli
F000:290E  [+0x0290E]  BB E8 46                 mov     bx,46E8h
F000:2911  [+0x02911]  8B D3                    mov     dx,bx
F000:2913  [+0x02913]  B8 16 00                 mov     ax,16h
F000:2916  [+0x02916]  EF                       out     dx,ax
F000:2917  [+0x02917]  BA 02 01                 mov     dx,102h
F000:291A  [+0x0291A]  B8 01 00                 mov     ax,1
F000:291D  [+0x0291D]  EF                       out     dx,ax
F000:291E  [+0x0291E]  B8 0E 00                 mov     ax,0Eh
F000:2921  [+0x02921]  8B D3                    mov     dx,bx
F000:2923  [+0x02923]  EF                       out     dx,ax
F000:2924  [+0x02924]  BA C3 03                 mov     dx,3C3h
F000:2927  [+0x02927]  B0 01                    mov     al,1
F000:2929  [+0x02929]  EE                       out     dx,al
F000:292A  [+0x0292A]  33 C0                    xor     ax,ax
F000:292C  [+0x0292C]  BA E8 4A                 mov     dx,4AE8h
F000:292F  [+0x0292F]  EF                       out     dx,ax
F000:2930  [+0x02930]  9D                       popf
F000:2931  [+0x02931]  C3                       ret
F000:2932  [+0x02932]  FA                       cli
F000:2933  [+0x02933]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:2938  [+0x02938]  BB 00 F0                 mov     bx,0F000h
F000:293B  [+0x0293B]  BF 08 01                 mov     di,108h
F000:293E  [+0x0293E]  B8 65 F0                 mov     ax,0F065h
F000:2941  [+0x02941]  E8 38 00                 call    297Ch
F000:2944  [+0x02944]  8C CB                    mov     bx,cs
F000:2946  [+0x02946]  BF B4 01                 mov     di,1B4h
F000:2949  [+0x02949]  B8 44 2C                 mov     ax,2C44h
F000:294C  [+0x0294C]  E8 2D 00                 call    297Ch
F000:294F  [+0x0294F]  BF 40 00                 mov     di,40h
F000:2952  [+0x02952]  B8 44 2C                 mov     ax,2C44h
F000:2955  [+0x02955]  E8 24 00                 call    297Ch
F000:2958  [+0x02958]  FA                       cli
F000:2959  [+0x02959]  2E 8E 06 77 26           mov     es,[cs:2677h]
F000:295E  [+0x0295E]  C7 06 A8 04 9E 01        mov     word [4A8h],19Eh
F000:2964  [+0x02964]  8C 0E AA 04              mov     [4AAh],cs
F000:2968  [+0x02968]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:296D  [+0x0296D]  BF 7C 00                 mov     di,7Ch
F000:2970  [+0x02970]  B8 54 5A                 mov     ax,5A54h
F000:2973  [+0x02973]  E8 06 00                 call    297Ch
F000:2976  [+0x02976]  BF 0C 01                 mov     di,10Ch
F000:2979  [+0x02979]  B8 54 56                 mov     ax,5654h
F000:297C  [+0x0297C]  AB                       stosw
F000:297D  [+0x0297D]  8B C3                    mov     ax,bx
F000:297F  [+0x0297F]  AB                       stosw
F000:2980  [+0x02980]  C3                       ret
F000:2981  [+0x02981]  50                       push    ax
F000:2982  [+0x02982]  2E F6 06 7F 01 10        test    byte [cs:17Fh],10h
F000:2988  [+0x02988]  75 16                    jne     short 29A0h
F000:298A  [+0x0298A]  BA B4 03                 mov     dx,3B4h
F000:298D  [+0x0298D]  E8 54 00                 call    29E4h
F000:2990  [+0x02990]  74 3F                    je      short 29D1h
F000:2992  [+0x02992]  BA C2 03                 mov     dx,3C2h
F000:2995  [+0x02995]  B0 A6                    mov     al,0A6h
F000:2997  [+0x02997]  EE                       out     dx,al
F000:2998  [+0x02998]  BA D4 03                 mov     dx,3D4h
F000:299B  [+0x0299B]  E8 46 00                 call    29E4h
F000:299E  [+0x0299E]  74 1E                    je      short 29BEh
F000:29A0  [+0x029A0]  BA C2 03                 mov     dx,3C2h
F000:29A3  [+0x029A3]  B0 23                    mov     al,23h
F000:29A5  [+0x029A5]  EE                       out     dx,al
F000:29A6  [+0x029A6]  BA D4 03                 mov     dx,3D4h
F000:29A9  [+0x029A9]  89 16 63 04              mov     [463h],dx
F000:29AD  [+0x029AD]  80 26 10 04 CF           and     byte [410h],0CFh
F000:29B2  [+0x029B2]  80 0E 10 04 20           or      byte [410h],20h
F000:29B7  [+0x029B7]  80 0E 89 04 01           or      byte [489h],1
F000:29BC  [+0x029BC]  58                       pop     ax
F000:29BD  [+0x029BD]  C3                       ret
F000:29BE  [+0x029BE]  80 0E 87 04 02           or      byte [487h],2
F000:29C3  [+0x029C3]  80 0E 10 04 30           or      byte [410h],30h
F000:29C8  [+0x029C8]  BA B4 03                 mov     dx,3B4h
F000:29CB  [+0x029CB]  89 16 63 04              mov     [463h],dx
F000:29CF  [+0x029CF]  58                       pop     ax
F000:29D0  [+0x029D0]  C3                       ret
F000:29D1  [+0x029D1]  80 26 10 04 CF           and     byte [410h],0CFh
F000:29D6  [+0x029D6]  80 0E 10 04 20           or      byte [410h],20h
F000:29DB  [+0x029DB]  BA D4 03                 mov     dx,3D4h
F000:29DE  [+0x029DE]  89 16 63 04              mov     [463h],dx
F000:29E2  [+0x029E2]  58                       pop     ax
F000:29E3  [+0x029E3]  C3                       ret
F000:29E4  [+0x029E4]  B3 FF                    mov     bl,0FFh
F000:29E6  [+0x029E6]  8A FB                    mov     bh,bl
F000:29E8  [+0x029E8]  80 E7 0F                 and     bh,0Fh
F000:29EB  [+0x029EB]  B0 0E                    mov     al,0Eh
F000:29ED  [+0x029ED]  8A E3                    mov     ah,bl
F000:29EF  [+0x029EF]  EF                       out     dx,ax
F000:29F0  [+0x029F0]  FE C0                    inc     al
F000:29F2  [+0x029F2]  EF                       out     dx,ax
F000:29F3  [+0x029F3]  B0 0E                    mov     al,0Eh
F000:29F5  [+0x029F5]  E8 92 26                 call    508Ah
F000:29F8  [+0x029F8]  80 E4 0F                 and     ah,0Fh
F000:29FB  [+0x029FB]  3A E7                    cmp     ah,bh
F000:29FD  [+0x029FD]  75 11                    jne     short 2A10h
F000:29FF  [+0x029FF]  E8 88 26                 call    508Ah
F000:2A02  [+0x02A02]  80 E4 0F                 and     ah,0Fh
F000:2A05  [+0x02A05]  3A E7                    cmp     ah,bh
F000:2A07  [+0x02A07]  75 07                    jne     short 2A10h
F000:2A09  [+0x02A09]  80 EB 55                 sub     bl,55h
F000:2A0C  [+0x02A0C]  73 D8                    jae     short 29E6h
F000:2A0E  [+0x02A0E]  32 DB                    xor     bl,bl
F000:2A10  [+0x02A10]  C3                       ret
F000:2A11  [+0x02A11]  E8 A2 26                 call    50B6h
F000:2A14  [+0x02A14]  52                       push    dx
F000:2A15  [+0x02A15]  BA D8 03                 mov     dx,3D8h
F000:2A18  [+0x02A18]  32 C0                    xor     al,al
F000:2A1A  [+0x02A1A]  F6 06 87 04 02           test    byte [487h],2
F000:2A1F  [+0x02A1F]  75 05                    jne     short 2A26h
F000:2A21  [+0x02A21]  BA B8 03                 mov     dx,3B8h
F000:2A24  [+0x02A24]  FE C0                    inc     al
F000:2A26  [+0x02A26]  EE                       out     dx,al
F000:2A27  [+0x02A27]  5A                       pop     dx
F000:2A28  [+0x02A28]  C3                       ret
F000:2A29  [+0x02A29]  B0 00                    mov     al,0
F000:2A2B  [+0x02A2B]  C3                       ret
F000:2A2C  [+0x02A2C]  50                       push    ax
F000:2A2D  [+0x02A2D]  53                       push    bx
F000:2A2E  [+0x02A2E]  51                       push    cx
F000:2A2F  [+0x02A2F]  52                       push    dx
F000:2A30  [+0x02A30]  50                       push    ax
F000:2A31  [+0x02A31]  B9 CC 06                 mov     cx,6CCh
F000:2A34  [+0x02A34]  B0 03                    mov     al,3
F000:2A36  [+0x02A36]  E8 97 26                 call    50D0h
F000:2A39  [+0x02A39]  58                       pop     ax
F000:2A3A  [+0x02A3A]  50                       push    ax
F000:2A3B  [+0x02A3B]  B9 2C 01                 mov     cx,12Ch
F000:2A3E  [+0x02A3E]  B0 00                    mov     al,0
F000:2A40  [+0x02A40]  E8 8D 26                 call    50D0h
F000:2A43  [+0x02A43]  B9 44 02                 mov     cx,244h
F000:2A46  [+0x02A46]  B0 02                    mov     al,2
F000:2A48  [+0x02A48]  E8 85 26                 call    50D0h
F000:2A4B  [+0x02A4B]  58                       pop     ax
F000:2A4C  [+0x02A4C]  FE C8                    dec     al
F000:2A4E  [+0x02A4E]  75 EA                    jne     short 2A3Ah
F000:2A50  [+0x02A50]  5A                       pop     dx
F000:2A51  [+0x02A51]  59                       pop     cx
F000:2A52  [+0x02A52]  5B                       pop     bx
F000:2A53  [+0x02A53]  58                       pop     ax
F000:2A54  [+0x02A54]  C3                       ret
F000:2A55  [+0x02A55]  33 FF                    xor     di,di
F000:2A57  [+0x02A57]  BA CE 03                 mov     dx,3CEh
F000:2A5A  [+0x02A5A]  BB FF 00                 mov     bx,0FFh
F000:2A5D  [+0x02A5D]  26 88 1D                 mov     [es:di],bl
F000:2A60  [+0x02A60]  B0 02                    mov     al,2
F000:2A62  [+0x02A62]  8A E7                    mov     ah,bh
F000:2A64  [+0x02A64]  EF                       out     dx,ax
F000:2A65  [+0x02A65]  26 3A 3D                 cmp     bh,[es:di]
F000:2A68  [+0x02A68]  75 0B                    jne     short 2A75h
F000:2A6A  [+0x02A6A]  B0 02                    mov     al,2
F000:2A6C  [+0x02A6C]  8A E3                    mov     ah,bl
F000:2A6E  [+0x02A6E]  EF                       out     dx,ax
F000:2A6F  [+0x02A6F]  26 3A 1D                 cmp     bl,[es:di]
F000:2A72  [+0x02A72]  75 01                    jne     short 2A75h
F000:2A74  [+0x02A74]  C3                       ret
F000:2A75  [+0x02A75]  0A DB                    or      bl,bl
F000:2A77  [+0x02A77]  C3                       ret
F000:2A78  [+0x02A78]  52                       push    dx
F000:2A79  [+0x02A79]  32 DB                    xor     bl,bl
F000:2A7B  [+0x02A7B]  2E F6 06 7F 01 08        test    byte [cs:17Fh],8
F000:2A81  [+0x02A81]  75 02                    jne     short 2A85h
F000:2A83  [+0x02A83]  FE CB                    dec     bl
F000:2A85  [+0x02A85]  B0 02                    mov     al,2
F000:2A87  [+0x02A87]  8A E3                    mov     ah,bl
F000:2A89  [+0x02A89]  BA CE 03                 mov     dx,3CEh
F000:2A8C  [+0x02A8C]  EF                       out     dx,ax
F000:2A8D  [+0x02A8D]  33 FF                    xor     di,di
F000:2A8F  [+0x02A8F]  8A C3                    mov     al,bl
F000:2A91  [+0x02A91]  8B CE                    mov     cx,si
F000:2A93  [+0x02A93]  F3 AA                    rep stosb
F000:2A95  [+0x02A95]  8B CE                    mov     cx,si
F000:2A97  [+0x02A97]  F3 AA                    rep stosb
F000:2A99  [+0x02A99]  33 FF                    xor     di,di
F000:2A9B  [+0x02A9B]  8B CE                    mov     cx,si
F000:2A9D  [+0x02A9D]  B0 FF                    mov     al,0FFh
F000:2A9F  [+0x02A9F]  F3 AE                    repe scasb
F000:2AA1  [+0x02AA1]  75 0C                    jne     short 2AAFh
F000:2AA3  [+0x02AA3]  8B CE                    mov     cx,si
F000:2AA5  [+0x02AA5]  F3 AE                    repe scasb
F000:2AA7  [+0x02AA7]  75 06                    jne     short 2AAFh
F000:2AA9  [+0x02AA9]  FE C3                    inc     bl
F000:2AAB  [+0x02AAB]  74 D8                    je      short 2A85h
F000:2AAD  [+0x02AAD]  3A C0                    cmp     al,al
F000:2AAF  [+0x02AAF]  5A                       pop     dx
F000:2AB0  [+0x02AB0]  C3                       ret
F000:2AB1  [+0x02AB1]  33 C9                    xor     cx,cx
F000:2AB3  [+0x02AB3]  EC                       in      al,dx
F000:2AB4  [+0x02AB4]  A8 01                    test    al,1
F000:2AB6  [+0x02AB6]  E1 FB                    loope   2AB3h
F000:2AB8  [+0x02AB8]  E3 0A                    jcxz    2AC4h
F000:2ABA  [+0x02ABA]  33 C9                    xor     cx,cx
F000:2ABC  [+0x02ABC]  EC                       in      al,dx
F000:2ABD  [+0x02ABD]  A8 01                    test    al,1
F000:2ABF  [+0x02ABF]  E0 FB                    loopne  2ABCh
F000:2AC1  [+0x02AC1]  E3 01                    jcxz    2AC4h
F000:2AC3  [+0x02AC3]  C3                       ret
F000:2AC4  [+0x02AC4]  0C FF                    or      al,0FFh
F000:2AC6  [+0x02AC6]  C3                       ret
F000:2AC7  [+0x02AC7]  B4 09                    mov     ah,9
F000:2AC9  [+0x02AC9]  33 C9                    xor     cx,cx
F000:2ACB  [+0x02ACB]  EC                       in      al,dx
F000:2ACC  [+0x02ACC]  A8 08                    test    al,8
F000:2ACE  [+0x02ACE]  E1 FB                    loope   2ACBh
F000:2AD0  [+0x02AD0]  75 06                    jne     short 2AD8h
F000:2AD2  [+0x02AD2]  FE CC                    dec     ah
F000:2AD4  [+0x02AD4]  75 F5                    jne     short 2ACBh
F000:2AD6  [+0x02AD6]  EB 0F                    jmp     short 2AE7h
F000:2AD8  [+0x02AD8]  B4 02                    mov     ah,2
F000:2ADA  [+0x02ADA]  33 C9                    xor     cx,cx
F000:2ADC  [+0x02ADC]  EC                       in      al,dx
F000:2ADD  [+0x02ADD]  A8 08                    test    al,8
F000:2ADF  [+0x02ADF]  E0 FB                    loopne  2ADCh
F000:2AE1  [+0x02AE1]  74 06                    je      short 2AE9h
F000:2AE3  [+0x02AE3]  FE CC                    dec     ah
F000:2AE5  [+0x02AE5]  75 F5                    jne     short 2ADCh
F000:2AE7  [+0x02AE7]  0C FF                    or      al,0FFh
F000:2AE9  [+0x02AE9]  C3                       ret
F000:2AEA  [+0x02AEA]  F6 06 89 04 01           test    byte [489h],1
F000:2AEF  [+0x02AEF]  75 28                    jne     short 2B19h
F000:2AF1  [+0x02AF1]  A1 10 04                 mov     ax,[410h]
F000:2AF4  [+0x02AF4]  50                       push    ax
F000:2AF5  [+0x02AF5]  B3 03                    mov     bl,3
F000:2AF7  [+0x02AF7]  B8 07 30                 mov     ax,3007h
F000:2AFA  [+0x02AFA]  F6 06 87 04 02           test    byte [487h],2
F000:2AFF  [+0x02AFF]  74 05                    je      short 2B06h
F000:2B01  [+0x02B01]  B8 03 20                 mov     ax,2003h
F000:2B04  [+0x02B04]  B3 07                    mov     bl,7
F000:2B06  [+0x02B06]  80 26 10 04 CF           and     byte [410h],0CFh
F000:2B0B  [+0x02B0B]  08 26 10 04              or      [410h],ah
F000:2B0F  [+0x02B0F]  32 E4                    xor     ah,ah
F000:2B11  [+0x02B11]  CD 42                    int     42h
F000:2B13  [+0x02B13]  58                       pop     ax
F000:2B14  [+0x02B14]  A3 10 04                 mov     [410h],ax
F000:2B17  [+0x02B17]  EB 1A                    jmp     short 2B33h
F000:2B19  [+0x02B19]  F6 06 89 04 04           test    byte [489h],4
F000:2B1E  [+0x02B1E]  75 0E                    jne     short 2B2Eh
F000:2B20  [+0x02B20]  F6 06 87 04 08           test    byte [487h],8
F000:2B25  [+0x02B25]  75 07                    jne     short 2B2Eh
F000:2B27  [+0x02B27]  80 26 87 04 FD           and     byte [487h],0FDh
F000:2B2C  [+0x02B2C]  EB 05                    jmp     short 2B33h
F000:2B2E  [+0x02B2E]  80 0E 87 04 02           or      byte [487h],2
F000:2B33  [+0x02B33]  E8 85 00                 call    2BBBh
F000:2B36  [+0x02B36]  B8 09 20                 mov     ax,2009h
F000:2B39  [+0x02B39]  B3 03                    mov     bl,3
F000:2B3B  [+0x02B3B]  F6 06 87 04 02           test    byte [487h],2
F000:2B40  [+0x02B40]  74 05                    je      short 2B47h
F000:2B42  [+0x02B42]  B8 0B 30                 mov     ax,300Bh
F000:2B45  [+0x02B45]  B3 07                    mov     bl,7
F000:2B47  [+0x02B47]  80 26 88 04 F0           and     byte [488h],0F0h
F000:2B4C  [+0x02B4C]  08 06 88 04              or      [488h],al
F000:2B50  [+0x02B50]  80 26 10 04 CF           and     byte [410h],0CFh
F000:2B55  [+0x02B55]  08 26 10 04              or      [410h],ah
F000:2B59  [+0x02B59]  A0 87 04                 mov     al,[487h]
F000:2B5C  [+0x02B5C]  24 08                    and     al,8
F000:2B5E  [+0x02B5E]  80 26 87 04 F7           and     byte [487h],0F7h
F000:2B63  [+0x02B63]  8A 26 89 04              mov     ah,[489h]
F000:2B67  [+0x02B67]  80 E4 01                 and     ah,1
F000:2B6A  [+0x02B6A]  80 26 89 04 FE           and     byte [489h],0FEh
F000:2B6F  [+0x02B6F]  50                       push    ax
F000:2B70  [+0x02B70]  32 E4                    xor     ah,ah
F000:2B72  [+0x02B72]  8A C3                    mov     al,bl
F000:2B74  [+0x02B74]  CD 10                    int     10h
F000:2B76  [+0x02B76]  58                       pop     ax
F000:2B77  [+0x02B77]  08 26 89 04              or      [489h],ah
F000:2B7B  [+0x02B7B]  E8 27 F9                 call    24A5h
F000:2B7E  [+0x02B7E]  F6 C4 01                 test    ah,1
F000:2B81  [+0x02B81]  75 33                    jne     short 2BB6h
F000:2B83  [+0x02B83]  A8 08                    test    al,8
F000:2B85  [+0x02B85]  74 2F                    je      short 2BB6h
F000:2B87  [+0x02B87]  50                       push    ax
F000:2B88  [+0x02B88]  B8 03 30                 mov     ax,3003h
F000:2B8B  [+0x02B8B]  B3 07                    mov     bl,7
F000:2B8D  [+0x02B8D]  F6 06 87 04 02           test    byte [487h],2
F000:2B92  [+0x02B92]  74 05                    je      short 2B99h
F000:2B94  [+0x02B94]  B8 05 20                 mov     ax,2005h
F000:2B97  [+0x02B97]  B3 03                    mov     bl,3
F000:2B99  [+0x02B99]  80 26 88 04 F0           and     byte [488h],0F0h
F000:2B9E  [+0x02B9E]  08 06 88 04              or      [488h],al
F000:2BA2  [+0x02BA2]  80 26 10 04 CF           and     byte [410h],0CFh
F000:2BA7  [+0x02BA7]  08 26 10 04              or      [410h],ah
F000:2BAB  [+0x02BAB]  58                       pop     ax
F000:2BAC  [+0x02BAC]  08 06 87 04              or      [487h],al
F000:2BB0  [+0x02BB0]  32 E4                    xor     ah,ah
F000:2BB2  [+0x02BB2]  8A C3                    mov     al,bl
F000:2BB4  [+0x02BB4]  CD 10                    int     10h
F000:2BB6  [+0x02BB6]  C3                       ret
F000:2BB7  [+0x02BB7]  0C 0B                    or      al,0Bh
F000:2BB9  [+0x02BB9]  0E                       push    cs
F000:2BBA  [+0x02BBA]  0D A0 87                 or      ax,87A0h
F000:2BBD  [+0x02BBD]  04 24                    add     al,24h
F000:2BBF  [+0x02BBF]  02 8A 26 89              add     cl,[bp+si-76DAh]
F000:2BC3  [+0x02BC3]  04 80                    add     al,80h
F000:2BC5  [+0x02BC5]  E4 01                    in      al,1
F000:2BC7  [+0x02BC7]  0A C4                    or      al,ah
F000:2BC9  [+0x02BC9]  32 E4                    xor     ah,ah
F000:2BCB  [+0x02BCB]  8B D8                    mov     bx,ax
F000:2BCD  [+0x02BCD]  2E 8A 87 B7 2B           mov     al,[cs:bx+2BB7h]
F000:2BD2  [+0x02BD2]  A2 8A 04                 mov     [48Ah],al
F000:2BD5  [+0x02BD5]  3C 0E                    cmp     al,0Eh
F000:2BD7  [+0x02BD7]  75 25                    jne     short 2BFEh
F000:2BD9  [+0x02BD9]  1E                       push    ds
F000:2BDA  [+0x02BDA]  B8 00 C6                 mov     ax,0C600h
F000:2BDD  [+0x02BDD]  8E D8                    mov     ds,ax
F000:2BDF  [+0x02BDF]  8A 26 D4 03              mov     ah,[3D4h]
F000:2BE3  [+0x02BE3]  C6 06 D4 03 28           mov     byte [3D4h],28h
F000:2BE8  [+0x02BE8]  EB 00                    jmp     short 2BEAh
F000:2BEA  [+0x02BEA]  BA D4 03                 mov     dx,3D4h
F000:2BED  [+0x02BED]  EC                       in      al,dx
F000:2BEE  [+0x02BEE]  EB 00                    jmp     short 2BF0h
F000:2BF0  [+0x02BF0]  88 26 D4 03              mov     [3D4h],ah
F000:2BF4  [+0x02BF4]  1F                       pop     ds
F000:2BF5  [+0x02BF5]  3C 28                    cmp     al,28h
F000:2BF7  [+0x02BF7]  75 05                    jne     short 2BFEh
F000:2BF9  [+0x02BF9]  C6 06 8A 04 0F           mov     byte [48Ah],0Fh
F000:2BFE  [+0x02BFE]  C3                       ret
F000:2BFF  [+0x02BFF]  32 C0                    xor     al,al
F000:2C01  [+0x02C01]  C3                       ret
F000:2C02  [+0x02C02]  50                       push    ax
F000:2C03  [+0x02C03]  33 C0                    xor     ax,ax
F000:2C05  [+0x02C05]  58                       pop     ax
F000:2C06  [+0x02C06]  C3                       ret
F000:2C07  [+0x02C07]  00 BE 2C E8              add     [bp-17D4h],bh
F000:2C0B  [+0x02C0B]  32 98 33 CC              xor     bl,[bx+si-33CDh]
F000:2C0F  [+0x02C0F]  33 E1                    xor     sp,cx
F000:2C11  [+0x02C11]  33 00                    xor     ax,[bx+si]
F000:2C13  [+0x02C13]  34 3E                    xor     al,3Eh
F000:2C15  [+0x02C15]  34 92                    xor     al,92h
F000:2C17  [+0x02C17]  34 42                    xor     al,42h
F000:2C19  [+0x02C19]  39 C2                    cmp     dx,ax
F000:2C1B  [+0x02C1B]  3B 56 3C                 cmp     dx,[bp+3Ch]
F000:2C1E  [+0x02C1E]  A4                       movsb
F000:2C1F  [+0x02C1F]  3E F4                    hlt
F000:2C21  [+0x02C21]  3F                       aas
F000:2C22  [+0x02C22]  C0 40 84 41              rol     byte [bx+si-7Ch],41h
F000:2C26  [+0x02C26]  50                       push    ax
F000:2C27  [+0x02C27]  42                       inc     dx
F000:2C28  [+0x02C28]  A2 42 F2                 mov     [0F242h],al
F000:2C2B  [+0x02C2B]  44                       inc     sp
F000:2C2C  [+0x02C2C]  28 47 EE                 sub     [bx-12h],al
F000:2C2F  [+0x02C2F]  49                       dec     cx
F000:2C30  [+0x02C30]  B5 2C                    mov     ch,2Ch
F000:2C32  [+0x02C32]  B5 2C                    mov     ch,2Ch
F000:2C34  [+0x02C34]  B5 2C                    mov     ch,2Ch
F000:2C36  [+0x02C36]  B5 2C                    mov     ch,2Ch
F000:2C38  [+0x02C38]  B5 2C                    mov     ch,2Ch
F000:2C3A  [+0x02C3A]  B5 2C                    mov     ch,2Ch
F000:2C3C  [+0x02C3C]  A7                       cmpsw
F000:2C3D  [+0x02C3D]  4A                       dec     dx
F000:2C3E  [+0x02C3E]  84 4B 02                 test    [bp+di+2],cl
F000:2C41  [+0x02C41]  4D                       dec     bp
F000:2C42  [+0x02C42]  90                       nop
F000:2C43  [+0x02C43]  90                       nop
F000:2C44  [+0x02C44]  FB                       sti
F000:2C45  [+0x02C45]  FC                       cld
F000:2C46  [+0x02C46]  80 FC 0E                 cmp     ah,0Eh
F000:2C49  [+0x02C49]  74 39                    je      short 2C84h
F000:2C4B  [+0x02C4B]  80 FC 0C                 cmp     ah,0Ch
F000:2C4E  [+0x02C4E]  74 38                    je      short 2C88h
F000:2C50  [+0x02C50]  80 FC 0D                 cmp     ah,0Dh
F000:2C53  [+0x02C53]  74 37                    je      short 2C8Ch
F000:2C55  [+0x02C55]  50                       push    ax
F000:2C56  [+0x02C56]  53                       push    bx
F000:2C57  [+0x02C57]  51                       push    cx
F000:2C58  [+0x02C58]  52                       push    dx
F000:2C59  [+0x02C59]  56                       push    si
F000:2C5A  [+0x02C5A]  57                       push    di
F000:2C5B  [+0x02C5B]  55                       push    bp
F000:2C5C  [+0x02C5C]  06                       push    es
F000:2C5D  [+0x02C5D]  1E                       push    ds
F000:2C5E  [+0x02C5E]  8B EC                    mov     bp,sp
F000:2C60  [+0x02C60]  2E 8E 1E 77 26           mov     ds,[cs:2677h]
F000:2C65  [+0x02C65]  8B F0                    mov     si,ax
F000:2C67  [+0x02C67]  8A C4                    mov     al,ah
F000:2C69  [+0x02C69]  32 E4                    xor     ah,ah
F000:2C6B  [+0x02C6B]  3C 1D                    cmp     al,1Dh
F000:2C6D  [+0x02C6D]  73 20                    jae     short 2C8Fh
F000:2C6F  [+0x02C6F]  D1 E0                    shl     ax,1
F000:2C71  [+0x02C71]  96                       xchg    si,ax
F000:2C72  [+0x02C72]  2E FF 94 08 2C           call    word [cs:si+2C08h]
F000:2C77  [+0x02C77]  1F                       pop     ds
F000:2C78  [+0x02C78]  07                       pop     es
F000:2C79  [+0x02C79]  5D                       pop     bp
F000:2C7A  [+0x02C7A]  5F                       pop     di
F000:2C7B  [+0x02C7B]  5E                       pop     si
F000:2C7C  [+0x02C7C]  5A                       pop     dx
F000:2C7D  [+0x02C7D]  59                       pop     cx
F000:2C7E  [+0x02C7E]  5B                       pop     bx
F000:2C7F  [+0x02C7F]  58                       pop     ax
F000:2C80  [+0x02C80]  CF                       iret
F000:2C81  [+0x02C81]  87 DB                    xchg    bx,bx
F000:2C83  [+0x02C83]  90                       nop
F000:2C84  [+0x02C84]  E9 FD 14                 jmp     4184h
F000:2C87  [+0x02C87]  90                       nop
F000:2C88  [+0x02C88]  E9 69 13                 jmp     3FF4h
F000:2C8B  [+0x02C8B]  90                       nop
F000:2C8C  [+0x02C8C]  E9 31 14                 jmp     40C0h
F000:2C8F  [+0x02C8F]  8B C6                    mov     ax,si
F000:2C91  [+0x02C91]  E8 D6 F3                 call    206Ah
F000:2C94  [+0x02C94]  83 7E 10 5F              cmp     word [bp+10h],5Fh
F000:2C98  [+0x02C98]  72 09                    jb      short 2CA3h
F000:2C9A  [+0x02C9A]  81 7E 10 5F 01           cmp     word [bp+10h],15Fh
F000:2C9F  [+0x02C9F]  77 02                    ja      short 2CA3h
F000:2CA1  [+0x02CA1]  EB D4                    jmp     short 2C77h
F000:2CA3  [+0x02CA3]  8B 46 10                 mov     ax,[bp+10h]
F000:2CA6  [+0x02CA6]  8E 5E 00                 mov     ds,[bp]
F000:2CA9  [+0x02CA9]  55                       push    bp
F000:2CAA  [+0x02CAA]  8B 6E 04                 mov     bp,[bp+4]
F000:2CAD  [+0x02CAD]  CD 42                    int     42h
F000:2CAF  [+0x02CAF]  5D                       pop     bp
F000:2CB0  [+0x02CB0]  89 46 10                 mov     [bp+10h],ax
F000:2CB3  [+0x02CB3]  EB C2                    jmp     short 2C77h
F000:2CB5  [+0x02CB5]  C3                       ret
F000:2CB6  [+0x02CB6]  2C 28                    sub     al,28h
F000:2CB8  [+0x02CB8]  2D 29 2A                 sub     ax,2A29h
F000:2CBB  [+0x02CBB]  2E 1E                    push    ds
F000:2CBD  [+0x02CBD]  29 50 8A                 sub     [bx+si-76h],dx
F000:2CC0  [+0x02CC0]  C8 24 70 3C              enter   7024h,3Ch
F000:2CC4  [+0x02CC4]  20 B4 00 75              and     [si+7500h],dh
F000:2CC8  [+0x02CC8]  02 B4 03 B0              add     dh,[si-4FFDh]
F000:2CCC  [+0x02CCC]  0C BA                    or      al,0BAh
F000:2CCE  [+0x02CCE]  D6                       salc
F000:2CCF  [+0x02CCF]  03 EF                    add     bp,di
F000:2CD1  [+0x02CD1]  B8 38 5F                 mov     ax,5F38h
F000:2CD4  [+0x02CD4]  E8 B5 01                 call    2E8Ch
F000:2CD7  [+0x02CD7]  58                       pop     ax
F000:2CD8  [+0x02CD8]  1E                       push    ds
F000:2CD9  [+0x02CD9]  E8 78 00                 call    2D54h
F000:2CDC  [+0x02CDC]  1F                       pop     ds
F000:2CDD  [+0x02CDD]  8B 1E 4A 04              mov     bx,[44Ah]
F000:2CE1  [+0x02CE1]  8A FB                    mov     bh,bl
F000:2CE3  [+0x02CE3]  8A 1E 49 04              mov     bl,[449h]
F000:2CE7  [+0x02CE7]  8A 2E 62 04              mov     ch,[462h]
F000:2CEB  [+0x02CEB]  BA D6 03                 mov     dx,3D6h
F000:2CEE  [+0x02CEE]  B0 2B                    mov     al,2Bh
F000:2CF0  [+0x02CF0]  8A E3                    mov     ah,bl
F000:2CF2  [+0x02CF2]  EF                       out     dx,ax
F000:2CF3  [+0x02CF3]  53                       push    bx
F000:2CF4  [+0x02CF4]  80 E3 7F                 and     bl,7Fh
F000:2CF7  [+0x02CF7]  B0 05                    mov     al,5
F000:2CF9  [+0x02CF9]  E8 30 F3                 call    202Ch
F000:2CFC  [+0x02CFC]  80 E4 FE                 and     ah,0FEh
F000:2CFF  [+0x02CFF]  80 FB 7E                 cmp     bl,7Eh
F000:2D02  [+0x02D02]  74 1E                    je      short 2D22h
F000:2D04  [+0x02D04]  80 FB 34                 cmp     bl,34h
F000:2D07  [+0x02D07]  74 19                    je      short 2D22h
F000:2D09  [+0x02D09]  80 FB 50                 cmp     bl,50h
F000:2D0C  [+0x02D0C]  74 17                    je      short 2D25h
F000:2D0E  [+0x02D0E]  80 FB 76                 cmp     bl,76h
F000:2D11  [+0x02D11]  77 12                    ja      short 2D25h
F000:2D13  [+0x02D13]  80 FB 6A                 cmp     bl,6Ah
F000:2D16  [+0x02D16]  73 0A                    jae     short 2D22h
F000:2D18  [+0x02D18]  80 FB 0E                 cmp     bl,0Eh
F000:2D1B  [+0x02D1B]  72 08                    jb      short 2D25h
F000:2D1D  [+0x02D1D]  80 FB 12                 cmp     bl,12h
F000:2D20  [+0x02D20]  77 03                    ja      short 2D25h
F000:2D22  [+0x02D22]  80 CC 01                 or      ah,1
F000:2D25  [+0x02D25]  EF                       out     dx,ax
F000:2D26  [+0x02D26]  8A E3                    mov     ah,bl
F000:2D28  [+0x02D28]  80 E3 70                 and     bl,70h
F000:2D2B  [+0x02D2B]  8A C4                    mov     al,ah
F000:2D2D  [+0x02D2D]  B4 00                    mov     ah,0
F000:2D2F  [+0x02D2F]  80 FB 20                 cmp     bl,20h
F000:2D32  [+0x02D32]  B0 FF                    mov     al,0FFh
F000:2D34  [+0x02D34]  75 04                    jne     short 2D3Ah
F000:2D36  [+0x02D36]  B4 03                    mov     ah,3
F000:2D38  [+0x02D38]  B0 0F                    mov     al,0Fh
F000:2D3A  [+0x02D3A]  BA C6 03                 mov     dx,3C6h
F000:2D3D  [+0x02D3D]  EE                       out     dx,al
F000:2D3E  [+0x02D3E]  B0 0C                    mov     al,0Ch
F000:2D40  [+0x02D40]  BA D6 03                 mov     dx,3D6h
F000:2D43  [+0x02D43]  EF                       out     dx,ax
F000:2D44  [+0x02D44]  5B                       pop     bx
F000:2D45  [+0x02D45]  B8 33 5F                 mov     ax,5F33h
F000:2D48  [+0x02D48]  E8 41 01                 call    2E8Ch
F000:2D4B  [+0x02D4B]  B9 00 01                 mov     cx,100h
F000:2D4E  [+0x02D4E]  32 C0                    xor     al,al
F000:2D50  [+0x02D50]  E8 7D 23                 call    50D0h
F000:2D53  [+0x02D53]  C3                       ret
F000:2D54  [+0x02D54]  24 7F                    and     al,7Fh
F000:2D56  [+0x02D56]  3C 13                    cmp     al,13h
F000:2D58  [+0x02D58]  76 0B                    jbe     short 2D65h
F000:2D5A  [+0x02D5A]  E8 85 EA                 call    17E2h
F000:2D5D  [+0x02D5D]  75 05                    jne     short 2D64h
F000:2D5F  [+0x02D5F]  E8 F6 EA                 call    1858h
F000:2D62  [+0x02D62]  74 01                    je      short 2D65h
F000:2D64  [+0x02D64]  C3                       ret
F000:2D65  [+0x02D65]  F6 06 89 04 01           test    byte [489h],1
F000:2D6A  [+0x02D6A]  74 0B                    je      short 2D77h
F000:2D6C  [+0x02D6C]  3C 07                    cmp     al,7
F000:2D6E  [+0x02D6E]  76 04                    jbe     short 2D74h
F000:2D70  [+0x02D70]  3C 0D                    cmp     al,0Dh
F000:2D72  [+0x02D72]  72 F0                    jb      short 2D64h
F000:2D74  [+0x02D74]  E8 66 01                 call    2EDDh
F000:2D77  [+0x02D77]  8A 26 10 04              mov     ah,[410h]
F000:2D7B  [+0x02D7B]  80 E4 30                 and     ah,30h
F000:2D7E  [+0x02D7E]  80 FC 30                 cmp     ah,30h
F000:2D81  [+0x02D81]  75 10                    jne     short 2D93h
F000:2D83  [+0x02D83]  F6 06 87 04 02           test    byte [487h],2
F000:2D88  [+0x02D88]  75 31                    jne     short 2DBBh
F000:2D8A  [+0x02D8A]  80 0E 87 04 08           or      byte [487h],8
F000:2D8F  [+0x02D8F]  B0 0E                    mov     al,0Eh
F000:2D91  [+0x02D91]  EB 1A                    jmp     short 2DADh
F000:2D93  [+0x02D93]  F6 06 87 04 02           test    byte [487h],2
F000:2D98  [+0x02D98]  74 43                    je      short 2DDDh
F000:2D9A  [+0x02D9A]  B4 08                    mov     ah,8
F000:2D9C  [+0x02D9C]  3C 02                    cmp     al,2
F000:2D9E  [+0x02D9E]  72 07                    jb      short 2DA7h
F000:2DA0  [+0x02DA0]  3C 04                    cmp     al,4
F000:2DA2  [+0x02DA2]  73 03                    jae     short 2DA7h
F000:2DA4  [+0x02DA4]  80 CC 04                 or      ah,4
F000:2DA7  [+0x02DA7]  08 26 87 04              or      [487h],ah
F000:2DAB  [+0x02DAB]  B0 08                    mov     al,8
F000:2DAD  [+0x02DAD]  C6 06 84 04 18           mov     byte [484h],18h
F000:2DB2  [+0x02DB2]  32 E4                    xor     ah,ah
F000:2DB4  [+0x02DB4]  A3 85 04                 mov     [485h],ax
F000:2DB7  [+0x02DB7]  E8 49 02                 call    3003h
F000:2DBA  [+0x02DBA]  C3                       ret
F000:2DBB  [+0x02DBB]  3C 07                    cmp     al,7
F000:2DBD  [+0x02DBD]  74 1C                    je      short 2DDBh
F000:2DBF  [+0x02DBF]  3C 0F                    cmp     al,0Fh
F000:2DC1  [+0x02DC1]  74 18                    je      short 2DDBh
F000:2DC3  [+0x02DC3]  72 0D                    jb      short 2DD2h
F000:2DC5  [+0x02DC5]  8A F8                    mov     bh,al
F000:2DC7  [+0x02DC7]  E8 44 EA                 call    180Eh
F000:2DCA  [+0x02DCA]  75 06                    jne     short 2DD2h
F000:2DCC  [+0x02DCC]  A8 02                    test    al,2
F000:2DCE  [+0x02DCE]  8A C7                    mov     al,bh
F000:2DD0  [+0x02DD0]  74 31                    je      short 2E03h
F000:2DD2  [+0x02DD2]  B0 07                    mov     al,7
F000:2DD4  [+0x02DD4]  80 26 87 04 7F           and     byte [487h],7Fh
F000:2DD9  [+0x02DD9]  EB 37                    jmp     short 2E12h
F000:2DDB  [+0x02DDB]  EB 26                    jmp     short 2E03h
F000:2DDD  [+0x02DDD]  3C 07                    cmp     al,7
F000:2DDF  [+0x02DDF]  72 22                    jb      short 2E03h
F000:2DE1  [+0x02DE1]  3C 0D                    cmp     al,0Dh
F000:2DE3  [+0x02DE3]  72 15                    jb      short 2DFAh
F000:2DE5  [+0x02DE5]  3C 0F                    cmp     al,0Fh
F000:2DE7  [+0x02DE7]  74 11                    je      short 2DFAh
F000:2DE9  [+0x02DE9]  3C 13                    cmp     al,13h
F000:2DEB  [+0x02DEB]  76 16                    jbe     short 2E03h
F000:2DED  [+0x02DED]  8A F8                    mov     bh,al
F000:2DEF  [+0x02DEF]  E8 1C EA                 call    180Eh
F000:2DF2  [+0x02DF2]  75 06                    jne     short 2DFAh
F000:2DF4  [+0x02DF4]  A8 02                    test    al,2
F000:2DF6  [+0x02DF6]  8A C7                    mov     al,bh
F000:2DF8  [+0x02DF8]  75 09                    jne     short 2E03h
F000:2DFA  [+0x02DFA]  32 C0                    xor     al,al
F000:2DFC  [+0x02DFC]  80 26 87 04 7F           and     byte [487h],7Fh
F000:2E01  [+0x02E01]  EB 0F                    jmp     short 2E12h
F000:2E03  [+0x02E03]  80 26 87 04 7F           and     byte [487h],7Fh
F000:2E08  [+0x02E08]  8A 66 10                 mov     ah,[bp+10h]
F000:2E0B  [+0x02E0B]  80 E4 80                 and     ah,80h
F000:2E0E  [+0x02E0E]  08 26 87 04              or      [487h],ah
F000:2E12  [+0x02E12]  A2 49 04                 mov     [449h],al
F000:2E15  [+0x02E15]  E8 25 02                 call    303Dh
F000:2E18  [+0x02E18]  80 26 87 04 F3           and     byte [487h],0F3h
F000:2E1D  [+0x02E1D]  E8 C5 02                 call    30E5h
F000:2E20  [+0x02E20]  E8 8F 23                 call    51B2h
F000:2E23  [+0x02E23]  A0 49 04                 mov     al,[449h]
F000:2E26  [+0x02E26]  E8 D9 E4                 call    1302h
F000:2E29  [+0x02E29]  E8 CB 24                 call    52F7h
F000:2E2C  [+0x02E2C]  8B 16 63 04              mov     dx,[463h]
F000:2E30  [+0x02E30]  A0 49 04                 mov     al,[449h]
F000:2E33  [+0x02E33]  3C 04                    cmp     al,4
F000:2E35  [+0x02E35]  72 0F                    jb      short 2E46h
F000:2E37  [+0x02E37]  3C 07                    cmp     al,7
F000:2E39  [+0x02E39]  74 0B                    je      short 2E46h
F000:2E3B  [+0x02E3B]  3C 13                    cmp     al,13h
F000:2E3D  [+0x02E3D]  76 0C                    jbe     short 2E4Bh
F000:2E3F  [+0x02E3F]  8A E0                    mov     ah,al
F000:2E41  [+0x02E41]  E8 FB F0                 call    1F3Fh
F000:2E44  [+0x02E44]  72 05                    jb      short 2E4Bh
F000:2E46  [+0x02E46]  E8 63 00                 call    2EACh
F000:2E49  [+0x02E49]  EB 14                    jmp     short 2E5Fh
F000:2E4B  [+0x02E4B]  C7 06 60 04 00 00        mov     word [460h],0
F000:2E51  [+0x02E51]  B8 07 00                 mov     ax,7
F000:2E54  [+0x02E54]  BB 0C 00                 mov     bx,0Ch
F000:2E57  [+0x02E57]  E8 A8 02                 call    3102h
F000:2E5A  [+0x02E5A]  75 03                    jne     short 2E5Fh
F000:2E5C  [+0x02E5C]  E8 68 03                 call    31C7h
F000:2E5F  [+0x02E5F]  F6 06 87 04 80           test    byte [487h],80h
F000:2E64  [+0x02E64]  75 0A                    jne     short 2E70h
F000:2E66  [+0x02E66]  A1 4C 04                 mov     ax,[44Ch]
F000:2E69  [+0x02E69]  0B C0                    or      ax,ax
F000:2E6B  [+0x02E6B]  74 03                    je      short 2E70h
F000:2E6D  [+0x02E6D]  E8 15 04                 call    3285h
F000:2E70  [+0x02E70]  E8 7B 03                 call    31EEh
F000:2E73  [+0x02E73]  E8 3A 22                 call    50B0h
F000:2E76  [+0x02E76]  E8 46 24                 call    52BFh
F000:2E79  [+0x02E79]  B3 11                    mov     bl,11h
F000:2E7B  [+0x02E7B]  E8 9E 15                 call    441Ch
F000:2E7E  [+0x02E7E]  88 7E 10                 mov     [bp+10h],bh
F000:2E81  [+0x02E81]  B0 55                    mov     al,55h
F000:2E83  [+0x02E83]  E8 A6 F1                 call    202Ch
F000:2E86  [+0x02E86]  E8 BD DD                 call    0C46h
F000:2E89  [+0x02E89]  74 00                    je      short 2E8Bh
F000:2E8B  [+0x02E8B]  C3                       ret
F000:2E8C  [+0x02E8C]  2E F6 06 7B 01 02        test    byte [cs:17Bh],2
F000:2E92  [+0x02E92]  74 17                    je      short 2EABh
F000:2E94  [+0x02E94]  50                       push    ax
F000:2E95  [+0x02E95]  E8 4E F5                 call    23E6h
F000:2E98  [+0x02E98]  A8 40                    test    al,40h
F000:2E9A  [+0x02E9A]  58                       pop     ax
F000:2E9B  [+0x02E9B]  75 0E                    jne     short 2EABh
F000:2E9D  [+0x02E9D]  2E F6 06 7B 01 01        test    byte [cs:17Bh],1
F000:2EA3  [+0x02EA3]  75 04                    jne     short 2EA9h
F000:2EA5  [+0x02EA5]  CD 15                    int     15h
F000:2EA7  [+0x02EA7]  EB 02                    jmp     short 2EABh
F000:2EA9  [+0x02EA9]  CD 42                    int     42h
F000:2EAB  [+0x02EAB]  C3                       ret
F000:2EAC  [+0x02EAC]  B8 0B 00                 mov     ax,0Bh
F000:2EAF  [+0x02EAF]  BB 08 00                 mov     bx,8
F000:2EB2  [+0x02EB2]  E8 4D 02                 call    3102h
F000:2EB5  [+0x02EB5]  75 05                    jne     short 2EBCh
F000:2EB7  [+0x02EB7]  E8 69 02                 call    3123h
F000:2EBA  [+0x02EBA]  EB 03                    jmp     short 2EBFh
F000:2EBC  [+0x02EBC]  E8 DF 02                 call    319Eh
F000:2EBF  [+0x02EBF]  BB 10 00                 mov     bx,10h
F000:2EC2  [+0x02EC2]  E8 15 04                 call    32DAh
F000:2EC5  [+0x02EC5]  74 15                    je      short 2EDCh
F000:2EC7  [+0x02EC7]  26 C4 5F 06              les     bx,[es:bx+6]
F000:2ECB  [+0x02ECB]  8C C0                    mov     ax,es
F000:2ECD  [+0x02ECD]  0B C3                    or      ax,bx
F000:2ECF  [+0x02ECF]  74 0B                    je      short 2EDCh
F000:2ED1  [+0x02ED1]  B8 07 00                 mov     ax,7
F000:2ED4  [+0x02ED4]  E8 33 02                 call    310Ah
F000:2ED7  [+0x02ED7]  75 03                    jne     short 2EDCh
F000:2ED9  [+0x02ED9]  E8 76 02                 call    3152h
F000:2EDC  [+0x02EDC]  C3                       ret
F000:2EDD  [+0x02EDD]  8A 1E 10 04              mov     bl,[410h]
F000:2EE1  [+0x02EE1]  80 E3 30                 and     bl,30h
F000:2EE4  [+0x02EE4]  38 06 49 04              cmp     [449h],al
F000:2EE8  [+0x02EE8]  74 55                    je      short 2F3Fh
F000:2EEA  [+0x02EEA]  8A 26 88 04              mov     ah,[488h]
F000:2EEE  [+0x02EEE]  80 E4 0F                 and     ah,0Fh
F000:2EF1  [+0x02EF1]  3C 07                    cmp     al,7
F000:2EF3  [+0x02EF3]  74 13                    je      short 2F08h
F000:2EF5  [+0x02EF5]  3C 0F                    cmp     al,0Fh
F000:2EF7  [+0x02EF7]  74 0F                    je      short 2F08h
F000:2EF9  [+0x02EF9]  3C 13                    cmp     al,13h
F000:2EFB  [+0x02EFB]  76 0D                    jbe     short 2F0Ah
F000:2EFD  [+0x02EFD]  8A F8                    mov     bh,al
F000:2EFF  [+0x02EFF]  E8 0C E9                 call    180Eh
F000:2F02  [+0x02F02]  75 06                    jne     short 2F0Ah
F000:2F04  [+0x02F04]  A8 02                    test    al,2
F000:2F06  [+0x02F06]  8A C7                    mov     al,bh
F000:2F08  [+0x02F08]  74 7A                    je      short 2F84h
F000:2F0A  [+0x02F0A]  81 3E 63 04 D4 03        cmp     word [463h],3D4h
F000:2F10  [+0x02F10]  74 2E                    je      short 2F40h
F000:2F12  [+0x02F12]  80 FB 30                 cmp     bl,30h
F000:2F15  [+0x02F15]  75 14                    jne     short 2F2Bh
F000:2F17  [+0x02F17]  2E F6 06 7D 01 01        test    byte [cs:17Dh],1
F000:2F1D  [+0x02F1D]  74 61                    je      short 2F80h
F000:2F1F  [+0x02F1F]  B3 20                    mov     bl,20h
F000:2F21  [+0x02F21]  80 26 10 04 CF           and     byte [410h],0CFh
F000:2F26  [+0x02F26]  80 0E 10 04 20           or      byte [410h],20h
F000:2F2B  [+0x02F2B]  80 FC 05                 cmp     ah,5
F000:2F2E  [+0x02F2E]  76 0F                    jbe     short 2F3Fh
F000:2F30  [+0x02F30]  80 FC 08                 cmp     ah,8
F000:2F33  [+0x02F33]  76 23                    jbe     short 2F58h
F000:2F35  [+0x02F35]  80 FC 09                 cmp     ah,9
F000:2F38  [+0x02F38]  74 22                    je      short 2F5Ch
F000:2F3A  [+0x02F3A]  80 FC 0B                 cmp     ah,0Bh
F000:2F3D  [+0x02F3D]  76 15                    jbe     short 2F54h
F000:2F3F  [+0x02F3F]  C3                       ret
F000:2F40  [+0x02F40]  2E F6 06 7D 01 01        test    byte [cs:17Dh],1
F000:2F46  [+0x02F46]  74 F7                    je      short 2F3Fh
F000:2F48  [+0x02F48]  80 26 10 04 CF           and     byte [410h],0CFh
F000:2F4D  [+0x02F4D]  80 0E 10 04 20           or      byte [410h],20h
F000:2F52  [+0x02F52]  EB EB                    jmp     short 2F3Fh
F000:2F54  [+0x02F54]  B3 48                    mov     bl,48h
F000:2F56  [+0x02F56]  EB 06                    jmp     short 2F5Eh
F000:2F58  [+0x02F58]  B3 8B                    mov     bl,8Bh
F000:2F5A  [+0x02F5A]  EB 02                    jmp     short 2F5Eh
F000:2F5C  [+0x02F5C]  B3 0B                    mov     bl,0Bh
F000:2F5E  [+0x02F5E]  80 26 87 04 FD           and     byte [487h],0FDh
F000:2F63  [+0x02F63]  80 26 88 04 F0           and     byte [488h],0F0h
F000:2F68  [+0x02F68]  8A 26 89 04              mov     ah,[489h]
F000:2F6C  [+0x02F6C]  F6 D4                    not     ah
F000:2F6E  [+0x02F6E]  80 E4 80                 and     ah,80h
F000:2F71  [+0x02F71]  D0 C4                    rol     ah,1
F000:2F73  [+0x02F73]  0A E3                    or      ah,bl
F000:2F75  [+0x02F75]  08 26 88 04              or      [488h],ah
F000:2F79  [+0x02F79]  80 26 89 04 7F           and     byte [489h],7Fh
F000:2F7E  [+0x02F7E]  EB BF                    jmp     short 2F3Fh
F000:2F80  [+0x02F80]  B0 07                    mov     al,7
F000:2F82  [+0x02F82]  EB BB                    jmp     short 2F3Fh
F000:2F84  [+0x02F84]  81 3E 63 04 B4 03        cmp     word [463h],3B4h
F000:2F8A  [+0x02F8A]  74 35                    je      short 2FC1h
F000:2F8C  [+0x02F8C]  80 FB 30                 cmp     bl,30h
F000:2F8F  [+0x02F8F]  74 14                    je      short 2FA5h
F000:2F91  [+0x02F91]  2E F6 06 7D 01 01        test    byte [cs:17Dh],1
F000:2F97  [+0x02F97]  74 24                    je      short 2FBDh
F000:2F99  [+0x02F99]  B3 30                    mov     bl,30h
F000:2F9B  [+0x02F9B]  80 26 10 04 CF           and     byte [410h],0CFh
F000:2FA0  [+0x02FA0]  80 0E 10 04 30           or      byte [410h],30h
F000:2FA5  [+0x02FA5]  80 FC 05                 cmp     ah,5
F000:2FA8  [+0x02FA8]  76 26                    jbe     short 2FD0h
F000:2FAA  [+0x02FAA]  80 FC 08                 cmp     ah,8
F000:2FAD  [+0x02FAD]  76 28                    jbe     short 2FD7h
F000:2FAF  [+0x02FAF]  80 FC 09                 cmp     ah,9
F000:2FB2  [+0x02FB2]  74 39                    je      short 2FEDh
F000:2FB4  [+0x02FB4]  80 FC 0B                 cmp     ah,0Bh
F000:2FB7  [+0x02FB7]  77 49                    ja      short 3002h
F000:2FB9  [+0x02FB9]  B3 08                    mov     bl,8
F000:2FBB  [+0x02FBB]  EB 32                    jmp     short 2FEFh
F000:2FBD  [+0x02FBD]  32 C0                    xor     al,al
F000:2FBF  [+0x02FBF]  EB 41                    jmp     short 3002h
F000:2FC1  [+0x02FC1]  2E F6 06 7D 01 01        test    byte [cs:17Dh],1
F000:2FC7  [+0x02FC7]  74 39                    je      short 3002h
F000:2FC9  [+0x02FC9]  80 0E 10 04 30           or      byte [410h],30h
F000:2FCE  [+0x02FCE]  EB 32                    jmp     short 3002h
F000:2FD0  [+0x02FD0]  80 0E 87 04 02           or      byte [487h],2
F000:2FD5  [+0x02FD5]  EB 2B                    jmp     short 3002h
F000:2FD7  [+0x02FD7]  80 0E 87 04 02           or      byte [487h],2
F000:2FDC  [+0x02FDC]  80 0E 89 04 80           or      byte [489h],80h
F000:2FE1  [+0x02FE1]  80 26 88 04 F0           and     byte [488h],0F0h
F000:2FE6  [+0x02FE6]  80 0E 88 04 0B           or      byte [488h],0Bh
F000:2FEB  [+0x02FEB]  EB 15                    jmp     short 3002h
F000:2FED  [+0x02FED]  B3 0B                    mov     bl,0Bh
F000:2FEF  [+0x02FEF]  80 0E 87 04 02           or      byte [487h],2
F000:2FF4  [+0x02FF4]  80 26 89 04 7F           and     byte [489h],7Fh
F000:2FF9  [+0x02FF9]  80 26 88 04 F0           and     byte [488h],0F0h
F000:2FFE  [+0x02FFE]  08 1E 88 04              or      [488h],bl
F000:3002  [+0x03002]  C3                       ret
F000:3003  [+0x03003]  1E                       push    ds
F000:3004  [+0x03004]  55                       push    bp
F000:3005  [+0x03005]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:300A  [+0x0300A]  9C                       pushf
F000:300B  [+0x0300B]  FA                       cli
F000:300C  [+0x0300C]  C7 06 0C 01 54 56        mov     word [10Ch],5654h
F000:3012  [+0x03012]  8C 0E 0E 01              mov     [10Eh],cs
F000:3016  [+0x03016]  9D                       popf
F000:3017  [+0x03017]  8E 5E 00                 mov     ds,[bp]
F000:301A  [+0x0301A]  8B 46 10                 mov     ax,[bp+10h]
F000:301D  [+0x0301D]  8B 56 0A                 mov     dx,[bp+0Ah]
F000:3020  [+0x03020]  8B 76 08                 mov     si,[bp+8]
F000:3023  [+0x03023]  8B 6E 04                 mov     bp,[bp+4]
F000:3026  [+0x03026]  CD 42                    int     42h
F000:3028  [+0x03028]  5D                       pop     bp
F000:3029  [+0x03029]  1F                       pop     ds
F000:302A  [+0x0302A]  89 46 10                 mov     [bp+10h],ax
F000:302D  [+0x0302D]  A0 10 04                 mov     al,[410h]
F000:3030  [+0x03030]  24 30                    and     al,30h
F000:3032  [+0x03032]  3C 30                    cmp     al,30h
F000:3034  [+0x03034]  75 06                    jne     short 303Ch
F000:3036  [+0x03036]  C7 06 60 04 0C 0B        mov     word [460h],0B0Ch
F000:303C  [+0x0303C]  C3                       ret
F000:303D  [+0x0303D]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:3042  [+0x03042]  BF 0C 01                 mov     di,10Ch
F000:3045  [+0x03045]  3C 13                    cmp     al,13h
F000:3047  [+0x03047]  76 1C                    jbe     short 3065h
F000:3049  [+0x03049]  E8 C2 E7                 call    180Eh
F000:304C  [+0x0304C]  75 17                    jne     short 3065h
F000:304E  [+0x0304E]  BB 54 56                 mov     bx,5654h
F000:3051  [+0x03051]  A8 01                    test    al,1
F000:3053  [+0x03053]  75 2E                    jne     short 3083h
F000:3055  [+0x03055]  24 70                    and     al,70h
F000:3057  [+0x03057]  74 2A                    je      short 3083h
F000:3059  [+0x03059]  BB 54 5E                 mov     bx,5E54h
F000:305C  [+0x0305C]  3C 20                    cmp     al,20h
F000:305E  [+0x0305E]  76 23                    jbe     short 3083h
F000:3060  [+0x03060]  BB 64 6D                 mov     bx,6D64h
F000:3063  [+0x03063]  EB 1E                    jmp     short 3083h
F000:3065  [+0x03065]  BB 54 56                 mov     bx,5654h
F000:3068  [+0x03068]  3C 13                    cmp     al,13h
F000:306A  [+0x0306A]  74 17                    je      short 3083h
F000:306C  [+0x0306C]  3C 08                    cmp     al,8
F000:306E  [+0x0306E]  72 13                    jb      short 3083h
F000:3070  [+0x03070]  BB 64 6D                 mov     bx,6D64h
F000:3073  [+0x03073]  74 0E                    je      short 3083h
F000:3075  [+0x03075]  3C 11                    cmp     al,11h
F000:3077  [+0x03077]  73 0A                    jae     short 3083h
F000:3079  [+0x03079]  BB 54 5E                 mov     bx,5E54h
F000:307C  [+0x0307C]  3C 0F                    cmp     al,0Fh
F000:307E  [+0x0307E]  73 03                    jae     short 3083h
F000:3080  [+0x03080]  BB 54 56                 mov     bx,5654h
F000:3083  [+0x03083]  8B C3                    mov     ax,bx
F000:3085  [+0x03085]  9C                       pushf
F000:3086  [+0x03086]  FA                       cli
F000:3087  [+0x03087]  AB                       stosw
F000:3088  [+0x03088]  8C C8                    mov     ax,cs
F000:308A  [+0x0308A]  AB                       stosw
F000:308B  [+0x0308B]  9D                       popf
F000:308C  [+0x0308C]  8C D8                    mov     ax,ds
F000:308E  [+0x0308E]  8E C0                    mov     es,ax
F000:3090  [+0x03090]  BF 50 04                 mov     di,450h
F000:3093  [+0x03093]  B9 08 00                 mov     cx,8
F000:3096  [+0x03096]  33 C0                    xor     ax,ax
F000:3098  [+0x03098]  F3 AB                    rep stosw
F000:309A  [+0x0309A]  A2 62 04                 mov     [462h],al
F000:309D  [+0x0309D]  A3 4E 04                 mov     [44Eh],ax
F000:30A0  [+0x030A0]  A0 49 04                 mov     al,[449h]
F000:30A3  [+0x030A3]  3C 07                    cmp     al,7
F000:30A5  [+0x030A5]  77 18                    ja      short 30BFh
F000:30A7  [+0x030A7]  32 E4                    xor     ah,ah
F000:30A9  [+0x030A9]  8B F8                    mov     di,ax
F000:30AB  [+0x030AB]  B0 3F                    mov     al,3Fh
F000:30AD  [+0x030AD]  83 FF 06                 cmp     di,6
F000:30B0  [+0x030B0]  74 02                    je      short 30B4h
F000:30B2  [+0x030B2]  B0 30                    mov     al,30h
F000:30B4  [+0x030B4]  A2 66 04                 mov     [466h],al
F000:30B7  [+0x030B7]  2E 8A 85 B6 2C           mov     al,[cs:di+2CB6h]
F000:30BC  [+0x030BC]  A2 65 04                 mov     [465h],al
F000:30BF  [+0x030BF]  E8 B4 20                 call    5176h
F000:30C2  [+0x030C2]  56                       push    si
F000:30C3  [+0x030C3]  26 AC                    es lodsb
F000:30C5  [+0x030C5]  32 E4                    xor     ah,ah
F000:30C7  [+0x030C7]  A3 4A 04                 mov     [44Ah],ax
F000:30CA  [+0x030CA]  26 AC                    es lodsb
F000:30CC  [+0x030CC]  A2 84 04                 mov     [484h],al
F000:30CF  [+0x030CF]  26 AC                    es lodsb
F000:30D1  [+0x030D1]  A3 85 04                 mov     [485h],ax
F000:30D4  [+0x030D4]  26 AD                    es lodsw
F000:30D6  [+0x030D6]  A3 4C 04                 mov     [44Ch],ax
F000:30D9  [+0x030D9]  83 C6 0F                 add     si,0Fh
F000:30DC  [+0x030DC]  26 AD                    es lodsw
F000:30DE  [+0x030DE]  86 C4                    xchg    al,ah
F000:30E0  [+0x030E0]  A3 60 04                 mov     [460h],ax
F000:30E3  [+0x030E3]  5E                       pop     si
F000:30E4  [+0x030E4]  C3                       ret
F000:30E5  [+0x030E5]  1E                       push    ds
F000:30E6  [+0x030E6]  06                       push    es
F000:30E7  [+0x030E7]  56                       push    si
F000:30E8  [+0x030E8]  06                       push    es
F000:30E9  [+0x030E9]  BB 04 00                 mov     bx,4
F000:30EC  [+0x030EC]  E8 EB 01                 call    32DAh
F000:30EF  [+0x030EF]  1F                       pop     ds
F000:30F0  [+0x030F0]  74 0C                    je      short 30FEh
F000:30F2  [+0x030F2]  83 C6 23                 add     si,23h
F000:30F5  [+0x030F5]  8B FB                    mov     di,bx
F000:30F7  [+0x030F7]  B9 08 00                 mov     cx,8
F000:30FA  [+0x030FA]  F3 A5                    rep movsw
F000:30FC  [+0x030FC]  46                       inc     si
F000:30FD  [+0x030FD]  A4                       movsb
F000:30FE  [+0x030FE]  5E                       pop     si
F000:30FF  [+0x030FF]  07                       pop     es
F000:3100  [+0x03100]  1F                       pop     ds
F000:3101  [+0x03101]  C3                       ret
F000:3102  [+0x03102]  E8 D5 01                 call    32DAh
F000:3105  [+0x03105]  75 03                    jne     short 310Ah
F000:3107  [+0x03107]  0C FF                    or      al,0FFh
F000:3109  [+0x03109]  C3                       ret
F000:310A  [+0x0310A]  53                       push    bx
F000:310B  [+0x0310B]  03 D8                    add     bx,ax
F000:310D  [+0x0310D]  A0 49 04                 mov     al,[449h]
F000:3110  [+0x03110]  26 8A 27                 mov     ah,[es:bx]
F000:3113  [+0x03113]  43                       inc     bx
F000:3114  [+0x03114]  80 FC FF                 cmp     ah,0FFh
F000:3117  [+0x03117]  74 06                    je      short 311Fh
F000:3119  [+0x03119]  3A C4                    cmp     al,ah
F000:311B  [+0x0311B]  75 F3                    jne     short 3110h
F000:311D  [+0x0311D]  5B                       pop     bx
F000:311E  [+0x0311E]  C3                       ret
F000:311F  [+0x0311F]  0C FF                    or      al,0FFh
F000:3121  [+0x03121]  5B                       pop     bx
F000:3122  [+0x03122]  C3                       ret
F000:3123  [+0x03123]  26 8A 47 0A              mov     al,[es:bx+0Ah]
F000:3127  [+0x03127]  50                       push    ax
F000:3128  [+0x03128]  26 8B 4F 02              mov     cx,[es:bx+2]
F000:312C  [+0x0312C]  26 8B 57 04              mov     dx,[es:bx+4]
F000:3130  [+0x03130]  26 8B 77 06              mov     si,[es:bx+6]
F000:3134  [+0x03134]  26 8B 47 08              mov     ax,[es:bx+8]
F000:3138  [+0x03138]  26 8B 1F                 mov     bx,[es:bx]
F000:313B  [+0x0313B]  86 DF                    xchg    bl,bh
F000:313D  [+0x0313D]  80 E3 3F                 and     bl,3Fh
F000:3140  [+0x03140]  8E C0                    mov     es,ax
F000:3142  [+0x03142]  B0 10                    mov     al,10h
F000:3144  [+0x03144]  E8 BA 13                 call    4501h
F000:3147  [+0x03147]  58                       pop     ax
F000:3148  [+0x03148]  FE C0                    inc     al
F000:314A  [+0x0314A]  74 05                    je      short 3151h
F000:314C  [+0x0314C]  48                       dec     ax
F000:314D  [+0x0314D]  48                       dec     ax
F000:314E  [+0x0314E]  A2 84 04                 mov     [484h],al
F000:3151  [+0x03151]  C3                       ret
F000:3152  [+0x03152]  26 8A 07                 mov     al,[es:bx]
F000:3155  [+0x03155]  32 E4                    xor     ah,ah
F000:3157  [+0x03157]  3B 06 85 04              cmp     ax,[485h]
F000:315B  [+0x0315B]  75 40                    jne     short 319Dh
F000:315D  [+0x0315D]  B9 00 01                 mov     cx,100h
F000:3160  [+0x03160]  33 D2                    xor     dx,dx
F000:3162  [+0x03162]  26 8B 77 03              mov     si,[es:bx+3]
F000:3166  [+0x03166]  26 8B 47 05              mov     ax,[es:bx+5]
F000:316A  [+0x0316A]  26 8B 1F                 mov     bx,[es:bx]
F000:316D  [+0x0316D]  86 DF                    xchg    bl,bh
F000:316F  [+0x0316F]  80 E3 3F                 and     bl,3Fh
F000:3172  [+0x03172]  8E C0                    mov     es,ax
F000:3174  [+0x03174]  32 C0                    xor     al,al
F000:3176  [+0x03176]  53                       push    bx
F000:3177  [+0x03177]  E8 87 13                 call    4501h
F000:317A  [+0x0317A]  BA C4 03                 mov     dx,3C4h
F000:317D  [+0x0317D]  B0 03                    mov     al,3
F000:317F  [+0x0317F]  E8 08 1F                 call    508Ah
F000:3182  [+0x03182]  80 E4 13                 and     ah,13h
F000:3185  [+0x03185]  5B                       pop     bx
F000:3186  [+0x03186]  8A FB                    mov     bh,bl
F000:3188  [+0x03188]  80 E3 03                 and     bl,3
F000:318B  [+0x0318B]  B1 02                    mov     cl,2
F000:318D  [+0x0318D]  D2 E3                    shl     bl,cl
F000:318F  [+0x0318F]  80 E7 04                 and     bh,4
F000:3192  [+0x03192]  FE C1                    inc     cl
F000:3194  [+0x03194]  D2 E7                    shl     bh,cl
F000:3196  [+0x03196]  0A E3                    or      ah,bl
F000:3198  [+0x03198]  0A E7                    or      ah,bh
F000:319A  [+0x0319A]  B0 03                    mov     al,3
F000:319C  [+0x0319C]  EF                       out     dx,ax
F000:319D  [+0x0319D]  C3                       ret
F000:319E  [+0x0319E]  32 DB                    xor     bl,bl
F000:31A0  [+0x031A0]  B0 01                    mov     al,1
F000:31A2  [+0x031A2]  83 3E 85 04 0E           cmp     word [485h],0Eh
F000:31A7  [+0x031A7]  74 10                    je      short 31B9h
F000:31A9  [+0x031A9]  B0 02                    mov     al,2
F000:31AB  [+0x031AB]  83 3E 85 04 08           cmp     word [485h],8
F000:31B0  [+0x031B0]  74 11                    je      short 31C3h
F000:31B2  [+0x031B2]  B0 04                    mov     al,4
F000:31B4  [+0x031B4]  80 CB 40                 or      bl,40h
F000:31B7  [+0x031B7]  EB 0A                    jmp     short 31C3h
F000:31B9  [+0x031B9]  80 3E 49 04 07           cmp     byte [449h],7
F000:31BE  [+0x031BE]  75 03                    jne     short 31C3h
F000:31C0  [+0x031C0]  80 CB 80                 or      bl,80h
F000:31C3  [+0x031C3]  E8 3B 13                 call    4501h
F000:31C6  [+0x031C6]  C3                       ret
F000:31C7  [+0x031C7]  26 8A 07                 mov     al,[es:bx]
F000:31CA  [+0x031CA]  FE C8                    dec     al
F000:31CC  [+0x031CC]  A2 84 04                 mov     [484h],al
F000:31CF  [+0x031CF]  26 8B 47 01              mov     ax,[es:bx+1]
F000:31D3  [+0x031D3]  A3 85 04                 mov     [485h],ax
F000:31D6  [+0x031D6]  26 8B 47 03              mov     ax,[es:bx+3]
F000:31DA  [+0x031DA]  26 8B 5F 05              mov     bx,[es:bx+5]
F000:31DE  [+0x031DE]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:31E3  [+0x031E3]  BF 0C 01                 mov     di,10Ch
F000:31E6  [+0x031E6]  9C                       pushf
F000:31E7  [+0x031E7]  FA                       cli
F000:31E8  [+0x031E8]  AB                       stosw
F000:31E9  [+0x031E9]  8B C3                    mov     ax,bx
F000:31EB  [+0x031EB]  AB                       stosw
F000:31EC  [+0x031EC]  9D                       popf
F000:31ED  [+0x031ED]  C3                       ret
F000:31EE  [+0x031EE]  BB 10 00                 mov     bx,10h
F000:31F1  [+0x031F1]  E8 E6 00                 call    32DAh
F000:31F4  [+0x031F4]  74 12                    je      short 3208h
F000:31F6  [+0x031F6]  26 C4 5F 0A              les     bx,[es:bx+0Ah]
F000:31FA  [+0x031FA]  8C C0                    mov     ax,es
F000:31FC  [+0x031FC]  0B C3                    or      ax,bx
F000:31FE  [+0x031FE]  74 08                    je      short 3208h
F000:3200  [+0x03200]  B8 14 00                 mov     ax,14h
F000:3203  [+0x03203]  E8 04 FF                 call    310Ah
F000:3206  [+0x03206]  74 01                    je      short 3209h
F000:3208  [+0x03208]  C3                       ret
F000:3209  [+0x03209]  F6 06 89 04 08           test    byte [489h],8
F000:320E  [+0x0320E]  75 59                    jne     short 3269h
F000:3210  [+0x03210]  8B 16 63 04              mov     dx,[463h]
F000:3214  [+0x03214]  83 C2 06                 add     dx,6
F000:3217  [+0x03217]  EC                       in      al,dx
F000:3218  [+0x03218]  1E                       push    ds
F000:3219  [+0x03219]  53                       push    bx
F000:321A  [+0x0321A]  26 8B 47 0E              mov     ax,[es:bx+0Eh]
F000:321E  [+0x0321E]  8A E0                    mov     ah,al
F000:3220  [+0x03220]  26 C5 77 10              lds     si,[es:bx+10h]
F000:3224  [+0x03224]  26 8B 5F 0C              mov     bx,[es:bx+0Ch]
F000:3228  [+0x03228]  0B DB                    or      bx,bx
F000:322A  [+0x0322A]  74 14                    je      short 3240h
F000:322C  [+0x0322C]  BA C8 03                 mov     dx,3C8h
F000:322F  [+0x0322F]  8A C4                    mov     al,ah
F000:3231  [+0x03231]  EE                       out     dx,al
F000:3232  [+0x03232]  42                       inc     dx
F000:3233  [+0x03233]  B9 03 00                 mov     cx,3
F000:3236  [+0x03236]  AC                       lodsb
F000:3237  [+0x03237]  EE                       out     dx,al
F000:3238  [+0x03238]  E2 FC                    loop    3236h
F000:323A  [+0x0323A]  FE C4                    inc     ah
F000:323C  [+0x0323C]  4A                       dec     dx
F000:323D  [+0x0323D]  4B                       dec     bx
F000:323E  [+0x0323E]  75 EF                    jne     short 322Fh
F000:3240  [+0x03240]  5B                       pop     bx
F000:3241  [+0x03241]  26 8B 47 06              mov     ax,[es:bx+6]
F000:3245  [+0x03245]  8A E0                    mov     ah,al
F000:3247  [+0x03247]  26 C5 77 08              lds     si,[es:bx+8]
F000:324B  [+0x0324B]  26 8B 4F 04              mov     cx,[es:bx+4]
F000:324F  [+0x0324F]  E3 17                    jcxz    3268h
F000:3251  [+0x03251]  BA C0 03                 mov     dx,3C0h
F000:3254  [+0x03254]  8A C4                    mov     al,ah
F000:3256  [+0x03256]  EE                       out     dx,al
F000:3257  [+0x03257]  EB 00                    jmp     short 3259h
F000:3259  [+0x03259]  AC                       lodsb
F000:325A  [+0x0325A]  EE                       out     dx,al
F000:325B  [+0x0325B]  FE C4                    inc     ah
F000:325D  [+0x0325D]  E2 F5                    loop    3254h
F000:325F  [+0x0325F]  FE C4                    inc     ah
F000:3261  [+0x03261]  8A C4                    mov     al,ah
F000:3263  [+0x03263]  EE                       out     dx,al
F000:3264  [+0x03264]  EB 00                    jmp     short 3266h
F000:3266  [+0x03266]  AC                       lodsb
F000:3267  [+0x03267]  EE                       out     dx,al
F000:3268  [+0x03268]  1F                       pop     ds
F000:3269  [+0x03269]  26 8A 07                 mov     al,[es:bx]
F000:326C  [+0x0326C]  0A C0                    or      al,al
F000:326E  [+0x0326E]  74 14                    je      short 3284h
F000:3270  [+0x03270]  A8 80                    test    al,80h
F000:3272  [+0x03272]  B0 1F                    mov     al,1Fh
F000:3274  [+0x03274]  75 05                    jne     short 327Bh
F000:3276  [+0x03276]  A1 85 04                 mov     ax,[485h]
F000:3279  [+0x03279]  FE C8                    dec     al
F000:327B  [+0x0327B]  8B 16 63 04              mov     dx,[463h]
F000:327F  [+0x0327F]  8A E0                    mov     ah,al
F000:3281  [+0x03281]  B0 14                    mov     al,14h
F000:3283  [+0x03283]  EF                       out     dx,ax
F000:3284  [+0x03284]  C3                       ret
F000:3285  [+0x03285]  B9 00 40                 mov     cx,4000h
F000:3288  [+0x03288]  8A 1E 49 04              mov     bl,[449h]
F000:328C  [+0x0328C]  80 FB 13                 cmp     bl,13h
F000:328F  [+0x0328F]  76 24                    jbe     short 32B5h
F000:3291  [+0x03291]  8A C3                    mov     al,bl
F000:3293  [+0x03293]  E8 78 E5                 call    180Eh
F000:3296  [+0x03296]  75 1D                    jne     short 32B5h
F000:3298  [+0x03298]  8A D8                    mov     bl,al
F000:329A  [+0x0329A]  B7 B8                    mov     bh,0B8h
F000:329C  [+0x0329C]  B8 20 07                 mov     ax,720h
F000:329F  [+0x0329F]  F6 C3 02                 test    bl,2
F000:32A2  [+0x032A2]  75 02                    jne     short 32A6h
F000:32A4  [+0x032A4]  B7 B0                    mov     bh,0B0h
F000:32A6  [+0x032A6]  F6 C3 01                 test    bl,1
F000:32A9  [+0x032A9]  75 26                    jne     short 32D1h
F000:32AB  [+0x032AB]  33 C0                    xor     ax,ax
F000:32AD  [+0x032AD]  F6 C3 80                 test    bl,80h
F000:32B0  [+0x032B0]  74 1B                    je      short 32CDh
F000:32B2  [+0x032B2]  E9 D0 EB                 jmp     1E85h
F000:32B5  [+0x032B5]  B7 B0                    mov     bh,0B0h
F000:32B7  [+0x032B7]  B8 20 07                 mov     ax,720h
F000:32BA  [+0x032BA]  80 FB 07                 cmp     bl,7
F000:32BD  [+0x032BD]  74 12                    je      short 32D1h
F000:32BF  [+0x032BF]  B7 B8                    mov     bh,0B8h
F000:32C1  [+0x032C1]  80 FB 03                 cmp     bl,3
F000:32C4  [+0x032C4]  76 0B                    jbe     short 32D1h
F000:32C6  [+0x032C6]  33 C0                    xor     ax,ax
F000:32C8  [+0x032C8]  80 FB 06                 cmp     bl,6
F000:32CB  [+0x032CB]  76 04                    jbe     short 32D1h
F000:32CD  [+0x032CD]  B7 A0                    mov     bh,0A0h
F000:32CF  [+0x032CF]  B5 80                    mov     ch,80h
F000:32D1  [+0x032D1]  32 DB                    xor     bl,bl
F000:32D3  [+0x032D3]  8E C3                    mov     es,bx
F000:32D5  [+0x032D5]  33 FF                    xor     di,di
F000:32D7  [+0x032D7]  F3 AB                    rep stosw
F000:32D9  [+0x032D9]  C3                       ret
F000:32DA  [+0x032DA]  57                       push    di
F000:32DB  [+0x032DB]  C4 3E A8 04              les     di,[4A8h]
F000:32DF  [+0x032DF]  26 C4 19                 les     bx,[es:bx+di]
F000:32E2  [+0x032E2]  8C C7                    mov     di,es
F000:32E4  [+0x032E4]  0B FB                    or      di,bx
F000:32E6  [+0x032E6]  5F                       pop     di
F000:32E7  [+0x032E7]  C3                       ret
F000:32E8  [+0x032E8]  89 0E 60 04              mov     [460h],cx
F000:32EC  [+0x032EC]  8B 16 63 04              mov     dx,[463h]
F000:32F0  [+0x032F0]  E8 05 00                 call    32F8h
F000:32F3  [+0x032F3]  89 46 10                 mov     [bp+10h],ax
F000:32F6  [+0x032F6]  C3                       ret
F000:32F7  [+0x032F7]  90                       nop
F000:32F8  [+0x032F8]  F6 06 87 04 08           test    byte [487h],8
F000:32FD  [+0x032FD]  75 75                    jne     short 3374h
F000:32FF  [+0x032FF]  8B C1                    mov     ax,cx
F000:3301  [+0x03301]  80 E4 60                 and     ah,60h
F000:3304  [+0x03304]  80 FC 20                 cmp     ah,20h
F000:3307  [+0x03307]  75 05                    jne     short 330Eh
F000:3309  [+0x03309]  B9 00 1E                 mov     cx,1E00h
F000:330C  [+0x0330C]  EB 66                    jmp     short 3374h
F000:330E  [+0x0330E]  F6 06 87 04 01           test    byte [487h],1
F000:3313  [+0x03313]  75 5F                    jne     short 3374h
F000:3315  [+0x03315]  8B C1                    mov     ax,cx
F000:3317  [+0x03317]  25 E0 E0                 and     ax,0E0E0h
F000:331A  [+0x0331A]  75 58                    jne     short 3374h
F000:331C  [+0x0331C]  A0 49 04                 mov     al,[449h]
F000:331F  [+0x0331F]  3C 04                    cmp     al,4
F000:3321  [+0x03321]  72 0F                    jb      short 3332h
F000:3323  [+0x03323]  3C 07                    cmp     al,7
F000:3325  [+0x03325]  74 0B                    je      short 3332h
F000:3327  [+0x03327]  3C 13                    cmp     al,13h
F000:3329  [+0x03329]  76 49                    jbe     short 3374h
F000:332B  [+0x0332B]  8A E0                    mov     ah,al
F000:332D  [+0x0332D]  E8 0F EC                 call    1F3Fh
F000:3330  [+0x03330]  72 42                    jb      short 3374h
F000:3332  [+0x03332]  3A CD                    cmp     cl,ch
F000:3334  [+0x03334]  73 0E                    jae     short 3344h
F000:3336  [+0x03336]  0A C9                    or      cl,cl
F000:3338  [+0x03338]  74 3A                    je      short 3374h
F000:333A  [+0x0333A]  8A E9                    mov     ch,cl
F000:333C  [+0x0333C]  8A 0E 85 04              mov     cl,[485h]
F000:3340  [+0x03340]  FE C9                    dec     cl
F000:3342  [+0x03342]  EB 30                    jmp     short 3374h
F000:3344  [+0x03344]  8A 1E 85 04              mov     bl,[485h]
F000:3348  [+0x03348]  8A FB                    mov     bh,bl
F000:334A  [+0x0334A]  FE CB                    dec     bl
F000:334C  [+0x0334C]  8A C1                    mov     al,cl
F000:334E  [+0x0334E]  0A C5                    or      al,ch
F000:3350  [+0x03350]  3A C7                    cmp     al,bh
F000:3352  [+0x03352]  73 0C                    jae     short 3360h
F000:3354  [+0x03354]  3A CB                    cmp     cl,bl
F000:3356  [+0x03356]  74 1C                    je      short 3374h
F000:3358  [+0x03358]  FE CB                    dec     bl
F000:335A  [+0x0335A]  3A EB                    cmp     ch,bl
F000:335C  [+0x0335C]  74 16                    je      short 3374h
F000:335E  [+0x0335E]  FE C3                    inc     bl
F000:3360  [+0x03360]  80 F9 03                 cmp     cl,3
F000:3363  [+0x03363]  76 0F                    jbe     short 3374h
F000:3365  [+0x03365]  8A C5                    mov     al,ch
F000:3367  [+0x03367]  04 02                    add     al,2
F000:3369  [+0x03369]  3A C1                    cmp     al,cl
F000:336B  [+0x0336B]  73 1A                    jae     short 3387h
F000:336D  [+0x0336D]  80 FD 02                 cmp     ch,2
F000:3370  [+0x03370]  77 0D                    ja      short 337Fh
F000:3372  [+0x03372]  8A CB                    mov     cl,bl
F000:3374  [+0x03374]  8A E5                    mov     ah,ch
F000:3376  [+0x03376]  B0 0A                    mov     al,0Ah
F000:3378  [+0x03378]  EF                       out     dx,ax
F000:3379  [+0x03379]  8A E1                    mov     ah,cl
F000:337B  [+0x0337B]  B0 0B                    mov     al,0Bh
F000:337D  [+0x0337D]  EF                       out     dx,ax
F000:337E  [+0x0337E]  C3                       ret
F000:337F  [+0x0337F]  8A CB                    mov     cl,bl
F000:3381  [+0x03381]  8A EF                    mov     ch,bh
F000:3383  [+0x03383]  D0 ED                    shr     ch,1
F000:3385  [+0x03385]  EB ED                    jmp     short 3374h
F000:3387  [+0x03387]  80 FF 0E                 cmp     bh,0Eh
F000:338A  [+0x0338A]  72 02                    jb      short 338Eh
F000:338C  [+0x0338C]  FE CB                    dec     bl
F000:338E  [+0x0338E]  2A E9                    sub     ch,cl
F000:3390  [+0x03390]  02 EB                    add     ch,bl
F000:3392  [+0x03392]  8A CB                    mov     cl,bl
F000:3394  [+0x03394]  EB DE                    jmp     short 3374h
F000:3396  [+0x03396]  87 DB                    xchg    bx,bx
F000:3398  [+0x03398]  8A C7                    mov     al,bh
F000:339A  [+0x0339A]  86 DF                    xchg    bl,bh
F000:339C  [+0x0339C]  32 FF                    xor     bh,bh
F000:339E  [+0x0339E]  D1 E3                    shl     bx,1
F000:33A0  [+0x033A0]  89 97 50 04              mov     [bx+450h],dx
F000:33A4  [+0x033A4]  38 06 62 04              cmp     [462h],al
F000:33A8  [+0x033A8]  75 20                    jne     short 33CAh
F000:33AA  [+0x033AA]  A0 4A 04                 mov     al,[44Ah]
F000:33AD  [+0x033AD]  F6 E6                    mul     dh
F000:33AF  [+0x033AF]  02 C2                    add     al,dl
F000:33B1  [+0x033B1]  80 D4 00                 adc     ah,0
F000:33B4  [+0x033B4]  8B 1E 4E 04              mov     bx,[44Eh]
F000:33B8  [+0x033B8]  D1 EB                    shr     bx,1
F000:33BA  [+0x033BA]  03 D8                    add     bx,ax
F000:33BC  [+0x033BC]  B0 0E                    mov     al,0Eh
F000:33BE  [+0x033BE]  8B 16 63 04              mov     dx,[463h]
F000:33C2  [+0x033C2]  8A E7                    mov     ah,bh
F000:33C4  [+0x033C4]  EF                       out     dx,ax
F000:33C5  [+0x033C5]  8A E3                    mov     ah,bl
F000:33C7  [+0x033C7]  FE C0                    inc     al
F000:33C9  [+0x033C9]  EF                       out     dx,ax
F000:33CA  [+0x033CA]  C3                       ret
F000:33CB  [+0x033CB]  90                       nop
F000:33CC  [+0x033CC]  86 DF                    xchg    bl,bh
F000:33CE  [+0x033CE]  32 FF                    xor     bh,bh
F000:33D0  [+0x033D0]  03 DB                    add     bx,bx
F000:33D2  [+0x033D2]  8B 97 50 04              mov     dx,[bx+450h]
F000:33D6  [+0x033D6]  8B 0E 60 04              mov     cx,[460h]
F000:33DA  [+0x033DA]  89 4E 0C                 mov     [bp+0Ch],cx
F000:33DD  [+0x033DD]  89 56 0A                 mov     [bp+0Ah],dx
F000:33E0  [+0x033E0]  C3                       ret
F000:33E1  [+0x033E1]  F6 06 87 04 08           test    byte [487h],8
F000:33E6  [+0x033E6]  74 0F                    je      short 33F7h
F000:33E8  [+0x033E8]  CD 42                    int     42h
F000:33EA  [+0x033EA]  89 56 0A                 mov     [bp+0Ah],dx
F000:33ED  [+0x033ED]  89 4E 0C                 mov     [bp+0Ch],cx
F000:33F0  [+0x033F0]  89 5E 0E                 mov     [bp+0Eh],bx
F000:33F3  [+0x033F3]  89 46 10                 mov     [bp+10h],ax
F000:33F6  [+0x033F6]  C3                       ret
F000:33F7  [+0x033F7]  33 C0                    xor     ax,ax
F000:33F9  [+0x033F9]  89 46 10                 mov     [bp+10h],ax
F000:33FC  [+0x033FC]  C3                       ret
F000:33FD  [+0x033FD]  87 DB                    xchg    bx,bx
F000:33FF  [+0x033FF]  90                       nop
F000:3400  [+0x03400]  32 E4                    xor     ah,ah
F000:3402  [+0x03402]  24 07                    and     al,7
F000:3404  [+0x03404]  8B F8                    mov     di,ax
F000:3406  [+0x03406]  A2 62 04                 mov     [462h],al
F000:3409  [+0x03409]  F7 26 4C 04              mul     word [44Ch]
F000:340D  [+0x0340D]  A3 4E 04                 mov     [44Eh],ax
F000:3410  [+0x03410]  8B D8                    mov     bx,ax
F000:3412  [+0x03412]  A0 49 04                 mov     al,[449h]
F000:3415  [+0x03415]  3C 07                    cmp     al,7
F000:3417  [+0x03417]  76 0B                    jbe     short 3424h
F000:3419  [+0x03419]  3C 13                    cmp     al,13h
F000:341B  [+0x0341B]  76 09                    jbe     short 3426h
F000:341D  [+0x0341D]  8A E0                    mov     ah,al
F000:341F  [+0x0341F]  E8 1D EB                 call    1F3Fh
F000:3422  [+0x03422]  72 02                    jb      short 3426h
F000:3424  [+0x03424]  D1 EB                    shr     bx,1
F000:3426  [+0x03426]  8B 16 63 04              mov     dx,[463h]
F000:342A  [+0x0342A]  B0 0C                    mov     al,0Ch
F000:342C  [+0x0342C]  8A E7                    mov     ah,bh
F000:342E  [+0x0342E]  EF                       out     dx,ax
F000:342F  [+0x0342F]  8A E3                    mov     ah,bl
F000:3431  [+0x03431]  FE C0                    inc     al
F000:3433  [+0x03433]  EF                       out     dx,ax
F000:3434  [+0x03434]  D1 E7                    shl     di,1
F000:3436  [+0x03436]  8B 95 50 04              mov     dx,[di+450h]
F000:343A  [+0x0343A]  E9 6D FF                 jmp     33AAh
F000:343D  [+0x0343D]  00 83 EC 04              add     [bp+di+4ECh],al
F000:3441  [+0x03441]  8B EC                    mov     bp,sp
F000:3443  [+0x03443]  89 46 00                 mov     [bp],ax
F000:3446  [+0x03446]  89 5E 02                 mov     [bp+2],bx
F000:3449  [+0x03449]  8B C1                    mov     ax,cx
F000:344B  [+0x0344B]  80 3E 49 04 13           cmp     byte [449h],13h
F000:3450  [+0x03450]  74 0C                    je      short 345Eh
F000:3452  [+0x03452]  77 2B                    ja      short 347Fh
F000:3454  [+0x03454]  80 3E 49 04 07           cmp     byte [449h],7
F000:3459  [+0x03459]  76 6D                    jbe     short 34C8h
F000:345B  [+0x0345B]  E9 F0 02                 jmp     374Eh
F000:345E  [+0x0345E]  8B F2                    mov     si,dx
F000:3460  [+0x03460]  8B F8                    mov     di,ax
F000:3462  [+0x03462]  81 E7 FF 00              and     di,0FFh
F000:3466  [+0x03466]  8A C4                    mov     al,ah
F000:3468  [+0x03468]  F6 26 4A 04              mul     byte [44Ah]
F000:346C  [+0x0346C]  F7 26 85 04              mul     word [485h]
F000:3470  [+0x03470]  03 F8                    add     di,ax
F000:3472  [+0x03472]  D1 E7                    shl     di,1
F000:3474  [+0x03474]  D1 E7                    shl     di,1
F000:3476  [+0x03476]  D1 E7                    shl     di,1
F000:3478  [+0x03478]  8B D6                    mov     dx,si
F000:347A  [+0x0347A]  8B C1                    mov     ax,cx
F000:347C  [+0x0347C]  E9 05 04                 jmp     3884h
F000:347F  [+0x0347F]  8A 26 49 04              mov     ah,[449h]
F000:3483  [+0x03483]  E8 B9 EA                 call    1F3Fh
F000:3486  [+0x03486]  8B C1                    mov     ax,cx
F000:3488  [+0x03488]  73 3E                    jae     short 34C8h
F000:348A  [+0x0348A]  75 CF                    jne     short 345Bh
F000:348C  [+0x0348C]  E9 80 E4                 jmp     190Fh
F000:348F  [+0x0348F]  87 DB                    xchg    bx,bx
F000:3491  [+0x03491]  90                       nop
F000:3492  [+0x03492]  83 EC 04                 sub     sp,4
F000:3495  [+0x03495]  8B EC                    mov     bp,sp
F000:3497  [+0x03497]  89 46 00                 mov     [bp],ax
F000:349A  [+0x0349A]  89 5E 02                 mov     [bp+2],bx
F000:349D  [+0x0349D]  8B C1                    mov     ax,cx
F000:349F  [+0x0349F]  80 3E 49 04 07           cmp     byte [449h],7
F000:34A4  [+0x034A4]  76 1F                    jbe     short 34C5h
F000:34A6  [+0x034A6]  80 3E 49 04 13           cmp     byte [449h],13h
F000:34AB  [+0x034AB]  74 05                    je      short 34B2h
F000:34AD  [+0x034AD]  77 06                    ja      short 34B5h
F000:34AF  [+0x034AF]  E9 68 02                 jmp     371Ah
F000:34B2  [+0x034B2]  E9 A1 03                 jmp     3856h
F000:34B5  [+0x034B5]  8A 26 49 04              mov     ah,[449h]
F000:34B9  [+0x034B9]  E8 83 EA                 call    1F3Fh
F000:34BC  [+0x034BC]  8B C1                    mov     ax,cx
F000:34BE  [+0x034BE]  73 05                    jae     short 34C5h
F000:34C0  [+0x034C0]  75 ED                    jne     short 34AFh
F000:34C2  [+0x034C2]  E9 E0 E3                 jmp     18A5h
F000:34C5  [+0x034C5]  8B CA                    mov     cx,dx
F000:34C7  [+0x034C7]  FD                       std
F000:34C8  [+0x034C8]  8B F0                    mov     si,ax
F000:34CA  [+0x034CA]  A0 10 04                 mov     al,[410h]
F000:34CD  [+0x034CD]  24 30                    and     al,30h
F000:34CF  [+0x034CF]  3C 30                    cmp     al,30h
F000:34D1  [+0x034D1]  B8 00 B0                 mov     ax,0B000h
F000:34D4  [+0x034D4]  74 02                    je      short 34D8h
F000:34D6  [+0x034D6]  B4 B8                    mov     ah,0B8h
F000:34D8  [+0x034D8]  8E C0                    mov     es,ax
F000:34DA  [+0x034DA]  8B C6                    mov     ax,si
F000:34DC  [+0x034DC]  2A D0                    sub     dl,al
F000:34DE  [+0x034DE]  2A F4                    sub     dh,ah
F000:34E0  [+0x034E0]  8A 46 00                 mov     al,[bp]
F000:34E3  [+0x034E3]  FE C2                    inc     dl
F000:34E5  [+0x034E5]  FE C6                    inc     dh
F000:34E7  [+0x034E7]  8A E6                    mov     ah,dh
F000:34E9  [+0x034E9]  0A C0                    or      al,al
F000:34EB  [+0x034EB]  74 04                    je      short 34F1h
F000:34ED  [+0x034ED]  2A E0                    sub     ah,al
F000:34EF  [+0x034EF]  77 04                    ja      short 34F5h
F000:34F1  [+0x034F1]  8A C6                    mov     al,dh
F000:34F3  [+0x034F3]  32 E4                    xor     ah,ah
F000:34F5  [+0x034F5]  50                       push    ax
F000:34F6  [+0x034F6]  8A 26 49 04              mov     ah,[449h]
F000:34FA  [+0x034FA]  80 FC 03                 cmp     ah,3
F000:34FD  [+0x034FD]  76 0F                    jbe     short 350Eh
F000:34FF  [+0x034FF]  80 FC 07                 cmp     ah,7
F000:3502  [+0x03502]  74 0A                    je      short 350Eh
F000:3504  [+0x03504]  80 FC 13                 cmp     ah,13h
F000:3507  [+0x03507]  77 05                    ja      short 350Eh
F000:3509  [+0x03509]  E9 C6 00                 jmp     35D2h
F000:350C  [+0x0350C]  87 DB                    xchg    bx,bx
F000:350E  [+0x0350E]  8A D8                    mov     bl,al
F000:3510  [+0x03510]  8A C5                    mov     al,ch
F000:3512  [+0x03512]  F6 26 4A 04              mul     byte [44Ah]
F000:3516  [+0x03516]  02 C1                    add     al,cl
F000:3518  [+0x03518]  80 D4 00                 adc     ah,0
F000:351B  [+0x0351B]  8B 3E 4E 04              mov     di,[44Eh]
F000:351F  [+0x0351F]  D1 EF                    shr     di,1
F000:3521  [+0x03521]  03 F8                    add     di,ax
F000:3523  [+0x03523]  8A C3                    mov     al,bl
F000:3525  [+0x03525]  D1 E7                    shl     di,1
F000:3527  [+0x03527]  8B F7                    mov     si,di
F000:3529  [+0x03529]  8B 1E 4A 04              mov     bx,[44Ah]
F000:352D  [+0x0352D]  F6 E3                    mul     bl
F000:352F  [+0x0352F]  50                       push    ax
F000:3530  [+0x03530]  D1 E0                    shl     ax,1
F000:3532  [+0x03532]  D1 E3                    shl     bx,1
F000:3534  [+0x03534]  80 7E 01 06              cmp     byte [bp+1],6
F000:3538  [+0x03538]  74 04                    je      short 353Eh
F000:353A  [+0x0353A]  F7 D8                    neg     ax
F000:353C  [+0x0353C]  F7 DB                    neg     bx
F000:353E  [+0x0353E]  8A CA                    mov     cl,dl
F000:3540  [+0x03540]  32 ED                    xor     ch,ch
F000:3542  [+0x03542]  03 F0                    add     si,ax
F000:3544  [+0x03544]  A0 49 04                 mov     al,[449h]
F000:3547  [+0x03547]  3C 02                    cmp     al,2
F000:3549  [+0x03549]  72 1C                    jb      short 3567h
F000:354B  [+0x0354B]  3C 03                    cmp     al,3
F000:354D  [+0x0354D]  77 18                    ja      short 3567h
F000:354F  [+0x0354F]  F6 06 87 04 04           test    byte [487h],4
F000:3554  [+0x03554]  74 11                    je      short 3567h
F000:3556  [+0x03556]  BA DA 03                 mov     dx,3DAh
F000:3559  [+0x03559]  EC                       in      al,dx
F000:355A  [+0x0355A]  A8 08                    test    al,8
F000:355C  [+0x0355C]  74 FB                    je      short 3559h
F000:355E  [+0x0355E]  83 EA 02                 sub     dx,2
F000:3561  [+0x03561]  A0 65 04                 mov     al,[465h]
F000:3564  [+0x03564]  24 F7                    and     al,0F7h
F000:3566  [+0x03566]  EE                       out     dx,al
F000:3567  [+0x03567]  8C C0                    mov     ax,es
F000:3569  [+0x03569]  8E D8                    mov     ds,ax
F000:356B  [+0x0356B]  58                       pop     ax
F000:356C  [+0x0356C]  5A                       pop     dx
F000:356D  [+0x0356D]  3B 0E 4A 04              cmp     cx,[44Ah]
F000:3571  [+0x03571]  75 15                    jne     short 3588h
F000:3573  [+0x03573]  8B D8                    mov     bx,ax
F000:3575  [+0x03575]  8A C1                    mov     al,cl
F000:3577  [+0x03577]  F6 E6                    mul     dh
F000:3579  [+0x03579]  8B C8                    mov     cx,ax
F000:357B  [+0x0357B]  F3 A5                    rep movsw
F000:357D  [+0x0357D]  8B CB                    mov     cx,bx
F000:357F  [+0x0357F]  B0 20                    mov     al,20h
F000:3581  [+0x03581]  8A 66 03                 mov     ah,[bp+3]
F000:3584  [+0x03584]  F3 AB                    rep stosw
F000:3586  [+0x03586]  EB 27                    jmp     short 35AFh
F000:3588  [+0x03588]  0A F6                    or      dh,dh
F000:358A  [+0x0358A]  74 12                    je      short 359Eh
F000:358C  [+0x0358C]  51                       push    cx
F000:358D  [+0x0358D]  56                       push    si
F000:358E  [+0x0358E]  8B C7                    mov     ax,di
F000:3590  [+0x03590]  F3 A5                    rep movsw
F000:3592  [+0x03592]  8B F8                    mov     di,ax
F000:3594  [+0x03594]  5E                       pop     si
F000:3595  [+0x03595]  59                       pop     cx
F000:3596  [+0x03596]  03 F3                    add     si,bx
F000:3598  [+0x03598]  03 FB                    add     di,bx
F000:359A  [+0x0359A]  FE CE                    dec     dh
F000:359C  [+0x0359C]  75 EE                    jne     short 358Ch
F000:359E  [+0x0359E]  B0 20                    mov     al,20h
F000:35A0  [+0x035A0]  8A 66 03                 mov     ah,[bp+3]
F000:35A3  [+0x035A3]  51                       push    cx
F000:35A4  [+0x035A4]  57                       push    di
F000:35A5  [+0x035A5]  F3 AB                    rep stosw
F000:35A7  [+0x035A7]  5F                       pop     di
F000:35A8  [+0x035A8]  59                       pop     cx
F000:35A9  [+0x035A9]  03 FB                    add     di,bx
F000:35AB  [+0x035AB]  FE CA                    dec     dl
F000:35AD  [+0x035AD]  75 F4                    jne     short 35A3h
F000:35AF  [+0x035AF]  2E 8E 1E 77 26           mov     ds,[cs:2677h]
F000:35B4  [+0x035B4]  A0 49 04                 mov     al,[449h]
F000:35B7  [+0x035B7]  3C 02                    cmp     al,2
F000:35B9  [+0x035B9]  72 12                    jb      short 35CDh
F000:35BB  [+0x035BB]  3C 03                    cmp     al,3
F000:35BD  [+0x035BD]  77 0E                    ja      short 35CDh
F000:35BF  [+0x035BF]  F6 06 87 04 04           test    byte [487h],4
F000:35C4  [+0x035C4]  74 07                    je      short 35CDh
F000:35C6  [+0x035C6]  BA D8 03                 mov     dx,3D8h
F000:35C9  [+0x035C9]  A0 65 04                 mov     al,[465h]
F000:35CC  [+0x035CC]  EE                       out     dx,al
F000:35CD  [+0x035CD]  83 C4 04                 add     sp,4
F000:35D0  [+0x035D0]  C3                       ret
F000:35D1  [+0x035D1]  90                       nop
F000:35D2  [+0x035D2]  80 FC 06                 cmp     ah,6
F000:35D5  [+0x035D5]  74 04                    je      short 35DBh
F000:35D7  [+0x035D7]  D0 E1                    shl     cl,1
F000:35D9  [+0x035D9]  D0 E2                    shl     dl,1
F000:35DB  [+0x035DB]  8B F2                    mov     si,dx
F000:35DD  [+0x035DD]  8A D8                    mov     bl,al
F000:35DF  [+0x035DF]  8A C5                    mov     al,ch
F000:35E1  [+0x035E1]  32 E4                    xor     ah,ah
F000:35E3  [+0x035E3]  BF 40 01                 mov     di,140h
F000:35E6  [+0x035E6]  F7 E7                    mul     di
F000:35E8  [+0x035E8]  02 C1                    add     al,cl
F000:35EA  [+0x035EA]  80 D4 00                 adc     ah,0
F000:35ED  [+0x035ED]  8B 3E 4E 04              mov     di,[44Eh]
F000:35F1  [+0x035F1]  03 F8                    add     di,ax
F000:35F3  [+0x035F3]  8A C3                    mov     al,bl
F000:35F5  [+0x035F5]  32 E4                    xor     ah,ah
F000:35F7  [+0x035F7]  BA 40 01                 mov     dx,140h
F000:35FA  [+0x035FA]  F7 E2                    mul     dx
F000:35FC  [+0x035FC]  8B D6                    mov     dx,si
F000:35FE  [+0x035FE]  50                       push    ax
F000:35FF  [+0x035FF]  BB 50 00                 mov     bx,50h
F000:3602  [+0x03602]  2A DA                    sub     bl,dl
F000:3604  [+0x03604]  80 DF 00                 sbb     bh,0
F000:3607  [+0x03607]  8A 6E 03                 mov     ch,[bp+3]
F000:360A  [+0x0360A]  80 7E 01 07              cmp     byte [bp+1],7
F000:360E  [+0x0360E]  BD 00 20                 mov     bp,2000h
F000:3611  [+0x03611]  74 73                    je      short 3686h
F000:3613  [+0x03613]  8A CA                    mov     cl,dl
F000:3615  [+0x03615]  8B F7                    mov     si,di
F000:3617  [+0x03617]  03 F0                    add     si,ax
F000:3619  [+0x03619]  58                       pop     ax
F000:361A  [+0x0361A]  5A                       pop     dx
F000:361B  [+0x0361B]  51                       push    cx
F000:361C  [+0x0361C]  32 ED                    xor     ch,ch
F000:361E  [+0x0361E]  8C C0                    mov     ax,es
F000:3620  [+0x03620]  8E D8                    mov     ds,ax
F000:3622  [+0x03622]  0A F6                    or      dh,dh
F000:3624  [+0x03624]  74 30                    je      short 3656h
F000:3626  [+0x03626]  D0 E6                    shl     dh,1
F000:3628  [+0x03628]  D0 E6                    shl     dh,1
F000:362A  [+0x0362A]  8B C1                    mov     ax,cx
F000:362C  [+0x0362C]  8B C8                    mov     cx,ax
F000:362E  [+0x0362E]  D1 E9                    shr     cx,1
F000:3630  [+0x03630]  F3 A5                    rep movsw
F000:3632  [+0x03632]  D1 D1                    rcl     cx,1
F000:3634  [+0x03634]  F3 A4                    rep movsb
F000:3636  [+0x03636]  2B F8                    sub     di,ax
F000:3638  [+0x03638]  2B F0                    sub     si,ax
F000:363A  [+0x0363A]  03 F5                    add     si,bp
F000:363C  [+0x0363C]  03 FD                    add     di,bp
F000:363E  [+0x0363E]  8B C8                    mov     cx,ax
F000:3640  [+0x03640]  D1 E9                    shr     cx,1
F000:3642  [+0x03642]  F3 A5                    rep movsw
F000:3644  [+0x03644]  D1 D1                    rcl     cx,1
F000:3646  [+0x03646]  F3 A4                    rep movsb
F000:3648  [+0x03648]  2B F5                    sub     si,bp
F000:364A  [+0x0364A]  2B FD                    sub     di,bp
F000:364C  [+0x0364C]  03 F3                    add     si,bx
F000:364E  [+0x0364E]  03 FB                    add     di,bx
F000:3650  [+0x03650]  FE CE                    dec     dh
F000:3652  [+0x03652]  75 D8                    jne     short 362Ch
F000:3654  [+0x03654]  8B C8                    mov     cx,ax
F000:3656  [+0x03656]  58                       pop     ax
F000:3657  [+0x03657]  8A C4                    mov     al,ah
F000:3659  [+0x03659]  D0 E2                    shl     dl,1
F000:365B  [+0x0365B]  D0 E2                    shl     dl,1
F000:365D  [+0x0365D]  8B F1                    mov     si,cx
F000:365F  [+0x0365F]  8B CE                    mov     cx,si
F000:3661  [+0x03661]  D1 E9                    shr     cx,1
F000:3663  [+0x03663]  F3 AB                    rep stosw
F000:3665  [+0x03665]  D1 D1                    rcl     cx,1
F000:3667  [+0x03667]  F3 AA                    rep stosb
F000:3669  [+0x03669]  2B FE                    sub     di,si
F000:366B  [+0x0366B]  03 FD                    add     di,bp
F000:366D  [+0x0366D]  8B CE                    mov     cx,si
F000:366F  [+0x0366F]  D1 E9                    shr     cx,1
F000:3671  [+0x03671]  F3 AB                    rep stosw
F000:3673  [+0x03673]  D1 D1                    rcl     cx,1
F000:3675  [+0x03675]  F3 AA                    rep stosb
F000:3677  [+0x03677]  2B FD                    sub     di,bp
F000:3679  [+0x03679]  03 FB                    add     di,bx
F000:367B  [+0x0367B]  FE CA                    dec     dl
F000:367D  [+0x0367D]  75 E0                    jne     short 365Fh
F000:367F  [+0x0367F]  83 C4 04                 add     sp,4
F000:3682  [+0x03682]  C3                       ret
F000:3683  [+0x03683]  87 DB                    xchg    bx,bx
F000:3685  [+0x03685]  90                       nop
F000:3686  [+0x03686]  F7 D8                    neg     ax
F000:3688  [+0x03688]  F7 DB                    neg     bx
F000:368A  [+0x0368A]  F7 DD                    neg     bp
F000:368C  [+0x0368C]  81 C7 F0 20              add     di,20F0h
F000:3690  [+0x03690]  80 3E 49 04 06           cmp     byte [449h],6
F000:3695  [+0x03695]  74 01                    je      short 3698h
F000:3697  [+0x03697]  47                       inc     di
F000:3698  [+0x03698]  8A CA                    mov     cl,dl
F000:369A  [+0x0369A]  8B F7                    mov     si,di
F000:369C  [+0x0369C]  03 F0                    add     si,ax
F000:369E  [+0x0369E]  58                       pop     ax
F000:369F  [+0x0369F]  5A                       pop     dx
F000:36A0  [+0x036A0]  51                       push    cx
F000:36A1  [+0x036A1]  32 ED                    xor     ch,ch
F000:36A3  [+0x036A3]  8C C0                    mov     ax,es
F000:36A5  [+0x036A5]  8E D8                    mov     ds,ax
F000:36A7  [+0x036A7]  0A F6                    or      dh,dh
F000:36A9  [+0x036A9]  74 3A                    je      short 36E5h
F000:36AB  [+0x036AB]  D0 E6                    shl     dh,1
F000:36AD  [+0x036AD]  D0 E6                    shl     dh,1
F000:36AF  [+0x036AF]  8B C1                    mov     ax,cx
F000:36B1  [+0x036B1]  8B C8                    mov     cx,ax
F000:36B3  [+0x036B3]  D1 E9                    shr     cx,1
F000:36B5  [+0x036B5]  73 01                    jae     short 36B8h
F000:36B7  [+0x036B7]  A4                       movsb
F000:36B8  [+0x036B8]  E3 06                    jcxz    36C0h
F000:36BA  [+0x036BA]  4E                       dec     si
F000:36BB  [+0x036BB]  4F                       dec     di
F000:36BC  [+0x036BC]  F3 A5                    rep movsw
F000:36BE  [+0x036BE]  46                       inc     si
F000:36BF  [+0x036BF]  47                       inc     di
F000:36C0  [+0x036C0]  03 F0                    add     si,ax
F000:36C2  [+0x036C2]  03 F8                    add     di,ax
F000:36C4  [+0x036C4]  03 F5                    add     si,bp
F000:36C6  [+0x036C6]  03 FD                    add     di,bp
F000:36C8  [+0x036C8]  8B C8                    mov     cx,ax
F000:36CA  [+0x036CA]  D1 E9                    shr     cx,1
F000:36CC  [+0x036CC]  73 01                    jae     short 36CFh
F000:36CE  [+0x036CE]  A4                       movsb
F000:36CF  [+0x036CF]  E3 06                    jcxz    36D7h
F000:36D1  [+0x036D1]  4E                       dec     si
F000:36D2  [+0x036D2]  4F                       dec     di
F000:36D3  [+0x036D3]  F3 A5                    rep movsw
F000:36D5  [+0x036D5]  46                       inc     si
F000:36D6  [+0x036D6]  47                       inc     di
F000:36D7  [+0x036D7]  2B F5                    sub     si,bp
F000:36D9  [+0x036D9]  2B FD                    sub     di,bp
F000:36DB  [+0x036DB]  03 F3                    add     si,bx
F000:36DD  [+0x036DD]  03 FB                    add     di,bx
F000:36DF  [+0x036DF]  FE CE                    dec     dh
F000:36E1  [+0x036E1]  75 CE                    jne     short 36B1h
F000:36E3  [+0x036E3]  8B C8                    mov     cx,ax
F000:36E5  [+0x036E5]  58                       pop     ax
F000:36E6  [+0x036E6]  8A C4                    mov     al,ah
F000:36E8  [+0x036E8]  D0 E2                    shl     dl,1
F000:36EA  [+0x036EA]  D0 E2                    shl     dl,1
F000:36EC  [+0x036EC]  8B F1                    mov     si,cx
F000:36EE  [+0x036EE]  8B CE                    mov     cx,si
F000:36F0  [+0x036F0]  D1 E9                    shr     cx,1
F000:36F2  [+0x036F2]  73 01                    jae     short 36F5h
F000:36F4  [+0x036F4]  AA                       stosb
F000:36F5  [+0x036F5]  E3 04                    jcxz    36FBh
F000:36F7  [+0x036F7]  4F                       dec     di
F000:36F8  [+0x036F8]  F3 AB                    rep stosw
F000:36FA  [+0x036FA]  47                       inc     di
F000:36FB  [+0x036FB]  03 FE                    add     di,si
F000:36FD  [+0x036FD]  03 FD                    add     di,bp
F000:36FF  [+0x036FF]  8B CE                    mov     cx,si
F000:3701  [+0x03701]  D1 E9                    shr     cx,1
F000:3703  [+0x03703]  73 01                    jae     short 3706h
F000:3705  [+0x03705]  AA                       stosb
F000:3706  [+0x03706]  E3 04                    jcxz    370Ch
F000:3708  [+0x03708]  4F                       dec     di
F000:3709  [+0x03709]  F3 AB                    rep stosw
F000:370B  [+0x0370B]  47                       inc     di
F000:370C  [+0x0370C]  2B FD                    sub     di,bp
F000:370E  [+0x0370E]  03 FB                    add     di,bx
F000:3710  [+0x03710]  FE CA                    dec     dl
F000:3712  [+0x03712]  75 DA                    jne     short 36EEh
F000:3714  [+0x03714]  83 C4 04                 add     sp,4
F000:3717  [+0x03717]  C3                       ret
F000:3718  [+0x03718]  87 DB                    xchg    bx,bx
F000:371A  [+0x0371A]  FD                       std
F000:371B  [+0x0371B]  8B C2                    mov     ax,dx
F000:371D  [+0x0371D]  8B F2                    mov     si,dx
F000:371F  [+0x0371F]  8B F8                    mov     di,ax
F000:3721  [+0x03721]  81 E7 FF 00              and     di,0FFh
F000:3725  [+0x03725]  8A C4                    mov     al,ah
F000:3727  [+0x03727]  F6 26 4A 04              mul     byte [44Ah]
F000:372B  [+0x0372B]  F7 26 85 04              mul     word [485h]
F000:372F  [+0x0372F]  03 F8                    add     di,ax
F000:3731  [+0x03731]  32 E4                    xor     ah,ah
F000:3733  [+0x03733]  A0 62 04                 mov     al,[462h]
F000:3736  [+0x03736]  F7 26 4C 04              mul     word [44Ch]
F000:373A  [+0x0373A]  03 F8                    add     di,ax
F000:373C  [+0x0373C]  8B 1E 85 04              mov     bx,[485h]
F000:3740  [+0x03740]  4B                       dec     bx
F000:3741  [+0x03741]  A1 4A 04                 mov     ax,[44Ah]
F000:3744  [+0x03744]  F7 E3                    mul     bx
F000:3746  [+0x03746]  03 F8                    add     di,ax
F000:3748  [+0x03748]  8B D6                    mov     dx,si
F000:374A  [+0x0374A]  EB 23                    jmp     short 376Fh
F000:374C  [+0x0374C]  87 DB                    xchg    bx,bx
F000:374E  [+0x0374E]  8B F2                    mov     si,dx
F000:3750  [+0x03750]  8B F8                    mov     di,ax
F000:3752  [+0x03752]  81 E7 FF 00              and     di,0FFh
F000:3756  [+0x03756]  8A C4                    mov     al,ah
F000:3758  [+0x03758]  F6 26 4A 04              mul     byte [44Ah]
F000:375C  [+0x0375C]  F7 26 85 04              mul     word [485h]
F000:3760  [+0x03760]  03 F8                    add     di,ax
F000:3762  [+0x03762]  32 E4                    xor     ah,ah
F000:3764  [+0x03764]  A0 62 04                 mov     al,[462h]
F000:3767  [+0x03767]  F7 26 4C 04              mul     word [44Ch]
F000:376B  [+0x0376B]  03 F8                    add     di,ax
F000:376D  [+0x0376D]  8B D6                    mov     dx,si
F000:376F  [+0x0376F]  2B D1                    sub     dx,cx
F000:3771  [+0x03771]  FE C6                    inc     dh
F000:3773  [+0x03773]  FE C2                    inc     dl
F000:3775  [+0x03775]  8A 46 00                 mov     al,[bp]
F000:3778  [+0x03778]  8A E6                    mov     ah,dh
F000:377A  [+0x0377A]  0A C0                    or      al,al
F000:377C  [+0x0377C]  74 04                    je      short 3782h
F000:377E  [+0x0377E]  2A E0                    sub     ah,al
F000:3780  [+0x03780]  77 04                    ja      short 3786h
F000:3782  [+0x03782]  8A C6                    mov     al,dh
F000:3784  [+0x03784]  32 E4                    xor     ah,ah
F000:3786  [+0x03786]  8B C8                    mov     cx,ax
F000:3788  [+0x03788]  8B F2                    mov     si,dx
F000:378A  [+0x0378A]  B8 05 01                 mov     ax,105h
F000:378D  [+0x0378D]  BA CE 03                 mov     dx,3CEh
F000:3790  [+0x03790]  EF                       out     dx,ax
F000:3791  [+0x03791]  B8 02 0F                 mov     ax,0F02h
F000:3794  [+0x03794]  BA C4 03                 mov     dx,3C4h
F000:3797  [+0x03797]  EF                       out     dx,ax
F000:3798  [+0x03798]  8B C1                    mov     ax,cx
F000:379A  [+0x0379A]  50                       push    ax
F000:379B  [+0x0379B]  8B 1E 4A 04              mov     bx,[44Ah]
F000:379F  [+0x0379F]  F6 E3                    mul     bl
F000:37A1  [+0x037A1]  F7 26 85 04              mul     word [485h]
F000:37A5  [+0x037A5]  8B C8                    mov     cx,ax
F000:37A7  [+0x037A7]  8B D6                    mov     dx,si
F000:37A9  [+0x037A9]  2A DA                    sub     bl,dl
F000:37AB  [+0x037AB]  80 DF 00                 sbb     bh,0
F000:37AE  [+0x037AE]  80 7E 01 07              cmp     byte [bp+1],7
F000:37B2  [+0x037B2]  75 04                    jne     short 37B8h
F000:37B4  [+0x037B4]  F7 D8                    neg     ax
F000:37B6  [+0x037B6]  F7 DB                    neg     bx
F000:37B8  [+0x037B8]  8B F7                    mov     si,di
F000:37BA  [+0x037BA]  03 F0                    add     si,ax
F000:37BC  [+0x037BC]  8B C1                    mov     ax,cx
F000:37BE  [+0x037BE]  8A CA                    mov     cl,dl
F000:37C0  [+0x037C0]  32 ED                    xor     ch,ch
F000:37C2  [+0x037C2]  5A                       pop     dx
F000:37C3  [+0x037C3]  3B 0E 4A 04              cmp     cx,[44Ah]
F000:37C7  [+0x037C7]  75 33                    jne     short 37FCh
F000:37C9  [+0x037C9]  8B D8                    mov     bx,ax
F000:37CB  [+0x037CB]  8A C1                    mov     al,cl
F000:37CD  [+0x037CD]  F6 E6                    mul     dh
F000:37CF  [+0x037CF]  F7 26 85 04              mul     word [485h]
F000:37D3  [+0x037D3]  8B C8                    mov     cx,ax
F000:37D5  [+0x037D5]  B8 00 A0                 mov     ax,0A000h
F000:37D8  [+0x037D8]  8E C0                    mov     es,ax
F000:37DA  [+0x037DA]  8E D8                    mov     ds,ax
F000:37DC  [+0x037DC]  F3 A4                    rep movsb
F000:37DE  [+0x037DE]  8B CB                    mov     cx,bx
F000:37E0  [+0x037E0]  BA CE 03                 mov     dx,3CEh
F000:37E3  [+0x037E3]  B8 05 00                 mov     ax,5
F000:37E6  [+0x037E6]  EF                       out     dx,ax
F000:37E7  [+0x037E7]  8A 66 03                 mov     ah,[bp+3]
F000:37EA  [+0x037EA]  32 C0                    xor     al,al
F000:37EC  [+0x037EC]  EF                       out     dx,ax
F000:37ED  [+0x037ED]  FE C0                    inc     al
F000:37EF  [+0x037EF]  EF                       out     dx,ax
F000:37F0  [+0x037F0]  33 C0                    xor     ax,ax
F000:37F2  [+0x037F2]  F3 AA                    rep stosb
F000:37F4  [+0x037F4]  EF                       out     dx,ax
F000:37F5  [+0x037F5]  FE C0                    inc     al
F000:37F7  [+0x037F7]  EF                       out     dx,ax
F000:37F8  [+0x037F8]  83 C4 04                 add     sp,4
F000:37FB  [+0x037FB]  C3                       ret
F000:37FC  [+0x037FC]  A0 85 04                 mov     al,[485h]
F000:37FF  [+0x037FF]  F6 E6                    mul     dh
F000:3801  [+0x03801]  52                       push    dx
F000:3802  [+0x03802]  8B D0                    mov     dx,ax
F000:3804  [+0x03804]  B8 00 A0                 mov     ax,0A000h
F000:3807  [+0x03807]  8E D8                    mov     ds,ax
F000:3809  [+0x03809]  8E C0                    mov     es,ax
F000:380B  [+0x0380B]  0B D2                    or      dx,dx
F000:380D  [+0x0380D]  74 0D                    je      short 381Ch
F000:380F  [+0x0380F]  8B C1                    mov     ax,cx
F000:3811  [+0x03811]  F3 A4                    rep movsb
F000:3813  [+0x03813]  8B C8                    mov     cx,ax
F000:3815  [+0x03815]  03 F3                    add     si,bx
F000:3817  [+0x03817]  03 FB                    add     di,bx
F000:3819  [+0x03819]  4A                       dec     dx
F000:381A  [+0x0381A]  75 F3                    jne     short 380Fh
F000:381C  [+0x0381C]  2E 8E 1E 77 26           mov     ds,[cs:2677h]
F000:3821  [+0x03821]  5E                       pop     si
F000:3822  [+0x03822]  BA CE 03                 mov     dx,3CEh
F000:3825  [+0x03825]  B8 05 00                 mov     ax,5
F000:3828  [+0x03828]  EF                       out     dx,ax
F000:3829  [+0x03829]  8A 66 03                 mov     ah,[bp+3]
F000:382C  [+0x0382C]  32 C0                    xor     al,al
F000:382E  [+0x0382E]  EF                       out     dx,ax
F000:382F  [+0x0382F]  FE C0                    inc     al
F000:3831  [+0x03831]  EF                       out     dx,ax
F000:3832  [+0x03832]  8B D6                    mov     dx,si
F000:3834  [+0x03834]  A0 85 04                 mov     al,[485h]
F000:3837  [+0x03837]  F6 E2                    mul     dl
F000:3839  [+0x03839]  8B D0                    mov     dx,ax
F000:383B  [+0x0383B]  33 C0                    xor     ax,ax
F000:383D  [+0x0383D]  8B F1                    mov     si,cx
F000:383F  [+0x0383F]  F3 AA                    rep stosb
F000:3841  [+0x03841]  03 FB                    add     di,bx
F000:3843  [+0x03843]  8B CE                    mov     cx,si
F000:3845  [+0x03845]  4A                       dec     dx
F000:3846  [+0x03846]  75 F5                    jne     short 383Dh
F000:3848  [+0x03848]  BA CE 03                 mov     dx,3CEh
F000:384B  [+0x0384B]  EF                       out     dx,ax
F000:384C  [+0x0384C]  FE C0                    inc     al
F000:384E  [+0x0384E]  EF                       out     dx,ax
F000:384F  [+0x0384F]  83 C4 04                 add     sp,4
F000:3852  [+0x03852]  C3                       ret
F000:3853  [+0x03853]  87 DB                    xchg    bx,bx
F000:3855  [+0x03855]  90                       nop
F000:3856  [+0x03856]  FD                       std
F000:3857  [+0x03857]  8B C2                    mov     ax,dx
F000:3859  [+0x03859]  8B F2                    mov     si,dx
F000:385B  [+0x0385B]  8B F8                    mov     di,ax
F000:385D  [+0x0385D]  81 E7 FF 00              and     di,0FFh
F000:3861  [+0x03861]  8A C4                    mov     al,ah
F000:3863  [+0x03863]  F6 26 4A 04              mul     byte [44Ah]
F000:3867  [+0x03867]  F7 26 85 04              mul     word [485h]
F000:386B  [+0x0386B]  03 F8                    add     di,ax
F000:386D  [+0x0386D]  8B 1E 85 04              mov     bx,[485h]
F000:3871  [+0x03871]  4B                       dec     bx
F000:3872  [+0x03872]  A1 4A 04                 mov     ax,[44Ah]
F000:3875  [+0x03875]  F7 E3                    mul     bx
F000:3877  [+0x03877]  03 F8                    add     di,ax
F000:3879  [+0x03879]  D1 E7                    shl     di,1
F000:387B  [+0x0387B]  D1 E7                    shl     di,1
F000:387D  [+0x0387D]  D1 E7                    shl     di,1
F000:387F  [+0x0387F]  83 C7 06                 add     di,6
F000:3882  [+0x03882]  8B D6                    mov     dx,si
F000:3884  [+0x03884]  2B D1                    sub     dx,cx
F000:3886  [+0x03886]  FE C6                    inc     dh
F000:3888  [+0x03888]  FE C2                    inc     dl
F000:388A  [+0x0388A]  8A 46 00                 mov     al,[bp]
F000:388D  [+0x0388D]  8A E6                    mov     ah,dh
F000:388F  [+0x0388F]  0A C0                    or      al,al
F000:3891  [+0x03891]  74 04                    je      short 3897h
F000:3893  [+0x03893]  2A E0                    sub     ah,al
F000:3895  [+0x03895]  77 04                    ja      short 389Bh
F000:3897  [+0x03897]  8A C6                    mov     al,dh
F000:3899  [+0x03899]  32 E4                    xor     ah,ah
F000:389B  [+0x0389B]  50                       push    ax
F000:389C  [+0x0389C]  8B F2                    mov     si,dx
F000:389E  [+0x0389E]  8B 1E 4A 04              mov     bx,[44Ah]
F000:38A2  [+0x038A2]  F6 E3                    mul     bl
F000:38A4  [+0x038A4]  F7 26 85 04              mul     word [485h]
F000:38A8  [+0x038A8]  8B D6                    mov     dx,si
F000:38AA  [+0x038AA]  D1 E0                    shl     ax,1
F000:38AC  [+0x038AC]  D1 E0                    shl     ax,1
F000:38AE  [+0x038AE]  50                       push    ax
F000:38AF  [+0x038AF]  D1 E0                    shl     ax,1
F000:38B1  [+0x038B1]  2A DA                    sub     bl,dl
F000:38B3  [+0x038B3]  80 DF 00                 sbb     bh,0
F000:38B6  [+0x038B6]  80 7E 01 07              cmp     byte [bp+1],7
F000:38BA  [+0x038BA]  75 04                    jne     short 38C0h
F000:38BC  [+0x038BC]  F7 D8                    neg     ax
F000:38BE  [+0x038BE]  F7 DB                    neg     bx
F000:38C0  [+0x038C0]  8A CA                    mov     cl,dl
F000:38C2  [+0x038C2]  B5 00                    mov     ch,0
F000:38C4  [+0x038C4]  8B F7                    mov     si,di
F000:38C6  [+0x038C6]  03 F0                    add     si,ax
F000:38C8  [+0x038C8]  58                       pop     ax
F000:38C9  [+0x038C9]  5A                       pop     dx
F000:38CA  [+0x038CA]  3B 0E 4A 04              cmp     cx,[44Ah]
F000:38CE  [+0x038CE]  75 26                    jne     short 38F6h
F000:38D0  [+0x038D0]  8B D8                    mov     bx,ax
F000:38D2  [+0x038D2]  8A C1                    mov     al,cl
F000:38D4  [+0x038D4]  F6 E6                    mul     dh
F000:38D6  [+0x038D6]  F7 26 85 04              mul     word [485h]
F000:38DA  [+0x038DA]  8B C8                    mov     cx,ax
F000:38DC  [+0x038DC]  D1 E1                    shl     cx,1
F000:38DE  [+0x038DE]  D1 E1                    shl     cx,1
F000:38E0  [+0x038E0]  B8 00 A0                 mov     ax,0A000h
F000:38E3  [+0x038E3]  8E C0                    mov     es,ax
F000:38E5  [+0x038E5]  8E D8                    mov     ds,ax
F000:38E7  [+0x038E7]  F3 A5                    rep movsw
F000:38E9  [+0x038E9]  8B CB                    mov     cx,bx
F000:38EB  [+0x038EB]  8A 46 03                 mov     al,[bp+3]
F000:38EE  [+0x038EE]  8A E0                    mov     ah,al
F000:38F0  [+0x038F0]  F3 AB                    rep stosw
F000:38F2  [+0x038F2]  83 C4 04                 add     sp,4
F000:38F5  [+0x038F5]  C3                       ret
F000:38F6  [+0x038F6]  D1 E3                    shl     bx,1
F000:38F8  [+0x038F8]  D1 E3                    shl     bx,1
F000:38FA  [+0x038FA]  D1 E3                    shl     bx,1
F000:38FC  [+0x038FC]  D1 E1                    shl     cx,1
F000:38FE  [+0x038FE]  D1 E1                    shl     cx,1
F000:3900  [+0x03900]  A0 85 04                 mov     al,[485h]
F000:3903  [+0x03903]  F6 E6                    mul     dh
F000:3905  [+0x03905]  52                       push    dx
F000:3906  [+0x03906]  8B D0                    mov     dx,ax
F000:3908  [+0x03908]  B8 00 A0                 mov     ax,0A000h
F000:390B  [+0x0390B]  8E D8                    mov     ds,ax
F000:390D  [+0x0390D]  8E C0                    mov     es,ax
F000:390F  [+0x0390F]  0B D2                    or      dx,dx
F000:3911  [+0x03911]  74 0D                    je      short 3920h
F000:3913  [+0x03913]  8B C1                    mov     ax,cx
F000:3915  [+0x03915]  F3 A5                    rep movsw
F000:3917  [+0x03917]  8B C8                    mov     cx,ax
F000:3919  [+0x03919]  03 F3                    add     si,bx
F000:391B  [+0x0391B]  03 FB                    add     di,bx
F000:391D  [+0x0391D]  4A                       dec     dx
F000:391E  [+0x0391E]  75 F3                    jne     short 3913h
F000:3920  [+0x03920]  5A                       pop     dx
F000:3921  [+0x03921]  2E 8E 1E 77 26           mov     ds,[cs:2677h]
F000:3926  [+0x03926]  A0 85 04                 mov     al,[485h]
F000:3929  [+0x03929]  F6 E2                    mul     dl
F000:392B  [+0x0392B]  8B D0                    mov     dx,ax
F000:392D  [+0x0392D]  8A 46 03                 mov     al,[bp+3]
F000:3930  [+0x03930]  8A E0                    mov     ah,al
F000:3932  [+0x03932]  8B F1                    mov     si,cx
F000:3934  [+0x03934]  F3 AB                    rep stosw
F000:3936  [+0x03936]  03 FB                    add     di,bx
F000:3938  [+0x03938]  8B CE                    mov     cx,si
F000:393A  [+0x0393A]  4A                       dec     dx
F000:393B  [+0x0393B]  75 F5                    jne     short 3932h
F000:393D  [+0x0393D]  83 C4 04                 add     sp,4
F000:3940  [+0x03940]  C3                       ret
F000:3941  [+0x03941]  00 E8                    add     al,ch
F000:3943  [+0x03943]  05 00 89                 add     ax,8900h
F000:3946  [+0x03946]  46                       inc     si
F000:3947  [+0x03947]  10 C3                    adc     bl,al
F000:3949  [+0x03949]  90                       nop
F000:394A  [+0x0394A]  8A 26 49 04              mov     ah,[449h]
F000:394E  [+0x0394E]  80 FC 07                 cmp     ah,7
F000:3951  [+0x03951]  76 0F                    jbe     short 3962h
F000:3953  [+0x03953]  80 FC 13                 cmp     ah,13h
F000:3956  [+0x03956]  74 2F                    je      short 3987h
F000:3958  [+0x03958]  72 04                    jb      short 395Eh
F000:395A  [+0x0395A]  E9 E6 E3                 jmp     1D43h
F000:395D  [+0x0395D]  90                       nop
F000:395E  [+0x0395E]  E9 F5 00                 jmp     3A56h
F000:3961  [+0x03961]  90                       nop
F000:3962  [+0x03962]  8B D0                    mov     dx,ax
F000:3964  [+0x03964]  A1 10 04                 mov     ax,[410h]
F000:3967  [+0x03967]  24 30                    and     al,30h
F000:3969  [+0x03969]  3C 30                    cmp     al,30h
F000:396B  [+0x0396B]  B8 00 B0                 mov     ax,0B000h
F000:396E  [+0x0396E]  74 02                    je      short 3972h
F000:3970  [+0x03970]  B4 B8                    mov     ah,0B8h
F000:3972  [+0x03972]  8E C0                    mov     es,ax
F000:3974  [+0x03974]  8B C2                    mov     ax,dx
F000:3976  [+0x03976]  80 FC 02                 cmp     ah,2
F000:3979  [+0x03979]  72 0F                    jb      short 398Ah
F000:397B  [+0x0397B]  80 FC 04                 cmp     ah,4
F000:397E  [+0x0397E]  72 28                    jb      short 39A8h
F000:3980  [+0x03980]  80 FC 07                 cmp     ah,7
F000:3983  [+0x03983]  74 05                    je      short 398Ah
F000:3985  [+0x03985]  EB 47                    jmp     short 39CEh
F000:3987  [+0x03987]  E9 53 01                 jmp     3ADDh
F000:398A  [+0x0398A]  0A FF                    or      bh,bh
F000:398C  [+0x0398C]  75 13                    jne     short 39A1h
F000:398E  [+0x0398E]  8B 1E 50 04              mov     bx,[450h]
F000:3992  [+0x03992]  A0 4A 04                 mov     al,[44Ah]
F000:3995  [+0x03995]  F6 E7                    mul     bh
F000:3997  [+0x03997]  32 FF                    xor     bh,bh
F000:3999  [+0x03999]  03 D8                    add     bx,ax
F000:399B  [+0x0399B]  D1 E3                    shl     bx,1
F000:399D  [+0x0399D]  26 8B 07                 mov     ax,[es:bx]
F000:39A0  [+0x039A0]  C3                       ret
F000:39A1  [+0x039A1]  E8 F6 01                 call    3B9Ah
F000:39A4  [+0x039A4]  26 8B 05                 mov     ax,[es:di]
F000:39A7  [+0x039A7]  C3                       ret
F000:39A8  [+0x039A8]  F6 06 87 04 04           test    byte [487h],4
F000:39AD  [+0x039AD]  74 DB                    je      short 398Ah
F000:39AF  [+0x039AF]  E8 E8 01                 call    3B9Ah
F000:39B2  [+0x039B2]  8B 16 63 04              mov     dx,[463h]
F000:39B6  [+0x039B6]  83 C2 06                 add     dx,6
F000:39B9  [+0x039B9]  8C C0                    mov     ax,es
F000:39BB  [+0x039BB]  8E D8                    mov     ds,ax
F000:39BD  [+0x039BD]  8B F7                    mov     si,di
F000:39BF  [+0x039BF]  EC                       in      al,dx
F000:39C0  [+0x039C0]  24 01                    and     al,1
F000:39C2  [+0x039C2]  75 FB                    jne     short 39BFh
F000:39C4  [+0x039C4]  9C                       pushf
F000:39C5  [+0x039C5]  FA                       cli
F000:39C6  [+0x039C6]  EC                       in      al,dx
F000:39C7  [+0x039C7]  24 01                    and     al,1
F000:39C9  [+0x039C9]  74 FB                    je      short 39C6h
F000:39CB  [+0x039CB]  AD                       lodsw
F000:39CC  [+0x039CC]  9D                       popf
F000:39CD  [+0x039CD]  C3                       ret
F000:39CE  [+0x039CE]  A0 51 04                 mov     al,[451h]
F000:39D1  [+0x039D1]  F6 26 4A 04              mul     byte [44Ah]
F000:39D5  [+0x039D5]  8B F8                    mov     di,ax
F000:39D7  [+0x039D7]  D1 E7                    shl     di,1
F000:39D9  [+0x039D9]  D1 E7                    shl     di,1
F000:39DB  [+0x039DB]  A0 50 04                 mov     al,[450h]
F000:39DE  [+0x039DE]  32 E4                    xor     ah,ah
F000:39E0  [+0x039E0]  03 F8                    add     di,ax
F000:39E2  [+0x039E2]  8A 26 49 04              mov     ah,[449h]
F000:39E6  [+0x039E6]  80 FC 06                 cmp     ah,6
F000:39E9  [+0x039E9]  74 02                    je      short 39EDh
F000:39EB  [+0x039EB]  D1 E7                    shl     di,1
F000:39ED  [+0x039ED]  81 C7 F0 20              add     di,20F0h
F000:39F1  [+0x039F1]  80 FC 06                 cmp     ah,6
F000:39F4  [+0x039F4]  8B F7                    mov     si,di
F000:39F6  [+0x039F6]  8C C0                    mov     ax,es
F000:39F8  [+0x039F8]  8E D8                    mov     ds,ax
F000:39FA  [+0x039FA]  B9 04 00                 mov     cx,4
F000:39FD  [+0x039FD]  74 15                    je      short 3A14h
F000:39FF  [+0x039FF]  E8 5D 01                 call    3B5Fh
F000:3A02  [+0x03A02]  8A FB                    mov     bh,bl
F000:3A04  [+0x03A04]  81 EE 02 20              sub     si,2002h
F000:3A08  [+0x03A08]  E8 54 01                 call    3B5Fh
F000:3A0B  [+0x03A0B]  81 C6 AE 1F              add     si,1FAEh
F000:3A0F  [+0x03A0F]  53                       push    bx
F000:3A10  [+0x03A10]  E2 ED                    loop    39FFh
F000:3A12  [+0x03A12]  EB 0F                    jmp     short 3A23h
F000:3A14  [+0x03A14]  AC                       lodsb
F000:3A15  [+0x03A15]  8A E0                    mov     ah,al
F000:3A17  [+0x03A17]  81 EE 01 20              sub     si,2001h
F000:3A1B  [+0x03A1B]  AC                       lodsb
F000:3A1C  [+0x03A1C]  81 C6 AF 1F              add     si,1FAFh
F000:3A20  [+0x03A20]  50                       push    ax
F000:3A21  [+0x03A21]  E2 F1                    loop    3A14h
F000:3A23  [+0x03A23]  8B F4                    mov     si,sp
F000:3A25  [+0x03A25]  8C D0                    mov     ax,ss
F000:3A27  [+0x03A27]  8E D8                    mov     ds,ax
F000:3A29  [+0x03A29]  8C C8                    mov     ax,cs
F000:3A2B  [+0x03A2B]  8E C0                    mov     es,ax
F000:3A2D  [+0x03A2D]  BF 54 56                 mov     di,5654h
F000:3A30  [+0x03A30]  BA 80 00                 mov     dx,80h
F000:3A33  [+0x03A33]  E8 3E 01                 call    3B74h
F000:3A36  [+0x03A36]  75 1A                    jne     short 3A52h
F000:3A38  [+0x03A38]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:3A3D  [+0x03A3D]  26 C4 3E 7C 00           les     di,[es:7Ch]
F000:3A42  [+0x03A42]  8C C0                    mov     ax,es
F000:3A44  [+0x03A44]  0B C7                    or      ax,di
F000:3A46  [+0x03A46]  74 0A                    je      short 3A52h
F000:3A48  [+0x03A48]  BA 80 00                 mov     dx,80h
F000:3A4B  [+0x03A4B]  E8 26 01                 call    3B74h
F000:3A4E  [+0x03A4E]  74 02                    je      short 3A52h
F000:3A50  [+0x03A50]  04 80                    add     al,80h
F000:3A52  [+0x03A52]  83 C4 08                 add     sp,8
F000:3A55  [+0x03A55]  C3                       ret
F000:3A56  [+0x03A56]  B8 00 A0                 mov     ax,0A000h
F000:3A59  [+0x03A59]  8E C0                    mov     es,ax
F000:3A5B  [+0x03A5B]  8A C7                    mov     al,bh
F000:3A5D  [+0x03A5D]  32 E4                    xor     ah,ah
F000:3A5F  [+0x03A5F]  D1 E0                    shl     ax,1
F000:3A61  [+0x03A61]  8B F0                    mov     si,ax
F000:3A63  [+0x03A63]  8B 84 50 04              mov     ax,[si+450h]
F000:3A67  [+0x03A67]  8B F0                    mov     si,ax
F000:3A69  [+0x03A69]  81 E6 FF 00              and     si,0FFh
F000:3A6D  [+0x03A6D]  8A C4                    mov     al,ah
F000:3A6F  [+0x03A6F]  F6 26 4A 04              mul     byte [44Ah]
F000:3A73  [+0x03A73]  F7 26 85 04              mul     word [485h]
F000:3A77  [+0x03A77]  03 F0                    add     si,ax
F000:3A79  [+0x03A79]  32 E4                    xor     ah,ah
F000:3A7B  [+0x03A7B]  8A C7                    mov     al,bh
F000:3A7D  [+0x03A7D]  F7 26 4C 04              mul     word [44Ch]
F000:3A81  [+0x03A81]  03 F0                    add     si,ax
F000:3A83  [+0x03A83]  A0 85 04                 mov     al,[485h]
F000:3A86  [+0x03A86]  FE C8                    dec     al
F000:3A88  [+0x03A88]  F6 26 4A 04              mul     byte [44Ah]
F000:3A8C  [+0x03A8C]  03 F0                    add     si,ax
F000:3A8E  [+0x03A8E]  B8 05 08                 mov     ax,805h
F000:3A91  [+0x03A91]  BA CE 03                 mov     dx,3CEh
F000:3A94  [+0x03A94]  EF                       out     dx,ax
F000:3A95  [+0x03A95]  8B 0E 85 04              mov     cx,[485h]
F000:3A99  [+0x03A99]  8B 1E 4A 04              mov     bx,[44Ah]
F000:3A9D  [+0x03A9D]  43                       inc     bx
F000:3A9E  [+0x03A9E]  26 AC                    es lodsb
F000:3AA0  [+0x03AA0]  8A E0                    mov     ah,al
F000:3AA2  [+0x03AA2]  F6 D4                    not     ah
F000:3AA4  [+0x03AA4]  50                       push    ax
F000:3AA5  [+0x03AA5]  44                       inc     sp
F000:3AA6  [+0x03AA6]  2B F3                    sub     si,bx
F000:3AA8  [+0x03AA8]  E2 F4                    loop    3A9Eh
F000:3AAA  [+0x03AAA]  B8 05 00                 mov     ax,5
F000:3AAD  [+0x03AAD]  EF                       out     dx,ax
F000:3AAE  [+0x03AAE]  8B F4                    mov     si,sp
F000:3AB0  [+0x03AB0]  32 C0                    xor     al,al
F000:3AB2  [+0x03AB2]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:3AB7  [+0x03AB7]  26 C4 1E 0C 01           les     bx,[es:10Ch]
F000:3ABC  [+0x03ABC]  8B D6                    mov     dx,si
F000:3ABE  [+0x03ABE]  9C                       pushf
F000:3ABF  [+0x03ABF]  FA                       cli
F000:3AC0  [+0x03AC0]  8B FB                    mov     di,bx
F000:3AC2  [+0x03AC2]  8B 0E 85 04              mov     cx,[485h]
F000:3AC6  [+0x03AC6]  F3 36 A6                 ss repe cmpsb
F000:3AC9  [+0x03AC9]  74 0A                    je      short 3AD5h
F000:3ACB  [+0x03ACB]  03 1E 85 04              add     bx,[485h]
F000:3ACF  [+0x03ACF]  8B F2                    mov     si,dx
F000:3AD1  [+0x03AD1]  FE C0                    inc     al
F000:3AD3  [+0x03AD3]  75 EB                    jne     short 3AC0h
F000:3AD5  [+0x03AD5]  9D                       popf
F000:3AD6  [+0x03AD6]  B4 05                    mov     ah,5
F000:3AD8  [+0x03AD8]  03 26 85 04              add     sp,[485h]
F000:3ADC  [+0x03ADC]  C3                       ret
F000:3ADD  [+0x03ADD]  B8 00 A0                 mov     ax,0A000h
F000:3AE0  [+0x03AE0]  8E C0                    mov     es,ax
F000:3AE2  [+0x03AE2]  A1 50 04                 mov     ax,[450h]
F000:3AE5  [+0x03AE5]  8B F8                    mov     di,ax
F000:3AE7  [+0x03AE7]  81 E7 FF 00              and     di,0FFh
F000:3AEB  [+0x03AEB]  8A C4                    mov     al,ah
F000:3AED  [+0x03AED]  F6 26 4A 04              mul     byte [44Ah]
F000:3AF1  [+0x03AF1]  F7 26 85 04              mul     word [485h]
F000:3AF5  [+0x03AF5]  03 F8                    add     di,ax
F000:3AF7  [+0x03AF7]  D1 E7                    shl     di,1
F000:3AF9  [+0x03AF9]  D1 E7                    shl     di,1
F000:3AFB  [+0x03AFB]  D1 E7                    shl     di,1
F000:3AFD  [+0x03AFD]  A0 85 04                 mov     al,[485h]
F000:3B00  [+0x03B00]  FE C8                    dec     al
F000:3B02  [+0x03B02]  F6 26 4A 04              mul     byte [44Ah]
F000:3B06  [+0x03B06]  B1 03                    mov     cl,3
F000:3B08  [+0x03B08]  D3 E0                    shl     ax,cl
F000:3B0A  [+0x03B0A]  8B F7                    mov     si,di
F000:3B0C  [+0x03B0C]  03 F0                    add     si,ax
F000:3B0E  [+0x03B0E]  8B 16 4A 04              mov     dx,[44Ah]
F000:3B12  [+0x03B12]  D3 E2                    shl     dx,cl
F000:3B14  [+0x03B14]  83 C2 08                 add     dx,8
F000:3B17  [+0x03B17]  8B 0E 85 04              mov     cx,[485h]
F000:3B1B  [+0x03B1B]  B3 08                    mov     bl,8
F000:3B1D  [+0x03B1D]  32 E4                    xor     ah,ah
F000:3B1F  [+0x03B1F]  26 AC                    es lodsb
F000:3B21  [+0x03B21]  3C 01                    cmp     al,1
F000:3B23  [+0x03B23]  F5                       cmc
F000:3B24  [+0x03B24]  D0 D4                    rcl     ah,1
F000:3B26  [+0x03B26]  FE CB                    dec     bl
F000:3B28  [+0x03B28]  75 F5                    jne     short 3B1Fh
F000:3B2A  [+0x03B2A]  50                       push    ax
F000:3B2B  [+0x03B2B]  44                       inc     sp
F000:3B2C  [+0x03B2C]  2B F2                    sub     si,dx
F000:3B2E  [+0x03B2E]  E2 EB                    loop    3B1Bh
F000:3B30  [+0x03B30]  8B F4                    mov     si,sp
F000:3B32  [+0x03B32]  32 C0                    xor     al,al
F000:3B34  [+0x03B34]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:3B39  [+0x03B39]  26 C4 1E 0C 01           les     bx,[es:10Ch]
F000:3B3E  [+0x03B3E]  8B D6                    mov     dx,si
F000:3B40  [+0x03B40]  9C                       pushf
F000:3B41  [+0x03B41]  FA                       cli
F000:3B42  [+0x03B42]  8B FB                    mov     di,bx
F000:3B44  [+0x03B44]  8B 0E 85 04              mov     cx,[485h]
F000:3B48  [+0x03B48]  F3 36 A6                 ss repe cmpsb
F000:3B4B  [+0x03B4B]  74 0A                    je      short 3B57h
F000:3B4D  [+0x03B4D]  03 1E 85 04              add     bx,[485h]
F000:3B51  [+0x03B51]  8B F2                    mov     si,dx
F000:3B53  [+0x03B53]  FE C0                    inc     al
F000:3B55  [+0x03B55]  75 EB                    jne     short 3B42h
F000:3B57  [+0x03B57]  9D                       popf
F000:3B58  [+0x03B58]  32 E4                    xor     ah,ah
F000:3B5A  [+0x03B5A]  03 26 85 04              add     sp,[485h]
F000:3B5E  [+0x03B5E]  C3                       ret
F000:3B5F  [+0x03B5F]  B2 08                    mov     dl,8
F000:3B61  [+0x03B61]  32 DB                    xor     bl,bl
F000:3B63  [+0x03B63]  AD                       lodsw
F000:3B64  [+0x03B64]  86 C4                    xchg    al,ah
F000:3B66  [+0x03B66]  D1 E0                    shl     ax,1
F000:3B68  [+0x03B68]  79 01                    jns     short 3B6Bh
F000:3B6A  [+0x03B6A]  F9                       stc
F000:3B6B  [+0x03B6B]  D0 D3                    rcl     bl,1
F000:3B6D  [+0x03B6D]  D1 E0                    shl     ax,1
F000:3B6F  [+0x03B6F]  FE CA                    dec     dl
F000:3B71  [+0x03B71]  75 F3                    jne     short 3B66h
F000:3B73  [+0x03B73]  C3                       ret
F000:3B74  [+0x03B74]  8B DF                    mov     bx,di
F000:3B76  [+0x03B76]  55                       push    bp
F000:3B77  [+0x03B77]  8B C6                    mov     ax,si
F000:3B79  [+0x03B79]  8B EF                    mov     bp,di
F000:3B7B  [+0x03B7B]  B9 04 00                 mov     cx,4
F000:3B7E  [+0x03B7E]  F3 A7                    repe cmpsw
F000:3B80  [+0x03B80]  8B FD                    mov     di,bp
F000:3B82  [+0x03B82]  74 0A                    je      short 3B8Eh
F000:3B84  [+0x03B84]  83 C7 08                 add     di,8
F000:3B87  [+0x03B87]  8B F0                    mov     si,ax
F000:3B89  [+0x03B89]  4A                       dec     dx
F000:3B8A  [+0x03B8A]  75 EB                    jne     short 3B77h
F000:3B8C  [+0x03B8C]  5D                       pop     bp
F000:3B8D  [+0x03B8D]  C3                       ret
F000:3B8E  [+0x03B8E]  2B FB                    sub     di,bx
F000:3B90  [+0x03B90]  B1 03                    mov     cl,3
F000:3B92  [+0x03B92]  D3 EF                    shr     di,cl
F000:3B94  [+0x03B94]  8B C7                    mov     ax,di
F000:3B96  [+0x03B96]  0A C9                    or      cl,cl
F000:3B98  [+0x03B98]  5D                       pop     bp
F000:3B99  [+0x03B99]  C3                       ret
F000:3B9A  [+0x03B9A]  8A E3                    mov     ah,bl
F000:3B9C  [+0x03B9C]  8B F8                    mov     di,ax
F000:3B9E  [+0x03B9E]  8A DF                    mov     bl,bh
F000:3BA0  [+0x03BA0]  32 FF                    xor     bh,bh
F000:3BA2  [+0x03BA2]  A1 4C 04                 mov     ax,[44Ch]
F000:3BA5  [+0x03BA5]  D1 E8                    shr     ax,1
F000:3BA7  [+0x03BA7]  F7 E3                    mul     bx
F000:3BA9  [+0x03BA9]  8B D0                    mov     dx,ax
F000:3BAB  [+0x03BAB]  D1 E3                    shl     bx,1
F000:3BAD  [+0x03BAD]  8B 9F 50 04              mov     bx,[bx+450h]
F000:3BB1  [+0x03BB1]  A0 4A 04                 mov     al,[44Ah]
F000:3BB4  [+0x03BB4]  F6 E7                    mul     bh
F000:3BB6  [+0x03BB6]  03 C2                    add     ax,dx
F000:3BB8  [+0x03BB8]  32 FF                    xor     bh,bh
F000:3BBA  [+0x03BBA]  03 C3                    add     ax,bx
F000:3BBC  [+0x03BBC]  D1 E0                    shl     ax,1
F000:3BBE  [+0x03BBE]  97                       xchg    di,ax
F000:3BBF  [+0x03BBF]  C3                       ret
F000:3BC0  [+0x03BC0]  87 DB                    xchg    bx,bx
F000:3BC2  [+0x03BC2]  8A 26 49 04              mov     ah,[449h]
F000:3BC6  [+0x03BC6]  80 FC 07                 cmp     ah,7
F000:3BC9  [+0x03BC9]  76 1F                    jbe     short 3BEAh
F000:3BCB  [+0x03BCB]  80 FC 13                 cmp     ah,13h
F000:3BCE  [+0x03BCE]  74 16                    je      short 3BE6h
F000:3BD0  [+0x03BD0]  72 03                    jb      short 3BD5h
F000:3BD2  [+0x03BD2]  E9 AE E0                 jmp     1C83h
F000:3BD5  [+0x03BD5]  80 FC 11                 cmp     ah,11h
F000:3BD8  [+0x03BD8]  75 06                    jne     short 3BE0h
F000:3BDA  [+0x03BDA]  80 E3 80                 and     bl,80h
F000:3BDD  [+0x03BDD]  80 CB 3F                 or      bl,3Fh
F000:3BE0  [+0x03BE0]  E9 9E 01                 jmp     3D81h
F000:3BE3  [+0x03BE3]  87 DB                    xchg    bx,bx
F000:3BE5  [+0x03BE5]  90                       nop
F000:3BE6  [+0x03BE6]  E9 3C 02                 jmp     3E25h
F000:3BE9  [+0x03BE9]  90                       nop
F000:3BEA  [+0x03BEA]  8A 16 10 04              mov     dl,[410h]
F000:3BEE  [+0x03BEE]  80 E2 30                 and     dl,30h
F000:3BF1  [+0x03BF1]  80 FA 30                 cmp     dl,30h
F000:3BF4  [+0x03BF4]  BA 00 B0                 mov     dx,0B000h
F000:3BF7  [+0x03BF7]  74 02                    je      short 3BFBh
F000:3BF9  [+0x03BF9]  B6 B8                    mov     dh,0B8h
F000:3BFB  [+0x03BFB]  8E C2                    mov     es,dx
F000:3BFD  [+0x03BFD]  80 FC 07                 cmp     ah,7
F000:3C00  [+0x03C00]  74 11                    je      short 3C13h
F000:3C02  [+0x03C02]  80 FC 03                 cmp     ah,3
F000:3C05  [+0x03C05]  77 2D                    ja      short 3C34h
F000:3C07  [+0x03C07]  80 FC 02                 cmp     ah,2
F000:3C0A  [+0x03C0A]  72 07                    jb      short 3C13h
F000:3C0C  [+0x03C0C]  F6 06 87 04 04           test    byte [487h],4
F000:3C11  [+0x03C11]  75 24                    jne     short 3C37h
F000:3C13  [+0x03C13]  0A FF                    or      bh,bh
F000:3C15  [+0x03C15]  75 17                    jne     short 3C2Eh
F000:3C17  [+0x03C17]  8A E3                    mov     ah,bl
F000:3C19  [+0x03C19]  8B F8                    mov     di,ax
F000:3C1B  [+0x03C1B]  8B 1E 50 04              mov     bx,[450h]
F000:3C1F  [+0x03C1F]  A0 4A 04                 mov     al,[44Ah]
F000:3C22  [+0x03C22]  F6 E7                    mul     bh
F000:3C24  [+0x03C24]  32 FF                    xor     bh,bh
F000:3C26  [+0x03C26]  03 C3                    add     ax,bx
F000:3C28  [+0x03C28]  D1 E0                    shl     ax,1
F000:3C2A  [+0x03C2A]  97                       xchg    di,ax
F000:3C2B  [+0x03C2B]  F3 AB                    rep stosw
F000:3C2D  [+0x03C2D]  C3                       ret
F000:3C2E  [+0x03C2E]  E8 69 FF                 call    3B9Ah
F000:3C31  [+0x03C31]  F3 AB                    rep stosw
F000:3C33  [+0x03C33]  C3                       ret
F000:3C34  [+0x03C34]  E9 A3 00                 jmp     3CDAh
F000:3C37  [+0x03C37]  E8 60 FF                 call    3B9Ah
F000:3C3A  [+0x03C3A]  8B 16 63 04              mov     dx,[463h]
F000:3C3E  [+0x03C3E]  83 C2 06                 add     dx,6
F000:3C41  [+0x03C41]  8A D8                    mov     bl,al
F000:3C43  [+0x03C43]  EC                       in      al,dx
F000:3C44  [+0x03C44]  A8 01                    test    al,1
F000:3C46  [+0x03C46]  75 FB                    jne     short 3C43h
F000:3C48  [+0x03C48]  9C                       pushf
F000:3C49  [+0x03C49]  FA                       cli
F000:3C4A  [+0x03C4A]  EC                       in      al,dx
F000:3C4B  [+0x03C4B]  A8 01                    test    al,1
F000:3C4D  [+0x03C4D]  74 FB                    je      short 3C4Ah
F000:3C4F  [+0x03C4F]  8A C3                    mov     al,bl
F000:3C51  [+0x03C51]  AB                       stosw
F000:3C52  [+0x03C52]  9D                       popf
F000:3C53  [+0x03C53]  E2 EE                    loop    3C43h
F000:3C55  [+0x03C55]  C3                       ret
F000:3C56  [+0x03C56]  8A 26 49 04              mov     ah,[449h]
F000:3C5A  [+0x03C5A]  80 FC 07                 cmp     ah,7
F000:3C5D  [+0x03C5D]  76 0F                    jbe     short 3C6Eh
F000:3C5F  [+0x03C5F]  80 FC 13                 cmp     ah,13h
F000:3C62  [+0x03C62]  74 82                    je      short 3BE6h
F000:3C64  [+0x03C64]  72 03                    jb      short 3C69h
F000:3C66  [+0x03C66]  E9 10 E0                 jmp     1C79h
F000:3C69  [+0x03C69]  E9 15 01                 jmp     3D81h
F000:3C6C  [+0x03C6C]  87 DB                    xchg    bx,bx
F000:3C6E  [+0x03C6E]  8A 16 10 04              mov     dl,[410h]
F000:3C72  [+0x03C72]  80 E2 30                 and     dl,30h
F000:3C75  [+0x03C75]  80 FA 30                 cmp     dl,30h
F000:3C78  [+0x03C78]  BA 00 B0                 mov     dx,0B000h
F000:3C7B  [+0x03C7B]  74 02                    je      short 3C7Fh
F000:3C7D  [+0x03C7D]  B6 B8                    mov     dh,0B8h
F000:3C7F  [+0x03C7F]  8E C2                    mov     es,dx
F000:3C81  [+0x03C81]  80 FC 07                 cmp     ah,7
F000:3C84  [+0x03C84]  74 11                    je      short 3C97h
F000:3C86  [+0x03C86]  80 FC 03                 cmp     ah,3
F000:3C89  [+0x03C89]  77 4F                    ja      short 3CDAh
F000:3C8B  [+0x03C8B]  80 FC 02                 cmp     ah,2
F000:3C8E  [+0x03C8E]  72 07                    jb      short 3C97h
F000:3C90  [+0x03C90]  F6 06 87 04 04           test    byte [487h],4
F000:3C95  [+0x03C95]  75 23                    jne     short 3CBAh
F000:3C97  [+0x03C97]  0A FF                    or      bh,bh
F000:3C99  [+0x03C99]  75 17                    jne     short 3CB2h
F000:3C9B  [+0x03C9B]  8B F8                    mov     di,ax
F000:3C9D  [+0x03C9D]  8B 1E 50 04              mov     bx,[450h]
F000:3CA1  [+0x03CA1]  A0 4A 04                 mov     al,[44Ah]
F000:3CA4  [+0x03CA4]  F6 E7                    mul     bh
F000:3CA6  [+0x03CA6]  32 FF                    xor     bh,bh
F000:3CA8  [+0x03CA8]  03 C3                    add     ax,bx
F000:3CAA  [+0x03CAA]  D1 E0                    shl     ax,1
F000:3CAC  [+0x03CAC]  97                       xchg    di,ax
F000:3CAD  [+0x03CAD]  AA                       stosb
F000:3CAE  [+0x03CAE]  47                       inc     di
F000:3CAF  [+0x03CAF]  E2 FC                    loop    3CADh
F000:3CB1  [+0x03CB1]  C3                       ret
F000:3CB2  [+0x03CB2]  E8 E5 FE                 call    3B9Ah
F000:3CB5  [+0x03CB5]  AA                       stosb
F000:3CB6  [+0x03CB6]  47                       inc     di
F000:3CB7  [+0x03CB7]  E2 FC                    loop    3CB5h
F000:3CB9  [+0x03CB9]  C3                       ret
F000:3CBA  [+0x03CBA]  E8 DD FE                 call    3B9Ah
F000:3CBD  [+0x03CBD]  8B 16 63 04              mov     dx,[463h]
F000:3CC1  [+0x03CC1]  83 C2 06                 add     dx,6
F000:3CC4  [+0x03CC4]  8A E0                    mov     ah,al
F000:3CC6  [+0x03CC6]  EC                       in      al,dx
F000:3CC7  [+0x03CC7]  A8 01                    test    al,1
F000:3CC9  [+0x03CC9]  75 FB                    jne     short 3CC6h
F000:3CCB  [+0x03CCB]  9C                       pushf
F000:3CCC  [+0x03CCC]  FA                       cli
F000:3CCD  [+0x03CCD]  EC                       in      al,dx
F000:3CCE  [+0x03CCE]  A8 01                    test    al,1
F000:3CD0  [+0x03CD0]  74 FB                    je      short 3CCDh
F000:3CD2  [+0x03CD2]  8A C4                    mov     al,ah
F000:3CD4  [+0x03CD4]  AA                       stosb
F000:3CD5  [+0x03CD5]  9D                       popf
F000:3CD6  [+0x03CD6]  47                       inc     di
F000:3CD7  [+0x03CD7]  E2 ED                    loop    3CC6h
F000:3CD9  [+0x03CD9]  C3                       ret
F000:3CDA  [+0x03CDA]  8B D0                    mov     dx,ax
F000:3CDC  [+0x03CDC]  A0 51 04                 mov     al,[451h]
F000:3CDF  [+0x03CDF]  F6 26 4A 04              mul     byte [44Ah]
F000:3CE3  [+0x03CE3]  8B F8                    mov     di,ax
F000:3CE5  [+0x03CE5]  D1 E7                    shl     di,1
F000:3CE7  [+0x03CE7]  D1 E7                    shl     di,1
F000:3CE9  [+0x03CE9]  A0 50 04                 mov     al,[450h]
F000:3CEC  [+0x03CEC]  32 E4                    xor     ah,ah
F000:3CEE  [+0x03CEE]  03 F8                    add     di,ax
F000:3CF0  [+0x03CF0]  80 FE 06                 cmp     dh,6
F000:3CF3  [+0x03CF3]  74 02                    je      short 3CF7h
F000:3CF5  [+0x03CF5]  D1 E7                    shl     di,1
F000:3CF7  [+0x03CF7]  8A C2                    mov     al,dl
F000:3CF9  [+0x03CF9]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:3CFE  [+0x03CFE]  0A C0                    or      al,al
F000:3D00  [+0x03D00]  79 08                    jns     short 3D0Ah
F000:3D02  [+0x03D02]  24 7F                    and     al,7Fh
F000:3D04  [+0x03D04]  C5 36 7C 00              lds     si,[7Ch]
F000:3D08  [+0x03D08]  EB 04                    jmp     short 3D0Eh
F000:3D0A  [+0x03D0A]  C5 36 0C 01              lds     si,[10Ch]
F000:3D0E  [+0x03D0E]  32 E4                    xor     ah,ah
F000:3D10  [+0x03D10]  D1 E0                    shl     ax,1
F000:3D12  [+0x03D12]  D1 E0                    shl     ax,1
F000:3D14  [+0x03D14]  D1 E0                    shl     ax,1
F000:3D16  [+0x03D16]  03 F0                    add     si,ax
F000:3D18  [+0x03D18]  80 FE 06                 cmp     dh,6
F000:3D1B  [+0x03D1B]  75 3E                    jne     short 3D5Bh
F000:3D1D  [+0x03D1D]  B2 04                    mov     dl,4
F000:3D1F  [+0x03D1F]  0A DB                    or      bl,bl
F000:3D21  [+0x03D21]  78 1B                    js      short 3D3Eh
F000:3D23  [+0x03D23]  AD                       lodsw
F000:3D24  [+0x03D24]  AA                       stosb
F000:3D25  [+0x03D25]  81 C7 FF 1F              add     di,1FFFh
F000:3D29  [+0x03D29]  8A C4                    mov     al,ah
F000:3D2B  [+0x03D2B]  AA                       stosb
F000:3D2C  [+0x03D2C]  81 EF B1 1F              sub     di,1FB1h
F000:3D30  [+0x03D30]  FE CA                    dec     dl
F000:3D32  [+0x03D32]  75 EF                    jne     short 3D23h
F000:3D34  [+0x03D34]  81 EF 3F 01              sub     di,13Fh
F000:3D38  [+0x03D38]  83 EE 08                 sub     si,8
F000:3D3B  [+0x03D3B]  E2 E0                    loop    3D1Dh
F000:3D3D  [+0x03D3D]  C3                       ret
F000:3D3E  [+0x03D3E]  AD                       lodsw
F000:3D3F  [+0x03D3F]  26 30 05                 xor     [es:di],al
F000:3D42  [+0x03D42]  81 C7 00 20              add     di,2000h
F000:3D46  [+0x03D46]  26 30 25                 xor     [es:di],ah
F000:3D49  [+0x03D49]  81 EF B0 1F              sub     di,1FB0h
F000:3D4D  [+0x03D4D]  FE CA                    dec     dl
F000:3D4F  [+0x03D4F]  75 ED                    jne     short 3D3Eh
F000:3D51  [+0x03D51]  81 EF 3F 01              sub     di,13Fh
F000:3D55  [+0x03D55]  83 EE 08                 sub     si,8
F000:3D58  [+0x03D58]  E2 C3                    loop    3D1Dh
F000:3D5A  [+0x03D5A]  C3                       ret
F000:3D5B  [+0x03D5B]  8A FB                    mov     bh,bl
F000:3D5D  [+0x03D5D]  80 E7 03                 and     bh,3
F000:3D60  [+0x03D60]  8B E9                    mov     bp,cx
F000:3D62  [+0x03D62]  B6 04                    mov     dh,4
F000:3D64  [+0x03D64]  E8 18 01                 call    3E7Fh
F000:3D67  [+0x03D67]  81 C7 FE 1F              add     di,1FFEh
F000:3D6B  [+0x03D6B]  E8 11 01                 call    3E7Fh
F000:3D6E  [+0x03D6E]  81 EF B2 1F              sub     di,1FB2h
F000:3D72  [+0x03D72]  FE CE                    dec     dh
F000:3D74  [+0x03D74]  75 EE                    jne     short 3D64h
F000:3D76  [+0x03D76]  81 EF 3E 01              sub     di,13Eh
F000:3D7A  [+0x03D7A]  83 EE 08                 sub     si,8
F000:3D7D  [+0x03D7D]  4D                       dec     bp
F000:3D7E  [+0x03D7E]  75 E2                    jne     short 3D62h
F000:3D80  [+0x03D80]  C3                       ret
F000:3D81  [+0x03D81]  8B F0                    mov     si,ax
F000:3D83  [+0x03D83]  8B E9                    mov     bp,cx
F000:3D85  [+0x03D85]  B8 00 A0                 mov     ax,0A000h
F000:3D88  [+0x03D88]  8E C0                    mov     es,ax
F000:3D8A  [+0x03D8A]  8A C7                    mov     al,bh
F000:3D8C  [+0x03D8C]  32 E4                    xor     ah,ah
F000:3D8E  [+0x03D8E]  D1 E0                    shl     ax,1
F000:3D90  [+0x03D90]  8B F8                    mov     di,ax
F000:3D92  [+0x03D92]  8B 85 50 04              mov     ax,[di+450h]
F000:3D96  [+0x03D96]  8B F8                    mov     di,ax
F000:3D98  [+0x03D98]  81 E7 FF 00              and     di,0FFh
F000:3D9C  [+0x03D9C]  A0 4A 04                 mov     al,[44Ah]
F000:3D9F  [+0x03D9F]  F6 E4                    mul     ah
F000:3DA1  [+0x03DA1]  F7 26 85 04              mul     word [485h]
F000:3DA5  [+0x03DA5]  03 F8                    add     di,ax
F000:3DA7  [+0x03DA7]  32 E4                    xor     ah,ah
F000:3DA9  [+0x03DA9]  8A C7                    mov     al,bh
F000:3DAB  [+0x03DAB]  F7 26 4C 04              mul     word [44Ch]
F000:3DAF  [+0x03DAF]  03 F8                    add     di,ax
F000:3DB1  [+0x03DB1]  8A D3                    mov     dl,bl
F000:3DB3  [+0x03DB3]  8B 0E 85 04              mov     cx,[485h]
F000:3DB7  [+0x03DB7]  8B 1E 4A 04              mov     bx,[44Ah]
F000:3DBB  [+0x03DBB]  4B                       dec     bx
F000:3DBC  [+0x03DBC]  8B C6                    mov     ax,si
F000:3DBE  [+0x03DBE]  F6 26 85 04              mul     byte [485h]
F000:3DC2  [+0x03DC2]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:3DC7  [+0x03DC7]  C5 36 0C 01              lds     si,[10Ch]
F000:3DCB  [+0x03DCB]  03 F0                    add     si,ax
F000:3DCD  [+0x03DCD]  8A E2                    mov     ah,dl
F000:3DCF  [+0x03DCF]  32 C0                    xor     al,al
F000:3DD1  [+0x03DD1]  BA CE 03                 mov     dx,3CEh
F000:3DD4  [+0x03DD4]  EF                       out     dx,ax
F000:3DD5  [+0x03DD5]  FE C0                    inc     al
F000:3DD7  [+0x03DD7]  F6 D4                    not     ah
F000:3DD9  [+0x03DD9]  EF                       out     dx,ax
F000:3DDA  [+0x03DDA]  F6 C4 80                 test    ah,80h
F000:3DDD  [+0x03DDD]  74 25                    je      short 3E04h
F000:3DDF  [+0x03DDF]  BA C4 03                 mov     dx,3C4h
F000:3DE2  [+0x03DE2]  B8 02 0F                 mov     ax,0F02h
F000:3DE5  [+0x03DE5]  EF                       out     dx,ax
F000:3DE6  [+0x03DE6]  56                       push    si
F000:3DE7  [+0x03DE7]  57                       push    di
F000:3DE8  [+0x03DE8]  8B D1                    mov     dx,cx
F000:3DEA  [+0x03DEA]  A4                       movsb
F000:3DEB  [+0x03DEB]  03 FB                    add     di,bx
F000:3DED  [+0x03DED]  E2 FB                    loop    3DEAh
F000:3DEF  [+0x03DEF]  8B CA                    mov     cx,dx
F000:3DF1  [+0x03DF1]  5F                       pop     di
F000:3DF2  [+0x03DF2]  5E                       pop     si
F000:3DF3  [+0x03DF3]  47                       inc     di
F000:3DF4  [+0x03DF4]  4D                       dec     bp
F000:3DF5  [+0x03DF5]  75 EF                    jne     short 3DE6h
F000:3DF7  [+0x03DF7]  B8 03 00                 mov     ax,3
F000:3DFA  [+0x03DFA]  BA CE 03                 mov     dx,3CEh
F000:3DFD  [+0x03DFD]  EF                       out     dx,ax
F000:3DFE  [+0x03DFE]  33 C0                    xor     ax,ax
F000:3E00  [+0x03E00]  EF                       out     dx,ax
F000:3E01  [+0x03E01]  40                       inc     ax
F000:3E02  [+0x03E02]  EF                       out     dx,ax
F000:3E03  [+0x03E03]  C3                       ret
F000:3E04  [+0x03E04]  B8 03 18                 mov     ax,1803h
F000:3E07  [+0x03E07]  EF                       out     dx,ax
F000:3E08  [+0x03E08]  BA C4 03                 mov     dx,3C4h
F000:3E0B  [+0x03E0B]  B8 02 0F                 mov     ax,0F02h
F000:3E0E  [+0x03E0E]  EF                       out     dx,ax
F000:3E0F  [+0x03E0F]  56                       push    si
F000:3E10  [+0x03E10]  57                       push    di
F000:3E11  [+0x03E11]  8B D1                    mov     dx,cx
F000:3E13  [+0x03E13]  26 8A 05                 mov     al,[es:di]
F000:3E16  [+0x03E16]  A4                       movsb
F000:3E17  [+0x03E17]  03 FB                    add     di,bx
F000:3E19  [+0x03E19]  E2 F8                    loop    3E13h
F000:3E1B  [+0x03E1B]  8B CA                    mov     cx,dx
F000:3E1D  [+0x03E1D]  5F                       pop     di
F000:3E1E  [+0x03E1E]  5E                       pop     si
F000:3E1F  [+0x03E1F]  47                       inc     di
F000:3E20  [+0x03E20]  4D                       dec     bp
F000:3E21  [+0x03E21]  75 EC                    jne     short 3E0Fh
F000:3E23  [+0x03E23]  EB D2                    jmp     short 3DF7h
F000:3E25  [+0x03E25]  8B E9                    mov     bp,cx
F000:3E27  [+0x03E27]  8B C8                    mov     cx,ax
F000:3E29  [+0x03E29]  B8 00 A0                 mov     ax,0A000h
F000:3E2C  [+0x03E2C]  8E C0                    mov     es,ax
F000:3E2E  [+0x03E2E]  A1 50 04                 mov     ax,[450h]
F000:3E31  [+0x03E31]  8B F8                    mov     di,ax
F000:3E33  [+0x03E33]  81 E7 FF 00              and     di,0FFh
F000:3E37  [+0x03E37]  A0 4A 04                 mov     al,[44Ah]
F000:3E3A  [+0x03E3A]  F6 E4                    mul     ah
F000:3E3C  [+0x03E3C]  F7 26 85 04              mul     word [485h]
F000:3E40  [+0x03E40]  03 F8                    add     di,ax
F000:3E42  [+0x03E42]  D1 E7                    shl     di,1
F000:3E44  [+0x03E44]  D1 E7                    shl     di,1
F000:3E46  [+0x03E46]  D1 E7                    shl     di,1
F000:3E48  [+0x03E48]  A1 85 04                 mov     ax,[485h]
F000:3E4B  [+0x03E4B]  8B D0                    mov     dx,ax
F000:3E4D  [+0x03E4D]  F6 E1                    mul     cl
F000:3E4F  [+0x03E4F]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:3E54  [+0x03E54]  C5 36 0C 01              lds     si,[10Ch]
F000:3E58  [+0x03E58]  03 F0                    add     si,ax
F000:3E5A  [+0x03E5A]  57                       push    di
F000:3E5B  [+0x03E5B]  52                       push    dx
F000:3E5C  [+0x03E5C]  B9 08 00                 mov     cx,8
F000:3E5F  [+0x03E5F]  8A 24                    mov     ah,[si]
F000:3E61  [+0x03E61]  46                       inc     si
F000:3E62  [+0x03E62]  D0 D4                    rcl     ah,1
F000:3E64  [+0x03E64]  8A C3                    mov     al,bl
F000:3E66  [+0x03E66]  72 02                    jb      short 3E6Ah
F000:3E68  [+0x03E68]  8A C7                    mov     al,bh
F000:3E6A  [+0x03E6A]  AA                       stosb
F000:3E6B  [+0x03E6B]  E2 F5                    loop    3E62h
F000:3E6D  [+0x03E6D]  81 C7 38 01              add     di,138h
F000:3E71  [+0x03E71]  4A                       dec     dx
F000:3E72  [+0x03E72]  75 E8                    jne     short 3E5Ch
F000:3E74  [+0x03E74]  5A                       pop     dx
F000:3E75  [+0x03E75]  5F                       pop     di
F000:3E76  [+0x03E76]  2B F2                    sub     si,dx
F000:3E78  [+0x03E78]  83 C7 08                 add     di,8
F000:3E7B  [+0x03E7B]  4D                       dec     bp
F000:3E7C  [+0x03E7C]  75 DC                    jne     short 3E5Ah
F000:3E7E  [+0x03E7E]  C3                       ret
F000:3E7F  [+0x03E7F]  B2 08                    mov     dl,8
F000:3E81  [+0x03E81]  33 C9                    xor     cx,cx
F000:3E83  [+0x03E83]  AC                       lodsb
F000:3E84  [+0x03E84]  D0 D8                    rcr     al,1
F000:3E86  [+0x03E86]  73 02                    jae     short 3E8Ah
F000:3E88  [+0x03E88]  0A CF                    or      cl,bh
F000:3E8A  [+0x03E8A]  D1 C9                    ror     cx,1
F000:3E8C  [+0x03E8C]  D1 C9                    ror     cx,1
F000:3E8E  [+0x03E8E]  FE CA                    dec     dl
F000:3E90  [+0x03E90]  75 F2                    jne     short 3E84h
F000:3E92  [+0x03E92]  8B C1                    mov     ax,cx
F000:3E94  [+0x03E94]  86 C4                    xchg    al,ah
F000:3E96  [+0x03E96]  0A DB                    or      bl,bl
F000:3E98  [+0x03E98]  78 02                    js      short 3E9Ch
F000:3E9A  [+0x03E9A]  AB                       stosw
F000:3E9B  [+0x03E9B]  C3                       ret
F000:3E9C  [+0x03E9C]  26 31 05                 xor     [es:di],ax
F000:3E9F  [+0x03E9F]  83 C7 02                 add     di,2
F000:3EA2  [+0x03EA2]  C3                       ret
F000:3EA3  [+0x03EA3]  00 81 3E 63              add     [bx+di+633Eh],al
F000:3EA7  [+0x03EA7]  04 B4                    add     al,0B4h
F000:3EA9  [+0x03EA9]  03 74 54                 add     si,[si+54h]
F000:3EAC  [+0x03EAC]  F6 06 87 04 08           test    byte [487h],8
F000:3EB1  [+0x03EB1]  74 03                    je      short 3EB6h
F000:3EB3  [+0x03EB3]  CD 42                    int     42h
F000:3EB5  [+0x03EB5]  C3                       ret
F000:3EB6  [+0x03EB6]  80 FF 00                 cmp     bh,0
F000:3EB9  [+0x03EB9]  74 46                    je      short 3F01h
F000:3EBB  [+0x03EBB]  A0 49 04                 mov     al,[449h]
F000:3EBE  [+0x03EBE]  3C 04                    cmp     al,4
F000:3EC0  [+0x03EC0]  72 3E                    jb      short 3F00h
F000:3EC2  [+0x03EC2]  3C 13                    cmp     al,13h
F000:3EC4  [+0x03EC4]  76 07                    jbe     short 3ECDh
F000:3EC6  [+0x03EC6]  8A E0                    mov     ah,al
F000:3EC8  [+0x03EC8]  E8 74 E0                 call    1F3Fh
F000:3ECB  [+0x03ECB]  73 33                    jae     short 3F00h
F000:3ECD  [+0x03ECD]  8A 3E 66 04              mov     bh,[466h]
F000:3ED1  [+0x03ED1]  80 E7 DF                 and     bh,0DFh
F000:3ED4  [+0x03ED4]  80 E3 01                 and     bl,1
F000:3ED7  [+0x03ED7]  74 03                    je      short 3EDCh
F000:3ED9  [+0x03ED9]  80 CF 20                 or      bh,20h
F000:3EDC  [+0x03EDC]  88 3E 66 04              mov     [466h],bh
F000:3EE0  [+0x03EE0]  80 E7 10                 and     bh,10h
F000:3EE3  [+0x03EE3]  0A FB                    or      bh,bl
F000:3EE5  [+0x03EE5]  81 CB 01 02              or      bx,201h
F000:3EE9  [+0x03EE9]  E8 83 00                 call    3F6Fh
F000:3EEC  [+0x03EEC]  E8 62 00                 call    3F51h
F000:3EEF  [+0x03EEF]  80 C7 02                 add     bh,2
F000:3EF2  [+0x03EF2]  FE C3                    inc     bl
F000:3EF4  [+0x03EF4]  80 FB 03                 cmp     bl,3
F000:3EF7  [+0x03EF7]  76 F0                    jbe     short 3EE9h
F000:3EF9  [+0x03EF9]  BA D9 03                 mov     dx,3D9h
F000:3EFC  [+0x03EFC]  A0 66 04                 mov     al,[466h]
F000:3EFF  [+0x03EFF]  EE                       out     dx,al
F000:3F00  [+0x03F00]  C3                       ret
F000:3F01  [+0x03F01]  8A 26 66 04              mov     ah,[466h]
F000:3F05  [+0x03F05]  80 E4 E0                 and     ah,0E0h
F000:3F08  [+0x03F08]  8A FB                    mov     bh,bl
F000:3F0A  [+0x03F0A]  80 E7 1F                 and     bh,1Fh
F000:3F0D  [+0x03F0D]  0A E7                    or      ah,bh
F000:3F0F  [+0x03F0F]  88 26 66 04              mov     [466h],ah
F000:3F13  [+0x03F13]  8A 46 0E                 mov     al,[bp+0Eh]
F000:3F16  [+0x03F16]  24 08                    and     al,8
F000:3F18  [+0x03F18]  D0 E0                    shl     al,1
F000:3F1A  [+0x03F1A]  80 E7 07                 and     bh,7
F000:3F1D  [+0x03F1D]  0A F8                    or      bh,al
F000:3F1F  [+0x03F1F]  B3 11                    mov     bl,11h
F000:3F21  [+0x03F21]  E8 4B 00                 call    3F6Fh
F000:3F24  [+0x03F24]  B3 10                    mov     bl,10h
F000:3F26  [+0x03F26]  E8 28 00                 call    3F51h
F000:3F29  [+0x03F29]  A0 49 04                 mov     al,[449h]
F000:3F2C  [+0x03F2C]  3C 03                    cmp     al,3
F000:3F2E  [+0x03F2E]  76 13                    jbe     short 3F43h
F000:3F30  [+0x03F30]  3C 13                    cmp     al,13h
F000:3F32  [+0x03F32]  76 07                    jbe     short 3F3Bh
F000:3F34  [+0x03F34]  8A E0                    mov     ah,al
F000:3F36  [+0x03F36]  E8 06 E0                 call    1F3Fh
F000:3F39  [+0x03F39]  73 08                    jae     short 3F43h
F000:3F3B  [+0x03F3B]  32 DB                    xor     bl,bl
F000:3F3D  [+0x03F3D]  E8 2F 00                 call    3F6Fh
F000:3F40  [+0x03F40]  E8 0E 00                 call    3F51h
F000:3F43  [+0x03F43]  8A 1E 66 04              mov     bl,[466h]
F000:3F47  [+0x03F47]  80 E3 20                 and     bl,20h
F000:3F4A  [+0x03F4A]  B1 05                    mov     cl,5
F000:3F4C  [+0x03F4C]  D2 EB                    shr     bl,cl
F000:3F4E  [+0x03F4E]  E9 6A FF                 jmp     3EBBh
F000:3F51  [+0x03F51]  50                       push    ax
F000:3F52  [+0x03F52]  57                       push    di
F000:3F53  [+0x03F53]  06                       push    es
F000:3F54  [+0x03F54]  C4 3E A8 04              les     di,[4A8h]
F000:3F58  [+0x03F58]  26 C4 7D 04              les     di,[es:di+4]
F000:3F5C  [+0x03F5C]  8C C0                    mov     ax,es
F000:3F5E  [+0x03F5E]  0B C7                    or      ax,di
F000:3F60  [+0x03F60]  74 09                    je      short 3F6Bh
F000:3F62  [+0x03F62]  8A C3                    mov     al,bl
F000:3F64  [+0x03F64]  B4 00                    mov     ah,0
F000:3F66  [+0x03F66]  03 F8                    add     di,ax
F000:3F68  [+0x03F68]  8A C7                    mov     al,bh
F000:3F6A  [+0x03F6A]  AA                       stosb
F000:3F6B  [+0x03F6B]  07                       pop     es
F000:3F6C  [+0x03F6C]  5F                       pop     di
F000:3F6D  [+0x03F6D]  58                       pop     ax
F000:3F6E  [+0x03F6E]  C3                       ret
F000:3F6F  [+0x03F6F]  50                       push    ax
F000:3F70  [+0x03F70]  52                       push    dx
F000:3F71  [+0x03F71]  8B 16 63 04              mov     dx,[463h]
F000:3F75  [+0x03F75]  80 C2 06                 add     dl,6
F000:3F78  [+0x03F78]  52                       push    dx
F000:3F79  [+0x03F79]  EC                       in      al,dx
F000:3F7A  [+0x03F7A]  24 08                    and     al,8
F000:3F7C  [+0x03F7C]  74 FB                    je      short 3F79h
F000:3F7E  [+0x03F7E]  BA C0 03                 mov     dx,3C0h
F000:3F81  [+0x03F81]  8A C3                    mov     al,bl
F000:3F83  [+0x03F83]  9C                       pushf
F000:3F84  [+0x03F84]  FA                       cli
F000:3F85  [+0x03F85]  EE                       out     dx,al
F000:3F86  [+0x03F86]  8A C7                    mov     al,bh
F000:3F88  [+0x03F88]  EB 00                    jmp     short 3F8Ah
F000:3F8A  [+0x03F8A]  EE                       out     dx,al
F000:3F8B  [+0x03F8B]  B0 20                    mov     al,20h
F000:3F8D  [+0x03F8D]  EE                       out     dx,al
F000:3F8E  [+0x03F8E]  9D                       popf
F000:3F8F  [+0x03F8F]  5A                       pop     dx
F000:3F90  [+0x03F90]  EC                       in      al,dx
F000:3F91  [+0x03F91]  5A                       pop     dx
F000:3F92  [+0x03F92]  58                       pop     ax
F000:3F93  [+0x03F93]  C3                       ret
F000:3F94  [+0x03F94]  77 1C                    ja      short 3FB2h
F000:3F96  [+0x03F96]  06                       push    es
F000:3F97  [+0x03F97]  57                       push    di
F000:3F98  [+0x03F98]  50                       push    ax
F000:3F99  [+0x03F99]  52                       push    dx
F000:3F9A  [+0x03F9A]  8B F8                    mov     di,ax
F000:3F9C  [+0x03F9C]  2E 8E 06 7B 26           mov     es,[cs:267Bh]
F000:3FA1  [+0x03FA1]  B8 40 01                 mov     ax,140h
F000:3FA4  [+0x03FA4]  F7 E2                    mul     dx
F000:3FA6  [+0x03FA6]  03 C1                    add     ax,cx
F000:3FA8  [+0x03FA8]  97                       xchg    di,ax
F000:3FA9  [+0x03FA9]  AA                       stosb
F000:3FAA  [+0x03FAA]  5A                       pop     dx
F000:3FAB  [+0x03FAB]  58                       pop     ax
F000:3FAC  [+0x03FAC]  5F                       pop     di
F000:3FAD  [+0x03FAD]  07                       pop     es
F000:3FAE  [+0x03FAE]  1F                       pop     ds
F000:3FAF  [+0x03FAF]  B4 0C                    mov     ah,0Ch
F000:3FB1  [+0x03FB1]  CF                       iret
F000:3FB2  [+0x03FB2]  E9 3D DC                 jmp     1BF2h
F000:3FB5  [+0x03FB5]  87 DB                    xchg    bx,bx
F000:3FB7  [+0x03FB7]  90                       nop
F000:3FB8  [+0x03FB8]  80 FC 04                 cmp     ah,4
F000:3FBB  [+0x03FBB]  72 2F                    jb      short 3FECh
F000:3FBD  [+0x03FBD]  80 FC 07                 cmp     ah,7
F000:3FC0  [+0x03FC0]  74 2A                    je      short 3FECh
F000:3FC2  [+0x03FC2]  80 FC 08                 cmp     ah,8
F000:3FC5  [+0x03FC5]  73 41                    jae     short 4008h
F000:3FC7  [+0x03FC7]  06                       push    es
F000:3FC8  [+0x03FC8]  57                       push    di
F000:3FC9  [+0x03FC9]  53                       push    bx
F000:3FCA  [+0x03FCA]  51                       push    cx
F000:3FCB  [+0x03FCB]  52                       push    dx
F000:3FCC  [+0x03FCC]  8B D8                    mov     bx,ax
F000:3FCE  [+0x03FCE]  E8 53 01                 call    4124h
F000:3FD1  [+0x03FD1]  8A C4                    mov     al,ah
F000:3FD3  [+0x03FD3]  D2 C8                    ror     al,cl
F000:3FD5  [+0x03FD5]  F6 D0                    not     al
F000:3FD7  [+0x03FD7]  22 C3                    and     al,bl
F000:3FD9  [+0x03FD9]  D2 E0                    shl     al,cl
F000:3FDB  [+0x03FDB]  0A DB                    or      bl,bl
F000:3FDD  [+0x03FDD]  78 0F                    js      short 3FEEh
F000:3FDF  [+0x03FDF]  26 22 25                 and     ah,[es:di]
F000:3FE2  [+0x03FE2]  0A C4                    or      al,ah
F000:3FE4  [+0x03FE4]  AA                       stosb
F000:3FE5  [+0x03FE5]  8B C3                    mov     ax,bx
F000:3FE7  [+0x03FE7]  5A                       pop     dx
F000:3FE8  [+0x03FE8]  59                       pop     cx
F000:3FE9  [+0x03FE9]  5B                       pop     bx
F000:3FEA  [+0x03FEA]  5F                       pop     di
F000:3FEB  [+0x03FEB]  07                       pop     es
F000:3FEC  [+0x03FEC]  1F                       pop     ds
F000:3FED  [+0x03FED]  CF                       iret
F000:3FEE  [+0x03FEE]  26 30 05                 xor     [es:di],al
F000:3FF1  [+0x03FF1]  EB F2                    jmp     short 3FE5h
F000:3FF3  [+0x03FF3]  90                       nop
F000:3FF4  [+0x03FF4]  1E                       push    ds
F000:3FF5  [+0x03FF5]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:3FFA  [+0x03FFA]  8A 26 49 04              mov     ah,[449h]
F000:3FFE  [+0x03FFE]  80 FC 0D                 cmp     ah,0Dh
F000:4001  [+0x04001]  72 B5                    jb      short 3FB8h
F000:4003  [+0x04003]  80 FC 13                 cmp     ah,13h
F000:4006  [+0x04006]  73 8C                    jae     short 3F94h
F000:4008  [+0x04008]  53                       push    bx
F000:4009  [+0x04009]  51                       push    cx
F000:400A  [+0x0400A]  52                       push    dx
F000:400B  [+0x0400B]  87 D9                    xchg    bx,cx
F000:400D  [+0x0400D]  8A CB                    mov     cl,bl
F000:400F  [+0x0400F]  D1 EB                    shr     bx,1
F000:4011  [+0x04011]  D1 EB                    shr     bx,1
F000:4013  [+0x04013]  D1 EB                    shr     bx,1
F000:4015  [+0x04015]  0A ED                    or      ch,ch
F000:4017  [+0x04017]  75 3F                    jne     short 4058h
F000:4019  [+0x04019]  8A E8                    mov     ch,al
F000:401B  [+0x0401B]  A1 4A 04                 mov     ax,[44Ah]
F000:401E  [+0x0401E]  F7 E2                    mul     dx
F000:4020  [+0x04020]  03 D8                    add     bx,ax
F000:4022  [+0x04022]  BA CE 03                 mov     dx,3CEh
F000:4025  [+0x04025]  33 C0                    xor     ax,ax
F000:4027  [+0x04027]  EF                       out     dx,ax
F000:4028  [+0x04028]  B8 01 0F                 mov     ax,0F01h
F000:402B  [+0x0402B]  EF                       out     dx,ax
F000:402C  [+0x0402C]  80 E1 07                 and     cl,7
F000:402F  [+0x0402F]  B8 08 80                 mov     ax,8008h
F000:4032  [+0x04032]  D2 EC                    shr     ah,cl
F000:4034  [+0x04034]  EF                       out     dx,ax
F000:4035  [+0x04035]  B8 00 A0                 mov     ax,0A000h
F000:4038  [+0x04038]  8E D8                    mov     ds,ax
F000:403A  [+0x0403A]  0A ED                    or      ch,ch
F000:403C  [+0x0403C]  78 26                    js      short 4064h
F000:403E  [+0x0403E]  08 07                    or      [bx],al
F000:4040  [+0x04040]  8A E5                    mov     ah,ch
F000:4042  [+0x04042]  EF                       out     dx,ax
F000:4043  [+0x04043]  08 07                    or      [bx],al
F000:4045  [+0x04045]  B8 08 FF                 mov     ax,0FF08h
F000:4048  [+0x04048]  EF                       out     dx,ax
F000:4049  [+0x04049]  33 C0                    xor     ax,ax
F000:404B  [+0x0404B]  EF                       out     dx,ax
F000:404C  [+0x0404C]  FE C0                    inc     al
F000:404E  [+0x0404E]  EF                       out     dx,ax
F000:404F  [+0x0404F]  8A C5                    mov     al,ch
F000:4051  [+0x04051]  B4 0C                    mov     ah,0Ch
F000:4053  [+0x04053]  5A                       pop     dx
F000:4054  [+0x04054]  59                       pop     cx
F000:4055  [+0x04055]  5B                       pop     bx
F000:4056  [+0x04056]  1F                       pop     ds
F000:4057  [+0x04057]  CF                       iret
F000:4058  [+0x04058]  03 1E 4C 04              add     bx,[44Ch]
F000:405C  [+0x0405C]  FE CD                    dec     ch
F000:405E  [+0x0405E]  75 F8                    jne     short 4058h
F000:4060  [+0x04060]  EB B7                    jmp     short 4019h
F000:4062  [+0x04062]  87 DB                    xchg    bx,bx
F000:4064  [+0x04064]  B8 03 18                 mov     ax,1803h
F000:4067  [+0x04067]  EF                       out     dx,ax
F000:4068  [+0x04068]  8A E5                    mov     ah,ch
F000:406A  [+0x0406A]  32 C0                    xor     al,al
F000:406C  [+0x0406C]  EF                       out     dx,ax
F000:406D  [+0x0406D]  08 07                    or      [bx],al
F000:406F  [+0x0406F]  B8 03 00                 mov     ax,3
F000:4072  [+0x04072]  EF                       out     dx,ax
F000:4073  [+0x04073]  EB D0                    jmp     short 4045h
F000:4075  [+0x04075]  87 DB                    xchg    bx,bx
F000:4077  [+0x04077]  90                       nop
F000:4078  [+0x04078]  77 18                    ja      short 4092h
F000:407A  [+0x0407A]  52                       push    dx
F000:407B  [+0x0407B]  57                       push    di
F000:407C  [+0x0407C]  2E 8E 1E 7B 26           mov     ds,[cs:267Bh]
F000:4081  [+0x04081]  B8 40 01                 mov     ax,140h
F000:4084  [+0x04084]  F7 E2                    mul     dx
F000:4086  [+0x04086]  03 C1                    add     ax,cx
F000:4088  [+0x04088]  8B F8                    mov     di,ax
F000:408A  [+0x0408A]  8A 05                    mov     al,[di]
F000:408C  [+0x0408C]  B4 0D                    mov     ah,0Dh
F000:408E  [+0x0408E]  5F                       pop     di
F000:408F  [+0x0408F]  5A                       pop     dx
F000:4090  [+0x04090]  1F                       pop     ds
F000:4091  [+0x04091]  CF                       iret
F000:4092  [+0x04092]  E9 F9 DA                 jmp     1B8Eh
F000:4095  [+0x04095]  87 DB                    xchg    bx,bx
F000:4097  [+0x04097]  90                       nop
F000:4098  [+0x04098]  80 FC 04                 cmp     ah,4
F000:409B  [+0x0409B]  72 20                    jb      short 40BDh
F000:409D  [+0x0409D]  80 FC 07                 cmp     ah,7
F000:40A0  [+0x040A0]  74 1B                    je      short 40BDh
F000:40A2  [+0x040A2]  80 FC 08                 cmp     ah,8
F000:40A5  [+0x040A5]  73 2D                    jae     short 40D4h
F000:40A7  [+0x040A7]  06                       push    es
F000:40A8  [+0x040A8]  57                       push    di
F000:40A9  [+0x040A9]  51                       push    cx
F000:40AA  [+0x040AA]  52                       push    dx
F000:40AB  [+0x040AB]  E8 76 00                 call    4124h
F000:40AE  [+0x040AE]  F6 D4                    not     ah
F000:40B0  [+0x040B0]  26 22 25                 and     ah,[es:di]
F000:40B3  [+0x040B3]  D2 EC                    shr     ah,cl
F000:40B5  [+0x040B5]  8A C4                    mov     al,ah
F000:40B7  [+0x040B7]  B4 0D                    mov     ah,0Dh
F000:40B9  [+0x040B9]  5A                       pop     dx
F000:40BA  [+0x040BA]  59                       pop     cx
F000:40BB  [+0x040BB]  5F                       pop     di
F000:40BC  [+0x040BC]  07                       pop     es
F000:40BD  [+0x040BD]  1F                       pop     ds
F000:40BE  [+0x040BE]  CF                       iret
F000:40BF  [+0x040BF]  90                       nop
F000:40C0  [+0x040C0]  1E                       push    ds
F000:40C1  [+0x040C1]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:40C6  [+0x040C6]  8A 26 49 04              mov     ah,[449h]
F000:40CA  [+0x040CA]  80 FC 0D                 cmp     ah,0Dh
F000:40CD  [+0x040CD]  72 C9                    jb      short 4098h
F000:40CF  [+0x040CF]  80 FC 13                 cmp     ah,13h
F000:40D2  [+0x040D2]  73 A4                    jae     short 4078h
F000:40D4  [+0x040D4]  56                       push    si
F000:40D5  [+0x040D5]  53                       push    bx
F000:40D6  [+0x040D6]  51                       push    cx
F000:40D7  [+0x040D7]  52                       push    dx
F000:40D8  [+0x040D8]  8B F1                    mov     si,cx
F000:40DA  [+0x040DA]  D1 EE                    shr     si,1
F000:40DC  [+0x040DC]  D1 EE                    shr     si,1
F000:40DE  [+0x040DE]  D1 EE                    shr     si,1
F000:40E0  [+0x040E0]  0A FF                    or      bh,bh
F000:40E2  [+0x040E2]  75 34                    jne     short 4118h
F000:40E4  [+0x040E4]  A1 4A 04                 mov     ax,[44Ah]
F000:40E7  [+0x040E7]  F7 E2                    mul     dx
F000:40E9  [+0x040E9]  03 F0                    add     si,ax
F000:40EB  [+0x040EB]  80 E1 07                 and     cl,7
F000:40EE  [+0x040EE]  B3 80                    mov     bl,80h
F000:40F0  [+0x040F0]  D2 EB                    shr     bl,cl
F000:40F2  [+0x040F2]  2E 8E 1E 7B 26           mov     ds,[cs:267Bh]
F000:40F7  [+0x040F7]  BA CE 03                 mov     dx,3CEh
F000:40FA  [+0x040FA]  32 C9                    xor     cl,cl
F000:40FC  [+0x040FC]  B8 04 03                 mov     ax,304h
F000:40FF  [+0x040FF]  EF                       out     dx,ax
F000:4100  [+0x04100]  8A 2C                    mov     ch,[si]
F000:4102  [+0x04102]  22 EB                    and     ch,bl
F000:4104  [+0x04104]  F6 DD                    neg     ch
F000:4106  [+0x04106]  D1 C1                    rol     cx,1
F000:4108  [+0x04108]  FE CC                    dec     ah
F000:410A  [+0x0410A]  79 F3                    jns     short 40FFh
F000:410C  [+0x0410C]  8A C1                    mov     al,cl
F000:410E  [+0x0410E]  B4 0D                    mov     ah,0Dh
F000:4110  [+0x04110]  5A                       pop     dx
F000:4111  [+0x04111]  59                       pop     cx
F000:4112  [+0x04112]  5B                       pop     bx
F000:4113  [+0x04113]  5E                       pop     si
F000:4114  [+0x04114]  1F                       pop     ds
F000:4115  [+0x04115]  CF                       iret
F000:4116  [+0x04116]  87 DB                    xchg    bx,bx
F000:4118  [+0x04118]  03 36 4C 04              add     si,[44Ch]
F000:411C  [+0x0411C]  FE CF                    dec     bh
F000:411E  [+0x0411E]  75 F8                    jne     short 4118h
F000:4120  [+0x04120]  EB C2                    jmp     short 40E4h
F000:4122  [+0x04122]  87 DB                    xchg    bx,bx
F000:4124  [+0x04124]  B8 00 B8                 mov     ax,0B800h
F000:4127  [+0x04127]  8E C0                    mov     es,ax
F000:4129  [+0x04129]  B0 28                    mov     al,28h
F000:412B  [+0x0412B]  F6 E2                    mul     dl
F000:412D  [+0x0412D]  A8 08                    test    al,8
F000:412F  [+0x0412F]  74 03                    je      short 4134h
F000:4131  [+0x04131]  05 D8 1F                 add     ax,1FD8h
F000:4134  [+0x04134]  8B F8                    mov     di,ax
F000:4136  [+0x04136]  8A C1                    mov     al,cl
F000:4138  [+0x04138]  F6 D0                    not     al
F000:413A  [+0x0413A]  80 3E 49 04 06           cmp     byte [449h],6
F000:413F  [+0x0413F]  72 08                    jb      short 4149h
F000:4141  [+0x04141]  D1 E9                    shr     cx,1
F000:4143  [+0x04143]  B4 FE                    mov     ah,0FEh
F000:4145  [+0x04145]  24 07                    and     al,7
F000:4147  [+0x04147]  EB 06                    jmp     short 414Fh
F000:4149  [+0x04149]  B4 FC                    mov     ah,0FCh
F000:414B  [+0x0414B]  D0 E0                    shl     al,1
F000:414D  [+0x0414D]  24 06                    and     al,6
F000:414F  [+0x0414F]  D1 E9                    shr     cx,1
F000:4151  [+0x04151]  D1 E9                    shr     cx,1
F000:4153  [+0x04153]  03 F9                    add     di,cx
F000:4155  [+0x04155]  8A C8                    mov     cl,al
F000:4157  [+0x04157]  D2 C4                    rol     ah,cl
F000:4159  [+0x04159]  C3                       ret
F000:415A  [+0x0415A]  87 DB                    xchg    bx,bx
F000:415C  [+0x0415C]  74 12                    je      short 4170h
F000:415E  [+0x0415E]  3C 0A                    cmp     al,0Ah
F000:4160  [+0x04160]  74 5B                    je      short 41BDh
F000:4162  [+0x04162]  3C 08                    cmp     al,8
F000:4164  [+0x04164]  74 12                    je      short 4178h
F000:4166  [+0x04166]  3C 07                    cmp     al,7
F000:4168  [+0x04168]  75 3C                    jne     short 41A6h
F000:416A  [+0x0416A]  E8 D2 00                 call    423Fh
F000:416D  [+0x0416D]  E9 BB 00                 jmp     422Bh
F000:4170  [+0x04170]  32 D2                    xor     dl,dl
F000:4172  [+0x04172]  E9 8D 00                 jmp     4202h
F000:4175  [+0x04175]  87 DB                    xchg    bx,bx
F000:4177  [+0x04177]  90                       nop
F000:4178  [+0x04178]  FE CA                    dec     dl
F000:417A  [+0x0417A]  79 03                    jns     short 417Fh
F000:417C  [+0x0417C]  E9 AC 00                 jmp     422Bh
F000:417F  [+0x0417F]  E9 80 00                 jmp     4202h
F000:4182  [+0x04182]  87 DB                    xchg    bx,bx
F000:4184  [+0x04184]  50                       push    ax
F000:4185  [+0x04185]  53                       push    bx
F000:4186  [+0x04186]  51                       push    cx
F000:4187  [+0x04187]  52                       push    dx
F000:4188  [+0x04188]  56                       push    si
F000:4189  [+0x04189]  57                       push    di
F000:418A  [+0x0418A]  55                       push    bp
F000:418B  [+0x0418B]  06                       push    es
F000:418C  [+0x0418C]  1E                       push    ds
F000:418D  [+0x0418D]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:4192  [+0x04192]  8A 0E 62 04              mov     cl,[462h]
F000:4196  [+0x04196]  32 ED                    xor     ch,ch
F000:4198  [+0x04198]  8B F9                    mov     di,cx
F000:419A  [+0x0419A]  D1 E7                    shl     di,1
F000:419C  [+0x0419C]  8A F9                    mov     bh,cl
F000:419E  [+0x0419E]  8B 95 50 04              mov     dx,[di+450h]
F000:41A2  [+0x041A2]  3C 0D                    cmp     al,0Dh
F000:41A4  [+0x041A4]  76 B6                    jbe     short 415Ch
F000:41A6  [+0x041A6]  52                       push    dx
F000:41A7  [+0x041A7]  B9 01 00                 mov     cx,1
F000:41AA  [+0x041AA]  E8 A9 FA                 call    3C56h
F000:41AD  [+0x041AD]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:41B2  [+0x041B2]  5A                       pop     dx
F000:41B3  [+0x041B3]  FE C2                    inc     dl
F000:41B5  [+0x041B5]  3A 16 4A 04              cmp     dl,[44Ah]
F000:41B9  [+0x041B9]  75 47                    jne     short 4202h
F000:41BB  [+0x041BB]  32 D2                    xor     dl,dl
F000:41BD  [+0x041BD]  FE C6                    inc     dh
F000:41BF  [+0x041BF]  3A 36 84 04              cmp     dh,[484h]
F000:41C3  [+0x041C3]  76 3D                    jbe     short 4202h
F000:41C5  [+0x041C5]  FE CE                    dec     dh
F000:41C7  [+0x041C7]  52                       push    dx
F000:41C8  [+0x041C8]  E8 7F F7                 call    394Ah
F000:41CB  [+0x041CB]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:41D0  [+0x041D0]  8A FC                    mov     bh,ah
F000:41D2  [+0x041D2]  A0 49 04                 mov     al,[449h]
F000:41D5  [+0x041D5]  3C 04                    cmp     al,4
F000:41D7  [+0x041D7]  72 11                    jb      short 41EAh
F000:41D9  [+0x041D9]  3C 07                    cmp     al,7
F000:41DB  [+0x041DB]  74 0D                    je      short 41EAh
F000:41DD  [+0x041DD]  3C 13                    cmp     al,13h
F000:41DF  [+0x041DF]  76 07                    jbe     short 41E8h
F000:41E1  [+0x041E1]  8A E0                    mov     ah,al
F000:41E3  [+0x041E3]  E8 59 DD                 call    1F3Fh
F000:41E6  [+0x041E6]  73 02                    jae     short 41EAh
F000:41E8  [+0x041E8]  32 FF                    xor     bh,bh
F000:41EA  [+0x041EA]  8A 16 4A 04              mov     dl,[44Ah]
F000:41EE  [+0x041EE]  FE CA                    dec     dl
F000:41F0  [+0x041F0]  8A 36 84 04              mov     dh,[484h]
F000:41F4  [+0x041F4]  33 C9                    xor     cx,cx
F000:41F6  [+0x041F6]  B8 01 06                 mov     ax,601h
F000:41F9  [+0x041F9]  E8 42 F2                 call    343Eh
F000:41FC  [+0x041FC]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:4201  [+0x04201]  5A                       pop     dx
F000:4202  [+0x04202]  A0 62 04                 mov     al,[462h]
F000:4205  [+0x04205]  0A C0                    or      al,al
F000:4207  [+0x04207]  75 2F                    jne     short 4238h
F000:4209  [+0x04209]  89 16 50 04              mov     [450h],dx
F000:420D  [+0x0420D]  38 06 62 04              cmp     [462h],al
F000:4211  [+0x04211]  75 18                    jne     short 422Bh
F000:4213  [+0x04213]  A0 4A 04                 mov     al,[44Ah]
F000:4216  [+0x04216]  F6 E6                    mul     dh
F000:4218  [+0x04218]  02 C2                    add     al,dl
F000:421A  [+0x0421A]  80 D4 00                 adc     ah,0
F000:421D  [+0x0421D]  8A D8                    mov     bl,al
F000:421F  [+0x0421F]  B0 0E                    mov     al,0Eh
F000:4221  [+0x04221]  8B 16 63 04              mov     dx,[463h]
F000:4225  [+0x04225]  EF                       out     dx,ax
F000:4226  [+0x04226]  8A E3                    mov     ah,bl
F000:4228  [+0x04228]  FE C0                    inc     al
F000:422A  [+0x0422A]  EF                       out     dx,ax
F000:422B  [+0x0422B]  1F                       pop     ds
F000:422C  [+0x0422C]  07                       pop     es
F000:422D  [+0x0422D]  5D                       pop     bp
F000:422E  [+0x0422E]  5F                       pop     di
F000:422F  [+0x0422F]  5E                       pop     si
F000:4230  [+0x04230]  5A                       pop     dx
F000:4231  [+0x04231]  59                       pop     cx
F000:4232  [+0x04232]  5B                       pop     bx
F000:4233  [+0x04233]  58                       pop     ax
F000:4234  [+0x04234]  CF                       iret
F000:4235  [+0x04235]  87 DB                    xchg    bx,bx
F000:4237  [+0x04237]  90                       nop
F000:4238  [+0x04238]  8A F8                    mov     bh,al
F000:423A  [+0x0423A]  E8 5B F1                 call    3398h
F000:423D  [+0x0423D]  EB EC                    jmp     short 422Bh
F000:423F  [+0x0423F]  50                       push    ax
F000:4240  [+0x04240]  53                       push    bx
F000:4241  [+0x04241]  51                       push    cx
F000:4242  [+0x04242]  52                       push    dx
F000:4243  [+0x04243]  B0 03                    mov     al,3
F000:4245  [+0x04245]  B9 44 02                 mov     cx,244h
F000:4248  [+0x04248]  E8 85 0E                 call    50D0h
F000:424B  [+0x0424B]  5A                       pop     dx
F000:424C  [+0x0424C]  59                       pop     cx
F000:424D  [+0x0424D]  5B                       pop     bx
F000:424E  [+0x0424E]  58                       pop     ax
F000:424F  [+0x0424F]  C3                       ret
F000:4250  [+0x04250]  A0 87 04                 mov     al,[487h]
F000:4253  [+0x04253]  24 80                    and     al,80h
F000:4255  [+0x04255]  0A 06 49 04              or      al,[449h]
F000:4259  [+0x04259]  88 46 10                 mov     [bp+10h],al
F000:425C  [+0x0425C]  A0 4A 04                 mov     al,[44Ah]
F000:425F  [+0x0425F]  88 46 11                 mov     [bp+11h],al
F000:4262  [+0x04262]  A0 62 04                 mov     al,[462h]
F000:4265  [+0x04265]  88 46 0F                 mov     [bp+0Fh],al
F000:4268  [+0x04268]  C3                       ret
F000:4269  [+0x04269]  00 DE                    add     dh,bl
F000:426B  [+0x0426B]  42                       inc     dx
F000:426C  [+0x0426C]  DC 42 E5                 fadd    qword [bp+si-1Bh]
F000:426F  [+0x0426F]  42                       inc     dx
F000:4270  [+0x04270]  06                       push    es
F000:4271  [+0x04271]  43                       inc     bx
F000:4272  [+0x04272]  E4 42                    in      al,42h
F000:4274  [+0x04274]  E4 42                    in      al,42h
F000:4276  [+0x04276]  E4 42                    in      al,42h
F000:4278  [+0x04278]  32 43 30                 xor     al,[bp+di+30h]
F000:427B  [+0x0427B]  43                       inc     bx
F000:427C  [+0x0427C]  39 43 E4                 cmp     [bp+di-1Ch],ax
F000:427F  [+0x0427F]  42                       inc     dx
F000:4280  [+0x04280]  E4 42                    in      al,42h
F000:4282  [+0x04282]  E4 42                    in      al,42h
F000:4284  [+0x04284]  E4 42                    in      al,42h
F000:4286  [+0x04286]  E4 42                    in      al,42h
F000:4288  [+0x04288]  E4 42                    in      al,42h
F000:428A  [+0x0428A]  53                       push    bx
F000:428B  [+0x0428B]  43                       inc     bx
F000:428C  [+0x0428C]  E4 42                    in      al,42h
F000:428E  [+0x0428E]  58                       pop     ax
F000:428F  [+0x0428F]  43                       inc     bx
F000:4290  [+0x04290]  76 43                    jbe     short 42D5h
F000:4292  [+0x04292]  E4 42                    in      al,42h
F000:4294  [+0x04294]  AE                       scasb
F000:4295  [+0x04295]  43                       inc     bx
F000:4296  [+0x04296]  E4 42                    in      al,42h
F000:4298  [+0x04298]  BB 43 D4                 mov     bx,0D443h
F000:429B  [+0x0429B]  43                       inc     bx
F000:429C  [+0x0429C]  DB 43 E5                 fild    dword [bp+di-1Bh]
F000:429F  [+0x0429F]  43                       inc     bx
F000:42A0  [+0x042A0]  07                       pop     es
F000:42A1  [+0x042A1]  44                       inc     sp
F000:42A2  [+0x042A2]  53                       push    bx
F000:42A3  [+0x042A3]  51                       push    cx
F000:42A4  [+0x042A4]  E8 8E 13                 call    5635h
F000:42A7  [+0x042A7]  8B FB                    mov     di,bx
F000:42A9  [+0x042A9]  59                       pop     cx
F000:42AA  [+0x042AA]  5B                       pop     bx
F000:42AB  [+0x042AB]  74 37                    je      short 42E4h
F000:42AD  [+0x042AD]  3C 03                    cmp     al,3
F000:42AF  [+0x042AF]  76 04                    jbe     short 42B5h
F000:42B1  [+0x042B1]  3C 1B                    cmp     al,1Bh
F000:42B3  [+0x042B3]  77 2F                    ja      short 42E4h
F000:42B5  [+0x042B5]  3C 02                    cmp     al,2
F000:42B7  [+0x042B7]  77 18                    ja      short 42D1h
F000:42B9  [+0x042B9]  3C 01                    cmp     al,1
F000:42BB  [+0x042BB]  74 14                    je      short 42D1h
F000:42BD  [+0x042BD]  80 3E 49 04 13           cmp     byte [449h],13h
F000:42C2  [+0x042C2]  72 0D                    jb      short 42D1h
F000:42C4  [+0x042C4]  74 1E                    je      short 42E4h
F000:42C6  [+0x042C6]  50                       push    ax
F000:42C7  [+0x042C7]  8A 26 49 04              mov     ah,[449h]
F000:42CB  [+0x042CB]  E8 71 DC                 call    1F3Fh
F000:42CE  [+0x042CE]  58                       pop     ax
F000:42CF  [+0x042CF]  7A 13                    jp      short 42E4h
F000:42D1  [+0x042D1]  32 E4                    xor     ah,ah
F000:42D3  [+0x042D3]  D1 E0                    shl     ax,1
F000:42D5  [+0x042D5]  8B F0                    mov     si,ax
F000:42D7  [+0x042D7]  2E FF A4 6A 42           jmp     word [cs:si+426Ah]
F000:42DC  [+0x042DC]  B3 11                    mov     bl,11h
F000:42DE  [+0x042DE]  E8 8E FC                 call    3F6Fh
F000:42E1  [+0x042E1]  E8 6D FC                 call    3F51h
F000:42E4  [+0x042E4]  C3                       ret
F000:42E5  [+0x042E5]  B9 10 00                 mov     cx,10h
F000:42E8  [+0x042E8]  32 DB                    xor     bl,bl
F000:42EA  [+0x042EA]  8B F2                    mov     si,dx
F000:42EC  [+0x042EC]  26 8A 3C                 mov     bh,[es:si]
F000:42EF  [+0x042EF]  46                       inc     si
F000:42F0  [+0x042F0]  E8 7C FC                 call    3F6Fh
F000:42F3  [+0x042F3]  E8 5B FC                 call    3F51h
F000:42F6  [+0x042F6]  FE C3                    inc     bl
F000:42F8  [+0x042F8]  E2 F2                    loop    42ECh
F000:42FA  [+0x042FA]  26 8A 3C                 mov     bh,[es:si]
F000:42FD  [+0x042FD]  E8 51 FC                 call    3F51h
F000:4300  [+0x04300]  FE C3                    inc     bl
F000:4302  [+0x04302]  E8 6A FC                 call    3F6Fh
F000:4305  [+0x04305]  C3                       ret
F000:4306  [+0x04306]  B3 10                    mov     bl,10h
F000:4308  [+0x04308]  E8 11 01                 call    441Ch
F000:430B  [+0x0430B]  80 7E 0E 00              cmp     byte [bp+0Eh],0
F000:430F  [+0x0430F]  74 10                    je      short 4321h
F000:4311  [+0x04311]  80 7E 0E 01              cmp     byte [bp+0Eh],1
F000:4315  [+0x04315]  75 18                    jne     short 432Fh
F000:4317  [+0x04317]  80 CF 08                 or      bh,8
F000:431A  [+0x0431A]  A0 65 04                 mov     al,[465h]
F000:431D  [+0x0431D]  0C 20                    or      al,20h
F000:431F  [+0x0431F]  EB 08                    jmp     short 4329h
F000:4321  [+0x04321]  80 E7 F7                 and     bh,0F7h
F000:4324  [+0x04324]  A0 65 04                 mov     al,[465h]
F000:4327  [+0x04327]  24 DF                    and     al,0DFh
F000:4329  [+0x04329]  A2 65 04                 mov     [465h],al
F000:432C  [+0x0432C]  E8 40 FC                 call    3F6Fh
F000:432F  [+0x0432F]  C3                       ret
F000:4330  [+0x04330]  B3 11                    mov     bl,11h
F000:4332  [+0x04332]  E8 E7 00                 call    441Ch
F000:4335  [+0x04335]  88 7E 0F                 mov     [bp+0Fh],bh
F000:4338  [+0x04338]  C3                       ret
F000:4339  [+0x04339]  B9 10 00                 mov     cx,10h
F000:433C  [+0x0433C]  32 DB                    xor     bl,bl
F000:433E  [+0x0433E]  8B FA                    mov     di,dx
F000:4340  [+0x04340]  E8 D9 00                 call    441Ch
F000:4343  [+0x04343]  8A C7                    mov     al,bh
F000:4345  [+0x04345]  AA                       stosb
F000:4346  [+0x04346]  FE C3                    inc     bl
F000:4348  [+0x04348]  E2 F6                    loop    4340h
F000:434A  [+0x0434A]  FE C3                    inc     bl
F000:434C  [+0x0434C]  E8 CD 00                 call    441Ch
F000:434F  [+0x0434F]  8A C7                    mov     al,bh
F000:4351  [+0x04351]  AA                       stosb
F000:4352  [+0x04352]  C3                       ret
F000:4353  [+0x04353]  8A E6                    mov     ah,dh
F000:4355  [+0x04355]  E9 F1 00                 jmp     4449h
F000:4358  [+0x04358]  E8 5C 0F                 call    52B7h
F000:435B  [+0x0435B]  8B F2                    mov     si,dx
F000:435D  [+0x0435D]  8B F9                    mov     di,cx
F000:435F  [+0x0435F]  26 AD                    es lodsw
F000:4361  [+0x04361]  8A EC                    mov     ch,ah
F000:4363  [+0x04363]  8A E0                    mov     ah,al
F000:4365  [+0x04365]  26 AC                    es lodsb
F000:4367  [+0x04367]  8A C8                    mov     cl,al
F000:4369  [+0x04369]  E8 08 01                 call    4474h
F000:436C  [+0x0436C]  E8 2D 0F                 call    529Ch
F000:436F  [+0x0436F]  4F                       dec     di
F000:4370  [+0x04370]  75 ED                    jne     short 435Fh
F000:4372  [+0x04372]  E8 4A 0F                 call    52BFh
F000:4375  [+0x04375]  C3                       ret
F000:4376  [+0x04376]  0A DB                    or      bl,bl
F000:4378  [+0x04378]  74 1D                    je      short 4397h
F000:437A  [+0x0437A]  B3 10                    mov     bl,10h
F000:437C  [+0x0437C]  E8 9D 00                 call    441Ch
F000:437F  [+0x0437F]  8A 46 0F                 mov     al,[bp+0Fh]
F000:4382  [+0x04382]  24 0F                    and     al,0Fh
F000:4384  [+0x04384]  F6 C7 80                 test    bh,80h
F000:4387  [+0x04387]  75 06                    jne     short 438Fh
F000:4389  [+0x04389]  24 03                    and     al,3
F000:438B  [+0x0438B]  D0 E0                    shl     al,1
F000:438D  [+0x0438D]  D0 E0                    shl     al,1
F000:438F  [+0x0438F]  B3 14                    mov     bl,14h
F000:4391  [+0x04391]  8A F8                    mov     bh,al
F000:4393  [+0x04393]  E8 D9 FB                 call    3F6Fh
F000:4396  [+0x04396]  C3                       ret
F000:4397  [+0x04397]  B3 10                    mov     bl,10h
F000:4399  [+0x04399]  E8 80 00                 call    441Ch
F000:439C  [+0x0439C]  80 E7 7F                 and     bh,7Fh
F000:439F  [+0x0439F]  80 7E 0F 00              cmp     byte [bp+0Fh],0
F000:43A3  [+0x043A3]  74 03                    je      short 43A8h
F000:43A5  [+0x043A5]  80 CF 80                 or      bh,80h
F000:43A8  [+0x043A8]  B3 10                    mov     bl,10h
F000:43AA  [+0x043AA]  E8 C2 FB                 call    3F6Fh
F000:43AD  [+0x043AD]  C3                       ret
F000:43AE  [+0x043AE]  E8 AC 00                 call    445Dh
F000:43B1  [+0x043B1]  88 66 0B                 mov     [bp+0Bh],ah
F000:43B4  [+0x043B4]  88 6E 0D                 mov     [bp+0Dh],ch
F000:43B7  [+0x043B7]  88 4E 0C                 mov     [bp+0Ch],cl
F000:43BA  [+0x043BA]  C3                       ret
F000:43BB  [+0x043BB]  E8 F9 0E                 call    52B7h
F000:43BE  [+0x043BE]  8B FA                    mov     di,dx
F000:43C0  [+0x043C0]  8B F1                    mov     si,cx
F000:43C2  [+0x043C2]  E8 BA 0E                 call    527Fh
F000:43C5  [+0x043C5]  8A C4                    mov     al,ah
F000:43C7  [+0x043C7]  8A E5                    mov     ah,ch
F000:43C9  [+0x043C9]  AB                       stosw
F000:43CA  [+0x043CA]  8A C1                    mov     al,cl
F000:43CC  [+0x043CC]  AA                       stosb
F000:43CD  [+0x043CD]  4E                       dec     si
F000:43CE  [+0x043CE]  75 F2                    jne     short 43C2h
F000:43D0  [+0x043D0]  E8 EC 0E                 call    52BFh
F000:43D3  [+0x043D3]  C3                       ret
F000:43D4  [+0x043D4]  BA C6 03                 mov     dx,3C6h
F000:43D7  [+0x043D7]  8A C3                    mov     al,bl
F000:43D9  [+0x043D9]  EE                       out     dx,al
F000:43DA  [+0x043DA]  C3                       ret
F000:43DB  [+0x043DB]  BA C6 03                 mov     dx,3C6h
F000:43DE  [+0x043DE]  EC                       in      al,dx
F000:43DF  [+0x043DF]  32 E4                    xor     ah,ah
F000:43E1  [+0x043E1]  89 46 0E                 mov     [bp+0Eh],ax
F000:43E4  [+0x043E4]  C3                       ret
F000:43E5  [+0x043E5]  B3 14                    mov     bl,14h
F000:43E7  [+0x043E7]  E8 32 00                 call    441Ch
F000:43EA  [+0x043EA]  8A CF                    mov     cl,bh
F000:43EC  [+0x043EC]  80 E1 0F                 and     cl,0Fh
F000:43EF  [+0x043EF]  B3 10                    mov     bl,10h
F000:43F1  [+0x043F1]  E8 28 00                 call    441Ch
F000:43F4  [+0x043F4]  B3 01                    mov     bl,1
F000:43F6  [+0x043F6]  F6 C7 80                 test    bh,80h
F000:43F9  [+0x043F9]  75 06                    jne     short 4401h
F000:43FB  [+0x043FB]  B3 00                    mov     bl,0
F000:43FD  [+0x043FD]  D0 E9                    shr     cl,1
F000:43FF  [+0x043FF]  D0 E9                    shr     cl,1
F000:4401  [+0x04401]  8A F9                    mov     bh,cl
F000:4403  [+0x04403]  89 5E 0E                 mov     [bp+0Eh],bx
F000:4406  [+0x04406]  C3                       ret
F000:4407  [+0x04407]  E8 AD 0E                 call    52B7h
F000:440A  [+0x0440A]  8B F1                    mov     si,cx
F000:440C  [+0x0440C]  E8 70 0E                 call    527Fh
F000:440F  [+0x0440F]  E8 69 00                 call    447Bh
F000:4412  [+0x04412]  4B                       dec     bx
F000:4413  [+0x04413]  E8 86 0E                 call    529Ch
F000:4416  [+0x04416]  4E                       dec     si
F000:4417  [+0x04417]  75 F3                    jne     short 440Ch
F000:4419  [+0x04419]  E9 A3 0E                 jmp     52BFh
F000:441C  [+0x0441C]  52                       push    dx
F000:441D  [+0x0441D]  8B 16 63 04              mov     dx,[463h]
F000:4421  [+0x04421]  80 C2 06                 add     dl,6
F000:4424  [+0x04424]  52                       push    dx
F000:4425  [+0x04425]  EC                       in      al,dx
F000:4426  [+0x04426]  24 08                    and     al,8
F000:4428  [+0x04428]  74 FB                    je      short 4425h
F000:442A  [+0x0442A]  52                       push    dx
F000:442B  [+0x0442B]  BA C0 03                 mov     dx,3C0h
F000:442E  [+0x0442E]  8A C3                    mov     al,bl
F000:4430  [+0x04430]  9C                       pushf
F000:4431  [+0x04431]  FA                       cli
F000:4432  [+0x04432]  EE                       out     dx,al
F000:4433  [+0x04433]  EB 00                    jmp     short 4435h
F000:4435  [+0x04435]  42                       inc     dx
F000:4436  [+0x04436]  EC                       in      al,dx
F000:4437  [+0x04437]  9D                       popf
F000:4438  [+0x04438]  5A                       pop     dx
F000:4439  [+0x04439]  8A F8                    mov     bh,al
F000:443B  [+0x0443B]  9C                       pushf
F000:443C  [+0x0443C]  FA                       cli
F000:443D  [+0x0443D]  EC                       in      al,dx
F000:443E  [+0x0443E]  BA C0 03                 mov     dx,3C0h
F000:4441  [+0x04441]  B0 20                    mov     al,20h
F000:4443  [+0x04443]  EE                       out     dx,al
F000:4444  [+0x04444]  9D                       popf
F000:4445  [+0x04445]  5A                       pop     dx
F000:4446  [+0x04446]  EC                       in      al,dx
F000:4447  [+0x04447]  5A                       pop     dx
F000:4448  [+0x04448]  C3                       ret
F000:4449  [+0x04449]  E8 28 00                 call    4474h
F000:444C  [+0x0444C]  8B 16 63 04              mov     dx,[463h]
F000:4450  [+0x04450]  80 C2 06                 add     dl,6
F000:4453  [+0x04453]  9C                       pushf
F000:4454  [+0x04454]  FA                       cli
F000:4455  [+0x04455]  EC                       in      al,dx
F000:4456  [+0x04456]  24 08                    and     al,8
F000:4458  [+0x04458]  74 FB                    je      short 4455h
F000:445A  [+0x0445A]  E9 41 0E                 jmp     529Eh
F000:445D  [+0x0445D]  8B 16 63 04              mov     dx,[463h]
F000:4461  [+0x04461]  80 C2 06                 add     dl,6
F000:4464  [+0x04464]  9C                       pushf
F000:4465  [+0x04465]  FA                       cli
F000:4466  [+0x04466]  EC                       in      al,dx
F000:4467  [+0x04467]  24 08                    and     al,8
F000:4469  [+0x04469]  74 FB                    je      short 4466h
F000:446B  [+0x0446B]  E9 13 0E                 jmp     5281h
F000:446E  [+0x0446E]  66 26 85 4B 14           test    [es:bp+di+14h],ecx
F000:4473  [+0x04473]  0E                       push    cs
F000:4474  [+0x04474]  F6 06 89 04 06           test    byte [489h],6
F000:4479  [+0x04479]  74 44                    je      short 44BFh
F000:447B  [+0x0447B]  53                       push    bx
F000:447C  [+0x0447C]  52                       push    dx
F000:447D  [+0x0447D]  25 00 3F                 and     ax,3F00h
F000:4480  [+0x04480]  86 C4                    xchg    al,ah
F000:4482  [+0x04482]  2E F7 26 6E 44           mul     word [cs:446Eh]
F000:4487  [+0x04487]  52                       push    dx
F000:4488  [+0x04488]  50                       push    ax
F000:4489  [+0x04489]  8A C5                    mov     al,ch
F000:448B  [+0x0448B]  24 3F                    and     al,3Fh
F000:448D  [+0x0448D]  32 E4                    xor     ah,ah
F000:448F  [+0x0448F]  2E F7 26 70 44           mul     word [cs:4470h]
F000:4494  [+0x04494]  52                       push    dx
F000:4495  [+0x04495]  50                       push    ax
F000:4496  [+0x04496]  8A C1                    mov     al,cl
F000:4498  [+0x04498]  24 3F                    and     al,3Fh
F000:449A  [+0x0449A]  32 E4                    xor     ah,ah
F000:449C  [+0x0449C]  2E F7 26 72 44           mul     word [cs:4472h]
F000:44A1  [+0x044A1]  5B                       pop     bx
F000:44A2  [+0x044A2]  03 C3                    add     ax,bx
F000:44A4  [+0x044A4]  5B                       pop     bx
F000:44A5  [+0x044A5]  13 D3                    adc     dx,bx
F000:44A7  [+0x044A7]  5B                       pop     bx
F000:44A8  [+0x044A8]  03 C3                    add     ax,bx
F000:44AA  [+0x044AA]  5B                       pop     bx
F000:44AB  [+0x044AB]  13 D3                    adc     dx,bx
F000:44AD  [+0x044AD]  03 C0                    add     ax,ax
F000:44AF  [+0x044AF]  13 D2                    adc     dx,dx
F000:44B1  [+0x044B1]  05 00 80                 add     ax,8000h
F000:44B4  [+0x044B4]  83 D2 00                 adc     dx,0
F000:44B7  [+0x044B7]  8A E2                    mov     ah,dl
F000:44B9  [+0x044B9]  8A CA                    mov     cl,dl
F000:44BB  [+0x044BB]  8A EA                    mov     ch,dl
F000:44BD  [+0x044BD]  5A                       pop     dx
F000:44BE  [+0x044BE]  5B                       pop     bx
F000:44BF  [+0x044BF]  C3                       ret
F000:44C0  [+0x044C0]  1C 45                    sbb     al,45h
F000:44C2  [+0x044C2]  1F                       pop     ds
F000:44C3  [+0x044C3]  45                       inc     bp
F000:44C4  [+0x044C4]  2A 45 35                 sub     al,[di+35h]
F000:44C7  [+0x044C7]  45                       inc     bp
F000:44C8  [+0x044C8]  3E 45                    inc     bp
F000:44CA  [+0x044CA]  1B 45 1B                 sbb     ax,[di+1Bh]
F000:44CD  [+0x044CD]  45                       inc     bp
F000:44CE  [+0x044CE]  1B 45 49                 sbb     ax,[di+49h]
F000:44D1  [+0x044D1]  45                       inc     bp
F000:44D2  [+0x044D2]  4E                       dec     si
F000:44D3  [+0x044D3]  45                       inc     bp
F000:44D4  [+0x044D4]  5B                       pop     bx
F000:44D5  [+0x044D5]  45                       inc     bp
F000:44D6  [+0x044D6]  1B 45 68                 sbb     ax,[di+68h]
F000:44D9  [+0x044D9]  45                       inc     bp
F000:44DA  [+0x044DA]  1B 45 1B                 sbb     ax,[di+1Bh]
F000:44DD  [+0x044DD]  45                       inc     bp
F000:44DE  [+0x044DE]  1B 45 48                 sbb     ax,[di+48h]
F000:44E1  [+0x044E1]  46                       inc     si
F000:44E2  [+0x044E2]  8D 46 5D                 lea     ax,[bp+5Dh]
F000:44E5  [+0x044E5]  46                       inc     si
F000:44E6  [+0x044E6]  6C                       insb
F000:44E7  [+0x044E7]  46                       inc     si
F000:44E8  [+0x044E8]  7B 46                    jnp     short 4530h
F000:44EA  [+0x044EA]  1B 45 1B                 sbb     ax,[di+1Bh]
F000:44ED  [+0x044ED]  45                       inc     bp
F000:44EE  [+0x044EE]  1B 45 CC                 sbb     ax,[di-34h]
F000:44F1  [+0x044F1]  46                       inc     si
F000:44F2  [+0x044F2]  53                       push    bx
F000:44F3  [+0x044F3]  51                       push    cx
F000:44F4  [+0x044F4]  E8 3E 11                 call    5635h
F000:44F7  [+0x044F7]  59                       pop     cx
F000:44F8  [+0x044F8]  5B                       pop     bx
F000:44F9  [+0x044F9]  74 20                    je      short 451Bh
F000:44FB  [+0x044FB]  8B 76 04                 mov     si,[bp+4]
F000:44FE  [+0x044FE]  80 E3 3F                 and     bl,3Fh
F000:4501  [+0x04501]  8A E0                    mov     ah,al
F000:4503  [+0x04503]  24 0F                    and     al,0Fh
F000:4505  [+0x04505]  80 E4 30                 and     ah,30h
F000:4508  [+0x04508]  D0 EC                    shr     ah,1
F000:450A  [+0x0450A]  0A C4                    or      al,ah
F000:450C  [+0x0450C]  3C 19                    cmp     al,19h
F000:450E  [+0x0450E]  73 0B                    jae     short 451Bh
F000:4510  [+0x04510]  32 E4                    xor     ah,ah
F000:4512  [+0x04512]  8B F8                    mov     di,ax
F000:4514  [+0x04514]  D1 E7                    shl     di,1
F000:4516  [+0x04516]  2E FF A5 C0 44           jmp     word [cs:di+44C0h]
F000:451B  [+0x0451B]  C3                       ret
F000:451C  [+0x0451C]  E9 BC 0F                 jmp     54DBh
F000:451F  [+0x0451F]  BE 54 5E                 mov     si,5E54h
F000:4522  [+0x04522]  E8 EB 01                 call    4710h
F000:4525  [+0x04525]  B7 0E                    mov     bh,0Eh
F000:4527  [+0x04527]  E9 B1 0F                 jmp     54DBh
F000:452A  [+0x0452A]  BE 54 56                 mov     si,5654h
F000:452D  [+0x0452D]  E8 E0 01                 call    4710h
F000:4530  [+0x04530]  B7 08                    mov     bh,8
F000:4532  [+0x04532]  E9 A6 0F                 jmp     54DBh
F000:4535  [+0x04535]  B0 03                    mov     al,3
F000:4537  [+0x04537]  8A E3                    mov     ah,bl
F000:4539  [+0x04539]  BA C4 03                 mov     dx,3C4h
F000:453C  [+0x0453C]  EF                       out     dx,ax
F000:453D  [+0x0453D]  C3                       ret
F000:453E  [+0x0453E]  BE 64 6D                 mov     si,6D64h
F000:4541  [+0x04541]  E8 CC 01                 call    4710h
F000:4544  [+0x04544]  B7 10                    mov     bh,10h
F000:4546  [+0x04546]  E9 92 0F                 jmp     54DBh
F000:4549  [+0x04549]  E8 8F 0F                 call    54DBh
F000:454C  [+0x0454C]  EB 27                    jmp     short 4575h
F000:454E  [+0x0454E]  BE 54 5E                 mov     si,5E54h
F000:4551  [+0x04551]  E8 BC 01                 call    4710h
F000:4554  [+0x04554]  B7 0E                    mov     bh,0Eh
F000:4556  [+0x04556]  E8 82 0F                 call    54DBh
F000:4559  [+0x04559]  EB 1A                    jmp     short 4575h
F000:455B  [+0x0455B]  BE 54 56                 mov     si,5654h
F000:455E  [+0x0455E]  E8 AF 01                 call    4710h
F000:4561  [+0x04561]  B7 08                    mov     bh,8
F000:4563  [+0x04563]  E8 75 0F                 call    54DBh
F000:4566  [+0x04566]  EB 0D                    jmp     short 4575h
F000:4568  [+0x04568]  BE 64 6D                 mov     si,6D64h
F000:456B  [+0x0456B]  E8 A2 01                 call    4710h
F000:456E  [+0x0456E]  B7 10                    mov     bh,10h
F000:4570  [+0x04570]  E8 68 0F                 call    54DBh
F000:4573  [+0x04573]  EB 00                    jmp     short 4575h
F000:4575  [+0x04575]  88 3E 85 04              mov     [485h],bh
F000:4579  [+0x04579]  BB 90 01                 mov     bx,190h
F000:457C  [+0x0457C]  A0 49 04                 mov     al,[449h]
F000:457F  [+0x0457F]  3C 11                    cmp     al,11h
F000:4581  [+0x04581]  74 4E                    je      short 45D1h
F000:4583  [+0x04583]  3C 12                    cmp     al,12h
F000:4585  [+0x04585]  74 4A                    je      short 45D1h
F000:4587  [+0x04587]  BB C8 00                 mov     bx,0C8h
F000:458A  [+0x0458A]  3C 13                    cmp     al,13h
F000:458C  [+0x0458C]  74 43                    je      short 45D1h
F000:458E  [+0x0458E]  3C 04                    cmp     al,4
F000:4590  [+0x04590]  72 13                    jb      short 45A5h
F000:4592  [+0x04592]  3C 06                    cmp     al,6
F000:4594  [+0x04594]  76 3B                    jbe     short 45D1h
F000:4596  [+0x04596]  3C 09                    cmp     al,9
F000:4598  [+0x04598]  72 0B                    jb      short 45A5h
F000:459A  [+0x0459A]  3C 0E                    cmp     al,0Eh
F000:459C  [+0x0459C]  76 33                    jbe     short 45D1h
F000:459E  [+0x0459E]  BB 5E 01                 mov     bx,15Eh
F000:45A1  [+0x045A1]  3C 10                    cmp     al,10h
F000:45A3  [+0x045A3]  76 2C                    jbe     short 45D1h
F000:45A5  [+0x045A5]  BB 90 01                 mov     bx,190h
F000:45A8  [+0x045A8]  F6 06 89 04 10           test    byte [489h],10h
F000:45AD  [+0x045AD]  75 22                    jne     short 45D1h
F000:45AF  [+0x045AF]  BB 5E 01                 mov     bx,15Eh
F000:45B2  [+0x045B2]  F6 06 87 04 02           test    byte [487h],2
F000:45B7  [+0x045B7]  75 18                    jne     short 45D1h
F000:45B9  [+0x045B9]  8A 26 88 04              mov     ah,[488h]
F000:45BD  [+0x045BD]  80 E4 0F                 and     ah,0Fh
F000:45C0  [+0x045C0]  80 FC 03                 cmp     ah,3
F000:45C3  [+0x045C3]  74 0C                    je      short 45D1h
F000:45C5  [+0x045C5]  80 FC 09                 cmp     ah,9
F000:45C8  [+0x045C8]  74 07                    je      short 45D1h
F000:45CA  [+0x045CA]  3C 07                    cmp     al,7
F000:45CC  [+0x045CC]  74 03                    je      short 45D1h
F000:45CE  [+0x045CE]  BB C8 00                 mov     bx,0C8h
F000:45D1  [+0x045D1]  8B C3                    mov     ax,bx
F000:45D3  [+0x045D3]  33 D2                    xor     dx,dx
F000:45D5  [+0x045D5]  F7 36 85 04              div     word [485h]
F000:45D9  [+0x045D9]  FE C8                    dec     al
F000:45DB  [+0x045DB]  A2 84 04                 mov     [484h],al
F000:45DE  [+0x045DE]  FE C0                    inc     al
F000:45E0  [+0x045E0]  8B 0E 4A 04              mov     cx,[44Ah]
F000:45E4  [+0x045E4]  D1 E1                    shl     cx,1
F000:45E6  [+0x045E6]  32 E4                    xor     ah,ah
F000:45E8  [+0x045E8]  F7 E1                    mul     cx
F000:45EA  [+0x045EA]  05 00 01                 add     ax,100h
F000:45ED  [+0x045ED]  A3 4C 04                 mov     [44Ch],ax
F000:45F0  [+0x045F0]  8B 16 63 04              mov     dx,[463h]
F000:45F4  [+0x045F4]  8A 26 85 04              mov     ah,[485h]
F000:45F8  [+0x045F8]  FE CC                    dec     ah
F000:45FA  [+0x045FA]  80 3E 49 04 07           cmp     byte [449h],7
F000:45FF  [+0x045FF]  75 03                    jne     short 4604h
F000:4601  [+0x04601]  B0 14                    mov     al,14h
F000:4603  [+0x04603]  EF                       out     dx,ax
F000:4604  [+0x04604]  B0 09                    mov     al,9
F000:4606  [+0x04606]  E8 90 0A                 call    5099h
F000:4609  [+0x04609]  24 E0                    and     al,0E0h
F000:460B  [+0x0460B]  50                       push    ax
F000:460C  [+0x0460C]  0A E0                    or      ah,al
F000:460E  [+0x0460E]  B0 09                    mov     al,9
F000:4610  [+0x04610]  4A                       dec     dx
F000:4611  [+0x04611]  EF                       out     dx,ax
F000:4612  [+0x04612]  58                       pop     ax
F000:4613  [+0x04613]  8A EC                    mov     ch,ah
F000:4615  [+0x04615]  8A CC                    mov     cl,ah
F000:4617  [+0x04617]  FE CD                    dec     ch
F000:4619  [+0x04619]  80 FC 0C                 cmp     ah,0Ch
F000:461C  [+0x0461C]  76 04                    jbe     short 4622h
F000:461E  [+0x0461E]  81 E9 01 01              sub     cx,101h
F000:4622  [+0x04622]  89 0E 60 04              mov     [460h],cx
F000:4626  [+0x04626]  B0 0A                    mov     al,0Ah
F000:4628  [+0x04628]  8A E5                    mov     ah,ch
F000:462A  [+0x0462A]  EF                       out     dx,ax
F000:462B  [+0x0462B]  FE C0                    inc     al
F000:462D  [+0x0462D]  8A E1                    mov     ah,cl
F000:462F  [+0x0462F]  EF                       out     dx,ax
F000:4630  [+0x04630]  A0 84 04                 mov     al,[484h]
F000:4633  [+0x04633]  FE C0                    inc     al
F000:4635  [+0x04635]  F6 26 85 04              mul     byte [485h]
F000:4639  [+0x04639]  81 FB C8 00              cmp     bx,0C8h
F000:463D  [+0x0463D]  75 02                    jne     short 4641h
F000:463F  [+0x0463F]  D1 E0                    shl     ax,1
F000:4641  [+0x04641]  48                       dec     ax
F000:4642  [+0x04642]  8A E0                    mov     ah,al
F000:4644  [+0x04644]  B0 12                    mov     al,12h
F000:4646  [+0x04646]  EF                       out     dx,ax
F000:4647  [+0x04647]  C3                       ret
F000:4648  [+0x04648]  8C C7                    mov     di,es
F000:464A  [+0x0464A]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:464F  [+0x0464F]  9C                       pushf
F000:4650  [+0x04650]  FA                       cli
F000:4651  [+0x04651]  26 89 36 7C 00           mov     [es:7Ch],si
F000:4656  [+0x04656]  26 89 3E 7E 00           mov     [es:7Eh],di
F000:465B  [+0x0465B]  9D                       popf
F000:465C  [+0x0465C]  C3                       ret
F000:465D  [+0x0465D]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:4662  [+0x04662]  BE 54 5E                 mov     si,5E54h
F000:4665  [+0x04665]  8C CF                    mov     di,cs
F000:4667  [+0x04667]  B9 0E 00                 mov     cx,0Eh
F000:466A  [+0x0466A]  EB 28                    jmp     short 4694h
F000:466C  [+0x0466C]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:4671  [+0x04671]  BE 54 56                 mov     si,5654h
F000:4674  [+0x04674]  8C CF                    mov     di,cs
F000:4676  [+0x04676]  B9 08 00                 mov     cx,8
F000:4679  [+0x04679]  EB 19                    jmp     short 4694h
F000:467B  [+0x0467B]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:4680  [+0x04680]  BE 64 6D                 mov     si,6D64h
F000:4683  [+0x04683]  8C CF                    mov     di,cs
F000:4685  [+0x04685]  B9 10 00                 mov     cx,10h
F000:4688  [+0x04688]  EB 0A                    jmp     short 4694h
F000:468A  [+0x0468A]  0D 18 2A                 or      ax,2A18h
F000:468D  [+0x0468D]  8C C7                    mov     di,es
F000:468F  [+0x0468F]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:4694  [+0x04694]  9C                       pushf
F000:4695  [+0x04695]  FA                       cli
F000:4696  [+0x04696]  26 89 36 0C 01           mov     [es:10Ch],si
F000:469B  [+0x0469B]  26 89 3E 0E 01           mov     [es:10Eh],di
F000:46A0  [+0x046A0]  9D                       popf
F000:46A1  [+0x046A1]  80 FB 04                 cmp     bl,4
F000:46A4  [+0x046A4]  72 02                    jb      short 46A8h
F000:46A6  [+0x046A6]  B3 03                    mov     bl,3
F000:46A8  [+0x046A8]  FE CA                    dec     dl
F000:46AA  [+0x046AA]  0A DB                    or      bl,bl
F000:46AC  [+0x046AC]  74 09                    je      short 46B7h
F000:46AE  [+0x046AE]  FE CB                    dec     bl
F000:46B0  [+0x046B0]  32 FF                    xor     bh,bh
F000:46B2  [+0x046B2]  2E 8A 97 8A 46           mov     dl,[cs:bx+468Ah]
F000:46B7  [+0x046B7]  89 0E 85 04              mov     [485h],cx
F000:46BB  [+0x046BB]  88 16 84 04              mov     [484h],dl
F000:46BF  [+0x046BF]  C3                       ret
F000:46C0  [+0x046C0]  54                       push    sp
F000:46C1  [+0x046C1]  5E                       pop     si
F000:46C2  [+0x046C2]  54                       push    sp
F000:46C3  [+0x046C3]  56                       push    si
F000:46C4  [+0x046C4]  54                       push    sp
F000:46C5  [+0x046C5]  5A                       pop     dx
F000:46C6  [+0x046C6]  54                       push    sp
F000:46C7  [+0x046C7]  6C                       insb
F000:46C8  [+0x046C8]  64 6D                    insw
F000:46CA  [+0x046CA]  64 7D 2E                 jge     short 46FBh
F000:46CD  [+0x046CD]  8E 06 79 26              mov     es,[2679h]
F000:46D1  [+0x046D1]  0A FF                    or      bh,bh
F000:46D3  [+0x046D3]  75 07                    jne     short 46DCh
F000:46D5  [+0x046D5]  26 C4 1E 7C 00           les     bx,[es:7Ch]
F000:46DA  [+0x046DA]  EB 21                    jmp     short 46FDh
F000:46DC  [+0x046DC]  FE CF                    dec     bh
F000:46DE  [+0x046DE]  75 07                    jne     short 46E7h
F000:46E0  [+0x046E0]  26 C4 1E 0C 01           les     bx,[es:10Ch]
F000:46E5  [+0x046E5]  EB 16                    jmp     short 46FDh
F000:46E7  [+0x046E7]  FE CF                    dec     bh
F000:46E9  [+0x046E9]  80 FF 05                 cmp     bh,5
F000:46EC  [+0x046EC]  77 15                    ja      short 4703h
F000:46EE  [+0x046EE]  8C C8                    mov     ax,cs
F000:46F0  [+0x046F0]  8E C0                    mov     es,ax
F000:46F2  [+0x046F2]  8A DF                    mov     bl,bh
F000:46F4  [+0x046F4]  32 FF                    xor     bh,bh
F000:46F6  [+0x046F6]  03 DB                    add     bx,bx
F000:46F8  [+0x046F8]  2E 8B 9F C0 46           mov     bx,[cs:bx+46C0h]
F000:46FD  [+0x046FD]  89 5E 04                 mov     [bp+4],bx
F000:4700  [+0x04700]  8C 46 02                 mov     [bp+2],es
F000:4703  [+0x04703]  A1 85 04                 mov     ax,[485h]
F000:4706  [+0x04706]  89 46 0C                 mov     [bp+0Ch],ax
F000:4709  [+0x04709]  A0 84 04                 mov     al,[484h]
F000:470C  [+0x0470C]  88 46 0A                 mov     [bp+0Ah],al
F000:470F  [+0x0470F]  C3                       ret
F000:4710  [+0x04710]  8C C8                    mov     ax,cs
F000:4712  [+0x04712]  8E C0                    mov     es,ax
F000:4714  [+0x04714]  33 D2                    xor     dx,dx
F000:4716  [+0x04716]  B9 00 01                 mov     cx,100h
F000:4719  [+0x04719]  C3                       ret
F000:471A  [+0x0471A]  AC                       lodsb
F000:471B  [+0x0471B]  47                       inc     di
F000:471C  [+0x0471C]  5B                       pop     bx
F000:471D  [+0x0471D]  48                       dec     ax
F000:471E  [+0x0471E]  6F                       outsw
F000:471F  [+0x0471F]  48                       dec     ax
F000:4720  [+0x04720]  7E 48                    jle     short 476Ah
F000:4722  [+0x04722]  97                       xchg    di,ax
F000:4723  [+0x04723]  48                       dec     ax
F000:4724  [+0x04724]  B3 48                    mov     bl,48h
F000:4726  [+0x04726]  38 49 53                 cmp     [bx+di+53h],cl
F000:4729  [+0x04729]  E8 09 0F                 call    5635h
F000:472C  [+0x0472C]  8A CB                    mov     cl,bl
F000:472E  [+0x0472E]  5B                       pop     bx
F000:472F  [+0x0472F]  74 21                    je      short 4752h
F000:4731  [+0x04731]  80 EB 10                 sub     bl,10h
F000:4734  [+0x04734]  74 1D                    je      short 4753h
F000:4736  [+0x04736]  80 EB 10                 sub     bl,10h
F000:4739  [+0x04739]  74 44                    je      short 477Fh
F000:473B  [+0x0473B]  80 EB 10                 sub     bl,10h
F000:473E  [+0x0473E]  72 12                    jb      short 4752h
F000:4740  [+0x04740]  80 FB 06                 cmp     bl,6
F000:4743  [+0x04743]  77 0D                    ja      short 4752h
F000:4745  [+0x04745]  32 FF                    xor     bh,bh
F000:4747  [+0x04747]  D1 E3                    shl     bx,1
F000:4749  [+0x04749]  C6 46 10 12              mov     byte [bp+10h],12h
F000:474D  [+0x0474D]  2E FF A7 1A 47           jmp     word [cs:bx+471Ah]
F000:4752  [+0x04752]  C3                       ret
F000:4753  [+0x04753]  8A 2E 88 04              mov     ch,[488h]
F000:4757  [+0x04757]  B1 04                    mov     cl,4
F000:4759  [+0x04759]  8A C5                    mov     al,ch
F000:475B  [+0x0475B]  D2 ED                    shr     ch,cl
F000:475D  [+0x0475D]  8A C8                    mov     cl,al
F000:475F  [+0x0475F]  80 E1 0F                 and     cl,0Fh
F000:4762  [+0x04762]  89 4E 0C                 mov     [bp+0Ch],cx
F000:4765  [+0x04765]  A0 87 04                 mov     al,[487h]
F000:4768  [+0x04768]  D0 E8                    shr     al,1
F000:476A  [+0x0476A]  24 01                    and     al,1
F000:476C  [+0x0476C]  88 46 0F                 mov     [bp+0Fh],al
F000:476F  [+0x0476F]  A0 87 04                 mov     al,[487h]
F000:4772  [+0x04772]  24 7F                    and     al,7Fh
F000:4774  [+0x04774]  B1 05                    mov     cl,5
F000:4776  [+0x04776]  D2 E8                    shr     al,cl
F000:4778  [+0x04778]  88 46 0E                 mov     [bp+0Eh],al
F000:477B  [+0x0477B]  88 46 10                 mov     [bp+10h],al
F000:477E  [+0x0477E]  C3                       ret
F000:477F  [+0x0477F]  1E                       push    ds
F000:4780  [+0x04780]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:4785  [+0x04785]  9C                       pushf
F000:4786  [+0x04786]  FA                       cli
F000:4787  [+0x04787]  C7 06 14 00 58 49        mov     word [14h],4958h
F000:478D  [+0x0478D]  8C 0E 16 00              mov     [16h],cs
F000:4791  [+0x04791]  9D                       popf
F000:4792  [+0x04792]  1F                       pop     ds
F000:4793  [+0x04793]  C3                       ret
F000:4794  [+0x04794]  E2 47                    loop    47DDh
F000:4796  [+0x04796]  DD 47 D8                 fld     qword [bx-28h]
F000:4799  [+0x04799]  47                       inc     di
F000:479A  [+0x0479A]  F2 47                    inc     di
F000:479C  [+0x0479C]  0C 48                    or      al,48h
F000:479E  [+0x0479E]  07                       pop     es
F000:479F  [+0x0479F]  48                       dec     ax
F000:47A0  [+0x047A0]  21 48 1C                 and     [bx+si+1Ch],cx
F000:47A3  [+0x047A3]  48                       dec     ax
F000:47A4  [+0x047A4]  36 48                    dec     ax
F000:47A6  [+0x047A6]  31 48 4B                 xor     [bx+si+4Bh],cx
F000:47A9  [+0x047A9]  48                       dec     ax
F000:47AA  [+0x047AA]  46                       inc     si
F000:47AB  [+0x047AB]  48                       dec     ax
F000:47AC  [+0x047AC]  3C 02                    cmp     al,2
F000:47AE  [+0x047AE]  77 28                    ja      short 47D8h
F000:47B0  [+0x047B0]  F6 06 87 04 08           test    byte [487h],8
F000:47B5  [+0x047B5]  75 21                    jne     short 47D8h
F000:47B7  [+0x047B7]  8A D8                    mov     bl,al
F000:47B9  [+0x047B9]  32 FF                    xor     bh,bh
F000:47BB  [+0x047BB]  D1 E3                    shl     bx,1
F000:47BD  [+0x047BD]  D1 E3                    shl     bx,1
F000:47BF  [+0x047BF]  D1 E3                    shl     bx,1
F000:47C1  [+0x047C1]  8B F3                    mov     si,bx
F000:47C3  [+0x047C3]  8A 1E 87 04              mov     bl,[487h]
F000:47C7  [+0x047C7]  80 E3 02                 and     bl,2
F000:47CA  [+0x047CA]  A0 89 04                 mov     al,[489h]
F000:47CD  [+0x047CD]  24 01                    and     al,1
F000:47CF  [+0x047CF]  0A D8                    or      bl,al
F000:47D1  [+0x047D1]  D1 E3                    shl     bx,1
F000:47D3  [+0x047D3]  2E FF A0 94 47           jmp     word [cs:bx+si+4794h]
F000:47D8  [+0x047D8]  C6 46 10 00              mov     byte [bp+10h],0
F000:47DC  [+0x047DC]  C3                       ret
F000:47DD  [+0x047DD]  80 0E 89 04 80           or      byte [489h],80h
F000:47E2  [+0x047E2]  80 26 89 04 EF           and     byte [489h],0EFh
F000:47E7  [+0x047E7]  80 26 88 04 F0           and     byte [488h],0F0h
F000:47EC  [+0x047EC]  80 0E 88 04 08           or      byte [488h],8
F000:47F1  [+0x047F1]  C3                       ret
F000:47F2  [+0x047F2]  80 0E 89 04 80           or      byte [489h],80h
F000:47F7  [+0x047F7]  80 26 89 04 EF           and     byte [489h],0EFh
F000:47FC  [+0x047FC]  80 26 88 04 F0           and     byte [488h],0F0h
F000:4801  [+0x04801]  80 0E 88 04 0B           or      byte [488h],0Bh
F000:4806  [+0x04806]  C3                       ret
F000:4807  [+0x04807]  80 26 89 04 7F           and     byte [489h],7Fh
F000:480C  [+0x0480C]  80 26 89 04 EF           and     byte [489h],0EFh
F000:4811  [+0x04811]  80 26 88 04 F0           and     byte [488h],0F0h
F000:4816  [+0x04816]  80 0E 88 04 09           or      byte [488h],9
F000:481B  [+0x0481B]  C3                       ret
F000:481C  [+0x0481C]  80 26 89 04 7F           and     byte [489h],7Fh
F000:4821  [+0x04821]  80 26 89 04 EF           and     byte [489h],0EFh
F000:4826  [+0x04826]  80 26 88 04 F0           and     byte [488h],0F0h
F000:482B  [+0x0482B]  80 0E 88 04 0B           or      byte [488h],0Bh
F000:4830  [+0x04830]  C3                       ret
F000:4831  [+0x04831]  80 26 89 04 7F           and     byte [489h],7Fh
F000:4836  [+0x04836]  80 0E 89 04 10           or      byte [489h],10h
F000:483B  [+0x0483B]  80 26 88 04 F0           and     byte [488h],0F0h
F000:4840  [+0x04840]  80 0E 88 04 09           or      byte [488h],9
F000:4845  [+0x04845]  C3                       ret
F000:4846  [+0x04846]  80 26 89 04 7F           and     byte [489h],7Fh
F000:484B  [+0x0484B]  80 0E 89 04 10           or      byte [489h],10h
F000:4850  [+0x04850]  80 26 88 04 F0           and     byte [488h],0F0h
F000:4855  [+0x04855]  80 0E 88 04 0B           or      byte [488h],0Bh
F000:485A  [+0x0485A]  C3                       ret
F000:485B  [+0x0485B]  3C 01                    cmp     al,1
F000:485D  [+0x0485D]  77 33                    ja      short 4892h
F000:485F  [+0x0485F]  B0 00                    mov     al,0
F000:4861  [+0x04861]  75 02                    jne     short 4865h
F000:4863  [+0x04863]  B0 08                    mov     al,8
F000:4865  [+0x04865]  80 26 89 04 F7           and     byte [489h],0F7h
F000:486A  [+0x0486A]  08 06 89 04              or      [489h],al
F000:486E  [+0x0486E]  C3                       ret
F000:486F  [+0x0486F]  3C 01                    cmp     al,1
F000:4871  [+0x04871]  77 1F                    ja      short 4892h
F000:4873  [+0x04873]  B0 00                    mov     al,0
F000:4875  [+0x04875]  74 02                    je      short 4879h
F000:4877  [+0x04877]  B0 0E                    mov     al,0Eh
F000:4879  [+0x04879]  BA E8 46                 mov     dx,46E8h
F000:487C  [+0x0487C]  EE                       out     dx,al
F000:487D  [+0x0487D]  C3                       ret
F000:487E  [+0x0487E]  3C 01                    cmp     al,1
F000:4880  [+0x04880]  77 10                    ja      short 4892h
F000:4882  [+0x04882]  B0 00                    mov     al,0
F000:4884  [+0x04884]  74 02                    je      short 4888h
F000:4886  [+0x04886]  B0 02                    mov     al,2
F000:4888  [+0x04888]  80 26 89 04 FD           and     byte [489h],0FDh
F000:488D  [+0x0488D]  08 06 89 04              or      [489h],al
F000:4891  [+0x04891]  C3                       ret
F000:4892  [+0x04892]  C6 46 10 00              mov     byte [bp+10h],0
F000:4896  [+0x04896]  C3                       ret
F000:4897  [+0x04897]  3C 01                    cmp     al,1
F000:4899  [+0x04899]  77 F7                    ja      short 4892h
F000:489B  [+0x0489B]  B0 00                    mov     al,0
F000:489D  [+0x0489D]  75 02                    jne     short 48A1h
F000:489F  [+0x0489F]  B0 01                    mov     al,1
F000:48A1  [+0x048A1]  80 26 87 04 FE           and     byte [487h],0FEh
F000:48A6  [+0x048A6]  08 06 87 04              or      [487h],al
F000:48AA  [+0x048AA]  C3                       ret
F000:48AB  [+0x048AB]  CE                       into
F000:48AC  [+0x048AC]  48                       dec     ax
F000:48AD  [+0x048AD]  CD 48                    int     48h
F000:48AF  [+0x048AF]  DB 0xC6  (bad)
F000:48B1  [+0x048B1]  0A 49 C6                 or      cl,[bx+di-3Ah]
F000:48B4  [+0x048B4]  46                       inc     si
F000:48B5  [+0x048B5]  10 00                    adc     [bx+si],al
F000:48B7  [+0x048B7]  3C 03                    cmp     al,3
F000:48B9  [+0x048B9]  77 12                    ja      short 48CDh
F000:48BB  [+0x048BB]  8A D8                    mov     bl,al
F000:48BD  [+0x048BD]  32 FF                    xor     bh,bh
F000:48BF  [+0x048BF]  D1 E3                    shl     bx,1
F000:48C1  [+0x048C1]  2E FF A7 AB 48           jmp     word [cs:bx+48ABh]
F000:48C6  [+0x048C6]  F6 06 89 04 40           test    byte [489h],40h
F000:48CB  [+0x048CB]  74 16                    je      short 48E3h
F000:48CD  [+0x048CD]  C3                       ret
F000:48CE  [+0x048CE]  F6 06 89 04 40           test    byte [489h],40h
F000:48D3  [+0x048D3]  75 F8                    jne     short 48CDh
F000:48D5  [+0x048D5]  B8 80 12                 mov     ax,1280h
F000:48D8  [+0x048D8]  B3 35                    mov     bl,35h
F000:48DA  [+0x048DA]  CD 42                    int     42h
F000:48DC  [+0x048DC]  F6 06 89 04 40           test    byte [489h],40h
F000:48E1  [+0x048E1]  74 EA                    je      short 48CDh
F000:48E3  [+0x048E3]  8B FA                    mov     di,dx
F000:48E5  [+0x048E5]  E8 E2 05                 call    4ECAh
F000:48E8  [+0x048E8]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:48ED  [+0x048ED]  BF B4 01                 mov     di,1B4h
F000:48F0  [+0x048F0]  BE 08 01                 mov     si,108h
F000:48F3  [+0x048F3]  A5                       movsw
F000:48F4  [+0x048F4]  A5                       movsw
F000:48F5  [+0x048F5]  BF 08 01                 mov     di,108h
F000:48F8  [+0x048F8]  B8 44 2C                 mov     ax,2C44h
F000:48FB  [+0x048FB]  AB                       stosw
F000:48FC  [+0x048FC]  8C C8                    mov     ax,cs
F000:48FE  [+0x048FE]  AB                       stosw
F000:48FF  [+0x048FF]  BA E8 46                 mov     dx,46E8h
F000:4902  [+0x04902]  B0 06                    mov     al,6
F000:4904  [+0x04904]  EE                       out     dx,al
F000:4905  [+0x04905]  C6 46 10 12              mov     byte [bp+10h],12h
F000:4909  [+0x04909]  C3                       ret
F000:490A  [+0x0490A]  F6 06 89 04 40           test    byte [489h],40h
F000:490F  [+0x0490F]  74 BC                    je      short 48CDh
F000:4911  [+0x04911]  8B FA                    mov     di,dx
F000:4913  [+0x04913]  E8 0F 07                 call    5025h
F000:4916  [+0x04916]  2E 8E 06 79 26           mov     es,[cs:2679h]
F000:491B  [+0x0491B]  BF 08 01                 mov     di,108h
F000:491E  [+0x0491E]  BE B4 01                 mov     si,1B4h
F000:4921  [+0x04921]  A5                       movsw
F000:4922  [+0x04922]  A5                       movsw
F000:4923  [+0x04923]  BF B4 01                 mov     di,1B4h
F000:4926  [+0x04926]  B8 44 2C                 mov     ax,2C44h
F000:4929  [+0x04929]  AB                       stosw
F000:492A  [+0x0492A]  8C C8                    mov     ax,cs
F000:492C  [+0x0492C]  AB                       stosw
F000:492D  [+0x0492D]  BA E8 46                 mov     dx,46E8h
F000:4930  [+0x04930]  B0 0E                    mov     al,0Eh
F000:4932  [+0x04932]  EE                       out     dx,al
F000:4933  [+0x04933]  C6 46 10 12              mov     byte [bp+10h],12h
F000:4937  [+0x04937]  C3                       ret
F000:4938  [+0x04938]  3C 01                    cmp     al,1
F000:493A  [+0x0493A]  77 17                    ja      short 4953h
F000:493C  [+0x0493C]  B1 05                    mov     cl,5
F000:493E  [+0x0493E]  D2 E0                    shl     al,cl
F000:4940  [+0x04940]  8A D8                    mov     bl,al
F000:4942  [+0x04942]  BA C4 03                 mov     dx,3C4h
F000:4945  [+0x04945]  B0 01                    mov     al,1
F000:4947  [+0x04947]  E8 40 07                 call    508Ah
F000:494A  [+0x0494A]  80 E4 DF                 and     ah,0DFh
F000:494D  [+0x0494D]  0A E3                    or      ah,bl
F000:494F  [+0x0494F]  B0 01                    mov     al,1
F000:4951  [+0x04951]  EF                       out     dx,ax
F000:4952  [+0x04952]  C3                       ret
F000:4953  [+0x04953]  C6 46 10 00              mov     byte [bp+10h],0
F000:4957  [+0x04957]  C3                       ret
F000:4958  [+0x04958]  1E                       push    ds
F000:4959  [+0x04959]  55                       push    bp
F000:495A  [+0x0495A]  52                       push    dx
F000:495B  [+0x0495B]  51                       push    cx
F000:495C  [+0x0495C]  53                       push    bx
F000:495D  [+0x0495D]  50                       push    ax
F000:495E  [+0x0495E]  2E 8E 1E 77 26           mov     ds,[cs:2677h]
F000:4963  [+0x04963]  B0 01                    mov     al,1
F000:4965  [+0x04965]  38 06 00 05              cmp     [500h],al
F000:4969  [+0x04969]  74 67                    je      short 49D2h
F000:496B  [+0x0496B]  A2 00 05                 mov     [500h],al
F000:496E  [+0x0496E]  33 D2                    xor     dx,dx
F000:4970  [+0x04970]  B4 02                    mov     ah,2
F000:4972  [+0x04972]  CD 17                    int     17h
F000:4974  [+0x04974]  B1 FF                    mov     cl,0FFh
F000:4976  [+0x04976]  F6 C4 80                 test    ah,80h
F000:4979  [+0x04979]  74 53                    je      short 49CEh
F000:497B  [+0x0497B]  F6 C4 20                 test    ah,20h
F000:497E  [+0x0497E]  75 4E                    jne     short 49CEh
F000:4980  [+0x04980]  B4 0F                    mov     ah,0Fh
F000:4982  [+0x04982]  CD 10                    int     10h
F000:4984  [+0x04984]  8A CC                    mov     cl,ah
F000:4986  [+0x04986]  8A 2E 84 04              mov     ch,[484h]
F000:498A  [+0x0498A]  FE C5                    inc     ch
F000:498C  [+0x0498C]  B4 03                    mov     ah,3
F000:498E  [+0x0498E]  51                       push    cx
F000:498F  [+0x0498F]  CD 10                    int     10h
F000:4991  [+0x04991]  59                       pop     cx
F000:4992  [+0x04992]  52                       push    dx
F000:4993  [+0x04993]  8B EC                    mov     bp,sp
F000:4995  [+0x04995]  B6 FF                    mov     dh,0FFh
F000:4997  [+0x04997]  EB 19                    jmp     short 49B2h
F000:4999  [+0x04999]  B8 00 02                 mov     ax,200h
F000:499C  [+0x0499C]  CD 10                    int     10h
F000:499E  [+0x0499E]  B8 00 08                 mov     ax,800h
F000:49A1  [+0x049A1]  CD 10                    int     10h
F000:49A3  [+0x049A3]  0A C0                    or      al,al
F000:49A5  [+0x049A5]  75 02                    jne     short 49A9h
F000:49A7  [+0x049A7]  B0 20                    mov     al,20h
F000:49A9  [+0x049A9]  E8 2D 00                 call    49D9h
F000:49AC  [+0x049AC]  FE C2                    inc     dl
F000:49AE  [+0x049AE]  3A D1                    cmp     dl,cl
F000:49B0  [+0x049B0]  75 E7                    jne     short 4999h
F000:49B2  [+0x049B2]  B0 0A                    mov     al,0Ah
F000:49B4  [+0x049B4]  E8 22 00                 call    49D9h
F000:49B7  [+0x049B7]  B0 0D                    mov     al,0Dh
F000:49B9  [+0x049B9]  E8 1D 00                 call    49D9h
F000:49BC  [+0x049BC]  32 D2                    xor     dl,dl
F000:49BE  [+0x049BE]  FE C6                    inc     dh
F000:49C0  [+0x049C0]  3A F5                    cmp     dh,ch
F000:49C2  [+0x049C2]  75 D5                    jne     short 4999h
F000:49C4  [+0x049C4]  32 C9                    xor     cl,cl
F000:49C6  [+0x049C6]  8B E5                    mov     sp,bp
F000:49C8  [+0x049C8]  5A                       pop     dx
F000:49C9  [+0x049C9]  B8 00 02                 mov     ax,200h
F000:49CC  [+0x049CC]  CD 10                    int     10h
F000:49CE  [+0x049CE]  88 0E 00 05              mov     [500h],cl
F000:49D2  [+0x049D2]  58                       pop     ax
F000:49D3  [+0x049D3]  5B                       pop     bx
F000:49D4  [+0x049D4]  59                       pop     cx
F000:49D5  [+0x049D5]  5A                       pop     dx
F000:49D6  [+0x049D6]  5D                       pop     bp
F000:49D7  [+0x049D7]  1F                       pop     ds
F000:49D8  [+0x049D8]  CF                       iret
F000:49D9  [+0x049D9]  52                       push    dx
F000:49DA  [+0x049DA]  32 E4                    xor     ah,ah
F000:49DC  [+0x049DC]  33 D2                    xor     dx,dx
F000:49DE  [+0x049DE]  CD 17                    int     17h
F000:49E0  [+0x049E0]  F6 C4 25                 test    ah,25h
F000:49E3  [+0x049E3]  5A                       pop     dx
F000:49E4  [+0x049E4]  74 04                    je      short 49EAh
F000:49E6  [+0x049E6]  B1 FF                    mov     cl,0FFh
F000:49E8  [+0x049E8]  EB DC                    jmp     short 49C6h
F000:49EA  [+0x049EA]  C3                       ret
F000:49EB  [+0x049EB]  87 DB                    xchg    bx,bx
F000:49ED  [+0x049ED]  90                       nop
F000:49EE  [+0x049EE]  53                       push    bx
F000:49EF  [+0x049EF]  51                       push    cx
F000:49F0  [+0x049F0]  E8 42 0C                 call    5635h
F000:49F3  [+0x049F3]  59                       pop     cx
F000:49F4  [+0x049F4]  5B                       pop     bx
F000:49F5  [+0x049F5]  74 75                    je      short 4A6Ch
F000:49F7  [+0x049F7]  E3 73                    jcxz    4A6Ch
F000:49F9  [+0x049F9]  3C 03                    cmp     al,3
F000:49FB  [+0x049FB]  77 6F                    ja      short 4A6Ch
F000:49FD  [+0x049FD]  8A E7                    mov     ah,bh
F000:49FF  [+0x049FF]  8A 3E 62 04              mov     bh,[462h]
F000:4A03  [+0x04A03]  53                       push    bx
F000:4A04  [+0x04A04]  A8 01                    test    al,1
F000:4A06  [+0x04A06]  75 0B                    jne     short 4A13h
F000:4A08  [+0x04A08]  8A DC                    mov     bl,ah
F000:4A0A  [+0x04A0A]  32 FF                    xor     bh,bh
F000:4A0C  [+0x04A0C]  D1 E3                    shl     bx,1
F000:4A0E  [+0x04A0E]  8B 97 50 04              mov     dx,[bx+450h]
F000:4A12  [+0x04A12]  52                       push    dx
F000:4A13  [+0x04A13]  8B 76 04                 mov     si,[bp+4]
F000:4A16  [+0x04A16]  8B 4E 0C                 mov     cx,[bp+0Ch]
F000:4A19  [+0x04A19]  8B 56 0A                 mov     dx,[bp+0Ah]
F000:4A1C  [+0x04A1C]  51                       push    cx
F000:4A1D  [+0x04A1D]  8A 7E 0F                 mov     bh,[bp+0Fh]
F000:4A20  [+0x04A20]  8B CA                    mov     cx,dx
F000:4A22  [+0x04A22]  E8 73 E9                 call    3398h
F000:4A25  [+0x04A25]  8B D1                    mov     dx,cx
F000:4A27  [+0x04A27]  8E 46 02                 mov     es,[bp+2]
F000:4A2A  [+0x04A2A]  26 AC                    es lodsb
F000:4A2C  [+0x04A2C]  3C 0D                    cmp     al,0Dh
F000:4A2E  [+0x04A2E]  76 3D                    jbe     short 4A6Dh
F000:4A30  [+0x04A30]  8B 5E 0E                 mov     bx,[bp+0Eh]
F000:4A33  [+0x04A33]  F6 46 10 02              test    byte [bp+10h],2
F000:4A37  [+0x04A37]  74 04                    je      short 4A3Dh
F000:4A39  [+0x04A39]  26 8A 1C                 mov     bl,[es:si]
F000:4A3C  [+0x04A3C]  46                       inc     si
F000:4A3D  [+0x04A3D]  56                       push    si
F000:4A3E  [+0x04A3E]  52                       push    dx
F000:4A3F  [+0x04A3F]  55                       push    bp
F000:4A40  [+0x04A40]  B9 01 00                 mov     cx,1
F000:4A43  [+0x04A43]  E8 7C F1                 call    3BC2h
F000:4A46  [+0x04A46]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:4A4B  [+0x04A4B]  5D                       pop     bp
F000:4A4C  [+0x04A4C]  5A                       pop     dx
F000:4A4D  [+0x04A4D]  FE C2                    inc     dl
F000:4A4F  [+0x04A4F]  3A 16 4A 04              cmp     dl,[44Ah]
F000:4A53  [+0x04A53]  72 3B                    jb      short 4A90h
F000:4A55  [+0x04A55]  FE C6                    inc     dh
F000:4A57  [+0x04A57]  32 D2                    xor     dl,dl
F000:4A59  [+0x04A59]  3A 36 84 04              cmp     dh,[484h]
F000:4A5D  [+0x04A5D]  76 31                    jbe     short 4A90h
F000:4A5F  [+0x04A5F]  52                       push    dx
F000:4A60  [+0x04A60]  B0 0A                    mov     al,0Ah
F000:4A62  [+0x04A62]  9C                       pushf
F000:4A63  [+0x04A63]  0E                       push    cs
F000:4A64  [+0x04A64]  E8 1D F7                 call    4184h
F000:4A67  [+0x04A67]  5A                       pop     dx
F000:4A68  [+0x04A68]  FE CE                    dec     dh
F000:4A6A  [+0x04A6A]  EB 24                    jmp     short 4A90h
F000:4A6C  [+0x04A6C]  C3                       ret
F000:4A6D  [+0x04A6D]  3C 07                    cmp     al,7
F000:4A6F  [+0x04A6F]  74 0E                    je      short 4A7Fh
F000:4A71  [+0x04A71]  3C 08                    cmp     al,8
F000:4A73  [+0x04A73]  74 0A                    je      short 4A7Fh
F000:4A75  [+0x04A75]  3C 0A                    cmp     al,0Ah
F000:4A77  [+0x04A77]  74 06                    je      short 4A7Fh
F000:4A79  [+0x04A79]  3C 0D                    cmp     al,0Dh
F000:4A7B  [+0x04A7B]  74 02                    je      short 4A7Fh
F000:4A7D  [+0x04A7D]  EB B1                    jmp     short 4A30h
F000:4A7F  [+0x04A7F]  56                       push    si
F000:4A80  [+0x04A80]  9C                       pushf
F000:4A81  [+0x04A81]  0E                       push    cs
F000:4A82  [+0x04A82]  E8 FF F6                 call    4184h
F000:4A85  [+0x04A85]  8A 5E 0F                 mov     bl,[bp+0Fh]
F000:4A88  [+0x04A88]  32 FF                    xor     bh,bh
F000:4A8A  [+0x04A8A]  D1 E3                    shl     bx,1
F000:4A8C  [+0x04A8C]  8B 97 50 04              mov     dx,[bx+450h]
F000:4A90  [+0x04A90]  5E                       pop     si
F000:4A91  [+0x04A91]  59                       pop     cx
F000:4A92  [+0x04A92]  E2 88                    loop    4A1Ch
F000:4A94  [+0x04A94]  F6 46 10 01              test    byte [bp+10h],1
F000:4A98  [+0x04A98]  75 01                    jne     short 4A9Bh
F000:4A9A  [+0x04A9A]  5A                       pop     dx
F000:4A9B  [+0x04A9B]  8A 7E 0F                 mov     bh,[bp+0Fh]
F000:4A9E  [+0x04A9E]  E8 F7 E8                 call    3398h
F000:4AA1  [+0x04AA1]  5B                       pop     bx
F000:4AA2  [+0x04AA2]  86 3E 62 04              xchg    bh,[462h]
F000:4AA6  [+0x04AA6]  C3                       ret
F000:4AA7  [+0x04AA7]  0A C0                    or      al,al
F000:4AA9  [+0x04AA9]  75 28                    jne     short 4AD3h
F000:4AAB  [+0x04AAB]  E8 6B 00                 call    4B19h
F000:4AAE  [+0x04AAE]  74 1B                    je      short 4ACBh
F000:4AB0  [+0x04AB0]  0A C9                    or      cl,cl
F000:4AB2  [+0x04AB2]  74 15                    je      short 4AC9h
F000:4AB4  [+0x04AB4]  A0 10 04                 mov     al,[410h]
F000:4AB7  [+0x04AB7]  24 30                    and     al,30h
F000:4AB9  [+0x04AB9]  3C 30                    cmp     al,30h
F000:4ABB  [+0x04ABB]  74 07                    je      short 4AC4h
F000:4ABD  [+0x04ABD]  F6 C1 01                 test    cl,1
F000:4AC0  [+0x04AC0]  75 07                    jne     short 4AC9h
F000:4AC2  [+0x04AC2]  EB 07                    jmp     short 4ACBh
F000:4AC4  [+0x04AC4]  F6 C1 01                 test    cl,1
F000:4AC7  [+0x04AC7]  75 02                    jne     short 4ACBh
F000:4AC9  [+0x04AC9]  86 CD                    xchg    cl,ch
F000:4ACB  [+0x04ACB]  89 4E 0E                 mov     [bp+0Eh],cx
F000:4ACE  [+0x04ACE]  C6 46 10 1A              mov     byte [bp+10h],1Ah
F000:4AD2  [+0x04AD2]  C3                       ret
F000:4AD3  [+0x04AD3]  FE C8                    dec     al
F000:4AD5  [+0x04AD5]  75 41                    jne     short 4B18h
F000:4AD7  [+0x04AD7]  B2 FF                    mov     dl,0FFh
F000:4AD9  [+0x04AD9]  BB 10 00                 mov     bx,10h
F000:4ADC  [+0x04ADC]  E8 FB E7                 call    32DAh
F000:4ADF  [+0x04ADF]  74 2F                    je      short 4B10h
F000:4AE1  [+0x04AE1]  26 C4 5F 02              les     bx,[es:bx+2]
F000:4AE5  [+0x04AE5]  8C C0                    mov     ax,es
F000:4AE7  [+0x04AE7]  0B C3                    or      ax,bx
F000:4AE9  [+0x04AE9]  74 25                    je      short 4B10h
F000:4AEB  [+0x04AEB]  26 8A 0F                 mov     cl,[es:bx]
F000:4AEE  [+0x04AEE]  32 ED                    xor     ch,ch
F000:4AF0  [+0x04AF0]  E3 1E                    jcxz    4B10h
F000:4AF2  [+0x04AF2]  8B FB                    mov     di,bx
F000:4AF4  [+0x04AF4]  83 C7 04                 add     di,4
F000:4AF7  [+0x04AF7]  8B 46 0E                 mov     ax,[bp+0Eh]
F000:4AFA  [+0x04AFA]  F2 AF                    repne scasw
F000:4AFC  [+0x04AFC]  74 0E                    je      short 4B0Ch
F000:4AFE  [+0x04AFE]  26 8A 0F                 mov     cl,[es:bx]
F000:4B01  [+0x04B01]  8B FB                    mov     di,bx
F000:4B03  [+0x04B03]  83 C7 04                 add     di,4
F000:4B06  [+0x04B06]  86 C4                    xchg    al,ah
F000:4B08  [+0x04B08]  F2 AF                    repne scasw
F000:4B0A  [+0x04B0A]  75 04                    jne     short 4B10h
F000:4B0C  [+0x04B0C]  B2 0F                    mov     dl,0Fh
F000:4B0E  [+0x04B0E]  2A D1                    sub     dl,cl
F000:4B10  [+0x04B10]  88 16 8A 04              mov     [48Ah],dl
F000:4B14  [+0x04B14]  C6 46 10 1A              mov     byte [bp+10h],1Ah
F000:4B18  [+0x04B18]  C3                       ret
F000:4B19  [+0x04B19]  06                       push    es
F000:4B1A  [+0x04B1A]  B9 FF FF                 mov     cx,0FFFFh
F000:4B1D  [+0x04B1D]  BB 10 00                 mov     bx,10h
F000:4B20  [+0x04B20]  E8 B7 E7                 call    32DAh
F000:4B23  [+0x04B23]  74 1E                    je      short 4B43h
F000:4B25  [+0x04B25]  26 C4 5F 02              les     bx,[es:bx+2]
F000:4B29  [+0x04B29]  8C C0                    mov     ax,es
F000:4B2B  [+0x04B2B]  0B C3                    or      ax,bx
F000:4B2D  [+0x04B2D]  74 14                    je      short 4B43h
F000:4B2F  [+0x04B2F]  A0 8A 04                 mov     al,[48Ah]
F000:4B32  [+0x04B32]  26 3A 07                 cmp     al,[es:bx]
F000:4B35  [+0x04B35]  73 0C                    jae     short 4B43h
F000:4B37  [+0x04B37]  32 E4                    xor     ah,ah
F000:4B39  [+0x04B39]  D1 E0                    shl     ax,1
F000:4B3B  [+0x04B3B]  05 04 00                 add     ax,4
F000:4B3E  [+0x04B3E]  8B F0                    mov     si,ax
F000:4B40  [+0x04B40]  26 8B 08                 mov     cx,[es:bx+si]
F000:4B43  [+0x04B43]  83 F9 FF                 cmp     cx,0FFFFh
F000:4B46  [+0x04B46]  07                       pop     es
F000:4B47  [+0x04B47]  C3                       ret
F000:4B48  [+0x04B48]  10 00                    adc     [bx+si],al
F000:4B4A  [+0x04B4A]  10 00                    adc     [bx+si],al
F000:4B4C  [+0x04B4C]  10 00                    adc     [bx+si],al
F000:4B4E  [+0x04B4E]  10 00                    adc     [bx+si],al
F000:4B50  [+0x04B50]  04 00                    add     al,0
F000:4B52  [+0x04B52]  04 00                    add     al,0
F000:4B54  [+0x04B54]  02 00                    add     al,[bx+si]
F000:4B56  [+0x04B56]  00 00                    add     [bx+si],al
F000:4B58  [+0x04B58]  00 00                    add     [bx+si],al
F000:4B5A  [+0x04B5A]  00 00                    add     [bx+si],al
F000:4B5C  [+0x04B5C]  00 00                    add     [bx+si],al
F000:4B5E  [+0x04B5E]  00 00                    add     [bx+si],al
F000:4B60  [+0x04B60]  00 00                    add     [bx+si],al
F000:4B62  [+0x04B62]  10 00                    adc     [bx+si],al
F000:4B64  [+0x04B64]  10 00                    adc     [bx+si],al
F000:4B66  [+0x04B66]  00 00                    add     [bx+si],al
F000:4B68  [+0x04B68]  10 00                    adc     [bx+si],al
F000:4B6A  [+0x04B6A]  02 00                    add     al,[bx+si]
F000:4B6C  [+0x04B6C]  10 00                    adc     [bx+si],al
F000:4B6E  [+0x04B6E]  00 01                    add     [bx+di],al
F000:4B70  [+0x04B70]  08 08                    or      [bx+si],cl
F000:4B72  [+0x04B72]  08 08                    or      [bx+si],cl
F000:4B74  [+0x04B74]  01 01                    add     [bx+di],ax
F000:4B76  [+0x04B76]  01 08                    add     [bx+si],cx
F000:4B78  [+0x04B78]  00 00                    add     [bx+si],al
F000:4B7A  [+0x04B7A]  00 00                    add     [bx+si],al
F000:4B7C  [+0x04B7C]  00 08                    add     [bx+si],cl
F000:4B7E  [+0x04B7E]  04 02                    add     al,2
F000:4B80  [+0x04B80]  02 01                    add     al,[bx+di]
F000:4B82  [+0x04B82]  01 01                    add     [bx+di],ax
F000:4B84  [+0x04B84]  53                       push    bx
F000:4B85  [+0x04B85]  57                       push    di
F000:4B86  [+0x04B86]  E8 AC 0A                 call    5635h
F000:4B89  [+0x04B89]  8A C3                    mov     al,bl
F000:4B8B  [+0x04B8B]  5F                       pop     di
F000:4B8C  [+0x04B8C]  5B                       pop     bx
F000:4B8D  [+0x04B8D]  0B DB                    or      bx,bx
F000:4B8F  [+0x04B8F]  74 05                    je      short 4B96h
F000:4B91  [+0x04B91]  C6 46 10 00              mov     byte [bp+10h],0
F000:4B95  [+0x04B95]  C3                       ret
F000:4B96  [+0x04B96]  C6 46 10 1B              mov     byte [bp+10h],1Bh
F000:4B9A  [+0x04B9A]  B8 AA 7E                 mov     ax,7EAAh
F000:4B9D  [+0x04B9D]  AB                       stosw
F000:4B9E  [+0x04B9E]  8C C8                    mov     ax,cs
F000:4BA0  [+0x04BA0]  AB                       stosw
F000:4BA1  [+0x04BA1]  B9 0F 00                 mov     cx,0Fh
F000:4BA4  [+0x04BA4]  BE 49 04                 mov     si,449h
F000:4BA7  [+0x04BA7]  F3 A5                    rep movsw
F000:4BA9  [+0x04BA9]  A0 84 04                 mov     al,[484h]
F000:4BAC  [+0x04BAC]  FE C0                    inc     al
F000:4BAE  [+0x04BAE]  AA                       stosb
F000:4BAF  [+0x04BAF]  A1 85 04                 mov     ax,[485h]
F000:4BB2  [+0x04BB2]  AB                       stosw
F000:4BB3  [+0x04BB3]  E8 63 FF                 call    4B19h
F000:4BB6  [+0x04BB6]  8B C1                    mov     ax,cx
F000:4BB8  [+0x04BB8]  0A C0                    or      al,al
F000:4BBA  [+0x04BBA]  75 02                    jne     short 4BBEh
F000:4BBC  [+0x04BBC]  86 C4                    xchg    al,ah
F000:4BBE  [+0x04BBE]  AB                       stosw
F000:4BBF  [+0x04BBF]  A0 49 04                 mov     al,[449h]
F000:4BC2  [+0x04BC2]  3C 13                    cmp     al,13h
F000:4BC4  [+0x04BC4]  76 03                    jbe     short 4BC9h
F000:4BC6  [+0x04BC6]  E9 5D CC                 jmp     1826h
F000:4BC9  [+0x04BC9]  32 E4                    xor     ah,ah
F000:4BCB  [+0x04BCB]  D1 E0                    shl     ax,1
F000:4BCD  [+0x04BCD]  8B D8                    mov     bx,ax
F000:4BCF  [+0x04BCF]  2E 8B 87 48 4B           mov     ax,[cs:bx+4B48h]
F000:4BD4  [+0x04BD4]  D1 EB                    shr     bx,1
F000:4BD6  [+0x04BD6]  AB                       stosw
F000:4BD7  [+0x04BD7]  2E 8A 87 70 4B           mov     al,[cs:bx+4B70h]
F000:4BDC  [+0x04BDC]  AA                       stosb
F000:4BDD  [+0x04BDD]  B3 03                    mov     bl,3
F000:4BDF  [+0x04BDF]  A0 49 04                 mov     al,[449h]
F000:4BE2  [+0x04BE2]  3C 11                    cmp     al,11h
F000:4BE4  [+0x04BE4]  74 49                    je      short 4C2Fh
F000:4BE6  [+0x04BE6]  3C 12                    cmp     al,12h
F000:4BE8  [+0x04BE8]  74 45                    je      short 4C2Fh
F000:4BEA  [+0x04BEA]  32 DB                    xor     bl,bl
F000:4BEC  [+0x04BEC]  3C 13                    cmp     al,13h
F000:4BEE  [+0x04BEE]  74 3F                    je      short 4C2Fh
F000:4BF0  [+0x04BF0]  3C 04                    cmp     al,4
F000:4BF2  [+0x04BF2]  72 12                    jb      short 4C06h
F000:4BF4  [+0x04BF4]  3C 06                    cmp     al,6
F000:4BF6  [+0x04BF6]  76 37                    jbe     short 4C2Fh
F000:4BF8  [+0x04BF8]  3C 09                    cmp     al,9
F000:4BFA  [+0x04BFA]  72 0A                    jb      short 4C06h
F000:4BFC  [+0x04BFC]  3C 0E                    cmp     al,0Eh
F000:4BFE  [+0x04BFE]  76 2F                    jbe     short 4C2Fh
F000:4C00  [+0x04C00]  B3 01                    mov     bl,1
F000:4C02  [+0x04C02]  3C 10                    cmp     al,10h
F000:4C04  [+0x04C04]  76 29                    jbe     short 4C2Fh
F000:4C06  [+0x04C06]  B3 02                    mov     bl,2
F000:4C08  [+0x04C08]  F6 06 89 04 10           test    byte [489h],10h
F000:4C0D  [+0x04C0D]  75 20                    jne     short 4C2Fh
F000:4C0F  [+0x04C0F]  B3 01                    mov     bl,1
F000:4C11  [+0x04C11]  F6 06 87 04 02           test    byte [487h],2
F000:4C16  [+0x04C16]  75 17                    jne     short 4C2Fh
F000:4C18  [+0x04C18]  8A 26 88 04              mov     ah,[488h]
F000:4C1C  [+0x04C1C]  80 E4 0F                 and     ah,0Fh
F000:4C1F  [+0x04C1F]  80 FC 03                 cmp     ah,3
F000:4C22  [+0x04C22]  74 0B                    je      short 4C2Fh
F000:4C24  [+0x04C24]  80 FC 09                 cmp     ah,9
F000:4C27  [+0x04C27]  74 06                    je      short 4C2Fh
F000:4C29  [+0x04C29]  3C 07                    cmp     al,7
F000:4C2B  [+0x04C2B]  74 02                    je      short 4C2Fh
F000:4C2D  [+0x04C2D]  32 DB                    xor     bl,bl
F000:4C2F  [+0x04C2F]  8A C3                    mov     al,bl
F000:4C31  [+0x04C31]  AA                       stosb
F000:4C32  [+0x04C32]  BA C4 03                 mov     dx,3C4h
F000:4C35  [+0x04C35]  53                       push    bx
F000:4C36  [+0x04C36]  EC                       in      al,dx
F000:4C37  [+0x04C37]  50                       push    ax
F000:4C38  [+0x04C38]  B0 03                    mov     al,3
F000:4C3A  [+0x04C3A]  E8 4D 04                 call    508Ah
F000:4C3D  [+0x04C3D]  8B D8                    mov     bx,ax
F000:4C3F  [+0x04C3F]  58                       pop     ax
F000:4C40  [+0x04C40]  EE                       out     dx,al
F000:4C41  [+0x04C41]  8B C3                    mov     ax,bx
F000:4C43  [+0x04C43]  5B                       pop     bx
F000:4C44  [+0x04C44]  8A C4                    mov     al,ah
F000:4C46  [+0x04C46]  24 03                    and     al,3
F000:4C48  [+0x04C48]  F6 C4 10                 test    ah,10h
F000:4C4B  [+0x04C4B]  74 02                    je      short 4C4Fh
F000:4C4D  [+0x04C4D]  0C 04                    or      al,4
F000:4C4F  [+0x04C4F]  AA                       stosb
F000:4C50  [+0x04C50]  8A C4                    mov     al,ah
F000:4C52  [+0x04C52]  24 0C                    and     al,0Ch
F000:4C54  [+0x04C54]  D0 E8                    shr     al,1
F000:4C56  [+0x04C56]  D0 E8                    shr     al,1
F000:4C58  [+0x04C58]  F6 C4 20                 test    ah,20h
F000:4C5B  [+0x04C5B]  74 02                    je      short 4C5Fh
F000:4C5D  [+0x04C5D]  0C 04                    or      al,4
F000:4C5F  [+0x04C5F]  AA                       stosb
F000:4C60  [+0x04C60]  B3 10                    mov     bl,10h
F000:4C62  [+0x04C62]  E8 B7 F7                 call    441Ch
F000:4C65  [+0x04C65]  8A C7                    mov     al,bh
F000:4C67  [+0x04C67]  24 08                    and     al,8
F000:4C69  [+0x04C69]  B1 02                    mov     cl,2
F000:4C6B  [+0x04C6B]  D2 E0                    shl     al,cl
F000:4C6D  [+0x04C6D]  B1 04                    mov     cl,4
F000:4C6F  [+0x04C6F]  8A 26 89 04              mov     ah,[489h]
F000:4C73  [+0x04C73]  80 E4 0F                 and     ah,0Fh
F000:4C76  [+0x04C76]  0A E0                    or      ah,al
F000:4C78  [+0x04C78]  A0 87 04                 mov     al,[487h]
F000:4C7B  [+0x04C7B]  24 01                    and     al,1
F000:4C7D  [+0x04C7D]  D2 E0                    shl     al,cl
F000:4C7F  [+0x04C7F]  34 10                    xor     al,10h
F000:4C81  [+0x04C81]  0A C4                    or      al,ah
F000:4C83  [+0x04C83]  AA                       stosb
F000:4C84  [+0x04C84]  33 C0                    xor     ax,ax
F000:4C86  [+0x04C86]  AB                       stosw
F000:4C87  [+0x04C87]  AA                       stosb
F000:4C88  [+0x04C88]  A0 87 04                 mov     al,[487h]
F000:4C8B  [+0x04C8B]  B1 05                    mov     cl,5
F000:4C8D  [+0x04C8D]  D2 E8                    shr     al,cl
F000:4C8F  [+0x04C8F]  24 03                    and     al,3
F000:4C91  [+0x04C91]  AA                       stosb
F000:4C92  [+0x04C92]  32 ED                    xor     ch,ch
F000:4C94  [+0x04C94]  06                       push    es
F000:4C95  [+0x04C95]  C4 1E A8 04              les     bx,[4A8h]
F000:4C99  [+0x04C99]  26 8B 47 04              mov     ax,[es:bx+4]
F000:4C9D  [+0x04C9D]  26 0B 47 06              or      ax,[es:bx+6]
F000:4CA1  [+0x04CA1]  74 03                    je      short 4CA6h
F000:4CA3  [+0x04CA3]  80 CD 02                 or      ch,2
F000:4CA6  [+0x04CA6]  26 8B 47 08              mov     ax,[es:bx+8]
F000:4CAA  [+0x04CAA]  26 0B 47 0A              or      ax,[es:bx+0Ah]
F000:4CAE  [+0x04CAE]  74 03                    je      short 4CB3h
F000:4CB0  [+0x04CB0]  80 CD 04                 or      ch,4
F000:4CB3  [+0x04CB3]  26 8B 47 0C              mov     ax,[es:bx+0Ch]
F000:4CB7  [+0x04CB7]  26 0B 47 0E              or      ax,[es:bx+0Eh]
F000:4CBB  [+0x04CBB]  74 03                    je      short 4CC0h
F000:4CBD  [+0x04CBD]  80 CD 08                 or      ch,8
F000:4CC0  [+0x04CC0]  26 C4 5F 10              les     bx,[es:bx+10h]
F000:4CC4  [+0x04CC4]  8C C0                    mov     ax,es
F000:4CC6  [+0x04CC6]  0B C3                    or      ax,bx
F000:4CC8  [+0x04CC8]  74 25                    je      short 4CEFh
F000:4CCA  [+0x04CCA]  26 8B 47 0A              mov     ax,[es:bx+0Ah]
F000:4CCE  [+0x04CCE]  26 0B 47 0C              or      ax,[es:bx+0Ch]
F000:4CD2  [+0x04CD2]  74 03                    je      short 4CD7h
F000:4CD4  [+0x04CD4]  80 CD 10                 or      ch,10h
F000:4CD7  [+0x04CD7]  8C C8                    mov     ax,cs
F000:4CD9  [+0x04CD9]  26 3B 47 04              cmp     ax,[es:bx+4]
F000:4CDD  [+0x04CDD]  74 03                    je      short 4CE2h
F000:4CDF  [+0x04CDF]  80 CD 20                 or      ch,20h
F000:4CE2  [+0x04CE2]  26 8B 47 06              mov     ax,[es:bx+6]
F000:4CE6  [+0x04CE6]  26 0B 47 08              or      ax,[es:bx+8]
F000:4CEA  [+0x04CEA]  74 03                    je      short 4CEFh
F000:4CEC  [+0x04CEC]  80 CD 01                 or      ch,1
F000:4CEF  [+0x04CEF]  8A C5                    mov     al,ch
F000:4CF1  [+0x04CF1]  07                       pop     es
F000:4CF2  [+0x04CF2]  AA                       stosb
F000:4CF3  [+0x04CF3]  B9 0D 00                 mov     cx,0Dh
F000:4CF6  [+0x04CF6]  32 C0                    xor     al,al
F000:4CF8  [+0x04CF8]  F3 AA                    rep stosb
F000:4CFA  [+0x04CFA]  C3                       ret
F000:4CFB  [+0x04CFB]  00 1F                    add     [bx],bl
F000:4CFD  [+0x04CFD]  4D                       dec     bp
F000:4CFE  [+0x04CFE]  30 4D 4A                 xor     [di+4Ah],cl
F000:4D01  [+0x04D01]  4D                       dec     bp
F000:4D02  [+0x04D02]  53                       push    bx
F000:4D03  [+0x04D03]  51                       push    cx
F000:4D04  [+0x04D04]  E8 2E 09                 call    5635h
F000:4D07  [+0x04D07]  8A E3                    mov     ah,bl
F000:4D09  [+0x04D09]  59                       pop     cx
F000:4D0A  [+0x04D0A]  5B                       pop     bx
F000:4D0B  [+0x04D0B]  C6 46 10 00              mov     byte [bp+10h],0
F000:4D0F  [+0x04D0F]  3C 02                    cmp     al,2
F000:4D11  [+0x04D11]  77 0B                    ja      short 4D1Eh
F000:4D13  [+0x04D13]  32 E4                    xor     ah,ah
F000:4D15  [+0x04D15]  D1 E0                    shl     ax,1
F000:4D17  [+0x04D17]  8B F0                    mov     si,ax
F000:4D19  [+0x04D19]  2E FF A4 FC 4C           jmp     word [cs:si+4CFCh]
F000:4D1E  [+0x04D1E]  C3                       ret
F000:4D1F  [+0x04D1F]  81 E1 07 80              and     cx,8007h
F000:4D23  [+0x04D23]  74 F9                    je      short 4D1Eh
F000:4D25  [+0x04D25]  C6 46 10 1C              mov     byte [bp+10h],1Ch
F000:4D29  [+0x04D29]  E8 40 00                 call    4D6Ch
F000:4D2C  [+0x04D2C]  89 46 0E                 mov     [bp+0Eh],ax
F000:4D2F  [+0x04D2F]  C3                       ret
F000:4D30  [+0x04D30]  81 E1 07 C0              and     cx,0C007h
F000:4D34  [+0x04D34]  F6 C1 04                 test    cl,4
F000:4D37  [+0x04D37]  75 04                    jne     short 4D3Dh
F000:4D39  [+0x04D39]  C6 46 10 1C              mov     byte [bp+10h],1Ch
F000:4D3D  [+0x04D3D]  83 F9 02                 cmp     cx,2
F000:4D40  [+0x04D40]  75 04                    jne     short 4D46h
F000:4D42  [+0x04D42]  E8 3D 00                 call    4D82h
F000:4D45  [+0x04D45]  C3                       ret
F000:4D46  [+0x04D46]  E8 15 D4                 call    215Eh
F000:4D49  [+0x04D49]  C3                       ret
F000:4D4A  [+0x04D4A]  81 E1 07 80              and     cx,8007h
F000:4D4E  [+0x04D4E]  F6 C1 04                 test    cl,4
F000:4D51  [+0x04D51]  75 04                    jne     short 4D57h
F000:4D53  [+0x04D53]  C6 46 10 1C              mov     byte [bp+10h],1Ch
F000:4D57  [+0x04D57]  83 F9 02                 cmp     cx,2
F000:4D5A  [+0x04D5A]  75 04                    jne     short 4D60h
F000:4D5C  [+0x04D5C]  E8 9D 01                 call    4EFCh
F000:4D5F  [+0x04D5F]  C3                       ret
F000:4D60  [+0x04D60]  E8 EB D4                 call    224Eh
F000:4D63  [+0x04D63]  C3                       ret
F000:4D64  [+0x04D64]  00 02                    add     [bp+si],al
F000:4D66  [+0x04D66]  02 03                    add     al,[bp+di]
F000:4D68  [+0x04D68]  0D 0E 0E                 or      ax,0E0Eh
F000:4D6B  [+0x04D6B]  0F 8A D9 32              jp      near 8048h
F000:4D6F  [+0x04D6F]  FF 2E 8A 87              jmp     far [878Ah]
F000:4D73  [+0x04D73]  64 4D                    dec     bp
F000:4D75  [+0x04D75]  F6 C5 80                 test    ch,80h
F000:4D78  [+0x04D78]  74 05                    je      short 4D7Fh
F000:4D7A  [+0x04D7A]  2E 8A 87 1E 21           mov     al,[cs:bx+211Eh]
F000:4D7F  [+0x04D7F]  32 E4                    xor     ah,ah
F000:4D81  [+0x04D81]  C3                       ret
F000:4D82  [+0x04D82]  8B FB                    mov     di,bx
F000:4D84  [+0x04D84]  83 C7 20                 add     di,20h
F000:4D87  [+0x04D87]  F6 C1 01                 test    cl,1
F000:4D8A  [+0x04D8A]  74 06                    je      short 4D92h
F000:4D8C  [+0x04D8C]  26 89 3F                 mov     [es:bx],di
F000:4D8F  [+0x04D8F]  E8 3E 00                 call    4DD0h
F000:4D92  [+0x04D92]  F6 C1 02                 test    cl,2
F000:4D95  [+0x04D95]  74 07                    je      short 4D9Eh
F000:4D97  [+0x04D97]  26 89 7F 02              mov     [es:bx+2],di
F000:4D9B  [+0x04D9B]  E8 2C 01                 call    4ECAh
F000:4D9E  [+0x04D9E]  F6 C1 04                 test    cl,4
F000:4DA1  [+0x04DA1]  74 2C                    je      short 4DCFh
F000:4DA3  [+0x04DA3]  51                       push    cx
F000:4DA4  [+0x04DA4]  26 89 7F 04              mov     [es:bx+4],di
F000:4DA8  [+0x04DA8]  BA C7 03                 mov     dx,3C7h
F000:4DAB  [+0x04DAB]  EC                       in      al,dx
F000:4DAC  [+0x04DAC]  42                       inc     dx
F000:4DAD  [+0x04DAD]  24 01                    and     al,1
F000:4DAF  [+0x04DAF]  AA                       stosb
F000:4DB0  [+0x04DB0]  EC                       in      al,dx
F000:4DB1  [+0x04DB1]  74 02                    je      short 4DB5h
F000:4DB3  [+0x04DB3]  FE C8                    dec     al
F000:4DB5  [+0x04DB5]  AA                       stosb
F000:4DB6  [+0x04DB6]  BA C6 03                 mov     dx,3C6h
F000:4DB9  [+0x04DB9]  EC                       in      al,dx
F000:4DBA  [+0x04DBA]  AA                       stosb
F000:4DBB  [+0x04DBB]  33 DB                    xor     bx,bx
F000:4DBD  [+0x04DBD]  BE 00 01                 mov     si,100h
F000:4DC0  [+0x04DC0]  E8 BC 04                 call    527Fh
F000:4DC3  [+0x04DC3]  8A C4                    mov     al,ah
F000:4DC5  [+0x04DC5]  8A E5                    mov     ah,ch
F000:4DC7  [+0x04DC7]  AB                       stosw
F000:4DC8  [+0x04DC8]  8A C1                    mov     al,cl
F000:4DCA  [+0x04DCA]  AA                       stosb
F000:4DCB  [+0x04DCB]  4E                       dec     si
F000:4DCC  [+0x04DCC]  75 F2                    jne     short 4DC0h
F000:4DCE  [+0x04DCE]  59                       pop     cx
F000:4DCF  [+0x04DCF]  C3                       ret
F000:4DD0  [+0x04DD0]  51                       push    cx
F000:4DD1  [+0x04DD1]  BA C4 03                 mov     dx,3C4h
F000:4DD4  [+0x04DD4]  EC                       in      al,dx
F000:4DD5  [+0x04DD5]  AA                       stosb
F000:4DD6  [+0x04DD6]  BA CC 03                 mov     dx,3CCh
F000:4DD9  [+0x04DD9]  EC                       in      al,dx
F000:4DDA  [+0x04DDA]  BA D4 03                 mov     dx,3D4h
F000:4DDD  [+0x04DDD]  A8 01                    test    al,1
F000:4DDF  [+0x04DDF]  75 03                    jne     short 4DE4h
F000:4DE1  [+0x04DE1]  BA B4 03                 mov     dx,3B4h
F000:4DE4  [+0x04DE4]  52                       push    dx
F000:4DE5  [+0x04DE5]  EC                       in      al,dx
F000:4DE6  [+0x04DE6]  AA                       stosb
F000:4DE7  [+0x04DE7]  BA CE 03                 mov     dx,3CEh
F000:4DEA  [+0x04DEA]  EC                       in      al,dx
F000:4DEB  [+0x04DEB]  AA                       stosb
F000:4DEC  [+0x04DEC]  5A                       pop     dx
F000:4DED  [+0x04DED]  32 E4                    xor     ah,ah
F000:4DEF  [+0x04DEF]  F6 C5 A0                 test    ch,0A0h
F000:4DF2  [+0x04DF2]  74 08                    je      short 4DFCh
F000:4DF4  [+0x04DF4]  B0 24                    mov     al,24h
F000:4DF6  [+0x04DF6]  E8 A5 02                 call    509Eh
F000:4DF9  [+0x04DF9]  80 E4 80                 and     ah,80h
F000:4DFC  [+0x04DFC]  83 C2 06                 add     dx,6
F000:4DFF  [+0x04DFF]  EC                       in      al,dx
F000:4E00  [+0x04E00]  BA C0 03                 mov     dx,3C0h
F000:4E03  [+0x04E03]  EC                       in      al,dx
F000:4E04  [+0x04E04]  0A C4                    or      al,ah
F000:4E06  [+0x04E06]  AA                       stosb
F000:4E07  [+0x04E07]  BA CA 03                 mov     dx,3CAh
F000:4E0A  [+0x04E0A]  EC                       in      al,dx
F000:4E0B  [+0x04E0B]  AA                       stosb
F000:4E0C  [+0x04E0C]  BA C4 03                 mov     dx,3C4h
F000:4E0F  [+0x04E0F]  B9 04 00                 mov     cx,4
F000:4E12  [+0x04E12]  B0 01                    mov     al,1
F000:4E14  [+0x04E14]  E8 73 02                 call    508Ah
F000:4E17  [+0x04E17]  86 C4                    xchg    al,ah
F000:4E19  [+0x04E19]  AA                       stosb
F000:4E1A  [+0x04E1A]  86 C4                    xchg    al,ah
F000:4E1C  [+0x04E1C]  E2 F6                    loop    4E14h
F000:4E1E  [+0x04E1E]  BA CC 03                 mov     dx,3CCh
F000:4E21  [+0x04E21]  EC                       in      al,dx
F000:4E22  [+0x04E22]  AA                       stosb
F000:4E23  [+0x04E23]  BA D4 03                 mov     dx,3D4h
F000:4E26  [+0x04E26]  A8 01                    test    al,1
F000:4E28  [+0x04E28]  75 03                    jne     short 4E2Dh
F000:4E2A  [+0x04E2A]  BA B4 03                 mov     dx,3B4h
F000:4E2D  [+0x04E2D]  B9 19 00                 mov     cx,19h
F000:4E30  [+0x04E30]  B0 00                    mov     al,0
F000:4E32  [+0x04E32]  E8 55 02                 call    508Ah
F000:4E35  [+0x04E35]  86 C4                    xchg    al,ah
F000:4E37  [+0x04E37]  AA                       stosb
F000:4E38  [+0x04E38]  86 C4                    xchg    al,ah
F000:4E3A  [+0x04E3A]  E2 F6                    loop    4E32h
F000:4E3C  [+0x04E3C]  52                       push    dx
F000:4E3D  [+0x04E3D]  83 C2 06                 add     dx,6
F000:4E40  [+0x04E40]  EC                       in      al,dx
F000:4E41  [+0x04E41]  BA C0 03                 mov     dx,3C0h
F000:4E44  [+0x04E44]  B9 14 00                 mov     cx,14h
F000:4E47  [+0x04E47]  53                       push    bx
F000:4E48  [+0x04E48]  B3 00                    mov     bl,0
F000:4E4A  [+0x04E4A]  E8 CF F5                 call    441Ch
F000:4E4D  [+0x04E4D]  8A C7                    mov     al,bh
F000:4E4F  [+0x04E4F]  AA                       stosb
F000:4E50  [+0x04E50]  FE C3                    inc     bl
F000:4E52  [+0x04E52]  E2 F6                    loop    4E4Ah
F000:4E54  [+0x04E54]  5B                       pop     bx
F000:4E55  [+0x04E55]  BA CE 03                 mov     dx,3CEh
F000:4E58  [+0x04E58]  B9 09 00                 mov     cx,9
F000:4E5B  [+0x04E5B]  B0 00                    mov     al,0
F000:4E5D  [+0x04E5D]  E8 2A 02                 call    508Ah
F000:4E60  [+0x04E60]  86 C4                    xchg    al,ah
F000:4E62  [+0x04E62]  AA                       stosb
F000:4E63  [+0x04E63]  86 C4                    xchg    al,ah
F000:4E65  [+0x04E65]  E2 F6                    loop    4E5Dh
F000:4E67  [+0x04E67]  58                       pop     ax
F000:4E68  [+0x04E68]  AB                       stosw
F000:4E69  [+0x04E69]  53                       push    bx
F000:4E6A  [+0x04E6A]  8B F0                    mov     si,ax
F000:4E6C  [+0x04E6C]  BA C4 03                 mov     dx,3C4h
F000:4E6F  [+0x04E6F]  B0 04                    mov     al,4
F000:4E71  [+0x04E71]  E8 2A 02                 call    509Eh
F000:4E74  [+0x04E74]  8A FC                    mov     bh,ah
F000:4E76  [+0x04E76]  B4 06                    mov     ah,6
F000:4E78  [+0x04E78]  EF                       out     dx,ax
F000:4E79  [+0x04E79]  BA CE 03                 mov     dx,3CEh
F000:4E7C  [+0x04E7C]  E8 0B 02                 call    508Ah
F000:4E7F  [+0x04E7F]  8A DC                    mov     bl,ah
F000:4E81  [+0x04E81]  53                       push    bx
F000:4E82  [+0x04E82]  E8 19 02                 call    509Eh
F000:4E85  [+0x04E85]  8A FC                    mov     bh,ah
F000:4E87  [+0x04E87]  B4 00                    mov     ah,0
F000:4E89  [+0x04E89]  EF                       out     dx,ax
F000:4E8A  [+0x04E8A]  FE C0                    inc     al
F000:4E8C  [+0x04E8C]  E8 0F 02                 call    509Eh
F000:4E8F  [+0x04E8F]  8A DC                    mov     bl,ah
F000:4E91  [+0x04E91]  53                       push    bx
F000:4E92  [+0x04E92]  B4 05                    mov     ah,5
F000:4E94  [+0x04E94]  EF                       out     dx,ax
F000:4E95  [+0x04E95]  B3 04                    mov     bl,4
F000:4E97  [+0x04E97]  32 E4                    xor     ah,ah
F000:4E99  [+0x04E99]  B7 22                    mov     bh,22h
F000:4E9B  [+0x04E9B]  B9 04 00                 mov     cx,4
F000:4E9E  [+0x04E9E]  8A C3                    mov     al,bl
F000:4EA0  [+0x04EA0]  EF                       out     dx,ax
F000:4EA1  [+0x04EA1]  87 D6                    xchg    dx,si
F000:4EA3  [+0x04EA3]  8A C7                    mov     al,bh
F000:4EA5  [+0x04EA5]  EE                       out     dx,al
F000:4EA6  [+0x04EA6]  42                       inc     dx
F000:4EA7  [+0x04EA7]  EC                       in      al,dx
F000:4EA8  [+0x04EA8]  AA                       stosb
F000:4EA9  [+0x04EA9]  FE C4                    inc     ah
F000:4EAB  [+0x04EAB]  4A                       dec     dx
F000:4EAC  [+0x04EAC]  87 D6                    xchg    dx,si
F000:4EAE  [+0x04EAE]  E2 EE                    loop    4E9Eh
F000:4EB0  [+0x04EB0]  5B                       pop     bx
F000:4EB1  [+0x04EB1]  B0 05                    mov     al,5
F000:4EB3  [+0x04EB3]  8A E7                    mov     ah,bh
F000:4EB5  [+0x04EB5]  EF                       out     dx,ax
F000:4EB6  [+0x04EB6]  FE C0                    inc     al
F000:4EB8  [+0x04EB8]  8A E3                    mov     ah,bl
F000:4EBA  [+0x04EBA]  EF                       out     dx,ax
F000:4EBB  [+0x04EBB]  5B                       pop     bx
F000:4EBC  [+0x04EBC]  B0 04                    mov     al,4
F000:4EBE  [+0x04EBE]  8A E3                    mov     ah,bl
F000:4EC0  [+0x04EC0]  EF                       out     dx,ax
F000:4EC1  [+0x04EC1]  BA C4 03                 mov     dx,3C4h
F000:4EC4  [+0x04EC4]  8A E7                    mov     ah,bh
F000:4EC6  [+0x04EC6]  EF                       out     dx,ax
F000:4EC7  [+0x04EC7]  5B                       pop     bx
F000:4EC8  [+0x04EC8]  59                       pop     cx
F000:4EC9  [+0x04EC9]  C3                       ret
F000:4ECA  [+0x04ECA]  51                       push    cx
F000:4ECB  [+0x04ECB]  A0 10 04                 mov     al,[410h]
F000:4ECE  [+0x04ECE]  24 30                    and     al,30h
F000:4ED0  [+0x04ED0]  AA                       stosb
F000:4ED1  [+0x04ED1]  BE 49 04                 mov     si,449h
F000:4ED4  [+0x04ED4]  B9 0F 00                 mov     cx,0Fh
F000:4ED7  [+0x04ED7]  F3 A5                    rep movsw
F000:4ED9  [+0x04ED9]  BE 84 04                 mov     si,484h
F000:4EDC  [+0x04EDC]  B9 07 00                 mov     cx,7
F000:4EDF  [+0x04EDF]  F3 A4                    rep movsb
F000:4EE1  [+0x04EE1]  BE A8 04                 mov     si,4A8h
F000:4EE4  [+0x04EE4]  A5                       movsw
F000:4EE5  [+0x04EE5]  A5                       movsw
F000:4EE6  [+0x04EE6]  BE 14 00                 mov     si,14h
F000:4EE9  [+0x04EE9]  A5                       movsw
F000:4EEA  [+0x04EEA]  A5                       movsw
F000:4EEB  [+0x04EEB]  BE 74 00                 mov     si,74h
F000:4EEE  [+0x04EEE]  A5                       movsw
F000:4EEF  [+0x04EEF]  A5                       movsw
F000:4EF0  [+0x04EF0]  BE 7C 00                 mov     si,7Ch
F000:4EF3  [+0x04EF3]  A5                       movsw
F000:4EF4  [+0x04EF4]  A5                       movsw
F000:4EF5  [+0x04EF5]  BE 0C 01                 mov     si,10Ch
F000:4EF8  [+0x04EF8]  A5                       movsw
F000:4EF9  [+0x04EF9]  A5                       movsw
F000:4EFA  [+0x04EFA]  59                       pop     cx
F000:4EFB  [+0x04EFB]  C3                       ret
F000:4EFC  [+0x04EFC]  F6 C1 01                 test    cl,1
F000:4EFF  [+0x04EFF]  74 06                    je      short 4F07h
F000:4F01  [+0x04F01]  26 8B 37                 mov     si,[es:bx]
F000:4F04  [+0x04F04]  E8 61 00                 call    4F68h
F000:4F07  [+0x04F07]  F6 C1 02                 test    cl,2
F000:4F0A  [+0x04F0A]  74 07                    je      short 4F13h
F000:4F0C  [+0x04F0C]  26 8B 77 02              mov     si,[es:bx+2]
F000:4F10  [+0x04F10]  E8 12 01                 call    5025h
F000:4F13  [+0x04F13]  F6 C1 04                 test    cl,4
F000:4F16  [+0x04F16]  74 4F                    je      short 4F67h
F000:4F18  [+0x04F18]  51                       push    cx
F000:4F19  [+0x04F19]  26 8B 77 04              mov     si,[es:bx+4]
F000:4F1D  [+0x04F1D]  53                       push    bx
F000:4F1E  [+0x04F1E]  BA C6 03                 mov     dx,3C6h
F000:4F21  [+0x04F21]  83 C6 02                 add     si,2
F000:4F24  [+0x04F24]  26 AC                    es lodsb
F000:4F26  [+0x04F26]  EE                       out     dx,al
F000:4F27  [+0x04F27]  BA C4 03                 mov     dx,3C4h
F000:4F2A  [+0x04F2A]  EC                       in      al,dx
F000:4F2B  [+0x04F2B]  50                       push    ax
F000:4F2C  [+0x04F2C]  B0 01                    mov     al,1
F000:4F2E  [+0x04F2E]  E8 6D 01                 call    509Eh
F000:4F31  [+0x04F31]  50                       push    ax
F000:4F32  [+0x04F32]  80 CC 20                 or      ah,20h
F000:4F35  [+0x04F35]  EF                       out     dx,ax
F000:4F36  [+0x04F36]  33 DB                    xor     bx,bx
F000:4F38  [+0x04F38]  BA 00 01                 mov     dx,100h
F000:4F3B  [+0x04F3B]  52                       push    dx
F000:4F3C  [+0x04F3C]  26 AD                    es lodsw
F000:4F3E  [+0x04F3E]  8A EC                    mov     ch,ah
F000:4F40  [+0x04F40]  8A E0                    mov     ah,al
F000:4F42  [+0x04F42]  26 AC                    es lodsb
F000:4F44  [+0x04F44]  8A C8                    mov     cl,al
F000:4F46  [+0x04F46]  E8 53 03                 call    529Ch
F000:4F49  [+0x04F49]  5A                       pop     dx
F000:4F4A  [+0x04F4A]  4A                       dec     dx
F000:4F4B  [+0x04F4B]  75 EE                    jne     short 4F3Bh
F000:4F4D  [+0x04F4D]  BA C4 03                 mov     dx,3C4h
F000:4F50  [+0x04F50]  58                       pop     ax
F000:4F51  [+0x04F51]  EF                       out     dx,ax
F000:4F52  [+0x04F52]  58                       pop     ax
F000:4F53  [+0x04F53]  EE                       out     dx,al
F000:4F54  [+0x04F54]  5B                       pop     bx
F000:4F55  [+0x04F55]  26 8B 77 04              mov     si,[es:bx+4]
F000:4F59  [+0x04F59]  BA C7 03                 mov     dx,3C7h
F000:4F5C  [+0x04F5C]  26 AC                    es lodsb
F000:4F5E  [+0x04F5E]  0A C0                    or      al,al
F000:4F60  [+0x04F60]  75 01                    jne     short 4F63h
F000:4F62  [+0x04F62]  42                       inc     dx
F000:4F63  [+0x04F63]  26 AC                    es lodsb
F000:4F65  [+0x04F65]  EE                       out     dx,al
F000:4F66  [+0x04F66]  59                       pop     cx
F000:4F67  [+0x04F67]  C3                       ret
F000:4F68  [+0x04F68]  51                       push    cx
F000:4F69  [+0x04F69]  1E                       push    ds
F000:4F6A  [+0x04F6A]  BA C4 03                 mov     dx,3C4h
F000:4F6D  [+0x04F6D]  B8 04 06                 mov     ax,604h
F000:4F70  [+0x04F70]  EF                       out     dx,ax
F000:4F71  [+0x04F71]  BA CE 03                 mov     dx,3CEh
F000:4F74  [+0x04F74]  B8 05 00                 mov     ax,5
F000:4F77  [+0x04F77]  EF                       out     dx,ax
F000:4F78  [+0x04F78]  B8 06 05                 mov     ax,506h
F000:4F7B  [+0x04F7B]  EF                       out     dx,ax
F000:4F7C  [+0x04F7C]  B8 08 FF                 mov     ax,0FF08h
F000:4F7F  [+0x04F7F]  EF                       out     dx,ax
F000:4F80  [+0x04F80]  B8 03 00                 mov     ax,3
F000:4F83  [+0x04F83]  EF                       out     dx,ax
F000:4F84  [+0x04F84]  B8 01 00                 mov     ax,1
F000:4F87  [+0x04F87]  EF                       out     dx,ax
F000:4F88  [+0x04F88]  B8 00 A0                 mov     ax,0A000h
F000:4F8B  [+0x04F8B]  8E D8                    mov     ds,ax
F000:4F8D  [+0x04F8D]  BF FF FF                 mov     di,0FFFFh
F000:4F90  [+0x04F90]  B9 00 04                 mov     cx,400h
F000:4F93  [+0x04F93]  B0 04                    mov     al,4
F000:4F95  [+0x04F95]  8A E1                    mov     ah,cl
F000:4F97  [+0x04F97]  EF                       out     dx,ax
F000:4F98  [+0x04F98]  8A 05                    mov     al,[di]
F000:4F9A  [+0x04F9A]  50                       push    ax
F000:4F9B  [+0x04F9B]  FE C1                    inc     cl
F000:4F9D  [+0x04F9D]  FE CD                    dec     ch
F000:4F9F  [+0x04F9F]  75 F2                    jne     short 4F93h
F000:4FA1  [+0x04FA1]  B9 01 04                 mov     cx,401h
F000:4FA4  [+0x04FA4]  83 C6 42                 add     si,42h
F000:4FA7  [+0x04FA7]  BA C4 03                 mov     dx,3C4h
F000:4FAA  [+0x04FAA]  B0 02                    mov     al,2
F000:4FAC  [+0x04FAC]  8A E1                    mov     ah,cl
F000:4FAE  [+0x04FAE]  EF                       out     dx,ax
F000:4FAF  [+0x04FAF]  26 AC                    es lodsb
F000:4FB1  [+0x04FB1]  88 05                    mov     [di],al
F000:4FB3  [+0x04FB3]  D0 E1                    shl     cl,1
F000:4FB5  [+0x04FB5]  FE CD                    dec     ch
F000:4FB7  [+0x04FB7]  75 F1                    jne     short 4FAAh
F000:4FB9  [+0x04FB9]  8A 05                    mov     al,[di]
F000:4FBB  [+0x04FBB]  B9 08 04                 mov     cx,408h
F000:4FBE  [+0x04FBE]  B0 02                    mov     al,2
F000:4FC0  [+0x04FC0]  8A E1                    mov     ah,cl
F000:4FC2  [+0x04FC2]  EF                       out     dx,ax
F000:4FC3  [+0x04FC3]  58                       pop     ax
F000:4FC4  [+0x04FC4]  88 05                    mov     [di],al
F000:4FC6  [+0x04FC6]  D0 E9                    shr     cl,1
F000:4FC8  [+0x04FC8]  FE CD                    dec     ch
F000:4FCA  [+0x04FCA]  75 F2                    jne     short 4FBEh
F000:4FCC  [+0x04FCC]  1F                       pop     ds
F000:4FCD  [+0x04FCD]  26 8B 37                 mov     si,[es:bx]
F000:4FD0  [+0x04FD0]  B0 00                    mov     al,0
F000:4FD2  [+0x04FD2]  86 06 89 04              xchg    al,[489h]
F000:4FD6  [+0x04FD6]  50                       push    ax
F000:4FD7  [+0x04FD7]  FF 36 63 04              push    word [463h]
F000:4FDB  [+0x04FDB]  E8 E8 01                 call    51C6h
F000:4FDE  [+0x04FDE]  8F 06 63 04              pop     word [463h]
F000:4FE2  [+0x04FE2]  58                       pop     ax
F000:4FE3  [+0x04FE3]  A2 89 04                 mov     [489h],al
F000:4FE6  [+0x04FE6]  26 8B 37                 mov     si,[es:bx]
F000:4FE9  [+0x04FE9]  26 8B 54 40              mov     dx,[es:si+40h]
F000:4FED  [+0x04FED]  52                       push    dx
F000:4FEE  [+0x04FEE]  83 C2 06                 add     dx,6
F000:4FF1  [+0x04FF1]  26 8A 44 04              mov     al,[es:si+4]
F000:4FF5  [+0x04FF5]  EE                       out     dx,al
F000:4FF6  [+0x04FF6]  BA C4 03                 mov     dx,3C4h
F000:4FF9  [+0x04FF9]  26 AC                    es lodsb
F000:4FFB  [+0x04FFB]  EE                       out     dx,al
F000:4FFC  [+0x04FFC]  5A                       pop     dx
F000:4FFD  [+0x04FFD]  26 AC                    es lodsb
F000:4FFF  [+0x04FFF]  EE                       out     dx,al
F000:5000  [+0x05000]  52                       push    dx
F000:5001  [+0x05001]  BA CE 03                 mov     dx,3CEh
F000:5004  [+0x05004]  26 AC                    es lodsb
F000:5006  [+0x05006]  EE                       out     dx,al
F000:5007  [+0x05007]  5A                       pop     dx
F000:5008  [+0x05008]  83 C2 06                 add     dx,6
F000:500B  [+0x0500B]  52                       push    dx
F000:500C  [+0x0500C]  EC                       in      al,dx
F000:500D  [+0x0500D]  BA C0 03                 mov     dx,3C0h
F000:5010  [+0x05010]  26 AC                    es lodsb
F000:5012  [+0x05012]  8A E0                    mov     ah,al
F000:5014  [+0x05014]  24 7F                    and     al,7Fh
F000:5016  [+0x05016]  EE                       out     dx,al
F000:5017  [+0x05017]  5A                       pop     dx
F000:5018  [+0x05018]  59                       pop     cx
F000:5019  [+0x05019]  F6 C5 A0                 test    ch,0A0h
F000:501C  [+0x0501C]  74 06                    je      short 5024h
F000:501E  [+0x0501E]  F6 C4 80                 test    ah,80h
F000:5021  [+0x05021]  75 01                    jne     short 5024h
F000:5023  [+0x05023]  EC                       in      al,dx
F000:5024  [+0x05024]  C3                       ret
F000:5025  [+0x05025]  51                       push    cx
F000:5026  [+0x05026]  80 26 10 04 CF           and     byte [410h],0CFh
F000:502B  [+0x0502B]  26 AC                    es lodsb
F000:502D  [+0x0502D]  08 06 10 04              or      [410h],al
F000:5031  [+0x05031]  06                       push    es
F000:5032  [+0x05032]  1E                       push    ds
F000:5033  [+0x05033]  8C D8                    mov     ax,ds
F000:5035  [+0x05035]  8C C7                    mov     di,es
F000:5037  [+0x05037]  97                       xchg    di,ax
F000:5038  [+0x05038]  8E D8                    mov     ds,ax
F000:503A  [+0x0503A]  8E C7                    mov     es,di
F000:503C  [+0x0503C]  BF 49 04                 mov     di,449h
F000:503F  [+0x0503F]  B9 0F 00                 mov     cx,0Fh
F000:5042  [+0x05042]  F3 A5                    rep movsw
F000:5044  [+0x05044]  BF 84 04                 mov     di,484h
F000:5047  [+0x05047]  B9 07 00                 mov     cx,7
F000:504A  [+0x0504A]  F3 A4                    rep movsb
F000:504C  [+0x0504C]  1F                       pop     ds
F000:504D  [+0x0504D]  07                       pop     es
F000:504E  [+0x0504E]  26 AD                    es lodsw
F000:5050  [+0x05050]  A3 A8 04                 mov     [4A8h],ax
F000:5053  [+0x05053]  26 AD                    es lodsw
F000:5055  [+0x05055]  A3 AA 04                 mov     [4AAh],ax
F000:5058  [+0x05058]  BF 14 00                 mov     di,14h
F000:505B  [+0x0505B]  26 AD                    es lodsw
F000:505D  [+0x0505D]  89 05                    mov     [di],ax
F000:505F  [+0x0505F]  26 AD                    es lodsw
F000:5061  [+0x05061]  89 45 02                 mov     [di+2],ax
F000:5064  [+0x05064]  BF 74 00                 mov     di,74h
F000:5067  [+0x05067]  26 AD                    es lodsw
F000:5069  [+0x05069]  89 05                    mov     [di],ax
F000:506B  [+0x0506B]  26 AD                    es lodsw
F000:506D  [+0x0506D]  89 45 02                 mov     [di+2],ax
F000:5070  [+0x05070]  BF 7C 00                 mov     di,7Ch
F000:5073  [+0x05073]  26 AD                    es lodsw
F000:5075  [+0x05075]  89 05                    mov     [di],ax
F000:5077  [+0x05077]  26 AD                    es lodsw
F000:5079  [+0x05079]  89 45 02                 mov     [di+2],ax
F000:507C  [+0x0507C]  BF 0C 01                 mov     di,10Ch
F000:507F  [+0x0507F]  26 AD                    es lodsw
F000:5081  [+0x05081]  89 05                    mov     [di],ax
F000:5083  [+0x05083]  26 AD                    es lodsw
F000:5085  [+0x05085]  89 45 02                 mov     [di+2],ax
F000:5088  [+0x05088]  59                       pop     cx
F000:5089  [+0x05089]  C3                       ret
F000:508A  [+0x0508A]  EE                       out     dx,al
F000:508B  [+0x0508B]  42                       inc     dx
F000:508C  [+0x0508C]  FE C0                    inc     al
F000:508E  [+0x0508E]  8A E0                    mov     ah,al
F000:5090  [+0x05090]  E3 00                    jcxz    5092h
F000:5092  [+0x05092]  E3 00                    jcxz    5094h
F000:5094  [+0x05094]  EC                       in      al,dx
F000:5095  [+0x05095]  4A                       dec     dx
F000:5096  [+0x05096]  86 C4                    xchg    al,ah
F000:5098  [+0x05098]  C3                       ret
F000:5099  [+0x05099]  EE                       out     dx,al
F000:509A  [+0x0509A]  42                       inc     dx
F000:509B  [+0x0509B]  EC                       in      al,dx
F000:509C  [+0x0509C]  C3                       ret
F000:509D  [+0x0509D]  90                       nop
F000:509E  [+0x0509E]  EE                       out     dx,al
F000:509F  [+0x0509F]  EB 00                    jmp     short 50A1h
F000:50A1  [+0x050A1]  ED                       in      ax,dx
F000:50A2  [+0x050A2]  C3                       ret
F000:50A3  [+0x050A3]  52                       push    dx
F000:50A4  [+0x050A4]  E8 85 CF                 call    202Ch
F000:50A7  [+0x050A7]  5A                       pop     dx
F000:50A8  [+0x050A8]  C3                       ret
F000:50A9  [+0x050A9]  52                       push    dx
F000:50AA  [+0x050AA]  BA D6 03                 mov     dx,3D6h
F000:50AD  [+0x050AD]  EF                       out     dx,ax
F000:50AE  [+0x050AE]  5A                       pop     dx
F000:50AF  [+0x050AF]  C3                       ret
F000:50B0  [+0x050B0]  B0 20                    mov     al,20h
F000:50B2  [+0x050B2]  E8 07 00                 call    50BCh
F000:50B5  [+0x050B5]  C3                       ret
F000:50B6  [+0x050B6]  32 C0                    xor     al,al
F000:50B8  [+0x050B8]  E8 01 00                 call    50BCh
F000:50BB  [+0x050BB]  C3                       ret
F000:50BC  [+0x050BC]  52                       push    dx
F000:50BD  [+0x050BD]  8B 16 63 04              mov     dx,[463h]
F000:50C1  [+0x050C1]  50                       push    ax
F000:50C2  [+0x050C2]  80 C2 06                 add     dl,6
F000:50C5  [+0x050C5]  EC                       in      al,dx
F000:50C6  [+0x050C6]  58                       pop     ax
F000:50C7  [+0x050C7]  52                       push    dx
F000:50C8  [+0x050C8]  BA C0 03                 mov     dx,3C0h
F000:50CB  [+0x050CB]  EE                       out     dx,al
F000:50CC  [+0x050CC]  5A                       pop     dx
F000:50CD  [+0x050CD]  EC                       in      al,dx
F000:50CE  [+0x050CE]  5A                       pop     dx
F000:50CF  [+0x050CF]  C3                       ret
F000:50D0  [+0x050D0]  8A D8                    mov     bl,al
F000:50D2  [+0x050D2]  E4 61                    in      al,61h
F000:50D4  [+0x050D4]  EB 00                    jmp     short 50D6h
F000:50D6  [+0x050D6]  8A F8                    mov     bh,al
F000:50D8  [+0x050D8]  24 FC                    and     al,0FCh
F000:50DA  [+0x050DA]  0A C3                    or      al,bl
F000:50DC  [+0x050DC]  0C 01                    or      al,1
F000:50DE  [+0x050DE]  E6 61                    out     61h,al
F000:50E0  [+0x050E0]  EB 00                    jmp     short 50E2h
F000:50E2  [+0x050E2]  B0 B6                    mov     al,0B6h
F000:50E4  [+0x050E4]  E6 43                    out     43h,al
F000:50E6  [+0x050E6]  EB 00                    jmp     short 50E8h
F000:50E8  [+0x050E8]  B0 50                    mov     al,50h
F000:50EA  [+0x050EA]  E6 42                    out     42h,al
F000:50EC  [+0x050EC]  EB 00                    jmp     short 50EEh
F000:50EE  [+0x050EE]  B0 05                    mov     al,5
F000:50F0  [+0x050F0]  E6 42                    out     42h,al
F000:50F2  [+0x050F2]  BA FF FF                 mov     dx,0FFFFh
F000:50F5  [+0x050F5]  B0 80                    mov     al,80h
F000:50F7  [+0x050F7]  E6 43                    out     43h,al
F000:50F9  [+0x050F9]  EB 00                    jmp     short 50FBh
F000:50FB  [+0x050FB]  E4 42                    in      al,42h
F000:50FD  [+0x050FD]  EB 00                    jmp     short 50FFh
F000:50FF  [+0x050FF]  8A E0                    mov     ah,al
F000:5101  [+0x05101]  E4 42                    in      al,42h
F000:5103  [+0x05103]  86 C4                    xchg    al,ah
F000:5105  [+0x05105]  3B C2                    cmp     ax,dx
F000:5107  [+0x05107]  8B D0                    mov     dx,ax
F000:5109  [+0x05109]  72 EA                    jb      short 50F5h
F000:510B  [+0x0510B]  E2 E8                    loop    50F5h
F000:510D  [+0x0510D]  E4 61                    in      al,61h
F000:510F  [+0x0510F]  EB 00                    jmp     short 5111h
F000:5111  [+0x05111]  22 C7                    and     al,bh
F000:5113  [+0x05113]  E6 61                    out     61h,al
F000:5115  [+0x05115]  C3                       ret
F000:5116  [+0x05116]  00 01                    add     [bx+di],al
F000:5118  [+0x05118]  02 03                    add     al,[bp+di]
F000:511A  [+0x0511A]  04 05                    add     al,5
F000:511C  [+0x0511C]  06                       push    es
F000:511D  [+0x0511D]  07                       pop     es
F000:511E  [+0x0511E]  08 09                    or      [bx+di],cl
F000:5120  [+0x05120]  0A 0B                    or      cl,[bp+di]
F000:5122  [+0x05122]  0C 0D                    or      al,0Dh
F000:5124  [+0x05124]  0E                       push    cs
F000:5125  [+0x05125]  11 12                    adc     [bp+si],dx
F000:5127  [+0x05127]  1A 1B                    sbb     bl,[bp+di]
F000:5129  [+0x05129]  1C 13                    sbb     al,13h
F000:512B  [+0x0512B]  14 15                    adc     al,15h
F000:512D  [+0x0512D]  16                       push    ss
F000:512E  [+0x0512E]  04 05                    add     al,5
F000:5130  [+0x05130]  06                       push    es
F000:5131  [+0x05131]  07                       pop     es
F000:5132  [+0x05132]  08 09                    or      [bx+di],cl
F000:5134  [+0x05134]  0A 0B                    or      cl,[bp+di]
F000:5136  [+0x05136]  0C 0D                    or      al,0Dh
F000:5138  [+0x05138]  0E                       push    cs
F000:5139  [+0x05139]  11 12                    adc     [bp+si],dx
F000:513B  [+0x0513B]  1A 1B                    sbb     bl,[bp+di]
F000:513D  [+0x0513D]  1C 17                    sbb     al,17h
F000:513F  [+0x0513F]  17                       pop     ss
F000:5140  [+0x05140]  18 18                    sbb     [bx+si],bl
F000:5142  [+0x05142]  04 05                    add     al,5
F000:5144  [+0x05144]  06                       push    es
F000:5145  [+0x05145]  19 08                    sbb     [bx+si],cx
F000:5147  [+0x05147]  09 0A                    or      [bp+si],cx
F000:5149  [+0x05149]  0B 0C                    or      cx,[si]
F000:514B  [+0x0514B]  0D 0E 11                 or      ax,110Eh
F000:514E  [+0x0514E]  12 1A                    adc     bl,[bp+si]
F000:5150  [+0x05150]  1B 1C                    sbb     bx,[si]
F000:5152  [+0x05152]  B9 02 00                 mov     cx,2
F000:5155  [+0x05155]  F6 06 89 04 10           test    byte [489h],10h
F000:515A  [+0x0515A]  75 19                    jne     short 5175h
F000:515C  [+0x0515C]  FE C9                    dec     cl
F000:515E  [+0x0515E]  8A 26 88 04              mov     ah,[488h]
F000:5162  [+0x05162]  80 E4 0F                 and     ah,0Fh
F000:5165  [+0x05165]  80 FC 03                 cmp     ah,3
F000:5168  [+0x05168]  74 0B                    je      short 5175h
F000:516A  [+0x0516A]  80 FC 09                 cmp     ah,9
F000:516D  [+0x0516D]  74 06                    je      short 5175h
F000:516F  [+0x0516F]  3C 07                    cmp     al,7
F000:5171  [+0x05171]  74 02                    je      short 5175h
F000:5173  [+0x05173]  FE C9                    dec     cl
F000:5175  [+0x05175]  C3                       ret
F000:5176  [+0x05176]  A0 49 04                 mov     al,[449h]
F000:5179  [+0x05179]  50                       push    ax
F000:517A  [+0x0517A]  53                       push    bx
F000:517B  [+0x0517B]  51                       push    cx
F000:517C  [+0x0517C]  3C 13                    cmp     al,13h
F000:517E  [+0x0517E]  76 0B                    jbe     short 518Bh
F000:5180  [+0x05180]  E8 98 C6                 call    181Bh
F000:5183  [+0x05183]  75 06                    jne     short 518Bh
F000:5185  [+0x05185]  8C C8                    mov     ax,cs
F000:5187  [+0x05187]  8E C0                    mov     es,ax
F000:5189  [+0x05189]  EB 21                    jmp     short 51ACh
F000:518B  [+0x0518B]  E8 C4 FF                 call    5152h
F000:518E  [+0x0518E]  BE 16 51                 mov     si,5116h
F000:5191  [+0x05191]  E3 05                    jcxz    5198h
F000:5193  [+0x05193]  83 C6 14                 add     si,14h
F000:5196  [+0x05196]  E2 FB                    loop    5193h
F000:5198  [+0x05198]  8A D8                    mov     bl,al
F000:519A  [+0x0519A]  32 FF                    xor     bh,bh
F000:519C  [+0x0519C]  2E 8A 00                 mov     al,[cs:bx+si]
F000:519F  [+0x0519F]  B4 40                    mov     ah,40h
F000:51A1  [+0x051A1]  F6 E4                    mul     ah
F000:51A3  [+0x051A3]  8B F0                    mov     si,ax
F000:51A5  [+0x051A5]  33 DB                    xor     bx,bx
F000:51A7  [+0x051A7]  E8 30 E1                 call    32DAh
F000:51AA  [+0x051AA]  03 F3                    add     si,bx
F000:51AC  [+0x051AC]  59                       pop     cx
F000:51AD  [+0x051AD]  5B                       pop     bx
F000:51AE  [+0x051AE]  58                       pop     ax
F000:51AF  [+0x051AF]  C3                       ret
F000:51B0  [+0x051B0]  87 DB                    xchg    bx,bx
F000:51B2  [+0x051B2]  51                       push    cx
F000:51B3  [+0x051B3]  52                       push    dx
F000:51B4  [+0x051B4]  E8 00 01                 call    52B7h
F000:51B7  [+0x051B7]  E8 0C 00                 call    51C6h
F000:51BA  [+0x051BA]  E8 6B C2                 call    1428h
F000:51BD  [+0x051BD]  E8 19 C2                 call    13D9h
F000:51C0  [+0x051C0]  E8 FC 00                 call    52BFh
F000:51C3  [+0x051C3]  5A                       pop     dx
F000:51C4  [+0x051C4]  59                       pop     cx
F000:51C5  [+0x051C5]  C3                       ret
F000:51C6  [+0x051C6]  51                       push    cx
F000:51C7  [+0x051C7]  52                       push    dx
F000:51C8  [+0x051C8]  B9 19 00                 mov     cx,19h
F000:51CB  [+0x051CB]  B8 00 00                 mov     ax,0
F000:51CE  [+0x051CE]  51                       push    cx
F000:51CF  [+0x051CF]  50                       push    ax
F000:51D0  [+0x051D0]  B9 05 00                 mov     cx,5
F000:51D3  [+0x051D3]  03 F1                    add     si,cx
F000:51D5  [+0x051D5]  B8 00 01                 mov     ax,100h
F000:51D8  [+0x051D8]  BA C4 03                 mov     dx,3C4h
F000:51DB  [+0x051DB]  9C                       pushf
F000:51DC  [+0x051DC]  FA                       cli
F000:51DD  [+0x051DD]  EF                       out     dx,ax
F000:51DE  [+0x051DE]  FE C0                    inc     al
F000:51E0  [+0x051E0]  26 8A 24                 mov     ah,[es:si]
F000:51E3  [+0x051E3]  46                       inc     si
F000:51E4  [+0x051E4]  E2 F7                    loop    51DDh
F000:51E6  [+0x051E6]  8A C4                    mov     al,ah
F000:51E8  [+0x051E8]  BA C2 03                 mov     dx,3C2h
F000:51EB  [+0x051EB]  EE                       out     dx,al
F000:51EC  [+0x051EC]  BA B4 03                 mov     dx,3B4h
F000:51EF  [+0x051EF]  A8 01                    test    al,1
F000:51F1  [+0x051F1]  74 03                    je      short 51F6h
F000:51F3  [+0x051F3]  BA D4 03                 mov     dx,3D4h
F000:51F6  [+0x051F6]  89 16 63 04              mov     [463h],dx
F000:51FA  [+0x051FA]  B8 00 03                 mov     ax,300h
F000:51FD  [+0x051FD]  BA C4 03                 mov     dx,3C4h
F000:5200  [+0x05200]  EF                       out     dx,ax
F000:5201  [+0x05201]  9D                       popf
F000:5202  [+0x05202]  8B 16 63 04              mov     dx,[463h]
F000:5206  [+0x05206]  B8 11 00                 mov     ax,11h
F000:5209  [+0x05209]  EF                       out     dx,ax
F000:520A  [+0x0520A]  58                       pop     ax
F000:520B  [+0x0520B]  59                       pop     cx
F000:520C  [+0x0520C]  03 F0                    add     si,ax
F000:520E  [+0x0520E]  26 8A 24                 mov     ah,[es:si]
F000:5211  [+0x05211]  46                       inc     si
F000:5212  [+0x05212]  EF                       out     dx,ax
F000:5213  [+0x05213]  FE C0                    inc     al
F000:5215  [+0x05215]  E2 F7                    loop    520Eh
F000:5217  [+0x05217]  83 C2 06                 add     dx,6
F000:521A  [+0x0521A]  EC                       in      al,dx
F000:521B  [+0x0521B]  52                       push    dx
F000:521C  [+0x0521C]  32 E4                    xor     ah,ah
F000:521E  [+0x0521E]  B9 10 00                 mov     cx,10h
F000:5221  [+0x05221]  BA C0 03                 mov     dx,3C0h
F000:5224  [+0x05224]  F6 06 89 04 08           test    byte [489h],8
F000:5229  [+0x05229]  75 0A                    jne     short 5235h
F000:522B  [+0x0522B]  8A C4                    mov     al,ah
F000:522D  [+0x0522D]  EE                       out     dx,al
F000:522E  [+0x0522E]  FE C4                    inc     ah
F000:5230  [+0x05230]  26 AC                    es lodsb
F000:5232  [+0x05232]  EE                       out     dx,al
F000:5233  [+0x05233]  E2 F6                    loop    522Bh
F000:5235  [+0x05235]  02 E1                    add     ah,cl
F000:5237  [+0x05237]  03 F1                    add     si,cx
F000:5239  [+0x05239]  B9 05 00                 mov     cx,5
F000:523C  [+0x0523C]  80 FC 11                 cmp     ah,11h
F000:523F  [+0x0523F]  75 09                    jne     short 524Ah
F000:5241  [+0x05241]  46                       inc     si
F000:5242  [+0x05242]  F6 06 89 04 08           test    byte [489h],8
F000:5247  [+0x05247]  75 10                    jne     short 5259h
F000:5249  [+0x05249]  4E                       dec     si
F000:524A  [+0x0524A]  8A C4                    mov     al,ah
F000:524C  [+0x0524C]  EE                       out     dx,al
F000:524D  [+0x0524D]  EB 00                    jmp     short 524Fh
F000:524F  [+0x0524F]  32 C0                    xor     al,al
F000:5251  [+0x05251]  80 FC 14                 cmp     ah,14h
F000:5254  [+0x05254]  74 02                    je      short 5258h
F000:5256  [+0x05256]  26 AC                    es lodsb
F000:5258  [+0x05258]  EE                       out     dx,al
F000:5259  [+0x05259]  FE C4                    inc     ah
F000:525B  [+0x0525B]  E2 DF                    loop    523Ch
F000:525D  [+0x0525D]  5A                       pop     dx
F000:525E  [+0x0525E]  EC                       in      al,dx
F000:525F  [+0x0525F]  32 C0                    xor     al,al
F000:5261  [+0x05261]  BA CC 03                 mov     dx,3CCh
F000:5264  [+0x05264]  EE                       out     dx,al
F000:5265  [+0x05265]  FE C0                    inc     al
F000:5267  [+0x05267]  BA CA 03                 mov     dx,3CAh
F000:526A  [+0x0526A]  EE                       out     dx,al
F000:526B  [+0x0526B]  32 C0                    xor     al,al
F000:526D  [+0x0526D]  B9 09 00                 mov     cx,9
F000:5270  [+0x05270]  BA CE 03                 mov     dx,3CEh
F000:5273  [+0x05273]  26 8A 24                 mov     ah,[es:si]
F000:5276  [+0x05276]  46                       inc     si
F000:5277  [+0x05277]  EF                       out     dx,ax
F000:5278  [+0x05278]  FE C0                    inc     al
F000:527A  [+0x0527A]  E2 F7                    loop    5273h
F000:527C  [+0x0527C]  5A                       pop     dx
F000:527D  [+0x0527D]  59                       pop     cx
F000:527E  [+0x0527E]  C3                       ret
F000:527F  [+0x0527F]  9C                       pushf
F000:5280  [+0x05280]  FA                       cli
F000:5281  [+0x05281]  BA C7 03                 mov     dx,3C7h
F000:5284  [+0x05284]  8A C3                    mov     al,bl
F000:5286  [+0x05286]  EE                       out     dx,al
F000:5287  [+0x05287]  EB 00                    jmp     short 5289h
F000:5289  [+0x05289]  83 C2 02                 add     dx,2
F000:528C  [+0x0528C]  EC                       in      al,dx
F000:528D  [+0x0528D]  EB 00                    jmp     short 528Fh
F000:528F  [+0x0528F]  8A E0                    mov     ah,al
F000:5291  [+0x05291]  EC                       in      al,dx
F000:5292  [+0x05292]  EB 00                    jmp     short 5294h
F000:5294  [+0x05294]  8A E8                    mov     ch,al
F000:5296  [+0x05296]  EC                       in      al,dx
F000:5297  [+0x05297]  8A C8                    mov     cl,al
F000:5299  [+0x05299]  43                       inc     bx
F000:529A  [+0x0529A]  9D                       popf
F000:529B  [+0x0529B]  C3                       ret
F000:529C  [+0x0529C]  9C                       pushf
F000:529D  [+0x0529D]  FA                       cli
F000:529E  [+0x0529E]  BA C8 03                 mov     dx,3C8h
F000:52A1  [+0x052A1]  8A C3                    mov     al,bl
F000:52A3  [+0x052A3]  EE                       out     dx,al
F000:52A4  [+0x052A4]  EB 00                    jmp     short 52A6h
F000:52A6  [+0x052A6]  42                       inc     dx
F000:52A7  [+0x052A7]  8A C4                    mov     al,ah
F000:52A9  [+0x052A9]  EE                       out     dx,al
F000:52AA  [+0x052AA]  EB 00                    jmp     short 52ACh
F000:52AC  [+0x052AC]  8A C5                    mov     al,ch
F000:52AE  [+0x052AE]  EE                       out     dx,al
F000:52AF  [+0x052AF]  EB 00                    jmp     short 52B1h
F000:52B1  [+0x052B1]  8A C1                    mov     al,cl
F000:52B3  [+0x052B3]  EE                       out     dx,al
F000:52B4  [+0x052B4]  43                       inc     bx
F000:52B5  [+0x052B5]  9D                       popf
F000:52B6  [+0x052B6]  C3                       ret
F000:52B7  [+0x052B7]  51                       push    cx
F000:52B8  [+0x052B8]  B1 20                    mov     cl,20h
F000:52BA  [+0x052BA]  E8 0A 00                 call    52C7h
F000:52BD  [+0x052BD]  59                       pop     cx
F000:52BE  [+0x052BE]  C3                       ret
F000:52BF  [+0x052BF]  51                       push    cx
F000:52C0  [+0x052C0]  B1 00                    mov     cl,0
F000:52C2  [+0x052C2]  E8 02 00                 call    52C7h
F000:52C5  [+0x052C5]  59                       pop     cx
F000:52C6  [+0x052C6]  C3                       ret
F000:52C7  [+0x052C7]  50                       push    ax
F000:52C8  [+0x052C8]  52                       push    dx
F000:52C9  [+0x052C9]  BA C4 03                 mov     dx,3C4h
F000:52CC  [+0x052CC]  9C                       pushf
F000:52CD  [+0x052CD]  FA                       cli
F000:52CE  [+0x052CE]  EC                       in      al,dx
F000:52CF  [+0x052CF]  50                       push    ax
F000:52D0  [+0x052D0]  B0 01                    mov     al,1
F000:52D2  [+0x052D2]  E8 C9 FD                 call    509Eh
F000:52D5  [+0x052D5]  80 E4 DF                 and     ah,0DFh
F000:52D8  [+0x052D8]  0A E1                    or      ah,cl
F000:52DA  [+0x052DA]  EF                       out     dx,ax
F000:52DB  [+0x052DB]  58                       pop     ax
F000:52DC  [+0x052DC]  EE                       out     dx,al
F000:52DD  [+0x052DD]  9D                       popf
F000:52DE  [+0x052DE]  5A                       pop     dx
F000:52DF  [+0x052DF]  58                       pop     ax
F000:52E0  [+0x052E0]  C3                       ret
F000:52E1  [+0x052E1]  E8 D3 FF                 call    52B7h
F000:52E4  [+0x052E4]  BE 00 01                 mov     si,100h
F000:52E7  [+0x052E7]  33 DB                    xor     bx,bx
F000:52E9  [+0x052E9]  32 E4                    xor     ah,ah
F000:52EB  [+0x052EB]  33 C9                    xor     cx,cx
F000:52ED  [+0x052ED]  E8 AC FF                 call    529Ch
F000:52F0  [+0x052F0]  4E                       dec     si
F000:52F1  [+0x052F1]  75 FA                    jne     short 52EDh
F000:52F3  [+0x052F3]  E8 C9 FF                 call    52BFh
F000:52F6  [+0x052F6]  C3                       ret
F000:52F7  [+0x052F7]  F6 06 89 04 08           test    byte [489h],8
F000:52FC  [+0x052FC]  74 01                    je      short 52FFh
F000:52FE  [+0x052FE]  C3                       ret
F000:52FF  [+0x052FF]  BA C6 03                 mov     dx,3C6h
F000:5302  [+0x05302]  EC                       in      al,dx
F000:5303  [+0x05303]  FE C0                    inc     al
F000:5305  [+0x05305]  74 03                    je      short 530Ah
F000:5307  [+0x05307]  B0 FF                    mov     al,0FFh
F000:5309  [+0x05309]  EE                       out     dx,al
F000:530A  [+0x0530A]  BF 40 00                 mov     di,40h
F000:530D  [+0x0530D]  33 DB                    xor     bx,bx
F000:530F  [+0x0530F]  A0 49 04                 mov     al,[449h]
F000:5312  [+0x05312]  3C 07                    cmp     al,7
F000:5314  [+0x05314]  74 78                    je      short 538Eh
F000:5316  [+0x05316]  3C 0F                    cmp     al,0Fh
F000:5318  [+0x05318]  74 74                    je      short 538Eh
F000:531A  [+0x0531A]  3C 13                    cmp     al,13h
F000:531C  [+0x0531C]  72 19                    jb      short 5337h
F000:531E  [+0x0531E]  75 03                    jne     short 5323h
F000:5320  [+0x05320]  E9 AF 00                 jmp     53D2h
F000:5323  [+0x05323]  8A E0                    mov     ah,al
F000:5325  [+0x05325]  E8 E6 C4                 call    180Eh
F000:5328  [+0x05328]  86 E0                    xchg    ah,al
F000:532A  [+0x0532A]  F6 C4 02                 test    ah,2
F000:532D  [+0x0532D]  74 5F                    je      short 538Eh
F000:532F  [+0x0532F]  F6 C4 04                 test    ah,4
F000:5332  [+0x05332]  74 2D                    je      short 5361h
F000:5334  [+0x05334]  E9 9B 00                 jmp     53D2h
F000:5337  [+0x05337]  3C 04                    cmp     al,4
F000:5339  [+0x05339]  72 0E                    jb      short 5349h
F000:533B  [+0x0533B]  3C 06                    cmp     al,6
F000:533D  [+0x0533D]  76 2B                    jbe     short 536Ah
F000:533F  [+0x0533F]  3C 08                    cmp     al,8
F000:5341  [+0x05341]  74 1E                    je      short 5361h
F000:5343  [+0x05343]  3C 0E                    cmp     al,0Eh
F000:5345  [+0x05345]  76 23                    jbe     short 536Ah
F000:5347  [+0x05347]  EB 18                    jmp     short 5361h
F000:5349  [+0x05349]  F6 06 89 04 10           test    byte [489h],10h
F000:534E  [+0x0534E]  75 11                    jne     short 5361h
F000:5350  [+0x05350]  8A 26 88 04              mov     ah,[488h]
F000:5354  [+0x05354]  80 E4 0F                 and     ah,0Fh
F000:5357  [+0x05357]  80 FC 03                 cmp     ah,3
F000:535A  [+0x0535A]  74 05                    je      short 5361h
F000:535C  [+0x0535C]  80 FC 09                 cmp     ah,9
F000:535F  [+0x0535F]  75 09                    jne     short 536Ah
F000:5361  [+0x05361]  F6 06 89 04 06           test    byte [489h],6
F000:5366  [+0x05366]  75 41                    jne     short 53A9h
F000:5368  [+0x05368]  EB 5A                    jmp     short 53C4h
F000:536A  [+0x0536A]  F6 06 89 04 06           test    byte [489h],6
F000:536F  [+0x0536F]  74 43                    je      short 53B4h
F000:5371  [+0x05371]  B7 07                    mov     bh,7
F000:5373  [+0x05373]  8B D3                    mov     dx,bx
F000:5375  [+0x05375]  BE CE 7E                 mov     si,7ECEh
F000:5378  [+0x05378]  E8 01 01                 call    547Ch
F000:537B  [+0x0537B]  F6 C2 08                 test    dl,8
F000:537E  [+0x0537E]  75 F8                    jne     short 5378h
F000:5380  [+0x05380]  83 C6 08                 add     si,8
F000:5383  [+0x05383]  F6 C2 10                 test    dl,10h
F000:5386  [+0x05386]  75 F0                    jne     short 5378h
F000:5388  [+0x05388]  80 FA 20                 cmp     dl,20h
F000:538B  [+0x0538B]  74 E8                    je      short 5375h
F000:538D  [+0x0538D]  C3                       ret
F000:538E  [+0x0538E]  B7 00                    mov     bh,0
F000:5390  [+0x05390]  8B D3                    mov     dx,bx
F000:5392  [+0x05392]  BE 42 7F                 mov     si,7F42h
F000:5395  [+0x05395]  E8 E4 00                 call    547Ch
F000:5398  [+0x05398]  F6 C2 07                 test    dl,7
F000:539B  [+0x0539B]  75 F8                    jne     short 5395h
F000:539D  [+0x0539D]  80 FA 20                 cmp     dl,20h
F000:53A0  [+0x053A0]  74 F0                    je      short 5392h
F000:53A2  [+0x053A2]  46                       inc     si
F000:53A3  [+0x053A3]  80 FA 40                 cmp     dl,40h
F000:53A6  [+0x053A6]  75 ED                    jne     short 5395h
F000:53A8  [+0x053A8]  C3                       ret
F000:53A9  [+0x053A9]  B7 3F                    mov     bh,3Fh
F000:53AB  [+0x053AB]  8B D3                    mov     dx,bx
F000:53AD  [+0x053AD]  BE 02 7F                 mov     si,7F02h
F000:53B0  [+0x053B0]  E8 C9 00                 call    547Ch
F000:53B3  [+0x053B3]  C3                       ret
F000:53B4  [+0x053B4]  B7 88                    mov     bh,88h
F000:53B6  [+0x053B6]  8B D3                    mov     dx,bx
F000:53B8  [+0x053B8]  BF C9 7E                 mov     di,7EC9h
F000:53BB  [+0x053BB]  BE BA 7E                 mov     si,7EBAh
F000:53BE  [+0x053BE]  E8 70 00                 call    5431h
F000:53C1  [+0x053C1]  74 F5                    je      short 53B8h
F000:53C3  [+0x053C3]  C3                       ret
F000:53C4  [+0x053C4]  8B D3                    mov     dx,bx
F000:53C6  [+0x053C6]  BF FD 7E                 mov     di,7EFDh
F000:53C9  [+0x053C9]  BE DE 7E                 mov     si,7EDEh
F000:53CC  [+0x053CC]  E8 62 00                 call    5431h
F000:53CF  [+0x053CF]  74 F8                    je      short 53C9h
F000:53D1  [+0x053D1]  C3                       ret
F000:53D2  [+0x053D2]  F6 06 89 04 06           test    byte [489h],6
F000:53D7  [+0x053D7]  75 14                    jne     short 53EDh
F000:53D9  [+0x053D9]  BF C9 7E                 mov     di,7EC9h
F000:53DC  [+0x053DC]  BE BA 7E                 mov     si,7EBAh
F000:53DF  [+0x053DF]  8B D3                    mov     dx,bx
F000:53E1  [+0x053E1]  E8 6D 00                 call    5451h
F000:53E4  [+0x053E4]  03 F2                    add     si,dx
F000:53E6  [+0x053E6]  F6 C2 08                 test    dl,8
F000:53E9  [+0x053E9]  75 F6                    jne     short 53E1h
F000:53EB  [+0x053EB]  EB 0A                    jmp     short 53F7h
F000:53ED  [+0x053ED]  B7 0F                    mov     bh,0Fh
F000:53EF  [+0x053EF]  8B D3                    mov     dx,bx
F000:53F1  [+0x053F1]  BE CE 7E                 mov     si,7ECEh
F000:53F4  [+0x053F4]  E8 85 00                 call    547Ch
F000:53F7  [+0x053F7]  B6 1F                    mov     dh,1Fh
F000:53F9  [+0x053F9]  8B DA                    mov     bx,dx
F000:53FB  [+0x053FB]  BE 3A 7F                 mov     si,7F3Ah
F000:53FE  [+0x053FE]  E8 7B 00                 call    547Ch
F000:5401  [+0x05401]  BF 09 00                 mov     di,9
F000:5404  [+0x05404]  BB 20 00                 mov     bx,20h
F000:5407  [+0x05407]  BE 5A 7F                 mov     si,7F5Ah
F000:540A  [+0x0540A]  BA 10 04                 mov     dx,410h
F000:540D  [+0x0540D]  57                       push    di
F000:540E  [+0x0540E]  BF 92 1B                 mov     di,1B92h
F000:5411  [+0x05411]  E8 7D 00                 call    5491h
F000:5414  [+0x05414]  52                       push    dx
F000:5415  [+0x05415]  F6 06 89 04 06           test    byte [489h],6
F000:541A  [+0x0541A]  74 03                    je      short 541Fh
F000:541C  [+0x0541C]  E8 55 F0                 call    4474h
F000:541F  [+0x0541F]  E8 7A FE                 call    529Ch
F000:5422  [+0x05422]  5A                       pop     dx
F000:5423  [+0x05423]  81 FA 10 04              cmp     dx,410h
F000:5427  [+0x05427]  75 E8                    jne     short 5411h
F000:5429  [+0x05429]  83 C6 05                 add     si,5
F000:542C  [+0x0542C]  5F                       pop     di
F000:542D  [+0x0542D]  4F                       dec     di
F000:542E  [+0x0542E]  75 DD                    jne     short 540Dh
F000:5430  [+0x05430]  C3                       ret
F000:5431  [+0x05431]  E8 1D 00                 call    5451h
F000:5434  [+0x05434]  F6 C2 18                 test    dl,18h
F000:5437  [+0x05437]  74 14                    je      short 544Dh
F000:5439  [+0x05439]  F6 C6 80                 test    dh,80h
F000:543C  [+0x0543C]  74 08                    je      short 5446h
F000:543E  [+0x0543E]  84 D6                    test    dh,dl
F000:5440  [+0x05440]  74 06                    je      short 5448h
F000:5442  [+0x05442]  4F                       dec     di
F000:5443  [+0x05443]  4F                       dec     di
F000:5444  [+0x05444]  EB EB                    jmp     short 5431h
F000:5446  [+0x05446]  4F                       dec     di
F000:5447  [+0x05447]  4F                       dec     di
F000:5448  [+0x05448]  83 C6 08                 add     si,8
F000:544B  [+0x0544B]  EB E4                    jmp     short 5431h
F000:544D  [+0x0544D]  80 FA 20                 cmp     dl,20h
F000:5450  [+0x05450]  C3                       ret
F000:5451  [+0x05451]  47                       inc     di
F000:5452  [+0x05452]  2E 8A 25                 mov     ah,[cs:di]
F000:5455  [+0x05455]  D0 E3                    shl     bl,1
F000:5457  [+0x05457]  32 FF                    xor     bh,bh
F000:5459  [+0x05459]  2E 8B 08                 mov     cx,[cs:bx+si]
F000:545C  [+0x0545C]  F6 C5 40                 test    ch,40h
F000:545F  [+0x0545F]  74 09                    je      short 546Ah
F000:5461  [+0x05461]  F6 C2 04                 test    dl,4
F000:5464  [+0x05464]  74 04                    je      short 546Ah
F000:5466  [+0x05466]  2E 8A 6D 01              mov     ch,[cs:di+1]
F000:546A  [+0x0546A]  8B DA                    mov     bx,dx
F000:546C  [+0x0546C]  E8 2D FE                 call    529Ch
F000:546F  [+0x0546F]  8B D3                    mov     dx,bx
F000:5471  [+0x05471]  80 E3 03                 and     bl,3
F000:5474  [+0x05474]  75 DF                    jne     short 5455h
F000:5476  [+0x05476]  F6 C2 04                 test    dl,4
F000:5479  [+0x05479]  75 D6                    jne     short 5451h
F000:547B  [+0x0547B]  C3                       ret
F000:547C  [+0x0547C]  32 FF                    xor     bh,bh
F000:547E  [+0x0547E]  2E 8A 20                 mov     ah,[cs:bx+si]
F000:5481  [+0x05481]  8B DA                    mov     bx,dx
F000:5483  [+0x05483]  8A CC                    mov     cl,ah
F000:5485  [+0x05485]  8A E9                    mov     ch,cl
F000:5487  [+0x05487]  E8 12 FE                 call    529Ch
F000:548A  [+0x0548A]  8B D3                    mov     dx,bx
F000:548C  [+0x0548C]  22 DF                    and     bl,bh
F000:548E  [+0x0548E]  75 EC                    jne     short 547Ch
F000:5490  [+0x05490]  C3                       ret
F000:5491  [+0x05491]  53                       push    bx
F000:5492  [+0x05492]  8B CF                    mov     cx,di
F000:5494  [+0x05494]  FE CB                    dec     bl
F000:5496  [+0x05496]  F6 C3 03                 test    bl,3
F000:5499  [+0x05499]  75 06                    jne     short 54A1h
F000:549B  [+0x0549B]  D0 C9                    ror     cl,1
F000:549D  [+0x0549D]  D0 C5                    rol     ch,1
F000:549F  [+0x0549F]  8B F9                    mov     di,cx
F000:54A1  [+0x054A1]  22 E9                    and     ch,cl
F000:54A3  [+0x054A3]  B8 01 00                 mov     ax,1
F000:54A6  [+0x054A6]  80 E1 06                 and     cl,6
F000:54A9  [+0x054A9]  D0 E1                    shl     cl,1
F000:54AB  [+0x054AB]  D3 E0                    shl     ax,cl
F000:54AD  [+0x054AD]  80 E5 07                 and     ch,7
F000:54B0  [+0x054B0]  74 04                    je      short 54B6h
F000:54B2  [+0x054B2]  2B D0                    sub     dx,ax
F000:54B4  [+0x054B4]  EB 02                    jmp     short 54B8h
F000:54B6  [+0x054B6]  03 D0                    add     dx,ax
F000:54B8  [+0x054B8]  8A DA                    mov     bl,dl
F000:54BA  [+0x054BA]  80 E3 07                 and     bl,7
F000:54BD  [+0x054BD]  2E 8A 20                 mov     ah,[cs:bx+si]
F000:54C0  [+0x054C0]  8A DA                    mov     bl,dl
F000:54C2  [+0x054C2]  83 E3 70                 and     bx,70h
F000:54C5  [+0x054C5]  B1 04                    mov     cl,4
F000:54C7  [+0x054C7]  D2 EB                    shr     bl,cl
F000:54C9  [+0x054C9]  2E 8A 28                 mov     ch,[cs:bx+si]
F000:54CC  [+0x054CC]  8B DA                    mov     bx,dx
F000:54CE  [+0x054CE]  81 E3 00 07              and     bx,700h
F000:54D2  [+0x054D2]  D0 E1                    shl     cl,1
F000:54D4  [+0x054D4]  D3 EB                    shr     bx,cl
F000:54D6  [+0x054D6]  2E 8A 08                 mov     cl,[cs:bx+si]
F000:54D9  [+0x054D9]  5B                       pop     bx
F000:54DA  [+0x054DA]  C3                       ret
F000:54DB  [+0x054DB]  50                       push    ax
F000:54DC  [+0x054DC]  53                       push    bx
F000:54DD  [+0x054DD]  51                       push    cx
F000:54DE  [+0x054DE]  52                       push    dx
F000:54DF  [+0x054DF]  57                       push    di
F000:54E0  [+0x054E0]  56                       push    si
F000:54E1  [+0x054E1]  1E                       push    ds
F000:54E2  [+0x054E2]  06                       push    es
F000:54E3  [+0x054E3]  E8 D0 FB                 call    50B6h
F000:54E6  [+0x054E6]  52                       push    dx
F000:54E7  [+0x054E7]  BA C4 03                 mov     dx,3C4h
F000:54EA  [+0x054EA]  B8 02 04                 mov     ax,402h
F000:54ED  [+0x054ED]  EF                       out     dx,ax
F000:54EE  [+0x054EE]  B8 04 07                 mov     ax,704h
F000:54F1  [+0x054F1]  EF                       out     dx,ax
F000:54F2  [+0x054F2]  BA CE 03                 mov     dx,3CEh
F000:54F5  [+0x054F5]  B8 04 02                 mov     ax,204h
F000:54F8  [+0x054F8]  EF                       out     dx,ax
F000:54F9  [+0x054F9]  B8 05 00                 mov     ax,5
F000:54FC  [+0x054FC]  EF                       out     dx,ax
F000:54FD  [+0x054FD]  B8 06 04                 mov     ax,406h
F000:5500  [+0x05500]  EF                       out     dx,ax
F000:5501  [+0x05501]  5A                       pop     dx
F000:5502  [+0x05502]  53                       push    bx
F000:5503  [+0x05503]  A0 49 04                 mov     al,[449h]
F000:5506  [+0x05506]  50                       push    ax
F000:5507  [+0x05507]  E8 DB 00                 call    55E5h
F000:550A  [+0x0550A]  58                       pop     ax
F000:550B  [+0x0550B]  BA 20 00                 mov     dx,20h
F000:550E  [+0x0550E]  2A D7                    sub     dl,bh
F000:5510  [+0x05510]  E3 58                    jcxz    556Ah
F000:5512  [+0x05512]  E8 31 B7                 call    0C46h
F000:5515  [+0x05515]  74 4E                    je      short 5565h
F000:5517  [+0x05517]  80 FF 0E                 cmp     bh,0Eh
F000:551A  [+0x0551A]  74 05                    je      short 5521h
F000:551C  [+0x0551C]  80 FF 10                 cmp     bh,10h
F000:551F  [+0x0551F]  75 44                    jne     short 5565h
F000:5521  [+0x05521]  E8 10 BD                 call    1234h
F000:5524  [+0x05524]  75 3F                    jne     short 5565h
F000:5526  [+0x05526]  80 FF 10                 cmp     bh,10h
F000:5529  [+0x05529]  75 02                    jne     short 552Dh
F000:552B  [+0x0552B]  EB 38                    jmp     short 5565h
F000:552D  [+0x0552D]  55                       push    bp
F000:552E  [+0x0552E]  83 EC 01                 sub     sp,1
F000:5531  [+0x05531]  8B EC                    mov     bp,sp
F000:5533  [+0x05533]  C6 46 00 00              mov     byte [bp],0
F000:5537  [+0x05537]  53                       push    bx
F000:5538  [+0x05538]  E8 06 BD                 call    1241h
F000:553B  [+0x0553B]  08 7E 00                 or      [bp],bh
F000:553E  [+0x0553E]  5B                       pop     bx
F000:553F  [+0x0553F]  80 7E 00 00              cmp     byte [bp],0
F000:5543  [+0x05543]  75 1C                    jne     short 5561h
F000:5545  [+0x05545]  E8 42 00                 call    558Ah
F000:5548  [+0x05548]  B0 57                    mov     al,57h
F000:554A  [+0x0554A]  E8 56 FB                 call    50A3h
F000:554D  [+0x0554D]  80 E4 EF                 and     ah,0EFh
F000:5550  [+0x05550]  80 CC 04                 or      ah,4
F000:5553  [+0x05553]  E8 53 FB                 call    50A9h
F000:5556  [+0x05556]  33 C0                    xor     ax,ax
F000:5558  [+0x05558]  83 C4 01                 add     sp,1
F000:555B  [+0x0555B]  5D                       pop     bp
F000:555C  [+0x0555C]  5B                       pop     bx
F000:555D  [+0x0555D]  07                       pop     es
F000:555E  [+0x0555E]  1F                       pop     ds
F000:555F  [+0x0555F]  EB 19                    jmp     short 557Ah
F000:5561  [+0x05561]  83 C4 01                 add     sp,1
F000:5564  [+0x05564]  5D                       pop     bp
F000:5565  [+0x05565]  E8 22 00                 call    558Ah
F000:5568  [+0x05568]  3A C0                    cmp     al,al
F000:556A  [+0x0556A]  5B                       pop     bx
F000:556B  [+0x0556B]  07                       pop     es
F000:556C  [+0x0556C]  1F                       pop     ds
F000:556D  [+0x0556D]  74 05                    je      short 5574h
F000:556F  [+0x0556F]  E8 C2 BC                 call    1234h
F000:5572  [+0x05572]  74 03                    je      short 5577h
F000:5574  [+0x05574]  E8 20 00                 call    5597h
F000:5577  [+0x05577]  E8 DE BC                 call    1258h
F000:557A  [+0x0557A]  E8 93 00                 call    5610h
F000:557D  [+0x0557D]  E8 30 FB                 call    50B0h
F000:5580  [+0x05580]  5E                       pop     si
F000:5581  [+0x05581]  5F                       pop     di
F000:5582  [+0x05582]  5A                       pop     dx
F000:5583  [+0x05583]  59                       pop     cx
F000:5584  [+0x05584]  5B                       pop     bx
F000:5585  [+0x05585]  58                       pop     ax
F000:5586  [+0x05586]  C3                       ret
F000:5587  [+0x05587]  87 DB                    xchg    bx,bx
F000:5589  [+0x05589]  90                       nop
F000:558A  [+0x0558A]  51                       push    cx
F000:558B  [+0x0558B]  8A CF                    mov     cl,bh
F000:558D  [+0x0558D]  32 ED                    xor     ch,ch
F000:558F  [+0x0558F]  F3 A4                    rep movsb
F000:5591  [+0x05591]  03 FA                    add     di,dx
F000:5593  [+0x05593]  59                       pop     cx
F000:5594  [+0x05594]  E2 F4                    loop    558Ah
F000:5596  [+0x05596]  C3                       ret
F000:5597  [+0x05597]  50                       push    ax
F000:5598  [+0x05598]  51                       push    cx
F000:5599  [+0x05599]  57                       push    di
F000:559A  [+0x0559A]  56                       push    si
F000:559B  [+0x0559B]  06                       push    es
F000:559C  [+0x0559C]  B9 00 A0                 mov     cx,0A000h
F000:559F  [+0x0559F]  8E C1                    mov     es,cx
F000:55A1  [+0x055A1]  F6 C3 C0                 test    bl,0C0h
F000:55A4  [+0x055A4]  74 36                    je      short 55DCh
F000:55A6  [+0x055A6]  B0 55                    mov     al,55h
F000:55A8  [+0x055A8]  E8 81 CA                 call    202Ch
F000:55AB  [+0x055AB]  F6 C4 04                 test    ah,4
F000:55AE  [+0x055AE]  75 2C                    jne     short 55DCh
F000:55B0  [+0x055B0]  B9 07 00                 mov     cx,7
F000:55B3  [+0x055B3]  BE 54 6C                 mov     si,6C54h
F000:55B6  [+0x055B6]  F6 C3 80                 test    bl,80h
F000:55B9  [+0x055B9]  75 05                    jne     short 55C0h
F000:55BB  [+0x055BB]  BE 64 7D                 mov     si,7D64h
F000:55BE  [+0x055BE]  B1 08                    mov     cl,8
F000:55C0  [+0x055C0]  2E 8A 24                 mov     ah,[cs:si]
F000:55C3  [+0x055C3]  46                       inc     si
F000:55C4  [+0x055C4]  0A E4                    or      ah,ah
F000:55C6  [+0x055C6]  74 14                    je      short 55DCh
F000:55C8  [+0x055C8]  32 C0                    xor     al,al
F000:55CA  [+0x055CA]  D1 E8                    shr     ax,1
F000:55CC  [+0x055CC]  D1 E8                    shr     ax,1
F000:55CE  [+0x055CE]  D1 E8                    shr     ax,1
F000:55D0  [+0x055D0]  8B F8                    mov     di,ax
F000:55D2  [+0x055D2]  51                       push    cx
F000:55D3  [+0x055D3]  9C                       pushf
F000:55D4  [+0x055D4]  FA                       cli
F000:55D5  [+0x055D5]  F3 2E A5                 cs rep movsw
F000:55D8  [+0x055D8]  9D                       popf
F000:55D9  [+0x055D9]  59                       pop     cx
F000:55DA  [+0x055DA]  EB E4                    jmp     short 55C0h
F000:55DC  [+0x055DC]  0B C9                    or      cx,cx
F000:55DE  [+0x055DE]  07                       pop     es
F000:55DF  [+0x055DF]  5E                       pop     si
F000:55E0  [+0x055E0]  5F                       pop     di
F000:55E1  [+0x055E1]  59                       pop     cx
F000:55E2  [+0x055E2]  58                       pop     ax
F000:55E3  [+0x055E3]  C3                       ret
F000:55E4  [+0x055E4]  C3                       ret
F000:55E5  [+0x055E5]  8C C0                    mov     ax,es
F000:55E7  [+0x055E7]  8E D8                    mov     ds,ax
F000:55E9  [+0x055E9]  B8 00 A0                 mov     ax,0A000h
F000:55EC  [+0x055EC]  8E C0                    mov     es,ax
F000:55EE  [+0x055EE]  80 E3 07                 and     bl,7
F000:55F1  [+0x055F1]  D0 CB                    ror     bl,1
F000:55F3  [+0x055F3]  D0 CB                    ror     bl,1
F000:55F5  [+0x055F5]  D0 DB                    rcr     bl,1
F000:55F7  [+0x055F7]  73 03                    jae     short 55FCh
F000:55F9  [+0x055F9]  80 C3 10                 add     bl,10h
F000:55FC  [+0x055FC]  D0 E3                    shl     bl,1
F000:55FE  [+0x055FE]  8A E3                    mov     ah,bl
F000:5600  [+0x05600]  32 C0                    xor     al,al
F000:5602  [+0x05602]  8B F8                    mov     di,ax
F000:5604  [+0x05604]  0B D2                    or      dx,dx
F000:5606  [+0x05606]  74 07                    je      short 560Fh
F000:5608  [+0x05608]  B8 20 00                 mov     ax,20h
F000:560B  [+0x0560B]  F7 E2                    mul     dx
F000:560D  [+0x0560D]  03 F8                    add     di,ax
F000:560F  [+0x0560F]  C3                       ret
F000:5610  [+0x05610]  BA C4 03                 mov     dx,3C4h
F000:5613  [+0x05613]  B8 02 03                 mov     ax,302h
F000:5616  [+0x05616]  EF                       out     dx,ax
F000:5617  [+0x05617]  B8 04 03                 mov     ax,304h
F000:561A  [+0x0561A]  EF                       out     dx,ax
F000:561B  [+0x0561B]  BA CE 03                 mov     dx,3CEh
F000:561E  [+0x0561E]  B8 04 00                 mov     ax,4
F000:5621  [+0x05621]  EF                       out     dx,ax
F000:5622  [+0x05622]  B8 05 10                 mov     ax,1005h
F000:5625  [+0x05625]  EF                       out     dx,ax
F000:5626  [+0x05626]  B8 06 0A                 mov     ax,0A06h
F000:5629  [+0x05629]  81 3E 63 04 B4 03        cmp     word [463h],3B4h
F000:562F  [+0x0562F]  74 02                    je      short 5633h
F000:5631  [+0x05631]  B4 0E                    mov     ah,0Eh
F000:5633  [+0x05633]  EF                       out     dx,ax
F000:5634  [+0x05634]  C3                       ret
F000:5635  [+0x05635]  B3 00                    mov     bl,0
F000:5637  [+0x05637]  2E 8E 1E 79 26           mov     ds,[cs:2679h]
F000:563C  [+0x0563C]  B9 44 2C                 mov     cx,2C44h
F000:563F  [+0x0563F]  80 FB 02                 cmp     bl,2
F000:5642  [+0x05642]  2E 8E 1E 77 26           mov     ds,[cs:2677h]
F000:5647  [+0x05647]  C3                       ret
F000:5648  [+0x05648]  00 00                    add     [bx+si],al
F000:564A  [+0x0564A]  00 00                    add     [bx+si],al
F000:564C  [+0x0564C]  00 00                    add     [bx+si],al
F000:564E  [+0x0564E]  00 00                    add     [bx+si],al
F000:5650  [+0x05650]  00 00                    add     [bx+si],al
F000:5652  [+0x05652]  00 00                    add     [bx+si],al
F000:5654  [+0x05654]  00 00                    add     [bx+si],al
F000:5656  [+0x05656]  00 00                    add     [bx+si],al
F000:5658  [+0x05658]  00 00                    add     [bx+si],al
F000:565A  [+0x0565A]  00 00                    add     [bx+si],al
F000:565C  [+0x0565C]  7E 81                    jle     short 55DFh
F000:565E  [+0x0565E]  A5                       movsw
F000:565F  [+0x0565F]  81 BD 99 81 7E 7E        cmp     word [di-7E67h],7E7Eh
F000:5665  [+0x05665]  DB 0xFF  (bad)
F000:5667  [+0x05667]  FF C3                    inc     bx
F000:5669  [+0x05669]  E7 FF                    out     0FFh,ax
F000:566B  [+0x0566B]  7E 6C                    jle     short 56D9h
F000:566D  [+0x0566D]  DB 0xFE  (bad)
F000:566F  [+0x0566F]  DB 0xFE  (bad)
F000:5671  [+0x05671]  38 10                    cmp     [bx+si],dl
F000:5673  [+0x05673]  00 10                    add     [bx+si],dl
F000:5675  [+0x05675]  38 7C FE                 cmp     [si-2],bh
F000:5678  [+0x05678]  7C 38                    jl      short 56B2h
F000:567A  [+0x0567A]  10 00                    adc     [bx+si],al
F000:567C  [+0x0567C]  38 7C 38                 cmp     [si+38h],bh
F000:567F  [+0x0567F]  DB 0xFE  (bad)
F000:5681  [+0x05681]  92                       xchg    dx,ax
F000:5682  [+0x05682]  10 7C 00                 adc     [si],bh
F000:5685  [+0x05685]  10 38                    adc     [bx+si],bh
F000:5687  [+0x05687]  7C FE                    jl      short 5687h
F000:5689  [+0x05689]  7C 38                    jl      short 56C3h
F000:568B  [+0x0568B]  7C 00                    jl      short 568Dh
F000:568D  [+0x0568D]  00 18                    add     [bx+si],bl
F000:568F  [+0x0568F]  3C 3C                    cmp     al,3Ch
F000:5691  [+0x05691]  18 00                    sbb     [bx+si],al
F000:5693  [+0x05693]  00 FF                    add     bh,bh
F000:5695  [+0x05695]  FF E7                    jmp     di
F000:5697  [+0x05697]  C3                       ret
F000:5698  [+0x05698]  C3                       ret
F000:5699  [+0x05699]  E7 FF                    out     0FFh,ax
F000:569B  [+0x0569B]  FF 00                    inc     word [bx+si]
F000:569D  [+0x0569D]  3C 66                    cmp     al,66h
F000:569F  [+0x0569F]  42                       inc     dx
F000:56A0  [+0x056A0]  42                       inc     dx
F000:56A1  [+0x056A1]  66 3C 00                 cmp     al,0
F000:56A4  [+0x056A4]  FF C3                    inc     bx
F000:56A6  [+0x056A6]  99                       cwd
F000:56A7  [+0x056A7]  BD BD 99                 mov     bp,99BDh
F000:56AA  [+0x056AA]  C3                       ret
F000:56AB  [+0x056AB]  FF 0F                    dec     word [bx]
F000:56AD  [+0x056AD]  07                       pop     es
F000:56AE  [+0x056AE]  DB 0x0F  (bad)
F000:56B1  [+0x056B1]  CC                       int3
F000:56B2  [+0x056B2]  CC                       int3
F000:56B3  [+0x056B3]  78 3C                    js      short 56F1h
F000:56B5  [+0x056B5]  66 66 66 3C 18           cmp     al,18h
F000:56BA  [+0x056BA]  7E 18                    jle     short 56D4h
F000:56BC  [+0x056BC]  3F                       aas
F000:56BD  [+0x056BD]  33 3F                    xor     di,[bx]
F000:56BF  [+0x056BF]  30 30                    xor     [bx+si],dh
F000:56C1  [+0x056C1]  70 F0                    jo      short 56B3h
F000:56C3  [+0x056C3]  E0 7F                    loopne  5744h
F000:56C5  [+0x056C5]  63 7F 63                 arpl    [bx+63h],di
F000:56C8  [+0x056C8]  63 67 E6                 arpl    [bx-1Ah],sp
F000:56CB  [+0x056CB]  C0 99 5A 3C E7           rcr     byte [bx+di+3C5Ah],0E7h
F000:56D0  [+0x056D0]  E7 3C                    out     3Ch,ax
F000:56D2  [+0x056D2]  5A                       pop     dx
F000:56D3  [+0x056D3]  99                       cwd
F000:56D4  [+0x056D4]  80 E0 F8                 and     al,0F8h
F000:56D7  [+0x056D7]  DB 0xFE  (bad)
F000:56D9  [+0x056D9]  E0 80                    loopne  565Bh
F000:56DB  [+0x056DB]  00 02                    add     [bp+si],al
F000:56DD  [+0x056DD]  0E                       push    cs
F000:56DE  [+0x056DE]  DB 0x3E  (bad)
F000:56E1  [+0x056E1]  0E                       push    cs
F000:56E2  [+0x056E2]  02 00                    add     al,[bx+si]
F000:56E4  [+0x056E4]  18 3C                    sbb     [si],bh
F000:56E6  [+0x056E6]  7E 18                    jle     short 5700h
F000:56E8  [+0x056E8]  18 7E 3C                 sbb     [bp+3Ch],bh
F000:56EB  [+0x056EB]  18 66 66                 sbb     [bp+66h],ah
F000:56EE  [+0x056EE]  66 66 66 00 66 00        add     [bp],ah
F000:56F4  [+0x056F4]  7F DB                    jg      short 56D1h
F000:56F6  [+0x056F6]  DB 7B 1B                 fstp    tword [bp+di+1Bh]
F000:56F9  [+0x056F9]  1B 1B                    sbb     bx,[bp+di]
F000:56FB  [+0x056FB]  00 3E 63 38              add     [3863h],bh
F000:56FF  [+0x056FF]  6C                       insb
F000:5700  [+0x05700]  6C                       insb
F000:5701  [+0x05701]  38 86 FC 00              cmp     [bp+0FCh],al
F000:5705  [+0x05705]  00 00                    add     [bx+si],al
F000:5707  [+0x05707]  00 7E 7E                 add     [bp+7Eh],bh
F000:570A  [+0x0570A]  7E 00                    jle     short 570Ch
F000:570C  [+0x0570C]  18 3C                    sbb     [si],bh
F000:570E  [+0x0570E]  7E 18                    jle     short 5728h
F000:5710  [+0x05710]  7E 3C                    jle     short 574Eh
F000:5712  [+0x05712]  18 FF                    sbb     bh,bh
F000:5714  [+0x05714]  18 3C                    sbb     [si],bh
F000:5716  [+0x05716]  7E 18                    jle     short 5730h
F000:5718  [+0x05718]  18 18                    sbb     [bx+si],bl
F000:571A  [+0x0571A]  18 00                    sbb     [bx+si],al
F000:571C  [+0x0571C]  18 18                    sbb     [bx+si],bl
F000:571E  [+0x0571E]  18 18                    sbb     [bx+si],bl
F000:5720  [+0x05720]  7E 3C                    jle     short 575Eh
F000:5722  [+0x05722]  18 00                    sbb     [bx+si],al
F000:5724  [+0x05724]  00 18                    add     [bx+si],bl
F000:5726  [+0x05726]  0C FE                    or      al,0FEh
F000:5728  [+0x05728]  0C 18                    or      al,18h
F000:572A  [+0x0572A]  00 00                    add     [bx+si],al
F000:572C  [+0x0572C]  00 30                    add     [bx+si],dh
F000:572E  [+0x0572E]  60                       pusha
F000:572F  [+0x0572F]  DB 0xFE  (bad)
F000:5731  [+0x05731]  30 00                    xor     [bx+si],al
F000:5733  [+0x05733]  00 00                    add     [bx+si],al
F000:5735  [+0x05735]  00 C0                    add     al,al
F000:5737  [+0x05737]  C0 C0 FE                 rol     al,0FEh
F000:573A  [+0x0573A]  00 00                    add     [bx+si],al
F000:573C  [+0x0573C]  00 24                    add     [si],ah
F000:573E  [+0x0573E]  66 FF 66 24              jmp     dword [bp+24h]
F000:5742  [+0x05742]  00 00                    add     [bx+si],al
F000:5744  [+0x05744]  00 18                    add     [bx+si],bl
F000:5746  [+0x05746]  3C 7E                    cmp     al,7Eh
F000:5748  [+0x05748]  DB 0xFF  (bad)
F000:574A  [+0x0574A]  00 00                    add     [bx+si],al
F000:574C  [+0x0574C]  00 FF                    add     bh,bh
F000:574E  [+0x0574E]  DB 0xFF  (bad)
F000:5750  [+0x05750]  3C 18                    cmp     al,18h
F000:5752  [+0x05752]  00 00                    add     [bx+si],al
F000:5754  [+0x05754]  00 00                    add     [bx+si],al
F000:5756  [+0x05756]  00 00                    add     [bx+si],al
F000:5758  [+0x05758]  00 00                    add     [bx+si],al
F000:575A  [+0x0575A]  00 00                    add     [bx+si],al
F000:575C  [+0x0575C]  18 3C                    sbb     [si],bh
F000:575E  [+0x0575E]  3C 18                    cmp     al,18h
F000:5760  [+0x05760]  18 00                    sbb     [bx+si],al
F000:5762  [+0x05762]  18 00                    sbb     [bx+si],al
F000:5764  [+0x05764]  6C                       insb
F000:5765  [+0x05765]  6C                       insb
F000:5766  [+0x05766]  6C                       insb
F000:5767  [+0x05767]  00 00                    add     [bx+si],al
F000:5769  [+0x05769]  00 00                    add     [bx+si],al
F000:576B  [+0x0576B]  00 6C 6C                 add     [si+6Ch],ch
F000:576E  [+0x0576E]  DB 0xFE  (bad)
F000:5770  [+0x05770]  DB 0xFE  (bad)
F000:5772  [+0x05772]  6C                       insb
F000:5773  [+0x05773]  00 18                    add     [bx+si],bl
F000:5775  [+0x05775]  7E C0                    jle     short 5737h
F000:5777  [+0x05777]  7C 06                    jl      short 577Fh
F000:5779  [+0x05779]  FC                       cld
F000:577A  [+0x0577A]  18 00                    sbb     [bx+si],al
F000:577C  [+0x0577C]  00 C6                    add     dh,al
F000:577E  [+0x0577E]  CC                       int3
F000:577F  [+0x0577F]  18 30                    sbb     [bx+si],dh
F000:5781  [+0x05781]  66 C6 00 38              mov     byte [bx+si],38h
F000:5785  [+0x05785]  6C                       insb
F000:5786  [+0x05786]  38 76 DC                 cmp     [bp-24h],dh
F000:5789  [+0x05789]  CC                       int3
F000:578A  [+0x0578A]  76 00                    jbe     short 578Ch
F000:578C  [+0x0578C]  30 30                    xor     [bx+si],dh
F000:578E  [+0x0578E]  60                       pusha
F000:578F  [+0x0578F]  00 00                    add     [bx+si],al
F000:5791  [+0x05791]  00 00                    add     [bx+si],al
F000:5793  [+0x05793]  00 18                    add     [bx+si],bl
F000:5795  [+0x05795]  30 60 60                 xor     [bx+si+60h],ah
F000:5798  [+0x05798]  60                       pusha
F000:5799  [+0x05799]  30 18                    xor     [bx+si],bl
F000:579B  [+0x0579B]  00 60 30                 add     [bx+si+30h],ah
F000:579E  [+0x0579E]  18 18                    sbb     [bx+si],bl
F000:57A0  [+0x057A0]  18 30                    sbb     [bx+si],dh
F000:57A2  [+0x057A2]  60                       pusha
F000:57A3  [+0x057A3]  00 00                    add     [bx+si],al
F000:57A5  [+0x057A5]  66 3C FF                 cmp     al,0FFh
F000:57A8  [+0x057A8]  3C 66                    cmp     al,66h
F000:57AA  [+0x057AA]  00 00                    add     [bx+si],al
F000:57AC  [+0x057AC]  00 18                    add     [bx+si],bl
F000:57AE  [+0x057AE]  18 7E 18                 sbb     [bp+18h],bh
F000:57B1  [+0x057B1]  18 00                    sbb     [bx+si],al
F000:57B3  [+0x057B3]  00 00                    add     [bx+si],al
F000:57B5  [+0x057B5]  00 00                    add     [bx+si],al
F000:57B7  [+0x057B7]  00 00                    add     [bx+si],al
F000:57B9  [+0x057B9]  18 18                    sbb     [bx+si],bl
F000:57BB  [+0x057BB]  30 00                    xor     [bx+si],al
F000:57BD  [+0x057BD]  00 00                    add     [bx+si],al
F000:57BF  [+0x057BF]  7E 00                    jle     short 57C1h
F000:57C1  [+0x057C1]  00 00                    add     [bx+si],al
F000:57C3  [+0x057C3]  00 00                    add     [bx+si],al
F000:57C5  [+0x057C5]  00 00                    add     [bx+si],al
F000:57C7  [+0x057C7]  00 00                    add     [bx+si],al
F000:57C9  [+0x057C9]  18 18                    sbb     [bx+si],bl
F000:57CB  [+0x057CB]  00 06 0C 18              add     [180Ch],al
F000:57CF  [+0x057CF]  30 60 C0                 xor     [bx+si-40h],ah
F000:57D2  [+0x057D2]  80 00 7C                 add     byte [bx+si],7Ch
F000:57D5  [+0x057D5]  DB 0xC6  (bad)
F000:57D7  [+0x057D7]  DE F6                    fdivrp  st6
F000:57D9  [+0x057D9]  E6 7C                    out     7Ch,al
F000:57DB  [+0x057DB]  00 30                    add     [bx+si],dh
F000:57DD  [+0x057DD]  70 30                    jo      short 580Fh
F000:57DF  [+0x057DF]  30 30                    xor     [bx+si],dh
F000:57E1  [+0x057E1]  30 FC                    xor     ah,bh
F000:57E3  [+0x057E3]  00 78 CC                 add     [bx+si-34h],bh
F000:57E6  [+0x057E6]  0C 38                    or      al,38h
F000:57E8  [+0x057E8]  60                       pusha
F000:57E9  [+0x057E9]  CC                       int3
F000:57EA  [+0x057EA]  FC                       cld
F000:57EB  [+0x057EB]  00 78 CC                 add     [bx+si-34h],bh
F000:57EE  [+0x057EE]  0C 38                    or      al,38h
F000:57F0  [+0x057F0]  0C CC                    or      al,0CCh
F000:57F2  [+0x057F2]  78 00                    js      short 57F4h
F000:57F4  [+0x057F4]  1C 3C                    sbb     al,3Ch
F000:57F6  [+0x057F6]  6C                       insb
F000:57F7  [+0x057F7]  CC                       int3
F000:57F8  [+0x057F8]  FE 0C                    dec     byte [si]
F000:57FA  [+0x057FA]  1E                       push    ds
F000:57FB  [+0x057FB]  00 FC                    add     ah,bh
F000:57FD  [+0x057FD]  C0 F8 0C                 sar     al,0Ch
F000:5800  [+0x05800]  0C CC                    or      al,0CCh
F000:5802  [+0x05802]  78 00                    js      short 5804h
F000:5804  [+0x05804]  38 60 C0                 cmp     [bx+si-40h],ah
F000:5807  [+0x05807]  F8                       clc
F000:5808  [+0x05808]  CC                       int3
F000:5809  [+0x05809]  CC                       int3
F000:580A  [+0x0580A]  78 00                    js      short 580Ch
F000:580C  [+0x0580C]  FC                       cld
F000:580D  [+0x0580D]  CC                       int3
F000:580E  [+0x0580E]  0C 18                    or      al,18h
F000:5810  [+0x05810]  30 30                    xor     [bx+si],dh
F000:5812  [+0x05812]  30 00                    xor     [bx+si],al
F000:5814  [+0x05814]  78 CC                    js      short 57E2h
F000:5816  [+0x05816]  CC                       int3
F000:5817  [+0x05817]  78 CC                    js      short 57E5h
F000:5819  [+0x05819]  CC                       int3
F000:581A  [+0x0581A]  78 00                    js      short 581Ch
F000:581C  [+0x0581C]  78 CC                    js      short 57EAh
F000:581E  [+0x0581E]  CC                       int3
F000:581F  [+0x0581F]  7C 0C                    jl      short 582Dh
F000:5821  [+0x05821]  18 70 00                 sbb     [bx+si],dh
F000:5824  [+0x05824]  00 18                    add     [bx+si],bl
F000:5826  [+0x05826]  18 00                    sbb     [bx+si],al
F000:5828  [+0x05828]  00 18                    add     [bx+si],bl
F000:582A  [+0x0582A]  18 00                    sbb     [bx+si],al
F000:582C  [+0x0582C]  00 18                    add     [bx+si],bl
F000:582E  [+0x0582E]  18 00                    sbb     [bx+si],al
F000:5830  [+0x05830]  00 18                    add     [bx+si],bl
F000:5832  [+0x05832]  18 30                    sbb     [bx+si],dh
F000:5834  [+0x05834]  18 30                    sbb     [bx+si],dh
F000:5836  [+0x05836]  60                       pusha
F000:5837  [+0x05837]  C0 60 30 18              shl     byte [bx+si+30h],18h
F000:583B  [+0x0583B]  00 00                    add     [bx+si],al
F000:583D  [+0x0583D]  00 7E 00                 add     [bp],bh
F000:5840  [+0x05840]  7E 00                    jle     short 5842h
F000:5842  [+0x05842]  00 00                    add     [bx+si],al
F000:5844  [+0x05844]  60                       pusha
F000:5845  [+0x05845]  30 18                    xor     [bx+si],bl
F000:5847  [+0x05847]  0C 18                    or      al,18h
F000:5849  [+0x05849]  30 60 00                 xor     [bx+si],ah
F000:584C  [+0x0584C]  3C 66                    cmp     al,66h
F000:584E  [+0x0584E]  0C 18                    or      al,18h
F000:5850  [+0x05850]  18 00                    sbb     [bx+si],al
F000:5852  [+0x05852]  18 00                    sbb     [bx+si],al
F000:5854  [+0x05854]  7C C6                    jl      short 581Ch
F000:5856  [+0x05856]  DB 0xDE  (bad)
F000:5859  [+0x05859]  C0 7C 00 30              sar     byte [si],30h
F000:585D  [+0x0585D]  78 CC                    js      short 582Bh
F000:585F  [+0x0585F]  CC                       int3
F000:5860  [+0x05860]  FC                       cld
F000:5861  [+0x05861]  CC                       int3
F000:5862  [+0x05862]  CC                       int3
F000:5863  [+0x05863]  00 FC                    add     ah,bh
F000:5865  [+0x05865]  66 66 7C 66              o32 jl  short 000058CFh
F000:5869  [+0x05869]  66 FC                    cld
F000:586B  [+0x0586B]  00 3C                    add     [si],bh
F000:586D  [+0x0586D]  66 C0 C0 C0              rol     al,0C0h
F000:5871  [+0x05871]  66 3C 00                 cmp     al,0
F000:5874  [+0x05874]  F8                       clc
F000:5875  [+0x05875]  6C                       insb
F000:5876  [+0x05876]  66 66 66 6C              insb
F000:587A  [+0x0587A]  F8                       clc
F000:587B  [+0x0587B]  00 FE                    add     dh,bh
F000:587D  [+0x0587D]  62 68 78                 bound   bp,[bx+si+78h]
F000:5880  [+0x05880]  68 62 FE                 push    0FE62h
F000:5883  [+0x05883]  00 FE                    add     dh,bh
F000:5885  [+0x05885]  62 68 78                 bound   bp,[bx+si+78h]
F000:5888  [+0x05888]  68 60 F0                 push    0F060h
F000:588B  [+0x0588B]  00 3C                    add     [si],bh
F000:588D  [+0x0588D]  66 C0 C0 CE              rol     al,0CEh
F000:5891  [+0x05891]  66 3A 00                 cmp     al,[bx+si]
F000:5894  [+0x05894]  CC                       int3
F000:5895  [+0x05895]  CC                       int3
F000:5896  [+0x05896]  CC                       int3
F000:5897  [+0x05897]  FC                       cld
F000:5898  [+0x05898]  CC                       int3
F000:5899  [+0x05899]  CC                       int3
F000:589A  [+0x0589A]  CC                       int3
F000:589B  [+0x0589B]  00 78 30                 add     [bx+si+30h],bh
F000:589E  [+0x0589E]  30 30                    xor     [bx+si],dh
F000:58A0  [+0x058A0]  30 30                    xor     [bx+si],dh
F000:58A2  [+0x058A2]  78 00                    js      short 58A4h
F000:58A4  [+0x058A4]  1E                       push    ds
F000:58A5  [+0x058A5]  0C 0C                    or      al,0Ch
F000:58A7  [+0x058A7]  0C CC                    or      al,0CCh
F000:58A9  [+0x058A9]  CC                       int3
F000:58AA  [+0x058AA]  78 00                    js      short 58ACh
F000:58AC  [+0x058AC]  E6 66                    out     66h,al
F000:58AE  [+0x058AE]  6C                       insb
F000:58AF  [+0x058AF]  78 6C                    js      short 591Dh
F000:58B1  [+0x058B1]  66 E6 00                 out     0,al
F000:58B4  [+0x058B4]  DB 0xF0  (bad)
F000:58B6  [+0x058B6]  60                       pusha
F000:58B7  [+0x058B7]  60                       pusha
F000:58B8  [+0x058B8]  62 66 FE                 bound   sp,[bp-2]
F000:58BB  [+0x058BB]  00 C6                    add     dh,al
F000:58BD  [+0x058BD]  EE                       out     dx,al
F000:58BE  [+0x058BE]  DB 0xFE  (bad)
F000:58C0  [+0x058C0]  D6                       salc
F000:58C1  [+0x058C1]  C6 C6 00                 mov     dh,0
F000:58C4  [+0x058C4]  DB 0xC6  (bad)
F000:58C6  [+0x058C6]  F6 DE                    neg     dh
F000:58C8  [+0x058C8]  CE                       into
F000:58C9  [+0x058C9]  C6 C6 00                 mov     dh,0
F000:58CC  [+0x058CC]  38 6C C6                 cmp     [si-3Ah],ch
F000:58CF  [+0x058CF]  C6 C6 6C                 mov     dh,6Ch
F000:58D2  [+0x058D2]  38 00                    cmp     [bx+si],al
F000:58D4  [+0x058D4]  FC                       cld
F000:58D5  [+0x058D5]  66 66 7C 60              o32 jl  short 00005939h
F000:58D9  [+0x058D9]  60                       pusha
F000:58DA  [+0x058DA]  F0 00 7C C6              lock add [si-3Ah],bh
F000:58DE  [+0x058DE]  C6 C6 D6                 mov     dh,0D6h
F000:58E1  [+0x058E1]  7C 0E                    jl      short 58F1h
F000:58E3  [+0x058E3]  00 FC                    add     ah,bh
F000:58E5  [+0x058E5]  66 66 7C 6C              o32 jl  short 00005955h
F000:58E9  [+0x058E9]  66 E6 00                 out     0,al
F000:58EC  [+0x058EC]  7C C6                    jl      short 58B4h
F000:58EE  [+0x058EE]  E0 78                    loopne  5968h
F000:58F0  [+0x058F0]  0E                       push    cs
F000:58F1  [+0x058F1]  DB 0xC6  (bad)
F000:58F3  [+0x058F3]  00 FC                    add     ah,bh
F000:58F5  [+0x058F5]  B4 30                    mov     ah,30h
F000:58F7  [+0x058F7]  30 30                    xor     [bx+si],dh
F000:58F9  [+0x058F9]  30 78 00                 xor     [bx+si],bh
F000:58FC  [+0x058FC]  CC                       int3
F000:58FD  [+0x058FD]  CC                       int3
F000:58FE  [+0x058FE]  CC                       int3
F000:58FF  [+0x058FF]  CC                       int3
F000:5900  [+0x05900]  CC                       int3
F000:5901  [+0x05901]  CC                       int3
F000:5902  [+0x05902]  FC                       cld
F000:5903  [+0x05903]  00 CC                    add     ah,cl
F000:5905  [+0x05905]  CC                       int3
F000:5906  [+0x05906]  CC                       int3
F000:5907  [+0x05907]  CC                       int3
F000:5908  [+0x05908]  CC                       int3
F000:5909  [+0x05909]  78 30                    js      short 593Bh
F000:590B  [+0x0590B]  00 C6                    add     dh,al
F000:590D  [+0x0590D]  C6 C6 C6                 mov     dh,0C6h
F000:5910  [+0x05910]  D6                       salc
F000:5911  [+0x05911]  DB 0xFE  (bad)
F000:5913  [+0x05913]  00 C6                    add     dh,al
F000:5915  [+0x05915]  DB 0xC6  (bad)
F000:5917  [+0x05917]  38 6C C6                 cmp     [si-3Ah],ch
F000:591A  [+0x0591A]  C6 00 CC                 mov     byte [bx+si],0CCh
F000:591D  [+0x0591D]  CC                       int3
F000:591E  [+0x0591E]  CC                       int3
F000:591F  [+0x0591F]  78 30                    js      short 5951h
F000:5921  [+0x05921]  30 78 00                 xor     [bx+si],bh
F000:5924  [+0x05924]  FE C6                    inc     dh
F000:5926  [+0x05926]  8C 18                    mov     [bx+si],ds
F000:5928  [+0x05928]  32 66 FE                 xor     ah,[bp-2]
F000:592B  [+0x0592B]  00 78 60                 add     [bx+si+60h],bh
F000:592E  [+0x0592E]  60                       pusha
F000:592F  [+0x0592F]  60                       pusha
F000:5930  [+0x05930]  60                       pusha
F000:5931  [+0x05931]  60                       pusha
F000:5932  [+0x05932]  78 00                    js      short 5934h
F000:5934  [+0x05934]  C0 60 30 18              shl     byte [bx+si+30h],18h
F000:5938  [+0x05938]  0C 06                    or      al,6
F000:593A  [+0x0593A]  02 00                    add     al,[bx+si]
F000:593C  [+0x0593C]  78 18                    js      short 5956h
F000:593E  [+0x0593E]  18 18                    sbb     [bx+si],bl
F000:5940  [+0x05940]  18 18                    sbb     [bx+si],bl
F000:5942  [+0x05942]  78 00                    js      short 5944h
F000:5944  [+0x05944]  10 38                    adc     [bx+si],bh
F000:5946  [+0x05946]  6C                       insb
F000:5947  [+0x05947]  C6 00 00                 mov     byte [bx+si],0
F000:594A  [+0x0594A]  00 00                    add     [bx+si],al
F000:594C  [+0x0594C]  00 00                    add     [bx+si],al
F000:594E  [+0x0594E]  00 00                    add     [bx+si],al
F000:5950  [+0x05950]  00 00                    add     [bx+si],al
F000:5952  [+0x05952]  00 FF                    add     bh,bh
F000:5954  [+0x05954]  30 30                    xor     [bx+si],dh
F000:5956  [+0x05956]  18 00                    sbb     [bx+si],al
F000:5958  [+0x05958]  00 00                    add     [bx+si],al
F000:595A  [+0x0595A]  00 00                    add     [bx+si],al
F000:595C  [+0x0595C]  00 00                    add     [bx+si],al
F000:595E  [+0x0595E]  78 0C                    js      short 596Ch
F000:5960  [+0x05960]  7C CC                    jl      short 592Eh
F000:5962  [+0x05962]  76 00                    jbe     short 5964h
F000:5964  [+0x05964]  E0 60                    loopne  59C6h
F000:5966  [+0x05966]  60                       pusha
F000:5967  [+0x05967]  7C 66                    jl      short 59CFh
F000:5969  [+0x05969]  66 DC 00                 fadd    qword [bx+si]
F000:596C  [+0x0596C]  00 00                    add     [bx+si],al
F000:596E  [+0x0596E]  78 CC                    js      short 593Ch
F000:5970  [+0x05970]  C0 CC 78                 ror     ah,78h
F000:5973  [+0x05973]  00 1C                    add     [si],bl
F000:5975  [+0x05975]  0C 0C                    or      al,0Ch
F000:5977  [+0x05977]  7C CC                    jl      short 5945h
F000:5979  [+0x05979]  CC                       int3
F000:597A  [+0x0597A]  76 00                    jbe     short 597Ch
F000:597C  [+0x0597C]  00 00                    add     [bx+si],al
F000:597E  [+0x0597E]  78 CC                    js      short 594Ch
F000:5980  [+0x05980]  FC                       cld
F000:5981  [+0x05981]  C0 78 00 38              sar     byte [bx+si],38h
F000:5985  [+0x05985]  6C                       insb
F000:5986  [+0x05986]  DB 0x64  (bad)
F000:5989  [+0x05989]  60                       pusha
F000:598A  [+0x0598A]  F0 00 00                 lock add [bx+si],al
F000:598D  [+0x0598D]  00 76 CC                 add     [bp-34h],dh
F000:5990  [+0x05990]  CC                       int3
F000:5991  [+0x05991]  7C 0C                    jl      short 599Fh
F000:5993  [+0x05993]  F8                       clc
F000:5994  [+0x05994]  E0 60                    loopne  59F6h
F000:5996  [+0x05996]  6C                       insb
F000:5997  [+0x05997]  76 66                    jbe     short 59FFh
F000:5999  [+0x05999]  66 E6 00                 out     0,al
F000:599C  [+0x0599C]  30 00                    xor     [bx+si],al
F000:599E  [+0x0599E]  70 30                    jo      short 59D0h
F000:59A0  [+0x059A0]  30 30                    xor     [bx+si],dh
F000:59A2  [+0x059A2]  78 00                    js      short 59A4h
F000:59A4  [+0x059A4]  0C 00                    or      al,0
F000:59A6  [+0x059A6]  1C 0C                    sbb     al,0Ch
F000:59A8  [+0x059A8]  0C CC                    or      al,0CCh
F000:59AA  [+0x059AA]  CC                       int3
F000:59AB  [+0x059AB]  78 E0                    js      short 598Dh
F000:59AD  [+0x059AD]  60                       pusha
F000:59AE  [+0x059AE]  66 6C                    insb
F000:59B0  [+0x059B0]  78 6C                    js      short 5A1Eh
F000:59B2  [+0x059B2]  E6 00                    out     0,al
F000:59B4  [+0x059B4]  70 30                    jo      short 59E6h
F000:59B6  [+0x059B6]  30 30                    xor     [bx+si],dh
F000:59B8  [+0x059B8]  30 30                    xor     [bx+si],dh
F000:59BA  [+0x059BA]  78 00                    js      short 59BCh
F000:59BC  [+0x059BC]  00 00                    add     [bx+si],al
F000:59BE  [+0x059BE]  CC                       int3
F000:59BF  [+0x059BF]  DB 0xFE  (bad)
F000:59C1  [+0x059C1]  D6                       salc
F000:59C2  [+0x059C2]  D6                       salc
F000:59C3  [+0x059C3]  00 00                    add     [bx+si],al
F000:59C5  [+0x059C5]  00 B8 CC CC              add     [bx+si-3334h],bh
F000:59C9  [+0x059C9]  CC                       int3
F000:59CA  [+0x059CA]  CC                       int3
F000:59CB  [+0x059CB]  00 00                    add     [bx+si],al
F000:59CD  [+0x059CD]  00 78 CC                 add     [bx+si-34h],bh
F000:59D0  [+0x059D0]  CC                       int3
F000:59D1  [+0x059D1]  CC                       int3
F000:59D2  [+0x059D2]  78 00                    js      short 59D4h
F000:59D4  [+0x059D4]  00 00                    add     [bx+si],al
F000:59D6  [+0x059D6]  DC 66 66                 fsub    qword [bp+66h]
F000:59D9  [+0x059D9]  7C 60                    jl      short 5A3Bh
F000:59DB  [+0x059DB]  F0 00 00                 lock add [bx+si],al
F000:59DE  [+0x059DE]  76 CC                    jbe     short 59ACh
F000:59E0  [+0x059E0]  CC                       int3
F000:59E1  [+0x059E1]  7C 0C                    jl      short 59EFh
F000:59E3  [+0x059E3]  1E                       push    ds
F000:59E4  [+0x059E4]  00 00                    add     [bx+si],al
F000:59E6  [+0x059E6]  DC 76 62                 fdiv    qword [bp+62h]
F000:59E9  [+0x059E9]  60                       pusha
F000:59EA  [+0x059EA]  F0 00 00                 lock add [bx+si],al
F000:59ED  [+0x059ED]  00 7C C0                 add     [si-40h],bh
F000:59F0  [+0x059F0]  70 1C                    jo      short 5A0Eh
F000:59F2  [+0x059F2]  F8                       clc
F000:59F3  [+0x059F3]  00 10                    add     [bx+si],dl
F000:59F5  [+0x059F5]  30 FC                    xor     ah,bh
F000:59F7  [+0x059F7]  30 30                    xor     [bx+si],dh
F000:59F9  [+0x059F9]  34 18                    xor     al,18h
F000:59FB  [+0x059FB]  00 00                    add     [bx+si],al
F000:59FD  [+0x059FD]  00 CC                    add     ah,cl
F000:59FF  [+0x059FF]  CC                       int3
F000:5A00  [+0x05A00]  CC                       int3
F000:5A01  [+0x05A01]  CC                       int3
F000:5A02  [+0x05A02]  76 00                    jbe     short 5A04h
F000:5A04  [+0x05A04]  00 00                    add     [bx+si],al
F000:5A06  [+0x05A06]  CC                       int3
F000:5A07  [+0x05A07]  CC                       int3
F000:5A08  [+0x05A08]  CC                       int3
F000:5A09  [+0x05A09]  78 30                    js      short 5A3Bh
F000:5A0B  [+0x05A0B]  00 00                    add     [bx+si],al
F000:5A0D  [+0x05A0D]  00 C6                    add     dh,al
F000:5A0F  [+0x05A0F]  DB 0xC6  (bad)
F000:5A11  [+0x05A11]  DB 0xFE  (bad)
F000:5A13  [+0x05A13]  00 00                    add     [bx+si],al
F000:5A15  [+0x05A15]  00 C6                    add     dh,al
F000:5A17  [+0x05A17]  6C                       insb
F000:5A18  [+0x05A18]  38 6C C6                 cmp     [si-3Ah],ch
F000:5A1B  [+0x05A1B]  00 00                    add     [bx+si],al
F000:5A1D  [+0x05A1D]  00 CC                    add     ah,cl
F000:5A1F  [+0x05A1F]  CC                       int3
F000:5A20  [+0x05A20]  CC                       int3
F000:5A21  [+0x05A21]  7C 0C                    jl      short 5A2Fh
F000:5A23  [+0x05A23]  F8                       clc
F000:5A24  [+0x05A24]  00 00                    add     [bx+si],al
F000:5A26  [+0x05A26]  FC                       cld
F000:5A27  [+0x05A27]  98                       cbw
F000:5A28  [+0x05A28]  30 64 FC                 xor     [si-4],ah
F000:5A2B  [+0x05A2B]  00 1C                    add     [si],bl
F000:5A2D  [+0x05A2D]  30 30                    xor     [bx+si],dh
F000:5A2F  [+0x05A2F]  E0 30                    loopne  5A61h
F000:5A31  [+0x05A31]  30 1C                    xor     [si],bl
F000:5A33  [+0x05A33]  00 18                    add     [bx+si],bl
F000:5A35  [+0x05A35]  18 18                    sbb     [bx+si],bl
F000:5A37  [+0x05A37]  00 18                    add     [bx+si],bl
F000:5A39  [+0x05A39]  18 18                    sbb     [bx+si],bl
F000:5A3B  [+0x05A3B]  00 E0                    add     al,ah
F000:5A3D  [+0x05A3D]  30 30                    xor     [bx+si],dh
F000:5A3F  [+0x05A3F]  1C 30                    sbb     al,30h
F000:5A41  [+0x05A41]  30 E0                    xor     al,ah
F000:5A43  [+0x05A43]  00 76 DC                 add     [bp-24h],dh
F000:5A46  [+0x05A46]  00 00                    add     [bx+si],al
F000:5A48  [+0x05A48]  00 00                    add     [bx+si],al
F000:5A4A  [+0x05A4A]  00 00                    add     [bx+si],al
F000:5A4C  [+0x05A4C]  00 10                    add     [bx+si],dl
F000:5A4E  [+0x05A4E]  38 6C C6                 cmp     [si-3Ah],ch
F000:5A51  [+0x05A51]  DB 0xC6  (bad)
F000:5A53  [+0x05A53]  00 7C C6                 add     [si-3Ah],bh
F000:5A56  [+0x05A56]  C0 C6 7C                 rol     dh,7Ch
F000:5A59  [+0x05A59]  0C 06                    or      al,6
F000:5A5B  [+0x05A5B]  7C 00                    jl      short 5A5Dh
F000:5A5D  [+0x05A5D]  CC                       int3
F000:5A5E  [+0x05A5E]  00 CC                    add     ah,cl
F000:5A60  [+0x05A60]  CC                       int3
F000:5A61  [+0x05A61]  CC                       int3
F000:5A62  [+0x05A62]  76 00                    jbe     short 5A64h
F000:5A64  [+0x05A64]  1C 00                    sbb     al,0
F000:5A66  [+0x05A66]  78 CC                    js      short 5A34h
F000:5A68  [+0x05A68]  FC                       cld
F000:5A69  [+0x05A69]  C0 78 00 7E              sar     byte [bx+si],7Eh
F000:5A6D  [+0x05A6D]  81 3C 06 3E              cmp     word [si],3E06h
F000:5A71  [+0x05A71]  66 3B 00                 cmp     eax,[bx+si]
F000:5A74  [+0x05A74]  CC                       int3
F000:5A75  [+0x05A75]  00 78 0C                 add     [bx+si+0Ch],bh
F000:5A78  [+0x05A78]  7C CC                    jl      short 5A46h
F000:5A7A  [+0x05A7A]  76 00                    jbe     short 5A7Ch
F000:5A7C  [+0x05A7C]  E0 00                    loopne  5A7Eh
F000:5A7E  [+0x05A7E]  78 0C                    js      short 5A8Ch
F000:5A80  [+0x05A80]  7C CC                    jl      short 5A4Eh
F000:5A82  [+0x05A82]  76 00                    jbe     short 5A84h
F000:5A84  [+0x05A84]  30 30                    xor     [bx+si],dh
F000:5A86  [+0x05A86]  78 0C                    js      short 5A94h
F000:5A88  [+0x05A88]  7C CC                    jl      short 5A56h
F000:5A8A  [+0x05A8A]  76 00                    jbe     short 5A8Ch
F000:5A8C  [+0x05A8C]  00 00                    add     [bx+si],al
F000:5A8E  [+0x05A8E]  7C C6                    jl      short 5A56h
F000:5A90  [+0x05A90]  C0 78 0C 38              sar     byte [bx+si+0Ch],38h
F000:5A94  [+0x05A94]  7E 81                    jle     short 5A17h
F000:5A96  [+0x05A96]  3C 66                    cmp     al,66h
F000:5A98  [+0x05A98]  7E 60                    jle     short 5AFAh
F000:5A9A  [+0x05A9A]  3C 00                    cmp     al,0
F000:5A9C  [+0x05A9C]  CC                       int3
F000:5A9D  [+0x05A9D]  00 78 CC                 add     [bx+si-34h],bh
F000:5AA0  [+0x05AA0]  FC                       cld
F000:5AA1  [+0x05AA1]  C0 78 00 E0              sar     byte [bx+si],0E0h
F000:5AA5  [+0x05AA5]  00 78 CC                 add     [bx+si-34h],bh
F000:5AA8  [+0x05AA8]  FC                       cld
F000:5AA9  [+0x05AA9]  C0 78 00 CC              sar     byte [bx+si],0CCh
F000:5AAD  [+0x05AAD]  00 70 30                 add     [bx+si+30h],dh
F000:5AB0  [+0x05AB0]  30 30                    xor     [bx+si],dh
F000:5AB2  [+0x05AB2]  78 00                    js      short 5AB4h
F000:5AB4  [+0x05AB4]  7C 82                    jl      short 5A38h
F000:5AB6  [+0x05AB6]  38 18                    cmp     [bx+si],bl
F000:5AB8  [+0x05AB8]  18 18                    sbb     [bx+si],bl
F000:5ABA  [+0x05ABA]  3C 00                    cmp     al,0
F000:5ABC  [+0x05ABC]  E0 00                    loopne  5ABEh
F000:5ABE  [+0x05ABE]  70 30                    jo      short 5AF0h
F000:5AC0  [+0x05AC0]  30 30                    xor     [bx+si],dh
F000:5AC2  [+0x05AC2]  78 00                    js      short 5AC4h
F000:5AC4  [+0x05AC4]  DB 0xC6  (bad)
F000:5AC6  [+0x05AC6]  7C C6                    jl      short 5A8Eh
F000:5AC8  [+0x05AC8]  FE C6                    inc     dh
F000:5ACA  [+0x05ACA]  C6 00 30                 mov     byte [bx+si],30h
F000:5ACD  [+0x05ACD]  30 00                    xor     [bx+si],al
F000:5ACF  [+0x05ACF]  78 CC                    js      short 5A9Dh
F000:5AD1  [+0x05AD1]  FC                       cld
F000:5AD2  [+0x05AD2]  CC                       int3
F000:5AD3  [+0x05AD3]  00 1C                    add     [si],bl
F000:5AD5  [+0x05AD5]  00 FC                    add     ah,bh
F000:5AD7  [+0x05AD7]  60                       pusha
F000:5AD8  [+0x05AD8]  78 60                    js      short 5B3Ah
F000:5ADA  [+0x05ADA]  FC                       cld
F000:5ADB  [+0x05ADB]  00 00                    add     [bx+si],al
F000:5ADD  [+0x05ADD]  00 7F 0C                 add     [bx+0Ch],bh
F000:5AE0  [+0x05AE0]  7F CC                    jg      short 5AAEh
F000:5AE2  [+0x05AE2]  7F 00                    jg      short 5AE4h
F000:5AE4  [+0x05AE4]  3E 6C                    insb
F000:5AE6  [+0x05AE6]  CC                       int3
F000:5AE7  [+0x05AE7]  FE CC                    dec     ah
F000:5AE9  [+0x05AE9]  CC                       int3
F000:5AEA  [+0x05AEA]  CE                       into
F000:5AEB  [+0x05AEB]  00 78 84                 add     [bx+si-7Ch],bh
F000:5AEE  [+0x05AEE]  00 78 CC                 add     [bx+si-34h],bh
F000:5AF1  [+0x05AF1]  CC                       int3
F000:5AF2  [+0x05AF2]  78 00                    js      short 5AF4h
F000:5AF4  [+0x05AF4]  00 CC                    add     ah,cl
F000:5AF6  [+0x05AF6]  00 78 CC                 add     [bx+si-34h],bh
F000:5AF9  [+0x05AF9]  CC                       int3
F000:5AFA  [+0x05AFA]  78 00                    js      short 5AFCh
F000:5AFC  [+0x05AFC]  00 E0                    add     al,ah
F000:5AFE  [+0x05AFE]  00 78 CC                 add     [bx+si-34h],bh
F000:5B01  [+0x05B01]  CC                       int3
F000:5B02  [+0x05B02]  78 00                    js      short 5B04h
F000:5B04  [+0x05B04]  78 84                    js      short 5A8Ah
F000:5B06  [+0x05B06]  00 CC                    add     ah,cl
F000:5B08  [+0x05B08]  CC                       int3
F000:5B09  [+0x05B09]  CC                       int3
F000:5B0A  [+0x05B0A]  76 00                    jbe     short 5B0Ch
F000:5B0C  [+0x05B0C]  00 E0                    add     al,ah
F000:5B0E  [+0x05B0E]  00 CC                    add     ah,cl
F000:5B10  [+0x05B10]  CC                       int3
F000:5B11  [+0x05B11]  CC                       int3
F000:5B12  [+0x05B12]  76 00                    jbe     short 5B14h
F000:5B14  [+0x05B14]  00 CC                    add     ah,cl
F000:5B16  [+0x05B16]  00 CC                    add     ah,cl
F000:5B18  [+0x05B18]  CC                       int3
F000:5B19  [+0x05B19]  7C 0C                    jl      short 5B27h
F000:5B1B  [+0x05B1B]  F8                       clc
F000:5B1C  [+0x05B1C]  C3                       ret
F000:5B1D  [+0x05B1D]  18 3C                    sbb     [si],bh
F000:5B1F  [+0x05B1F]  66 66 3C 18              cmp     al,18h
F000:5B23  [+0x05B23]  00 CC                    add     ah,cl
F000:5B25  [+0x05B25]  00 CC                    add     ah,cl
F000:5B27  [+0x05B27]  CC                       int3
F000:5B28  [+0x05B28]  CC                       int3
F000:5B29  [+0x05B29]  CC                       int3
F000:5B2A  [+0x05B2A]  78 00                    js      short 5B2Ch
F000:5B2C  [+0x05B2C]  18 18                    sbb     [bx+si],bl
F000:5B2E  [+0x05B2E]  7E C0                    jle     short 5AF0h
F000:5B30  [+0x05B30]  C0 7E 18 18              sar     byte [bp+18h],18h
F000:5B34  [+0x05B34]  38 6C 64                 cmp     [si+64h],ch
F000:5B37  [+0x05B37]  DB 0xF0  (bad)
F000:5B39  [+0x05B39]  E6 FC                    out     0FCh,al
F000:5B3B  [+0x05B3B]  00 CC                    add     ah,cl
F000:5B3D  [+0x05B3D]  CC                       int3
F000:5B3E  [+0x05B3E]  78 30                    js      short 5B70h
F000:5B40  [+0x05B40]  FC                       cld
F000:5B41  [+0x05B41]  30 FC                    xor     ah,bh
F000:5B43  [+0x05B43]  30 F8                    xor     al,bh
F000:5B45  [+0x05B45]  CC                       int3
F000:5B46  [+0x05B46]  CC                       int3
F000:5B47  [+0x05B47]  FA                       cli
F000:5B48  [+0x05B48]  DB 0xC6  (bad)
F000:5B4A  [+0x05B4A]  C6 C3 0E                 mov     bl,0Eh
F000:5B4D  [+0x05B4D]  1B 18                    sbb     bx,[bx+si]
F000:5B4F  [+0x05B4F]  3C 18                    cmp     al,18h
F000:5B51  [+0x05B51]  18 D8                    sbb     al,bl
F000:5B53  [+0x05B53]  70 1C                    jo      short 5B71h
F000:5B55  [+0x05B55]  00 78 0C                 add     [bx+si+0Ch],bh
F000:5B58  [+0x05B58]  7C CC                    jl      short 5B26h
F000:5B5A  [+0x05B5A]  76 00                    jbe     short 5B5Ch
F000:5B5C  [+0x05B5C]  38 00                    cmp     [bx+si],al
F000:5B5E  [+0x05B5E]  70 30                    jo      short 5B90h
F000:5B60  [+0x05B60]  30 30                    xor     [bx+si],dh
F000:5B62  [+0x05B62]  78 00                    js      short 5B64h
F000:5B64  [+0x05B64]  00 1C                    add     [si],bl
F000:5B66  [+0x05B66]  00 78 CC                 add     [bx+si-34h],bh
F000:5B69  [+0x05B69]  CC                       int3
F000:5B6A  [+0x05B6A]  78 00                    js      short 5B6Ch
F000:5B6C  [+0x05B6C]  00 1C                    add     [si],bl
F000:5B6E  [+0x05B6E]  00 CC                    add     ah,cl
F000:5B70  [+0x05B70]  CC                       int3
F000:5B71  [+0x05B71]  CC                       int3
F000:5B72  [+0x05B72]  76 00                    jbe     short 5B74h
F000:5B74  [+0x05B74]  00 F8                    add     al,bh
F000:5B76  [+0x05B76]  00 B8 CC CC              add     [bx+si-3334h],bh
F000:5B7A  [+0x05B7A]  CC                       int3
F000:5B7B  [+0x05B7B]  00 FC                    add     ah,bh
F000:5B7D  [+0x05B7D]  00 CC                    add     ah,cl
F000:5B7F  [+0x05B7F]  EC                       in      al,dx
F000:5B80  [+0x05B80]  FC                       cld
F000:5B81  [+0x05B81]  DC CC                    fmul    to st4
F000:5B83  [+0x05B83]  00 3C                    add     [si],bh
F000:5B85  [+0x05B85]  6C                       insb
F000:5B86  [+0x05B86]  6C                       insb
F000:5B87  [+0x05B87]  3E 00 7E 00              add     [ds:bp],bh
F000:5B8B  [+0x05B8B]  00 38                    add     [bx+si],bh
F000:5B8D  [+0x05B8D]  6C                       insb
F000:5B8E  [+0x05B8E]  6C                       insb
F000:5B8F  [+0x05B8F]  38 00                    cmp     [bx+si],al
F000:5B91  [+0x05B91]  7C 00                    jl      short 5B93h
F000:5B93  [+0x05B93]  00 18                    add     [bx+si],bl
F000:5B95  [+0x05B95]  00 18                    add     [bx+si],bl
F000:5B97  [+0x05B97]  18 30                    sbb     [bx+si],dh
F000:5B99  [+0x05B99]  66 3C 00                 cmp     al,0
F000:5B9C  [+0x05B9C]  00 00                    add     [bx+si],al
F000:5B9E  [+0x05B9E]  00 FC                    add     ah,bh
F000:5BA0  [+0x05BA0]  C0 C0 00                 rol     al,0
F000:5BA3  [+0x05BA3]  00 00                    add     [bx+si],al
F000:5BA5  [+0x05BA5]  00 00                    add     [bx+si],al
F000:5BA7  [+0x05BA7]  FC                       cld
F000:5BA8  [+0x05BA8]  0C 0C                    or      al,0Ch
F000:5BAA  [+0x05BAA]  00 00                    add     [bx+si],al
F000:5BAC  [+0x05BAC]  DB 0xC6  (bad)
F000:5BAE  [+0x05BAE]  D8 36 6B C2              fdiv    dword [0C26Bh]
F000:5BB2  [+0x05BB2]  84 0F                    test    [bx],cl
F000:5BB4  [+0x05BB4]  C3                       ret
F000:5BB5  [+0x05BB5]  DB 0xC6  (bad)
F000:5BB7  [+0x05BB7]  DB 0xDB  (bad)
F000:5BB9  [+0x05BB9]  6D                       insw
F000:5BBA  [+0x05BBA]  CF                       iret
F000:5BBB  [+0x05BBB]  03 18                    add     bx,[bx+si]
F000:5BBD  [+0x05BBD]  00 18                    add     [bx+si],bl
F000:5BBF  [+0x05BBF]  18 3C                    sbb     [si],bh
F000:5BC1  [+0x05BC1]  3C 18                    cmp     al,18h
F000:5BC3  [+0x05BC3]  00 00                    add     [bx+si],al
F000:5BC5  [+0x05BC5]  33 66 CC                 xor     sp,[bp-34h]
F000:5BC8  [+0x05BC8]  66 33 00                 xor     eax,[bx+si]
F000:5BCB  [+0x05BCB]  00 00                    add     [bx+si],al
F000:5BCD  [+0x05BCD]  CC                       int3
F000:5BCE  [+0x05BCE]  66 33 66 CC              xor     esp,[bp-34h]
F000:5BD2  [+0x05BD2]  00 00                    add     [bx+si],al
F000:5BD4  [+0x05BD4]  22 88 22 88              and     cl,[bx+si-77DEh]
F000:5BD8  [+0x05BD8]  22 88 22 88              and     cl,[bx+si-77DEh]
F000:5BDC  [+0x05BDC]  55                       push    bp
F000:5BDD  [+0x05BDD]  AA                       stosb
F000:5BDE  [+0x05BDE]  55                       push    bp
F000:5BDF  [+0x05BDF]  AA                       stosb
F000:5BE0  [+0x05BE0]  55                       push    bp
F000:5BE1  [+0x05BE1]  AA                       stosb
F000:5BE2  [+0x05BE2]  55                       push    bp
F000:5BE3  [+0x05BE3]  AA                       stosb
F000:5BE4  [+0x05BE4]  DB F6                    fcomi   st6
F000:5BE6  [+0x05BE6]  DB 6F DB                 fld     tword [bx-25h]
F000:5BE9  [+0x05BE9]  7E D7                    jle     short 5BC2h
F000:5BEB  [+0x05BEB]  ED                       in      ax,dx
F000:5BEC  [+0x05BEC]  18 18                    sbb     [bx+si],bl
F000:5BEE  [+0x05BEE]  18 18                    sbb     [bx+si],bl
F000:5BF0  [+0x05BF0]  18 18                    sbb     [bx+si],bl
F000:5BF2  [+0x05BF2]  18 18                    sbb     [bx+si],bl
F000:5BF4  [+0x05BF4]  18 18                    sbb     [bx+si],bl
F000:5BF6  [+0x05BF6]  18 18                    sbb     [bx+si],bl
F000:5BF8  [+0x05BF8]  F8                       clc
F000:5BF9  [+0x05BF9]  18 18                    sbb     [bx+si],bl
F000:5BFB  [+0x05BFB]  18 18                    sbb     [bx+si],bl
F000:5BFD  [+0x05BFD]  18 F8                    sbb     al,bh
F000:5BFF  [+0x05BFF]  18 F8                    sbb     al,bh
F000:5C01  [+0x05C01]  18 18                    sbb     [bx+si],bl
F000:5C03  [+0x05C03]  18 36 36 36              sbb     [3636h],dh
F000:5C07  [+0x05C07]  36 F6 36 36 36           div     byte [ss:3636h]
F000:5C0C  [+0x05C0C]  00 00                    add     [bx+si],al
F000:5C0E  [+0x05C0E]  00 00                    add     [bx+si],al
F000:5C10  [+0x05C10]  DB 0xFE  (bad)
F000:5C12  [+0x05C12]  36 36 00 00              add     [ss:bx+si],al
F000:5C16  [+0x05C16]  F8                       clc
F000:5C17  [+0x05C17]  18 F8                    sbb     al,bh
F000:5C19  [+0x05C19]  18 18                    sbb     [bx+si],bl
F000:5C1B  [+0x05C1B]  18 36 36 F6              sbb     [0F636h],dh
F000:5C1F  [+0x05C1F]  06                       push    es
F000:5C20  [+0x05C20]  F6 36 36 36              div     byte [3636h]
F000:5C24  [+0x05C24]  36 36 36 36 36 36 36 36 00 00 add     [ss:bx+si],al
F000:5C2E  [+0x05C2E]  FE 06 F6 36              inc     byte [36F6h]
F000:5C32  [+0x05C32]  36 36 36 36 F6 06 FE 00 00 test    byte [ss:0FEh],0
F000:5C3B  [+0x05C3B]  00 36 36 36              add     [3636h],dh
F000:5C3F  [+0x05C3F]  36 FE 00                 inc     byte [ss:bx+si]
F000:5C42  [+0x05C42]  00 00                    add     [bx+si],al
F000:5C44  [+0x05C44]  18 18                    sbb     [bx+si],bl
F000:5C46  [+0x05C46]  F8                       clc
F000:5C47  [+0x05C47]  18 F8                    sbb     al,bh
F000:5C49  [+0x05C49]  00 00                    add     [bx+si],al
F000:5C4B  [+0x05C4B]  00 00                    add     [bx+si],al
F000:5C4D  [+0x05C4D]  00 00                    add     [bx+si],al
F000:5C4F  [+0x05C4F]  00 F8                    add     al,bh
F000:5C51  [+0x05C51]  18 18                    sbb     [bx+si],bl
F000:5C53  [+0x05C53]  18 18                    sbb     [bx+si],bl
F000:5C55  [+0x05C55]  18 18                    sbb     [bx+si],bl
F000:5C57  [+0x05C57]  18 1F                    sbb     [bx],bl
F000:5C59  [+0x05C59]  00 00                    add     [bx+si],al
F000:5C5B  [+0x05C5B]  00 18                    add     [bx+si],bl
F000:5C5D  [+0x05C5D]  18 18                    sbb     [bx+si],bl
F000:5C5F  [+0x05C5F]  18 FF                    sbb     bh,bh
F000:5C61  [+0x05C61]  00 00                    add     [bx+si],al
F000:5C63  [+0x05C63]  00 00                    add     [bx+si],al
F000:5C65  [+0x05C65]  00 00                    add     [bx+si],al
F000:5C67  [+0x05C67]  00 FF                    add     bh,bh
F000:5C69  [+0x05C69]  18 18                    sbb     [bx+si],bl
F000:5C6B  [+0x05C6B]  18 18                    sbb     [bx+si],bl
F000:5C6D  [+0x05C6D]  18 18                    sbb     [bx+si],bl
F000:5C6F  [+0x05C6F]  18 1F                    sbb     [bx],bl
F000:5C71  [+0x05C71]  18 18                    sbb     [bx+si],bl
F000:5C73  [+0x05C73]  18 00                    sbb     [bx+si],al
F000:5C75  [+0x05C75]  00 00                    add     [bx+si],al
F000:5C77  [+0x05C77]  00 FF                    add     bh,bh
F000:5C79  [+0x05C79]  00 00                    add     [bx+si],al
F000:5C7B  [+0x05C7B]  00 18                    add     [bx+si],bl
F000:5C7D  [+0x05C7D]  18 18                    sbb     [bx+si],bl
F000:5C7F  [+0x05C7F]  18 FF                    sbb     bh,bh
F000:5C81  [+0x05C81]  18 18                    sbb     [bx+si],bl
F000:5C83  [+0x05C83]  18 18                    sbb     [bx+si],bl
F000:5C85  [+0x05C85]  18 1F                    sbb     [bx],bl
F000:5C87  [+0x05C87]  18 1F                    sbb     [bx],bl
F000:5C89  [+0x05C89]  18 18                    sbb     [bx+si],bl
F000:5C8B  [+0x05C8B]  18 36 36 36              sbb     [3636h],dh
F000:5C8F  [+0x05C8F]  36 37                    aaa
F000:5C91  [+0x05C91]  36 36 36 36 36 37        aaa
F000:5C97  [+0x05C97]  30 3F                    xor     [bx],bh
F000:5C99  [+0x05C99]  00 00                    add     [bx+si],al
F000:5C9B  [+0x05C9B]  00 00                    add     [bx+si],al
F000:5C9D  [+0x05C9D]  00 3F                    add     [bx],bh
F000:5C9F  [+0x05C9F]  30 37                    xor     [bx],dh
F000:5CA1  [+0x05CA1]  36 36 36 36 36 F7 00 FF 00 test    word [ss:bx+si],0FFh
F000:5CAA  [+0x05CAA]  00 00                    add     [bx+si],al
F000:5CAC  [+0x05CAC]  00 00                    add     [bx+si],al
F000:5CAE  [+0x05CAE]  FF 00                    inc     word [bx+si]
F000:5CB0  [+0x05CB0]  F7 36 36 36              div     word [3636h]
F000:5CB4  [+0x05CB4]  36 36 37                 aaa
F000:5CB7  [+0x05CB7]  30 37                    xor     [bx],dh
F000:5CB9  [+0x05CB9]  36 36 36 00 00           add     [ss:bx+si],al
F000:5CBE  [+0x05CBE]  FF 00                    inc     word [bx+si]
F000:5CC0  [+0x05CC0]  FF 00                    inc     word [bx+si]
F000:5CC2  [+0x05CC2]  00 00                    add     [bx+si],al
F000:5CC4  [+0x05CC4]  36 36 F7 00 F7 36        test    word [ss:bx+si],36F7h
F000:5CCA  [+0x05CCA]  36 36 18 18              sbb     [ss:bx+si],bl
F000:5CCE  [+0x05CCE]  FF 00                    inc     word [bx+si]
F000:5CD0  [+0x05CD0]  FF 00                    inc     word [bx+si]
F000:5CD2  [+0x05CD2]  00 00                    add     [bx+si],al
F000:5CD4  [+0x05CD4]  36 36 36 36 FF 00        inc     word [ss:bx+si]
F000:5CDA  [+0x05CDA]  00 00                    add     [bx+si],al
F000:5CDC  [+0x05CDC]  00 00                    add     [bx+si],al
F000:5CDE  [+0x05CDE]  FF 00                    inc     word [bx+si]
F000:5CE0  [+0x05CE0]  FF 18                    call    far [bx+si]
F000:5CE2  [+0x05CE2]  18 18                    sbb     [bx+si],bl
F000:5CE4  [+0x05CE4]  00 00                    add     [bx+si],al
F000:5CE6  [+0x05CE6]  00 00                    add     [bx+si],al
F000:5CE8  [+0x05CE8]  FF 36 36 36              push    word [3636h]
F000:5CEC  [+0x05CEC]  36 36 36 36 3F           aas
F000:5CF1  [+0x05CF1]  00 00                    add     [bx+si],al
F000:5CF3  [+0x05CF3]  00 18                    add     [bx+si],bl
F000:5CF5  [+0x05CF5]  18 1F                    sbb     [bx],bl
F000:5CF7  [+0x05CF7]  18 1F                    sbb     [bx],bl
F000:5CF9  [+0x05CF9]  00 00                    add     [bx+si],al
F000:5CFB  [+0x05CFB]  00 00                    add     [bx+si],al
F000:5CFD  [+0x05CFD]  00 1F                    add     [bx],bl
F000:5CFF  [+0x05CFF]  18 1F                    sbb     [bx],bl
F000:5D01  [+0x05D01]  18 18                    sbb     [bx+si],bl
F000:5D03  [+0x05D03]  18 00                    sbb     [bx+si],al
F000:5D05  [+0x05D05]  00 00                    add     [bx+si],al
F000:5D07  [+0x05D07]  00 3F                    add     [bx],bh
F000:5D09  [+0x05D09]  36 36 36 36 36 36 36 FF 36 36 36 push    word [ss:3636h]
F000:5D14  [+0x05D14]  18 18                    sbb     [bx+si],bl
F000:5D16  [+0x05D16]  FF 18                    call    far [bx+si]
F000:5D18  [+0x05D18]  FF 18                    call    far [bx+si]
F000:5D1A  [+0x05D1A]  18 18                    sbb     [bx+si],bl
F000:5D1C  [+0x05D1C]  18 18                    sbb     [bx+si],bl
F000:5D1E  [+0x05D1E]  18 18                    sbb     [bx+si],bl
F000:5D20  [+0x05D20]  F8                       clc
F000:5D21  [+0x05D21]  00 00                    add     [bx+si],al
F000:5D23  [+0x05D23]  00 00                    add     [bx+si],al
F000:5D25  [+0x05D25]  00 00                    add     [bx+si],al
F000:5D27  [+0x05D27]  00 1F                    add     [bx],bl
F000:5D29  [+0x05D29]  18 18                    sbb     [bx+si],bl
F000:5D2B  [+0x05D2B]  18 FF                    sbb     bh,bh
F000:5D2D  [+0x05D2D]  DB 0xFF  (bad)
F000:5D2F  [+0x05D2F]  DB 0xFF  (bad)
F000:5D31  [+0x05D31]  DB 0xFF  (bad)
F000:5D33  [+0x05D33]  FF 00                    inc     word [bx+si]
F000:5D35  [+0x05D35]  00 00                    add     [bx+si],al
F000:5D37  [+0x05D37]  00 FF                    add     bh,bh
F000:5D39  [+0x05D39]  DB 0xFF  (bad)
F000:5D3B  [+0x05D3B]  FF F0                    push    ax
F000:5D3D  [+0x05D3D]  DB 0xF0  (bad)
F000:5D48  [+0x05D48]  DB 0x0F  (bad)
F000:5D4C  [+0x05D4C]  DB 0xFF  (bad)
F000:5D4E  [+0x05D4E]  DB 0xFF  (bad)
F000:5D50  [+0x05D50]  00 00                    add     [bx+si],al
F000:5D52  [+0x05D52]  00 00                    add     [bx+si],al
F000:5D54  [+0x05D54]  00 00                    add     [bx+si],al
F000:5D56  [+0x05D56]  76 DC                    jbe     short 5D34h
F000:5D58  [+0x05D58]  C8 DC 76 00              enter   76DCh,0
F000:5D5C  [+0x05D5C]  00 7C C6                 add     [si-3Ah],bh
F000:5D5F  [+0x05D5F]  FC                       cld
F000:5D60  [+0x05D60]  DB 0xC6  (bad)
F000:5D62  [+0x05D62]  C0 C0 00                 rol     al,0
F000:5D65  [+0x05D65]  FC                       cld
F000:5D66  [+0x05D66]  CC                       int3
F000:5D67  [+0x05D67]  C0 C0 C0                 rol     al,0C0h
F000:5D6A  [+0x05D6A]  C0 00 00                 rol     byte [bx+si],0
F000:5D6D  [+0x05D6D]  00 FE                    add     dh,bh
F000:5D6F  [+0x05D6F]  6C                       insb
F000:5D70  [+0x05D70]  6C                       insb
F000:5D71  [+0x05D71]  6C                       insb
F000:5D72  [+0x05D72]  6C                       insb
F000:5D73  [+0x05D73]  00 FC                    add     ah,bh
F000:5D75  [+0x05D75]  CC                       int3
F000:5D76  [+0x05D76]  60                       pusha
F000:5D77  [+0x05D77]  30 60 CC                 xor     [bx+si-34h],ah
F000:5D7A  [+0x05D7A]  FC                       cld
F000:5D7B  [+0x05D7B]  00 00                    add     [bx+si],al
F000:5D7D  [+0x05D7D]  00 7E D8                 add     [bp-28h],bh
F000:5D80  [+0x05D80]  D8 D8                    fcomp   st0
F000:5D82  [+0x05D82]  70 00                    jo      short 5D84h
F000:5D84  [+0x05D84]  00 66 66                 add     [bp+66h],ah
F000:5D87  [+0x05D87]  66 66 7C 60              o32 jl  short 00005DEBh
F000:5D8B  [+0x05D8B]  C0 00 76                 rol     byte [bx+si],76h
F000:5D8E  [+0x05D8E]  DC 18                    fcomp   qword [bx+si]
F000:5D90  [+0x05D90]  18 18                    sbb     [bx+si],bl
F000:5D92  [+0x05D92]  18 00                    sbb     [bx+si],al
F000:5D94  [+0x05D94]  FC                       cld
F000:5D95  [+0x05D95]  30 78 CC                 xor     [bx+si-34h],bh
F000:5D98  [+0x05D98]  CC                       int3
F000:5D99  [+0x05D99]  78 30                    js      short 5DCBh
F000:5D9B  [+0x05D9B]  FC                       cld
F000:5D9C  [+0x05D9C]  38 6C C6                 cmp     [si-3Ah],ch
F000:5D9F  [+0x05D9F]  FE C6                    inc     dh
F000:5DA1  [+0x05DA1]  6C                       insb
F000:5DA2  [+0x05DA2]  38 00                    cmp     [bx+si],al
F000:5DA4  [+0x05DA4]  38 6C C6                 cmp     [si-3Ah],ch
F000:5DA7  [+0x05DA7]  DB 0xC6  (bad)
F000:5DA9  [+0x05DA9]  6C                       insb
F000:5DAA  [+0x05DAA]  EE                       out     dx,al
F000:5DAB  [+0x05DAB]  00 1C                    add     [si],bl
F000:5DAD  [+0x05DAD]  30 18                    xor     [bx+si],bl
F000:5DAF  [+0x05DAF]  7C CC                    jl      short 5D7Dh
F000:5DB1  [+0x05DB1]  CC                       int3
F000:5DB2  [+0x05DB2]  78 00                    js      short 5DB4h
F000:5DB4  [+0x05DB4]  00 00                    add     [bx+si],al
F000:5DB6  [+0x05DB6]  7E DB                    jle     short 5D93h
F000:5DB8  [+0x05DB8]  DB 7E 00                 fstp    tword [bp]
F000:5DBB  [+0x05DBB]  00 06 0C 7E              add     [7E0Ch],al
F000:5DBF  [+0x05DBF]  DB DB                    fcmovnu st3
F000:5DC1  [+0x05DC1]  7E 60                    jle     short 5E23h
F000:5DC3  [+0x05DC3]  C0 38 60                 sar     byte [bx+si],60h
F000:5DC6  [+0x05DC6]  C0 F8 C0                 sar     al,0C0h
F000:5DC9  [+0x05DC9]  60                       pusha
F000:5DCA  [+0x05DCA]  38 00                    cmp     [bx+si],al
F000:5DCC  [+0x05DCC]  78 CC                    js      short 5D9Ah
F000:5DCE  [+0x05DCE]  CC                       int3
F000:5DCF  [+0x05DCF]  CC                       int3
F000:5DD0  [+0x05DD0]  CC                       int3
F000:5DD1  [+0x05DD1]  CC                       int3
F000:5DD2  [+0x05DD2]  CC                       int3
F000:5DD3  [+0x05DD3]  00 00                    add     [bx+si],al
F000:5DD5  [+0x05DD5]  7E 00                    jle     short 5DD7h
F000:5DD7  [+0x05DD7]  7E 00                    jle     short 5DD9h
F000:5DD9  [+0x05DD9]  7E 00                    jle     short 5DDBh
F000:5DDB  [+0x05DDB]  00 18                    add     [bx+si],bl
F000:5DDD  [+0x05DDD]  18 7E 18                 sbb     [bp+18h],bh
F000:5DE0  [+0x05DE0]  18 00                    sbb     [bx+si],al
F000:5DE2  [+0x05DE2]  7E 00                    jle     short 5DE4h
F000:5DE4  [+0x05DE4]  60                       pusha
F000:5DE5  [+0x05DE5]  30 18                    xor     [bx+si],bl
F000:5DE7  [+0x05DE7]  30 60 00                 xor     [bx+si],ah
F000:5DEA  [+0x05DEA]  FC                       cld
F000:5DEB  [+0x05DEB]  00 18                    add     [bx+si],bl
F000:5DED  [+0x05DED]  30 60 30                 xor     [bx+si+30h],ah
F000:5DF0  [+0x05DF0]  18 00                    sbb     [bx+si],al
F000:5DF2  [+0x05DF2]  FC                       cld
F000:5DF3  [+0x05DF3]  00 0E 1B 1B              add     [1B1Bh],cl
F000:5DF7  [+0x05DF7]  18 18                    sbb     [bx+si],bl
F000:5DF9  [+0x05DF9]  18 18                    sbb     [bx+si],bl
F000:5DFB  [+0x05DFB]  18 18                    sbb     [bx+si],bl
F000:5DFD  [+0x05DFD]  18 18                    sbb     [bx+si],bl
F000:5DFF  [+0x05DFF]  18 18                    sbb     [bx+si],bl
F000:5E01  [+0x05E01]  D8 D8                    fcomp   st0
F000:5E03  [+0x05E03]  70 18                    jo      short 5E1Dh
F000:5E05  [+0x05E05]  18 00                    sbb     [bx+si],al
F000:5E07  [+0x05E07]  7E 00                    jle     short 5E09h
F000:5E09  [+0x05E09]  18 18                    sbb     [bx+si],bl
F000:5E0B  [+0x05E0B]  00 00                    add     [bx+si],al
F000:5E0D  [+0x05E0D]  76 DC                    jbe     short 5DEBh
F000:5E0F  [+0x05E0F]  00 76 DC                 add     [bp-24h],dh
F000:5E12  [+0x05E12]  00 00                    add     [bx+si],al
F000:5E14  [+0x05E14]  38 6C 6C                 cmp     [si+6Ch],ch
F000:5E17  [+0x05E17]  38 00                    cmp     [bx+si],al
F000:5E19  [+0x05E19]  00 00                    add     [bx+si],al
F000:5E1B  [+0x05E1B]  00 00                    add     [bx+si],al
F000:5E1D  [+0x05E1D]  00 00                    add     [bx+si],al
F000:5E1F  [+0x05E1F]  18 18                    sbb     [bx+si],bl
F000:5E21  [+0x05E21]  00 00                    add     [bx+si],al
F000:5E23  [+0x05E23]  00 00                    add     [bx+si],al
F000:5E25  [+0x05E25]  00 00                    add     [bx+si],al
F000:5E27  [+0x05E27]  00 18                    add     [bx+si],bl
F000:5E29  [+0x05E29]  00 00                    add     [bx+si],al
F000:5E2B  [+0x05E2B]  00 0F                    add     [bx],cl
F000:5E2D  [+0x05E2D]  0C 0C                    or      al,0Ch
F000:5E2F  [+0x05E2F]  0C EC                    or      al,0ECh
F000:5E31  [+0x05E31]  6C                       insb
F000:5E32  [+0x05E32]  3C 1C                    cmp     al,1Ch
F000:5E34  [+0x05E34]  58                       pop     ax
F000:5E35  [+0x05E35]  6C                       insb
F000:5E36  [+0x05E36]  6C                       insb
F000:5E37  [+0x05E37]  6C                       insb
F000:5E38  [+0x05E38]  6C                       insb
F000:5E39  [+0x05E39]  00 00                    add     [bx+si],al
F000:5E3B  [+0x05E3B]  00 70 98                 add     [bx+si-68h],dh
F000:5E3E  [+0x05E3E]  30 60 F8                 xor     [bx+si-8],ah
F000:5E41  [+0x05E41]  00 00                    add     [bx+si],al
F000:5E43  [+0x05E43]  00 00                    add     [bx+si],al
F000:5E45  [+0x05E45]  00 3C                    add     [si],bh
F000:5E47  [+0x05E47]  3C 3C                    cmp     al,3Ch
F000:5E49  [+0x05E49]  3C 00                    cmp     al,0
F000:5E4B  [+0x05E4B]  00 00                    add     [bx+si],al
F000:5E4D  [+0x05E4D]  00 00                    add     [bx+si],al
F000:5E4F  [+0x05E4F]  00 00                    add     [bx+si],al
F000:5E51  [+0x05E51]  00 00                    add     [bx+si],al
F000:5E53  [+0x05E53]  00 00                    add     [bx+si],al
F000:5E55  [+0x05E55]  00 00                    add     [bx+si],al
F000:5E57  [+0x05E57]  00 00                    add     [bx+si],al
F000:5E59  [+0x05E59]  00 00                    add     [bx+si],al
F000:5E5B  [+0x05E5B]  00 00                    add     [bx+si],al
F000:5E5D  [+0x05E5D]  00 00                    add     [bx+si],al
F000:5E5F  [+0x05E5F]  00 00                    add     [bx+si],al
F000:5E61  [+0x05E61]  00 00                    add     [bx+si],al
F000:5E63  [+0x05E63]  00 7E 81                 add     [bp-7Fh],bh
F000:5E66  [+0x05E66]  A5                       movsw
F000:5E67  [+0x05E67]  81 81 BD 99 81 7E        add     word [bx+di-6643h],7E81h
F000:5E6D  [+0x05E6D]  00 00                    add     [bx+si],al
F000:5E6F  [+0x05E6F]  00 00                    add     [bx+si],al
F000:5E71  [+0x05E71]  00 7E FF                 add     [bp-1],bh
F000:5E74  [+0x05E74]  DB 0xDB  (bad)
F000:5E76  [+0x05E76]  FF C3                    inc     bx
F000:5E78  [+0x05E78]  E7 FF                    out     0FFh,ax
F000:5E7A  [+0x05E7A]  7E 00                    jle     short 5E7Ch
F000:5E7C  [+0x05E7C]  00 00                    add     [bx+si],al
F000:5E7E  [+0x05E7E]  00 00                    add     [bx+si],al
F000:5E80  [+0x05E80]  00 6C FE                 add     [si-2],ch
F000:5E83  [+0x05E83]  DB 0xFE  (bad)
F000:5E85  [+0x05E85]  DB 0xFE  (bad)
F000:5E87  [+0x05E87]  38 10                    cmp     [bx+si],dl
F000:5E89  [+0x05E89]  00 00                    add     [bx+si],al
F000:5E8B  [+0x05E8B]  00 00                    add     [bx+si],al
F000:5E8D  [+0x05E8D]  00 00                    add     [bx+si],al
F000:5E8F  [+0x05E8F]  10 38                    adc     [bx+si],bh
F000:5E91  [+0x05E91]  7C FE                    jl      short 5E91h
F000:5E93  [+0x05E93]  7C 38                    jl      short 5ECDh
F000:5E95  [+0x05E95]  10 00                    adc     [bx+si],al
F000:5E97  [+0x05E97]  00 00                    add     [bx+si],al
F000:5E99  [+0x05E99]  00 00                    add     [bx+si],al
F000:5E9B  [+0x05E9B]  00 18                    add     [bx+si],bl
F000:5E9D  [+0x05E9D]  3C 3C                    cmp     al,3Ch
F000:5E9F  [+0x05E9F]  E7 E7                    out     0E7h,ax
F000:5EA1  [+0x05EA1]  E7 99                    out     99h,ax
F000:5EA3  [+0x05EA3]  18 3C                    sbb     [si],bh
F000:5EA5  [+0x05EA5]  00 00                    add     [bx+si],al
F000:5EA7  [+0x05EA7]  00 00                    add     [bx+si],al
F000:5EA9  [+0x05EA9]  00 18                    add     [bx+si],bl
F000:5EAB  [+0x05EAB]  3C 7E                    cmp     al,7Eh
F000:5EAD  [+0x05EAD]  DB 0xFF  (bad)
F000:5EAF  [+0x05EAF]  7E 18                    jle     short 5EC9h
F000:5EB1  [+0x05EB1]  18 3C                    sbb     [si],bh
F000:5EB3  [+0x05EB3]  00 00                    add     [bx+si],al
F000:5EB5  [+0x05EB5]  00 00                    add     [bx+si],al
F000:5EB7  [+0x05EB7]  00 00                    add     [bx+si],al
F000:5EB9  [+0x05EB9]  00 00                    add     [bx+si],al
F000:5EBB  [+0x05EBB]  18 3C                    sbb     [si],bh
F000:5EBD  [+0x05EBD]  3C 18                    cmp     al,18h
F000:5EBF  [+0x05EBF]  00 00                    add     [bx+si],al
F000:5EC1  [+0x05EC1]  00 00                    add     [bx+si],al
F000:5EC3  [+0x05EC3]  00 FF                    add     bh,bh
F000:5EC5  [+0x05EC5]  DB 0xFF  (bad)
F000:5EC7  [+0x05EC7]  DB 0xFF  (bad)
F000:5EC9  [+0x05EC9]  E7 C3                    out     0C3h,ax
F000:5ECB  [+0x05ECB]  C3                       ret
F000:5ECC  [+0x05ECC]  E7 FF                    out     0FFh,ax
F000:5ECE  [+0x05ECE]  DB 0xFF  (bad)
F000:5ED0  [+0x05ED0]  DB 0xFF  (bad)
F000:5ED2  [+0x05ED2]  00 00                    add     [bx+si],al
F000:5ED4  [+0x05ED4]  00 00                    add     [bx+si],al
F000:5ED6  [+0x05ED6]  3C 66                    cmp     al,66h
F000:5ED8  [+0x05ED8]  42                       inc     dx
F000:5ED9  [+0x05ED9]  42                       inc     dx
F000:5EDA  [+0x05EDA]  66 3C 00                 cmp     al,0
F000:5EDD  [+0x05EDD]  00 00                    add     [bx+si],al
F000:5EDF  [+0x05EDF]  00 FF                    add     bh,bh
F000:5EE1  [+0x05EE1]  DB 0xFF  (bad)
F000:5EE3  [+0x05EE3]  FF C3                    inc     bx
F000:5EE5  [+0x05EE5]  99                       cwd
F000:5EE6  [+0x05EE6]  BD BD 99                 mov     bp,99BDh
F000:5EE9  [+0x05EE9]  C3                       ret
F000:5EEA  [+0x05EEA]  DB 0xFF  (bad)
F000:5EEC  [+0x05EEC]  DB 0xFF  (bad)
F000:5EEE  [+0x05EEE]  00 00                    add     [bx+si],al
F000:5EF0  [+0x05EF0]  1E                       push    ds
F000:5EF1  [+0x05EF1]  0E                       push    cs
F000:5EF2  [+0x05EF2]  1A 32                    sbb     dh,[bp+si]
F000:5EF4  [+0x05EF4]  78 CC                    js      short 5EC2h
F000:5EF6  [+0x05EF6]  CC                       int3
F000:5EF7  [+0x05EF7]  CC                       int3
F000:5EF8  [+0x05EF8]  78 00                    js      short 5EFAh
F000:5EFA  [+0x05EFA]  00 00                    add     [bx+si],al
F000:5EFC  [+0x05EFC]  00 00                    add     [bx+si],al
F000:5EFE  [+0x05EFE]  3C 66                    cmp     al,66h
F000:5F00  [+0x05F00]  66 66 3C 18              cmp     al,18h
F000:5F04  [+0x05F04]  7E 18                    jle     short 5F1Eh
F000:5F06  [+0x05F06]  18 00                    sbb     [bx+si],al
F000:5F08  [+0x05F08]  00 00                    add     [bx+si],al
F000:5F0A  [+0x05F0A]  00 00                    add     [bx+si],al
F000:5F0C  [+0x05F0C]  3F                       aas
F000:5F0D  [+0x05F0D]  33 3F                    xor     di,[bx]
F000:5F0F  [+0x05F0F]  30 30                    xor     [bx+si],dh
F000:5F11  [+0x05F11]  30 70 F0                 xor     [bx+si-10h],dh
F000:5F14  [+0x05F14]  E0 00                    loopne  5F16h
F000:5F16  [+0x05F16]  00 00                    add     [bx+si],al
F000:5F18  [+0x05F18]  00 00                    add     [bx+si],al
F000:5F1A  [+0x05F1A]  7F 63                    jg      short 5F7Fh
F000:5F1C  [+0x05F1C]  7F 63                    jg      short 5F81h
F000:5F1E  [+0x05F1E]  63 63 67                 arpl    [bp+di+67h],sp
F000:5F21  [+0x05F21]  E7 E6                    out     0E6h,ax
F000:5F23  [+0x05F23]  C0 00 00                 rol     byte [bx+si],0
F000:5F26  [+0x05F26]  00 00                    add     [bx+si],al
F000:5F28  [+0x05F28]  18 18                    sbb     [bx+si],bl
F000:5F2A  [+0x05F2A]  DB 3C                    fstp    tword [si]
F000:5F2C  [+0x05F2C]  E7 3C                    out     3Ch,ax
F000:5F2E  [+0x05F2E]  DB 18                    fistp   dword [bx+si]
F000:5F30  [+0x05F30]  18 00                    sbb     [bx+si],al
F000:5F32  [+0x05F32]  00 00                    add     [bx+si],al
F000:5F34  [+0x05F34]  00 00                    add     [bx+si],al
F000:5F36  [+0x05F36]  80 C0 E0                 add     al,0E0h
F000:5F39  [+0x05F39]  F8                       clc
F000:5F3A  [+0x05F3A]  DB 0xFE  (bad)
F000:5F3C  [+0x05F3C]  E0 C0                    loopne  5EFEh
F000:5F3E  [+0x05F3E]  80 00 00                 add     byte [bx+si],0
F000:5F41  [+0x05F41]  00 00                    add     [bx+si],al
F000:5F43  [+0x05F43]  00 02                    add     [bp+si],al
F000:5F45  [+0x05F45]  06                       push    es
F000:5F46  [+0x05F46]  0E                       push    cs
F000:5F47  [+0x05F47]  DB 0x3E  (bad)
F000:5F4A  [+0x05F4A]  0E                       push    cs
F000:5F4B  [+0x05F4B]  06                       push    es
F000:5F4C  [+0x05F4C]  02 00                    add     al,[bx+si]
F000:5F4E  [+0x05F4E]  00 00                    add     [bx+si],al
F000:5F50  [+0x05F50]  00 00                    add     [bx+si],al
F000:5F52  [+0x05F52]  18 3C                    sbb     [si],bh
F000:5F54  [+0x05F54]  7E 18                    jle     short 5F6Eh
F000:5F56  [+0x05F56]  18 18                    sbb     [bx+si],bl
F000:5F58  [+0x05F58]  7E 3C                    jle     short 5F96h
F000:5F5A  [+0x05F5A]  18 00                    sbb     [bx+si],al
F000:5F5C  [+0x05F5C]  00 00                    add     [bx+si],al
F000:5F5E  [+0x05F5E]  00 00                    add     [bx+si],al
F000:5F60  [+0x05F60]  66 66 66 66 66 66 00 66 66 add     [bp+66h],ah
F000:5F69  [+0x05F69]  00 00                    add     [bx+si],al
F000:5F6B  [+0x05F6B]  00 00                    add     [bx+si],al
F000:5F6D  [+0x05F6D]  00 7F DB                 add     [bx-25h],bh
F000:5F70  [+0x05F70]  DB DB                    fcmovnu st3
F000:5F72  [+0x05F72]  7B 1B                    jnp     short 5F8Fh
F000:5F74  [+0x05F74]  1B 1B                    sbb     bx,[bp+di]
F000:5F76  [+0x05F76]  1B 00                    sbb     ax,[bx+si]
F000:5F78  [+0x05F78]  00 00                    add     [bx+si],al
F000:5F7A  [+0x05F7A]  00 7C C6                 add     [si-3Ah],bh
F000:5F7D  [+0x05F7D]  60                       pusha
F000:5F7E  [+0x05F7E]  38 6C C6                 cmp     [si-3Ah],ch
F000:5F81  [+0x05F81]  DB 0xC6  (bad)
F000:5F83  [+0x05F83]  38 0C                    cmp     [si],cl
F000:5F85  [+0x05F85]  DB 0xC6  (bad)
F000:5F87  [+0x05F87]  00 00                    add     [bx+si],al
F000:5F89  [+0x05F89]  00 00                    add     [bx+si],al
F000:5F8B  [+0x05F8B]  00 00                    add     [bx+si],al
F000:5F8D  [+0x05F8D]  00 00                    add     [bx+si],al
F000:5F8F  [+0x05F8F]  00 FE                    add     dh,bh
F000:5F91  [+0x05F91]  DB 0xFE  (bad)
F000:5F93  [+0x05F93]  00 00                    add     [bx+si],al
F000:5F95  [+0x05F95]  00 00                    add     [bx+si],al
F000:5F97  [+0x05F97]  00 18                    add     [bx+si],bl
F000:5F99  [+0x05F99]  3C 7E                    cmp     al,7Eh
F000:5F9B  [+0x05F9B]  18 18                    sbb     [bx+si],bl
F000:5F9D  [+0x05F9D]  18 7E 3C                 sbb     [bp+3Ch],bh
F000:5FA0  [+0x05FA0]  18 7E 00                 sbb     [bp],bh
F000:5FA3  [+0x05FA3]  00 00                    add     [bx+si],al
F000:5FA5  [+0x05FA5]  00 18                    add     [bx+si],bl
F000:5FA7  [+0x05FA7]  3C 7E                    cmp     al,7Eh
F000:5FA9  [+0x05FA9]  18 18                    sbb     [bx+si],bl
F000:5FAB  [+0x05FAB]  18 18                    sbb     [bx+si],bl
F000:5FAD  [+0x05FAD]  18 18                    sbb     [bx+si],bl
F000:5FAF  [+0x05FAF]  00 00                    add     [bx+si],al
F000:5FB1  [+0x05FB1]  00 00                    add     [bx+si],al
F000:5FB3  [+0x05FB3]  00 18                    add     [bx+si],bl
F000:5FB5  [+0x05FB5]  18 18                    sbb     [bx+si],bl
F000:5FB7  [+0x05FB7]  18 18                    sbb     [bx+si],bl
F000:5FB9  [+0x05FB9]  18 7E 3C                 sbb     [bp+3Ch],bh
F000:5FBC  [+0x05FBC]  18 00                    sbb     [bx+si],al
F000:5FBE  [+0x05FBE]  00 00                    add     [bx+si],al
F000:5FC0  [+0x05FC0]  00 00                    add     [bx+si],al
F000:5FC2  [+0x05FC2]  00 00                    add     [bx+si],al
F000:5FC4  [+0x05FC4]  18 0C                    sbb     [si],cl
F000:5FC6  [+0x05FC6]  FE 0C                    dec     byte [si]
F000:5FC8  [+0x05FC8]  18 00                    sbb     [bx+si],al
F000:5FCA  [+0x05FCA]  00 00                    add     [bx+si],al
F000:5FCC  [+0x05FCC]  00 00                    add     [bx+si],al
F000:5FCE  [+0x05FCE]  00 00                    add     [bx+si],al
F000:5FD0  [+0x05FD0]  00 00                    add     [bx+si],al
F000:5FD2  [+0x05FD2]  30 60 FE                 xor     [bx+si-2],ah
F000:5FD5  [+0x05FD5]  60                       pusha
F000:5FD6  [+0x05FD6]  30 00                    xor     [bx+si],al
F000:5FD8  [+0x05FD8]  00 00                    add     [bx+si],al
F000:5FDA  [+0x05FDA]  00 00                    add     [bx+si],al
F000:5FDC  [+0x05FDC]  00 00                    add     [bx+si],al
F000:5FDE  [+0x05FDE]  00 00                    add     [bx+si],al
F000:5FE0  [+0x05FE0]  00 C0                    add     al,al
F000:5FE2  [+0x05FE2]  C0 C0 FE                 rol     al,0FEh
F000:5FE5  [+0x05FE5]  00 00                    add     [bx+si],al
F000:5FE7  [+0x05FE7]  00 00                    add     [bx+si],al
F000:5FE9  [+0x05FE9]  00 00                    add     [bx+si],al
F000:5FEB  [+0x05FEB]  00 00                    add     [bx+si],al
F000:5FED  [+0x05FED]  00 28                    add     [bx+si],ch
F000:5FEF  [+0x05FEF]  6C                       insb
F000:5FF0  [+0x05FF0]  DB 0xFE  (bad)
F000:5FF2  [+0x05FF2]  28 00                    sub     [bx+si],al
F000:5FF4  [+0x05FF4]  00 00                    add     [bx+si],al
F000:5FF6  [+0x05FF6]  00 00                    add     [bx+si],al
F000:5FF8  [+0x05FF8]  00 00                    add     [bx+si],al
F000:5FFA  [+0x05FFA]  00 10                    add     [bx+si],dl
F000:5FFC  [+0x05FFC]  38 38                    cmp     [bx+si],bh
F000:5FFE  [+0x05FFE]  7C 7C                    jl      short 607Ch
F000:6000  [+0x06000]  DB 0xFE  (bad)
F000:6002  [+0x06002]  00 00                    add     [bx+si],al
F000:6004  [+0x06004]  00 00                    add     [bx+si],al
F000:6006  [+0x06006]  00 00                    add     [bx+si],al
F000:6008  [+0x06008]  00 FE                    add     dh,bh
F000:600A  [+0x0600A]  DB 0xFE  (bad)
F000:600C  [+0x0600C]  7C 38                    jl      short 6046h
F000:600E  [+0x0600E]  38 10                    cmp     [bx+si],dl
F000:6010  [+0x06010]  00 00                    add     [bx+si],al
F000:6012  [+0x06012]  00 00                    add     [bx+si],al
F000:6014  [+0x06014]  00 00                    add     [bx+si],al
F000:6016  [+0x06016]  00 00                    add     [bx+si],al
F000:6018  [+0x06018]  00 00                    add     [bx+si],al
F000:601A  [+0x0601A]  00 00                    add     [bx+si],al
F000:601C  [+0x0601C]  00 00                    add     [bx+si],al
F000:601E  [+0x0601E]  00 00                    add     [bx+si],al
F000:6020  [+0x06020]  00 00                    add     [bx+si],al
F000:6022  [+0x06022]  00 00                    add     [bx+si],al
F000:6024  [+0x06024]  18 3C                    sbb     [si],bh
F000:6026  [+0x06026]  3C 3C                    cmp     al,3Ch
F000:6028  [+0x06028]  18 18                    sbb     [bx+si],bl
F000:602A  [+0x0602A]  00 18                    add     [bx+si],bl
F000:602C  [+0x0602C]  18 00                    sbb     [bx+si],al
F000:602E  [+0x0602E]  00 00                    add     [bx+si],al
F000:6030  [+0x06030]  00 66 66                 add     [bp+66h],ah
F000:6033  [+0x06033]  66 24 00                 and     al,0
F000:6036  [+0x06036]  00 00                    add     [bx+si],al
F000:6038  [+0x06038]  00 00                    add     [bx+si],al
F000:603A  [+0x0603A]  00 00                    add     [bx+si],al
F000:603C  [+0x0603C]  00 00                    add     [bx+si],al
F000:603E  [+0x0603E]  00 00                    add     [bx+si],al
F000:6040  [+0x06040]  6C                       insb
F000:6041  [+0x06041]  6C                       insb
F000:6042  [+0x06042]  DB 0xFE  (bad)
F000:6044  [+0x06044]  6C                       insb
F000:6045  [+0x06045]  6C                       insb
F000:6046  [+0x06046]  DB 0xFE  (bad)
F000:6048  [+0x06048]  6C                       insb
F000:6049  [+0x06049]  00 00                    add     [bx+si],al
F000:604B  [+0x0604B]  00 18                    add     [bx+si],bl
F000:604D  [+0x0604D]  18 7C C6                 sbb     [si-3Ah],bh
F000:6050  [+0x06050]  C2 C0 7C                 ret     7CC0h
F000:6053  [+0x06053]  06                       push    es
F000:6054  [+0x06054]  86 C6                    xchg    al,dh
F000:6056  [+0x06056]  7C 18                    jl      short 6070h
F000:6058  [+0x06058]  18 00                    sbb     [bx+si],al
F000:605A  [+0x0605A]  00 00                    add     [bx+si],al
F000:605C  [+0x0605C]  00 00                    add     [bx+si],al
F000:605E  [+0x0605E]  C2 C6 0C                 ret     0CC6h
F000:6061  [+0x06061]  18 30                    sbb     [bx+si],dh
F000:6063  [+0x06063]  66 C6 00 00              mov     byte [bx+si],0
F000:6067  [+0x06067]  00 00                    add     [bx+si],al
F000:6069  [+0x06069]  00 38                    add     [bx+si],bh
F000:606B  [+0x0606B]  6C                       insb
F000:606C  [+0x0606C]  6C                       insb
F000:606D  [+0x0606D]  38 76 DC                 cmp     [bp-24h],dh
F000:6070  [+0x06070]  CC                       int3
F000:6071  [+0x06071]  CC                       int3
F000:6072  [+0x06072]  76 00                    jbe     short 6074h
F000:6074  [+0x06074]  00 00                    add     [bx+si],al
F000:6076  [+0x06076]  00 30                    add     [bx+si],dh
F000:6078  [+0x06078]  30 30                    xor     [bx+si],dh
F000:607A  [+0x0607A]  60                       pusha
F000:607B  [+0x0607B]  00 00                    add     [bx+si],al
F000:607D  [+0x0607D]  00 00                    add     [bx+si],al
F000:607F  [+0x0607F]  00 00                    add     [bx+si],al
F000:6081  [+0x06081]  00 00                    add     [bx+si],al
F000:6083  [+0x06083]  00 00                    add     [bx+si],al
F000:6085  [+0x06085]  00 0C                    add     [si],cl
F000:6087  [+0x06087]  18 30                    sbb     [bx+si],dh
F000:6089  [+0x06089]  30 30                    xor     [bx+si],dh
F000:608B  [+0x0608B]  30 30                    xor     [bx+si],dh
F000:608D  [+0x0608D]  18 0C                    sbb     [si],cl
F000:608F  [+0x0608F]  00 00                    add     [bx+si],al
F000:6091  [+0x06091]  00 00                    add     [bx+si],al
F000:6093  [+0x06093]  00 30                    add     [bx+si],dh
F000:6095  [+0x06095]  18 0C                    sbb     [si],cl
F000:6097  [+0x06097]  0C 0C                    or      al,0Ch
F000:6099  [+0x06099]  0C 0C                    or      al,0Ch
F000:609B  [+0x0609B]  18 30                    sbb     [bx+si],dh
F000:609D  [+0x0609D]  00 00                    add     [bx+si],al
F000:609F  [+0x0609F]  00 00                    add     [bx+si],al
F000:60A1  [+0x060A1]  00 00                    add     [bx+si],al
F000:60A3  [+0x060A3]  00 66 3C                 add     [bp+3Ch],ah
F000:60A6  [+0x060A6]  DB 0xFF  (bad)
F000:60A8  [+0x060A8]  66 00 00                 add     [bx+si],al
F000:60AB  [+0x060AB]  00 00                    add     [bx+si],al
F000:60AD  [+0x060AD]  00 00                    add     [bx+si],al
F000:60AF  [+0x060AF]  00 00                    add     [bx+si],al
F000:60B1  [+0x060B1]  00 18                    add     [bx+si],bl
F000:60B3  [+0x060B3]  18 7E 18                 sbb     [bp+18h],bh
F000:60B6  [+0x060B6]  18 00                    sbb     [bx+si],al
F000:60B8  [+0x060B8]  00 00                    add     [bx+si],al
F000:60BA  [+0x060BA]  00 00                    add     [bx+si],al
F000:60BC  [+0x060BC]  00 00                    add     [bx+si],al
F000:60BE  [+0x060BE]  00 00                    add     [bx+si],al
F000:60C0  [+0x060C0]  00 00                    add     [bx+si],al
F000:60C2  [+0x060C2]  00 00                    add     [bx+si],al
F000:60C4  [+0x060C4]  18 18                    sbb     [bx+si],bl
F000:60C6  [+0x060C6]  18 30                    sbb     [bx+si],dh
F000:60C8  [+0x060C8]  00 00                    add     [bx+si],al
F000:60CA  [+0x060CA]  00 00                    add     [bx+si],al
F000:60CC  [+0x060CC]  00 00                    add     [bx+si],al
F000:60CE  [+0x060CE]  00 00                    add     [bx+si],al
F000:60D0  [+0x060D0]  FE 00                    inc     byte [bx+si]
F000:60D2  [+0x060D2]  00 00                    add     [bx+si],al
F000:60D4  [+0x060D4]  00 00                    add     [bx+si],al
F000:60D6  [+0x060D6]  00 00                    add     [bx+si],al
F000:60D8  [+0x060D8]  00 00                    add     [bx+si],al
F000:60DA  [+0x060DA]  00 00                    add     [bx+si],al
F000:60DC  [+0x060DC]  00 00                    add     [bx+si],al
F000:60DE  [+0x060DE]  00 00                    add     [bx+si],al
F000:60E0  [+0x060E0]  00 18                    add     [bx+si],bl
F000:60E2  [+0x060E2]  18 00                    sbb     [bx+si],al
F000:60E4  [+0x060E4]  00 00                    add     [bx+si],al
F000:60E6  [+0x060E6]  00 00                    add     [bx+si],al
F000:60E8  [+0x060E8]  02 06 0C 18              add     al,[180Ch]
F000:60EC  [+0x060EC]  30 60 C0                 xor     [bx+si-40h],ah
F000:60EF  [+0x060EF]  80 00 00                 add     byte [bx+si],0
F000:60F2  [+0x060F2]  00 00                    add     [bx+si],al
F000:60F4  [+0x060F4]  00 00                    add     [bx+si],al
F000:60F6  [+0x060F6]  7C C6                    jl      short 60BEh
F000:60F8  [+0x060F8]  CE                       into
F000:60F9  [+0x060F9]  DE F6                    fdivrp  st6
F000:60FB  [+0x060FB]  E6 C6                    out     0C6h,al
F000:60FD  [+0x060FD]  DB 0xC6  (bad)
F000:60FF  [+0x060FF]  00 00                    add     [bx+si],al
F000:6101  [+0x06101]  00 00                    add     [bx+si],al
F000:6103  [+0x06103]  00 18                    add     [bx+si],bl
F000:6105  [+0x06105]  38 78 18                 cmp     [bx+si+18h],bh
F000:6108  [+0x06108]  18 18                    sbb     [bx+si],bl
F000:610A  [+0x0610A]  18 18                    sbb     [bx+si],bl
F000:610C  [+0x0610C]  7E 00                    jle     short 610Eh
F000:610E  [+0x0610E]  00 00                    add     [bx+si],al
F000:6110  [+0x06110]  00 00                    add     [bx+si],al
F000:6112  [+0x06112]  7C C6                    jl      short 60DAh
F000:6114  [+0x06114]  06                       push    es
F000:6115  [+0x06115]  0C 18                    or      al,18h
F000:6117  [+0x06117]  30 60 C6                 xor     [bx+si-3Ah],ah
F000:611A  [+0x0611A]  FE 00                    inc     byte [bx+si]
F000:611C  [+0x0611C]  00 00                    add     [bx+si],al
F000:611E  [+0x0611E]  00 00                    add     [bx+si],al
F000:6120  [+0x06120]  7C C6                    jl      short 60E8h
F000:6122  [+0x06122]  06                       push    es
F000:6123  [+0x06123]  06                       push    es
F000:6124  [+0x06124]  3C 06                    cmp     al,6
F000:6126  [+0x06126]  06                       push    es
F000:6127  [+0x06127]  DB 0xC6  (bad)
F000:6129  [+0x06129]  00 00                    add     [bx+si],al
F000:612B  [+0x0612B]  00 00                    add     [bx+si],al
F000:612D  [+0x0612D]  00 0C                    add     [si],cl
F000:612F  [+0x0612F]  1C 3C                    sbb     al,3Ch
F000:6131  [+0x06131]  6C                       insb
F000:6132  [+0x06132]  CC                       int3
F000:6133  [+0x06133]  FE 0C                    dec     byte [si]
F000:6135  [+0x06135]  0C 1E                    or      al,1Eh
F000:6137  [+0x06137]  00 00                    add     [bx+si],al
F000:6139  [+0x06139]  00 00                    add     [bx+si],al
F000:613B  [+0x0613B]  00 FE                    add     dh,bh
F000:613D  [+0x0613D]  C0 C0 FC                 rol     al,0FCh
F000:6140  [+0x06140]  0E                       push    cs
F000:6141  [+0x06141]  06                       push    es
F000:6142  [+0x06142]  06                       push    es
F000:6143  [+0x06143]  DB 0xC6  (bad)
F000:6145  [+0x06145]  00 00                    add     [bx+si],al
F000:6147  [+0x06147]  00 00                    add     [bx+si],al
F000:6149  [+0x06149]  00 38                    add     [bx+si],bh
F000:614B  [+0x0614B]  60                       pusha
F000:614C  [+0x0614C]  C0 C0 FC                 rol     al,0FCh
F000:614F  [+0x0614F]  C6 C6 C6                 mov     dh,0C6h
F000:6152  [+0x06152]  7C 00                    jl      short 6154h
F000:6154  [+0x06154]  00 00                    add     [bx+si],al
F000:6156  [+0x06156]  00 00                    add     [bx+si],al
F000:6158  [+0x06158]  FE C6                    inc     dh
F000:615A  [+0x0615A]  06                       push    es
F000:615B  [+0x0615B]  0C 18                    or      al,18h
F000:615D  [+0x0615D]  30 30                    xor     [bx+si],dh
F000:615F  [+0x0615F]  30 30                    xor     [bx+si],dh
F000:6161  [+0x06161]  00 00                    add     [bx+si],al
F000:6163  [+0x06163]  00 00                    add     [bx+si],al
F000:6165  [+0x06165]  00 7C C6                 add     [si-3Ah],bh
F000:6168  [+0x06168]  C6 C6 7C                 mov     dh,7Ch
F000:616B  [+0x0616B]  C6 C6 C6                 mov     dh,0C6h
F000:616E  [+0x0616E]  7C 00                    jl      short 6170h
F000:6170  [+0x06170]  00 00                    add     [bx+si],al
F000:6172  [+0x06172]  00 00                    add     [bx+si],al
F000:6174  [+0x06174]  7C C6                    jl      short 613Ch
F000:6176  [+0x06176]  C6 C6 7E                 mov     dh,7Eh
F000:6179  [+0x06179]  06                       push    es
F000:617A  [+0x0617A]  06                       push    es
F000:617B  [+0x0617B]  0C 78                    or      al,78h
F000:617D  [+0x0617D]  00 00                    add     [bx+si],al
F000:617F  [+0x0617F]  00 00                    add     [bx+si],al
F000:6181  [+0x06181]  00 00                    add     [bx+si],al
F000:6183  [+0x06183]  18 18                    sbb     [bx+si],bl
F000:6185  [+0x06185]  00 00                    add     [bx+si],al
F000:6187  [+0x06187]  00 18                    add     [bx+si],bl
F000:6189  [+0x06189]  18 00                    sbb     [bx+si],al
F000:618B  [+0x0618B]  00 00                    add     [bx+si],al
F000:618D  [+0x0618D]  00 00                    add     [bx+si],al
F000:618F  [+0x0618F]  00 00                    add     [bx+si],al
F000:6191  [+0x06191]  18 18                    sbb     [bx+si],bl
F000:6193  [+0x06193]  00 00                    add     [bx+si],al
F000:6195  [+0x06195]  00 18                    add     [bx+si],bl
F000:6197  [+0x06197]  18 30                    sbb     [bx+si],dh
F000:6199  [+0x06199]  00 00                    add     [bx+si],al
F000:619B  [+0x0619B]  00 00                    add     [bx+si],al
F000:619D  [+0x0619D]  00 06 0C 18              add     [180Ch],al
F000:61A1  [+0x061A1]  30 60 30                 xor     [bx+si+30h],ah
F000:61A4  [+0x061A4]  18 0C                    sbb     [si],cl
F000:61A6  [+0x061A6]  06                       push    es
F000:61A7  [+0x061A7]  00 00                    add     [bx+si],al
F000:61A9  [+0x061A9]  00 00                    add     [bx+si],al
F000:61AB  [+0x061AB]  00 00                    add     [bx+si],al
F000:61AD  [+0x061AD]  00 00                    add     [bx+si],al
F000:61AF  [+0x061AF]  FE 00                    inc     byte [bx+si]
F000:61B1  [+0x061B1]  00 FE                    add     dh,bh
F000:61B3  [+0x061B3]  00 00                    add     [bx+si],al
F000:61B5  [+0x061B5]  00 00                    add     [bx+si],al
F000:61B7  [+0x061B7]  00 00                    add     [bx+si],al
F000:61B9  [+0x061B9]  00 60 30                 add     [bx+si+30h],ah
F000:61BC  [+0x061BC]  18 0C                    sbb     [si],cl
F000:61BE  [+0x061BE]  06                       push    es
F000:61BF  [+0x061BF]  0C 18                    or      al,18h
F000:61C1  [+0x061C1]  30 60 00                 xor     [bx+si],ah
F000:61C4  [+0x061C4]  00 00                    add     [bx+si],al
F000:61C6  [+0x061C6]  00 00                    add     [bx+si],al
F000:61C8  [+0x061C8]  7C C6                    jl      short 6190h
F000:61CA  [+0x061CA]  DB 0xC6  (bad)
F000:61CC  [+0x061CC]  18 18                    sbb     [bx+si],bl
F000:61CE  [+0x061CE]  00 18                    add     [bx+si],bl
F000:61D0  [+0x061D0]  18 00                    sbb     [bx+si],al
F000:61D2  [+0x061D2]  00 00                    add     [bx+si],al
F000:61D4  [+0x061D4]  00 00                    add     [bx+si],al
F000:61D6  [+0x061D6]  7C C6                    jl      short 619Eh
F000:61D8  [+0x061D8]  DB 0xC6  (bad)
F000:61DA  [+0x061DA]  DB 0xDE  (bad)
F000:61DD  [+0x061DD]  C0 7C 00 00              sar     byte [si],0
F000:61E1  [+0x061E1]  00 00                    add     [bx+si],al
F000:61E3  [+0x061E3]  00 10                    add     [bx+si],dl
F000:61E5  [+0x061E5]  38 6C C6                 cmp     [si-3Ah],ch
F000:61E8  [+0x061E8]  DB 0xC6  (bad)
F000:61EA  [+0x061EA]  C6 C6 C6                 mov     dh,0C6h
F000:61ED  [+0x061ED]  00 00                    add     [bx+si],al
F000:61EF  [+0x061EF]  00 00                    add     [bx+si],al
F000:61F1  [+0x061F1]  00 FC                    add     ah,bh
F000:61F3  [+0x061F3]  66 66 66 7C 66           o32 jl  short 0000625Eh
F000:61F8  [+0x061F8]  66 66 FC                 cld
F000:61FB  [+0x061FB]  00 00                    add     [bx+si],al
F000:61FD  [+0x061FD]  00 00                    add     [bx+si],al
F000:61FF  [+0x061FF]  00 3C                    add     [si],bh
F000:6201  [+0x06201]  66 C2 C0 C0              retd    0C0C0h
F000:6205  [+0x06205]  C0 C2 66                 rol     dl,66h
F000:6208  [+0x06208]  3C 00                    cmp     al,0
F000:620A  [+0x0620A]  00 00                    add     [bx+si],al
F000:620C  [+0x0620C]  00 00                    add     [bx+si],al
F000:620E  [+0x0620E]  F8                       clc
F000:620F  [+0x0620F]  6C                       insb
F000:6210  [+0x06210]  66 66 66 66 66 6C        insb
F000:6216  [+0x06216]  F8                       clc
F000:6217  [+0x06217]  00 00                    add     [bx+si],al
F000:6219  [+0x06219]  00 00                    add     [bx+si],al
F000:621B  [+0x0621B]  00 FE                    add     dh,bh
F000:621D  [+0x0621D]  66 62 68 78              bound   ebp,[bx+si+78h]
F000:6221  [+0x06221]  68 62 66                 push    6662h
F000:6224  [+0x06224]  FE 00                    inc     byte [bx+si]
F000:6226  [+0x06226]  00 00                    add     [bx+si],al
F000:6228  [+0x06228]  00 00                    add     [bx+si],al
F000:622A  [+0x0622A]  DB 0xFE  (bad)
F000:622C  [+0x0622C]  62 68 78                 bound   bp,[bx+si+78h]
F000:622F  [+0x0622F]  68 60 60                 push    6060h
F000:6232  [+0x06232]  F0 00 00                 lock add [bx+si],al
F000:6235  [+0x06235]  00 00                    add     [bx+si],al
F000:6237  [+0x06237]  00 3C                    add     [si],bh
F000:6239  [+0x06239]  66 C2 C0 C0              retd    0C0C0h
F000:623D  [+0x0623D]  DE C6                    faddp   st6
F000:623F  [+0x0623F]  66 3A 00                 cmp     al,[bx+si]
F000:6242  [+0x06242]  00 00                    add     [bx+si],al
F000:6244  [+0x06244]  00 00                    add     [bx+si],al
F000:6246  [+0x06246]  C6 C6 C6                 mov     dh,0C6h
F000:6249  [+0x06249]  DB 0xC6  (bad)
F000:624B  [+0x0624B]  C6 C6 C6                 mov     dh,0C6h
F000:624E  [+0x0624E]  C6 00 00                 mov     byte [bx+si],0
F000:6251  [+0x06251]  00 00                    add     [bx+si],al
F000:6253  [+0x06253]  00 3C                    add     [si],bh
F000:6255  [+0x06255]  18 18                    sbb     [bx+si],bl
F000:6257  [+0x06257]  18 18                    sbb     [bx+si],bl
F000:6259  [+0x06259]  18 18                    sbb     [bx+si],bl
F000:625B  [+0x0625B]  18 3C                    sbb     [si],bh
F000:625D  [+0x0625D]  00 00                    add     [bx+si],al
F000:625F  [+0x0625F]  00 00                    add     [bx+si],al
F000:6261  [+0x06261]  00 1E 0C 0C              add     [0C0Ch],bl
F000:6265  [+0x06265]  0C 0C                    or      al,0Ch
F000:6267  [+0x06267]  0C CC                    or      al,0CCh
F000:6269  [+0x06269]  CC                       int3
F000:626A  [+0x0626A]  78 00                    js      short 626Ch
F000:626C  [+0x0626C]  00 00                    add     [bx+si],al
F000:626E  [+0x0626E]  00 00                    add     [bx+si],al
F000:6270  [+0x06270]  E6 66                    out     66h,al
F000:6272  [+0x06272]  6C                       insb
F000:6273  [+0x06273]  6C                       insb
F000:6274  [+0x06274]  78 6C                    js      short 62E2h
F000:6276  [+0x06276]  6C                       insb
F000:6277  [+0x06277]  66 E6 00                 out     0,al
F000:627A  [+0x0627A]  00 00                    add     [bx+si],al
F000:627C  [+0x0627C]  00 00                    add     [bx+si],al
F000:627E  [+0x0627E]  DB 0xF0  (bad)
F000:6280  [+0x06280]  60                       pusha
F000:6281  [+0x06281]  60                       pusha
F000:6282  [+0x06282]  60                       pusha
F000:6283  [+0x06283]  60                       pusha
F000:6284  [+0x06284]  62 66 FE                 bound   sp,[bp-2]
F000:6287  [+0x06287]  00 00                    add     [bx+si],al
F000:6289  [+0x06289]  00 00                    add     [bx+si],al
F000:628B  [+0x0628B]  00 C6                    add     dh,al
F000:628D  [+0x0628D]  EE                       out     dx,al
F000:628E  [+0x0628E]  DB 0xFE  (bad)
F000:6290  [+0x06290]  D6                       salc
F000:6291  [+0x06291]  C6 C6 C6                 mov     dh,0C6h
F000:6294  [+0x06294]  C6 00 00                 mov     byte [bx+si],0
F000:6297  [+0x06297]  00 00                    add     [bx+si],al
F000:6299  [+0x06299]  00 C6                    add     dh,al
F000:629B  [+0x0629B]  E6 F6                    out     0F6h,al
F000:629D  [+0x0629D]  DB 0xFE  (bad)
F000:629F  [+0x0629F]  CE                       into
F000:62A0  [+0x062A0]  C6 C6 C6                 mov     dh,0C6h
F000:62A3  [+0x062A3]  00 00                    add     [bx+si],al
F000:62A5  [+0x062A5]  00 00                    add     [bx+si],al
F000:62A7  [+0x062A7]  00 38                    add     [bx+si],bh
F000:62A9  [+0x062A9]  6C                       insb
F000:62AA  [+0x062AA]  C6 C6 C6                 mov     dh,0C6h
F000:62AD  [+0x062AD]  C6 C6 6C                 mov     dh,6Ch
F000:62B0  [+0x062B0]  38 00                    cmp     [bx+si],al
F000:62B2  [+0x062B2]  00 00                    add     [bx+si],al
F000:62B4  [+0x062B4]  00 00                    add     [bx+si],al
F000:62B6  [+0x062B6]  FC                       cld
F000:62B7  [+0x062B7]  66 66 66 7C 60           o32 jl  short 0000631Ch
F000:62BC  [+0x062BC]  60                       pusha
F000:62BD  [+0x062BD]  60                       pusha
F000:62BE  [+0x062BE]  F0 00 00                 lock add [bx+si],al
F000:62C1  [+0x062C1]  00 00                    add     [bx+si],al
F000:62C3  [+0x062C3]  00 7C C6                 add     [si-3Ah],bh
F000:62C6  [+0x062C6]  C6 C6 C6                 mov     dh,0C6h
F000:62C9  [+0x062C9]  D6                       salc
F000:62CA  [+0x062CA]  DE 7C 0C                 fidivr  word [si+0Ch]
F000:62CD  [+0x062CD]  0E                       push    cs
F000:62CE  [+0x062CE]  00 00                    add     [bx+si],al
F000:62D0  [+0x062D0]  00 00                    add     [bx+si],al
F000:62D2  [+0x062D2]  FC                       cld
F000:62D3  [+0x062D3]  66 66 66 7C 6C           o32 jl  short 00006344h
F000:62D8  [+0x062D8]  66 66 E6 00              out     0,al
F000:62DC  [+0x062DC]  00 00                    add     [bx+si],al
F000:62DE  [+0x062DE]  00 00                    add     [bx+si],al
F000:62E0  [+0x062E0]  7C C6                    jl      short 62A8h
F000:62E2  [+0x062E2]  DB 0xC6  (bad)
F000:62E4  [+0x062E4]  38 0C                    cmp     [si],cl
F000:62E6  [+0x062E6]  C6 C6 7C                 mov     dh,7Ch
F000:62E9  [+0x062E9]  00 00                    add     [bx+si],al
F000:62EB  [+0x062EB]  00 00                    add     [bx+si],al
F000:62ED  [+0x062ED]  00 7E 7E                 add     [bp+7Eh],bh
F000:62F0  [+0x062F0]  5A                       pop     dx
F000:62F1  [+0x062F1]  18 18                    sbb     [bx+si],bl
F000:62F3  [+0x062F3]  18 18                    sbb     [bx+si],bl
F000:62F5  [+0x062F5]  18 3C                    sbb     [si],bh
F000:62F7  [+0x062F7]  00 00                    add     [bx+si],al
F000:62F9  [+0x062F9]  00 00                    add     [bx+si],al
F000:62FB  [+0x062FB]  00 C6                    add     dh,al
F000:62FD  [+0x062FD]  C6 C6 C6                 mov     dh,0C6h
F000:6300  [+0x06300]  C6 C6 C6                 mov     dh,0C6h
F000:6303  [+0x06303]  DB 0xC6  (bad)
F000:6305  [+0x06305]  00 00                    add     [bx+si],al
F000:6307  [+0x06307]  00 00                    add     [bx+si],al
F000:6309  [+0x06309]  00 C6                    add     dh,al
F000:630B  [+0x0630B]  C6 C6 C6                 mov     dh,0C6h
F000:630E  [+0x0630E]  C6 C6 6C                 mov     dh,6Ch
F000:6311  [+0x06311]  38 10                    cmp     [bx+si],dl
F000:6313  [+0x06313]  00 00                    add     [bx+si],al
F000:6315  [+0x06315]  00 00                    add     [bx+si],al
F000:6317  [+0x06317]  00 C6                    add     dh,al
F000:6319  [+0x06319]  C6 C6 C6                 mov     dh,0C6h
F000:631C  [+0x0631C]  D6                       salc
F000:631D  [+0x0631D]  D6                       salc
F000:631E  [+0x0631E]  DB 0xFE  (bad)
F000:6320  [+0x06320]  6C                       insb
F000:6321  [+0x06321]  00 00                    add     [bx+si],al
F000:6323  [+0x06323]  00 00                    add     [bx+si],al
F000:6325  [+0x06325]  00 C6                    add     dh,al
F000:6327  [+0x06327]  DB 0xC6  (bad)
F000:6329  [+0x06329]  38 38                    cmp     [bx+si],bh
F000:632B  [+0x0632B]  38 6C C6                 cmp     [si-3Ah],ch
F000:632E  [+0x0632E]  C6 00 00                 mov     byte [bx+si],0
F000:6331  [+0x06331]  00 00                    add     [bx+si],al
F000:6333  [+0x06333]  00 66 66                 add     [bp+66h],ah
F000:6336  [+0x06336]  66 66 3C 18              cmp     al,18h
F000:633A  [+0x0633A]  18 18                    sbb     [bx+si],bl
F000:633C  [+0x0633C]  3C 00                    cmp     al,0
F000:633E  [+0x0633E]  00 00                    add     [bx+si],al
F000:6340  [+0x06340]  00 00                    add     [bx+si],al
F000:6342  [+0x06342]  FE C6                    inc     dh
F000:6344  [+0x06344]  8C 18                    mov     [bx+si],ds
F000:6346  [+0x06346]  30 60 C2                 xor     [bx+si-3Eh],ah
F000:6349  [+0x06349]  DB 0xC6  (bad)
F000:634B  [+0x0634B]  00 00                    add     [bx+si],al
F000:634D  [+0x0634D]  00 00                    add     [bx+si],al
F000:634F  [+0x0634F]  00 3C                    add     [si],bh
F000:6351  [+0x06351]  30 30                    xor     [bx+si],dh
F000:6353  [+0x06353]  30 30                    xor     [bx+si],dh
F000:6355  [+0x06355]  30 30                    xor     [bx+si],dh
F000:6357  [+0x06357]  30 3C                    xor     [si],bh
F000:6359  [+0x06359]  00 00                    add     [bx+si],al
F000:635B  [+0x0635B]  00 00                    add     [bx+si],al
F000:635D  [+0x0635D]  00 80 C0 E0              add     [bx+si-1F40h],al
F000:6361  [+0x06361]  70 38                    jo      short 639Bh
F000:6363  [+0x06363]  1C 0E                    sbb     al,0Eh
F000:6365  [+0x06365]  06                       push    es
F000:6366  [+0x06366]  02 00                    add     al,[bx+si]
F000:6368  [+0x06368]  00 00                    add     [bx+si],al
F000:636A  [+0x0636A]  00 00                    add     [bx+si],al
F000:636C  [+0x0636C]  3C 0C                    cmp     al,0Ch
F000:636E  [+0x0636E]  0C 0C                    or      al,0Ch
F000:6370  [+0x06370]  0C 0C                    or      al,0Ch
F000:6372  [+0x06372]  0C 0C                    or      al,0Ch
F000:6374  [+0x06374]  3C 00                    cmp     al,0
F000:6376  [+0x06376]  00 00                    add     [bx+si],al
F000:6378  [+0x06378]  10 38                    adc     [bx+si],bh
F000:637A  [+0x0637A]  6C                       insb
F000:637B  [+0x0637B]  C6 00 00                 mov     byte [bx+si],0
F000:637E  [+0x0637E]  00 00                    add     [bx+si],al
F000:6380  [+0x06380]  00 00                    add     [bx+si],al
F000:6382  [+0x06382]  00 00                    add     [bx+si],al
F000:6384  [+0x06384]  00 00                    add     [bx+si],al
F000:6386  [+0x06386]  00 00                    add     [bx+si],al
F000:6388  [+0x06388]  00 00                    add     [bx+si],al
F000:638A  [+0x0638A]  00 00                    add     [bx+si],al
F000:638C  [+0x0638C]  00 00                    add     [bx+si],al
F000:638E  [+0x0638E]  00 00                    add     [bx+si],al
F000:6390  [+0x06390]  00 00                    add     [bx+si],al
F000:6392  [+0x06392]  FF 00                    inc     word [bx+si]
F000:6394  [+0x06394]  30 30                    xor     [bx+si],dh
F000:6396  [+0x06396]  18 00                    sbb     [bx+si],al
F000:6398  [+0x06398]  00 00                    add     [bx+si],al
F000:639A  [+0x0639A]  00 00                    add     [bx+si],al
F000:639C  [+0x0639C]  00 00                    add     [bx+si],al
F000:639E  [+0x0639E]  00 00                    add     [bx+si],al
F000:63A0  [+0x063A0]  00 00                    add     [bx+si],al
F000:63A2  [+0x063A2]  00 00                    add     [bx+si],al
F000:63A4  [+0x063A4]  00 00                    add     [bx+si],al
F000:63A6  [+0x063A6]  00 78 0C                 add     [bx+si+0Ch],bh
F000:63A9  [+0x063A9]  7C CC                    jl      short 6377h
F000:63AB  [+0x063AB]  CC                       int3
F000:63AC  [+0x063AC]  76 00                    jbe     short 63AEh
F000:63AE  [+0x063AE]  00 00                    add     [bx+si],al
F000:63B0  [+0x063B0]  00 00                    add     [bx+si],al
F000:63B2  [+0x063B2]  E0 60                    loopne  6414h
F000:63B4  [+0x063B4]  60                       pusha
F000:63B5  [+0x063B5]  78 6C                    js      short 6423h
F000:63B7  [+0x063B7]  66 66 66 DC 00           fadd    qword [bx+si]
F000:63BC  [+0x063BC]  00 00                    add     [bx+si],al
F000:63BE  [+0x063BE]  00 00                    add     [bx+si],al
F000:63C0  [+0x063C0]  00 00                    add     [bx+si],al
F000:63C2  [+0x063C2]  00 7C C6                 add     [si-3Ah],bh
F000:63C5  [+0x063C5]  C0 C0 C6                 rol     al,0C6h
F000:63C8  [+0x063C8]  7C 00                    jl      short 63CAh
F000:63CA  [+0x063CA]  00 00                    add     [bx+si],al
F000:63CC  [+0x063CC]  00 00                    add     [bx+si],al
F000:63CE  [+0x063CE]  1C 0C                    sbb     al,0Ch
F000:63D0  [+0x063D0]  0C 3C                    or      al,3Ch
F000:63D2  [+0x063D2]  6C                       insb
F000:63D3  [+0x063D3]  CC                       int3
F000:63D4  [+0x063D4]  CC                       int3
F000:63D5  [+0x063D5]  CC                       int3
F000:63D6  [+0x063D6]  76 00                    jbe     short 63D8h
F000:63D8  [+0x063D8]  00 00                    add     [bx+si],al
F000:63DA  [+0x063DA]  00 00                    add     [bx+si],al
F000:63DC  [+0x063DC]  00 00                    add     [bx+si],al
F000:63DE  [+0x063DE]  00 7C C6                 add     [si-3Ah],bh
F000:63E1  [+0x063E1]  FE C0                    inc     al
F000:63E3  [+0x063E3]  DB 0xC6  (bad)
F000:63E5  [+0x063E5]  00 00                    add     [bx+si],al
F000:63E7  [+0x063E7]  00 00                    add     [bx+si],al
F000:63E9  [+0x063E9]  00 38                    add     [bx+si],bh
F000:63EB  [+0x063EB]  6C                       insb
F000:63EC  [+0x063EC]  64 60                    pusha
F000:63EE  [+0x063EE]  DB 0xF0  (bad)
F000:63F0  [+0x063F0]  60                       pusha
F000:63F1  [+0x063F1]  60                       pusha
F000:63F2  [+0x063F2]  F0 00 00                 lock add [bx+si],al
F000:63F5  [+0x063F5]  00 00                    add     [bx+si],al
F000:63F7  [+0x063F7]  00 00                    add     [bx+si],al
F000:63F9  [+0x063F9]  00 00                    add     [bx+si],al
F000:63FB  [+0x063FB]  76 CC                    jbe     short 63C9h
F000:63FD  [+0x063FD]  CC                       int3
F000:63FE  [+0x063FE]  CC                       int3
F000:63FF  [+0x063FF]  7C 0C                    jl      short 640Dh
F000:6401  [+0x06401]  CC                       int3
F000:6402  [+0x06402]  78 00                    js      short 6404h
F000:6404  [+0x06404]  00 00                    add     [bx+si],al
F000:6406  [+0x06406]  E0 60                    loopne  6468h
F000:6408  [+0x06408]  60                       pusha
F000:6409  [+0x06409]  6C                       insb
F000:640A  [+0x0640A]  76 66                    jbe     short 6472h
F000:640C  [+0x0640C]  66 66 E6 00              out     0,al
F000:6410  [+0x06410]  00 00                    add     [bx+si],al
F000:6412  [+0x06412]  00 00                    add     [bx+si],al
F000:6414  [+0x06414]  18 18                    sbb     [bx+si],bl
F000:6416  [+0x06416]  00 38                    add     [bx+si],bh
F000:6418  [+0x06418]  18 18                    sbb     [bx+si],bl
F000:641A  [+0x0641A]  18 18                    sbb     [bx+si],bl
F000:641C  [+0x0641C]  3C 00                    cmp     al,0
F000:641E  [+0x0641E]  00 00                    add     [bx+si],al
F000:6420  [+0x06420]  00 00                    add     [bx+si],al
F000:6422  [+0x06422]  06                       push    es
F000:6423  [+0x06423]  06                       push    es
F000:6424  [+0x06424]  00 0E 06 06              add     [606h],cl
F000:6428  [+0x06428]  06                       push    es
F000:6429  [+0x06429]  06                       push    es
F000:642A  [+0x0642A]  66 66 3C 00              cmp     al,0
F000:642E  [+0x0642E]  00 00                    add     [bx+si],al
F000:6430  [+0x06430]  E0 60                    loopne  6492h
F000:6432  [+0x06432]  60                       pusha
F000:6433  [+0x06433]  66 6C                    insb
F000:6435  [+0x06435]  78 6C                    js      short 64A3h
F000:6437  [+0x06437]  66 E6 00                 out     0,al
F000:643A  [+0x0643A]  00 00                    add     [bx+si],al
F000:643C  [+0x0643C]  00 00                    add     [bx+si],al
F000:643E  [+0x0643E]  38 18                    cmp     [bx+si],bl
F000:6440  [+0x06440]  18 18                    sbb     [bx+si],bl
F000:6442  [+0x06442]  18 18                    sbb     [bx+si],bl
F000:6444  [+0x06444]  18 18                    sbb     [bx+si],bl
F000:6446  [+0x06446]  3C 00                    cmp     al,0
F000:6448  [+0x06448]  00 00                    add     [bx+si],al
F000:644A  [+0x0644A]  00 00                    add     [bx+si],al
F000:644C  [+0x0644C]  00 00                    add     [bx+si],al
F000:644E  [+0x0644E]  00 EC                    add     ah,ch
F000:6450  [+0x06450]  DB 0xFE  (bad)
F000:6452  [+0x06452]  D6                       salc
F000:6453  [+0x06453]  D6                       salc
F000:6454  [+0x06454]  D6                       salc
F000:6455  [+0x06455]  00 00                    add     [bx+si],al
F000:6457  [+0x06457]  00 00                    add     [bx+si],al
F000:6459  [+0x06459]  00 00                    add     [bx+si],al
F000:645B  [+0x0645B]  00 00                    add     [bx+si],al
F000:645D  [+0x0645D]  DC 66 66                 fsub    qword [bp+66h]
F000:6460  [+0x06460]  66 66 66 00 00           add     [bx+si],al
F000:6465  [+0x06465]  00 00                    add     [bx+si],al
F000:6467  [+0x06467]  00 00                    add     [bx+si],al
F000:6469  [+0x06469]  00 00                    add     [bx+si],al
F000:646B  [+0x0646B]  7C C6                    jl      short 6433h
F000:646D  [+0x0646D]  C6 C6 C6                 mov     dh,0C6h
F000:6470  [+0x06470]  7C 00                    jl      short 6472h
F000:6472  [+0x06472]  00 00                    add     [bx+si],al
F000:6474  [+0x06474]  00 00                    add     [bx+si],al
F000:6476  [+0x06476]  00 00                    add     [bx+si],al
F000:6478  [+0x06478]  00 DC                    add     ah,bl
F000:647A  [+0x0647A]  66 66 66 7C 60           o32 jl  short 000064DFh
F000:647F  [+0x0647F]  60                       pusha
F000:6480  [+0x06480]  F0 00 00                 lock add [bx+si],al
F000:6483  [+0x06483]  00 00                    add     [bx+si],al
F000:6485  [+0x06485]  00 00                    add     [bx+si],al
F000:6487  [+0x06487]  76 CC                    jbe     short 6455h
F000:6489  [+0x06489]  CC                       int3
F000:648A  [+0x0648A]  CC                       int3
F000:648B  [+0x0648B]  7C 0C                    jl      short 6499h
F000:648D  [+0x0648D]  0C 1E                    or      al,1Eh
F000:648F  [+0x0648F]  00 00                    add     [bx+si],al
F000:6491  [+0x06491]  00 00                    add     [bx+si],al
F000:6493  [+0x06493]  00 00                    add     [bx+si],al
F000:6495  [+0x06495]  DC 76 62                 fdiv    qword [bp+62h]
F000:6498  [+0x06498]  60                       pusha
F000:6499  [+0x06499]  60                       pusha
F000:649A  [+0x0649A]  F0 00 00                 lock add [bx+si],al
F000:649D  [+0x0649D]  00 00                    add     [bx+si],al
F000:649F  [+0x0649F]  00 00                    add     [bx+si],al
F000:64A1  [+0x064A1]  00 00                    add     [bx+si],al
F000:64A3  [+0x064A3]  7C C6                    jl      short 646Bh
F000:64A5  [+0x064A5]  70 1C                    jo      short 64C3h
F000:64A7  [+0x064A7]  DB 0xC6  (bad)
F000:64A9  [+0x064A9]  00 00                    add     [bx+si],al
F000:64AB  [+0x064AB]  00 00                    add     [bx+si],al
F000:64AD  [+0x064AD]  00 10                    add     [bx+si],dl
F000:64AF  [+0x064AF]  30 30                    xor     [bx+si],dh
F000:64B1  [+0x064B1]  FC                       cld
F000:64B2  [+0x064B2]  30 30                    xor     [bx+si],dh
F000:64B4  [+0x064B4]  30 36 1C 00              xor     [1Ch],dh
F000:64B8  [+0x064B8]  00 00                    add     [bx+si],al
F000:64BA  [+0x064BA]  00 00                    add     [bx+si],al
F000:64BC  [+0x064BC]  00 00                    add     [bx+si],al
F000:64BE  [+0x064BE]  00 CC                    add     ah,cl
F000:64C0  [+0x064C0]  CC                       int3
F000:64C1  [+0x064C1]  CC                       int3
F000:64C2  [+0x064C2]  CC                       int3
F000:64C3  [+0x064C3]  CC                       int3
F000:64C4  [+0x064C4]  76 00                    jbe     short 64C6h
F000:64C6  [+0x064C6]  00 00                    add     [bx+si],al
F000:64C8  [+0x064C8]  00 00                    add     [bx+si],al
F000:64CA  [+0x064CA]  00 00                    add     [bx+si],al
F000:64CC  [+0x064CC]  00 66 66                 add     [bp+66h],ah
F000:64CF  [+0x064CF]  66 66 3C 18              cmp     al,18h
F000:64D3  [+0x064D3]  00 00                    add     [bx+si],al
F000:64D5  [+0x064D5]  00 00                    add     [bx+si],al
F000:64D7  [+0x064D7]  00 00                    add     [bx+si],al
F000:64D9  [+0x064D9]  00 00                    add     [bx+si],al
F000:64DB  [+0x064DB]  C6 C6 D6                 mov     dh,0D6h
F000:64DE  [+0x064DE]  D6                       salc
F000:64DF  [+0x064DF]  DB 0xFE  (bad)
F000:64E1  [+0x064E1]  00 00                    add     [bx+si],al
F000:64E3  [+0x064E3]  00 00                    add     [bx+si],al
F000:64E5  [+0x064E5]  00 00                    add     [bx+si],al
F000:64E7  [+0x064E7]  00 00                    add     [bx+si],al
F000:64E9  [+0x064E9]  DB 0xC6  (bad)
F000:64EB  [+0x064EB]  38 38                    cmp     [bx+si],bh
F000:64ED  [+0x064ED]  6C                       insb
F000:64EE  [+0x064EE]  C6 00 00                 mov     byte [bx+si],0
F000:64F1  [+0x064F1]  00 00                    add     [bx+si],al
F000:64F3  [+0x064F3]  00 00                    add     [bx+si],al
F000:64F5  [+0x064F5]  00 00                    add     [bx+si],al
F000:64F7  [+0x064F7]  C6 C6 C6                 mov     dh,0C6h
F000:64FA  [+0x064FA]  DB 0xC6  (bad)
F000:64FC  [+0x064FC]  06                       push    es
F000:64FD  [+0x064FD]  0C F8                    or      al,0F8h
F000:64FF  [+0x064FF]  00 00                    add     [bx+si],al
F000:6501  [+0x06501]  00 00                    add     [bx+si],al
F000:6503  [+0x06503]  00 00                    add     [bx+si],al
F000:6505  [+0x06505]  FE CC                    dec     ah
F000:6507  [+0x06507]  18 30                    sbb     [bx+si],dh
F000:6509  [+0x06509]  66 FE 00                 inc     byte [bx+si]
F000:650C  [+0x0650C]  00 00                    add     [bx+si],al
F000:650E  [+0x0650E]  00 00                    add     [bx+si],al
F000:6510  [+0x06510]  0E                       push    cs
F000:6511  [+0x06511]  18 18                    sbb     [bx+si],bl
F000:6513  [+0x06513]  18 70 18                 sbb     [bx+si+18h],dh
F000:6516  [+0x06516]  18 18                    sbb     [bx+si],bl
F000:6518  [+0x06518]  0E                       push    cs
F000:6519  [+0x06519]  00 00                    add     [bx+si],al
F000:651B  [+0x0651B]  00 00                    add     [bx+si],al
F000:651D  [+0x0651D]  00 18                    add     [bx+si],bl
F000:651F  [+0x0651F]  18 18                    sbb     [bx+si],bl
F000:6521  [+0x06521]  18 00                    sbb     [bx+si],al
F000:6523  [+0x06523]  18 18                    sbb     [bx+si],bl
F000:6525  [+0x06525]  18 18                    sbb     [bx+si],bl
F000:6527  [+0x06527]  00 00                    add     [bx+si],al
F000:6529  [+0x06529]  00 00                    add     [bx+si],al
F000:652B  [+0x0652B]  00 70 18                 add     [bx+si+18h],dh
F000:652E  [+0x0652E]  18 18                    sbb     [bx+si],bl
F000:6530  [+0x06530]  0E                       push    cs
F000:6531  [+0x06531]  18 18                    sbb     [bx+si],bl
F000:6533  [+0x06533]  18 70 00                 sbb     [bx+si],dh
F000:6536  [+0x06536]  00 00                    add     [bx+si],al
F000:6538  [+0x06538]  00 00                    add     [bx+si],al
F000:653A  [+0x0653A]  76 DC                    jbe     short 6518h
F000:653C  [+0x0653C]  00 00                    add     [bx+si],al
F000:653E  [+0x0653E]  00 00                    add     [bx+si],al
F000:6540  [+0x06540]  00 00                    add     [bx+si],al
F000:6542  [+0x06542]  00 00                    add     [bx+si],al
F000:6544  [+0x06544]  00 00                    add     [bx+si],al
F000:6546  [+0x06546]  00 00                    add     [bx+si],al
F000:6548  [+0x06548]  00 00                    add     [bx+si],al
F000:654A  [+0x0654A]  10 38                    adc     [bx+si],bh
F000:654C  [+0x0654C]  6C                       insb
F000:654D  [+0x0654D]  C6 C6 FE                 mov     dh,0FEh
F000:6550  [+0x06550]  00 00                    add     [bx+si],al
F000:6552  [+0x06552]  00 00                    add     [bx+si],al
F000:6554  [+0x06554]  00 00                    add     [bx+si],al
F000:6556  [+0x06556]  3C 66                    cmp     al,66h
F000:6558  [+0x06558]  C2 C0 C0                 ret     0C0C0h
F000:655B  [+0x0655B]  C2 66 3C                 ret     3C66h
F000:655E  [+0x0655E]  0C 06                    or      al,6
F000:6560  [+0x06560]  7C 00                    jl      short 6562h
F000:6562  [+0x06562]  00 00                    add     [bx+si],al
F000:6564  [+0x06564]  CC                       int3
F000:6565  [+0x06565]  CC                       int3
F000:6566  [+0x06566]  00 CC                    add     ah,cl
F000:6568  [+0x06568]  CC                       int3
F000:6569  [+0x06569]  CC                       int3
F000:656A  [+0x0656A]  CC                       int3
F000:656B  [+0x0656B]  CC                       int3
F000:656C  [+0x0656C]  76 00                    jbe     short 656Eh
F000:656E  [+0x0656E]  00 00                    add     [bx+si],al
F000:6570  [+0x06570]  00 0C                    add     [si],cl
F000:6572  [+0x06572]  18 30                    sbb     [bx+si],dh
F000:6574  [+0x06574]  00 7C C6                 add     [si-3Ah],bh
F000:6577  [+0x06577]  FE C0                    inc     al
F000:6579  [+0x06579]  DB 0xC6  (bad)
F000:657B  [+0x0657B]  00 00                    add     [bx+si],al
F000:657D  [+0x0657D]  00 00                    add     [bx+si],al
F000:657F  [+0x0657F]  10 38                    adc     [bx+si],bh
F000:6581  [+0x06581]  6C                       insb
F000:6582  [+0x06582]  00 78 0C                 add     [bx+si+0Ch],bh
F000:6585  [+0x06585]  7C CC                    jl      short 6553h
F000:6587  [+0x06587]  CC                       int3
F000:6588  [+0x06588]  76 00                    jbe     short 658Ah
F000:658A  [+0x0658A]  00 00                    add     [bx+si],al
F000:658C  [+0x0658C]  00 00                    add     [bx+si],al
F000:658E  [+0x0658E]  CC                       int3
F000:658F  [+0x0658F]  CC                       int3
F000:6590  [+0x06590]  00 78 0C                 add     [bx+si+0Ch],bh
F000:6593  [+0x06593]  7C CC                    jl      short 6561h
F000:6595  [+0x06595]  CC                       int3
F000:6596  [+0x06596]  76 00                    jbe     short 6598h
F000:6598  [+0x06598]  00 00                    add     [bx+si],al
F000:659A  [+0x0659A]  00 60 30                 add     [bx+si+30h],ah
F000:659D  [+0x0659D]  18 00                    sbb     [bx+si],al
F000:659F  [+0x0659F]  78 0C                    js      short 65ADh
F000:65A1  [+0x065A1]  7C CC                    jl      short 656Fh
F000:65A3  [+0x065A3]  CC                       int3
F000:65A4  [+0x065A4]  76 00                    jbe     short 65A6h
F000:65A6  [+0x065A6]  00 00                    add     [bx+si],al
F000:65A8  [+0x065A8]  00 38                    add     [bx+si],bh
F000:65AA  [+0x065AA]  6C                       insb
F000:65AB  [+0x065AB]  38 00                    cmp     [bx+si],al
F000:65AD  [+0x065AD]  78 0C                    js      short 65BBh
F000:65AF  [+0x065AF]  7C CC                    jl      short 657Dh
F000:65B1  [+0x065B1]  CC                       int3
F000:65B2  [+0x065B2]  76 00                    jbe     short 65B4h
F000:65B4  [+0x065B4]  00 00                    add     [bx+si],al
F000:65B6  [+0x065B6]  00 00                    add     [bx+si],al
F000:65B8  [+0x065B8]  00 00                    add     [bx+si],al
F000:65BA  [+0x065BA]  3C 66                    cmp     al,66h
F000:65BC  [+0x065BC]  60                       pusha
F000:65BD  [+0x065BD]  66 3C 0C                 cmp     al,0Ch
F000:65C0  [+0x065C0]  06                       push    es
F000:65C1  [+0x065C1]  3C 00                    cmp     al,0
F000:65C3  [+0x065C3]  00 00                    add     [bx+si],al
F000:65C5  [+0x065C5]  10 38                    adc     [bx+si],bh
F000:65C7  [+0x065C7]  6C                       insb
F000:65C8  [+0x065C8]  00 7C C6                 add     [si-3Ah],bh
F000:65CB  [+0x065CB]  FE C0                    inc     al
F000:65CD  [+0x065CD]  DB 0xC6  (bad)
F000:65CF  [+0x065CF]  00 00                    add     [bx+si],al
F000:65D1  [+0x065D1]  00 00                    add     [bx+si],al
F000:65D3  [+0x065D3]  00 CC                    add     ah,cl
F000:65D5  [+0x065D5]  CC                       int3
F000:65D6  [+0x065D6]  00 7C C6                 add     [si-3Ah],bh
F000:65D9  [+0x065D9]  FE C0                    inc     al
F000:65DB  [+0x065DB]  DB 0xC6  (bad)
F000:65DD  [+0x065DD]  00 00                    add     [bx+si],al
F000:65DF  [+0x065DF]  00 00                    add     [bx+si],al
F000:65E1  [+0x065E1]  60                       pusha
F000:65E2  [+0x065E2]  30 18                    xor     [bx+si],bl
F000:65E4  [+0x065E4]  00 7C C6                 add     [si-3Ah],bh
F000:65E7  [+0x065E7]  FE C0                    inc     al
F000:65E9  [+0x065E9]  DB 0xC6  (bad)
F000:65EB  [+0x065EB]  00 00                    add     [bx+si],al
F000:65ED  [+0x065ED]  00 00                    add     [bx+si],al
F000:65EF  [+0x065EF]  00 66 66                 add     [bp+66h],ah
F000:65F2  [+0x065F2]  00 38                    add     [bx+si],bh
F000:65F4  [+0x065F4]  18 18                    sbb     [bx+si],bl
F000:65F6  [+0x065F6]  18 18                    sbb     [bx+si],bl
F000:65F8  [+0x065F8]  3C 00                    cmp     al,0
F000:65FA  [+0x065FA]  00 00                    add     [bx+si],al
F000:65FC  [+0x065FC]  00 18                    add     [bx+si],bl
F000:65FE  [+0x065FE]  3C 66                    cmp     al,66h
F000:6600  [+0x06600]  00 38                    add     [bx+si],bh
F000:6602  [+0x06602]  18 18                    sbb     [bx+si],bl
F000:6604  [+0x06604]  18 18                    sbb     [bx+si],bl
F000:6606  [+0x06606]  3C 00                    cmp     al,0
F000:6608  [+0x06608]  00 00                    add     [bx+si],al
F000:660A  [+0x0660A]  00 60 30                 add     [bx+si+30h],ah
F000:660D  [+0x0660D]  18 00                    sbb     [bx+si],al
F000:660F  [+0x0660F]  38 18                    cmp     [bx+si],bl
F000:6611  [+0x06611]  18 18                    sbb     [bx+si],bl
F000:6613  [+0x06613]  18 3C                    sbb     [si],bh
F000:6615  [+0x06615]  00 00                    add     [bx+si],al
F000:6617  [+0x06617]  00 00                    add     [bx+si],al
F000:6619  [+0x06619]  C6 C6 10                 mov     dh,10h
F000:661C  [+0x0661C]  38 6C C6                 cmp     [si-3Ah],ch
F000:661F  [+0x0661F]  DB 0xC6  (bad)
F000:6621  [+0x06621]  C6 C6 00                 mov     dh,0
F000:6624  [+0x06624]  00 00                    add     [bx+si],al
F000:6626  [+0x06626]  38 6C 38                 cmp     [si+38h],ch
F000:6629  [+0x06629]  00 38                    add     [bx+si],bh
F000:662B  [+0x0662B]  6C                       insb
F000:662C  [+0x0662C]  C6 C6 FE                 mov     dh,0FEh
F000:662F  [+0x0662F]  C6 C6 00                 mov     dh,0
F000:6632  [+0x06632]  00 00                    add     [bx+si],al
F000:6634  [+0x06634]  18 30                    sbb     [bx+si],dh
F000:6636  [+0x06636]  60                       pusha
F000:6637  [+0x06637]  00 FE                    add     dh,bh
F000:6639  [+0x06639]  66 60                    pushad
F000:663B  [+0x0663B]  7C 60                    jl      short 669Dh
F000:663D  [+0x0663D]  66 FE 00                 inc     byte [bx+si]
F000:6640  [+0x06640]  00 00                    add     [bx+si],al
F000:6642  [+0x06642]  00 00                    add     [bx+si],al
F000:6644  [+0x06644]  00 00                    add     [bx+si],al
F000:6646  [+0x06646]  CC                       int3
F000:6647  [+0x06647]  76 36                    jbe     short 667Fh
F000:6649  [+0x06649]  7E D8                    jle     short 6623h
F000:664B  [+0x0664B]  D8 6E 00                 fsubr   dword [bp]
F000:664E  [+0x0664E]  00 00                    add     [bx+si],al
F000:6650  [+0x06650]  00 00                    add     [bx+si],al
F000:6652  [+0x06652]  3E 6C                    insb
F000:6654  [+0x06654]  CC                       int3
F000:6655  [+0x06655]  CC                       int3
F000:6656  [+0x06656]  FE CC                    dec     ah
F000:6658  [+0x06658]  CC                       int3
F000:6659  [+0x06659]  CC                       int3
F000:665A  [+0x0665A]  CE                       into
F000:665B  [+0x0665B]  00 00                    add     [bx+si],al
F000:665D  [+0x0665D]  00 00                    add     [bx+si],al
F000:665F  [+0x0665F]  10 38                    adc     [bx+si],bh
F000:6661  [+0x06661]  6C                       insb
F000:6662  [+0x06662]  00 7C C6                 add     [si-3Ah],bh
F000:6665  [+0x06665]  C6 C6 C6                 mov     dh,0C6h
F000:6668  [+0x06668]  7C 00                    jl      short 666Ah
F000:666A  [+0x0666A]  00 00                    add     [bx+si],al
F000:666C  [+0x0666C]  00 00                    add     [bx+si],al
F000:666E  [+0x0666E]  C6 C6 00                 mov     dh,0
F000:6671  [+0x06671]  7C C6                    jl      short 6639h
F000:6673  [+0x06673]  C6 C6 C6                 mov     dh,0C6h
F000:6676  [+0x06676]  7C 00                    jl      short 6678h
F000:6678  [+0x06678]  00 00                    add     [bx+si],al
F000:667A  [+0x0667A]  00 60 30                 add     [bx+si+30h],ah
F000:667D  [+0x0667D]  18 00                    sbb     [bx+si],al
F000:667F  [+0x0667F]  7C C6                    jl      short 6647h
F000:6681  [+0x06681]  C6 C6 C6                 mov     dh,0C6h
F000:6684  [+0x06684]  7C 00                    jl      short 6686h
F000:6686  [+0x06686]  00 00                    add     [bx+si],al
F000:6688  [+0x06688]  00 30                    add     [bx+si],dh
F000:668A  [+0x0668A]  78 CC                    js      short 6658h
F000:668C  [+0x0668C]  00 CC                    add     ah,cl
F000:668E  [+0x0668E]  CC                       int3
F000:668F  [+0x0668F]  CC                       int3
F000:6690  [+0x06690]  CC                       int3
F000:6691  [+0x06691]  CC                       int3
F000:6692  [+0x06692]  76 00                    jbe     short 6694h
F000:6694  [+0x06694]  00 00                    add     [bx+si],al
F000:6696  [+0x06696]  00 60 30                 add     [bx+si+30h],ah
F000:6699  [+0x06699]  18 00                    sbb     [bx+si],al
F000:669B  [+0x0669B]  CC                       int3
F000:669C  [+0x0669C]  CC                       int3
F000:669D  [+0x0669D]  CC                       int3
F000:669E  [+0x0669E]  CC                       int3
F000:669F  [+0x0669F]  CC                       int3
F000:66A0  [+0x066A0]  76 00                    jbe     short 66A2h
F000:66A2  [+0x066A2]  00 00                    add     [bx+si],al
F000:66A4  [+0x066A4]  00 00                    add     [bx+si],al
F000:66A6  [+0x066A6]  C6 C6 00                 mov     dh,0
F000:66A9  [+0x066A9]  C6 C6 C6                 mov     dh,0C6h
F000:66AC  [+0x066AC]  DB 0xC6  (bad)
F000:66AE  [+0x066AE]  06                       push    es
F000:66AF  [+0x066AF]  0C 78                    or      al,78h
F000:66B1  [+0x066B1]  00 00                    add     [bx+si],al
F000:66B3  [+0x066B3]  C6 C6 38                 mov     dh,38h
F000:66B6  [+0x066B6]  6C                       insb
F000:66B7  [+0x066B7]  C6 C6 C6                 mov     dh,0C6h
F000:66BA  [+0x066BA]  DB 0xC6  (bad)
F000:66BC  [+0x066BC]  38 00                    cmp     [bx+si],al
F000:66BE  [+0x066BE]  00 00                    add     [bx+si],al
F000:66C0  [+0x066C0]  00 C6                    add     dh,al
F000:66C2  [+0x066C2]  C6 00 C6                 mov     byte [bx+si],0C6h
F000:66C5  [+0x066C5]  C6 C6 C6                 mov     dh,0C6h
F000:66C8  [+0x066C8]  C6 C6 7C                 mov     dh,7Ch
F000:66CB  [+0x066CB]  00 00                    add     [bx+si],al
F000:66CD  [+0x066CD]  00 00                    add     [bx+si],al
F000:66CF  [+0x066CF]  18 18                    sbb     [bx+si],bl
F000:66D1  [+0x066D1]  7C C6                    jl      short 6699h
F000:66D3  [+0x066D3]  C0 C0 C6                 rol     al,0C6h
F000:66D6  [+0x066D6]  7C 18                    jl      short 66F0h
F000:66D8  [+0x066D8]  18 00                    sbb     [bx+si],al
F000:66DA  [+0x066DA]  00 00                    add     [bx+si],al
F000:66DC  [+0x066DC]  00 38                    add     [bx+si],bh
F000:66DE  [+0x066DE]  6C                       insb
F000:66DF  [+0x066DF]  64 60                    pusha
F000:66E1  [+0x066E1]  DB 0xF0  (bad)
F000:66E3  [+0x066E3]  60                       pusha
F000:66E4  [+0x066E4]  60                       pusha
F000:66E5  [+0x066E5]  E6 FC                    out     0FCh,al
F000:66E7  [+0x066E7]  00 00                    add     [bx+si],al
F000:66E9  [+0x066E9]  00 00                    add     [bx+si],al
F000:66EB  [+0x066EB]  00 66 66                 add     [bp+66h],ah
F000:66EE  [+0x066EE]  3C 18                    cmp     al,18h
F000:66F0  [+0x066F0]  7E 18                    jle     short 670Ah
F000:66F2  [+0x066F2]  7E 18                    jle     short 670Ch
F000:66F4  [+0x066F4]  18 00                    sbb     [bx+si],al
F000:66F6  [+0x066F6]  00 00                    add     [bx+si],al
F000:66F8  [+0x066F8]  00 F8                    add     al,bh
F000:66FA  [+0x066FA]  CC                       int3
F000:66FB  [+0x066FB]  CC                       int3
F000:66FC  [+0x066FC]  F8                       clc
F000:66FD  [+0x066FD]  DB 0xC4  (bad)
F000:6701  [+0x06701]  CC                       int3
F000:6702  [+0x06702]  C6 00 00                 mov     byte [bx+si],0
F000:6705  [+0x06705]  00 00                    add     [bx+si],al
F000:6707  [+0x06707]  0E                       push    cs
F000:6708  [+0x06708]  1B 18                    sbb     bx,[bx+si]
F000:670A  [+0x0670A]  18 18                    sbb     [bx+si],bl
F000:670C  [+0x0670C]  7E 18                    jle     short 6726h
F000:670E  [+0x0670E]  18 18                    sbb     [bx+si],bl
F000:6710  [+0x06710]  18 D8                    sbb     al,bl
F000:6712  [+0x06712]  70 00                    jo      short 6714h
F000:6714  [+0x06714]  00 18                    add     [bx+si],bl
F000:6716  [+0x06716]  30 60 00                 xor     [bx+si],ah
F000:6719  [+0x06719]  78 0C                    js      short 6727h
F000:671B  [+0x0671B]  7C CC                    jl      short 66E9h
F000:671D  [+0x0671D]  CC                       int3
F000:671E  [+0x0671E]  76 00                    jbe     short 6720h
F000:6720  [+0x06720]  00 00                    add     [bx+si],al
F000:6722  [+0x06722]  00 0C                    add     [si],cl
F000:6724  [+0x06724]  18 30                    sbb     [bx+si],dh
F000:6726  [+0x06726]  00 38                    add     [bx+si],bh
F000:6728  [+0x06728]  18 18                    sbb     [bx+si],bl
F000:672A  [+0x0672A]  18 18                    sbb     [bx+si],bl
F000:672C  [+0x0672C]  3C 00                    cmp     al,0
F000:672E  [+0x0672E]  00 00                    add     [bx+si],al
F000:6730  [+0x06730]  00 18                    add     [bx+si],bl
F000:6732  [+0x06732]  30 60 00                 xor     [bx+si],ah
F000:6735  [+0x06735]  7C C6                    jl      short 66FDh
F000:6737  [+0x06737]  C6 C6 C6                 mov     dh,0C6h
F000:673A  [+0x0673A]  7C 00                    jl      short 673Ch
F000:673C  [+0x0673C]  00 00                    add     [bx+si],al
F000:673E  [+0x0673E]  00 18                    add     [bx+si],bl
F000:6740  [+0x06740]  30 60 00                 xor     [bx+si],ah
F000:6743  [+0x06743]  CC                       int3
F000:6744  [+0x06744]  CC                       int3
F000:6745  [+0x06745]  CC                       int3
F000:6746  [+0x06746]  CC                       int3
F000:6747  [+0x06747]  CC                       int3
F000:6748  [+0x06748]  76 00                    jbe     short 674Ah
F000:674A  [+0x0674A]  00 00                    add     [bx+si],al
F000:674C  [+0x0674C]  00 00                    add     [bx+si],al
F000:674E  [+0x0674E]  76 DC                    jbe     short 672Ch
F000:6750  [+0x06750]  00 DC                    add     ah,bl
F000:6752  [+0x06752]  66 66 66 66 66 00 00     add     [bx+si],al
F000:6759  [+0x06759]  00 76 DC                 add     [bp-24h],dh
F000:675C  [+0x0675C]  00 C6                    add     dh,al
F000:675E  [+0x0675E]  E6 F6                    out     0F6h,al
F000:6760  [+0x06760]  DB 0xFE  (bad)
F000:6762  [+0x06762]  CE                       into
F000:6763  [+0x06763]  C6 C6 00                 mov     dh,0
F000:6766  [+0x06766]  00 00                    add     [bx+si],al
F000:6768  [+0x06768]  00 3C                    add     [si],bh
F000:676A  [+0x0676A]  6C                       insb
F000:676B  [+0x0676B]  6C                       insb
F000:676C  [+0x0676C]  3E 00 7E 00              add     [ds:bp],bh
F000:6770  [+0x06770]  00 00                    add     [bx+si],al
F000:6772  [+0x06772]  00 00                    add     [bx+si],al
F000:6774  [+0x06774]  00 00                    add     [bx+si],al
F000:6776  [+0x06776]  00 38                    add     [bx+si],bh
F000:6778  [+0x06778]  6C                       insb
F000:6779  [+0x06779]  6C                       insb
F000:677A  [+0x0677A]  38 00                    cmp     [bx+si],al
F000:677C  [+0x0677C]  7C 00                    jl      short 677Eh
F000:677E  [+0x0677E]  00 00                    add     [bx+si],al
F000:6780  [+0x06780]  00 00                    add     [bx+si],al
F000:6782  [+0x06782]  00 00                    add     [bx+si],al
F000:6784  [+0x06784]  00 00                    add     [bx+si],al
F000:6786  [+0x06786]  30 30                    xor     [bx+si],dh
F000:6788  [+0x06788]  00 30                    add     [bx+si],dh
F000:678A  [+0x0678A]  30 60 C6                 xor     [bx+si-3Ah],ah
F000:678D  [+0x0678D]  DB 0xC6  (bad)
F000:678F  [+0x0678F]  00 00                    add     [bx+si],al
F000:6791  [+0x06791]  00 00                    add     [bx+si],al
F000:6793  [+0x06793]  00 00                    add     [bx+si],al
F000:6795  [+0x06795]  00 00                    add     [bx+si],al
F000:6797  [+0x06797]  00 FE                    add     dh,bh
F000:6799  [+0x06799]  C0 C0 C0                 rol     al,0C0h
F000:679C  [+0x0679C]  00 00                    add     [bx+si],al
F000:679E  [+0x0679E]  00 00                    add     [bx+si],al
F000:67A0  [+0x067A0]  00 00                    add     [bx+si],al
F000:67A2  [+0x067A2]  00 00                    add     [bx+si],al
F000:67A4  [+0x067A4]  00 00                    add     [bx+si],al
F000:67A6  [+0x067A6]  FE 06 06 06              inc     byte [606h]
F000:67AA  [+0x067AA]  00 00                    add     [bx+si],al
F000:67AC  [+0x067AC]  00 00                    add     [bx+si],al
F000:67AE  [+0x067AE]  00 C0                    add     al,al
F000:67B0  [+0x067B0]  C0 C6 CC                 rol     dh,0CCh
F000:67B3  [+0x067B3]  D8 30                    fdiv    dword [bx+si]
F000:67B5  [+0x067B5]  60                       pusha
F000:67B6  [+0x067B6]  CE                       into
F000:67B7  [+0x067B7]  93                       xchg    bx,ax
F000:67B8  [+0x067B8]  06                       push    es
F000:67B9  [+0x067B9]  0C 1F                    or      al,1Fh
F000:67BB  [+0x067BB]  00 00                    add     [bx+si],al
F000:67BD  [+0x067BD]  C0 C0 C6                 rol     al,0C6h
F000:67C0  [+0x067C0]  CC                       int3
F000:67C1  [+0x067C1]  D8 30                    fdiv    dword [bx+si]
F000:67C3  [+0x067C3]  66 CE                    into
F000:67C5  [+0x067C5]  9A 3F 06 0F 00           call    000Fh:063Fh
F000:67CA  [+0x067CA]  00 00                    add     [bx+si],al
F000:67CC  [+0x067CC]  18 18                    sbb     [bx+si],bl
F000:67CE  [+0x067CE]  00 18                    add     [bx+si],bl
F000:67D0  [+0x067D0]  18 3C                    sbb     [si],bh
F000:67D2  [+0x067D2]  3C 3C                    cmp     al,3Ch
F000:67D4  [+0x067D4]  18 00                    sbb     [bx+si],al
F000:67D6  [+0x067D6]  00 00                    add     [bx+si],al
F000:67D8  [+0x067D8]  00 00                    add     [bx+si],al
F000:67DA  [+0x067DA]  00 00                    add     [bx+si],al
F000:67DC  [+0x067DC]  33 66 CC                 xor     sp,[bp-34h]
F000:67DF  [+0x067DF]  66 33 00                 xor     eax,[bx+si]
F000:67E2  [+0x067E2]  00 00                    add     [bx+si],al
F000:67E4  [+0x067E4]  00 00                    add     [bx+si],al
F000:67E6  [+0x067E6]  00 00                    add     [bx+si],al
F000:67E8  [+0x067E8]  00 00                    add     [bx+si],al
F000:67EA  [+0x067EA]  CC                       int3
F000:67EB  [+0x067EB]  66 33 66 CC              xor     esp,[bp-34h]
F000:67EF  [+0x067EF]  00 00                    add     [bx+si],al
F000:67F1  [+0x067F1]  00 00                    add     [bx+si],al
F000:67F3  [+0x067F3]  00 11                    add     [bx+di],dl
F000:67F5  [+0x067F5]  44                       inc     sp
F000:67F6  [+0x067F6]  11 44 11                 adc     [si+11h],ax
F000:67F9  [+0x067F9]  44                       inc     sp
F000:67FA  [+0x067FA]  11 44 11                 adc     [si+11h],ax
F000:67FD  [+0x067FD]  44                       inc     sp
F000:67FE  [+0x067FE]  11 44 11                 adc     [si+11h],ax
F000:6801  [+0x06801]  44                       inc     sp
F000:6802  [+0x06802]  55                       push    bp
F000:6803  [+0x06803]  AA                       stosb
F000:6804  [+0x06804]  55                       push    bp
F000:6805  [+0x06805]  AA                       stosb
F000:6806  [+0x06806]  55                       push    bp
F000:6807  [+0x06807]  AA                       stosb
F000:6808  [+0x06808]  55                       push    bp
F000:6809  [+0x06809]  AA                       stosb
F000:680A  [+0x0680A]  55                       push    bp
F000:680B  [+0x0680B]  AA                       stosb
F000:680C  [+0x0680C]  55                       push    bp
F000:680D  [+0x0680D]  AA                       stosb
F000:680E  [+0x0680E]  55                       push    bp
F000:680F  [+0x0680F]  AA                       stosb
F000:6810  [+0x06810]  DD 77 DD                 fnsave  [bx-23h]
F000:6813  [+0x06813]  77 DD                    ja      short 67F2h
F000:6815  [+0x06815]  77 DD                    ja      short 67F4h
F000:6817  [+0x06817]  77 DD                    ja      short 67F6h
F000:6819  [+0x06819]  77 DD                    ja      short 67F8h
F000:681B  [+0x0681B]  77 DD                    ja      short 67FAh
F000:681D  [+0x0681D]  77 18                    ja      short 6837h
F000:681F  [+0x0681F]  18 18                    sbb     [bx+si],bl
F000:6821  [+0x06821]  18 18                    sbb     [bx+si],bl
F000:6823  [+0x06823]  18 18                    sbb     [bx+si],bl
F000:6825  [+0x06825]  18 18                    sbb     [bx+si],bl
F000:6827  [+0x06827]  18 18                    sbb     [bx+si],bl
F000:6829  [+0x06829]  18 18                    sbb     [bx+si],bl
F000:682B  [+0x0682B]  18 18                    sbb     [bx+si],bl
F000:682D  [+0x0682D]  18 18                    sbb     [bx+si],bl
F000:682F  [+0x0682F]  18 18                    sbb     [bx+si],bl
F000:6831  [+0x06831]  18 18                    sbb     [bx+si],bl
F000:6833  [+0x06833]  F8                       clc
F000:6834  [+0x06834]  18 18                    sbb     [bx+si],bl
F000:6836  [+0x06836]  18 18                    sbb     [bx+si],bl
F000:6838  [+0x06838]  18 18                    sbb     [bx+si],bl
F000:683A  [+0x0683A]  18 18                    sbb     [bx+si],bl
F000:683C  [+0x0683C]  18 18                    sbb     [bx+si],bl
F000:683E  [+0x0683E]  18 F8                    sbb     al,bh
F000:6840  [+0x06840]  18 F8                    sbb     al,bh
F000:6842  [+0x06842]  18 18                    sbb     [bx+si],bl
F000:6844  [+0x06844]  18 18                    sbb     [bx+si],bl
F000:6846  [+0x06846]  18 18                    sbb     [bx+si],bl
F000:6848  [+0x06848]  36 36 36 36 36 36 36 F6 36 36 36 div     byte [ss:3636h]
F000:6853  [+0x06853]  36 36 36 00 00           add     [ss:bx+si],al
F000:6858  [+0x06858]  00 00                    add     [bx+si],al
F000:685A  [+0x0685A]  00 00                    add     [bx+si],al
F000:685C  [+0x0685C]  00 FE                    add     dh,bh
F000:685E  [+0x0685E]  36 36 36 36 36 36 00 00  add     [ss:bx+si],al
F000:6866  [+0x06866]  00 00                    add     [bx+si],al
F000:6868  [+0x06868]  00 F8                    add     al,bh
F000:686A  [+0x0686A]  18 F8                    sbb     al,bh
F000:686C  [+0x0686C]  18 18                    sbb     [bx+si],bl
F000:686E  [+0x0686E]  18 18                    sbb     [bx+si],bl
F000:6870  [+0x06870]  18 18                    sbb     [bx+si],bl
F000:6872  [+0x06872]  36 36 36 36 36 F6 06 F6 36 36 test    byte [ss:36F6h],36h
F000:687C  [+0x0687C]  DB 0x36  (bad)
F000:688B  [+0x0688B]  36 36 36 00 00           add     [ss:bx+si],al
F000:6890  [+0x06890]  00 00                    add     [bx+si],al
F000:6892  [+0x06892]  00 FE                    add     dh,bh
F000:6894  [+0x06894]  06                       push    es
F000:6895  [+0x06895]  F6 36 36 36              div     byte [3636h]
F000:6899  [+0x06899]  36 36 36 36 36 36 36 36 F6 06 FE 00 00 test    byte [ss:0FEh],0
F000:68A6  [+0x068A6]  00 00                    add     [bx+si],al
F000:68A8  [+0x068A8]  00 00                    add     [bx+si],al
F000:68AA  [+0x068AA]  36 36 36 36 36 36 36 FE 00 inc     byte [ss:bx+si]
F000:68B3  [+0x068B3]  00 00                    add     [bx+si],al
F000:68B5  [+0x068B5]  00 00                    add     [bx+si],al
F000:68B7  [+0x068B7]  00 18                    add     [bx+si],bl
F000:68B9  [+0x068B9]  18 18                    sbb     [bx+si],bl
F000:68BB  [+0x068BB]  18 18                    sbb     [bx+si],bl
F000:68BD  [+0x068BD]  F8                       clc
F000:68BE  [+0x068BE]  18 F8                    sbb     al,bh
F000:68C0  [+0x068C0]  00 00                    add     [bx+si],al
F000:68C2  [+0x068C2]  00 00                    add     [bx+si],al
F000:68C4  [+0x068C4]  00 00                    add     [bx+si],al
F000:68C6  [+0x068C6]  00 00                    add     [bx+si],al
F000:68C8  [+0x068C8]  00 00                    add     [bx+si],al
F000:68CA  [+0x068CA]  00 00                    add     [bx+si],al
F000:68CC  [+0x068CC]  00 F8                    add     al,bh
F000:68CE  [+0x068CE]  18 18                    sbb     [bx+si],bl
F000:68D0  [+0x068D0]  18 18                    sbb     [bx+si],bl
F000:68D2  [+0x068D2]  18 18                    sbb     [bx+si],bl
F000:68D4  [+0x068D4]  18 18                    sbb     [bx+si],bl
F000:68D6  [+0x068D6]  18 18                    sbb     [bx+si],bl
F000:68D8  [+0x068D8]  18 18                    sbb     [bx+si],bl
F000:68DA  [+0x068DA]  18 1F                    sbb     [bx],bl
F000:68DC  [+0x068DC]  00 00                    add     [bx+si],al
F000:68DE  [+0x068DE]  00 00                    add     [bx+si],al
F000:68E0  [+0x068E0]  00 00                    add     [bx+si],al
F000:68E2  [+0x068E2]  18 18                    sbb     [bx+si],bl
F000:68E4  [+0x068E4]  18 18                    sbb     [bx+si],bl
F000:68E6  [+0x068E6]  18 18                    sbb     [bx+si],bl
F000:68E8  [+0x068E8]  18 FF                    sbb     bh,bh
F000:68EA  [+0x068EA]  00 00                    add     [bx+si],al
F000:68EC  [+0x068EC]  00 00                    add     [bx+si],al
F000:68EE  [+0x068EE]  00 00                    add     [bx+si],al
F000:68F0  [+0x068F0]  00 00                    add     [bx+si],al
F000:68F2  [+0x068F2]  00 00                    add     [bx+si],al
F000:68F4  [+0x068F4]  00 00                    add     [bx+si],al
F000:68F6  [+0x068F6]  00 FF                    add     bh,bh
F000:68F8  [+0x068F8]  18 18                    sbb     [bx+si],bl
F000:68FA  [+0x068FA]  18 18                    sbb     [bx+si],bl
F000:68FC  [+0x068FC]  18 18                    sbb     [bx+si],bl
F000:68FE  [+0x068FE]  18 18                    sbb     [bx+si],bl
F000:6900  [+0x06900]  18 18                    sbb     [bx+si],bl
F000:6902  [+0x06902]  18 18                    sbb     [bx+si],bl
F000:6904  [+0x06904]  18 1F                    sbb     [bx],bl
F000:6906  [+0x06906]  18 18                    sbb     [bx+si],bl
F000:6908  [+0x06908]  18 18                    sbb     [bx+si],bl
F000:690A  [+0x0690A]  18 18                    sbb     [bx+si],bl
F000:690C  [+0x0690C]  00 00                    add     [bx+si],al
F000:690E  [+0x0690E]  00 00                    add     [bx+si],al
F000:6910  [+0x06910]  00 00                    add     [bx+si],al
F000:6912  [+0x06912]  00 FF                    add     bh,bh
F000:6914  [+0x06914]  00 00                    add     [bx+si],al
F000:6916  [+0x06916]  00 00                    add     [bx+si],al
F000:6918  [+0x06918]  00 00                    add     [bx+si],al
F000:691A  [+0x0691A]  18 18                    sbb     [bx+si],bl
F000:691C  [+0x0691C]  18 18                    sbb     [bx+si],bl
F000:691E  [+0x0691E]  18 18                    sbb     [bx+si],bl
F000:6920  [+0x06920]  18 FF                    sbb     bh,bh
F000:6922  [+0x06922]  18 18                    sbb     [bx+si],bl
F000:6924  [+0x06924]  18 18                    sbb     [bx+si],bl
F000:6926  [+0x06926]  18 18                    sbb     [bx+si],bl
F000:6928  [+0x06928]  18 18                    sbb     [bx+si],bl
F000:692A  [+0x0692A]  18 18                    sbb     [bx+si],bl
F000:692C  [+0x0692C]  18 1F                    sbb     [bx],bl
F000:692E  [+0x0692E]  18 1F                    sbb     [bx],bl
F000:6930  [+0x06930]  18 18                    sbb     [bx+si],bl
F000:6932  [+0x06932]  18 18                    sbb     [bx+si],bl
F000:6934  [+0x06934]  18 18                    sbb     [bx+si],bl
F000:6936  [+0x06936]  36 36 36 36 36 36 36 37  aaa
F000:693E  [+0x0693E]  36 36 36 36 36 36 36 36 36 36 36 37 aaa
F000:694A  [+0x0694A]  30 3F                    xor     [bx],bh
F000:694C  [+0x0694C]  00 00                    add     [bx+si],al
F000:694E  [+0x0694E]  00 00                    add     [bx+si],al
F000:6950  [+0x06950]  00 00                    add     [bx+si],al
F000:6952  [+0x06952]  00 00                    add     [bx+si],al
F000:6954  [+0x06954]  00 00                    add     [bx+si],al
F000:6956  [+0x06956]  00 3F                    add     [bx],bh
F000:6958  [+0x06958]  30 37                    xor     [bx],dh
F000:695A  [+0x0695A]  36 36 36 36 36 36 36 36 36 36 36 F7 00 FF 00 test    word [ss:bx+si],0FFh
F000:6969  [+0x06969]  00 00                    add     [bx+si],al
F000:696B  [+0x0696B]  00 00                    add     [bx+si],al
F000:696D  [+0x0696D]  00 00                    add     [bx+si],al
F000:696F  [+0x0696F]  00 00                    add     [bx+si],al
F000:6971  [+0x06971]  00 00                    add     [bx+si],al
F000:6973  [+0x06973]  FF 00                    inc     word [bx+si]
F000:6975  [+0x06975]  F7 36 36 36              div     word [3636h]
F000:6979  [+0x06979]  36 36 36 36 36 36 36 36 37 aaa
F000:6982  [+0x06982]  30 37                    xor     [bx],dh
F000:6984  [+0x06984]  36 36 36 36 36 36 00 00  add     [ss:bx+si],al
F000:698C  [+0x0698C]  00 00                    add     [bx+si],al
F000:698E  [+0x0698E]  00 FF                    add     bh,bh
F000:6990  [+0x06990]  00 FF                    add     bh,bh
F000:6992  [+0x06992]  00 00                    add     [bx+si],al
F000:6994  [+0x06994]  00 00                    add     [bx+si],al
F000:6996  [+0x06996]  00 00                    add     [bx+si],al
F000:6998  [+0x06998]  36 36 36 36 36 F7 00 F7 36 test    word [ss:bx+si],36F7h
F000:69A1  [+0x069A1]  36 36 36 36 36 18 18     sbb     [ss:bx+si],bl
F000:69A8  [+0x069A8]  18 18                    sbb     [bx+si],bl
F000:69AA  [+0x069AA]  18 FF                    sbb     bh,bh
F000:69AC  [+0x069AC]  00 FF                    add     bh,bh
F000:69AE  [+0x069AE]  00 00                    add     [bx+si],al
F000:69B0  [+0x069B0]  00 00                    add     [bx+si],al
F000:69B2  [+0x069B2]  00 00                    add     [bx+si],al
F000:69B4  [+0x069B4]  36 36 36 36 36 36 36 FF 00 inc     word [ss:bx+si]
F000:69BD  [+0x069BD]  00 00                    add     [bx+si],al
F000:69BF  [+0x069BF]  00 00                    add     [bx+si],al
F000:69C1  [+0x069C1]  00 00                    add     [bx+si],al
F000:69C3  [+0x069C3]  00 00                    add     [bx+si],al
F000:69C5  [+0x069C5]  00 00                    add     [bx+si],al
F000:69C7  [+0x069C7]  FF 00                    inc     word [bx+si]
F000:69C9  [+0x069C9]  FF 18                    call    far [bx+si]
F000:69CB  [+0x069CB]  18 18                    sbb     [bx+si],bl
F000:69CD  [+0x069CD]  18 18                    sbb     [bx+si],bl
F000:69CF  [+0x069CF]  18 00                    sbb     [bx+si],al
F000:69D1  [+0x069D1]  00 00                    add     [bx+si],al
F000:69D3  [+0x069D3]  00 00                    add     [bx+si],al
F000:69D5  [+0x069D5]  00 00                    add     [bx+si],al
F000:69D7  [+0x069D7]  FF 36 36 36              push    word [3636h]
F000:69DB  [+0x069DB]  36 36 36 36 36 36 36 36 36 36 3F aas
F000:69E6  [+0x069E6]  00 00                    add     [bx+si],al
F000:69E8  [+0x069E8]  00 00                    add     [bx+si],al
F000:69EA  [+0x069EA]  00 00                    add     [bx+si],al
F000:69EC  [+0x069EC]  18 18                    sbb     [bx+si],bl
F000:69EE  [+0x069EE]  18 18                    sbb     [bx+si],bl
F000:69F0  [+0x069F0]  18 1F                    sbb     [bx],bl
F000:69F2  [+0x069F2]  18 1F                    sbb     [bx],bl
F000:69F4  [+0x069F4]  00 00                    add     [bx+si],al
F000:69F6  [+0x069F6]  00 00                    add     [bx+si],al
F000:69F8  [+0x069F8]  00 00                    add     [bx+si],al
F000:69FA  [+0x069FA]  00 00                    add     [bx+si],al
F000:69FC  [+0x069FC]  00 00                    add     [bx+si],al
F000:69FE  [+0x069FE]  00 1F                    add     [bx],bl
F000:6A00  [+0x06A00]  18 1F                    sbb     [bx],bl
F000:6A02  [+0x06A02]  18 18                    sbb     [bx+si],bl
F000:6A04  [+0x06A04]  18 18                    sbb     [bx+si],bl
F000:6A06  [+0x06A06]  18 18                    sbb     [bx+si],bl
F000:6A08  [+0x06A08]  00 00                    add     [bx+si],al
F000:6A0A  [+0x06A0A]  00 00                    add     [bx+si],al
F000:6A0C  [+0x06A0C]  00 00                    add     [bx+si],al
F000:6A0E  [+0x06A0E]  00 3F                    add     [bx],bh
F000:6A10  [+0x06A10]  DB 0x36  (bad)
F000:6A1F  [+0x06A1F]  36 36 36 36 36 18 18     sbb     [ss:bx+si],bl
F000:6A26  [+0x06A26]  18 18                    sbb     [bx+si],bl
F000:6A28  [+0x06A28]  18 FF                    sbb     bh,bh
F000:6A2A  [+0x06A2A]  18 FF                    sbb     bh,bh
F000:6A2C  [+0x06A2C]  18 18                    sbb     [bx+si],bl
F000:6A2E  [+0x06A2E]  18 18                    sbb     [bx+si],bl
F000:6A30  [+0x06A30]  18 18                    sbb     [bx+si],bl
F000:6A32  [+0x06A32]  18 18                    sbb     [bx+si],bl
F000:6A34  [+0x06A34]  18 18                    sbb     [bx+si],bl
F000:6A36  [+0x06A36]  18 18                    sbb     [bx+si],bl
F000:6A38  [+0x06A38]  18 F8                    sbb     al,bh
F000:6A3A  [+0x06A3A]  00 00                    add     [bx+si],al
F000:6A3C  [+0x06A3C]  00 00                    add     [bx+si],al
F000:6A3E  [+0x06A3E]  00 00                    add     [bx+si],al
F000:6A40  [+0x06A40]  00 00                    add     [bx+si],al
F000:6A42  [+0x06A42]  00 00                    add     [bx+si],al
F000:6A44  [+0x06A44]  00 00                    add     [bx+si],al
F000:6A46  [+0x06A46]  00 1F                    add     [bx],bl
F000:6A48  [+0x06A48]  18 18                    sbb     [bx+si],bl
F000:6A4A  [+0x06A4A]  18 18                    sbb     [bx+si],bl
F000:6A4C  [+0x06A4C]  18 18                    sbb     [bx+si],bl
F000:6A4E  [+0x06A4E]  DB 0xFF  (bad)
F000:6A50  [+0x06A50]  DB 0xFF  (bad)
F000:6A52  [+0x06A52]  DB 0xFF  (bad)
F000:6A54  [+0x06A54]  DB 0xFF  (bad)
F000:6A56  [+0x06A56]  DB 0xFF  (bad)
F000:6A58  [+0x06A58]  DB 0xFF  (bad)
F000:6A5A  [+0x06A5A]  DB 0xFF  (bad)
F000:6A5C  [+0x06A5C]  00 00                    add     [bx+si],al
F000:6A5E  [+0x06A5E]  00 00                    add     [bx+si],al
F000:6A60  [+0x06A60]  00 00                    add     [bx+si],al
F000:6A62  [+0x06A62]  00 FF                    add     bh,bh
F000:6A64  [+0x06A64]  DB 0xFF  (bad)
F000:6A66  [+0x06A66]  DB 0xFF  (bad)
F000:6A68  [+0x06A68]  DB 0xFF  (bad)
F000:6A6A  [+0x06A6A]  DB 0xF0  (bad)
F000:6A79  [+0x06A79]  DB 0x0F  (bad)
F000:6A7D  [+0x06A7D]  DB 0x0F  (bad)
F000:6A81  [+0x06A81]  DB 0x0F  (bad)
F000:6A85  [+0x06A85]  0F FF FF                 ud0     di,di
F000:6A88  [+0x06A88]  DB 0xFF  (bad)
F000:6A8A  [+0x06A8A]  DB 0xFF  (bad)
F000:6A8C  [+0x06A8C]  FF 00                    inc     word [bx+si]
F000:6A8E  [+0x06A8E]  00 00                    add     [bx+si],al
F000:6A90  [+0x06A90]  00 00                    add     [bx+si],al
F000:6A92  [+0x06A92]  00 00                    add     [bx+si],al
F000:6A94  [+0x06A94]  00 00                    add     [bx+si],al
F000:6A96  [+0x06A96]  00 00                    add     [bx+si],al
F000:6A98  [+0x06A98]  00 76 DC                 add     [bp-24h],dh
F000:6A9B  [+0x06A9B]  D8 D8                    fcomp   st0
F000:6A9D  [+0x06A9D]  DC 76 00                 fdiv    qword [bp]
F000:6AA0  [+0x06AA0]  00 00                    add     [bx+si],al
F000:6AA2  [+0x06AA2]  00 00                    add     [bx+si],al
F000:6AA4  [+0x06AA4]  00 00                    add     [bx+si],al
F000:6AA6  [+0x06AA6]  7C C6                    jl      short 6A6Eh
F000:6AA8  [+0x06AA8]  FC                       cld
F000:6AA9  [+0x06AA9]  C6 C6 FC                 mov     dh,0FCh
F000:6AAC  [+0x06AAC]  C0 C0 40                 rol     al,40h
F000:6AAF  [+0x06AAF]  00 00                    add     [bx+si],al
F000:6AB1  [+0x06AB1]  00 FE                    add     dh,bh
F000:6AB3  [+0x06AB3]  C6 C6 C0                 mov     dh,0C0h
F000:6AB6  [+0x06AB6]  C0 C0 C0                 rol     al,0C0h
F000:6AB9  [+0x06AB9]  C0 C0 00                 rol     al,0
F000:6ABC  [+0x06ABC]  00 00                    add     [bx+si],al
F000:6ABE  [+0x06ABE]  00 00                    add     [bx+si],al
F000:6AC0  [+0x06AC0]  00 00                    add     [bx+si],al
F000:6AC2  [+0x06AC2]  00 FE                    add     dh,bh
F000:6AC4  [+0x06AC4]  6C                       insb
F000:6AC5  [+0x06AC5]  6C                       insb
F000:6AC6  [+0x06AC6]  6C                       insb
F000:6AC7  [+0x06AC7]  6C                       insb
F000:6AC8  [+0x06AC8]  6C                       insb
F000:6AC9  [+0x06AC9]  00 00                    add     [bx+si],al
F000:6ACB  [+0x06ACB]  00 00                    add     [bx+si],al
F000:6ACD  [+0x06ACD]  00 FE                    add     dh,bh
F000:6ACF  [+0x06ACF]  DB 0xC6  (bad)
F000:6AD1  [+0x06AD1]  30 18                    xor     [bx+si],bl
F000:6AD3  [+0x06AD3]  30 60 C6                 xor     [bx+si-3Ah],ah
F000:6AD6  [+0x06AD6]  FE 00                    inc     byte [bx+si]
F000:6AD8  [+0x06AD8]  00 00                    add     [bx+si],al
F000:6ADA  [+0x06ADA]  00 00                    add     [bx+si],al
F000:6ADC  [+0x06ADC]  00 00                    add     [bx+si],al
F000:6ADE  [+0x06ADE]  00 7E D8                 add     [bp-28h],bh
F000:6AE1  [+0x06AE1]  D8 D8                    fcomp   st0
F000:6AE3  [+0x06AE3]  D8 70 00                 fdiv    dword [bx+si]
F000:6AE6  [+0x06AE6]  00 00                    add     [bx+si],al
F000:6AE8  [+0x06AE8]  00 00                    add     [bx+si],al
F000:6AEA  [+0x06AEA]  00 00                    add     [bx+si],al
F000:6AEC  [+0x06AEC]  66 66 66 66 7C 60        o32 jl  short 00006B52h
F000:6AF2  [+0x06AF2]  60                       pusha
F000:6AF3  [+0x06AF3]  C0 00 00                 rol     byte [bx+si],0
F000:6AF6  [+0x06AF6]  00 00                    add     [bx+si],al
F000:6AF8  [+0x06AF8]  00 00                    add     [bx+si],al
F000:6AFA  [+0x06AFA]  76 DC                    jbe     short 6AD8h
F000:6AFC  [+0x06AFC]  18 18                    sbb     [bx+si],bl
F000:6AFE  [+0x06AFE]  18 18                    sbb     [bx+si],bl
F000:6B00  [+0x06B00]  18 00                    sbb     [bx+si],al
F000:6B02  [+0x06B02]  00 00                    add     [bx+si],al
F000:6B04  [+0x06B04]  00 00                    add     [bx+si],al
F000:6B06  [+0x06B06]  7E 18                    jle     short 6B20h
F000:6B08  [+0x06B08]  3C 66                    cmp     al,66h
F000:6B0A  [+0x06B0A]  66 66 3C 18              cmp     al,18h
F000:6B0E  [+0x06B0E]  7E 00                    jle     short 6B10h
F000:6B10  [+0x06B10]  00 00                    add     [bx+si],al
F000:6B12  [+0x06B12]  00 00                    add     [bx+si],al
F000:6B14  [+0x06B14]  38 6C C6                 cmp     [si-3Ah],ch
F000:6B17  [+0x06B17]  DB 0xC6  (bad)
F000:6B19  [+0x06B19]  C6 C6 6C                 mov     dh,6Ch
F000:6B1C  [+0x06B1C]  38 00                    cmp     [bx+si],al
F000:6B1E  [+0x06B1E]  00 00                    add     [bx+si],al
F000:6B20  [+0x06B20]  00 00                    add     [bx+si],al
F000:6B22  [+0x06B22]  38 6C C6                 cmp     [si-3Ah],ch
F000:6B25  [+0x06B25]  C6 C6 6C                 mov     dh,6Ch
F000:6B28  [+0x06B28]  6C                       insb
F000:6B29  [+0x06B29]  6C                       insb
F000:6B2A  [+0x06B2A]  EE                       out     dx,al
F000:6B2B  [+0x06B2B]  00 00                    add     [bx+si],al
F000:6B2D  [+0x06B2D]  00 00                    add     [bx+si],al
F000:6B2F  [+0x06B2F]  00 1E 30 18              add     [1830h],bl
F000:6B33  [+0x06B33]  0C 3E                    or      al,3Eh
F000:6B35  [+0x06B35]  66 66 66 3C 00           cmp     al,0
F000:6B3A  [+0x06B3A]  00 00                    add     [bx+si],al
F000:6B3C  [+0x06B3C]  00 00                    add     [bx+si],al
F000:6B3E  [+0x06B3E]  00 00                    add     [bx+si],al
F000:6B40  [+0x06B40]  00 7E DB                 add     [bp-25h],bh
F000:6B43  [+0x06B43]  DB 7E 00                 fstp    tword [bp]
F000:6B46  [+0x06B46]  00 00                    add     [bx+si],al
F000:6B48  [+0x06B48]  00 00                    add     [bx+si],al
F000:6B4A  [+0x06B4A]  00 00                    add     [bx+si],al
F000:6B4C  [+0x06B4C]  03 06 7E CF              add     ax,[0CF7Eh]
F000:6B50  [+0x06B50]  DB F3                    fcomi   st3
F000:6B52  [+0x06B52]  7E 60                    jle     short 6BB4h
F000:6B54  [+0x06B54]  C0 00 00                 rol     byte [bx+si],0
F000:6B57  [+0x06B57]  00 00                    add     [bx+si],al
F000:6B59  [+0x06B59]  00 1C                    add     [si],bl
F000:6B5B  [+0x06B5B]  30 60 60                 xor     [bx+si+60h],ah
F000:6B5E  [+0x06B5E]  7C 60                    jl      short 6BC0h
F000:6B60  [+0x06B60]  60                       pusha
F000:6B61  [+0x06B61]  30 1C                    xor     [si],bl
F000:6B63  [+0x06B63]  00 00                    add     [bx+si],al
F000:6B65  [+0x06B65]  00 00                    add     [bx+si],al
F000:6B67  [+0x06B67]  00 00                    add     [bx+si],al
F000:6B69  [+0x06B69]  7C C6                    jl      short 6B31h
F000:6B6B  [+0x06B6B]  C6 C6 C6                 mov     dh,0C6h
F000:6B6E  [+0x06B6E]  C6 C6 C6                 mov     dh,0C6h
F000:6B71  [+0x06B71]  00 00                    add     [bx+si],al
F000:6B73  [+0x06B73]  00 00                    add     [bx+si],al
F000:6B75  [+0x06B75]  00 00                    add     [bx+si],al
F000:6B77  [+0x06B77]  FE 00                    inc     byte [bx+si]
F000:6B79  [+0x06B79]  00 FE                    add     dh,bh
F000:6B7B  [+0x06B7B]  00 00                    add     [bx+si],al
F000:6B7D  [+0x06B7D]  FE 00                    inc     byte [bx+si]
F000:6B7F  [+0x06B7F]  00 00                    add     [bx+si],al
F000:6B81  [+0x06B81]  00 00                    add     [bx+si],al
F000:6B83  [+0x06B83]  00 00                    add     [bx+si],al
F000:6B85  [+0x06B85]  18 18                    sbb     [bx+si],bl
F000:6B87  [+0x06B87]  7E 18                    jle     short 6BA1h
F000:6B89  [+0x06B89]  18 00                    sbb     [bx+si],al
F000:6B8B  [+0x06B8B]  00 FF                    add     bh,bh
F000:6B8D  [+0x06B8D]  00 00                    add     [bx+si],al
F000:6B8F  [+0x06B8F]  00 00                    add     [bx+si],al
F000:6B91  [+0x06B91]  00 30                    add     [bx+si],dh
F000:6B93  [+0x06B93]  18 0C                    sbb     [si],cl
F000:6B95  [+0x06B95]  06                       push    es
F000:6B96  [+0x06B96]  0C 18                    or      al,18h
F000:6B98  [+0x06B98]  30 00                    xor     [bx+si],al
F000:6B9A  [+0x06B9A]  7E 00                    jle     short 6B9Ch
F000:6B9C  [+0x06B9C]  00 00                    add     [bx+si],al
F000:6B9E  [+0x06B9E]  00 00                    add     [bx+si],al
F000:6BA0  [+0x06BA0]  0C 18                    or      al,18h
F000:6BA2  [+0x06BA2]  30 60 30                 xor     [bx+si+30h],ah
F000:6BA5  [+0x06BA5]  18 0C                    sbb     [si],cl
F000:6BA7  [+0x06BA7]  00 7E 00                 add     [bp],bh
F000:6BAA  [+0x06BAA]  00 00                    add     [bx+si],al
F000:6BAC  [+0x06BAC]  00 00                    add     [bx+si],al
F000:6BAE  [+0x06BAE]  0E                       push    cs
F000:6BAF  [+0x06BAF]  1B 1B                    sbb     bx,[bp+di]
F000:6BB1  [+0x06BB1]  18 18                    sbb     [bx+si],bl
F000:6BB3  [+0x06BB3]  18 18                    sbb     [bx+si],bl
F000:6BB5  [+0x06BB5]  18 18                    sbb     [bx+si],bl
F000:6BB7  [+0x06BB7]  18 18                    sbb     [bx+si],bl
F000:6BB9  [+0x06BB9]  18 18                    sbb     [bx+si],bl
F000:6BBB  [+0x06BBB]  18 18                    sbb     [bx+si],bl
F000:6BBD  [+0x06BBD]  18 18                    sbb     [bx+si],bl
F000:6BBF  [+0x06BBF]  18 18                    sbb     [bx+si],bl
F000:6BC1  [+0x06BC1]  18 D8                    sbb     al,bl
F000:6BC3  [+0x06BC3]  D8 70 00                 fdiv    dword [bx+si]
F000:6BC6  [+0x06BC6]  00 00                    add     [bx+si],al
F000:6BC8  [+0x06BC8]  00 00                    add     [bx+si],al
F000:6BCA  [+0x06BCA]  00 18                    add     [bx+si],bl
F000:6BCC  [+0x06BCC]  18 00                    sbb     [bx+si],al
F000:6BCE  [+0x06BCE]  7E 00                    jle     short 6BD0h
F000:6BD0  [+0x06BD0]  18 18                    sbb     [bx+si],bl
F000:6BD2  [+0x06BD2]  00 00                    add     [bx+si],al
F000:6BD4  [+0x06BD4]  00 00                    add     [bx+si],al
F000:6BD6  [+0x06BD6]  00 00                    add     [bx+si],al
F000:6BD8  [+0x06BD8]  00 00                    add     [bx+si],al
F000:6BDA  [+0x06BDA]  76 DC                    jbe     short 6BB8h
F000:6BDC  [+0x06BDC]  00 76 DC                 add     [bp-24h],dh
F000:6BDF  [+0x06BDF]  00 00                    add     [bx+si],al
F000:6BE1  [+0x06BE1]  00 00                    add     [bx+si],al
F000:6BE3  [+0x06BE3]  00 00                    add     [bx+si],al
F000:6BE5  [+0x06BE5]  38 6C 6C                 cmp     [si+6Ch],ch
F000:6BE8  [+0x06BE8]  38 00                    cmp     [bx+si],al
F000:6BEA  [+0x06BEA]  00 00                    add     [bx+si],al
F000:6BEC  [+0x06BEC]  00 00                    add     [bx+si],al
F000:6BEE  [+0x06BEE]  00 00                    add     [bx+si],al
F000:6BF0  [+0x06BF0]  00 00                    add     [bx+si],al
F000:6BF2  [+0x06BF2]  00 00                    add     [bx+si],al
F000:6BF4  [+0x06BF4]  00 00                    add     [bx+si],al
F000:6BF6  [+0x06BF6]  00 00                    add     [bx+si],al
F000:6BF8  [+0x06BF8]  18 18                    sbb     [bx+si],bl
F000:6BFA  [+0x06BFA]  00 00                    add     [bx+si],al
F000:6BFC  [+0x06BFC]  00 00                    add     [bx+si],al
F000:6BFE  [+0x06BFE]  00 00                    add     [bx+si],al
F000:6C00  [+0x06C00]  00 00                    add     [bx+si],al
F000:6C02  [+0x06C02]  00 00                    add     [bx+si],al
F000:6C04  [+0x06C04]  00 00                    add     [bx+si],al
F000:6C06  [+0x06C06]  00 18                    add     [bx+si],bl
F000:6C08  [+0x06C08]  00 00                    add     [bx+si],al
F000:6C0A  [+0x06C0A]  00 00                    add     [bx+si],al
F000:6C0C  [+0x06C0C]  00 00                    add     [bx+si],al
F000:6C0E  [+0x06C0E]  00 0F                    add     [bx],cl
F000:6C10  [+0x06C10]  0C 0C                    or      al,0Ch
F000:6C12  [+0x06C12]  0C 0C                    or      al,0Ch
F000:6C14  [+0x06C14]  0C EC                    or      al,0ECh
F000:6C16  [+0x06C16]  6C                       insb
F000:6C17  [+0x06C17]  3C 1C                    cmp     al,1Ch
F000:6C19  [+0x06C19]  00 00                    add     [bx+si],al
F000:6C1B  [+0x06C1B]  00 00                    add     [bx+si],al
F000:6C1D  [+0x06C1D]  D8 6C 6C                 fsubr   dword [si+6Ch]
F000:6C20  [+0x06C20]  6C                       insb
F000:6C21  [+0x06C21]  6C                       insb
F000:6C22  [+0x06C22]  6C                       insb
F000:6C23  [+0x06C23]  00 00                    add     [bx+si],al
F000:6C25  [+0x06C25]  00 00                    add     [bx+si],al
F000:6C27  [+0x06C27]  00 00                    add     [bx+si],al
F000:6C29  [+0x06C29]  00 00                    add     [bx+si],al
F000:6C2B  [+0x06C2B]  70 98                    jo      short 6BC5h
F000:6C2D  [+0x06C2D]  30 60 C8                 xor     [bx+si-38h],ah
F000:6C30  [+0x06C30]  F8                       clc
F000:6C31  [+0x06C31]  00 00                    add     [bx+si],al
F000:6C33  [+0x06C33]  00 00                    add     [bx+si],al
F000:6C35  [+0x06C35]  00 00                    add     [bx+si],al
F000:6C37  [+0x06C37]  00 00                    add     [bx+si],al
F000:6C39  [+0x06C39]  00 00                    add     [bx+si],al
F000:6C3B  [+0x06C3B]  00 7C 7C                 add     [si+7Ch],bh
F000:6C3E  [+0x06C3E]  7C 7C                    jl      short 6CBCh
F000:6C40  [+0x06C40]  7C 7C                    jl      short 6CBEh
F000:6C42  [+0x06C42]  00 00                    add     [bx+si],al
F000:6C44  [+0x06C44]  00 00                    add     [bx+si],al
F000:6C46  [+0x06C46]  00 00                    add     [bx+si],al
F000:6C48  [+0x06C48]  00 00                    add     [bx+si],al
F000:6C4A  [+0x06C4A]  00 00                    add     [bx+si],al
F000:6C4C  [+0x06C4C]  00 00                    add     [bx+si],al
F000:6C4E  [+0x06C4E]  00 00                    add     [bx+si],al
F000:6C50  [+0x06C50]  00 00                    add     [bx+si],al
F000:6C52  [+0x06C52]  00 00                    add     [bx+si],al
F000:6C54  [+0x06C54]  1D 00 00                 sbb     ax,0
F000:6C57  [+0x06C57]  00 00                    add     [bx+si],al
F000:6C59  [+0x06C59]  24 66                    and     al,66h
F000:6C5B  [+0x06C5B]  FF 66 24                 jmp     word [bp+24h]
F000:6C5E  [+0x06C5E]  00 00                    add     [bx+si],al
F000:6C60  [+0x06C60]  00 00                    add     [bx+si],al
F000:6C62  [+0x06C62]  00 22                    add     [bp+si],ah
F000:6C64  [+0x06C64]  00 63 63                 add     [bp+di+63h],ah
F000:6C67  [+0x06C67]  63 22                    arpl    [bp+si],sp
F000:6C69  [+0x06C69]  00 00                    add     [bx+si],al
F000:6C6B  [+0x06C6B]  00 00                    add     [bx+si],al
F000:6C6D  [+0x06C6D]  00 00                    add     [bx+si],al
F000:6C6F  [+0x06C6F]  00 00                    add     [bx+si],al
F000:6C71  [+0x06C71]  00 2B                    add     [bp+di],ch
F000:6C73  [+0x06C73]  00 00                    add     [bx+si],al
F000:6C75  [+0x06C75]  00 18                    add     [bx+si],bl
F000:6C77  [+0x06C77]  18 18                    sbb     [bx+si],bl
F000:6C79  [+0x06C79]  FF 18                    call    far [bx+si]
F000:6C7B  [+0x06C7B]  18 18                    sbb     [bx+si],bl
F000:6C7D  [+0x06C7D]  00 00                    add     [bx+si],al
F000:6C7F  [+0x06C7F]  00 00                    add     [bx+si],al
F000:6C81  [+0x06C81]  2D 00 00                 sub     ax,0
F000:6C84  [+0x06C84]  00 00                    add     [bx+si],al
F000:6C86  [+0x06C86]  00 00                    add     [bx+si],al
F000:6C88  [+0x06C88]  FF 00                    inc     word [bx+si]
F000:6C8A  [+0x06C8A]  00 00                    add     [bx+si],al
F000:6C8C  [+0x06C8C]  00 00                    add     [bx+si],al
F000:6C8E  [+0x06C8E]  00 00                    add     [bx+si],al
F000:6C90  [+0x06C90]  4D                       dec     bp
F000:6C91  [+0x06C91]  00 00                    add     [bx+si],al
F000:6C93  [+0x06C93]  C3                       ret
F000:6C94  [+0x06C94]  E7 FF                    out     0FFh,ax
F000:6C96  [+0x06C96]  DB C3                    fcmovnb st3
F000:6C98  [+0x06C98]  C3                       ret
F000:6C99  [+0x06C99]  C3                       ret
F000:6C9A  [+0x06C9A]  C3                       ret
F000:6C9B  [+0x06C9B]  C3                       ret
F000:6C9C  [+0x06C9C]  00 00                    add     [bx+si],al
F000:6C9E  [+0x06C9E]  00 54 00                 add     [si],dl
F000:6CA1  [+0x06CA1]  00 FF                    add     bh,bh
F000:6CA3  [+0x06CA3]  DB 99 18 18              fistp   dword [bx+di+1818h]
F000:6CA7  [+0x06CA7]  18 18                    sbb     [bx+si],bl
F000:6CA9  [+0x06CA9]  18 3C                    sbb     [si],bh
F000:6CAB  [+0x06CAB]  00 00                    add     [bx+si],al
F000:6CAD  [+0x06CAD]  00 57 00                 add     [bx],dl
F000:6CB0  [+0x06CB0]  00 C3                    add     bl,al
F000:6CB2  [+0x06CB2]  C3                       ret
F000:6CB3  [+0x06CB3]  C3                       ret
F000:6CB4  [+0x06CB4]  C3                       ret
F000:6CB5  [+0x06CB5]  DB DB                    fcmovnu st3
F000:6CB7  [+0x06CB7]  FF 66 66                 jmp     word [bp+66h]
F000:6CBA  [+0x06CBA]  00 00                    add     [bx+si],al
F000:6CBC  [+0x06CBC]  00 58 00                 add     [bx+si],bl
F000:6CBF  [+0x06CBF]  00 C3                    add     bl,al
F000:6CC1  [+0x06CC1]  C3                       ret
F000:6CC2  [+0x06CC2]  66 3C 18                 cmp     al,18h
F000:6CC5  [+0x06CC5]  3C 66                    cmp     al,66h
F000:6CC7  [+0x06CC7]  C3                       ret
F000:6CC8  [+0x06CC8]  C3                       ret
F000:6CC9  [+0x06CC9]  00 00                    add     [bx+si],al
F000:6CCB  [+0x06CCB]  00 5A 00                 add     [bp+si],bl
F000:6CCE  [+0x06CCE]  00 FF                    add     bh,bh
F000:6CD0  [+0x06CD0]  C3                       ret
F000:6CD1  [+0x06CD1]  86 0C                    xchg    cl,[si]
F000:6CD3  [+0x06CD3]  18 30                    sbb     [bx+si],dh
F000:6CD5  [+0x06CD5]  61                       popa
F000:6CD6  [+0x06CD6]  C3                       ret
F000:6CD7  [+0x06CD7]  FF 00                    inc     word [bx+si]
F000:6CD9  [+0x06CD9]  00 00                    add     [bx+si],al
F000:6CDB  [+0x06CDB]  5B                       pop     bx
F000:6CDC  [+0x06CDC]  00 00                    add     [bx+si],al
F000:6CDE  [+0x06CDE]  3E 30 30                 xor     [bx+si],dh
F000:6CE1  [+0x06CE1]  30 30                    xor     [bx+si],dh
F000:6CE3  [+0x06CE3]  30 30                    xor     [bx+si],dh
F000:6CE5  [+0x06CE5]  30 3E 00 00              xor     [0],bh
F000:6CE9  [+0x06CE9]  00 5D 00                 add     [di],bl
F000:6CEC  [+0x06CEC]  00 3E 06 06              add     [606h],bh
F000:6CF0  [+0x06CF0]  06                       push    es
F000:6CF1  [+0x06CF1]  06                       push    es
F000:6CF2  [+0x06CF2]  06                       push    es
F000:6CF3  [+0x06CF3]  06                       push    es
F000:6CF4  [+0x06CF4]  06                       push    es
F000:6CF5  [+0x06CF5]  3E 00 00                 add     [bx+si],al
F000:6CF8  [+0x06CF8]  00 6D 00                 add     [di],ch
F000:6CFB  [+0x06CFB]  00 00                    add     [bx+si],al
F000:6CFD  [+0x06CFD]  00 00                    add     [bx+si],al
F000:6CFF  [+0x06CFF]  E6 FF                    out     0FFh,al
F000:6D01  [+0x06D01]  DB DB                    fcmovnu st3
F000:6D03  [+0x06D03]  DB DB                    fcmovnu st3
F000:6D05  [+0x06D05]  00 00                    add     [bx+si],al
F000:6D07  [+0x06D07]  00 77 00                 add     [bx],dh
F000:6D0A  [+0x06D0A]  00 00                    add     [bx+si],al
F000:6D0C  [+0x06D0C]  00 00                    add     [bx+si],al
F000:6D0E  [+0x06D0E]  C3                       ret
F000:6D0F  [+0x06D0F]  C3                       ret
F000:6D10  [+0x06D10]  DB DB                    fcmovnu st3
F000:6D12  [+0x06D12]  FF 66 00                 jmp     word [bp]
F000:6D15  [+0x06D15]  00 00                    add     [bx+si],al
F000:6D17  [+0x06D17]  91                       xchg    cx,ax
F000:6D18  [+0x06D18]  00 00                    add     [bx+si],al
F000:6D1A  [+0x06D1A]  00 00                    add     [bx+si],al
F000:6D1C  [+0x06D1C]  6E                       outsb
F000:6D1D  [+0x06D1D]  3B 1B                    cmp     bx,[bp+di]
F000:6D1F  [+0x06D1F]  7E D8                    jle     short 6CF9h
F000:6D21  [+0x06D21]  DC 77 00                 fdiv    qword [bx]
F000:6D24  [+0x06D24]  00 00                    add     [bx+si],al
F000:6D26  [+0x06D26]  9D                       popf
F000:6D27  [+0x06D27]  00 00                    add     [bx+si],al
F000:6D29  [+0x06D29]  C3                       ret
F000:6D2A  [+0x06D2A]  66 3C 18                 cmp     al,18h
F000:6D2D  [+0x06D2D]  7E 18                    jle     short 6D47h
F000:6D2F  [+0x06D2F]  7E 18                    jle     short 6D49h
F000:6D31  [+0x06D31]  18 00                    sbb     [bx+si],al
F000:6D33  [+0x06D33]  00 00                    add     [bx+si],al
F000:6D35  [+0x06D35]  9E                       sahf
F000:6D36  [+0x06D36]  00 FC                    add     ah,bh
F000:6D38  [+0x06D38]  66 66 7C 62              o32 jl  short 00006D9Eh
F000:6D3C  [+0x06D3C]  66 6F                    outsd
F000:6D3E  [+0x06D3E]  66 66 F3 00 00           add     [bx+si],al
F000:6D43  [+0x06D43]  00 F1                    add     cl,dh
F000:6D45  [+0x06D45]  00 00                    add     [bx+si],al
F000:6D47  [+0x06D47]  18 18                    sbb     [bx+si],bl
F000:6D49  [+0x06D49]  18 FF                    sbb     bh,bh
F000:6D4B  [+0x06D4B]  18 18                    sbb     [bx+si],bl
F000:6D4D  [+0x06D4D]  18 00                    sbb     [bx+si],al
F000:6D4F  [+0x06D4F]  FF 00                    inc     word [bx+si]
F000:6D51  [+0x06D51]  00 00                    add     [bx+si],al
F000:6D53  [+0x06D53]  F6 00 00                 test    byte [bx+si],0
F000:6D56  [+0x06D56]  18 18                    sbb     [bx+si],bl
F000:6D58  [+0x06D58]  00 00                    add     [bx+si],al
F000:6D5A  [+0x06D5A]  FF 00                    inc     word [bx+si]
F000:6D5C  [+0x06D5C]  00 18                    add     [bx+si],bl
F000:6D5E  [+0x06D5E]  18 00                    sbb     [bx+si],al
F000:6D60  [+0x06D60]  00 00                    add     [bx+si],al
F000:6D62  [+0x06D62]  00 00                    add     [bx+si],al
F000:6D64  [+0x06D64]  00 00                    add     [bx+si],al
F000:6D66  [+0x06D66]  00 00                    add     [bx+si],al
F000:6D68  [+0x06D68]  00 00                    add     [bx+si],al
F000:6D6A  [+0x06D6A]  00 00                    add     [bx+si],al
F000:6D6C  [+0x06D6C]  00 00                    add     [bx+si],al
F000:6D6E  [+0x06D6E]  00 00                    add     [bx+si],al
F000:6D70  [+0x06D70]  00 00                    add     [bx+si],al
F000:6D72  [+0x06D72]  00 00                    add     [bx+si],al
F000:6D74  [+0x06D74]  00 00                    add     [bx+si],al
F000:6D76  [+0x06D76]  7E 81                    jle     short 6CF9h
F000:6D78  [+0x06D78]  A5                       movsw
F000:6D79  [+0x06D79]  81 81 BD 99 81 81        add     word [bx+di-6643h],8181h
F000:6D7F  [+0x06D7F]  7E 00                    jle     short 6D81h
F000:6D81  [+0x06D81]  00 00                    add     [bx+si],al
F000:6D83  [+0x06D83]  00 00                    add     [bx+si],al
F000:6D85  [+0x06D85]  00 7E FF                 add     [bp-1],bh
F000:6D88  [+0x06D88]  DB 0xDB  (bad)
F000:6D8A  [+0x06D8A]  FF C3                    inc     bx
F000:6D8C  [+0x06D8C]  E7 FF                    out     0FFh,ax
F000:6D8E  [+0x06D8E]  DB 0xFF  (bad)
F000:6D90  [+0x06D90]  00 00                    add     [bx+si],al
F000:6D92  [+0x06D92]  00 00                    add     [bx+si],al
F000:6D94  [+0x06D94]  00 00                    add     [bx+si],al
F000:6D96  [+0x06D96]  00 00                    add     [bx+si],al
F000:6D98  [+0x06D98]  6C                       insb
F000:6D99  [+0x06D99]  DB 0xFE  (bad)
F000:6D9B  [+0x06D9B]  DB 0xFE  (bad)
F000:6D9D  [+0x06D9D]  7C 38                    jl      short 6DD7h
F000:6D9F  [+0x06D9F]  10 00                    adc     [bx+si],al
F000:6DA1  [+0x06DA1]  00 00                    add     [bx+si],al
F000:6DA3  [+0x06DA3]  00 00                    add     [bx+si],al
F000:6DA5  [+0x06DA5]  00 00                    add     [bx+si],al
F000:6DA7  [+0x06DA7]  00 10                    add     [bx+si],dl
F000:6DA9  [+0x06DA9]  38 7C FE                 cmp     [si-2],bh
F000:6DAC  [+0x06DAC]  7C 38                    jl      short 6DE6h
F000:6DAE  [+0x06DAE]  10 00                    adc     [bx+si],al
F000:6DB0  [+0x06DB0]  00 00                    add     [bx+si],al
F000:6DB2  [+0x06DB2]  00 00                    add     [bx+si],al
F000:6DB4  [+0x06DB4]  00 00                    add     [bx+si],al
F000:6DB6  [+0x06DB6]  00 18                    add     [bx+si],bl
F000:6DB8  [+0x06DB8]  3C 3C                    cmp     al,3Ch
F000:6DBA  [+0x06DBA]  E7 E7                    out     0E7h,ax
F000:6DBC  [+0x06DBC]  E7 99                    out     99h,ax
F000:6DBE  [+0x06DBE]  18 3C                    sbb     [si],bh
F000:6DC0  [+0x06DC0]  00 00                    add     [bx+si],al
F000:6DC2  [+0x06DC2]  00 00                    add     [bx+si],al
F000:6DC4  [+0x06DC4]  00 00                    add     [bx+si],al
F000:6DC6  [+0x06DC6]  00 18                    add     [bx+si],bl
F000:6DC8  [+0x06DC8]  3C 7E                    cmp     al,7Eh
F000:6DCA  [+0x06DCA]  DB 0xFF  (bad)
F000:6DCC  [+0x06DCC]  7E 18                    jle     short 6DE6h
F000:6DCE  [+0x06DCE]  18 3C                    sbb     [si],bh
F000:6DD0  [+0x06DD0]  00 00                    add     [bx+si],al
F000:6DD2  [+0x06DD2]  00 00                    add     [bx+si],al
F000:6DD4  [+0x06DD4]  00 00                    add     [bx+si],al
F000:6DD6  [+0x06DD6]  00 00                    add     [bx+si],al
F000:6DD8  [+0x06DD8]  00 00                    add     [bx+si],al
F000:6DDA  [+0x06DDA]  18 3C                    sbb     [si],bh
F000:6DDC  [+0x06DDC]  3C 18                    cmp     al,18h
F000:6DDE  [+0x06DDE]  00 00                    add     [bx+si],al
F000:6DE0  [+0x06DE0]  00 00                    add     [bx+si],al
F000:6DE2  [+0x06DE2]  00 00                    add     [bx+si],al
F000:6DE4  [+0x06DE4]  DB 0xFF  (bad)
F000:6DE6  [+0x06DE6]  DB 0xFF  (bad)
F000:6DE8  [+0x06DE8]  DB 0xFF  (bad)
F000:6DEA  [+0x06DEA]  E7 C3                    out     0C3h,ax
F000:6DEC  [+0x06DEC]  C3                       ret
F000:6DED  [+0x06DED]  E7 FF                    out     0FFh,ax
F000:6DEF  [+0x06DEF]  DB 0xFF  (bad)
F000:6DF1  [+0x06DF1]  DB 0xFF  (bad)
F000:6DF3  [+0x06DF3]  FF 00                    inc     word [bx+si]
F000:6DF5  [+0x06DF5]  00 00                    add     [bx+si],al
F000:6DF7  [+0x06DF7]  00 00                    add     [bx+si],al
F000:6DF9  [+0x06DF9]  3C 66                    cmp     al,66h
F000:6DFB  [+0x06DFB]  42                       inc     dx
F000:6DFC  [+0x06DFC]  42                       inc     dx
F000:6DFD  [+0x06DFD]  66 3C 00                 cmp     al,0
F000:6E00  [+0x06E00]  00 00                    add     [bx+si],al
F000:6E02  [+0x06E02]  00 00                    add     [bx+si],al
F000:6E04  [+0x06E04]  DB 0xFF  (bad)
F000:6E06  [+0x06E06]  DB 0xFF  (bad)
F000:6E08  [+0x06E08]  FF C3                    inc     bx
F000:6E0A  [+0x06E0A]  99                       cwd
F000:6E0B  [+0x06E0B]  BD BD 99                 mov     bp,99BDh
F000:6E0E  [+0x06E0E]  C3                       ret
F000:6E0F  [+0x06E0F]  DB 0xFF  (bad)
F000:6E11  [+0x06E11]  DB 0xFF  (bad)
F000:6E13  [+0x06E13]  FF 00                    inc     word [bx+si]
F000:6E15  [+0x06E15]  00 1E 0E 1A              add     [1A0Eh],bl
F000:6E19  [+0x06E19]  32 78 CC                 xor     bh,[bx+si-34h]
F000:6E1C  [+0x06E1C]  CC                       int3
F000:6E1D  [+0x06E1D]  CC                       int3
F000:6E1E  [+0x06E1E]  CC                       int3
F000:6E1F  [+0x06E1F]  78 00                    js      short 6E21h
F000:6E21  [+0x06E21]  00 00                    add     [bx+si],al
F000:6E23  [+0x06E23]  00 00                    add     [bx+si],al
F000:6E25  [+0x06E25]  00 3C                    add     [si],bh
F000:6E27  [+0x06E27]  66 66 66 66 3C 18        cmp     al,18h
F000:6E2D  [+0x06E2D]  7E 18                    jle     short 6E47h
F000:6E2F  [+0x06E2F]  18 00                    sbb     [bx+si],al
F000:6E31  [+0x06E31]  00 00                    add     [bx+si],al
F000:6E33  [+0x06E33]  00 00                    add     [bx+si],al
F000:6E35  [+0x06E35]  00 3F                    add     [bx],bh
F000:6E37  [+0x06E37]  33 3F                    xor     di,[bx]
F000:6E39  [+0x06E39]  30 30                    xor     [bx+si],dh
F000:6E3B  [+0x06E3B]  30 30                    xor     [bx+si],dh
F000:6E3D  [+0x06E3D]  70 F0                    jo      short 6E2Fh
F000:6E3F  [+0x06E3F]  E0 00                    loopne  6E41h
F000:6E41  [+0x06E41]  00 00                    add     [bx+si],al
F000:6E43  [+0x06E43]  00 00                    add     [bx+si],al
F000:6E45  [+0x06E45]  00 7F 63                 add     [bx+63h],bh
F000:6E48  [+0x06E48]  7F 63                    jg      short 6EADh
F000:6E4A  [+0x06E4A]  63 63 63                 arpl    [bp+di+63h],sp
F000:6E4D  [+0x06E4D]  67 E7 E6                 out     0E6h,ax
F000:6E50  [+0x06E50]  C0 00 00                 rol     byte [bx+si],0
F000:6E53  [+0x06E53]  00 00                    add     [bx+si],al
F000:6E55  [+0x06E55]  00 00                    add     [bx+si],al
F000:6E57  [+0x06E57]  18 18                    sbb     [bx+si],bl
F000:6E59  [+0x06E59]  DB 3C                    fstp    tword [si]
F000:6E5B  [+0x06E5B]  E7 3C                    out     3Ch,ax
F000:6E5D  [+0x06E5D]  DB 18                    fistp   dword [bx+si]
F000:6E5F  [+0x06E5F]  18 00                    sbb     [bx+si],al
F000:6E61  [+0x06E61]  00 00                    add     [bx+si],al
F000:6E63  [+0x06E63]  00 00                    add     [bx+si],al
F000:6E65  [+0x06E65]  80 C0 E0                 add     al,0E0h
F000:6E68  [+0x06E68]  DB 0xF0  (bad)
F000:6E6A  [+0x06E6A]  DB 0xFE  (bad)
F000:6E6C  [+0x06E6C]  DB 0xF0  (bad)
F000:6E6F  [+0x06E6F]  80 00 00                 add     byte [bx+si],0
F000:6E72  [+0x06E72]  00 00                    add     [bx+si],al
F000:6E74  [+0x06E74]  00 02                    add     [bp+si],al
F000:6E76  [+0x06E76]  06                       push    es
F000:6E77  [+0x06E77]  0E                       push    cs
F000:6E78  [+0x06E78]  1E                       push    ds
F000:6E79  [+0x06E79]  DB 0x3E  (bad)
F000:6E7C  [+0x06E7C]  1E                       push    ds
F000:6E7D  [+0x06E7D]  0E                       push    cs
F000:6E7E  [+0x06E7E]  06                       push    es
F000:6E7F  [+0x06E7F]  02 00                    add     al,[bx+si]
F000:6E81  [+0x06E81]  00 00                    add     [bx+si],al
F000:6E83  [+0x06E83]  00 00                    add     [bx+si],al
F000:6E85  [+0x06E85]  00 18                    add     [bx+si],bl
F000:6E87  [+0x06E87]  3C 7E                    cmp     al,7Eh
F000:6E89  [+0x06E89]  18 18                    sbb     [bx+si],bl
F000:6E8B  [+0x06E8B]  18 18                    sbb     [bx+si],bl
F000:6E8D  [+0x06E8D]  7E 3C                    jle     short 6ECBh
F000:6E8F  [+0x06E8F]  18 00                    sbb     [bx+si],al
F000:6E91  [+0x06E91]  00 00                    add     [bx+si],al
F000:6E93  [+0x06E93]  00 00                    add     [bx+si],al
F000:6E95  [+0x06E95]  00 66 66                 add     [bp+66h],ah
F000:6E98  [+0x06E98]  66 66 66 66 66 00 66 66  add     [bp+66h],ah
F000:6EA0  [+0x06EA0]  00 00                    add     [bx+si],al
F000:6EA2  [+0x06EA2]  00 00                    add     [bx+si],al
F000:6EA4  [+0x06EA4]  00 00                    add     [bx+si],al
F000:6EA6  [+0x06EA6]  7F DB                    jg      short 6E83h
F000:6EA8  [+0x06EA8]  DB DB                    fcmovnu st3
F000:6EAA  [+0x06EAA]  7B 1B                    jnp     short 6EC7h
F000:6EAC  [+0x06EAC]  1B 1B                    sbb     bx,[bp+di]
F000:6EAE  [+0x06EAE]  1B 1B                    sbb     bx,[bp+di]
F000:6EB0  [+0x06EB0]  00 00                    add     [bx+si],al
F000:6EB2  [+0x06EB2]  00 00                    add     [bx+si],al
F000:6EB4  [+0x06EB4]  00 7C C6                 add     [si-3Ah],bh
F000:6EB7  [+0x06EB7]  60                       pusha
F000:6EB8  [+0x06EB8]  38 6C C6                 cmp     [si-3Ah],ch
F000:6EBB  [+0x06EBB]  DB 0xC6  (bad)
F000:6EBD  [+0x06EBD]  38 0C                    cmp     [si],cl
F000:6EBF  [+0x06EBF]  DB 0xC6  (bad)
F000:6EC1  [+0x06EC1]  00 00                    add     [bx+si],al
F000:6EC3  [+0x06EC3]  00 00                    add     [bx+si],al
F000:6EC5  [+0x06EC5]  00 00                    add     [bx+si],al
F000:6EC7  [+0x06EC7]  00 00                    add     [bx+si],al
F000:6EC9  [+0x06EC9]  00 00                    add     [bx+si],al
F000:6ECB  [+0x06ECB]  00 FE                    add     dh,bh
F000:6ECD  [+0x06ECD]  DB 0xFE  (bad)
F000:6ECF  [+0x06ECF]  FE 00                    inc     byte [bx+si]
F000:6ED1  [+0x06ED1]  00 00                    add     [bx+si],al
F000:6ED3  [+0x06ED3]  00 00                    add     [bx+si],al
F000:6ED5  [+0x06ED5]  00 18                    add     [bx+si],bl
F000:6ED7  [+0x06ED7]  3C 7E                    cmp     al,7Eh
F000:6ED9  [+0x06ED9]  18 18                    sbb     [bx+si],bl
F000:6EDB  [+0x06EDB]  18 18                    sbb     [bx+si],bl
F000:6EDD  [+0x06EDD]  7E 3C                    jle     short 6F1Bh
F000:6EDF  [+0x06EDF]  18 7E 00                 sbb     [bp],bh
F000:6EE2  [+0x06EE2]  00 00                    add     [bx+si],al
F000:6EE4  [+0x06EE4]  00 00                    add     [bx+si],al
F000:6EE6  [+0x06EE6]  18 3C                    sbb     [si],bh
F000:6EE8  [+0x06EE8]  7E 18                    jle     short 6F02h
F000:6EEA  [+0x06EEA]  18 18                    sbb     [bx+si],bl
F000:6EEC  [+0x06EEC]  18 18                    sbb     [bx+si],bl
F000:6EEE  [+0x06EEE]  18 18                    sbb     [bx+si],bl
F000:6EF0  [+0x06EF0]  00 00                    add     [bx+si],al
F000:6EF2  [+0x06EF2]  00 00                    add     [bx+si],al
F000:6EF4  [+0x06EF4]  00 00                    add     [bx+si],al
F000:6EF6  [+0x06EF6]  18 18                    sbb     [bx+si],bl
F000:6EF8  [+0x06EF8]  18 18                    sbb     [bx+si],bl
F000:6EFA  [+0x06EFA]  18 18                    sbb     [bx+si],bl
F000:6EFC  [+0x06EFC]  18 7E 3C                 sbb     [bp+3Ch],bh
F000:6EFF  [+0x06EFF]  18 00                    sbb     [bx+si],al
F000:6F01  [+0x06F01]  00 00                    add     [bx+si],al
F000:6F03  [+0x06F03]  00 00                    add     [bx+si],al
F000:6F05  [+0x06F05]  00 00                    add     [bx+si],al
F000:6F07  [+0x06F07]  00 00                    add     [bx+si],al
F000:6F09  [+0x06F09]  18 0C                    sbb     [si],cl
F000:6F0B  [+0x06F0B]  FE 0C                    dec     byte [si]
F000:6F0D  [+0x06F0D]  18 00                    sbb     [bx+si],al
F000:6F0F  [+0x06F0F]  00 00                    add     [bx+si],al
F000:6F11  [+0x06F11]  00 00                    add     [bx+si],al
F000:6F13  [+0x06F13]  00 00                    add     [bx+si],al
F000:6F15  [+0x06F15]  00 00                    add     [bx+si],al
F000:6F17  [+0x06F17]  00 00                    add     [bx+si],al
F000:6F19  [+0x06F19]  30 60 FE                 xor     [bx+si-2],ah
F000:6F1C  [+0x06F1C]  60                       pusha
F000:6F1D  [+0x06F1D]  30 00                    xor     [bx+si],al
F000:6F1F  [+0x06F1F]  00 00                    add     [bx+si],al
F000:6F21  [+0x06F21]  00 00                    add     [bx+si],al
F000:6F23  [+0x06F23]  00 00                    add     [bx+si],al
F000:6F25  [+0x06F25]  00 00                    add     [bx+si],al
F000:6F27  [+0x06F27]  00 00                    add     [bx+si],al
F000:6F29  [+0x06F29]  C0 C0 C0                 rol     al,0C0h
F000:6F2C  [+0x06F2C]  C0 FE 00                 sar     dh,0
F000:6F2F  [+0x06F2F]  00 00                    add     [bx+si],al
F000:6F31  [+0x06F31]  00 00                    add     [bx+si],al
F000:6F33  [+0x06F33]  00 00                    add     [bx+si],al
F000:6F35  [+0x06F35]  00 00                    add     [bx+si],al
F000:6F37  [+0x06F37]  00 00                    add     [bx+si],al
F000:6F39  [+0x06F39]  28 6C FE                 sub     [si-2],ch
F000:6F3C  [+0x06F3C]  6C                       insb
F000:6F3D  [+0x06F3D]  28 00                    sub     [bx+si],al
F000:6F3F  [+0x06F3F]  00 00                    add     [bx+si],al
F000:6F41  [+0x06F41]  00 00                    add     [bx+si],al
F000:6F43  [+0x06F43]  00 00                    add     [bx+si],al
F000:6F45  [+0x06F45]  00 00                    add     [bx+si],al
F000:6F47  [+0x06F47]  00 10                    add     [bx+si],dl
F000:6F49  [+0x06F49]  38 38                    cmp     [bx+si],bh
F000:6F4B  [+0x06F4B]  7C 7C                    jl      short 6FC9h
F000:6F4D  [+0x06F4D]  DB 0xFE  (bad)
F000:6F4F  [+0x06F4F]  00 00                    add     [bx+si],al
F000:6F51  [+0x06F51]  00 00                    add     [bx+si],al
F000:6F53  [+0x06F53]  00 00                    add     [bx+si],al
F000:6F55  [+0x06F55]  00 00                    add     [bx+si],al
F000:6F57  [+0x06F57]  00 FE                    add     dh,bh
F000:6F59  [+0x06F59]  DB 0xFE  (bad)
F000:6F5B  [+0x06F5B]  7C 38                    jl      short 6F95h
F000:6F5D  [+0x06F5D]  38 10                    cmp     [bx+si],dl
F000:6F5F  [+0x06F5F]  00 00                    add     [bx+si],al
F000:6F61  [+0x06F61]  00 00                    add     [bx+si],al
F000:6F63  [+0x06F63]  00 00                    add     [bx+si],al
F000:6F65  [+0x06F65]  00 00                    add     [bx+si],al
F000:6F67  [+0x06F67]  00 00                    add     [bx+si],al
F000:6F69  [+0x06F69]  00 00                    add     [bx+si],al
F000:6F6B  [+0x06F6B]  00 00                    add     [bx+si],al
F000:6F6D  [+0x06F6D]  00 00                    add     [bx+si],al
F000:6F6F  [+0x06F6F]  00 00                    add     [bx+si],al
F000:6F71  [+0x06F71]  00 00                    add     [bx+si],al
F000:6F73  [+0x06F73]  00 00                    add     [bx+si],al
F000:6F75  [+0x06F75]  00 18                    add     [bx+si],bl
F000:6F77  [+0x06F77]  3C 3C                    cmp     al,3Ch
F000:6F79  [+0x06F79]  3C 18                    cmp     al,18h
F000:6F7B  [+0x06F7B]  18 18                    sbb     [bx+si],bl
F000:6F7D  [+0x06F7D]  00 18                    add     [bx+si],bl
F000:6F7F  [+0x06F7F]  18 00                    sbb     [bx+si],al
F000:6F81  [+0x06F81]  00 00                    add     [bx+si],al
F000:6F83  [+0x06F83]  00 00                    add     [bx+si],al
F000:6F85  [+0x06F85]  66 66 66 24 00           and     al,0
F000:6F8A  [+0x06F8A]  00 00                    add     [bx+si],al
F000:6F8C  [+0x06F8C]  00 00                    add     [bx+si],al
F000:6F8E  [+0x06F8E]  00 00                    add     [bx+si],al
F000:6F90  [+0x06F90]  00 00                    add     [bx+si],al
F000:6F92  [+0x06F92]  00 00                    add     [bx+si],al
F000:6F94  [+0x06F94]  00 00                    add     [bx+si],al
F000:6F96  [+0x06F96]  00 6C 6C                 add     [si+6Ch],ch
F000:6F99  [+0x06F99]  DB 0xFE  (bad)
F000:6F9B  [+0x06F9B]  6C                       insb
F000:6F9C  [+0x06F9C]  6C                       insb
F000:6F9D  [+0x06F9D]  DB 0xFE  (bad)
F000:6F9F  [+0x06F9F]  6C                       insb
F000:6FA0  [+0x06FA0]  00 00                    add     [bx+si],al
F000:6FA2  [+0x06FA2]  00 00                    add     [bx+si],al
F000:6FA4  [+0x06FA4]  00 18                    add     [bx+si],bl
F000:6FA6  [+0x06FA6]  18 7C C6                 sbb     [si-3Ah],bh
F000:6FA9  [+0x06FA9]  C2 C0 7C                 ret     7CC0h
F000:6FAC  [+0x06FAC]  06                       push    es
F000:6FAD  [+0x06FAD]  86 C6                    xchg    al,dh
F000:6FAF  [+0x06FAF]  7C 18                    jl      short 6FC9h
F000:6FB1  [+0x06FB1]  18 00                    sbb     [bx+si],al
F000:6FB3  [+0x06FB3]  00 00                    add     [bx+si],al
F000:6FB5  [+0x06FB5]  00 00                    add     [bx+si],al
F000:6FB7  [+0x06FB7]  00 C2                    add     dl,al
F000:6FB9  [+0x06FB9]  DB 0xC6  (bad)
F000:6FBB  [+0x06FBB]  18 30                    sbb     [bx+si],dh
F000:6FBD  [+0x06FBD]  60                       pusha
F000:6FBE  [+0x06FBE]  C6 86 00 00 00           mov     byte [bp],0
F000:6FC3  [+0x06FC3]  00 00                    add     [bx+si],al
F000:6FC5  [+0x06FC5]  00 38                    add     [bx+si],bh
F000:6FC7  [+0x06FC7]  6C                       insb
F000:6FC8  [+0x06FC8]  6C                       insb
F000:6FC9  [+0x06FC9]  38 76 DC                 cmp     [bp-24h],dh
F000:6FCC  [+0x06FCC]  CC                       int3
F000:6FCD  [+0x06FCD]  CC                       int3
F000:6FCE  [+0x06FCE]  CC                       int3
F000:6FCF  [+0x06FCF]  76 00                    jbe     short 6FD1h
F000:6FD1  [+0x06FD1]  00 00                    add     [bx+si],al
F000:6FD3  [+0x06FD3]  00 00                    add     [bx+si],al
F000:6FD5  [+0x06FD5]  30 30                    xor     [bx+si],dh
F000:6FD7  [+0x06FD7]  30 60 00                 xor     [bx+si],ah
F000:6FDA  [+0x06FDA]  00 00                    add     [bx+si],al
F000:6FDC  [+0x06FDC]  00 00                    add     [bx+si],al
F000:6FDE  [+0x06FDE]  00 00                    add     [bx+si],al
F000:6FE0  [+0x06FE0]  00 00                    add     [bx+si],al
F000:6FE2  [+0x06FE2]  00 00                    add     [bx+si],al
F000:6FE4  [+0x06FE4]  00 00                    add     [bx+si],al
F000:6FE6  [+0x06FE6]  0C 18                    or      al,18h
F000:6FE8  [+0x06FE8]  30 30                    xor     [bx+si],dh
F000:6FEA  [+0x06FEA]  30 30                    xor     [bx+si],dh
F000:6FEC  [+0x06FEC]  30 30                    xor     [bx+si],dh
F000:6FEE  [+0x06FEE]  18 0C                    sbb     [si],cl
F000:6FF0  [+0x06FF0]  00 00                    add     [bx+si],al
F000:6FF2  [+0x06FF2]  00 00                    add     [bx+si],al
F000:6FF4  [+0x06FF4]  00 00                    add     [bx+si],al
F000:6FF6  [+0x06FF6]  30 18                    xor     [bx+si],bl
F000:6FF8  [+0x06FF8]  0C 0C                    or      al,0Ch
F000:6FFA  [+0x06FFA]  0C 0C                    or      al,0Ch
F000:6FFC  [+0x06FFC]  0C 0C                    or      al,0Ch
F000:6FFE  [+0x06FFE]  18 30                    sbb     [bx+si],dh
F000:7000  [+0x07000]  00 00                    add     [bx+si],al
F000:7002  [+0x07002]  00 00                    add     [bx+si],al
F000:7004  [+0x07004]  00 00                    add     [bx+si],al
F000:7006  [+0x07006]  00 00                    add     [bx+si],al
F000:7008  [+0x07008]  00 66 3C                 add     [bp+3Ch],ah
F000:700B  [+0x0700B]  DB 0xFF  (bad)
F000:700D  [+0x0700D]  66 00 00                 add     [bx+si],al
F000:7010  [+0x07010]  00 00                    add     [bx+si],al
F000:7012  [+0x07012]  00 00                    add     [bx+si],al
F000:7014  [+0x07014]  00 00                    add     [bx+si],al
F000:7016  [+0x07016]  00 00                    add     [bx+si],al
F000:7018  [+0x07018]  00 18                    add     [bx+si],bl
F000:701A  [+0x0701A]  18 7E 18                 sbb     [bp+18h],bh
F000:701D  [+0x0701D]  18 00                    sbb     [bx+si],al
F000:701F  [+0x0701F]  00 00                    add     [bx+si],al
F000:7021  [+0x07021]  00 00                    add     [bx+si],al
F000:7023  [+0x07023]  00 00                    add     [bx+si],al
F000:7025  [+0x07025]  00 00                    add     [bx+si],al
F000:7027  [+0x07027]  00 00                    add     [bx+si],al
F000:7029  [+0x07029]  00 00                    add     [bx+si],al
F000:702B  [+0x0702B]  00 00                    add     [bx+si],al
F000:702D  [+0x0702D]  18 18                    sbb     [bx+si],bl
F000:702F  [+0x0702F]  18 30                    sbb     [bx+si],dh
F000:7031  [+0x07031]  00 00                    add     [bx+si],al
F000:7033  [+0x07033]  00 00                    add     [bx+si],al
F000:7035  [+0x07035]  00 00                    add     [bx+si],al
F000:7037  [+0x07037]  00 00                    add     [bx+si],al
F000:7039  [+0x07039]  00 00                    add     [bx+si],al
F000:703B  [+0x0703B]  FE 00                    inc     byte [bx+si]
F000:703D  [+0x0703D]  00 00                    add     [bx+si],al
F000:703F  [+0x0703F]  00 00                    add     [bx+si],al
F000:7041  [+0x07041]  00 00                    add     [bx+si],al
F000:7043  [+0x07043]  00 00                    add     [bx+si],al
F000:7045  [+0x07045]  00 00                    add     [bx+si],al
F000:7047  [+0x07047]  00 00                    add     [bx+si],al
F000:7049  [+0x07049]  00 00                    add     [bx+si],al
F000:704B  [+0x0704B]  00 00                    add     [bx+si],al
F000:704D  [+0x0704D]  00 18                    add     [bx+si],bl
F000:704F  [+0x0704F]  18 00                    sbb     [bx+si],al
F000:7051  [+0x07051]  00 00                    add     [bx+si],al
F000:7053  [+0x07053]  00 00                    add     [bx+si],al
F000:7055  [+0x07055]  00 00                    add     [bx+si],al
F000:7057  [+0x07057]  00 02                    add     [bp+si],al
F000:7059  [+0x07059]  06                       push    es
F000:705A  [+0x0705A]  0C 18                    or      al,18h
F000:705C  [+0x0705C]  30 60 C0                 xor     [bx+si-40h],ah
F000:705F  [+0x0705F]  80 00 00                 add     byte [bx+si],0
F000:7062  [+0x07062]  00 00                    add     [bx+si],al
F000:7064  [+0x07064]  00 00                    add     [bx+si],al
F000:7066  [+0x07066]  38 6C C6                 cmp     [si-3Ah],ch
F000:7069  [+0x07069]  DB 0xC6  (bad)
F000:706B  [+0x0706B]  D6                       salc
F000:706C  [+0x0706C]  C6 C6 6C                 mov     dh,6Ch
F000:706F  [+0x0706F]  38 00                    cmp     [bx+si],al
F000:7071  [+0x07071]  00 00                    add     [bx+si],al
F000:7073  [+0x07073]  00 00                    add     [bx+si],al
F000:7075  [+0x07075]  00 18                    add     [bx+si],bl
F000:7077  [+0x07077]  38 78 18                 cmp     [bx+si+18h],bh
F000:707A  [+0x0707A]  18 18                    sbb     [bx+si],bl
F000:707C  [+0x0707C]  18 18                    sbb     [bx+si],bl
F000:707E  [+0x0707E]  18 7E 00                 sbb     [bp],bh
F000:7081  [+0x07081]  00 00                    add     [bx+si],al
F000:7083  [+0x07083]  00 00                    add     [bx+si],al
F000:7085  [+0x07085]  00 7C C6                 add     [si-3Ah],bh
F000:7088  [+0x07088]  06                       push    es
F000:7089  [+0x07089]  0C 18                    or      al,18h
F000:708B  [+0x0708B]  30 60 C0                 xor     [bx+si-40h],ah
F000:708E  [+0x0708E]  DB 0xC6  (bad)
F000:7090  [+0x07090]  00 00                    add     [bx+si],al
F000:7092  [+0x07092]  00 00                    add     [bx+si],al
F000:7094  [+0x07094]  00 00                    add     [bx+si],al
F000:7096  [+0x07096]  7C C6                    jl      short 705Eh
F000:7098  [+0x07098]  06                       push    es
F000:7099  [+0x07099]  06                       push    es
F000:709A  [+0x0709A]  3C 06                    cmp     al,6
F000:709C  [+0x0709C]  06                       push    es
F000:709D  [+0x0709D]  06                       push    es
F000:709E  [+0x0709E]  DB 0xC6  (bad)
F000:70A0  [+0x070A0]  00 00                    add     [bx+si],al
F000:70A2  [+0x070A2]  00 00                    add     [bx+si],al
F000:70A4  [+0x070A4]  00 00                    add     [bx+si],al
F000:70A6  [+0x070A6]  0C 1C                    or      al,1Ch
F000:70A8  [+0x070A8]  3C 6C                    cmp     al,6Ch
F000:70AA  [+0x070AA]  CC                       int3
F000:70AB  [+0x070AB]  FE 0C                    dec     byte [si]
F000:70AD  [+0x070AD]  0C 0C                    or      al,0Ch
F000:70AF  [+0x070AF]  1E                       push    ds
F000:70B0  [+0x070B0]  00 00                    add     [bx+si],al
F000:70B2  [+0x070B2]  00 00                    add     [bx+si],al
F000:70B4  [+0x070B4]  00 00                    add     [bx+si],al
F000:70B6  [+0x070B6]  FE C0                    inc     al
F000:70B8  [+0x070B8]  C0 C0 FC                 rol     al,0FCh
F000:70BB  [+0x070BB]  0E                       push    cs
F000:70BC  [+0x070BC]  06                       push    es
F000:70BD  [+0x070BD]  06                       push    es
F000:70BE  [+0x070BE]  DB 0xC6  (bad)
F000:70C0  [+0x070C0]  00 00                    add     [bx+si],al
F000:70C2  [+0x070C2]  00 00                    add     [bx+si],al
F000:70C4  [+0x070C4]  00 00                    add     [bx+si],al
F000:70C6  [+0x070C6]  38 60 C0                 cmp     [bx+si-40h],ah
F000:70C9  [+0x070C9]  C0 FC C6                 sar     ah,0C6h
F000:70CC  [+0x070CC]  C6 C6 C6                 mov     dh,0C6h
F000:70CF  [+0x070CF]  7C 00                    jl      short 70D1h
F000:70D1  [+0x070D1]  00 00                    add     [bx+si],al
F000:70D3  [+0x070D3]  00 00                    add     [bx+si],al
F000:70D5  [+0x070D5]  00 FE                    add     dh,bh
F000:70D7  [+0x070D7]  C6 06 06 0C 18           mov     byte [0C06h],18h
F000:70DC  [+0x070DC]  30 30                    xor     [bx+si],dh
F000:70DE  [+0x070DE]  30 30                    xor     [bx+si],dh
F000:70E0  [+0x070E0]  00 00                    add     [bx+si],al
F000:70E2  [+0x070E2]  00 00                    add     [bx+si],al
F000:70E4  [+0x070E4]  00 00                    add     [bx+si],al
F000:70E6  [+0x070E6]  7C C6                    jl      short 70AEh
F000:70E8  [+0x070E8]  C6 C6 7C                 mov     dh,7Ch
F000:70EB  [+0x070EB]  C6 C6 C6                 mov     dh,0C6h
F000:70EE  [+0x070EE]  DB 0xC6  (bad)
F000:70F0  [+0x070F0]  00 00                    add     [bx+si],al
F000:70F2  [+0x070F2]  00 00                    add     [bx+si],al
F000:70F4  [+0x070F4]  00 00                    add     [bx+si],al
F000:70F6  [+0x070F6]  7C C6                    jl      short 70BEh
F000:70F8  [+0x070F8]  C6 C6 7E                 mov     dh,7Eh
F000:70FB  [+0x070FB]  06                       push    es
F000:70FC  [+0x070FC]  06                       push    es
F000:70FD  [+0x070FD]  06                       push    es
F000:70FE  [+0x070FE]  0C 78                    or      al,78h
F000:7100  [+0x07100]  00 00                    add     [bx+si],al
F000:7102  [+0x07102]  00 00                    add     [bx+si],al
F000:7104  [+0x07104]  00 00                    add     [bx+si],al
F000:7106  [+0x07106]  00 00                    add     [bx+si],al
F000:7108  [+0x07108]  18 18                    sbb     [bx+si],bl
F000:710A  [+0x0710A]  00 00                    add     [bx+si],al
F000:710C  [+0x0710C]  00 18                    add     [bx+si],bl
F000:710E  [+0x0710E]  18 00                    sbb     [bx+si],al
F000:7110  [+0x07110]  00 00                    add     [bx+si],al
F000:7112  [+0x07112]  00 00                    add     [bx+si],al
F000:7114  [+0x07114]  00 00                    add     [bx+si],al
F000:7116  [+0x07116]  00 00                    add     [bx+si],al
F000:7118  [+0x07118]  18 18                    sbb     [bx+si],bl
F000:711A  [+0x0711A]  00 00                    add     [bx+si],al
F000:711C  [+0x0711C]  00 18                    add     [bx+si],bl
F000:711E  [+0x0711E]  18 30                    sbb     [bx+si],dh
F000:7120  [+0x07120]  00 00                    add     [bx+si],al
F000:7122  [+0x07122]  00 00                    add     [bx+si],al
F000:7124  [+0x07124]  00 00                    add     [bx+si],al
F000:7126  [+0x07126]  00 06 0C 18              add     [180Ch],al
F000:712A  [+0x0712A]  30 60 30                 xor     [bx+si+30h],ah
F000:712D  [+0x0712D]  18 0C                    sbb     [si],cl
F000:712F  [+0x0712F]  06                       push    es
F000:7130  [+0x07130]  00 00                    add     [bx+si],al
F000:7132  [+0x07132]  00 00                    add     [bx+si],al
F000:7134  [+0x07134]  00 00                    add     [bx+si],al
F000:7136  [+0x07136]  00 00                    add     [bx+si],al
F000:7138  [+0x07138]  00 FE                    add     dh,bh
F000:713A  [+0x0713A]  00 00                    add     [bx+si],al
F000:713C  [+0x0713C]  FE 00                    inc     byte [bx+si]
F000:713E  [+0x0713E]  00 00                    add     [bx+si],al
F000:7140  [+0x07140]  00 00                    add     [bx+si],al
F000:7142  [+0x07142]  00 00                    add     [bx+si],al
F000:7144  [+0x07144]  00 00                    add     [bx+si],al
F000:7146  [+0x07146]  00 60 30                 add     [bx+si+30h],ah
F000:7149  [+0x07149]  18 0C                    sbb     [si],cl
F000:714B  [+0x0714B]  06                       push    es
F000:714C  [+0x0714C]  0C 18                    or      al,18h
F000:714E  [+0x0714E]  30 60 00                 xor     [bx+si],ah
F000:7151  [+0x07151]  00 00                    add     [bx+si],al
F000:7153  [+0x07153]  00 00                    add     [bx+si],al
F000:7155  [+0x07155]  00 7C C6                 add     [si-3Ah],bh
F000:7158  [+0x07158]  DB 0xC6  (bad)
F000:715A  [+0x0715A]  18 18                    sbb     [bx+si],bl
F000:715C  [+0x0715C]  18 00                    sbb     [bx+si],al
F000:715E  [+0x0715E]  18 18                    sbb     [bx+si],bl
F000:7160  [+0x07160]  00 00                    add     [bx+si],al
F000:7162  [+0x07162]  00 00                    add     [bx+si],al
F000:7164  [+0x07164]  00 00                    add     [bx+si],al
F000:7166  [+0x07166]  00 7C C6                 add     [si-3Ah],bh
F000:7169  [+0x07169]  DB 0xC6  (bad)
F000:716B  [+0x0716B]  DB 0xDE  (bad)
F000:716E  [+0x0716E]  C0 7C 00 00              sar     byte [si],0
F000:7172  [+0x07172]  00 00                    add     [bx+si],al
F000:7174  [+0x07174]  00 00                    add     [bx+si],al
F000:7176  [+0x07176]  10 38                    adc     [bx+si],bh
F000:7178  [+0x07178]  6C                       insb
F000:7179  [+0x07179]  C6 C6 FE                 mov     dh,0FEh
F000:717C  [+0x0717C]  C6 C6 C6                 mov     dh,0C6h
F000:717F  [+0x0717F]  C6 00 00                 mov     byte [bx+si],0
F000:7182  [+0x07182]  00 00                    add     [bx+si],al
F000:7184  [+0x07184]  00 00                    add     [bx+si],al
F000:7186  [+0x07186]  FC                       cld
F000:7187  [+0x07187]  66 66 66 7C 66           o32 jl  short 000071F2h
F000:718C  [+0x0718C]  66 66 66 FC              cld
F000:7190  [+0x07190]  00 00                    add     [bx+si],al
F000:7192  [+0x07192]  00 00                    add     [bx+si],al
F000:7194  [+0x07194]  00 00                    add     [bx+si],al
F000:7196  [+0x07196]  3C 66                    cmp     al,66h
F000:7198  [+0x07198]  C2 C0 C0                 ret     0C0C0h
F000:719B  [+0x0719B]  C0 C0 C2                 rol     al,0C2h
F000:719E  [+0x0719E]  66 3C 00                 cmp     al,0
F000:71A1  [+0x071A1]  00 00                    add     [bx+si],al
F000:71A3  [+0x071A3]  00 00                    add     [bx+si],al
F000:71A5  [+0x071A5]  00 F8                    add     al,bh
F000:71A7  [+0x071A7]  6C                       insb
F000:71A8  [+0x071A8]  66 66 66 66 66 66 6C     insb
F000:71AF  [+0x071AF]  F8                       clc
F000:71B0  [+0x071B0]  00 00                    add     [bx+si],al
F000:71B2  [+0x071B2]  00 00                    add     [bx+si],al
F000:71B4  [+0x071B4]  00 00                    add     [bx+si],al
F000:71B6  [+0x071B6]  DB 0xFE  (bad)
F000:71B8  [+0x071B8]  62 68 78                 bound   bp,[bx+si+78h]
F000:71BB  [+0x071BB]  68 60 62                 push    6260h
F000:71BE  [+0x071BE]  66 FE 00                 inc     byte [bx+si]
F000:71C1  [+0x071C1]  00 00                    add     [bx+si],al
F000:71C3  [+0x071C3]  00 00                    add     [bx+si],al
F000:71C5  [+0x071C5]  00 FE                    add     dh,bh
F000:71C7  [+0x071C7]  66 62 68 78              bound   ebp,[bx+si+78h]
F000:71CB  [+0x071CB]  68 60 60                 push    6060h
F000:71CE  [+0x071CE]  60                       pusha
F000:71CF  [+0x071CF]  F0 00 00                 lock add [bx+si],al
F000:71D2  [+0x071D2]  00 00                    add     [bx+si],al
F000:71D4  [+0x071D4]  00 00                    add     [bx+si],al
F000:71D6  [+0x071D6]  3C 66                    cmp     al,66h
F000:71D8  [+0x071D8]  C2 C0 C0                 ret     0C0C0h
F000:71DB  [+0x071DB]  DE C6                    faddp   st6
F000:71DD  [+0x071DD]  DB 0xC6  (bad)
F000:71DF  [+0x071DF]  3A 00                    cmp     al,[bx+si]
F000:71E1  [+0x071E1]  00 00                    add     [bx+si],al
F000:71E3  [+0x071E3]  00 00                    add     [bx+si],al
F000:71E5  [+0x071E5]  00 C6                    add     dh,al
F000:71E7  [+0x071E7]  C6 C6 C6                 mov     dh,0C6h
F000:71EA  [+0x071EA]  FE C6                    inc     dh
F000:71EC  [+0x071EC]  C6 C6 C6                 mov     dh,0C6h
F000:71EF  [+0x071EF]  C6 00 00                 mov     byte [bx+si],0
F000:71F2  [+0x071F2]  00 00                    add     [bx+si],al
F000:71F4  [+0x071F4]  00 00                    add     [bx+si],al
F000:71F6  [+0x071F6]  3C 18                    cmp     al,18h
F000:71F8  [+0x071F8]  18 18                    sbb     [bx+si],bl
F000:71FA  [+0x071FA]  18 18                    sbb     [bx+si],bl
F000:71FC  [+0x071FC]  18 18                    sbb     [bx+si],bl
F000:71FE  [+0x071FE]  18 3C                    sbb     [si],bh
F000:7200  [+0x07200]  00 00                    add     [bx+si],al
F000:7202  [+0x07202]  00 00                    add     [bx+si],al
F000:7204  [+0x07204]  00 00                    add     [bx+si],al
F000:7206  [+0x07206]  1E                       push    ds
F000:7207  [+0x07207]  0C 0C                    or      al,0Ch
F000:7209  [+0x07209]  0C 0C                    or      al,0Ch
F000:720B  [+0x0720B]  0C CC                    or      al,0CCh
F000:720D  [+0x0720D]  CC                       int3
F000:720E  [+0x0720E]  CC                       int3
F000:720F  [+0x0720F]  78 00                    js      short 7211h
F000:7211  [+0x07211]  00 00                    add     [bx+si],al
F000:7213  [+0x07213]  00 00                    add     [bx+si],al
F000:7215  [+0x07215]  00 E6                    add     dh,ah
F000:7217  [+0x07217]  66 6C                    insb
F000:7219  [+0x07219]  6C                       insb
F000:721A  [+0x0721A]  78 78                    js      short 7294h
F000:721C  [+0x0721C]  6C                       insb
F000:721D  [+0x0721D]  66 66 E6 00              out     0,al
F000:7221  [+0x07221]  00 00                    add     [bx+si],al
F000:7223  [+0x07223]  00 00                    add     [bx+si],al
F000:7225  [+0x07225]  00 F0                    add     al,dh
F000:7227  [+0x07227]  60                       pusha
F000:7228  [+0x07228]  60                       pusha
F000:7229  [+0x07229]  60                       pusha
F000:722A  [+0x0722A]  60                       pusha
F000:722B  [+0x0722B]  60                       pusha
F000:722C  [+0x0722C]  60                       pusha
F000:722D  [+0x0722D]  62 66 FE                 bound   sp,[bp-2]
F000:7230  [+0x07230]  00 00                    add     [bx+si],al
F000:7232  [+0x07232]  00 00                    add     [bx+si],al
F000:7234  [+0x07234]  00 00                    add     [bx+si],al
F000:7236  [+0x07236]  DB 0xC6  (bad)
F000:7238  [+0x07238]  DB 0xFE  (bad)
F000:723A  [+0x0723A]  D6                       salc
F000:723B  [+0x0723B]  C6 C6 C6                 mov     dh,0C6h
F000:723E  [+0x0723E]  C6 C6 00                 mov     dh,0
F000:7241  [+0x07241]  00 00                    add     [bx+si],al
F000:7243  [+0x07243]  00 00                    add     [bx+si],al
F000:7245  [+0x07245]  00 C6                    add     dh,al
F000:7247  [+0x07247]  E6 F6                    out     0F6h,al
F000:7249  [+0x07249]  DB 0xFE  (bad)
F000:724B  [+0x0724B]  CE                       into
F000:724C  [+0x0724C]  C6 C6 C6                 mov     dh,0C6h
F000:724F  [+0x0724F]  C6 00 00                 mov     byte [bx+si],0
F000:7252  [+0x07252]  00 00                    add     [bx+si],al
F000:7254  [+0x07254]  00 00                    add     [bx+si],al
F000:7256  [+0x07256]  7C C6                    jl      short 721Eh
F000:7258  [+0x07258]  C6 C6 C6                 mov     dh,0C6h
F000:725B  [+0x0725B]  C6 C6 C6                 mov     dh,0C6h
F000:725E  [+0x0725E]  DB 0xC6  (bad)
F000:7260  [+0x07260]  00 00                    add     [bx+si],al
F000:7262  [+0x07262]  00 00                    add     [bx+si],al
F000:7264  [+0x07264]  00 00                    add     [bx+si],al
F000:7266  [+0x07266]  FC                       cld
F000:7267  [+0x07267]  66 66 66 7C 60           o32 jl  short 000072CCh
F000:726C  [+0x0726C]  60                       pusha
F000:726D  [+0x0726D]  60                       pusha
F000:726E  [+0x0726E]  60                       pusha
F000:726F  [+0x0726F]  F0 00 00                 lock add [bx+si],al
F000:7272  [+0x07272]  00 00                    add     [bx+si],al
F000:7274  [+0x07274]  00 00                    add     [bx+si],al
F000:7276  [+0x07276]  7C C6                    jl      short 723Eh
F000:7278  [+0x07278]  C6 C6 C6                 mov     dh,0C6h
F000:727B  [+0x0727B]  C6 C6 D6                 mov     dh,0D6h
F000:727E  [+0x0727E]  DE 7C 0C                 fidivr  word [si+0Ch]
F000:7281  [+0x07281]  0E                       push    cs
F000:7282  [+0x07282]  00 00                    add     [bx+si],al
F000:7284  [+0x07284]  00 00                    add     [bx+si],al
F000:7286  [+0x07286]  FC                       cld
F000:7287  [+0x07287]  66 66 66 7C 6C           o32 jl  short 000072F8h
F000:728C  [+0x0728C]  66 66 66 E6 00           out     0,al
F000:7291  [+0x07291]  00 00                    add     [bx+si],al
F000:7293  [+0x07293]  00 00                    add     [bx+si],al
F000:7295  [+0x07295]  00 7C C6                 add     [si-3Ah],bh
F000:7298  [+0x07298]  DB 0xC6  (bad)
F000:729A  [+0x0729A]  38 0C                    cmp     [si],cl
F000:729C  [+0x0729C]  06                       push    es
F000:729D  [+0x0729D]  C6 C6 7C                 mov     dh,7Ch
F000:72A0  [+0x072A0]  00 00                    add     [bx+si],al
F000:72A2  [+0x072A2]  00 00                    add     [bx+si],al
F000:72A4  [+0x072A4]  00 00                    add     [bx+si],al
F000:72A6  [+0x072A6]  7E 7E                    jle     short 7326h
F000:72A8  [+0x072A8]  5A                       pop     dx
F000:72A9  [+0x072A9]  18 18                    sbb     [bx+si],bl
F000:72AB  [+0x072AB]  18 18                    sbb     [bx+si],bl
F000:72AD  [+0x072AD]  18 18                    sbb     [bx+si],bl
F000:72AF  [+0x072AF]  3C 00                    cmp     al,0
F000:72B1  [+0x072B1]  00 00                    add     [bx+si],al
F000:72B3  [+0x072B3]  00 00                    add     [bx+si],al
F000:72B5  [+0x072B5]  00 C6                    add     dh,al
F000:72B7  [+0x072B7]  C6 C6 C6                 mov     dh,0C6h
F000:72BA  [+0x072BA]  C6 C6 C6                 mov     dh,0C6h
F000:72BD  [+0x072BD]  C6 C6 7C                 mov     dh,7Ch
F000:72C0  [+0x072C0]  00 00                    add     [bx+si],al
F000:72C2  [+0x072C2]  00 00                    add     [bx+si],al
F000:72C4  [+0x072C4]  00 00                    add     [bx+si],al
F000:72C6  [+0x072C6]  C6 C6 C6                 mov     dh,0C6h
F000:72C9  [+0x072C9]  C6 C6 C6                 mov     dh,0C6h
F000:72CC  [+0x072CC]  DB 0xC6  (bad)
F000:72CE  [+0x072CE]  38 10                    cmp     [bx+si],dl
F000:72D0  [+0x072D0]  00 00                    add     [bx+si],al
F000:72D2  [+0x072D2]  00 00                    add     [bx+si],al
F000:72D4  [+0x072D4]  00 00                    add     [bx+si],al
F000:72D6  [+0x072D6]  C6 C6 C6                 mov     dh,0C6h
F000:72D9  [+0x072D9]  C6 C6 D6                 mov     dh,0D6h
F000:72DC  [+0x072DC]  D6                       salc
F000:72DD  [+0x072DD]  DB 0xFE  (bad)
F000:72DF  [+0x072DF]  6C                       insb
F000:72E0  [+0x072E0]  00 00                    add     [bx+si],al
F000:72E2  [+0x072E2]  00 00                    add     [bx+si],al
F000:72E4  [+0x072E4]  00 00                    add     [bx+si],al
F000:72E6  [+0x072E6]  C6 C6 6C                 mov     dh,6Ch
F000:72E9  [+0x072E9]  6C                       insb
F000:72EA  [+0x072EA]  38 38                    cmp     [bx+si],bh
F000:72EC  [+0x072EC]  6C                       insb
F000:72ED  [+0x072ED]  6C                       insb
F000:72EE  [+0x072EE]  C6 C6 00                 mov     dh,0
F000:72F1  [+0x072F1]  00 00                    add     [bx+si],al
F000:72F3  [+0x072F3]  00 00                    add     [bx+si],al
F000:72F5  [+0x072F5]  00 66 66                 add     [bp+66h],ah
F000:72F8  [+0x072F8]  66 66 3C 18              cmp     al,18h
F000:72FC  [+0x072FC]  18 18                    sbb     [bx+si],bl
F000:72FE  [+0x072FE]  18 3C                    sbb     [si],bh
F000:7300  [+0x07300]  00 00                    add     [bx+si],al
F000:7302  [+0x07302]  00 00                    add     [bx+si],al
F000:7304  [+0x07304]  00 00                    add     [bx+si],al
F000:7306  [+0x07306]  FE C6                    inc     dh
F000:7308  [+0x07308]  86 0C                    xchg    cl,[si]
F000:730A  [+0x0730A]  18 30                    sbb     [bx+si],dh
F000:730C  [+0x0730C]  60                       pusha
F000:730D  [+0x0730D]  C2 C6 FE                 ret     0FEC6h
F000:7310  [+0x07310]  00 00                    add     [bx+si],al
F000:7312  [+0x07312]  00 00                    add     [bx+si],al
F000:7314  [+0x07314]  00 00                    add     [bx+si],al
F000:7316  [+0x07316]  3C 30                    cmp     al,30h
F000:7318  [+0x07318]  30 30                    xor     [bx+si],dh
F000:731A  [+0x0731A]  30 30                    xor     [bx+si],dh
F000:731C  [+0x0731C]  30 30                    xor     [bx+si],dh
F000:731E  [+0x0731E]  30 3C                    xor     [si],bh
F000:7320  [+0x07320]  00 00                    add     [bx+si],al
F000:7322  [+0x07322]  00 00                    add     [bx+si],al
F000:7324  [+0x07324]  00 00                    add     [bx+si],al
F000:7326  [+0x07326]  00 80 C0 E0              add     [bx+si-1F40h],al
F000:732A  [+0x0732A]  70 38                    jo      short 7364h
F000:732C  [+0x0732C]  1C 0E                    sbb     al,0Eh
F000:732E  [+0x0732E]  06                       push    es
F000:732F  [+0x0732F]  02 00                    add     al,[bx+si]
F000:7331  [+0x07331]  00 00                    add     [bx+si],al
F000:7333  [+0x07333]  00 00                    add     [bx+si],al
F000:7335  [+0x07335]  00 3C                    add     [si],bh
F000:7337  [+0x07337]  0C 0C                    or      al,0Ch
F000:7339  [+0x07339]  0C 0C                    or      al,0Ch
F000:733B  [+0x0733B]  0C 0C                    or      al,0Ch
F000:733D  [+0x0733D]  0C 0C                    or      al,0Ch
F000:733F  [+0x0733F]  3C 00                    cmp     al,0
F000:7341  [+0x07341]  00 00                    add     [bx+si],al
F000:7343  [+0x07343]  00 10                    add     [bx+si],dl
F000:7345  [+0x07345]  38 6C C6                 cmp     [si-3Ah],ch
F000:7348  [+0x07348]  00 00                    add     [bx+si],al
F000:734A  [+0x0734A]  00 00                    add     [bx+si],al
F000:734C  [+0x0734C]  00 00                    add     [bx+si],al
F000:734E  [+0x0734E]  00 00                    add     [bx+si],al
F000:7350  [+0x07350]  00 00                    add     [bx+si],al
F000:7352  [+0x07352]  00 00                    add     [bx+si],al
F000:7354  [+0x07354]  00 00                    add     [bx+si],al
F000:7356  [+0x07356]  00 00                    add     [bx+si],al
F000:7358  [+0x07358]  00 00                    add     [bx+si],al
F000:735A  [+0x0735A]  00 00                    add     [bx+si],al
F000:735C  [+0x0735C]  00 00                    add     [bx+si],al
F000:735E  [+0x0735E]  00 00                    add     [bx+si],al
F000:7360  [+0x07360]  00 FF                    add     bh,bh
F000:7362  [+0x07362]  00 00                    add     [bx+si],al
F000:7364  [+0x07364]  30 30                    xor     [bx+si],dh
F000:7366  [+0x07366]  18 00                    sbb     [bx+si],al
F000:7368  [+0x07368]  00 00                    add     [bx+si],al
F000:736A  [+0x0736A]  00 00                    add     [bx+si],al
F000:736C  [+0x0736C]  00 00                    add     [bx+si],al
F000:736E  [+0x0736E]  00 00                    add     [bx+si],al
F000:7370  [+0x07370]  00 00                    add     [bx+si],al
F000:7372  [+0x07372]  00 00                    add     [bx+si],al
F000:7374  [+0x07374]  00 00                    add     [bx+si],al
F000:7376  [+0x07376]  00 00                    add     [bx+si],al
F000:7378  [+0x07378]  00 78 0C                 add     [bx+si+0Ch],bh
F000:737B  [+0x0737B]  7C CC                    jl      short 7349h
F000:737D  [+0x0737D]  CC                       int3
F000:737E  [+0x0737E]  CC                       int3
F000:737F  [+0x0737F]  76 00                    jbe     short 7381h
F000:7381  [+0x07381]  00 00                    add     [bx+si],al
F000:7383  [+0x07383]  00 00                    add     [bx+si],al
F000:7385  [+0x07385]  00 E0                    add     al,ah
F000:7387  [+0x07387]  60                       pusha
F000:7388  [+0x07388]  60                       pusha
F000:7389  [+0x07389]  78 6C                    js      short 73F7h
F000:738B  [+0x0738B]  66 66 66 66 DC 00        fadd    qword [bx+si]
F000:7391  [+0x07391]  00 00                    add     [bx+si],al
F000:7393  [+0x07393]  00 00                    add     [bx+si],al
F000:7395  [+0x07395]  00 00                    add     [bx+si],al
F000:7397  [+0x07397]  00 00                    add     [bx+si],al
F000:7399  [+0x07399]  7C C6                    jl      short 7361h
F000:739B  [+0x0739B]  C0 C0 C0                 rol     al,0C0h
F000:739E  [+0x0739E]  DB 0xC6  (bad)
F000:73A0  [+0x073A0]  00 00                    add     [bx+si],al
F000:73A2  [+0x073A2]  00 00                    add     [bx+si],al
F000:73A4  [+0x073A4]  00 00                    add     [bx+si],al
F000:73A6  [+0x073A6]  1C 0C                    sbb     al,0Ch
F000:73A8  [+0x073A8]  0C 3C                    or      al,3Ch
F000:73AA  [+0x073AA]  6C                       insb
F000:73AB  [+0x073AB]  CC                       int3
F000:73AC  [+0x073AC]  CC                       int3
F000:73AD  [+0x073AD]  CC                       int3
F000:73AE  [+0x073AE]  CC                       int3
F000:73AF  [+0x073AF]  76 00                    jbe     short 73B1h
F000:73B1  [+0x073B1]  00 00                    add     [bx+si],al
F000:73B3  [+0x073B3]  00 00                    add     [bx+si],al
F000:73B5  [+0x073B5]  00 00                    add     [bx+si],al
F000:73B7  [+0x073B7]  00 00                    add     [bx+si],al
F000:73B9  [+0x073B9]  7C C6                    jl      short 7381h
F000:73BB  [+0x073BB]  FE C0                    inc     al
F000:73BD  [+0x073BD]  C0 C6 7C                 rol     dh,7Ch
F000:73C0  [+0x073C0]  00 00                    add     [bx+si],al
F000:73C2  [+0x073C2]  00 00                    add     [bx+si],al
F000:73C4  [+0x073C4]  00 00                    add     [bx+si],al
F000:73C6  [+0x073C6]  38 6C 64                 cmp     [si+64h],ch
F000:73C9  [+0x073C9]  60                       pusha
F000:73CA  [+0x073CA]  DB 0xF0  (bad)
F000:73CC  [+0x073CC]  60                       pusha
F000:73CD  [+0x073CD]  60                       pusha
F000:73CE  [+0x073CE]  60                       pusha
F000:73CF  [+0x073CF]  F0 00 00                 lock add [bx+si],al
F000:73D2  [+0x073D2]  00 00                    add     [bx+si],al
F000:73D4  [+0x073D4]  00 00                    add     [bx+si],al
F000:73D6  [+0x073D6]  00 00                    add     [bx+si],al
F000:73D8  [+0x073D8]  00 76 CC                 add     [bp-34h],dh
F000:73DB  [+0x073DB]  CC                       int3
F000:73DC  [+0x073DC]  CC                       int3
F000:73DD  [+0x073DD]  CC                       int3
F000:73DE  [+0x073DE]  CC                       int3
F000:73DF  [+0x073DF]  7C 0C                    jl      short 73EDh
F000:73E1  [+0x073E1]  CC                       int3
F000:73E2  [+0x073E2]  78 00                    js      short 73E4h
F000:73E4  [+0x073E4]  00 00                    add     [bx+si],al
F000:73E6  [+0x073E6]  E0 60                    loopne  7448h
F000:73E8  [+0x073E8]  60                       pusha
F000:73E9  [+0x073E9]  6C                       insb
F000:73EA  [+0x073EA]  76 66                    jbe     short 7452h
F000:73EC  [+0x073EC]  66 66 66 E6 00           out     0,al
F000:73F1  [+0x073F1]  00 00                    add     [bx+si],al
F000:73F3  [+0x073F3]  00 00                    add     [bx+si],al
F000:73F5  [+0x073F5]  00 18                    add     [bx+si],bl
F000:73F7  [+0x073F7]  18 00                    sbb     [bx+si],al
F000:73F9  [+0x073F9]  38 18                    cmp     [bx+si],bl
F000:73FB  [+0x073FB]  18 18                    sbb     [bx+si],bl
F000:73FD  [+0x073FD]  18 18                    sbb     [bx+si],bl
F000:73FF  [+0x073FF]  3C 00                    cmp     al,0
F000:7401  [+0x07401]  00 00                    add     [bx+si],al
F000:7403  [+0x07403]  00 00                    add     [bx+si],al
F000:7405  [+0x07405]  00 06 06 00              add     [6],al
F000:7409  [+0x07409]  0E                       push    cs
F000:740A  [+0x0740A]  06                       push    es
F000:740B  [+0x0740B]  06                       push    es
F000:740C  [+0x0740C]  06                       push    es
F000:740D  [+0x0740D]  06                       push    es
F000:740E  [+0x0740E]  06                       push    es
F000:740F  [+0x0740F]  06                       push    es
F000:7410  [+0x07410]  66 66 3C 00              cmp     al,0
F000:7414  [+0x07414]  00 00                    add     [bx+si],al
F000:7416  [+0x07416]  E0 60                    loopne  7478h
F000:7418  [+0x07418]  60                       pusha
F000:7419  [+0x07419]  66 6C                    insb
F000:741B  [+0x0741B]  78 78                    js      short 7495h
F000:741D  [+0x0741D]  6C                       insb
F000:741E  [+0x0741E]  66 E6 00                 out     0,al
F000:7421  [+0x07421]  00 00                    add     [bx+si],al
F000:7423  [+0x07423]  00 00                    add     [bx+si],al
F000:7425  [+0x07425]  00 38                    add     [bx+si],bh
F000:7427  [+0x07427]  18 18                    sbb     [bx+si],bl
F000:7429  [+0x07429]  18 18                    sbb     [bx+si],bl
F000:742B  [+0x0742B]  18 18                    sbb     [bx+si],bl
F000:742D  [+0x0742D]  18 18                    sbb     [bx+si],bl
F000:742F  [+0x0742F]  3C 00                    cmp     al,0
F000:7431  [+0x07431]  00 00                    add     [bx+si],al
F000:7433  [+0x07433]  00 00                    add     [bx+si],al
F000:7435  [+0x07435]  00 00                    add     [bx+si],al
F000:7437  [+0x07437]  00 00                    add     [bx+si],al
F000:7439  [+0x07439]  EC                       in      al,dx
F000:743A  [+0x0743A]  DB 0xFE  (bad)
F000:743C  [+0x0743C]  D6                       salc
F000:743D  [+0x0743D]  D6                       salc
F000:743E  [+0x0743E]  D6                       salc
F000:743F  [+0x0743F]  D6                       salc
F000:7440  [+0x07440]  00 00                    add     [bx+si],al
F000:7442  [+0x07442]  00 00                    add     [bx+si],al
F000:7444  [+0x07444]  00 00                    add     [bx+si],al
F000:7446  [+0x07446]  00 00                    add     [bx+si],al
F000:7448  [+0x07448]  00 DC                    add     ah,bl
F000:744A  [+0x0744A]  66 66 66 66 66 66 00 00  add     [bx+si],al
F000:7452  [+0x07452]  00 00                    add     [bx+si],al
F000:7454  [+0x07454]  00 00                    add     [bx+si],al
F000:7456  [+0x07456]  00 00                    add     [bx+si],al
F000:7458  [+0x07458]  00 7C C6                 add     [si-3Ah],bh
F000:745B  [+0x0745B]  C6 C6 C6                 mov     dh,0C6h
F000:745E  [+0x0745E]  DB 0xC6  (bad)
F000:7460  [+0x07460]  00 00                    add     [bx+si],al
F000:7462  [+0x07462]  00 00                    add     [bx+si],al
F000:7464  [+0x07464]  00 00                    add     [bx+si],al
F000:7466  [+0x07466]  00 00                    add     [bx+si],al
F000:7468  [+0x07468]  00 DC                    add     ah,bl
F000:746A  [+0x0746A]  66 66 66 66 66 7C 60     o32 jl  short 000074D1h
F000:7471  [+0x07471]  60                       pusha
F000:7472  [+0x07472]  F0 00 00                 lock add [bx+si],al
F000:7475  [+0x07475]  00 00                    add     [bx+si],al
F000:7477  [+0x07477]  00 00                    add     [bx+si],al
F000:7479  [+0x07479]  76 CC                    jbe     short 7447h
F000:747B  [+0x0747B]  CC                       int3
F000:747C  [+0x0747C]  CC                       int3
F000:747D  [+0x0747D]  CC                       int3
F000:747E  [+0x0747E]  CC                       int3
F000:747F  [+0x0747F]  7C 0C                    jl      short 748Dh
F000:7481  [+0x07481]  0C 1E                    or      al,1Eh
F000:7483  [+0x07483]  00 00                    add     [bx+si],al
F000:7485  [+0x07485]  00 00                    add     [bx+si],al
F000:7487  [+0x07487]  00 00                    add     [bx+si],al
F000:7489  [+0x07489]  DC 76 62                 fdiv    qword [bp+62h]
F000:748C  [+0x0748C]  60                       pusha
F000:748D  [+0x0748D]  60                       pusha
F000:748E  [+0x0748E]  60                       pusha
F000:748F  [+0x0748F]  F0 00 00                 lock add [bx+si],al
F000:7492  [+0x07492]  00 00                    add     [bx+si],al
F000:7494  [+0x07494]  00 00                    add     [bx+si],al
F000:7496  [+0x07496]  00 00                    add     [bx+si],al
F000:7498  [+0x07498]  00 7C C6                 add     [si-3Ah],bh
F000:749B  [+0x0749B]  60                       pusha
F000:749C  [+0x0749C]  38 0C                    cmp     [si],cl
F000:749E  [+0x0749E]  DB 0xC6  (bad)
F000:74A0  [+0x074A0]  00 00                    add     [bx+si],al
F000:74A2  [+0x074A2]  00 00                    add     [bx+si],al
F000:74A4  [+0x074A4]  00 00                    add     [bx+si],al
F000:74A6  [+0x074A6]  10 30                    adc     [bx+si],dh
F000:74A8  [+0x074A8]  30 FC                    xor     ah,bh
F000:74AA  [+0x074AA]  30 30                    xor     [bx+si],dh
F000:74AC  [+0x074AC]  30 30                    xor     [bx+si],dh
F000:74AE  [+0x074AE]  36 1C 00                 sbb     al,0
F000:74B1  [+0x074B1]  00 00                    add     [bx+si],al
F000:74B3  [+0x074B3]  00 00                    add     [bx+si],al
F000:74B5  [+0x074B5]  00 00                    add     [bx+si],al
F000:74B7  [+0x074B7]  00 00                    add     [bx+si],al
F000:74B9  [+0x074B9]  CC                       int3
F000:74BA  [+0x074BA]  CC                       int3
F000:74BB  [+0x074BB]  CC                       int3
F000:74BC  [+0x074BC]  CC                       int3
F000:74BD  [+0x074BD]  CC                       int3
F000:74BE  [+0x074BE]  CC                       int3
F000:74BF  [+0x074BF]  76 00                    jbe     short 74C1h
F000:74C1  [+0x074C1]  00 00                    add     [bx+si],al
F000:74C3  [+0x074C3]  00 00                    add     [bx+si],al
F000:74C5  [+0x074C5]  00 00                    add     [bx+si],al
F000:74C7  [+0x074C7]  00 00                    add     [bx+si],al
F000:74C9  [+0x074C9]  66 66 66 66 66 3C 18     cmp     al,18h
F000:74D0  [+0x074D0]  00 00                    add     [bx+si],al
F000:74D2  [+0x074D2]  00 00                    add     [bx+si],al
F000:74D4  [+0x074D4]  00 00                    add     [bx+si],al
F000:74D6  [+0x074D6]  00 00                    add     [bx+si],al
F000:74D8  [+0x074D8]  00 C6                    add     dh,al
F000:74DA  [+0x074DA]  C6 C6 D6                 mov     dh,0D6h
F000:74DD  [+0x074DD]  D6                       salc
F000:74DE  [+0x074DE]  DB 0xFE  (bad)
F000:74E0  [+0x074E0]  00 00                    add     [bx+si],al
F000:74E2  [+0x074E2]  00 00                    add     [bx+si],al
F000:74E4  [+0x074E4]  00 00                    add     [bx+si],al
F000:74E6  [+0x074E6]  00 00                    add     [bx+si],al
F000:74E8  [+0x074E8]  00 C6                    add     dh,al
F000:74EA  [+0x074EA]  6C                       insb
F000:74EB  [+0x074EB]  38 38                    cmp     [bx+si],bh
F000:74ED  [+0x074ED]  38 6C C6                 cmp     [si-3Ah],ch
F000:74F0  [+0x074F0]  00 00                    add     [bx+si],al
F000:74F2  [+0x074F2]  00 00                    add     [bx+si],al
F000:74F4  [+0x074F4]  00 00                    add     [bx+si],al
F000:74F6  [+0x074F6]  00 00                    add     [bx+si],al
F000:74F8  [+0x074F8]  00 C6                    add     dh,al
F000:74FA  [+0x074FA]  C6 C6 C6                 mov     dh,0C6h
F000:74FD  [+0x074FD]  C6 C6 7E                 mov     dh,7Eh
F000:7500  [+0x07500]  06                       push    es
F000:7501  [+0x07501]  0C F8                    or      al,0F8h
F000:7503  [+0x07503]  00 00                    add     [bx+si],al
F000:7505  [+0x07505]  00 00                    add     [bx+si],al
F000:7507  [+0x07507]  00 00                    add     [bx+si],al
F000:7509  [+0x07509]  FE CC                    dec     ah
F000:750B  [+0x0750B]  18 30                    sbb     [bx+si],dh
F000:750D  [+0x0750D]  60                       pusha
F000:750E  [+0x0750E]  DB 0xC6  (bad)
F000:7510  [+0x07510]  00 00                    add     [bx+si],al
F000:7512  [+0x07512]  00 00                    add     [bx+si],al
F000:7514  [+0x07514]  00 00                    add     [bx+si],al
F000:7516  [+0x07516]  0E                       push    cs
F000:7517  [+0x07517]  18 18                    sbb     [bx+si],bl
F000:7519  [+0x07519]  18 70 18                 sbb     [bx+si+18h],dh
F000:751C  [+0x0751C]  18 18                    sbb     [bx+si],bl
F000:751E  [+0x0751E]  18 0E 00 00              sbb     [0],cl
F000:7522  [+0x07522]  00 00                    add     [bx+si],al
F000:7524  [+0x07524]  00 00                    add     [bx+si],al
F000:7526  [+0x07526]  18 18                    sbb     [bx+si],bl
F000:7528  [+0x07528]  18 18                    sbb     [bx+si],bl
F000:752A  [+0x0752A]  00 18                    add     [bx+si],bl
F000:752C  [+0x0752C]  18 18                    sbb     [bx+si],bl
F000:752E  [+0x0752E]  18 18                    sbb     [bx+si],bl
F000:7530  [+0x07530]  00 00                    add     [bx+si],al
F000:7532  [+0x07532]  00 00                    add     [bx+si],al
F000:7534  [+0x07534]  00 00                    add     [bx+si],al
F000:7536  [+0x07536]  70 18                    jo      short 7550h
F000:7538  [+0x07538]  18 18                    sbb     [bx+si],bl
F000:753A  [+0x0753A]  0E                       push    cs
F000:753B  [+0x0753B]  18 18                    sbb     [bx+si],bl
F000:753D  [+0x0753D]  18 18                    sbb     [bx+si],bl
F000:753F  [+0x0753F]  70 00                    jo      short 7541h
F000:7541  [+0x07541]  00 00                    add     [bx+si],al
F000:7543  [+0x07543]  00 00                    add     [bx+si],al
F000:7545  [+0x07545]  00 76 DC                 add     [bp-24h],dh
F000:7548  [+0x07548]  00 00                    add     [bx+si],al
F000:754A  [+0x0754A]  00 00                    add     [bx+si],al
F000:754C  [+0x0754C]  00 00                    add     [bx+si],al
F000:754E  [+0x0754E]  00 00                    add     [bx+si],al
F000:7550  [+0x07550]  00 00                    add     [bx+si],al
F000:7552  [+0x07552]  00 00                    add     [bx+si],al
F000:7554  [+0x07554]  00 00                    add     [bx+si],al
F000:7556  [+0x07556]  00 00                    add     [bx+si],al
F000:7558  [+0x07558]  10 38                    adc     [bx+si],bh
F000:755A  [+0x0755A]  6C                       insb
F000:755B  [+0x0755B]  C6 C6 C6                 mov     dh,0C6h
F000:755E  [+0x0755E]  FE 00                    inc     byte [bx+si]
F000:7560  [+0x07560]  00 00                    add     [bx+si],al
F000:7562  [+0x07562]  00 00                    add     [bx+si],al
F000:7564  [+0x07564]  00 00                    add     [bx+si],al
F000:7566  [+0x07566]  3C 66                    cmp     al,66h
F000:7568  [+0x07568]  C2 C0 C0                 ret     0C0C0h
F000:756B  [+0x0756B]  C0 C2 66                 rol     dl,66h
F000:756E  [+0x0756E]  3C 0C                    cmp     al,0Ch
F000:7570  [+0x07570]  06                       push    es
F000:7571  [+0x07571]  7C 00                    jl      short 7573h
F000:7573  [+0x07573]  00 00                    add     [bx+si],al
F000:7575  [+0x07575]  00 CC                    add     ah,cl
F000:7577  [+0x07577]  CC                       int3
F000:7578  [+0x07578]  00 CC                    add     ah,cl
F000:757A  [+0x0757A]  CC                       int3
F000:757B  [+0x0757B]  CC                       int3
F000:757C  [+0x0757C]  CC                       int3
F000:757D  [+0x0757D]  CC                       int3
F000:757E  [+0x0757E]  CC                       int3
F000:757F  [+0x0757F]  76 00                    jbe     short 7581h
F000:7581  [+0x07581]  00 00                    add     [bx+si],al
F000:7583  [+0x07583]  00 00                    add     [bx+si],al
F000:7585  [+0x07585]  0C 18                    or      al,18h
F000:7587  [+0x07587]  30 00                    xor     [bx+si],al
F000:7589  [+0x07589]  7C C6                    jl      short 7551h
F000:758B  [+0x0758B]  FE C0                    inc     al
F000:758D  [+0x0758D]  C0 C6 7C                 rol     dh,7Ch
F000:7590  [+0x07590]  00 00                    add     [bx+si],al
F000:7592  [+0x07592]  00 00                    add     [bx+si],al
F000:7594  [+0x07594]  00 10                    add     [bx+si],dl
F000:7596  [+0x07596]  38 6C 00                 cmp     [si],ch
F000:7599  [+0x07599]  78 0C                    js      short 75A7h
F000:759B  [+0x0759B]  7C CC                    jl      short 7569h
F000:759D  [+0x0759D]  CC                       int3
F000:759E  [+0x0759E]  CC                       int3
F000:759F  [+0x0759F]  76 00                    jbe     short 75A1h
F000:75A1  [+0x075A1]  00 00                    add     [bx+si],al
F000:75A3  [+0x075A3]  00 00                    add     [bx+si],al
F000:75A5  [+0x075A5]  00 CC                    add     ah,cl
F000:75A7  [+0x075A7]  CC                       int3
F000:75A8  [+0x075A8]  00 78 0C                 add     [bx+si+0Ch],bh
F000:75AB  [+0x075AB]  7C CC                    jl      short 7579h
F000:75AD  [+0x075AD]  CC                       int3
F000:75AE  [+0x075AE]  CC                       int3
F000:75AF  [+0x075AF]  76 00                    jbe     short 75B1h
F000:75B1  [+0x075B1]  00 00                    add     [bx+si],al
F000:75B3  [+0x075B3]  00 00                    add     [bx+si],al
F000:75B5  [+0x075B5]  60                       pusha
F000:75B6  [+0x075B6]  30 18                    xor     [bx+si],bl
F000:75B8  [+0x075B8]  00 78 0C                 add     [bx+si+0Ch],bh
F000:75BB  [+0x075BB]  7C CC                    jl      short 7589h
F000:75BD  [+0x075BD]  CC                       int3
F000:75BE  [+0x075BE]  CC                       int3
F000:75BF  [+0x075BF]  76 00                    jbe     short 75C1h
F000:75C1  [+0x075C1]  00 00                    add     [bx+si],al
F000:75C3  [+0x075C3]  00 00                    add     [bx+si],al
F000:75C5  [+0x075C5]  38 6C 38                 cmp     [si+38h],ch
F000:75C8  [+0x075C8]  00 78 0C                 add     [bx+si+0Ch],bh
F000:75CB  [+0x075CB]  7C CC                    jl      short 7599h
F000:75CD  [+0x075CD]  CC                       int3
F000:75CE  [+0x075CE]  CC                       int3
F000:75CF  [+0x075CF]  76 00                    jbe     short 75D1h
F000:75D1  [+0x075D1]  00 00                    add     [bx+si],al
F000:75D3  [+0x075D3]  00 00                    add     [bx+si],al
F000:75D5  [+0x075D5]  00 00                    add     [bx+si],al
F000:75D7  [+0x075D7]  00 3C                    add     [si],bh
F000:75D9  [+0x075D9]  66 60                    pushad
F000:75DB  [+0x075DB]  60                       pusha
F000:75DC  [+0x075DC]  66 3C 0C                 cmp     al,0Ch
F000:75DF  [+0x075DF]  06                       push    es
F000:75E0  [+0x075E0]  3C 00                    cmp     al,0
F000:75E2  [+0x075E2]  00 00                    add     [bx+si],al
F000:75E4  [+0x075E4]  00 10                    add     [bx+si],dl
F000:75E6  [+0x075E6]  38 6C 00                 cmp     [si],ch
F000:75E9  [+0x075E9]  7C C6                    jl      short 75B1h
F000:75EB  [+0x075EB]  FE C0                    inc     al
F000:75ED  [+0x075ED]  C0 C6 7C                 rol     dh,7Ch
F000:75F0  [+0x075F0]  00 00                    add     [bx+si],al
F000:75F2  [+0x075F2]  00 00                    add     [bx+si],al
F000:75F4  [+0x075F4]  00 00                    add     [bx+si],al
F000:75F6  [+0x075F6]  C6 C6 00                 mov     dh,0
F000:75F9  [+0x075F9]  7C C6                    jl      short 75C1h
F000:75FB  [+0x075FB]  FE C0                    inc     al
F000:75FD  [+0x075FD]  C0 C6 7C                 rol     dh,7Ch
F000:7600  [+0x07600]  00 00                    add     [bx+si],al
F000:7602  [+0x07602]  00 00                    add     [bx+si],al
F000:7604  [+0x07604]  00 60 30                 add     [bx+si+30h],ah
F000:7607  [+0x07607]  18 00                    sbb     [bx+si],al
F000:7609  [+0x07609]  7C C6                    jl      short 75D1h
F000:760B  [+0x0760B]  FE C0                    inc     al
F000:760D  [+0x0760D]  C0 C6 7C                 rol     dh,7Ch
F000:7610  [+0x07610]  00 00                    add     [bx+si],al
F000:7612  [+0x07612]  00 00                    add     [bx+si],al
F000:7614  [+0x07614]  00 00                    add     [bx+si],al
F000:7616  [+0x07616]  66 66 00 38              add     [bx+si],bh
F000:761A  [+0x0761A]  18 18                    sbb     [bx+si],bl
F000:761C  [+0x0761C]  18 18                    sbb     [bx+si],bl
F000:761E  [+0x0761E]  18 3C                    sbb     [si],bh
F000:7620  [+0x07620]  00 00                    add     [bx+si],al
F000:7622  [+0x07622]  00 00                    add     [bx+si],al
F000:7624  [+0x07624]  00 18                    add     [bx+si],bl
F000:7626  [+0x07626]  3C 66                    cmp     al,66h
F000:7628  [+0x07628]  00 38                    add     [bx+si],bh
F000:762A  [+0x0762A]  18 18                    sbb     [bx+si],bl
F000:762C  [+0x0762C]  18 18                    sbb     [bx+si],bl
F000:762E  [+0x0762E]  18 3C                    sbb     [si],bh
F000:7630  [+0x07630]  00 00                    add     [bx+si],al
F000:7632  [+0x07632]  00 00                    add     [bx+si],al
F000:7634  [+0x07634]  00 60 30                 add     [bx+si+30h],ah
F000:7637  [+0x07637]  18 00                    sbb     [bx+si],al
F000:7639  [+0x07639]  38 18                    cmp     [bx+si],bl
F000:763B  [+0x0763B]  18 18                    sbb     [bx+si],bl
F000:763D  [+0x0763D]  18 18                    sbb     [bx+si],bl
F000:763F  [+0x0763F]  3C 00                    cmp     al,0
F000:7641  [+0x07641]  00 00                    add     [bx+si],al
F000:7643  [+0x07643]  00 00                    add     [bx+si],al
F000:7645  [+0x07645]  C6 C6 10                 mov     dh,10h
F000:7648  [+0x07648]  38 6C C6                 cmp     [si-3Ah],ch
F000:764B  [+0x0764B]  DB 0xC6  (bad)
F000:764D  [+0x0764D]  C6 C6 C6                 mov     dh,0C6h
F000:7650  [+0x07650]  00 00                    add     [bx+si],al
F000:7652  [+0x07652]  00 00                    add     [bx+si],al
F000:7654  [+0x07654]  38 6C 38                 cmp     [si+38h],ch
F000:7657  [+0x07657]  00 38                    add     [bx+si],bh
F000:7659  [+0x07659]  6C                       insb
F000:765A  [+0x0765A]  C6 C6 FE                 mov     dh,0FEh
F000:765D  [+0x0765D]  C6 C6 C6                 mov     dh,0C6h
F000:7660  [+0x07660]  00 00                    add     [bx+si],al
F000:7662  [+0x07662]  00 00                    add     [bx+si],al
F000:7664  [+0x07664]  18 30                    sbb     [bx+si],dh
F000:7666  [+0x07666]  60                       pusha
F000:7667  [+0x07667]  00 FE                    add     dh,bh
F000:7669  [+0x07669]  66 60                    pushad
F000:766B  [+0x0766B]  7C 60                    jl      short 76CDh
F000:766D  [+0x0766D]  60                       pusha
F000:766E  [+0x0766E]  66 FE 00                 inc     byte [bx+si]
F000:7671  [+0x07671]  00 00                    add     [bx+si],al
F000:7673  [+0x07673]  00 00                    add     [bx+si],al
F000:7675  [+0x07675]  00 00                    add     [bx+si],al
F000:7677  [+0x07677]  00 00                    add     [bx+si],al
F000:7679  [+0x07679]  CC                       int3
F000:767A  [+0x0767A]  76 36                    jbe     short 76B2h
F000:767C  [+0x0767C]  7E D8                    jle     short 7656h
F000:767E  [+0x0767E]  D8 6E 00                 fsubr   dword [bp]
F000:7681  [+0x07681]  00 00                    add     [bx+si],al
F000:7683  [+0x07683]  00 00                    add     [bx+si],al
F000:7685  [+0x07685]  00 3E 6C CC              add     [0CC6Ch],bh
F000:7689  [+0x07689]  CC                       int3
F000:768A  [+0x0768A]  FE CC                    dec     ah
F000:768C  [+0x0768C]  CC                       int3
F000:768D  [+0x0768D]  CC                       int3
F000:768E  [+0x0768E]  CC                       int3
F000:768F  [+0x0768F]  CE                       into
F000:7690  [+0x07690]  00 00                    add     [bx+si],al
F000:7692  [+0x07692]  00 00                    add     [bx+si],al
F000:7694  [+0x07694]  00 10                    add     [bx+si],dl
F000:7696  [+0x07696]  38 6C 00                 cmp     [si],ch
F000:7699  [+0x07699]  7C C6                    jl      short 7661h
F000:769B  [+0x0769B]  C6 C6 C6                 mov     dh,0C6h
F000:769E  [+0x0769E]  DB 0xC6  (bad)
F000:76A0  [+0x076A0]  00 00                    add     [bx+si],al
F000:76A2  [+0x076A2]  00 00                    add     [bx+si],al
F000:76A4  [+0x076A4]  00 00                    add     [bx+si],al
F000:76A6  [+0x076A6]  C6 C6 00                 mov     dh,0
F000:76A9  [+0x076A9]  7C C6                    jl      short 7671h
F000:76AB  [+0x076AB]  C6 C6 C6                 mov     dh,0C6h
F000:76AE  [+0x076AE]  DB 0xC6  (bad)
F000:76B0  [+0x076B0]  00 00                    add     [bx+si],al
F000:76B2  [+0x076B2]  00 00                    add     [bx+si],al
F000:76B4  [+0x076B4]  00 60 30                 add     [bx+si+30h],ah
F000:76B7  [+0x076B7]  18 00                    sbb     [bx+si],al
F000:76B9  [+0x076B9]  7C C6                    jl      short 7681h
F000:76BB  [+0x076BB]  C6 C6 C6                 mov     dh,0C6h
F000:76BE  [+0x076BE]  DB 0xC6  (bad)
F000:76C0  [+0x076C0]  00 00                    add     [bx+si],al
F000:76C2  [+0x076C2]  00 00                    add     [bx+si],al
F000:76C4  [+0x076C4]  00 30                    add     [bx+si],dh
F000:76C6  [+0x076C6]  78 CC                    js      short 7694h
F000:76C8  [+0x076C8]  00 CC                    add     ah,cl
F000:76CA  [+0x076CA]  CC                       int3
F000:76CB  [+0x076CB]  CC                       int3
F000:76CC  [+0x076CC]  CC                       int3
F000:76CD  [+0x076CD]  CC                       int3
F000:76CE  [+0x076CE]  CC                       int3
F000:76CF  [+0x076CF]  76 00                    jbe     short 76D1h
F000:76D1  [+0x076D1]  00 00                    add     [bx+si],al
F000:76D3  [+0x076D3]  00 00                    add     [bx+si],al
F000:76D5  [+0x076D5]  60                       pusha
F000:76D6  [+0x076D6]  30 18                    xor     [bx+si],bl
F000:76D8  [+0x076D8]  00 CC                    add     ah,cl
F000:76DA  [+0x076DA]  CC                       int3
F000:76DB  [+0x076DB]  CC                       int3
F000:76DC  [+0x076DC]  CC                       int3
F000:76DD  [+0x076DD]  CC                       int3
F000:76DE  [+0x076DE]  CC                       int3
F000:76DF  [+0x076DF]  76 00                    jbe     short 76E1h
F000:76E1  [+0x076E1]  00 00                    add     [bx+si],al
F000:76E3  [+0x076E3]  00 00                    add     [bx+si],al
F000:76E5  [+0x076E5]  00 C6                    add     dh,al
F000:76E7  [+0x076E7]  C6 00 C6                 mov     byte [bx+si],0C6h
F000:76EA  [+0x076EA]  C6 C6 C6                 mov     dh,0C6h
F000:76ED  [+0x076ED]  C6 C6 7E                 mov     dh,7Eh
F000:76F0  [+0x076F0]  06                       push    es
F000:76F1  [+0x076F1]  0C 78                    or      al,78h
F000:76F3  [+0x076F3]  00 00                    add     [bx+si],al
F000:76F5  [+0x076F5]  C6 C6 00                 mov     dh,0
F000:76F8  [+0x076F8]  38 6C C6                 cmp     [si-3Ah],ch
F000:76FB  [+0x076FB]  C6 C6 C6                 mov     dh,0C6h
F000:76FE  [+0x076FE]  6C                       insb
F000:76FF  [+0x076FF]  38 00                    cmp     [bx+si],al
F000:7701  [+0x07701]  00 00                    add     [bx+si],al
F000:7703  [+0x07703]  00 00                    add     [bx+si],al
F000:7705  [+0x07705]  C6 C6 00                 mov     dh,0
F000:7708  [+0x07708]  C6 C6 C6                 mov     dh,0C6h
F000:770B  [+0x0770B]  C6 C6 C6                 mov     dh,0C6h
F000:770E  [+0x0770E]  DB 0xC6  (bad)
F000:7710  [+0x07710]  00 00                    add     [bx+si],al
F000:7712  [+0x07712]  00 00                    add     [bx+si],al
F000:7714  [+0x07714]  00 18                    add     [bx+si],bl
F000:7716  [+0x07716]  18 3C                    sbb     [si],bh
F000:7718  [+0x07718]  66 60                    pushad
F000:771A  [+0x0771A]  60                       pusha
F000:771B  [+0x0771B]  60                       pusha
F000:771C  [+0x0771C]  66 3C 18                 cmp     al,18h
F000:771F  [+0x0771F]  18 00                    sbb     [bx+si],al
F000:7721  [+0x07721]  00 00                    add     [bx+si],al
F000:7723  [+0x07723]  00 00                    add     [bx+si],al
F000:7725  [+0x07725]  38 6C 64                 cmp     [si+64h],ch
F000:7728  [+0x07728]  60                       pusha
F000:7729  [+0x07729]  DB 0xF0  (bad)
F000:772B  [+0x0772B]  60                       pusha
F000:772C  [+0x0772C]  60                       pusha
F000:772D  [+0x0772D]  60                       pusha
F000:772E  [+0x0772E]  E6 FC                    out     0FCh,al
F000:7730  [+0x07730]  00 00                    add     [bx+si],al
F000:7732  [+0x07732]  00 00                    add     [bx+si],al
F000:7734  [+0x07734]  00 00                    add     [bx+si],al
F000:7736  [+0x07736]  66 66 3C 18              cmp     al,18h
F000:773A  [+0x0773A]  7E 18                    jle     short 7754h
F000:773C  [+0x0773C]  7E 18                    jle     short 7756h
F000:773E  [+0x0773E]  18 18                    sbb     [bx+si],bl
F000:7740  [+0x07740]  00 00                    add     [bx+si],al
F000:7742  [+0x07742]  00 00                    add     [bx+si],al
F000:7744  [+0x07744]  00 F8                    add     al,bh
F000:7746  [+0x07746]  CC                       int3
F000:7747  [+0x07747]  CC                       int3
F000:7748  [+0x07748]  F8                       clc
F000:7749  [+0x07749]  DB 0xC4  (bad)
F000:774D  [+0x0774D]  CC                       int3
F000:774E  [+0x0774E]  CC                       int3
F000:774F  [+0x0774F]  C6 00 00                 mov     byte [bx+si],0
F000:7752  [+0x07752]  00 00                    add     [bx+si],al
F000:7754  [+0x07754]  00 0E 1B 18              add     [181Bh],cl
F000:7758  [+0x07758]  18 18                    sbb     [bx+si],bl
F000:775A  [+0x0775A]  7E 18                    jle     short 7774h
F000:775C  [+0x0775C]  18 18                    sbb     [bx+si],bl
F000:775E  [+0x0775E]  18 18                    sbb     [bx+si],bl
F000:7760  [+0x07760]  D8 70 00                 fdiv    dword [bx+si]
F000:7763  [+0x07763]  00 00                    add     [bx+si],al
F000:7765  [+0x07765]  18 30                    sbb     [bx+si],dh
F000:7767  [+0x07767]  60                       pusha
F000:7768  [+0x07768]  00 78 0C                 add     [bx+si+0Ch],bh
F000:776B  [+0x0776B]  7C CC                    jl      short 7739h
F000:776D  [+0x0776D]  CC                       int3
F000:776E  [+0x0776E]  CC                       int3
F000:776F  [+0x0776F]  76 00                    jbe     short 7771h
F000:7771  [+0x07771]  00 00                    add     [bx+si],al
F000:7773  [+0x07773]  00 00                    add     [bx+si],al
F000:7775  [+0x07775]  0C 18                    or      al,18h
F000:7777  [+0x07777]  30 00                    xor     [bx+si],al
F000:7779  [+0x07779]  38 18                    cmp     [bx+si],bl
F000:777B  [+0x0777B]  18 18                    sbb     [bx+si],bl
F000:777D  [+0x0777D]  18 18                    sbb     [bx+si],bl
F000:777F  [+0x0777F]  3C 00                    cmp     al,0
F000:7781  [+0x07781]  00 00                    add     [bx+si],al
F000:7783  [+0x07783]  00 00                    add     [bx+si],al
F000:7785  [+0x07785]  18 30                    sbb     [bx+si],dh
F000:7787  [+0x07787]  60                       pusha
F000:7788  [+0x07788]  00 7C C6                 add     [si-3Ah],bh
F000:778B  [+0x0778B]  C6 C6 C6                 mov     dh,0C6h
F000:778E  [+0x0778E]  DB 0xC6  (bad)
F000:7790  [+0x07790]  00 00                    add     [bx+si],al
F000:7792  [+0x07792]  00 00                    add     [bx+si],al
F000:7794  [+0x07794]  00 18                    add     [bx+si],bl
F000:7796  [+0x07796]  30 60 00                 xor     [bx+si],ah
F000:7799  [+0x07799]  CC                       int3
F000:779A  [+0x0779A]  CC                       int3
F000:779B  [+0x0779B]  CC                       int3
F000:779C  [+0x0779C]  CC                       int3
F000:779D  [+0x0779D]  CC                       int3
F000:779E  [+0x0779E]  CC                       int3
F000:779F  [+0x0779F]  76 00                    jbe     short 77A1h
F000:77A1  [+0x077A1]  00 00                    add     [bx+si],al
F000:77A3  [+0x077A3]  00 00                    add     [bx+si],al
F000:77A5  [+0x077A5]  00 76 DC                 add     [bp-24h],dh
F000:77A8  [+0x077A8]  00 DC                    add     ah,bl
F000:77AA  [+0x077AA]  66 66 66 66 66 66 00 00  add     [bx+si],al
F000:77B2  [+0x077B2]  00 00                    add     [bx+si],al
F000:77B4  [+0x077B4]  76 DC                    jbe     short 7792h
F000:77B6  [+0x077B6]  00 C6                    add     dh,al
F000:77B8  [+0x077B8]  E6 F6                    out     0F6h,al
F000:77BA  [+0x077BA]  DB 0xFE  (bad)
F000:77BC  [+0x077BC]  CE                       into
F000:77BD  [+0x077BD]  C6 C6 C6                 mov     dh,0C6h
F000:77C0  [+0x077C0]  00 00                    add     [bx+si],al
F000:77C2  [+0x077C2]  00 00                    add     [bx+si],al
F000:77C4  [+0x077C4]  00 3C                    add     [si],bh
F000:77C6  [+0x077C6]  6C                       insb
F000:77C7  [+0x077C7]  6C                       insb
F000:77C8  [+0x077C8]  3E 00 7E 00              add     [ds:bp],bh
F000:77CC  [+0x077CC]  00 00                    add     [bx+si],al
F000:77CE  [+0x077CE]  00 00                    add     [bx+si],al
F000:77D0  [+0x077D0]  00 00                    add     [bx+si],al
F000:77D2  [+0x077D2]  00 00                    add     [bx+si],al
F000:77D4  [+0x077D4]  00 38                    add     [bx+si],bh
F000:77D6  [+0x077D6]  6C                       insb
F000:77D7  [+0x077D7]  6C                       insb
F000:77D8  [+0x077D8]  38 00                    cmp     [bx+si],al
F000:77DA  [+0x077DA]  7C 00                    jl      short 77DCh
F000:77DC  [+0x077DC]  00 00                    add     [bx+si],al
F000:77DE  [+0x077DE]  00 00                    add     [bx+si],al
F000:77E0  [+0x077E0]  00 00                    add     [bx+si],al
F000:77E2  [+0x077E2]  00 00                    add     [bx+si],al
F000:77E4  [+0x077E4]  00 00                    add     [bx+si],al
F000:77E6  [+0x077E6]  30 30                    xor     [bx+si],dh
F000:77E8  [+0x077E8]  00 30                    add     [bx+si],dh
F000:77EA  [+0x077EA]  30 60 C0                 xor     [bx+si-40h],ah
F000:77ED  [+0x077ED]  C6 C6 7C                 mov     dh,7Ch
F000:77F0  [+0x077F0]  00 00                    add     [bx+si],al
F000:77F2  [+0x077F2]  00 00                    add     [bx+si],al
F000:77F4  [+0x077F4]  00 00                    add     [bx+si],al
F000:77F6  [+0x077F6]  00 00                    add     [bx+si],al
F000:77F8  [+0x077F8]  00 00                    add     [bx+si],al
F000:77FA  [+0x077FA]  FE C0                    inc     al
F000:77FC  [+0x077FC]  C0 C0 C0                 rol     al,0C0h
F000:77FF  [+0x077FF]  00 00                    add     [bx+si],al
F000:7801  [+0x07801]  00 00                    add     [bx+si],al
F000:7803  [+0x07803]  00 00                    add     [bx+si],al
F000:7805  [+0x07805]  00 00                    add     [bx+si],al
F000:7807  [+0x07807]  00 00                    add     [bx+si],al
F000:7809  [+0x07809]  00 FE                    add     dh,bh
F000:780B  [+0x0780B]  06                       push    es
F000:780C  [+0x0780C]  06                       push    es
F000:780D  [+0x0780D]  06                       push    es
F000:780E  [+0x0780E]  06                       push    es
F000:780F  [+0x0780F]  00 00                    add     [bx+si],al
F000:7811  [+0x07811]  00 00                    add     [bx+si],al
F000:7813  [+0x07813]  00 00                    add     [bx+si],al
F000:7815  [+0x07815]  C0 C0 C2                 rol     al,0C2h
F000:7818  [+0x07818]  DB 0xC6  (bad)
F000:781A  [+0x0781A]  18 30                    sbb     [bx+si],dh
F000:781C  [+0x0781C]  60                       pusha
F000:781D  [+0x0781D]  CE                       into
F000:781E  [+0x0781E]  93                       xchg    bx,ax
F000:781F  [+0x0781F]  06                       push    es
F000:7820  [+0x07820]  0C 1F                    or      al,1Fh
F000:7822  [+0x07822]  00 00                    add     [bx+si],al
F000:7824  [+0x07824]  00 C0                    add     al,al
F000:7826  [+0x07826]  C0 C2 C6                 rol     dl,0C6h
F000:7829  [+0x07829]  CC                       int3
F000:782A  [+0x0782A]  18 30                    sbb     [bx+si],dh
F000:782C  [+0x0782C]  66 CE                    into
F000:782E  [+0x0782E]  9A 3F 06 0F 00           call    000Fh:063Fh
F000:7833  [+0x07833]  00 00                    add     [bx+si],al
F000:7835  [+0x07835]  00 18                    add     [bx+si],bl
F000:7837  [+0x07837]  18 00                    sbb     [bx+si],al
F000:7839  [+0x07839]  18 18                    sbb     [bx+si],bl
F000:783B  [+0x0783B]  18 3C                    sbb     [si],bh
F000:783D  [+0x0783D]  3C 3C                    cmp     al,3Ch
F000:783F  [+0x0783F]  18 00                    sbb     [bx+si],al
F000:7841  [+0x07841]  00 00                    add     [bx+si],al
F000:7843  [+0x07843]  00 00                    add     [bx+si],al
F000:7845  [+0x07845]  00 00                    add     [bx+si],al
F000:7847  [+0x07847]  00 00                    add     [bx+si],al
F000:7849  [+0x07849]  33 66 CC                 xor     sp,[bp-34h]
F000:784C  [+0x0784C]  66 33 00                 xor     eax,[bx+si]
F000:784F  [+0x0784F]  00 00                    add     [bx+si],al
F000:7851  [+0x07851]  00 00                    add     [bx+si],al
F000:7853  [+0x07853]  00 00                    add     [bx+si],al
F000:7855  [+0x07855]  00 00                    add     [bx+si],al
F000:7857  [+0x07857]  00 00                    add     [bx+si],al
F000:7859  [+0x07859]  CC                       int3
F000:785A  [+0x0785A]  66 33 66 CC              xor     esp,[bp-34h]
F000:785E  [+0x0785E]  00 00                    add     [bx+si],al
F000:7860  [+0x07860]  00 00                    add     [bx+si],al
F000:7862  [+0x07862]  00 00                    add     [bx+si],al
F000:7864  [+0x07864]  11 44 11                 adc     [si+11h],ax
F000:7867  [+0x07867]  44                       inc     sp
F000:7868  [+0x07868]  11 44 11                 adc     [si+11h],ax
F000:786B  [+0x0786B]  44                       inc     sp
F000:786C  [+0x0786C]  11 44 11                 adc     [si+11h],ax
F000:786F  [+0x0786F]  44                       inc     sp
F000:7870  [+0x07870]  11 44 11                 adc     [si+11h],ax
F000:7873  [+0x07873]  44                       inc     sp
F000:7874  [+0x07874]  55                       push    bp
F000:7875  [+0x07875]  AA                       stosb
F000:7876  [+0x07876]  55                       push    bp
F000:7877  [+0x07877]  AA                       stosb
F000:7878  [+0x07878]  55                       push    bp
F000:7879  [+0x07879]  AA                       stosb
F000:787A  [+0x0787A]  55                       push    bp
F000:787B  [+0x0787B]  AA                       stosb
F000:787C  [+0x0787C]  55                       push    bp
F000:787D  [+0x0787D]  AA                       stosb
F000:787E  [+0x0787E]  55                       push    bp
F000:787F  [+0x0787F]  AA                       stosb
F000:7880  [+0x07880]  55                       push    bp
F000:7881  [+0x07881]  AA                       stosb
F000:7882  [+0x07882]  55                       push    bp
F000:7883  [+0x07883]  AA                       stosb
F000:7884  [+0x07884]  DD 77 DD                 fnsave  [bx-23h]
F000:7887  [+0x07887]  77 DD                    ja      short 7866h
F000:7889  [+0x07889]  77 DD                    ja      short 7868h
F000:788B  [+0x0788B]  77 DD                    ja      short 786Ah
F000:788D  [+0x0788D]  77 DD                    ja      short 786Ch
F000:788F  [+0x0788F]  77 DD                    ja      short 786Eh
F000:7891  [+0x07891]  77 DD                    ja      short 7870h
F000:7893  [+0x07893]  77 18                    ja      short 78ADh
F000:7895  [+0x07895]  18 18                    sbb     [bx+si],bl
F000:7897  [+0x07897]  18 18                    sbb     [bx+si],bl
F000:7899  [+0x07899]  18 18                    sbb     [bx+si],bl
F000:789B  [+0x0789B]  18 18                    sbb     [bx+si],bl
F000:789D  [+0x0789D]  18 18                    sbb     [bx+si],bl
F000:789F  [+0x0789F]  18 18                    sbb     [bx+si],bl
F000:78A1  [+0x078A1]  18 18                    sbb     [bx+si],bl
F000:78A3  [+0x078A3]  18 18                    sbb     [bx+si],bl
F000:78A5  [+0x078A5]  18 18                    sbb     [bx+si],bl
F000:78A7  [+0x078A7]  18 18                    sbb     [bx+si],bl
F000:78A9  [+0x078A9]  18 18                    sbb     [bx+si],bl
F000:78AB  [+0x078AB]  F8                       clc
F000:78AC  [+0x078AC]  18 18                    sbb     [bx+si],bl
F000:78AE  [+0x078AE]  18 18                    sbb     [bx+si],bl
F000:78B0  [+0x078B0]  18 18                    sbb     [bx+si],bl
F000:78B2  [+0x078B2]  18 18                    sbb     [bx+si],bl
F000:78B4  [+0x078B4]  18 18                    sbb     [bx+si],bl
F000:78B6  [+0x078B6]  18 18                    sbb     [bx+si],bl
F000:78B8  [+0x078B8]  18 F8                    sbb     al,bh
F000:78BA  [+0x078BA]  18 F8                    sbb     al,bh
F000:78BC  [+0x078BC]  18 18                    sbb     [bx+si],bl
F000:78BE  [+0x078BE]  18 18                    sbb     [bx+si],bl
F000:78C0  [+0x078C0]  18 18                    sbb     [bx+si],bl
F000:78C2  [+0x078C2]  18 18                    sbb     [bx+si],bl
F000:78C4  [+0x078C4]  36 36 36 36 36 36 36 F6 36 36 36 div     byte [ss:3636h]
F000:78CF  [+0x078CF]  36 36 36 36 36 00 00     add     [ss:bx+si],al
F000:78D6  [+0x078D6]  00 00                    add     [bx+si],al
F000:78D8  [+0x078D8]  00 00                    add     [bx+si],al
F000:78DA  [+0x078DA]  00 FE                    add     dh,bh
F000:78DC  [+0x078DC]  36 36 36 36 36 36 36 36 00 00 add     [ss:bx+si],al
F000:78E6  [+0x078E6]  00 00                    add     [bx+si],al
F000:78E8  [+0x078E8]  00 F8                    add     al,bh
F000:78EA  [+0x078EA]  18 F8                    sbb     al,bh
F000:78EC  [+0x078EC]  18 18                    sbb     [bx+si],bl
F000:78EE  [+0x078EE]  18 18                    sbb     [bx+si],bl
F000:78F0  [+0x078F0]  18 18                    sbb     [bx+si],bl
F000:78F2  [+0x078F2]  18 18                    sbb     [bx+si],bl
F000:78F4  [+0x078F4]  36 36 36 36 36 F6 06 F6 36 36 test    byte [ss:36F6h],36h
F000:78FE  [+0x078FE]  DB 0x36  (bad)
F000:790D  [+0x0790D]  36 36 36 36 36 36 36 00 00 add     [ss:bx+si],al
F000:7916  [+0x07916]  00 00                    add     [bx+si],al
F000:7918  [+0x07918]  00 FE                    add     dh,bh
F000:791A  [+0x0791A]  06                       push    es
F000:791B  [+0x0791B]  F6 36 36 36              div     byte [3636h]
F000:791F  [+0x0791F]  36 36 36 36 36 36 36 36 36 36 F6 06 FE 00 00 test    byte [ss:0FEh],0
F000:792E  [+0x0792E]  00 00                    add     [bx+si],al
F000:7930  [+0x07930]  00 00                    add     [bx+si],al
F000:7932  [+0x07932]  00 00                    add     [bx+si],al
F000:7934  [+0x07934]  36 36 36 36 36 36 36 FE 00 inc     byte [ss:bx+si]
F000:793D  [+0x0793D]  00 00                    add     [bx+si],al
F000:793F  [+0x0793F]  00 00                    add     [bx+si],al
F000:7941  [+0x07941]  00 00                    add     [bx+si],al
F000:7943  [+0x07943]  00 18                    add     [bx+si],bl
F000:7945  [+0x07945]  18 18                    sbb     [bx+si],bl
F000:7947  [+0x07947]  18 18                    sbb     [bx+si],bl
F000:7949  [+0x07949]  F8                       clc
F000:794A  [+0x0794A]  18 F8                    sbb     al,bh
F000:794C  [+0x0794C]  00 00                    add     [bx+si],al
F000:794E  [+0x0794E]  00 00                    add     [bx+si],al
F000:7950  [+0x07950]  00 00                    add     [bx+si],al
F000:7952  [+0x07952]  00 00                    add     [bx+si],al
F000:7954  [+0x07954]  00 00                    add     [bx+si],al
F000:7956  [+0x07956]  00 00                    add     [bx+si],al
F000:7958  [+0x07958]  00 00                    add     [bx+si],al
F000:795A  [+0x0795A]  00 F8                    add     al,bh
F000:795C  [+0x0795C]  18 18                    sbb     [bx+si],bl
F000:795E  [+0x0795E]  18 18                    sbb     [bx+si],bl
F000:7960  [+0x07960]  18 18                    sbb     [bx+si],bl
F000:7962  [+0x07962]  18 18                    sbb     [bx+si],bl
F000:7964  [+0x07964]  18 18                    sbb     [bx+si],bl
F000:7966  [+0x07966]  18 18                    sbb     [bx+si],bl
F000:7968  [+0x07968]  18 18                    sbb     [bx+si],bl
F000:796A  [+0x0796A]  18 1F                    sbb     [bx],bl
F000:796C  [+0x0796C]  00 00                    add     [bx+si],al
F000:796E  [+0x0796E]  00 00                    add     [bx+si],al
F000:7970  [+0x07970]  00 00                    add     [bx+si],al
F000:7972  [+0x07972]  00 00                    add     [bx+si],al
F000:7974  [+0x07974]  18 18                    sbb     [bx+si],bl
F000:7976  [+0x07976]  18 18                    sbb     [bx+si],bl
F000:7978  [+0x07978]  18 18                    sbb     [bx+si],bl
F000:797A  [+0x0797A]  18 FF                    sbb     bh,bh
F000:797C  [+0x0797C]  00 00                    add     [bx+si],al
F000:797E  [+0x0797E]  00 00                    add     [bx+si],al
F000:7980  [+0x07980]  00 00                    add     [bx+si],al
F000:7982  [+0x07982]  00 00                    add     [bx+si],al
F000:7984  [+0x07984]  00 00                    add     [bx+si],al
F000:7986  [+0x07986]  00 00                    add     [bx+si],al
F000:7988  [+0x07988]  00 00                    add     [bx+si],al
F000:798A  [+0x0798A]  00 FF                    add     bh,bh
F000:798C  [+0x0798C]  18 18                    sbb     [bx+si],bl
F000:798E  [+0x0798E]  18 18                    sbb     [bx+si],bl
F000:7990  [+0x07990]  18 18                    sbb     [bx+si],bl
F000:7992  [+0x07992]  18 18                    sbb     [bx+si],bl
F000:7994  [+0x07994]  18 18                    sbb     [bx+si],bl
F000:7996  [+0x07996]  18 18                    sbb     [bx+si],bl
F000:7998  [+0x07998]  18 18                    sbb     [bx+si],bl
F000:799A  [+0x0799A]  18 1F                    sbb     [bx],bl
F000:799C  [+0x0799C]  18 18                    sbb     [bx+si],bl
F000:799E  [+0x0799E]  18 18                    sbb     [bx+si],bl
F000:79A0  [+0x079A0]  18 18                    sbb     [bx+si],bl
F000:79A2  [+0x079A2]  18 18                    sbb     [bx+si],bl
F000:79A4  [+0x079A4]  00 00                    add     [bx+si],al
F000:79A6  [+0x079A6]  00 00                    add     [bx+si],al
F000:79A8  [+0x079A8]  00 00                    add     [bx+si],al
F000:79AA  [+0x079AA]  00 FF                    add     bh,bh
F000:79AC  [+0x079AC]  00 00                    add     [bx+si],al
F000:79AE  [+0x079AE]  00 00                    add     [bx+si],al
F000:79B0  [+0x079B0]  00 00                    add     [bx+si],al
F000:79B2  [+0x079B2]  00 00                    add     [bx+si],al
F000:79B4  [+0x079B4]  18 18                    sbb     [bx+si],bl
F000:79B6  [+0x079B6]  18 18                    sbb     [bx+si],bl
F000:79B8  [+0x079B8]  18 18                    sbb     [bx+si],bl
F000:79BA  [+0x079BA]  18 FF                    sbb     bh,bh
F000:79BC  [+0x079BC]  18 18                    sbb     [bx+si],bl
F000:79BE  [+0x079BE]  18 18                    sbb     [bx+si],bl
F000:79C0  [+0x079C0]  18 18                    sbb     [bx+si],bl
F000:79C2  [+0x079C2]  18 18                    sbb     [bx+si],bl
F000:79C4  [+0x079C4]  18 18                    sbb     [bx+si],bl
F000:79C6  [+0x079C6]  18 18                    sbb     [bx+si],bl
F000:79C8  [+0x079C8]  18 1F                    sbb     [bx],bl
F000:79CA  [+0x079CA]  18 1F                    sbb     [bx],bl
F000:79CC  [+0x079CC]  18 18                    sbb     [bx+si],bl
F000:79CE  [+0x079CE]  18 18                    sbb     [bx+si],bl
F000:79D0  [+0x079D0]  18 18                    sbb     [bx+si],bl
F000:79D2  [+0x079D2]  18 18                    sbb     [bx+si],bl
F000:79D4  [+0x079D4]  36 36 36 36 36 36 36 37  aaa
F000:79DC  [+0x079DC]  36 36 36 36 36 36 36 36 36 36 36 36 36 37 aaa
F000:79EA  [+0x079EA]  30 3F                    xor     [bx],bh
F000:79EC  [+0x079EC]  00 00                    add     [bx+si],al
F000:79EE  [+0x079EE]  00 00                    add     [bx+si],al
F000:79F0  [+0x079F0]  00 00                    add     [bx+si],al
F000:79F2  [+0x079F2]  00 00                    add     [bx+si],al
F000:79F4  [+0x079F4]  00 00                    add     [bx+si],al
F000:79F6  [+0x079F6]  00 00                    add     [bx+si],al
F000:79F8  [+0x079F8]  00 3F                    add     [bx],bh
F000:79FA  [+0x079FA]  30 37                    xor     [bx],dh
F000:79FC  [+0x079FC]  DB 0x36  (bad)
F000:7A0B  [+0x07A0B]  FF 00                    inc     word [bx+si]
F000:7A0D  [+0x07A0D]  00 00                    add     [bx+si],al
F000:7A0F  [+0x07A0F]  00 00                    add     [bx+si],al
F000:7A11  [+0x07A11]  00 00                    add     [bx+si],al
F000:7A13  [+0x07A13]  00 00                    add     [bx+si],al
F000:7A15  [+0x07A15]  00 00                    add     [bx+si],al
F000:7A17  [+0x07A17]  00 00                    add     [bx+si],al
F000:7A19  [+0x07A19]  FF 00                    inc     word [bx+si]
F000:7A1B  [+0x07A1B]  F7 36 36 36              div     word [3636h]
F000:7A1F  [+0x07A1F]  36 36 36 36 36 36 36 36 36 36 37 aaa
F000:7A2A  [+0x07A2A]  30 37                    xor     [bx],dh
F000:7A2C  [+0x07A2C]  36 36 36 36 36 36 36 36 00 00 add     [ss:bx+si],al
F000:7A36  [+0x07A36]  00 00                    add     [bx+si],al
F000:7A38  [+0x07A38]  00 FF                    add     bh,bh
F000:7A3A  [+0x07A3A]  00 FF                    add     bh,bh
F000:7A3C  [+0x07A3C]  00 00                    add     [bx+si],al
F000:7A3E  [+0x07A3E]  00 00                    add     [bx+si],al
F000:7A40  [+0x07A40]  00 00                    add     [bx+si],al
F000:7A42  [+0x07A42]  00 00                    add     [bx+si],al
F000:7A44  [+0x07A44]  36 36 36 36 36 F7 00 F7 36 test    word [ss:bx+si],36F7h
F000:7A4D  [+0x07A4D]  36 36 36 36 36 36 36 18 18 sbb     [ss:bx+si],bl
F000:7A56  [+0x07A56]  18 18                    sbb     [bx+si],bl
F000:7A58  [+0x07A58]  18 FF                    sbb     bh,bh
F000:7A5A  [+0x07A5A]  00 FF                    add     bh,bh
F000:7A5C  [+0x07A5C]  00 00                    add     [bx+si],al
F000:7A5E  [+0x07A5E]  00 00                    add     [bx+si],al
F000:7A60  [+0x07A60]  00 00                    add     [bx+si],al
F000:7A62  [+0x07A62]  00 00                    add     [bx+si],al
F000:7A64  [+0x07A64]  36 36 36 36 36 36 36 FF 00 inc     word [ss:bx+si]
F000:7A6D  [+0x07A6D]  00 00                    add     [bx+si],al
F000:7A6F  [+0x07A6F]  00 00                    add     [bx+si],al
F000:7A71  [+0x07A71]  00 00                    add     [bx+si],al
F000:7A73  [+0x07A73]  00 00                    add     [bx+si],al
F000:7A75  [+0x07A75]  00 00                    add     [bx+si],al
F000:7A77  [+0x07A77]  00 00                    add     [bx+si],al
F000:7A79  [+0x07A79]  FF 00                    inc     word [bx+si]
F000:7A7B  [+0x07A7B]  FF 18                    call    far [bx+si]
F000:7A7D  [+0x07A7D]  18 18                    sbb     [bx+si],bl
F000:7A7F  [+0x07A7F]  18 18                    sbb     [bx+si],bl
F000:7A81  [+0x07A81]  18 18                    sbb     [bx+si],bl
F000:7A83  [+0x07A83]  18 00                    sbb     [bx+si],al
F000:7A85  [+0x07A85]  00 00                    add     [bx+si],al
F000:7A87  [+0x07A87]  00 00                    add     [bx+si],al
F000:7A89  [+0x07A89]  00 00                    add     [bx+si],al
F000:7A8B  [+0x07A8B]  FF 36 36 36              push    word [3636h]
F000:7A8F  [+0x07A8F]  36 36 36 36 36 36 36 36 36 36 36 36 3F aas
F000:7A9C  [+0x07A9C]  00 00                    add     [bx+si],al
F000:7A9E  [+0x07A9E]  00 00                    add     [bx+si],al
F000:7AA0  [+0x07AA0]  00 00                    add     [bx+si],al
F000:7AA2  [+0x07AA2]  00 00                    add     [bx+si],al
F000:7AA4  [+0x07AA4]  18 18                    sbb     [bx+si],bl
F000:7AA6  [+0x07AA6]  18 18                    sbb     [bx+si],bl
F000:7AA8  [+0x07AA8]  18 1F                    sbb     [bx],bl
F000:7AAA  [+0x07AAA]  18 1F                    sbb     [bx],bl
F000:7AAC  [+0x07AAC]  00 00                    add     [bx+si],al
F000:7AAE  [+0x07AAE]  00 00                    add     [bx+si],al
F000:7AB0  [+0x07AB0]  00 00                    add     [bx+si],al
F000:7AB2  [+0x07AB2]  00 00                    add     [bx+si],al
F000:7AB4  [+0x07AB4]  00 00                    add     [bx+si],al
F000:7AB6  [+0x07AB6]  00 00                    add     [bx+si],al
F000:7AB8  [+0x07AB8]  00 1F                    add     [bx],bl
F000:7ABA  [+0x07ABA]  18 1F                    sbb     [bx],bl
F000:7ABC  [+0x07ABC]  18 18                    sbb     [bx+si],bl
F000:7ABE  [+0x07ABE]  18 18                    sbb     [bx+si],bl
F000:7AC0  [+0x07AC0]  18 18                    sbb     [bx+si],bl
F000:7AC2  [+0x07AC2]  18 18                    sbb     [bx+si],bl
F000:7AC4  [+0x07AC4]  00 00                    add     [bx+si],al
F000:7AC6  [+0x07AC6]  00 00                    add     [bx+si],al
F000:7AC8  [+0x07AC8]  00 00                    add     [bx+si],al
F000:7ACA  [+0x07ACA]  00 3F                    add     [bx],bh
F000:7ACC  [+0x07ACC]  DB 0x36  (bad)
F000:7ADB  [+0x07ADB]  FF 36 36 36              push    word [3636h]
F000:7ADF  [+0x07ADF]  36 36 36 36 36 18 18     sbb     [ss:bx+si],bl
F000:7AE6  [+0x07AE6]  18 18                    sbb     [bx+si],bl
F000:7AE8  [+0x07AE8]  18 FF                    sbb     bh,bh
F000:7AEA  [+0x07AEA]  18 FF                    sbb     bh,bh
F000:7AEC  [+0x07AEC]  18 18                    sbb     [bx+si],bl
F000:7AEE  [+0x07AEE]  18 18                    sbb     [bx+si],bl
F000:7AF0  [+0x07AF0]  18 18                    sbb     [bx+si],bl
F000:7AF2  [+0x07AF2]  18 18                    sbb     [bx+si],bl
F000:7AF4  [+0x07AF4]  18 18                    sbb     [bx+si],bl
F000:7AF6  [+0x07AF6]  18 18                    sbb     [bx+si],bl
F000:7AF8  [+0x07AF8]  18 18                    sbb     [bx+si],bl
F000:7AFA  [+0x07AFA]  18 F8                    sbb     al,bh
F000:7AFC  [+0x07AFC]  00 00                    add     [bx+si],al
F000:7AFE  [+0x07AFE]  00 00                    add     [bx+si],al
F000:7B00  [+0x07B00]  00 00                    add     [bx+si],al
F000:7B02  [+0x07B02]  00 00                    add     [bx+si],al
F000:7B04  [+0x07B04]  00 00                    add     [bx+si],al
F000:7B06  [+0x07B06]  00 00                    add     [bx+si],al
F000:7B08  [+0x07B08]  00 00                    add     [bx+si],al
F000:7B0A  [+0x07B0A]  00 1F                    add     [bx],bl
F000:7B0C  [+0x07B0C]  18 18                    sbb     [bx+si],bl
F000:7B0E  [+0x07B0E]  18 18                    sbb     [bx+si],bl
F000:7B10  [+0x07B10]  18 18                    sbb     [bx+si],bl
F000:7B12  [+0x07B12]  18 18                    sbb     [bx+si],bl
F000:7B14  [+0x07B14]  DB 0xFF  (bad)
F000:7B16  [+0x07B16]  DB 0xFF  (bad)
F000:7B18  [+0x07B18]  DB 0xFF  (bad)
F000:7B1A  [+0x07B1A]  DB 0xFF  (bad)
F000:7B1C  [+0x07B1C]  DB 0xFF  (bad)
F000:7B1E  [+0x07B1E]  DB 0xFF  (bad)
F000:7B20  [+0x07B20]  DB 0xFF  (bad)
F000:7B22  [+0x07B22]  DB 0xFF  (bad)
F000:7B24  [+0x07B24]  00 00                    add     [bx+si],al
F000:7B26  [+0x07B26]  00 00                    add     [bx+si],al
F000:7B28  [+0x07B28]  00 00                    add     [bx+si],al
F000:7B2A  [+0x07B2A]  00 FF                    add     bh,bh
F000:7B2C  [+0x07B2C]  DB 0xFF  (bad)
F000:7B2E  [+0x07B2E]  DB 0xFF  (bad)
F000:7B30  [+0x07B30]  DB 0xFF  (bad)
F000:7B32  [+0x07B32]  DB 0xFF  (bad)
F000:7B34  [+0x07B34]  DB 0xF0  (bad)
F000:7B43  [+0x07B43]  DB 0xF0  (bad)
F000:7B48  [+0x07B48]  DB 0x0F  (bad)
F000:7B4C  [+0x07B4C]  DB 0x0F  (bad)
F000:7B50  [+0x07B50]  DB 0x0F  (bad)
F000:7B54  [+0x07B54]  DB 0xFF  (bad)
F000:7B56  [+0x07B56]  DB 0xFF  (bad)
F000:7B58  [+0x07B58]  DB 0xFF  (bad)
F000:7B5A  [+0x07B5A]  FF 00                    inc     word [bx+si]
F000:7B5C  [+0x07B5C]  00 00                    add     [bx+si],al
F000:7B5E  [+0x07B5E]  00 00                    add     [bx+si],al
F000:7B60  [+0x07B60]  00 00                    add     [bx+si],al
F000:7B62  [+0x07B62]  00 00                    add     [bx+si],al
F000:7B64  [+0x07B64]  00 00                    add     [bx+si],al
F000:7B66  [+0x07B66]  00 00                    add     [bx+si],al
F000:7B68  [+0x07B68]  00 76 DC                 add     [bp-24h],dh
F000:7B6B  [+0x07B6B]  D8 D8                    fcomp   st0
F000:7B6D  [+0x07B6D]  D8 DC                    fcomp   st4
F000:7B6F  [+0x07B6F]  76 00                    jbe     short 7B71h
F000:7B71  [+0x07B71]  00 00                    add     [bx+si],al
F000:7B73  [+0x07B73]  00 00                    add     [bx+si],al
F000:7B75  [+0x07B75]  00 78 CC                 add     [bx+si-34h],bh
F000:7B78  [+0x07B78]  CC                       int3
F000:7B79  [+0x07B79]  CC                       int3
F000:7B7A  [+0x07B7A]  D8 CC                    fmul    st4
F000:7B7C  [+0x07B7C]  C6 C6 C6                 mov     dh,0C6h
F000:7B7F  [+0x07B7F]  CC                       int3
F000:7B80  [+0x07B80]  00 00                    add     [bx+si],al
F000:7B82  [+0x07B82]  00 00                    add     [bx+si],al
F000:7B84  [+0x07B84]  00 00                    add     [bx+si],al
F000:7B86  [+0x07B86]  FE C6                    inc     dh
F000:7B88  [+0x07B88]  C6 C0 C0                 mov     al,0C0h
F000:7B8B  [+0x07B8B]  C0 C0 C0                 rol     al,0C0h
F000:7B8E  [+0x07B8E]  C0 C0 00                 rol     al,0
F000:7B91  [+0x07B91]  00 00                    add     [bx+si],al
F000:7B93  [+0x07B93]  00 00                    add     [bx+si],al
F000:7B95  [+0x07B95]  00 00                    add     [bx+si],al
F000:7B97  [+0x07B97]  00 80 FE 6C              add     [bx+si+6CFEh],al
F000:7B9B  [+0x07B9B]  6C                       insb
F000:7B9C  [+0x07B9C]  6C                       insb
F000:7B9D  [+0x07B9D]  6C                       insb
F000:7B9E  [+0x07B9E]  6C                       insb
F000:7B9F  [+0x07B9F]  6C                       insb
F000:7BA0  [+0x07BA0]  00 00                    add     [bx+si],al
F000:7BA2  [+0x07BA2]  00 00                    add     [bx+si],al
F000:7BA4  [+0x07BA4]  00 00                    add     [bx+si],al
F000:7BA6  [+0x07BA6]  00 FE                    add     dh,bh
F000:7BA8  [+0x07BA8]  DB 0xC6  (bad)
F000:7BAA  [+0x07BAA]  30 18                    xor     [bx+si],bl
F000:7BAC  [+0x07BAC]  30 60 C6                 xor     [bx+si-3Ah],ah
F000:7BAF  [+0x07BAF]  FE 00                    inc     byte [bx+si]
F000:7BB1  [+0x07BB1]  00 00                    add     [bx+si],al
F000:7BB3  [+0x07BB3]  00 00                    add     [bx+si],al
F000:7BB5  [+0x07BB5]  00 00                    add     [bx+si],al
F000:7BB7  [+0x07BB7]  00 00                    add     [bx+si],al
F000:7BB9  [+0x07BB9]  7E D8                    jle     short 7B93h
F000:7BBB  [+0x07BBB]  D8 D8                    fcomp   st0
F000:7BBD  [+0x07BBD]  D8 D8                    fcomp   st0
F000:7BBF  [+0x07BBF]  70 00                    jo      short 7BC1h
F000:7BC1  [+0x07BC1]  00 00                    add     [bx+si],al
F000:7BC3  [+0x07BC3]  00 00                    add     [bx+si],al
F000:7BC5  [+0x07BC5]  00 00                    add     [bx+si],al
F000:7BC7  [+0x07BC7]  00 66 66                 add     [bp+66h],ah
F000:7BCA  [+0x07BCA]  66 66 66 7C 60           o32 jl  short 00007C2Fh
F000:7BCF  [+0x07BCF]  60                       pusha
F000:7BD0  [+0x07BD0]  C0 00 00                 rol     byte [bx+si],0
F000:7BD3  [+0x07BD3]  00 00                    add     [bx+si],al
F000:7BD5  [+0x07BD5]  00 00                    add     [bx+si],al
F000:7BD7  [+0x07BD7]  00 76 DC                 add     [bp-24h],dh
F000:7BDA  [+0x07BDA]  18 18                    sbb     [bx+si],bl
F000:7BDC  [+0x07BDC]  18 18                    sbb     [bx+si],bl
F000:7BDE  [+0x07BDE]  18 18                    sbb     [bx+si],bl
F000:7BE0  [+0x07BE0]  00 00                    add     [bx+si],al
F000:7BE2  [+0x07BE2]  00 00                    add     [bx+si],al
F000:7BE4  [+0x07BE4]  00 00                    add     [bx+si],al
F000:7BE6  [+0x07BE6]  00 7E 18                 add     [bp+18h],bh
F000:7BE9  [+0x07BE9]  3C 66                    cmp     al,66h
F000:7BEB  [+0x07BEB]  66 66 3C 18              cmp     al,18h
F000:7BEF  [+0x07BEF]  7E 00                    jle     short 7BF1h
F000:7BF1  [+0x07BF1]  00 00                    add     [bx+si],al
F000:7BF3  [+0x07BF3]  00 00                    add     [bx+si],al
F000:7BF5  [+0x07BF5]  00 00                    add     [bx+si],al
F000:7BF7  [+0x07BF7]  38 6C C6                 cmp     [si-3Ah],ch
F000:7BFA  [+0x07BFA]  DB 0xC6  (bad)
F000:7BFC  [+0x07BFC]  C6 C6 6C                 mov     dh,6Ch
F000:7BFF  [+0x07BFF]  38 00                    cmp     [bx+si],al
F000:7C01  [+0x07C01]  00 00                    add     [bx+si],al
F000:7C03  [+0x07C03]  00 00                    add     [bx+si],al
F000:7C05  [+0x07C05]  00 38                    add     [bx+si],bh
F000:7C07  [+0x07C07]  6C                       insb
F000:7C08  [+0x07C08]  C6 C6 C6                 mov     dh,0C6h
F000:7C0B  [+0x07C0B]  6C                       insb
F000:7C0C  [+0x07C0C]  6C                       insb
F000:7C0D  [+0x07C0D]  6C                       insb
F000:7C0E  [+0x07C0E]  6C                       insb
F000:7C0F  [+0x07C0F]  EE                       out     dx,al
F000:7C10  [+0x07C10]  00 00                    add     [bx+si],al
F000:7C12  [+0x07C12]  00 00                    add     [bx+si],al
F000:7C14  [+0x07C14]  00 00                    add     [bx+si],al
F000:7C16  [+0x07C16]  1E                       push    ds
F000:7C17  [+0x07C17]  30 18                    xor     [bx+si],bl
F000:7C19  [+0x07C19]  0C 3E                    or      al,3Eh
F000:7C1B  [+0x07C1B]  66 66 66 66 3C 00        cmp     al,0
F000:7C21  [+0x07C21]  00 00                    add     [bx+si],al
F000:7C23  [+0x07C23]  00 00                    add     [bx+si],al
F000:7C25  [+0x07C25]  00 00                    add     [bx+si],al
F000:7C27  [+0x07C27]  00 00                    add     [bx+si],al
F000:7C29  [+0x07C29]  7E DB                    jle     short 7C06h
F000:7C2B  [+0x07C2B]  DB DB                    fcmovnu st3
F000:7C2D  [+0x07C2D]  7E 00                    jle     short 7C2Fh
F000:7C2F  [+0x07C2F]  00 00                    add     [bx+si],al
F000:7C31  [+0x07C31]  00 00                    add     [bx+si],al
F000:7C33  [+0x07C33]  00 00                    add     [bx+si],al
F000:7C35  [+0x07C35]  00 00                    add     [bx+si],al
F000:7C37  [+0x07C37]  03 06 7E CF              add     ax,[0CF7Eh]
F000:7C3B  [+0x07C3B]  DB F3                    fcomi   st3
F000:7C3D  [+0x07C3D]  7E 60                    jle     short 7C9Fh
F000:7C3F  [+0x07C3F]  C0 00 00                 rol     byte [bx+si],0
F000:7C42  [+0x07C42]  00 00                    add     [bx+si],al
F000:7C44  [+0x07C44]  00 00                    add     [bx+si],al
F000:7C46  [+0x07C46]  1C 30                    sbb     al,30h
F000:7C48  [+0x07C48]  60                       pusha
F000:7C49  [+0x07C49]  60                       pusha
F000:7C4A  [+0x07C4A]  7C 60                    jl      short 7CACh
F000:7C4C  [+0x07C4C]  60                       pusha
F000:7C4D  [+0x07C4D]  60                       pusha
F000:7C4E  [+0x07C4E]  30 1C                    xor     [si],bl
F000:7C50  [+0x07C50]  00 00                    add     [bx+si],al
F000:7C52  [+0x07C52]  00 00                    add     [bx+si],al
F000:7C54  [+0x07C54]  00 00                    add     [bx+si],al
F000:7C56  [+0x07C56]  00 7C C6                 add     [si-3Ah],bh
F000:7C59  [+0x07C59]  C6 C6 C6                 mov     dh,0C6h
F000:7C5C  [+0x07C5C]  C6 C6 C6                 mov     dh,0C6h
F000:7C5F  [+0x07C5F]  C6 00 00                 mov     byte [bx+si],0
F000:7C62  [+0x07C62]  00 00                    add     [bx+si],al
F000:7C64  [+0x07C64]  00 00                    add     [bx+si],al
F000:7C66  [+0x07C66]  00 00                    add     [bx+si],al
F000:7C68  [+0x07C68]  FE 00                    inc     byte [bx+si]
F000:7C6A  [+0x07C6A]  00 FE                    add     dh,bh
F000:7C6C  [+0x07C6C]  00 00                    add     [bx+si],al
F000:7C6E  [+0x07C6E]  FE 00                    inc     byte [bx+si]
F000:7C70  [+0x07C70]  00 00                    add     [bx+si],al
F000:7C72  [+0x07C72]  00 00                    add     [bx+si],al
F000:7C74  [+0x07C74]  00 00                    add     [bx+si],al
F000:7C76  [+0x07C76]  00 00                    add     [bx+si],al
F000:7C78  [+0x07C78]  18 18                    sbb     [bx+si],bl
F000:7C7A  [+0x07C7A]  7E 18                    jle     short 7C94h
F000:7C7C  [+0x07C7C]  18 00                    sbb     [bx+si],al
F000:7C7E  [+0x07C7E]  00 FF                    add     bh,bh
F000:7C80  [+0x07C80]  00 00                    add     [bx+si],al
F000:7C82  [+0x07C82]  00 00                    add     [bx+si],al
F000:7C84  [+0x07C84]  00 00                    add     [bx+si],al
F000:7C86  [+0x07C86]  00 30                    add     [bx+si],dh
F000:7C88  [+0x07C88]  18 0C                    sbb     [si],cl
F000:7C8A  [+0x07C8A]  06                       push    es
F000:7C8B  [+0x07C8B]  0C 18                    or      al,18h
F000:7C8D  [+0x07C8D]  30 00                    xor     [bx+si],al
F000:7C8F  [+0x07C8F]  7E 00                    jle     short 7C91h
F000:7C91  [+0x07C91]  00 00                    add     [bx+si],al
F000:7C93  [+0x07C93]  00 00                    add     [bx+si],al
F000:7C95  [+0x07C95]  00 00                    add     [bx+si],al
F000:7C97  [+0x07C97]  0C 18                    or      al,18h
F000:7C99  [+0x07C99]  30 60 30                 xor     [bx+si+30h],ah
F000:7C9C  [+0x07C9C]  18 0C                    sbb     [si],cl
F000:7C9E  [+0x07C9E]  00 7E 00                 add     [bp],bh
F000:7CA1  [+0x07CA1]  00 00                    add     [bx+si],al
F000:7CA3  [+0x07CA3]  00 00                    add     [bx+si],al
F000:7CA5  [+0x07CA5]  00 0E 1B 1B              add     [1B1Bh],cl
F000:7CA9  [+0x07CA9]  18 18                    sbb     [bx+si],bl
F000:7CAB  [+0x07CAB]  18 18                    sbb     [bx+si],bl
F000:7CAD  [+0x07CAD]  18 18                    sbb     [bx+si],bl
F000:7CAF  [+0x07CAF]  18 18                    sbb     [bx+si],bl
F000:7CB1  [+0x07CB1]  18 18                    sbb     [bx+si],bl
F000:7CB3  [+0x07CB3]  18 18                    sbb     [bx+si],bl
F000:7CB5  [+0x07CB5]  18 18                    sbb     [bx+si],bl
F000:7CB7  [+0x07CB7]  18 18                    sbb     [bx+si],bl
F000:7CB9  [+0x07CB9]  18 18                    sbb     [bx+si],bl
F000:7CBB  [+0x07CBB]  18 D8                    sbb     al,bl
F000:7CBD  [+0x07CBD]  D8 D8                    fcomp   st0
F000:7CBF  [+0x07CBF]  70 00                    jo      short 7CC1h
F000:7CC1  [+0x07CC1]  00 00                    add     [bx+si],al
F000:7CC3  [+0x07CC3]  00 00                    add     [bx+si],al
F000:7CC5  [+0x07CC5]  00 00                    add     [bx+si],al
F000:7CC7  [+0x07CC7]  00 18                    add     [bx+si],bl
F000:7CC9  [+0x07CC9]  18 00                    sbb     [bx+si],al
F000:7CCB  [+0x07CCB]  7E 00                    jle     short 7CCDh
F000:7CCD  [+0x07CCD]  18 18                    sbb     [bx+si],bl
F000:7CCF  [+0x07CCF]  00 00                    add     [bx+si],al
F000:7CD1  [+0x07CD1]  00 00                    add     [bx+si],al
F000:7CD3  [+0x07CD3]  00 00                    add     [bx+si],al
F000:7CD5  [+0x07CD5]  00 00                    add     [bx+si],al
F000:7CD7  [+0x07CD7]  00 00                    add     [bx+si],al
F000:7CD9  [+0x07CD9]  76 DC                    jbe     short 7CB7h
F000:7CDB  [+0x07CDB]  00 76 DC                 add     [bp-24h],dh
F000:7CDE  [+0x07CDE]  00 00                    add     [bx+si],al
F000:7CE0  [+0x07CE0]  00 00                    add     [bx+si],al
F000:7CE2  [+0x07CE2]  00 00                    add     [bx+si],al
F000:7CE4  [+0x07CE4]  00 38                    add     [bx+si],bh
F000:7CE6  [+0x07CE6]  6C                       insb
F000:7CE7  [+0x07CE7]  6C                       insb
F000:7CE8  [+0x07CE8]  38 00                    cmp     [bx+si],al
F000:7CEA  [+0x07CEA]  00 00                    add     [bx+si],al
F000:7CEC  [+0x07CEC]  00 00                    add     [bx+si],al
F000:7CEE  [+0x07CEE]  00 00                    add     [bx+si],al
F000:7CF0  [+0x07CF0]  00 00                    add     [bx+si],al
F000:7CF2  [+0x07CF2]  00 00                    add     [bx+si],al
F000:7CF4  [+0x07CF4]  00 00                    add     [bx+si],al
F000:7CF6  [+0x07CF6]  00 00                    add     [bx+si],al
F000:7CF8  [+0x07CF8]  00 00                    add     [bx+si],al
F000:7CFA  [+0x07CFA]  00 18                    add     [bx+si],bl
F000:7CFC  [+0x07CFC]  18 00                    sbb     [bx+si],al
F000:7CFE  [+0x07CFE]  00 00                    add     [bx+si],al
F000:7D00  [+0x07D00]  00 00                    add     [bx+si],al
F000:7D02  [+0x07D02]  00 00                    add     [bx+si],al
F000:7D04  [+0x07D04]  00 00                    add     [bx+si],al
F000:7D06  [+0x07D06]  00 00                    add     [bx+si],al
F000:7D08  [+0x07D08]  00 00                    add     [bx+si],al
F000:7D0A  [+0x07D0A]  00 00                    add     [bx+si],al
F000:7D0C  [+0x07D0C]  18 00                    sbb     [bx+si],al
F000:7D0E  [+0x07D0E]  00 00                    add     [bx+si],al
F000:7D10  [+0x07D10]  00 00                    add     [bx+si],al
F000:7D12  [+0x07D12]  00 00                    add     [bx+si],al
F000:7D14  [+0x07D14]  00 0F                    add     [bx],cl
F000:7D16  [+0x07D16]  0C 0C                    or      al,0Ch
F000:7D18  [+0x07D18]  0C 0C                    or      al,0Ch
F000:7D1A  [+0x07D1A]  0C EC                    or      al,0ECh
F000:7D1C  [+0x07D1C]  6C                       insb
F000:7D1D  [+0x07D1D]  6C                       insb
F000:7D1E  [+0x07D1E]  3C 1C                    cmp     al,1Ch
F000:7D20  [+0x07D20]  00 00                    add     [bx+si],al
F000:7D22  [+0x07D22]  00 00                    add     [bx+si],al
F000:7D24  [+0x07D24]  00 D8                    add     al,bl
F000:7D26  [+0x07D26]  6C                       insb
F000:7D27  [+0x07D27]  6C                       insb
F000:7D28  [+0x07D28]  6C                       insb
F000:7D29  [+0x07D29]  6C                       insb
F000:7D2A  [+0x07D2A]  6C                       insb
F000:7D2B  [+0x07D2B]  00 00                    add     [bx+si],al
F000:7D2D  [+0x07D2D]  00 00                    add     [bx+si],al
F000:7D2F  [+0x07D2F]  00 00                    add     [bx+si],al
F000:7D31  [+0x07D31]  00 00                    add     [bx+si],al
F000:7D33  [+0x07D33]  00 00                    add     [bx+si],al
F000:7D35  [+0x07D35]  70 98                    jo      short 7CCFh
F000:7D37  [+0x07D37]  30 60 C8                 xor     [bx+si-38h],ah
F000:7D3A  [+0x07D3A]  F8                       clc
F000:7D3B  [+0x07D3B]  00 00                    add     [bx+si],al
F000:7D3D  [+0x07D3D]  00 00                    add     [bx+si],al
F000:7D3F  [+0x07D3F]  00 00                    add     [bx+si],al
F000:7D41  [+0x07D41]  00 00                    add     [bx+si],al
F000:7D43  [+0x07D43]  00 00                    add     [bx+si],al
F000:7D45  [+0x07D45]  00 00                    add     [bx+si],al
F000:7D47  [+0x07D47]  00 7C 7C                 add     [si+7Ch],bh
F000:7D4A  [+0x07D4A]  7C 7C                    jl      short 7DC8h
F000:7D4C  [+0x07D4C]  7C 7C                    jl      short 7DCAh
F000:7D4E  [+0x07D4E]  7C 00                    jl      short 7D50h
F000:7D50  [+0x07D50]  00 00                    add     [bx+si],al
F000:7D52  [+0x07D52]  00 00                    add     [bx+si],al
F000:7D54  [+0x07D54]  00 00                    add     [bx+si],al
F000:7D56  [+0x07D56]  00 00                    add     [bx+si],al
F000:7D58  [+0x07D58]  00 00                    add     [bx+si],al
F000:7D5A  [+0x07D5A]  00 00                    add     [bx+si],al
F000:7D5C  [+0x07D5C]  00 00                    add     [bx+si],al
F000:7D5E  [+0x07D5E]  00 00                    add     [bx+si],al
F000:7D60  [+0x07D60]  00 00                    add     [bx+si],al
F000:7D62  [+0x07D62]  00 00                    add     [bx+si],al
F000:7D64  [+0x07D64]  1D 00 00                 sbb     ax,0
F000:7D67  [+0x07D67]  00 00                    add     [bx+si],al
F000:7D69  [+0x07D69]  00 24                    add     [si],ah
F000:7D6B  [+0x07D6B]  66 FF 66 24              jmp     dword [bp+24h]
F000:7D6F  [+0x07D6F]  00 00                    add     [bx+si],al
F000:7D71  [+0x07D71]  00 00                    add     [bx+si],al
F000:7D73  [+0x07D73]  00 00                    add     [bx+si],al
F000:7D75  [+0x07D75]  22 00                    and     al,[bx+si]
F000:7D77  [+0x07D77]  63 63 63                 arpl    [bp+di+63h],sp
F000:7D7A  [+0x07D7A]  22 00                    and     al,[bx+si]
F000:7D7C  [+0x07D7C]  00 00                    add     [bx+si],al
F000:7D7E  [+0x07D7E]  00 00                    add     [bx+si],al
F000:7D80  [+0x07D80]  00 00                    add     [bx+si],al
F000:7D82  [+0x07D82]  00 00                    add     [bx+si],al
F000:7D84  [+0x07D84]  00 00                    add     [bx+si],al
F000:7D86  [+0x07D86]  2B 00                    sub     ax,[bx+si]
F000:7D88  [+0x07D88]  00 00                    add     [bx+si],al
F000:7D8A  [+0x07D8A]  00 00                    add     [bx+si],al
F000:7D8C  [+0x07D8C]  18 18                    sbb     [bx+si],bl
F000:7D8E  [+0x07D8E]  FF 18                    call    far [bx+si]
F000:7D90  [+0x07D90]  18 00                    sbb     [bx+si],al
F000:7D92  [+0x07D92]  00 00                    add     [bx+si],al
F000:7D94  [+0x07D94]  00 00                    add     [bx+si],al
F000:7D96  [+0x07D96]  00 2D                    add     [di],ch
F000:7D98  [+0x07D98]  00 00                    add     [bx+si],al
F000:7D9A  [+0x07D9A]  00 00                    add     [bx+si],al
F000:7D9C  [+0x07D9C]  00 00                    add     [bx+si],al
F000:7D9E  [+0x07D9E]  00 FF                    add     bh,bh
F000:7DA0  [+0x07DA0]  00 00                    add     [bx+si],al
F000:7DA2  [+0x07DA2]  00 00                    add     [bx+si],al
F000:7DA4  [+0x07DA4]  00 00                    add     [bx+si],al
F000:7DA6  [+0x07DA6]  00 00                    add     [bx+si],al
F000:7DA8  [+0x07DA8]  4D                       dec     bp
F000:7DA9  [+0x07DA9]  00 00                    add     [bx+si],al
F000:7DAB  [+0x07DAB]  C3                       ret
F000:7DAC  [+0x07DAC]  E7 FF                    out     0FFh,ax
F000:7DAE  [+0x07DAE]  DB DB                    fcmovnu st3
F000:7DB0  [+0x07DB0]  C3                       ret
F000:7DB1  [+0x07DB1]  C3                       ret
F000:7DB2  [+0x07DB2]  C3                       ret
F000:7DB3  [+0x07DB3]  C3                       ret
F000:7DB4  [+0x07DB4]  C3                       ret
F000:7DB5  [+0x07DB5]  00 00                    add     [bx+si],al
F000:7DB7  [+0x07DB7]  00 00                    add     [bx+si],al
F000:7DB9  [+0x07DB9]  54                       push    sp
F000:7DBA  [+0x07DBA]  00 00                    add     [bx+si],al
F000:7DBC  [+0x07DBC]  DB 0xFF  (bad)
F000:7DBE  [+0x07DBE]  99                       cwd
F000:7DBF  [+0x07DBF]  18 18                    sbb     [bx+si],bl
F000:7DC1  [+0x07DC1]  18 18                    sbb     [bx+si],bl
F000:7DC3  [+0x07DC3]  18 18                    sbb     [bx+si],bl
F000:7DC5  [+0x07DC5]  3C 00                    cmp     al,0
F000:7DC7  [+0x07DC7]  00 00                    add     [bx+si],al
F000:7DC9  [+0x07DC9]  00 57 00                 add     [bx],dl
F000:7DCC  [+0x07DCC]  00 C3                    add     bl,al
F000:7DCE  [+0x07DCE]  C3                       ret
F000:7DCF  [+0x07DCF]  C3                       ret
F000:7DD0  [+0x07DD0]  C3                       ret
F000:7DD1  [+0x07DD1]  C3                       ret
F000:7DD2  [+0x07DD2]  DB DB                    fcmovnu st3
F000:7DD4  [+0x07DD4]  FF 66 66                 jmp     word [bp+66h]
F000:7DD7  [+0x07DD7]  00 00                    add     [bx+si],al
F000:7DD9  [+0x07DD9]  00 00                    add     [bx+si],al
F000:7DDB  [+0x07DDB]  5A                       pop     dx
F000:7DDC  [+0x07DDC]  00 00                    add     [bx+si],al
F000:7DDE  [+0x07DDE]  FF C3                    inc     bx
F000:7DE0  [+0x07DE0]  83 06 0C 18 30           add     word [180Ch],30h
F000:7DE5  [+0x07DE5]  61                       popa
F000:7DE6  [+0x07DE6]  C3                       ret
F000:7DE7  [+0x07DE7]  FF 00                    inc     word [bx+si]
F000:7DE9  [+0x07DE9]  00 00                    add     [bx+si],al
F000:7DEB  [+0x07DEB]  00 5B 00                 add     [bp+di],bl
F000:7DEE  [+0x07DEE]  00 3E 30 30              add     [3030h],bh
F000:7DF2  [+0x07DF2]  30 30                    xor     [bx+si],dh
F000:7DF4  [+0x07DF4]  30 30                    xor     [bx+si],dh
F000:7DF6  [+0x07DF6]  30 30                    xor     [bx+si],dh
F000:7DF8  [+0x07DF8]  3E 00 00                 add     [bx+si],al
F000:7DFB  [+0x07DFB]  00 00                    add     [bx+si],al
F000:7DFD  [+0x07DFD]  5D                       pop     bp
F000:7DFE  [+0x07DFE]  00 00                    add     [bx+si],al
F000:7E00  [+0x07E00]  3E 06                    push    es
F000:7E02  [+0x07E02]  06                       push    es
F000:7E03  [+0x07E03]  06                       push    es
F000:7E04  [+0x07E04]  06                       push    es
F000:7E05  [+0x07E05]  06                       push    es
F000:7E06  [+0x07E06]  06                       push    es
F000:7E07  [+0x07E07]  06                       push    es
F000:7E08  [+0x07E08]  06                       push    es
F000:7E09  [+0x07E09]  3E 00 00                 add     [bx+si],al
F000:7E0C  [+0x07E0C]  00 00                    add     [bx+si],al
F000:7E0E  [+0x07E0E]  6D                       insw
F000:7E0F  [+0x07E0F]  00 00                    add     [bx+si],al
F000:7E11  [+0x07E11]  00 00                    add     [bx+si],al
F000:7E13  [+0x07E13]  00 E6                    add     dh,ah
F000:7E15  [+0x07E15]  DB 0xFF  (bad)
F000:7E17  [+0x07E17]  DB DB                    fcmovnu st3
F000:7E19  [+0x07E19]  DB DB                    fcmovnu st3
F000:7E1B  [+0x07E1B]  00 00                    add     [bx+si],al
F000:7E1D  [+0x07E1D]  00 00                    add     [bx+si],al
F000:7E1F  [+0x07E1F]  77 00                    ja      short 7E21h
F000:7E21  [+0x07E21]  00 00                    add     [bx+si],al
F000:7E23  [+0x07E23]  00 00                    add     [bx+si],al
F000:7E25  [+0x07E25]  C3                       ret
F000:7E26  [+0x07E26]  C3                       ret
F000:7E27  [+0x07E27]  C3                       ret
F000:7E28  [+0x07E28]  DB DB                    fcmovnu st3
F000:7E2A  [+0x07E2A]  FF 66 00                 jmp     word [bp]
F000:7E2D  [+0x07E2D]  00 00                    add     [bx+si],al
F000:7E2F  [+0x07E2F]  00 91 00 00              add     [bx+di],dl
F000:7E33  [+0x07E33]  00 00                    add     [bx+si],al
F000:7E35  [+0x07E35]  00 6E 3B                 add     [bp+3Bh],ch
F000:7E38  [+0x07E38]  1B 7E D8                 sbb     di,[bp-28h]
F000:7E3B  [+0x07E3B]  DC 77 00                 fdiv    qword [bx]
F000:7E3E  [+0x07E3E]  00 00                    add     [bx+si],al
F000:7E40  [+0x07E40]  00 9D 00 00              add     [di],bl
F000:7E44  [+0x07E44]  C3                       ret
F000:7E45  [+0x07E45]  66 3C 18                 cmp     al,18h
F000:7E48  [+0x07E48]  7E 18                    jle     short 7E62h
F000:7E4A  [+0x07E4A]  7E 18                    jle     short 7E64h
F000:7E4C  [+0x07E4C]  18 18                    sbb     [bx+si],bl
F000:7E4E  [+0x07E4E]  00 00                    add     [bx+si],al
F000:7E50  [+0x07E50]  00 00                    add     [bx+si],al
F000:7E52  [+0x07E52]  9E                       sahf
F000:7E53  [+0x07E53]  00 FC                    add     ah,bh
F000:7E55  [+0x07E55]  66 66 7C 62              o32 jl  short 00007EBBh
F000:7E59  [+0x07E59]  66 6F                    outsd
F000:7E5B  [+0x07E5B]  66 66 66 F3 00 00        add     [bx+si],al
F000:7E61  [+0x07E61]  00 00                    add     [bx+si],al
F000:7E63  [+0x07E63]  F1                       int1
F000:7E64  [+0x07E64]  00 00                    add     [bx+si],al
F000:7E66  [+0x07E66]  00 00                    add     [bx+si],al
F000:7E68  [+0x07E68]  18 18                    sbb     [bx+si],bl
F000:7E6A  [+0x07E6A]  FF 18                    call    far [bx+si]
F000:7E6C  [+0x07E6C]  18 00                    sbb     [bx+si],al
F000:7E6E  [+0x07E6E]  00 FF                    add     bh,bh
F000:7E70  [+0x07E70]  00 00                    add     [bx+si],al
F000:7E72  [+0x07E72]  00 00                    add     [bx+si],al
F000:7E74  [+0x07E74]  F6 00 00                 test    byte [bx+si],0
F000:7E77  [+0x07E77]  00 00                    add     [bx+si],al
F000:7E79  [+0x07E79]  18 18                    sbb     [bx+si],bl
F000:7E7B  [+0x07E7B]  00 FF                    add     bh,bh
F000:7E7D  [+0x07E7D]  00 18                    add     [bx+si],bl
F000:7E7F  [+0x07E7F]  18 00                    sbb     [bx+si],al
F000:7E81  [+0x07E81]  00 00                    add     [bx+si],al
F000:7E83  [+0x07E83]  00 00                    add     [bx+si],al
F000:7E85  [+0x07E85]  00 10                    add     [bx+si],dl
F000:7E87  [+0x07E87]  01 08                    add     [bx+si],cx
F000:7E89  [+0x07E89]  00 00                    add     [bx+si],al
F000:7E8B  [+0x07E8B]  00 00                    add     [bx+si],al
F000:7E8D  [+0x07E8D]  01 00                    add     [bx+si],ax
F000:7E8F  [+0x07E8F]  02 02                    add     al,[bp+si]
F000:7E91  [+0x07E91]  01 00                    add     [bx+si],ax
F000:7E93  [+0x07E93]  04 04                    add     al,4
F000:7E95  [+0x07E95]  01 00                    add     [bx+si],ax
F000:7E97  [+0x07E97]  05 02 05                 add     ax,502h
F000:7E9A  [+0x07E9A]  00 06 01 06              add     [601h],al
F000:7E9E  [+0x07E9E]  05 06 00                 add     ax,6
F000:7EA1  [+0x07EA1]  08 01                    or      [bx+di],al
F000:7EA3  [+0x07EA3]  08 00                    or      [bx+si],al
F000:7EA5  [+0x07EA5]  07                       pop     es
F000:7EA6  [+0x07EA6]  02 07                    add     al,[bx]
F000:7EA8  [+0x07EA8]  06                       push    es
F000:7EA9  [+0x07EA9]  07                       pop     es
F000:7EAA  [+0x07EAA]  FF E0                    jmp     ax
F000:7EAC  [+0x07EAC]  0F 00 00                 sldt    [bx+si]
F000:7EAF  [+0x07EAF]  00 00                    add     [bx+si],al
F000:7EB1  [+0x07EB1]  07                       pop     es
F000:7EB2  [+0x07EB2]  02 08                    add     cl,[bx+si]
F000:7EB4  [+0x07EB4]  FF 0E 00 00              dec     word [0]
F000:7EB8  [+0x07EB8]  3F                       aas
F000:7EB9  [+0x07EB9]  00 00                    add     [bx+si],al
F000:7EBB  [+0x07EBB]  00 2A                    add     [bp+si],ch
F000:7EBD  [+0x07EBD]  00 00                    add     [bx+si],al
F000:7EBF  [+0x07EBF]  6A 2A                    push    2Ah
F000:7EC1  [+0x07EC1]  2A 15                    sub     dl,[di]
F000:7EC3  [+0x07EC3]  15 3F 15                 adc     ax,153Fh
F000:7EC6  [+0x07EC6]  15 3F 3F                 adc     ax,3F3Fh
F000:7EC9  [+0x07EC9]  3F                       aas
F000:7ECA  [+0x07ECA]  00 2A                    add     [bp+si],ch
F000:7ECC  [+0x07ECC]  15 3F 00                 adc     ax,3Fh
F000:7ECF  [+0x07ECF]  05 11 1C                 add     ax,1C11h
F000:7ED2  [+0x07ED2]  08 0B                    or      [bp+di],cl
F000:7ED4  [+0x07ED4]  14 28                    adc     al,28h
F000:7ED6  [+0x07ED6]  0E                       push    cs
F000:7ED7  [+0x07ED7]  18 2D                    sbb     [di],ch
F000:7ED9  [+0x07ED9]  32 20                    xor     ah,[bx+si]
F000:7EDB  [+0x07EDB]  24 38                    and     al,38h
F000:7EDD  [+0x07EDD]  3F                       aas
F000:7EDE  [+0x07EDE]  00 00                    add     [bx+si],al
F000:7EE0  [+0x07EE0]  2A 00                    sub     al,[bx+si]
F000:7EE2  [+0x07EE2]  00 2A                    add     [bp+si],ch
F000:7EE4  [+0x07EE4]  2A 2A                    sub     ch,[bp+si]
F000:7EE6  [+0x07EE6]  15 00 3F                 adc     ax,3F00h
F000:7EE9  [+0x07EE9]  00 15                    add     [di],dl
F000:7EEB  [+0x07EEB]  2A 3F                    sub     bh,[bx]
F000:7EED  [+0x07EED]  2A 00                    sub     al,[bx+si]
F000:7EEF  [+0x07EEF]  15 2A 15                 adc     ax,152Ah
F000:7EF2  [+0x07EF2]  00 3F                    add     [bx],bh
F000:7EF4  [+0x07EF4]  2A 3F                    sub     bh,[bx]
F000:7EF6  [+0x07EF6]  15 15 3F                 adc     ax,3F15h
F000:7EF9  [+0x07EF9]  15 15 3F                 adc     ax,3F15h
F000:7EFC  [+0x07EFC]  3F                       aas
F000:7EFD  [+0x07EFD]  3F                       aas
F000:7EFE  [+0x07EFE]  00 2A                    add     [bp+si],ch
F000:7F00  [+0x07F00]  15 3F 00                 adc     ax,3Fh
F000:7F03  [+0x07F03]  05 11 1C                 add     ax,1C11h
F000:7F06  [+0x07F06]  08 0B                    or      [bp+di],cl
F000:7F08  [+0x07F08]  25 28 02                 and     ax,228h
F000:7F0B  [+0x07F0B]  07                       pop     es
F000:7F0C  [+0x07F0C]  1B 20                    sbb     sp,[bx+si]
F000:7F0E  [+0x07F0E]  0F 14 28                 unpcklps xmm5,[bx+si]
F000:7F11  [+0x07F11]  2C 0C                    sub     al,0Ch
F000:7F13  [+0x07F13]  11 25                    adc     [di],sp
F000:7F15  [+0x07F15]  2A 14                    sub     dl,[si]
F000:7F17  [+0x07F17]  1E                       push    ds
F000:7F18  [+0x07F18]  32 36 0F 13              xor     dh,[130Fh]
F000:7F1C  [+0x07F1C]  27                       daa
F000:7F1D  [+0x07F1D]  2C 1B                    sub     al,1Bh
F000:7F1F  [+0x07F1F]  20 34                    and     [si],dh
F000:7F21  [+0x07F21]  39 06 0B 1F              cmp     [1F0Bh],ax
F000:7F25  [+0x07F25]  24 13                    and     al,13h
F000:7F27  [+0x07F27]  18 2C                    sbb     [si],ch
F000:7F29  [+0x07F29]  30 09                    xor     [bx+di],cl
F000:7F2B  [+0x07F2B]  0D 21 26                 or      ax,2621h
F000:7F2E  [+0x07F2E]  15 1A 2E                 adc     ax,2E1Ah
F000:7F31  [+0x07F31]  33 13                    xor     dx,[bp+di]
F000:7F33  [+0x07F33]  17                       pop     ss
F000:7F34  [+0x07F34]  2B 30                    sub     si,[bx+si]
F000:7F36  [+0x07F36]  1F                       pop     ds
F000:7F37  [+0x07F37]  24 38                    and     al,38h
F000:7F39  [+0x07F39]  3D 0E 18                 cmp     ax,180Eh
F000:7F3C  [+0x07F3C]  2D 32 20                 sub     ax,2032h
F000:7F3F  [+0x07F3F]  24 38                    and     al,38h
F000:7F41  [+0x07F41]  3F                       aas
F000:7F42  [+0x07F42]  00 2A                    add     [bp+si],ch
F000:7F44  [+0x07F44]  00 3F                    add     [bx],bh
F000:7F46  [+0x07F46]  00 2A                    add     [bp+si],ch
F000:7F48  [+0x07F48]  00 3F                    add     [bx],bh
F000:7F4A  [+0x07F4A]  00 05                    add     [di],al
F000:7F4C  [+0x07F4C]  08 0B                    or      [bp+di],cl
F000:7F4E  [+0x07F4E]  0E                       push    cs
F000:7F4F  [+0x07F4F]  11 14                    adc     [si],dx
F000:7F51  [+0x07F51]  18 1C                    sbb     [si],bl
F000:7F53  [+0x07F53]  20 24                    and     [si],ah
F000:7F55  [+0x07F55]  28 2D                    sub     [di],ch
F000:7F57  [+0x07F57]  32 38                    xor     bh,[bx+si]
F000:7F59  [+0x07F59]  3F                       aas
F000:7F5A  [+0x07F5A]  00 10                    add     [bx+si],dl
F000:7F5C  [+0x07F5C]  1F                       pop     ds
F000:7F5D  [+0x07F5D]  2F                       das
F000:7F5E  [+0x07F5E]  3F                       aas
F000:7F5F  [+0x07F5F]  1F                       pop     ds
F000:7F60  [+0x07F60]  27                       daa
F000:7F61  [+0x07F61]  2F                       das
F000:7F62  [+0x07F62]  37                       aaa
F000:7F63  [+0x07F63]  3F                       aas
F000:7F64  [+0x07F64]  2D 31 36                 sub     ax,3631h
F000:7F67  [+0x07F67]  3A 3F                    cmp     bh,[bx]
F000:7F69  [+0x07F69]  00 07                    add     [bx],al
F000:7F6B  [+0x07F6B]  0E                       push    cs
F000:7F6C  [+0x07F6C]  15 1C 0E                 adc     ax,0E1Ch
F000:7F6F  [+0x07F6F]  11 15                    adc     [di],dx
F000:7F71  [+0x07F71]  18 1C                    sbb     [si],bl
F000:7F73  [+0x07F73]  14 16                    adc     al,16h
F000:7F75  [+0x07F75]  18 1A                    sbb     [bp+si],bl
F000:7F77  [+0x07F77]  1C 00                    sbb     al,0
F000:7F79  [+0x07F79]  04 08                    add     al,8
F000:7F7B  [+0x07F7B]  0C 10                    or      al,10h
F000:7F7D  [+0x07F7D]  08 0A                    or      [bp+si],cl
F000:7F7F  [+0x07F7F]  0C 0E                    or      al,0Eh
F000:7F81  [+0x07F81]  10 0B                    adc     [bp+di],cl
F000:7F83  [+0x07F83]  0C 0D                    or      al,0Dh
F000:7F85  [+0x07F85]  0F 10 00                 movups  xmm0,[bx+si]
F000:7F88  [+0x07F88]  00 00                    add     [bx+si],al
F000:7F8A  [+0x07F8A]  00 00                    add     [bx+si],al
F000:7F8C  [+0x07F8C]  00 00                    add     [bx+si],al
F000:7F8E  [+0x07F8E]  00 00                    add     [bx+si],al
F000:7F90  [+0x07F90]  00 00                    add     [bx+si],al
F000:7F92  [+0x07F92]  00 00                    add     [bx+si],al
F000:7F94  [+0x07F94]  00 00                    add     [bx+si],al
F000:7F96  [+0x07F96]  00 00                    add     [bx+si],al
F000:7F98  [+0x07F98]  00 00                    add     [bx+si],al
F000:7F9A  [+0x07F9A]  00 00                    add     [bx+si],al
F000:7F9C  [+0x07F9C]  00 00                    add     [bx+si],al
F000:7F9E  [+0x07F9E]  00 00                    add     [bx+si],al
F000:7FA0  [+0x07FA0]  00 00                    add     [bx+si],al
F000:7FA2  [+0x07FA2]  00 00                    add     [bx+si],al
F000:7FA4  [+0x07FA4]  00 00                    add     [bx+si],al
F000:7FA6  [+0x07FA6]  00 00                    add     [bx+si],al
F000:7FA8  [+0x07FA8]  00 00                    add     [bx+si],al
F000:7FAA  [+0x07FAA]  00 00                    add     [bx+si],al
F000:7FAC  [+0x07FAC]  00 00                    add     [bx+si],al
F000:7FAE  [+0x07FAE]  00 00                    add     [bx+si],al
F000:7FB0  [+0x07FB0]  00 00                    add     [bx+si],al
F000:7FB2  [+0x07FB2]  00 00                    add     [bx+si],al
F000:7FB4  [+0x07FB4]  00 00                    add     [bx+si],al
F000:7FB6  [+0x07FB6]  00 00                    add     [bx+si],al
F000:7FB8  [+0x07FB8]  00 00                    add     [bx+si],al
F000:7FBA  [+0x07FBA]  00 00                    add     [bx+si],al
F000:7FBC  [+0x07FBC]  00 00                    add     [bx+si],al
F000:7FBE  [+0x07FBE]  00 00                    add     [bx+si],al
F000:7FC0  [+0x07FC0]  00 00                    add     [bx+si],al
F000:7FC2  [+0x07FC2]  00 00                    add     [bx+si],al
F000:7FC4  [+0x07FC4]  00 00                    add     [bx+si],al
F000:7FC6  [+0x07FC6]  00 00                    add     [bx+si],al
F000:7FC8  [+0x07FC8]  00 00                    add     [bx+si],al
F000:7FCA  [+0x07FCA]  00 00                    add     [bx+si],al
F000:7FCC  [+0x07FCC]  00 00                    add     [bx+si],al
F000:7FCE  [+0x07FCE]  00 00                    add     [bx+si],al
F000:7FD0  [+0x07FD0]  00 00                    add     [bx+si],al
F000:7FD2  [+0x07FD2]  00 00                    add     [bx+si],al
F000:7FD4  [+0x07FD4]  00 00                    add     [bx+si],al
F000:7FD6  [+0x07FD6]  00 00                    add     [bx+si],al
F000:7FD8  [+0x07FD8]  00 00                    add     [bx+si],al
F000:7FDA  [+0x07FDA]  00 00                    add     [bx+si],al
F000:7FDC  [+0x07FDC]  00 00                    add     [bx+si],al
F000:7FDE  [+0x07FDE]  00 00                    add     [bx+si],al
F000:7FE0  [+0x07FE0]  00 00                    add     [bx+si],al
F000:7FE2  [+0x07FE2]  00 00                    add     [bx+si],al
F000:7FE4  [+0x07FE4]  00 00                    add     [bx+si],al
F000:7FE6  [+0x07FE6]  00 00                    add     [bx+si],al
F000:7FE8  [+0x07FE8]  00 00                    add     [bx+si],al
F000:7FEA  [+0x07FEA]  00 00                    add     [bx+si],al
F000:7FEC  [+0x07FEC]  00 00                    add     [bx+si],al
F000:7FEE  [+0x07FEE]  00 00                    add     [bx+si],al
F000:7FF0  [+0x07FF0]  00 00                    add     [bx+si],al
F000:7FF2  [+0x07FF2]  00 00                    add     [bx+si],al
F000:7FF4  [+0x07FF4]  00 00                    add     [bx+si],al
F000:7FF6  [+0x07FF6]  00 00                    add     [bx+si],al
F000:7FF8  [+0x07FF8]  00 00                    add     [bx+si],al
F000:7FFA  [+0x07FFA]  00 00                    add     [bx+si],al
F000:7FFC  [+0x07FFC]  00 00                    add     [bx+si],al
F000:7FFE  [+0x07FFE]  00 D7                    add     bh,dl
