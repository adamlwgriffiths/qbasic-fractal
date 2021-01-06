SCREEN 13
CLS

CONST w = 320
CONST h = 200
CONST maxi = 100
CONST colours = 256

DIM SHARED sx AS SINGLE
DIM SHARED xy AS SINGLE
DIM SHARED x AS SINGLE
DIM SHARED y AS SINGLE


DIM SHARED P AS INTEGER
DIM SHARED r AS INTEGER
DIM SHARED g AS INTEGER
DIM SHARED b AS INTEGER


FOR py = 0 TO h - 1
        REM Scale Y to -1:+1
        sy = (py / h) * 2! - 1
        FOR px = 0 TO w - 1
                REM Scale X to -2.5:1
                sx = (px / w) * 3.5 - 2.5
                vy = 0
                vx = 0
                i = 0
                x = 0
                y = 0
                PSET (px, py), 1
                WHILE (x ^ 2 + y ^ 2 < 4) AND (i < maxi)
                        xt = x * x - y * y + sx
                        y = 2 * x * y + sy
                        x = xt
                        i = i + 1
                WEND
                c = i / maxi * colours
                PSET (px, py), c
        NEXT
NEXT

CALL SaveScreen("mandelbr.raw", 320, 200)

SUB SaveScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)
    OPEN filename FOR OUTPUT AS #1
        FOR y = 0 TO h - 1
            FOR x = 0 TO w - 1
                PRINT #1, CHR$(POINT(x, y));
            NEXT x
        NEXT y
    CLOSE #1
SUB END
