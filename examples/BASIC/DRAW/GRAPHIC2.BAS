DIM colors%(1 TO 400)
INPUT "which screen are you using"; scr
PRINT "Welcome to Allen's special graphics shop."
PRINT "This is a very basic and easy to use graphic maker"
INPUT "speed of fast keys"; speed
IF scr = 9 THEN PRINT "do you have (1)vga or ega whith vidio memory >64k or"
IF scr = 9 THEN INPUT "ega <=64k memory (1/2)"; vidio
IF scr = 9 THEN PRINT "note: if you get white 12 times in a row then you entered"
IF scr = 9 THEN PRINT "the wrong number"
instructionyn:
INPUT "instuctions (y/n)"; in$
IF in$ <> "y" AND in$ <> "n" THEN GOTO instructionyn
IF in$ = "y" THEN GOTO instruct
options:
INPUT "grid(y/n)"; grid$
IF grid$ = "y" THEN INPUT "space of lines"; grid
INPUT "load a file"; load$
IF load$ = "y" THEN GOTO loadfile
GOTO first
loadfile:
INPUT "file name"; name$
OPEN name$ FOR INPUT AS #1
a = 0: b = 0: c = 0: d = 0: e = 0: f = 0: j = 0: k = 0: l = 0
conloadc:
INPUT #1, zz, yy, rr, cc, dd, ff, pp
IF zz = 0 AND yy = 0 AND rr = 0 THEN GOTO lineload
circle1(a, b, c) = zz
circle2(a, b, c) = yy
rad(a, b, c) = rr
colorc(a, b, c) = cc
circledeg1(a, b, c) = dd
circledeg2(a, b, c) = ff
elipsecircle(a, b, c) = pp
a = a + 1
IF a = 11 THEN b = b + 1
IF a = 11 THEN a = 0
IF b = 11 THEN c = c + 1
IF b = 11 THEN b = 0
GOTO conloadc:
lineload:
conloadl:
INPUT #1, zz, yy, z, y, cc
IF zz = 0 AND yy = 0 AND z = 0 AND y = 0 AND cc = 0 THEN GOTO fillload
line1(d, e, f) = zz
line2(d, e, f) = yy
line3(d, e, f) = z
line4(d, e, f) = y
colorl(d, e, f) = cc
d = d + 1
IF d = 11 THEN e = e + 1
IF d = 11 THEN d = 0
IF e = 11 THEN f = f + 1
IF e = 11 THEN e = 0
GOTO conloadl
fillload:
conloadf:
INPUT #1, zz, yy, cc, bb
IF zz = 0 AND yy = 0 AND cc = 0 AND bb = 0 THEN GOTO doneload
fill1(j, k, l) = zz
fill2(j, k, l) = yy
colorf(j, k, l) = cc
bakcolf(j, k, l) = bb
j = j + 1
IF j = 11 THEN k = k + 1
IF j = 11 THEN j = 0
IF k = 11 THEN l = l + 1
IF k = 11 THEN k = 0
GOTO conloadf
doneload:
CLOSE
first:
SCREEN scr
grid:
SCREEN scr
CLS
IF grid$ = "n" THEN GOTO REDRAW
FOR i = 1 TO 700 STEP grid
LINE (i, 1)-(i, 500)
LINE (1, i)-(1000, i)
NEXT i
IF ok$ = "y" THEN GOTO REDRAW
PRINT "do you like the grid(y/n)"; gyn$
IF gyn$ = "n" THEN INPUT "new grid size "; grid
IF gyn$ = "n" THEN GOTO grid
ok$ = "y"
REDRAW:
IF view$ = "y" THEN CLS
a = 0: b = 0: c = 0
checkc:
IF circle1(a, b, c) = 0 THEN GOTO lines
GOTO configc
printc:
CIRCLE (zz, yy), rr, cc, tt1, tt2, tt3
nextlocatec:
a = a + 1
IF a = 11 THEN b = b + 1
IF a = 11 THEN a = 0
IF b = 11 THEN c = c + 1
IF b = 11 THEN b = 0
GOTO checkc
configc:
zz = circle1(a, b, c)
yy = circle2(a, b, c)
rr = rad(a, b, c)
cc = colorc(a, b, c)
tt1 = circledeg1(a, b, c)
tt2 = circledeg2(a, b, c)
tt3 = elipsecircle(a, b, c)
GOTO printc
lines:
d = 0: e = 0: f = 0
checkf:
IF line1(d, e, f) = 0 AND colorl(d, e, f) = 0 THEN GOTO dfill
GOTO configf
printf:
LINE (zz, yy)-(z, y), cc
nextlocatef:
d = d + 1
IF d = 11 THEN e = e + 1
IF d = 11 THEN d = 0
IF e = 11 THEN f = f + 1
IF e = 11 THEN e = 0
GOTO checkf
configf:
zz = line1(d, e, f)
yy = line2(d, e, f)
z = line3(d, e, f)
y = line4(d, e, f)
cc = colorl(d, e, f)
GOTO printf
dfill:
j = 0: k = 0: l = 0
checkd:
IF fill1(j, k, l) = 0 THEN GOTO addto3
GOTO configd
printd:
PAINT (zz, yy), cc, bb
nextlocated:
j = j + 1
IF j = 11 THEN k = k + 1
IF j = 11 THEN j = 0
IF k = 11 THEN l = l + 1
IF k = 11 THEN k = 0
GOTO checkd
configd:
zz = fill1(j, k, l)
yy = fill2(j, k, l)
cc = colorf(j, k, l)
bb = bakcolf(j, k, l)
GOTO printd
addto3:
IF view$ = "y" THEN GOTO viewy
view$ = "n"
addto:
goal = 0
' cursur is over cursur2 is down
SCREEN scr
CIRCLE (cursur, cursur2), 10, cursurco
CIRCLE (cursur, cursur2), 5, cursurco
CIRCLE (cursur, cursur2), 1, cursurco
getkey:
go$ = INKEY$
IF go$ = "" THEN GOTO getkey
IF go$ = "y" THEN GOTO up
IF go$ = "g" THEN GOTO left
IF go$ = "j" THEN GOTO right
IF go$ = "h" THEN GOTO down
IF go$ = "a" THEN GOTO fleft
IF go$ = "d" THEN GOTO fright
IF go$ = "w" THEN GOTO fup
IF go$ = "s" THEN GOTO fdown
IF go$ = "l" THEN GOTO addline
IF go$ = "c" THEN GOTO addcircle
IF go$ = "f" THEN GOTO fill
IF go$ = "e" THEN GOTO save
IF go$ = "+" THEN GOTO pluscolor
IF go$ = "-" THEN GOTO minuscolor
GOTO getkey
pluscolor:
IF highcolor = 0 THEN GOTO getcolor
cursurco = cursurco + 1
IF cursurco = highcolor OR cursurco > highcolor THEN cursurco = 0
CLS
CIRCLE (10, 10), 10, cursurco
CIRCLE (10, 10), 5, cursurco
CIRCLE (10, 10), 1, cursurco
GET (0, 0)-(20, 20), colors%
GOTO grid
minuscolor:
IF highcolor = 0 THEN GOTO getcolor
cursurco = cursurco - 1
IF cursurco < 0 THEN cursurco = highcolor - 1
CLS
CIRCLE (10, 10), 10, cursurco
CIRCLE (10, 10), 5, cursurco
CIRCLE (10, 10), 1, cursurco
GET (0, 0)-(20, 20), colors%
GOTO grid
getcolor:
IF scr = 0 OR scr = 7 OR scr = 12 THEN highcolor = 16
IF scr = 1 THEN highcolor = 4
IF scr = 2 OR scr = 11 THEN highcolor = 2
IF scr = 9 THEN IF vidio = 1 THEN highcolor = 16
IF scr = 9 THEN IF vidio = 2 THEN highcolor = 4
IF scr = 13 THEN highcolor = 256
IF highcolor = 0 THEN puerr$ = "v"
CLS
CIRCLE (10, 10), 10, cursurco
CIRCLE (10, 10), 5, cursurco
CIRCLE (10, 10), 1, cursurco
GET (0, 0)-(20, 20), colors%
up:
cursur2 = cursur2 - 1
GOTO grid
left:
cursur = cursur - 1
GOTO grid
right:
cursur = cursur + 1
GOTO grid
down:
cursur2 = cursur2 + 1
GOTO grid
fleft:
cursur = cursur - speed
GOTO grid
fright:
cursur = cursur + speed
GOTO grid
fdown:
cursur2 = cursur2 + speed
GOTO grid
fup:
cursur2 = cursur2 - speed
GOTO grid
addcircle:
deg1 = .02: deg2 = .01
printtext$ = "n"
CLS
INPUT "radius"; rad(a, b, c)
INPUT "Wedge Arc or Circle"; type$
IF type$ = "C" OR type$ = "c" OR type$ = "Circle" OR type$ = "circle" THEN GOTO spazycircle
IF type$ = "a" OR type$ = "A" OR type$ = "Arc" OR type$ = "arc" THEN GOTO arc
IF type$ = "w" OR type$ = "W" OR type$ = "Wedge" OR type$ = "wedge" THEN GOTO wedge
wedge:
IF deg1 > 0 THEN deg1 = -.02
IF deg2 > 0 THEN deg2 = -.02
IF deg1 = 0 THEN deg1 = -.02
IF deg2 = 0 THEN deg2 = -.02
CLS
CIRCLE (cursur, cursur2), rad(a, b, c), cursurco, deg1, deg2
a = 0: b = 0: c = 0
checkcc:
IF circle1(a, b, c) = 0 THEN GOTO linesc
GOTO configcc
printcc:
CIRCLE (zz, yy), rr, cc, tt1, tt2, tt3
nextlocatecc:
a = a + 1
IF a = 11 THEN b = b + 1
IF a = 11 THEN a = 0
IF b = 11 THEN c = c + 1
IF b = 11 THEN b = 0
GOTO checkcc
configcc:
zz = circle1(a, b, c)
yy = circle2(a, b, c)
rr = rad(a, b, c)
cc = colorc(a, b, c)
tt1 = circledeg1(a, b, c)
tt2 = circledeg2(a, b, c)
tt3 = elipsecircle(a, b, c)
GOTO printcc
linesc:
d = 0: e = 0: f = 0
checkfc:
IF line1(d, e, f) = 0 THEN GOTO dfillc
GOTO configfc
printfc:
LINE (zz, yy)-(z, y), cc
nextlocatefc:
d = d + 1
IF d = 11 THEN e = e + 1
IF d = 11 THEN d = 0
IF e = 11 THEN f = f + 1
IF e = 11 THEN e = 0
GOTO checkfc
configfc:
zz = line1(d, e, f)
yy = line2(d, e, f)
z = line3(d, e, f)
y = line4(d, e, f)
cc = colorl(d, e, f)
GOTO printfc
dfillc:
j = 0: k = 0: l = 0
checkdc:
IF fill1(j, k, l) = 0 THEN GOTO redad
GOTO configdc
printdc:
PAINT (zz, yy), cc, bb
nextlocatedc:
j = j + 1
IF j = 11 THEN k = k + 1
IF j = 11 THEN j = 0
IF k = 11 THEN l = l + 1
IF k = 11 THEN k = 0
GOTO checkdc
configdc:
zz = fill1(j, k, l)
yy = fill2(j, k, l)
cc = colorf(j, k, l)
bb = bakcolf(j, k, l)
GOTO printdc
redad:
IF printtext$ = "y" THEN GOTO degchange2
LOCATE 10, 1
PRINT "h-j move degrees on one radius"
PRINT "n-m move degrees on other radius"
PRINT "note this is not the size of the finished circle"
PRINT "o is ok"
degchange2:
printtext$ = "y"
key$ = INKEY$
IF key$ = "h" THEN deg1 = deg1 - .01: GOTO wedge
IF key$ = "j" THEN deg1 = deg1 + .01: GOTO wedge
IF key$ = "n" THEN deg2 = deg2 - .01: GOTO wedge
IF key$ = "m" THEN deg2 = deg2 + .01: GOTO wedge
IF key$ = "o" THEN printtext$ = "n": GOTO normcircle
GOTO degchange2
arc:
IF deg1 < 0 THEN deg1 = .02
IF deg2 < 0 THEN deg2 = .02
IF deg1 = 0 THEN deg1 = .02
IF deg2 = 0 THEN deg2 = .02
CLS
CIRCLE (cursur, cursur2), rad(a, b, c), cursurco, deg1, deg2
a = 0: b = 0: c = 0
checkcc2:
IF circle1(a, b, c) = 0 THEN GOTO linesc2
GOTO configcc2
printcc2:
CIRCLE (zz, yy), rr, cc, tt1, tt2, tt3
nextlocatecc2:
a = a + 1
IF a = 11 THEN b = b + 1
IF a = 11 THEN a = 0
IF b = 11 THEN c = c + 1
IF b = 11 THEN b = 0
GOTO checkcc2
configcc2:
zz = circle1(a, b, c)
yy = circle2(a, b, c)
rr = rad(a, b, c)
cc = colorc(a, b, c)
tt1 = circledeg1(a, b, c)
tt2 = circledeg2(a, b, c)
tt3 = elipsecircle(a, b, c)
GOTO printcc2
linesc2:
d = 0: e = 0: f = 0
checkfc2:
IF line1(d, e, f) = 0 THEN GOTO dfillc2
GOTO configfc2
printfc2:
LINE (zz, yy)-(z, y), cc
nextlocatefc2:
d = d + 1
IF d = 11 THEN e = e + 1
IF d = 11 THEN d = 0
IF e = 11 THEN f = f + 1
IF e = 11 THEN e = 0
GOTO checkfc2
configfc2:
zz = line1(d, e, f)
yy = line2(d, e, f)
z = line3(d, e, f)
y = line4(d, e, f)
cc = colorl(d, e, f)
GOTO printfc2
dfillc2:
j = 0: k = 0: l = 0
checkdc2:
IF fill1(j, k, l) = 0 THEN GOTO redad2
GOTO configdc2
printdc2:
PAINT (zz, yy), cc, bb
nextlocatedc2:
j = j + 1
IF j = 11 THEN k = k + 1
IF j = 11 THEN j = 0
IF k = 11 THEN l = l + 1
IF k = 11 THEN k = 0
GOTO checkdc2
configdc2:
zz = fill1(j, k, l)
yy = fill2(j, k, l)
cc = colorf(j, k, l)
bb = bakcolf(j, k, l)
GOTO printdc2
redad2:
IF printtext$ = "y" THEN GOTO degchange
LOCATE 10, 1
PRINT "h-j move degrees on one radius"
PRINT "n-m move degrees on other radius"
PRINT "o is ok"
degchange:
printtext$ = "y"
key$ = INKEY$
IF key$ = "h" THEN deg1 = deg1 - .03: GOTO arc
IF key$ = "j" THEN deg1 = deg1 + .03: GOTO arc
IF key$ = "n" THEN deg2 = deg2 - .03: GOTO arc
IF key$ = "m" THEN deg2 = deg2 + .03: GOTO arc
IF key$ = "o" THEN printtext$ = "n": GOTO normcircle
GOTO degchange
spazycircle:
normcircle:
elipse = .7300002
INPUT "elipse? (y/n)"; el$
IF el$ = "n" THEN GOTO dumbcircle
elipse = .7300002
elipse:
CLS
CIRCLE (cursur, cursur2), rad(a, b, c), cursurco, deg1, deg2, elipse
a = 0: b = 0: c = 0
checkcc3:
IF circle1(a, b, c) = 0 THEN GOTO linesc3
GOTO configcc3
printcc3:
CIRCLE (zz, yy), rr, cc, tt1, tt2, tt3
nextlocatecc3:
a = a + 1
IF a = 11 THEN b = b + 1
IF a = 11 THEN a = 0
IF b = 11 THEN c = c + 1
IF b = 11 THEN b = 0
GOTO checkcc3
configcc3:
zz = circle1(a, b, c)
yy = circle2(a, b, c)
rr = rad(a, b, c)
cc = colorc(a, b, c)
tt1 = circledeg1(a, b, c)
tt2 = circledeg2(a, b, c)
tt3 = elipsecircle(a, b, c)
GOTO printcc3
linesc3:
d = 0: e = 0: f = 0
checkfc3:
IF line1(d, e, f) = 0 THEN GOTO dfillc3
GOTO configfc3
printfc3:
LINE (zz, yy)-(z, y), cc
nextlocatefc3:
d = d + 1
IF d = 11 THEN e = e + 1
IF d = 11 THEN d = 0
IF e = 11 THEN f = f + 1
IF e = 11 THEN e = 0
GOTO checkfc3
configfc3:
zz = line1(d, e, f)
yy = line2(d, e, f)
z = line3(d, e, f)
y = line4(d, e, f)
cc = colorl(d, e, f)
GOTO printfc3
dfillc3:
j = 0: k = 0: l = 0
checkdc3:
IF fill1(j, k, l) = 0 THEN GOTO redad3
GOTO configdc3
printdc3:
PAINT (zz, yy), cc, bb
nextlocatedc3:
j = j + 1
IF j = 11 THEN k = k + 1
IF j = 11 THEN j = 0
IF k = 11 THEN l = l + 1
IF k = 11 THEN k = 0
GOTO checkdc3
configdc3:
zz = fill1(j, k, l)
yy = fill2(j, k, l)
cc = colorf(j, k, l)
bb = bakcolf(j, k, l)
GOTO printdc3
redad3:

