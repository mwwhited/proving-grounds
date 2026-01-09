    '                        PINFIRE VER. 2.0
    '
    '                 APRIL 8, 1988 BY CHRIS PAQUETTE
    '
    '           CORRECTS VER. 1.1 24-PIN AUTO-FIRING PROBLEM
    '
    '              ALSO IMPROVES SELECTION MENU OPERATION
    '
    '          PIN FIRING PROGRAM FOR PRINTER TROUBLESHOOTING
    '
    '
80 KEY OFF: WIDTH 40: COLOR 14, 8, 8: CLS
    X$ = CHR$(27) + "^" + CHR$(0) + CHR$(255) + CHR$(0)
    Z$ = CHR$(27) + "*" + CHR$(32) + CHR$(255) + CHR$(0)
    WIDTH "LPT1:", 255
    LOCATE 2, 13, 0: PRINT "PINFIRE Ver 2.0"
    LOCATE 4, 9, 0: PRINT "by CHRIS PAQUETTE  4/88"
    LOCATE 10, 5, 0: PRINT "Specify printer type..."
    LOCATE 13, 10, 0: PRINT "1)  9 PIN"
    LOCATE 15, 10, 0: PRINT "2) 24 PIN"
    LOCATE 22, 11, 0: COLOR 12: PRINT "Enter 'Q' to quit": COLOR 2
170 IN$ = INKEY$: IF IN$ = "" THEN 170
    IF IN$ = "q" OR IN$ = "Q" THEN 3000
    IF IN$ = "1" THEN 1000
    IF IN$ = "2" THEN 2000 ELSE 170
    '
    '
1000 CLS    '          9 PIN MENU ROUTINE
     '
     LOCATE 5, 2, 0: PRINT "Enter number of pin to fire (1-9)"
     LOCATE 6, 2, 0: PRINT "or press <RETURN> to cycle all pins."
     LOCATE 22, 11, 0: COLOR 12: PRINT "Enter 99 to exit.": COLOR 14
     LOCATE 8, 1, 0: INPUT PIN: IF PIN = 99 THEN GOTO 80
     IF PIN > 9 THEN GOTO 1000
     '
     CLS : LOCATE 10, 12, 0: PRINT "FIRING PIN(S).."
     IF PIN > 0 THEN GOSUB 1500 ELSE GOSUB 1300
     A = 0: B = 0: PIN = 0: ALL = 0
     GOTO 1000
1300 PIN = 1
     FOR ALL = 1 TO 9
     GOSUB 1500
     PIN = PIN + 1
     NEXT ALL
     RETURN
1500 A = 0: B = 0
     IF PIN = 9 THEN B = 128
     IF PIN = 8 THEN A = 1
     IF PIN = 7 THEN A = 2
     IF PIN = 6 THEN A = 4
     IF PIN = 5 THEN A = 8
     IF PIN = 4 THEN A = 16
     IF PIN = 3 THEN A = 32
     IF PIN = 2 THEN A = 64
     IF PIN = 1 THEN A = 128
     IF PIN = 1 THEN A = 128
     '
     '                          9 PIN FIRING ROUTINE
     '
     LPRINT TAB(8); "FIRING PIN "; PIN; " ==> ",
     LPRINT "["; X$;
     FOR DO1 = 1 TO 255
     LPRINT CHR$(A); CHR$(B);
     NEXT DO1
     LPRINT CHR$(10); CHR$(13);
     RETURN
     '
2000 CLS   '           24 PIN MENU ROUTINE
     '
     LOCATE 5, 2, 0: PRINT "Enter number of pin to fire (1-24)"
     LOCATE 6, 2, 0: PRINT "or press <RETURN> to cycle all pins."

     LOCATE 22, 11, 0: COLOR 12: PRINT "Enter 99 to exit.": COLOR 14

     LOCATE 8, 5, 0: INPUT PIN: IF PIN = 99 THEN 80
     IF PIN > 24 THEN 2000
     '
     CLS : LOCATE 10, 12, 0: PRINT "FIRING PIN(S)"
     IF PIN > 0 THEN GOSUB 2400 ELSE GOSUB 2300
     A = 0: B = 0: C = 0: PIN = 0: ALL = 0
     GOTO 2000
     '
2300 PIN = 1
     FOR ALL = 1 TO 24
     GOSUB 2400
     PIN = PIN + 1
     NEXT ALL
     RETURN
     '
2400 A = 0: B = 0: C = 0
     IF PIN = 24 THEN C = 1
     IF PIN = 23 THEN C = 2
     IF PIN = 22 THEN C = 4
     IF PIN = 21 THEN C = 8
     IF PIN = 20 THEN C = 16
     IF PIN = 19 THEN C = 32
     IF PIN = 18 THEN C = 64
     IF PIN = 17 THEN C = 128
     IF PIN = 16 THEN B = 1
     IF PIN = 15 THEN B = 2
     IF PIN = 14 THEN B = 4
     IF PIN = 13 THEN B = 8
     IF PIN = 12 THEN B = 16
     IF PIN = 11 THEN B = 32
     IF PIN = 10 THEN B = 64
     IF PIN = 9 THEN B = 128
     IF PIN = 8 THEN A = 1
     IF PIN = 7 THEN A = 2
     IF PIN = 6 THEN A = 4
     IF PIN = 5 THEN A = 8
     IF PIN = 4 THEN A = 16
     IF PIN = 3 THEN A = 32
     IF PIN = 2 THEN A = 64
     IF PIN = 1 THEN A = 128
     '
     '        24 PIN FIRING ROUTINE
     '
     LPRINT TAB(8); "FIRING PIN "; PIN; " ==> ",
     LPRINT "["; Z$;
     FOR DO1 = 1 TO 255
     LPRINT CHR$(A); CHR$(B); CHR$(C);
     NEXT DO1
     LPRINT CHR$(10); CHR$(13);
     RETURN
3000 WIDTH 80: CLS : END

