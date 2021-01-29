myFont = None
typedText = "type:"

def setup():
    size(800, 800)
    global myFont
    myFont = createFont("Courier-Bold", 72)

def draw():
    background(253)
    fill(0)
    
    textX = width * 0.925
    textY = height/2 - 5
    
    global myFont
    global typedText
    
    textFont(myFont, 72)
    textAlign(RIGHT, CENTER)
    text(typedText, textX, textY)
    
    # draw a simple text-cursor
    stroke(0)
    strokeWeight(8)
    line(textX, textY+50, textX, textY-45)
    
def keyPressed():
    global typedText
    if (key == TAB):
        saveFrame("one_line_typewriter.png")
    elif ((key == RETURN) or (key == ENTER)):
        typedText = ""
    elif (key == BACKSPACE):
        l = len(typedText)
        if (l > 0):
            typedText = typedText[:l-1]
    elif (20 <= ord(key) <= 126):
        typedText += key
    
    
    
