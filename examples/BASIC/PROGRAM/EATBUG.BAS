1 PRINT "You're Oliver the bug eater and you have to eat all the bugs!"
2 PRINT "You're the O and the Bugs are the B's. S moves down. W moves up."
3 PRINT "A moves left, and D moves right. Q quits."
4 PRINT "Please send $5 to: "
5 PRINT "Jonathan Gray"
6 PRINT "4909 Cardinal Way"
7 PRINT "Agoura, CA  91301-4762"
8 PRINT "and you will receive my next three games for free!"
9 PRINT "Check payable to Jonathan Gray. Please include compuserve ID."
PRINT "Press enter to begin"
INPUT A$
CLS
10 SW = 80: SP = 50: RANDOMIZE (TIMER)
20 DIM BG(10), BX(10), BY(10)
30 FOR X = 1 TO 10
40 BG(X) = 1
50 BX(X) = INT(RND(1) * SW) + 1
60 BY(X) = INT(RND(1) * 23) + 1
70 NEXT
80 SC = 0: FL = 0: MX = INT(SW / 2): MY = 12
90 GOSUB 430
100 IF FL = 1 THEN 240
110 FOR X = 1 TO 10
120 IF BG(X) = 0 THEN 230
130 PX = BX(X): PY = BY(X): GOSUB 420: PRINT CHR$(32);
140 IF RND(1) > .5 THEN BX(X) = BX(X) + 1: GOTO 160
150 BX(X) = BX(X) - 1
160 IF BX(X) > SW THEN BX(X) = SW
170 IF BX(X) < 1 THEN BX(X) = 1
180 IF RND(1) > .5 THEN BY(X) = BY(X) + 1: GOTO 200
190 BY(X) = BY(X) - 1
200 IF BY(X) > 23 THEN BY(X) = 23
210 IF BY(X) < 1 THEN BY(X) = 1
220 PX = BX(X): PY = BY(X): GOSUB 420: PRINT "B"
230 NEXT
240 PX = MX: PY = MY: GOSUB 420: PRINT CHR$(32);
250 GOSUB 440: IF B$ = "" THEN 350
260 IF B$ = "Q" OR B$ = "q" THEN END
270 IF B$ = "A" OR B$ = "a" THEN MX = MX - 1
280 IF B$ = "D" OR B$ = "d" THEN MX = MX + 1
290 IF B$ = "W" OR B$ = "w" THEN MY = MY - 1
300 IF B$ = "S" OR B$ = "s" THEN MY = MY + 1
310 IF MX > SW THEN MX = SW
320 IF MX < 1 THEN MX = 1
330 IF MY > 23 THEN MX = 23
340 IF MY < 1 THEN MY = 1
350 PX = MX: PY = MY: GOSUB 420: PRINT "O"
360 FOR X = 1 TO 10: IF BG(X) = 1 AND MX = BX(X) AND MY = BY(X) THEN GOSUB 410
370 NEXT: FL = 1 - FL
380 IF SC < 10 THEN 100
390 GOSUB 430: PRINT "You ate all the bugs!": END
400 FOR PE = 1 TO SP: NEXT: GOTO 100
410 BG(X) = 0: GOSUB 470: SC = SC + 1: RETURN
420 LOCATE PY, PX: RETURN
430 CLS : RETURN
440 B$ = INKEY$
450 FOR X = 1 TO 15: Q$ = INKEY$: NEXT
460 RETURN
470 SOUND 440, 1: RETURN





