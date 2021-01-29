myFont = None
cellW = 64 #40 #32 #16
cellH = 80 #48 #40 #20 
nRows, nCols, nChars = 0, 0, 0
charEditIndex = 0

letters = "Meta-design is much more difficult than design; it is easier to draw something than to explain how to draw it."; 
# One of the problems is that different sets of potential specifications cannot easily be envisioned all at once. Another is that a computer has to be told absolutely everything. However, once we have successfully explained how to draw something in a sufficiently general manner, the same explanation will work for related shapes, in different circumstances.";//; so the time spent in formulating a precise explanation turns out to be worth it."

def setup():
    size(800, 800) 
    
    global charEditIndex, myFont, letters, nRows, nCols, nChars, cellW, cellH
    
    charEditIndex = len(letters)

    myFont = createFont("pixelmix", 80) # A monospace font
    textFont(myFont);

    nRows = height/cellH
    nCols = width/ cellW
    nChars = nRows*nCols
    # Pad out the text to fill the whole grid. 
    if (len(letters) < nChars):
        for i in range(len(letters), nChars): 
            letters += " "

def draw():
    background(253) 
    drawGrid()
    drawCursor()
    drawText()
    
def drawCursor():
    global charEditIndex, nRows, nCols, nChars, cellW, cellH
    
    cursorXCell = (charEditIndex%nCols) 
    cursorYCell = (charEditIndex/nCols)
    fill(255, 200, 200)

    cursorX = cursorXCell*cellW
    cursorY = cursorYCell*cellH
    rect(cursorX, cursorY+1, cellW-1, cellH-1)

def drawText():
    global letters, nRows, nCols, nChars, cellW, cellH
    
    textAlign(CENTER);
    fill(0)
    for i in range(len(letters)):
        c = letters[i]
        cx = (i%nCols)*cellW
        cy = (1 + (i/nCols))*cellH
        text(c, cx + cellW/2, cy-5)

def drawGrid():
    global nRows, nCols, nChars, cellW, cellH
    strokeWeight(2);
    stroke(200)
    for cy in range(1, nRows):
        line(0, cy*cellH+0, width, cy*cellH+0)
        line(0, cy*cellH+1, width, cy*cellH+1)
    for cx in range(1, nCols):
        line(cx*cellW+0, 0, cx*cellW+0, height) 
        line(cx*cellW-1, 0, cx*cellW-1, height)

def mousePressed():
    setEditIndexFromScreenPosition(mouseX, mouseY)

def mouseDragged():
    setEditIndexFromScreenPosition(mouseX, mouseY)
    
def setEditIndexFromScreenPosition(x, y):
    global charEditIndex, nRows, nCols, nChars, cellW, cellH

    mouseXCol = (x-2)/cellW
    mouseYRow = (y-3)/cellH
    mouseXCol = constrain(mouseXCol, 0, nCols-1)
    mouseYRow = constrain(mouseYRow, 0, nRows-1) 
    charEditIndex = mouseYRow*nCols + mouseXCol

def keyPressed():

    global charEditIndex, letters, nRows, nCols, nChars, cellW, cellH

    if (key == '~'):
        saveFrame("word_processor.png")
        return
    else:
        if (key == BACKSPACE):
            charEditIndex = (charEditIndex-1+nChars)%nChars
            newLetters = letters[0:charEditIndex]
            newLetters += ' ' + letters[charEditIndex+1:]
            letters = newLetters
        elif (key == CODED):
            if (keyCode == LEFT):
                charEditIndex = (charEditIndex-1+nChars)%nChars
            elif (keyCode == RIGHT):
                charEditIndex = (charEditIndex+1)%nChars
            elif (keyCode == DOWN):
                charEditIndex = (charEditIndex+nCols)%nChars;
            elif (keyCode == UP):
                charEditIndex = (charEditIndex-nCols+nChars)%nChars
        elif ((ord(key) >= 32) and (ord(key) <= 127)):
            newLetters = letters[0:charEditIndex]
            newLetters += key + letters[charEditIndex+1:]
            letters = newLetters;
            if (not mousePressed):
                charEditIndex = (charEditIndex+1)%nChars
