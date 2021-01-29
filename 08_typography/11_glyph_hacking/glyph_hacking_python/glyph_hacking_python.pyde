add_library('geomerative')

myShapeGroup = None
points = []

def setup():
  size(800, 800)
  smooth()

  RG.init(this)
  global myShapeGroup
  myShapeGroup = RG.getText("G", "RobotoCondensed-Bold.ttf", 600, CENTER)
  
def draw():
    background(253)
    fill(230)
    stroke(0)
    strokeWeight(2)
    strokeJoin(ROUND)
    
    global myShapeGroup, points
    
    RG.setPolygonizer(RG.ADAPTATIVE)
    RG.setPolygonizer(RG.UNIFORMLENGTH)
    RG.setPolygonizerLength(1.5)
    nGlyphs = len(myShapeGroup.children)
    
    # Draw unmodified glyph
    for g in range(nGlyphs):
        aGlyph = myShapeGroup.children[g]
        points = aGlyph.getPoints()
        nPoints = len(points)
    
        beginShape()
        for i in range(nPoints):
            px = points[i].x
            py = points[i].y
            px += width*0.235
            py += height*0.75 
            vertex(px, py)
        endShape(CLOSE)

    # Draw modified glyph
    for g in range(nGlyphs):
        aGlyph = myShapeGroup.children[g]
        points = aGlyph.getPoints()
        nPoints = len(points)
    
        amplitude = 6.0
        frequency = 37 
        beginShape()
        for i in range(nPoints):
            px = points[i].x
            py = points[i].y
        
            # Make it puffy
            t = map(i, 0, nPoints, 0, TWO_PI)
            px += amplitude * sin(frequency*t)
            py += amplitude * cos(frequency*t + PI)
        
            px += width*0.70
            py += height*0.75
            vertex(px, py)
        
        endShape(CLOSE)
  
  
def keyPressed():
  if (key == ' '):
    saveFrame("glyph_hacking.png")
  
  
