myRegularFont = None
myItalicFont = None
cursorImg = None
theWord = None
tx, ty = 0, 0
ux, uy = 0, 0


def setup():
    size(800, 800)
    
    global myRegularFont, myItalicFont, cursorImg, theWord, ux, uy, tx, ty
    myRegularFont = createFont("Helvetica-Bold", 72)
    myItalicFont = createFont("Helvetica-BoldOblique", 72)
    cursorImg = loadImage("cursor_with_shadow_15x21.png")
    theWord = "avoid"
    
    ux = tx = width/2
    uy = ty = height/2

def draw():
    noStroke()
    fill(253, 50)
    rect(0, 0, width, height)
    
    global myRegularFont, myItalicFont, cursorImg, theWord, ux, uy, tx, ty

    # Compute the text's bounding box
    rw = textWidth(theWord)
    rh = textAscent() + textDescent()
    rx = tx - rw/2
    ry = ty - rh/2
    
    textFont(myRegularFont, 144)
    # Check to see if the mouse is in the box,
    # and update the text's target position.
    bMoving = False; 
    if ((mouseX > rx) and (mouseX < (rx+rw)) and 
            (mouseY > ry) and (mouseY < (ry+rh))):
        dx = mouseX - tx
        dy = mouseY - ty
        avoidAmount = 1.2
        ux = tx - avoidAmount * dx
        uy = ty - avoidAmount * dy
        bMoving = True
  
        # Draw the text
        if (bMoving):
            textFont(myItalicFont, 144) 
        else:
            textFont(myRegularFont, 144)
            
    textAlign(CENTER, CENTER)
    fill(0, 0, 0)
    text(theWord, tx, ty)
  
    # Interpolate the text position to target position, 
    # using Zeno's method (simple easing)
    A = 0.96
    B = 1.0-A
    tx = A*tx + B*ux
    ty = A*ty + B*uy

    # Draw the cursor (for print output)
    image(cursorImg, mouseX, mouseY, 15*6, 21*6)

def keyPressed():
    if (key == ' '):
        saveFrame("responsive_text.png")
    else:
        background(253)
        ux = tx = width/2
        uy = ty = height/2
