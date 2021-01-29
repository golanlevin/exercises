myFont = None
whichColor = 0
mostRecentKey = ' '
pg = None

def setup():
    size(800, 800)
    global myFont
    myFont = createFont("Gotham-Black", 256)
    textFont (myFont, 256)
    textAlign(CENTER, CENTER)
    
    global pg
    pg = createGraphics(800, 800)
    pg.beginDraw()
    pg.textFont(myFont, 256)
    pg.textAlign(CENTER, CENTER)
    pg.background(253)
    pg.endDraw()

def draw():
    global pg
    image(pg, 0, 0)
    
    global whichColor
    fill (whichColor*253, 64)
    pushMatrix()
    translate(mouseX, mouseY)
    text(key, 0, 0)
    popMatrix()

def mouseReleased():
    global pg
    global whichColor
    pg.beginDraw(); 
    pg.fill(whichColor*253); 
    pg.pushMatrix();
    pg.translate(mouseX, mouseY); 
    pg.text(key, 0, 0);
    pg.popMatrix(); 
    pg.endDraw();


def keyPressed():
    global pg
    global whichColor
    global mostRecentKey
    if (key == mostRecentKey):
        whichColor = 1-whichColor
    if (key == ' '):
        pg.beginDraw()
        pg.background(whichColor * 253)
        pg.endDraw()
    elif (key == TAB):
        saveFrame("letter_collage.png")
    mostRecentKey = key; 
