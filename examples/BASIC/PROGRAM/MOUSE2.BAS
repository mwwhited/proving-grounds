DECLARE FUNCTION Init% ()
DECLARE SUB Status (lb%, rb%, mb%, xMouse%, yMouse%)
DECLARE SUB MouseDriver (ax%, bx%, cx%, dx%)
DECLARE SUB Show ()
CLEAR 90000, 90000, 10000
scr = 13
DIM box%(1 TO 200)
DEF SEG = &HA000
DIM SHARED mouse$: mouse$ = SPACE$(57)
FOR i% = 1 TO 57:  READ A$:  H$ = CHR$(VAL("&H" + A$))
MID$(mouse$, i%, 1) = H$: NEXT i%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00
RESTORE
ms% = Init%
Show
SCREEN scr
INKY:
COLOR 1
IF A = 1 THEN COLOR 3
LOCATE 1, 1: PRINT "EXIT"  '(0,0)-(30,6)
COLOR 1
IF A = 2 THEN COLOR 3
LOCATE 3, 1: PRINT "TREE"  '(0,16)-(30,22)
COLOR 1
IF A = 3 THEN COLOR 3
LOCATE 5, 1: PRINT "DIR"  '(0,32)-(22,38)
COLOR 1
IF A = 4 THEN COLOR 3
LOCATE 7, 1: PRINT "SHELL"  '(0,48)-(38,54)
Status lb%, rb%, mb%, X%, Y%
A = 0
LOCATE 9, 1: PRINT X%; " "; Y%
PRESET (A%, B%)
A% = X%: B% = Y%
PSET (X%, Y%), 10
IF X% >= 0 AND Y% >= 48 THEN
     A = 4
ELSEIF X% >= 0 AND Y% >= 32 THEN
     A = 3
ELSEIF X% >= 0 AND Y% >= 16 THEN
     A = 2
ELSEIF X% >= 0 AND Y% >= 0 THEN
     A = 1
END IF
IF X% >= 0 AND Y% >= 48 AND lb% <> 0 THEN
     END
ELSEIF X% >= 0 AND Y% >= 32 AND lb% <> 0 THEN
     GOTO TREE
ELSEIF X% >= 0 AND Y% >= 16 AND lb% <> 0 THEN
     GOTO DIR
ELSEIF X% >= 0 AND Y% >= 0 AND lb% <> 0 THEN
     GOTO DOSSHELL
END IF
IF X% <= 38 AND Y% <= 54 THEN
     A = 4
ELSEIF X% <= 22 AND Y% <= 38 THEN
     A = 3
ELSEIF X% <= 30 AND Y% <= 22 THEN A = 2
ELSEIF X% <= 30 AND Y% <= 6 THEN A = 1
END IF
IF X% <= 38 AND Y% <= 54 AND lb% <> 0 THEN
     END
ELSEIF X% <= 22 AND Y% <= 38 AND lb% <> 0 THEN
     GOTO TREE
ELSEIF X% <= 30 AND Y% <= 22 AND lb% <> 0 THEN
     GOTO DIR
ELSEIF X% <= 30 AND Y% <= 6 AND lb% <> 0 THEN
     GOTO DOSSHELL
END IF
GOTO INKY
TREE:
CLS
SHELL "TREE"
SLEEP
CLS
GOTO INKY
DIR:
CLS
SHELL "DIR /P/W"
SLEEP
CLS
GOTO INKY
DOSSHELL:
CLS
SHELL
CLS
GOTO INKY

DEFLNG A-Z
FUNCTION Init%
  ax% = 0
  MouseDriver ax%, 0, 0, 0
  Init% = ax%
END FUNCTION

SUB MouseDriver (ax%, bx%, cx%, dx%)
  DEF SEG = VARSEG(mouse$)
  mouse% = SADD(mouse$)
  CALL Absolute(ax%, bx%, cx%, dx%, mouse%)
END SUB

SUB Show
  ax% = 1
  MouseDriver ax%, 0, 0, 0
END SUB

SUB Status (lb%, rb%, mb%, xMouse%, yMouse%)
  ax% = 3
  MouseDriver ax%, bx%, cx%, dx%
  lb% = ((bx% AND 1) <> 0)
  rb% = ((bx% AND 2) <> 0)
  mb% = ((bx% AND 4) <> 0)
  xMouse% = cx%
  yMouse% = dx%
END SUB