LOCATE 15, 1
PRINT "h-j control fatness of it"
PRINT "d=done"
PRINT "emount elipsed "; elipse
elkey:
go$ = INKEY$
printtext$ = "y"
IF go$ = "h" THEN elipse = elipse + .01: GOTO elipse
IF go$ = "j" THEN elipse = elipse - .01: GOTO elipse
IF go$ = "d" THEN GOTO coolcircle
GOTO elkey
dumbcircle:
elipse = .7300002
coolcircle:
circle1(a, b, c) = cursur
circle2(a, b, c) = cursur2
colorc(a, b, c) = cursurco
circledeg1(a, b, c) = deg1
circledeg2(a, b, c) = deg2
elipsecircle(a, b, c) = elipse
emc = emc + 1
a = a + 1
IF a = 11 THEN b = b + 1
IF a = 11 THEN a = 0
IF b = 11 THEN c = c + 1
IF b = 11 THEN b = 0
IF c = 11 THEN PRINT "no more circles"
GOTO grid
addline:
IF linp1 = 1 THEN GOTO seccor
location1 = cursur: location2 = cursur2
linp1 = 1
GOTO grid
seccor:
location3 = cursur: location4 = cursur2
line1(d, e, f) = location1
line2(d, e, f) = location2
line3(d, e, f) = location3
line4(d, e, f) = location4
linp1 = 0
eml = eml + 1
location1 = 0: location2 = 0: location3 = 0: location4 = 0
colorl(d, e, f) = cursurco
d = d + 1
IF d = 11 THEN e = e + 1
IF d = 11 THEN d = 0
IF e = 11 THEN f = f + 1
IF e = 11 THEN e = 0
IF f = 11 THEN PRINT "no more lines"
GOTO grid
fill:
LOCATE 1, 1: PRINT "need border color or color of outline in an object that is not suposed"
PRINT "to be earased with this paint job (g-h to change) d=done"
fillcol:
IF bcf = -1 THEN bcf = 0
LOCATE 4, 5
COLOR bcf
PRINT "color"
changebak:
go$ = INKEY$
IF go$ = "g" THEN bcf = bcf + 1: GOTO fillcol
IF go$ = "h" THEN bcf = bcf - 1: GOTO fillcol
IF go$ = "d" THEN GOTO df
GOTO changebak
df:
fill1(j, k, l) = cursur
fill2(j, k, l) = cursur2
colorf(j, k, l) = cursurco
bakcolf(j, k, l) = bcf
j = j + 1
emf = emf + 1
IF j = 11 THEN k = k + 1
IF j = 11 THEN j = 0
IF k = 11 THEN l = l + 1
IF k = 11 THEN k = 0
IF l = 11 THEN PRINT "can't fill any more"
GOTO grid
save:
PRINT "(s)ave, (e)rase a section of drawing, (c)ompleatly start over (v)iew"
INPUT "which (s/e/c/v)"; opt$
IF opt$ = "s" THEN GOTO opt1
IF opt$ = "e" THEN GOTO opt2
IF opt$ = "c" THEN GOTO opt3
IF opt$ = "v" THEN view$ = "y"
IF opt$ = "v" THEN GOTO REDRAW
GOTO save
opt1:
CLS
INPUT "file name"; name$
OPEN name$ FOR OUTPUT AS #1
a = 0: b = 0: c = 0: d = 0: e = 0: f = 0: j = 0: k = 0: l = 0
consavc:
IF circle1(a, b, c) = 0 THEN GOTO linesav
zz = circle1(a, b, c)
yy = circle2(a, b, c)
rr = rad(a, b, c)
cc = colorc(a, b, c)
dd = circledeg1(a, b, c)
ff = circledeg2(a, b, c)
pp = elipsecircle(a, b, c)
WRITE #1, zz, yy, rr, cc, dd, ff, pp
a = a + 1
IF a = 11 THEN b = b + 1
IF a = 11 THEN a = 0
IF b = 11 THEN c = c + 1
IF b = 11 THEN b = 0
GOTO consavc:
linesav:
WRITE #1, 0, 0, 0, 0, 0, 0, 0
consavl:
zz = line1(d, e, f)
yy = line2(d, e, f)
z = line3(d, e, f)
y = line4(d, e, f)
cc = colorl(d, e, f)
IF zz = 0 AND yy = 0 AND z = 0 AND y = 0 AND cc = 0 THEN GOTO fillsav
WRITE #1, zz, yy, z, y, cc
d = d + 1
IF d = 11 THEN e = e + 1
IF d = 11 THEN d = 0
IF e = 11 THEN f = f + 1
IF e = 11 THEN e = 0
GOTO consavl
fillsav:
WRITE #1, 0, 0, 0, 0, 0
consavf:
zz = fill1(j, k, l)
IF zz = 0 THEN GOTO donesav
yy = fill2(j, k, l)
cc = colorf(j, k, l)
bb = bakcolf(j, k, l)
WRITE #1, zz, yy, cc, bb
j = j + 1
IF j = 11 THEN k = k + 1
IF j = 11 THEN j = 0
IF k = 11 THEN l = l + 1
IF k = 11 THEN k = 0
GOTO consavf
donesav:
WRITE #1, 0, 0, 0, 0
CLOSE
viewd:
INPUT "view (y/n)"; view$
IF view$ = "y" THEN GOTO REDRAW
GOTO saveopt
viewy:
go$ = INKEY$
IF go$ = "" THEN GOTO viewy
saveopt:
SCREEN textmode
view$ = "n"
INPUT "(c)ontinue (n)ew (e)nd"; select$
IF select$ = "e" THEN END
IF select$ = "n" THEN GOTO opt3
SCREEN scr
IF select$ = "c" THEN GOTO grid
GOTO saveopt
opt2:
INPUT "(l)ine (c)ircle (f)illed in area"; erasew$
IF erasew$ = "l" THEN GOTO linegone
IF erasew$ = "c" THEN GOTO circlegone
IF erasew$ = "f" THEN GOTO fillgone
linegone:
d = d - 1
IF d < 0 THEN e = e - 1
IF d < 0 THEN d = 10
IF e < 0 THEN f = f - 1
IF e < 0 THEN e = 10
IF d = 0 AND e = 0 AND f = 0 THEN PRINT "no more earasing lines"
IF d < 0 THEN d = 0
IF e < 0 THEN e = 0
IF f < 0 THEN f = 0
line1(d, e, f) = 0
line2(d, e, f) = 0
line3(d, e, f) = 0
line4(d, e, f) = 0
colorl(d, e, f) = 0
GOTO grid
circlegone:
a = a - 1
IF a < 0 THEN b = b - 1
IF a < 0 THEN a = 10
IF b < 0 THEN c = c - 1
IF b < 0 THEN b = 10
IF c = 0 AND a = 0 AND b = 0 THEN PRINT "no more subtracting circles"
IF c = 0 THEN c = 0
IF b = 0 THEN b = 0
IF a = 0 THEN a = 0
circle1(a, b, c) = 0
circle2(a, b, c) = 0
rad(a, b, c) = 0
GOTO grid
fillgone:  
j = j - 1
IF j < 0 THEN k = k - 1
IF j < 0 THEN j = 10
IF k < 0 THEN l = l - 1
IF k < 0 THEN k = 10
IF j < 0 AND k = 0 AND l = 0 THEN PRINT "no more empting filled holes"
IF j < 0 THEN j = 0
IF k < 0 THEN k = 0
IF l < 0 THEN l = 0
fill1(j, k, l) = 0
fill2(j, k, l) = 0
GOTO grid
opt3:
a = 0: b = 0: c = 0: d = 0: e = 0: f = 0: j = 0: k = 0: l = 0
erasec:
IF circle1(a, b, c) = 0 THEN GOTO erasel
circle1(a, b, c) = 0
circle2(a, b, c) = 0
rad(a, b, c) = 0
a = a + 1
IF a = 11 THEN b = b + 1
IF a = 11 THEN a = 0
IF b = 11 THEN c = c + 1
IF b = 11 THEN b = 0
IF c = 11 THEN GOTO erasel
GOTO erasec
erasel:
IF line1(d, e, f) = 0 THEN GOTO erasef
line1(d, e, f) = 0
line2(d, e, f) = 0
line3(d, e, f) = 0
line4(d, e, f) = 0
d = d + 1
IF d = 11 THEN e = e + 1
IF d = 11 THEN d = 0
IF e = 11 THEN f = f + 1
IF e = 11 THEN e = 0
IF f = 11 THEN GOTO erasef
GOTO erasel
erasef:
IF fill1(j, k, l) = 0 THEN GOTO dopt3
fill1(j, k, l) = 0
fill2(j, k, l) = 0
j = j + 1
IF j = 11 THEN k = k + 1
IF j = 11 THEN j = 0
IF k = 11 THEN l = l + 1
IF k = 11 THEN k = 0
IF l = 11 THEN GOTO dopt3
GOTO erasef
dopt3:
a = 0: b = 0: c = 0: d = 0: e = 0: f = 0: j = 0: k = 0: l = 0
SCREEN textmode
RUN

