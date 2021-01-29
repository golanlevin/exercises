# split_flap_type_java
# It helps to use a monospace font for this.

myFont = None;

nLetters = 0
startWord = ['B', 'A', 'R']
endWord = ['H', 'E', 'N']
currentWord = None
textY, textX = 0, 0

def setup():
    size(800, 800)
    frameRate(10)
    
    global myFont, nLetters, startWord, endWord, currentWord, textY, textX
    
    myFont = createFont("LucidaSans-Typewriter", 72)
    textX, textY = 88, 100
    
    nLetters = len(startWord) 
    currentWord = [None] * nLetters
    for i in range(nLetters):
        currentWord[i] = startWord[i]
    
    background(253)


def draw():

    global myFont, nLetters, startWord, endWord, currentWord, textY, textX

    # render the current word. 
    # as the word changes, move it downwards.
    drawCurrentWord(textX, textY)
  
    # render the current word large, 
    # in the same spot
    pushMatrix()
    translate(width/2, height/2)
    scale(2,2)
    drawCurrentWord(0,0)
    popMatrix()
    
  
    #-------------------------
    # update the current word
    bChanged = False
    for i in range(nLetters):
        if (currentWord[i] < endWord[i]):
            currentWord[i] = chr(ord(currentWord[i]) + 1)
            bChanged = True
        elif (currentWord[i] > endWord[i]):
            currentWord[i] = chr(ord(currentWord[i]) - 1)
            bChanged = True

    if (bChanged):
        textY += 100
        fill(253, 60)
        rectMode(CORNER)
        rect(0, 0, width, height)

def drawCurrentWord(tx, ty):
    textFont(myFont, 44*2)
    textAlign(CENTER, CENTER)
    rectMode(CENTER)
    boxSpacing = 36*2
    boxWidth = boxSpacing-4
    boxHeight = 46*2;
    textOffsetY = 5*2
    pushMatrix()
    translate(tx, ty)
    
    global nLetters
    for i in range(nLetters):
        px = i*boxSpacing
        py = 0
        noStroke()
        fill(0, 0, 0)
        rect(px, py, boxWidth, boxHeight)
        fill(255)
        text(currentWord[i], px-1, py - textOffsetY)
        
    popMatrix()


def keyPressed():
    if (key == ' '):
        saveFrame("split_flap_type.png")
