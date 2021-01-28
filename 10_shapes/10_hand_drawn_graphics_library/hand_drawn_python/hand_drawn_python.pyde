# Press l, r, e, to switch between drawing lines, rectangles, and ellipses.

mode = None

DRAW_LINE = 0
DRAW_ELLIPSE = 1
DRAW_RECTANGLE = 2

lines = []
rectangles = []
ellipses = []

curP, cursor = None, None

def setup():
  size(800, 800)

  global mode, cursor

  mode = DRAW_LINE
  reset()
  frameRate(24)
  
  cursor = loadImage("cursor_with_shadow_15x21.png")


def draw():
  background(253)

  global mode, curP, cursor, DRAW_LINE, DRAW_ELLIPSE, DRAW_RECTANGLE, lines, rectangles, ellipses
  
  if (mode == DRAW_LINE):
    if (curP != None):
      l = LineHand(curP, PVector(mouseX, mouseY))
      l.show()
    
  elif (mode == DRAW_RECTANGLE):
    if (curP != None):
      r = RectHand(curP, PVector(mouseX, mouseY))
      r.show()
    
  elif (mode == DRAW_ELLIPSE):
    if (curP != None):
      e = EllipseHand(curP, PVector(mouseX, mouseY))
      e.show()
  
  for l in lines:
    l.show()

  for r in rectangles:
    r.show()
  
  for e in ellipses:
    e.show()
  
  image(cursor, mouseX, mouseY, 90, 126)


def reset():
  global lines, rectangles, ellipses
  lines = []
  rectangles = []
  ellipses = []


def mousePressed():
  global mode, cursor, curP, DRAW_LINE, DRAW_ELLIPSE, DRAW_RECTANGLE, lines, rectangles, ellipses

  if (mode == DRAW_LINE):
    if (curP is None):
      curP = PVector(mouseX, mouseY)
    else:
      p = PVector(mouseX, mouseY)
      l = LineHand(curP, p)
      curP = None
      lines.append(l)
    
  elif (mode == DRAW_RECTANGLE):
    if (curP is None):
      curP = PVector(mouseX, mouseY)
    else:
      p = PVector(mouseX, mouseY)
      r = RectHand(curP, p)
      curP = None
      rectangles.append(r)
    
  elif (mode == DRAW_ELLIPSE):
    if (curP is None):
      curP = PVector(mouseX, mouseY)
    else:
      p = PVector(mouseX, mouseY)
      e = EllipseHand(curP, p)
      curP = None
      ellipses.append(e)
    
  
def keyPressed():
  global mode, DRAW_LINE, DRAW_ELLIPSE, DRAW_RECTANGLE

  if (key == 'r'):
    mode = DRAW_RECTANGLE
  elif (key == 'l'):
    mode = DRAW_LINE
  elif (key == 'e'):
    mode = DRAW_ELLIPSE
  elif (key == 'c'):
    reset()
  elif (key == ' '):
    saveFrame("hand_drawn.png")
  

class EllipseHand:
  def __init__ (self, p1, p2):
    center = p1
    radius = PVector.dist(p1, p2)
    (self.points) = []
    
    n = max(2, int(PI*2*radius/30))
    
    for i in range(n):
      r = 2*PI * i/n
      p = PVector(center.x + radius * cos(r) + (randomGaussian()-0.5)*3, 
                              center.y + radius * sin(r) + (randomGaussian()-0.5)*3)
      self.points.append(p)

  def show(self):
    noFill()
    stroke(0)
    strokeWeight(8)
    beginShape()
    p = (self.points)[0]
    curveVertex(p.x, p.y)
    for i in range(len((self.points))):
      p = (self.points)[i]
      curveVertex(p.x, p.y)
    
    p = (self.points)[len(self.points)-1]
    curveVertex(p.x, p.y)
    p = (self.points)[0]
    curveVertex(p.x, p.y)
    curveVertex(p.x, p.y)
    endShape()
  
class LineHand:
  def __init__ (self, pa, pb):
    distance = PVector.dist(pa, pb)
    n = int(distance/30) # number of (self.points)
    (self.points) = []
    (self.points).append(pa)
    for i in range(n):
      dx =  (pb.x-pa.x)*i/n + (randomGaussian()-0.5)*3
      dy =  (pb.y-pa.y)*i/n + (randomGaussian()-0.5)*3
      newP = PVector(pa.x + dx, pa.y + dy)
      (self.points).append(newP)
    
    (self.points).append(pb)
  
  
  def show(self):
    noFill()
    stroke(0)
    strokeWeight(8)
    beginShape()
    p = (self.points)[0]
    curveVertex(p.x, p.y)
    for i in range(len((self.points))):
      p = (self.points)[i]
      curveVertex(p.x, p.y)
    p = (self.points)[len((self.points))-1]
    curveVertex(p.x, p.y)
    endShape()
  
  
class RectHand:
  def __init__(self, p1, p2):
    p1_ = PVector(p1.x, p2.y)
    p2_ = PVector(p2.x, p1.y)
    
    self.topEdge = LineHand(p1, p1_)
    self.leftEdge = LineHand(p1_, p2)
    self.bottomEdge = LineHand(p2, p2_)
    self.rightEdge = LineHand(p2_, p1)    
    
  def show(self):
    self.topEdge.show()
    self.leftEdge.show()
    self.bottomEdge.show()
    self.rightEdge.show()
  
