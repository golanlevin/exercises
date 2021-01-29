# Word finder 
#
# Text from "This Is Not a Small Voice" by Sonia Sanchez, 1995
# https://poets.org/poem/not-small-voice


poem = ["This is not a small voice", 
        "you hear              this is a large", 
        "voice coming out of these cities.", 
        "This is the voice of LaTanya.", 
        "Kadesha. Shaniqua. This", 
        "is the voice of Antoine.", 
        "Darryl. Shaquille."]

myFont = None

def setup():
    size(800, 800)
    global myFont
    myFont = createFont("Sentinel-Medium", 64)

def draw():
    background(253)
    pushMatrix()
    translate(80, 120)
    
    global myFont, poem
    textFont(myFont, 48)
    textAlign(LEFT, BASELINE)
    textSpacing = 96
    
    # Choose the "word of interest"
    myWord = "voice"
    if (second()%2 == 0):
        myWord = "This"

    # Display the text. 
    fill(0, 0, 0)
    for i in range(len(poem)):
        text(poem[i], 0, i*textSpacing)

    # Find and highlight the word's instances
    noStroke()
    fill(200) 
    wordWidth = textWidth(myWord)
    for i in range(len(poem)):
        aLine = poem[i]
        wordLoc = aLine.find(myWord)
        if (wordLoc >= 0):
            prefix = aLine[0:wordLoc]
            prefixWidth = textWidth(prefix)
            px = prefixWidth
            py = i*textSpacing + 4
            rect(px, py, wordWidth, 14)
    
    popMatrix()


def keyPressed():
    if (key == ' '):
        saveFrame("word_finder.png")
