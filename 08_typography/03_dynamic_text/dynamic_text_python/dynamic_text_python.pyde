myFont = None
tSize = None
tPos = None

def setup():
    size(800, 800)
    global myFont
    myFont = createFont("Georgia", 96)

    background(253)
    global tSize
    tSize = 10
    global tPos
    tPos = height * 0.8
    
def draw():
    global myFont
    global tSize
    global tPos
    if (frameCount < 50):
        tSize *= 1.05
        tPos = tPos - 6.0
        
        noStroke()
        fill(255, 255, 255, 20)
        rect(0, 0, width, height)
        
        textFont(myFont, tSize)
        textAlign(CENTER)
        fill(0)
        drawWord()
    elif (frameCount == 50):
        fill(255)
        textFont(myFont, tSize)
        textAlign(CENTER)
        text("GROW", 400, tPos)

def drawWord():
    for dy in range(-2, 3, 2):
        for dx in range(-2, 3, 2):
            text("GROW", width/2-dx, tPos+dy)
            
def keyPressed():
    if (key == ' '):
        saveFrame("text_with_feeling.png")
        