instruct:
CLS
PRINT "Are you tierd of programing detailed graphics then slow way,"
PRINT "in basic? (positioning each line and circle) Well, now you have the easy way"
PRINT "with this all you have to do for each graphic is copy installg.bas into your"
PRINT "programs. the screen is the programing screen your using in your game."
PRINT "This tool has two sets of moveing keys, fast and slow. fast moves the cursur"
PRINT "a # of spaces. The total # is givin by you. This lets you move to a general"
PRINT "area. The slow is one spot at a time. These are the keys:"
PRINT "fast:"
PRINT "up=w"
PRINT "down=s"
PRINT "left=a"
PRINT "right=d"
PRINT "slow:"
INPUT ""; sdfggdsgfd$
PRINT "hit the # lock key, and go to the number pad (# lock must be on)"
PRINT "right=4"
PRINT "left=6"
PRINT "up=8"
PRINT "down=2"
PRINT "7,1,9,3,5 are nothing."
PRINT "the funtion keys:"
PRINT "circle=c (computer askes for radius)"
PRINT "line=l (hit in one spot (begining of line) hit in another spot (end of line)"
PRINT "paint or fill an area=f (not very good with grid)"
PRINT "grid. you select how big the grid is. it lets you really perfect detall."
PRINT "note: the grid is not saved"
PRINT "loading a file lets you modify alredy made graphics."
PRINT "type `e' to get the menu of saving, erasing a spot of your graphic or "
PRINT "start with a new graphic."
INPUT ""; sgdfgdfdsgfhgfds$
GOTO options

