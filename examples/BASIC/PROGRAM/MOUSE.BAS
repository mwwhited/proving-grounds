DECLARE FUNCTION Init% ()
DECLARE SUB Status (lb%, rb%, mb%, xMouse%, yMouse%)
DECLARE SUB Range (x1%, y1%, x2%, Y2%)
DECLARE SUB MouseDriver (ax%, bx%, cx%, dx%)
DECLARE SUB Show ()
CLEAR 90000, 90000, 10000
scr = 12
SCREEN 13
DIM box%(1 TO 200)
DEF SEG = &HA000
DIM SHARED mouse$: mouse$ = SPACE$(57)
FOR i% = 1 TO 57:  READ a$:  H$ = CHR$(VAL("&H" + a$))
MID$(mouse$, i%, 1) = H$: NEXT i%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00
RESTORE
ms% = Init%
IF NOT ms% THEN
  SCREEN 0
  WIDTH 80
  CLS
  PRINT "Have you just awakened from a 10 year coma or are"
  PRINT "you just too cheap to spring for a mouse?"
END
END IF
IF scr <> 12 THEN
Range 0, 0, 634, 197
END IF
IF scr = 12 THEN
Range 0, 0, 637, 477
END IF
Show
inky:
Status lb%, rb%, mb%, x%, Y%
LOCATE 1, 1
PRINT lb%
PRINT mb%
PRINT rb%
PRINT "coordinants"
PRINT x%
PRINT Y%
GOTO inky

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

SUB Range (x1%, y1%, x2%, Y2%)
  ax% = 7
  cx% = x1%
  dx% = x2%
MouseDriver ax%, 0, cx%, dx%
  ax% = 8
  cx% = y1%
  dx% = Y2%
  MouseDriver ax%, 0, cx%, dx%
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

