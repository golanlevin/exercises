words = None
myFont = None 

def setup():
    size(800, 800)
    
    global myFont
    myFont = createFont("Century", 64)
    
    global words
    words = [None] * 3
    words[0] = "perspicacious"
    words[1] = "polyphiloprogenitive"
    words[2] = "piglet"


def draw():
    background(253)
    
    margin = 40
    targetTextWidth = width - 2*margin
  
    # draw borders
    noFill()
    stroke(0) 
    strokeWeight(6)
    line(margin-3, margin, margin-3, height-margin)
    line(width-margin+3, margin, width-margin+3, height-margin)
  
    global words
    global myFont
    nWords = len(words)
    
    y = margin + 50;
    
    fill(0)
    textAlign(CENTER, TOP)
    
    for i in range(nWords):
        word = words[i]
        wordFontSize = 1.0
        textFont(myFont, wordFontSize)
        while (textWidth(word) < targetTextWidth):
            wordFontSize += 0.01
            textFont(myFont, wordFontSize)
        text(word, width/2, y)
        y += wordFontSize * 1.2

def keyPressed():
  saveFrame("procrustean_typography.png")
