REM A script to show the raw screen data saved in MANDELBR.BAS

DECLARE SUB LoadRawScreen (filename AS STRING, w AS INTEGER, h AS INTEGER)

SCREEN 13
CLS
LINE(0,0)-(320-200), 15, BF

CALL LoadRawScreen("SCREEN.RAW", 320, 200)

SUB LoadRawScreen(filename AS STRING, w AS INTEGER, h AS INTEGER)

  OPEN filename FOR BINARY AS #1
  DIM colour AS INTEGER
  
  FOR y = 0 TO h - 1
    
    FOR x = 0 TO w - 1
    
      position = (x + (Y * w))
      
      GET #1, position + 1, colour
      
      PSET (x, y), colour
      
    NEXT x
  
  NEXT y
  
  CLOSE #1
  
END SUB
