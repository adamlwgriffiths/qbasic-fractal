DECLARE SUB SaveScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)
DECLARE SUB InitPalette ()

SCREEN 13
CLS
LINE (0, 0)-(320, 200), 15, BF

REM Initialise a nicer palette so the fractal doesnt look weird
CALL InitPalette

CONST w = 320
CONST h = 200
CONST maxi = 100
CONST colours = 256

DIM SHARED sx AS SINGLE
DIM SHARED xy AS SINGLE
DIM SHARED x AS SINGLE
DIM SHARED y AS SINGLE

DIM SHARED p AS INTEGER
DIM SHARED r AS INTEGER
DIM SHARED g AS INTEGER
DIM SHARED B AS INTEGER

REM This is fractal rendering code, the other functions are to make it look nicer
FOR py = 0 TO h - 1
        REM scale Y to -1:+1
        sy = (py / h) * 2! - 1
        FOR px = 0 TO w - 1
                REM scale x to -2.5:1
                sx = (px / w) * 3.5 - 2.5
                vy = 0
                vx = 0
                i = 0
                x = 0
                y = 0
                PSET (px, py), 1
                WHILE (x * x + y * y < 4) AND (i < maxi)
                        xt = x * x - y * y + sx
                        y = 2 * x * y + sy
                        x = xt
                        i = i + 1
                WEND
                c = i / maxi * colours
                PSET (px, py), c
        NEXT
NEXT

CALL SaveScreen("C:\SCREEN.RAW", 320, 200)
REM CALL CyclePalette

REM Change the default colours
SUB InitPalette
        DIM blue AS LONG
        DIM green AS LONG
        DIM red AS LONG
        DIM pcolour AS LONG
        FOR i = 0 TO 63
                blue = i
                green = i / 2
                red = i / 3
                pcolour = blue * 65536 + green * 256 + red
                PALETTE i, pcolour
                PALETTE i + 128, pcolour
        NEXT i
        FOR i = 63 TO 0 STEP -1
                blue = i
                green = i / 2
                red = i / 3
                pcolour = blue * 65536 + green * 256 + red
                PALETTE i + 64, pcolour
                PALETTE i + 192, pcolour
        NEXT i

END SUB

SUB SaveScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)
        OPEN filename FOR OUTPUT AS #1
        FOR y = 0 TO h - 1
                FOR x = 0 TO w - 1
                        PRINT #1, CHR$(POINT(x, y));
                NEXT x
        NEXT y

        CLOSE #1
END SUB

