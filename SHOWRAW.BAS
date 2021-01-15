DECLARE FUNCTION PaletteColour! (red AS LONG, green AS LONG, blue AS LONG)
DECLARE SUB LoadRawScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)
DECLARE SUB CyclePalette ()

SCREEN 13
CLS
LINE (0, 0)-(320, 200), 15, BF
CALL LoadRawScreen("C:\SCREEN.RAW", 320, 200)

CALL CyclePalette

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
                pcolour = PaletteColour(red, blue, green)
                pvalues1(i) = pcolour
                pvalues1(i + 128) = pcolour
                blue = i / 2
                green = i / 3
                red = i
                pcolour = PaletteColour(red, blue, green)
                pvalues2(i) = pcolour
                pvalues2(i + 128) = pcolour
                blue = i / 3
                green = i
                red = i / 2
                pcolour = PaletteColour(red, blue, green)
                pvalues3(i) = pcolour
                pvalues3(i + 128) = pcolour
                blue = i
                green = i
                red = i
                pcolour = PaletteColour(red, blue, green)
                pvalues4(i) = pcolour
                pvalues4(i + 128) = pcolour
        NEXT i
        FOR i = 63 TO 0 STEP -1
                blue = i
                green = i / 2
                red = i / 3
                pcolour = PaletteColour(red, blue, green)
                pvalues1(i + 64) = pcolour
                pvalues1(i + 192) = pcolour
                blue = i / 2
                green = i / 3
                red = i
                pcolour = PaletteColour(red, blue, green)
                pvalues2(i + 64) = pcolour
                pvalues2(i + 192) = pcolour
                blue = i / 3
                green = i
                red = i / 2
                pcolour = PaletteColour(red, blue, green)
                pvalues3(i + 64) = pcolour
                pvalues3(i + 192) = pcolour
                blue = i
                green = i
                red = i
                pcolour = PaletteColour(red, blue, green)
                pvalues4(i + 64) = pcolour
                pvalues4(i + 192) = pcolour
       
        NEXT i

        index = 0
        DO WHILE INKEY$ = ""
                IF index = 0 THEN
                        PALETTE USING pvalues4
                ELSEIF index = 1 THEN
                        PALETTE USING pvalues3
                ELSEIF index = 2 THEN
                        PALETTE USING pvalues2
                ELSE
                        PALETTE USING pvalues1
                END IF

                index = index + 1
                SLEEP 1

                IF index > 3 THEN index = 0
        LOOP
END SUB

SUB LoadRawScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)
      
        OPEN filename FOR BINARY AS #1
        DIM colour AS INTEGER

        FOR y = 0 TO h - 1
               
                FOR x = 0 TO w - 1

                        position = (x + (y * w))
                        
                        GET #1, position + 1, colour

                        PSET (x, y), colour

                NEXT x
               
        NEXT y

        CLOSE #1

END SUB

FUNCTION PaletteColour (red AS LONG, green AS LONG, blue AS LONG)
        PaletteColour = blue * 65536 + green * 256 + red
END FUNCTION

