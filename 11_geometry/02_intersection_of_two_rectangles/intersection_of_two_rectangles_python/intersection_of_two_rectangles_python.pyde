A1, A2, B1, B2 = None, None, None, None
cursorImg, myFont = None, None

dot_diameter = 24
color_dot_diameter = 32

def setup():
  size(800, 800)
  
  global cursorImg, myFont
  
  cursorImg = loadImage("cursor_with_shadow_15x21.png")
  myFont = loadFont("CenturySchoolbook-60.vlw")
  
  textFont(myFont, 60)
  reset();

def draw():
  global A1, A2, B1, B2
  
  background(253)
  stroke(0)

  # the first two parameters of rect() as the location of one corner, and the third and fourth parameters as the location of the opposite corner
  rectMode(CORNERS)
  
  # draw two rectangles
  noFill()
  strokeWeight(8)
  rect(A1.x, A1.y, A2.x, A2.y)
  rect(B1.x, B1.y, B2.x, B2.y)
  
  A_mid = PVector((A1.x + A2.x)/2, (A1.y + A2.y)/2)
  B_mid = PVector((B1.x + B2.x)/2, (B1.y + B2.y)/2)
  intersect(A1, A2, B1, B2)
    

def mousePressed():
  reset()

# Returns true if two rectangles (l1, r1) and (l2, r2) overlap 
def intersect(l1, r1, l2, r2):
  
  # If one rectangle is on left side of other 
  if (l1.x >= r2.x or l2.x >= r1.x):
    return False
  
  # If one rectangle is above other 
  if (l1.y >= r2.y or l2.y >= r1.y):
      return False
  
  corner1 = PVector(max(l1.x, l2.x), max(l1.y, l2.y))
  corner2 = PVector(min(r1.x, r2.x), min(r1.y, r2.y))
  strokeWeight(3)
  line(corner1.x, corner1.y, corner2.x, corner2.y)
  line(corner1.x, corner2.y, corner2.x, corner1.y)
  return True

def keyPressed():
    reset()

def reset():
  global A1, A2, B1, B2
    
  A1 = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0) 
  A2 = PVector(random(A1.x+10, width*0.9), random(A1.y+10, height*0.9), 0)
  B1 = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
  B2 = PVector(random(B1.x+10, width*0.9), random(B1.y+10, height*0.9), 0)
  # A1 = PVector(120, 100) 
  # A2 = PVector(500, 420) 
  # B1 = PVector(250, 250)
  # B2 = PVector(650, 700)
