# Text along a (Bezier) curve.

# See, for reference: 
# https://processing.org/reference/bezierPoint_.html
# https://processing.org/reference/curvePoint_.html

myFont = None
ctrlPts = None 

def setup():
    size(800, 800)
    
    global myFont, ctrlPts
    
    myFont = createFont("BirchStd", 72)
    
    ctrlPts = [None] * 4 
    ctrlPts[0] = PVector(45, 95)
    ctrlPts[1] = PVector(265, 45)
    ctrlPts[2] = PVector(155, 315)
    ctrlPts[3] = PVector(355, 360)
    ctrlPts[0].mult(2)
    ctrlPts[1].mult(2)
    ctrlPts[2].mult(2)
    ctrlPts[3].mult(2)


def draw():
    background(253)
    
    global myFont, ctrlPts
    
    ax = ctrlPts[0].x
    ay = ctrlPts[0].y
    bx = ctrlPts[1].x
    by = ctrlPts[1].y
    cx = ctrlPts[2].x
    cy = ctrlPts[2].y
    dx = ctrlPts[3].x
    dy = ctrlPts[3].y
  
    # From https://www.azquotes.com/quotes/topics/curves.html
    # "Magic lives in curves, not angles." -- Mason Cooley
    phrase = "magic lives in curves";

    noFill()
    stroke(200)
    strokeWeight(2)
    bezier(ax, ay, bx, by, cx, cy, dx, dy)
  
    noStroke()
    fill(0,0,0)
    textFont(myFont)
    textAlign(CENTER)
  
    nChars = len(phrase)
    
    for i in range(nChars):
        # First, calculate the position of the i'th letter. 
        u = map(i, 0, nChars-1, 0,1)
        px = bezierPoint(ax, bx, cx, dx, u)
        py = bezierPoint(ay, by, cy, dy, u)
        
        # We need a second point to calculate the local slope.
        v = u + 0.01
        qx = bezierPoint(ax, bx, cx, dx, v)
        qy = bezierPoint(ay, by, cy, dy, v)
        tx = qx - px
        ty = qy - py
        orientation = atan2(ty, tx)
        
        # Fetch the i'th letter
        ithChar = phrase[i]
        
        # Render it at the position, with the orientation. 
        pushMatrix()
        translate(px, py)
        rotate(orientation)
        text(ithChar, 0,-5)
        popMatrix()

def keyPressed():
    saveFrame("type_along_a_curve.png")
