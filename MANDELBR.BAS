DECLARE SUB CyclePalette ()
DECLARE SUB SaveScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)
DECLARE SUB InitPalette ()

SCREEN 13
CLS
LINE (0, 0)-(320, 200), 15, BF

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

SUB CyclePalette
        DIM blue AS LONG
        DIM green AS LONG
        DIM red AS LONG
        DIM pcolour AS LONG
        DIM pvalues1(255) AS LONG
        DIM pvalues2(255) AS LONG
        DIM pvalues3(255) AS LONG
        DIM pvalues4(255) AS LONG
        FOR i = 0 TO 63
                blue = i
                green = i / 2
                red = i / 3
                pcolour = blue * 65536 + green * 256 + red
                pvalues1(i) = pcolour
                pvalues1(i + 128) = pcolour
                blue = i / 2
                green = i / 3
                red = i
                pvalues2(i) = pcolour
                pvalues2(i + 128) = pcolour
                blue = i / 3
                green = i
                red = i / 2
                pvalues3(i) = pcolour
                pvalues3(i + 128) = pcolour
                blue = i
                green = i
                red = i
                pvalues4(i) = pcolour
                pvalues4(i + 128) = pcolour
        NEXT i
        FOR i = 63 TO 0 STEP -1
                blue = i
                green = i / 2
                red = i / 3
                pcolour = blue * 65536 + green * 256 + red
                pvalues1(i + 64) = pcolour
                pvalues1(i + 192) = pcolour
                blue = i / 2
                green = i / 3
                red = i
                pvalues2(i + 64) = pcolour
                pvalues2(i + 192) = pcolour
                blue = i / 3
                green = i
                red = i / 2
                pvalues3(i + 64) = pcolour
                pvalues3(i + 192) = pcolour
                blue = i
                green = i
                red = i
                pvalues4(i + 64) = pcolour
                pvalues4(i + 192) = pcolour
       
        NEXT i

        index = 0
        DO WHILE INKEY$ = ""
                IF index = 0 THEN
                        PALETTE USING pvalues1
                ELSEIF index = 1 THEN
                        PALETTE USING pvalues2
                ELSEIF index = 2 THEN
                        PALETTE USING pvalues3
                ELSE
                        PALETTE USING pvalues4
                END IF

                index = index + 1
                IF index > 3 THEN index = 0
        LOOP
END SUB

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

