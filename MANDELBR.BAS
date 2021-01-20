DECLARE SUB InitPalette ()
DECLARE SUB DrawFractal ()
DECLARE SUB SaveScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)

SCREEN 13
CLS
LINE (0, 0)-(320, 200), 15, BF

CONST w = 320
CONST h = 200

CALL InitPalette
CALL DrawFractal
CALL SaveScreen("MANDELBR.RAW", w, h)

REM This is fractal rendering code, the other functions are to make it look nicer
SUB DrawFractal
    DIM sx AS SINGLE
    DIM xy AS SINGLE
    DIM x AS SINGLE
    DIM y AS SINGLE
    DIM x2 AS SINGLE
    DIM y2 AS SINGLE

    DIM p AS INTEGER
    DIM r AS INTEGER
    DIM g AS INTEGER
    DIM B AS INTEGER

    CONST maxi = 100
    CONST colours = 256

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
            x2 = 0
            y2 = 0
            WHILE (x2 + y2 < 4) AND (i < maxi)
                xt = x2 - y2 + sx
                y = 2 * x * y + sy
                x = xt
                x2 = x * x
                y2 = y * y
                i = i + 1
            WEND
            c = i / maxi * colours
            PSET (px, py), c
        NEXT
    NEXT
END SUB


REM Changes the palette as the default is not pretty
SUB InitPalette
    DIM red AS LONG
    DIM green AS LONG
    DIM blue AS LONG
    DIM colour AS LONG

    FOR i = 0 TO 63
        blue = i
        green = i / 2
        red = i / 3
        colour = blue * 65536 + green * 256 + red
        PALETTE i, colour
        PALETTE i + 128, colour
    NEXT i
    FOR i = 63 TO 0 STEP -1
        blue = i
        green = i / 2
        red = i / 3
        colour = blue * 65536 + green * 256 + red
        PALETTE i + 64, colour
        PALETTE i + 192, colour
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
