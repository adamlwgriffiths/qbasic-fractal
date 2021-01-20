DECLARE SUB InitPalette ()
DECLARE FUNCTION PaletteColour! (red AS LONG, green AS LONG, blue AS LONG)
DECLARE SUB LoadRawScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)
DECLARE SUB CyclePalette ()

SCREEN 13
CLS
LINE (0, 0)-(320, 200), 15, BF

CALL InitPalette
CALL LoadRawScreen("MANDELBR.RAW", 320, 200)
CALL CyclePalette

FUNCTION PaletteColour (red AS LONG, green AS LONG, blue AS LONG)
    PaletteColour = blue * 65536 + green * 256 + red
END FUNCTION

REM Changes the palette as the default is not pretty
SUB InitPalette
    DIM i AS LONG
    DIM idiv2 AS LONG
    DIM idiv3 AS LONG
    DIM colour AS LONG

    FOR i = 0 TO 63
        idiv2 = i / 2
        idiv3 = i / 3
        colour = PaletteColour(idiv3, i, idiv2)
        PALETTE i, colour
        PALETTE i + 128, colour
    NEXT i
    FOR i = 63 TO 0 STEP -1
        idiv2 = i / 2
        idiv3 = i / 3
        colour = PaletteColour(idiv3, i, idiv2)
        PALETTE i + 64, colour
        PALETTE i + 192, colour
    NEXT i
END SUB

SUB CyclePalette
    DIM i AS LONG
    DIM idiv2 AS LONG
    DIM idiv3 AS LONG
    DIM colour AS LONG
    DIM palette1(255) AS LONG
    DIM palette2(255) AS LONG
    DIM palette3(255) AS LONG
    DIM palette4(255) AS LONG

    FOR i = 0 TO 63
        idiv2 = i / 2
        idiv3 = i / 3

        colour = PaletteColour(idiv3, i, idiv2)
        palette1(i) = colour
        palette1(i + 128) = colour

        colour = PaletteColour(i, idiv2, idiv3)
        palette2(i) = colour
        palette2(i + 128) = colour

        colour = PaletteColour(idiv2, idiv3, i)
        palette3(i) = colour
        palette3(i + 128) = colour

        colour = PaletteColour(i, i, i)
        palette4(i) = colour
        palette4(i + 128) = colour
    NEXT i
    FOR i = 63 TO 0 STEP -1
        idiv2 = i / 2
        idiv3 = i / 3

        colour = PaletteColour(idiv3, i, idiv2)
        palette1(i + 64) = colour
        palette1(i + 192) = colour

        colour = PaletteColour(i, idiv2, idiv3)
        palette2(i + 64) = colour
        palette2(i + 192) = colour

        colour = PaletteColour(idiv2, idiv3, i)
        palette3(i + 64) = colour
        palette3(i + 192) = colour

        colour = PaletteColour(i, i, i)
        palette4(i + 64) = colour
        palette4(i + 192) = colour
    NEXT i

    index = 0
    DO WHILE INKEY$ = ""
        IF index = 0 THEN
            PALETTE USING palette1
        ELSEIF index = 1 THEN
            PALETTE USING palette2
        ELSEIF index = 2 THEN
            PALETTE USING palette3
        ELSE
            PALETTE USING palette4
        END IF

        SLEEP 1

        index = index + 1
        IF index > 3 THEN index = 0
    LOOP
END SUB

SUB LoadRawScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)
    OPEN filename FOR BINARY AS #1
    DIM colour AS INTEGER
    DIM yw AS LONG

    FOR y = 0 TO h - 1
        yw = y * w
        FOR x = 0 TO w - 1
            position = (x + yw)
            GET #1, position + 1, colour
            PSET (x, y), colour
        NEXT x
    NEXT y
    CLOSE #1
END SUB
