A = PVector(191, 115, 0)
B = PVector(141, 699, 0)
C = PVector(694, 286, 0)

cursorImg = None
myFont = None

def setup():
  size(800, 800)
  
  global cursorImg, myFont
  
  cursorImg = loadImage("cursor_with_shadow_15x21.png")
  myFont = loadFont("CenturySchoolbook-60.vlw")
  textFont(myFont, 60)


def draw():
  background(253)
  global A, B, C

  stroke(0)
  strokeWeight(8)

  # draw triangle
  line(A.x, A.y, B.x, B.y)
  line(A.x, A.y, C.x, C.y)
  line(C.x, C.y, B.x, B.y)

  drawCentroid()
  

def drawCentroid():
  global A, B, C

  AB_mid = PVector((A.x + B.x)/2, (A.y + B.y)/2)
  BC_mid = PVector((C.x + B.x)/2, (C.y + B.y)/2)
  CA_mid = PVector((A.x + C.x)/2, (A.y + C.y)/2)

  strokeWeight(2)
  line(A.x, A.y, BC_mid.x, BC_mid.y)
  line(AB_mid.x, AB_mid.y, C.x, C.y)
  line(CA_mid.x, CA_mid.y, B.x, B.y)

  ellipseMode(CENTER)
  strokeWeight(8)

  fill(0)
  ellipse(A.x, A.y, 24, 24)
  ellipse(B.x, B.y, 24, 24)
  ellipse(C.x, C.y, 24, 24)

  # draw centroid
  centroid = PVector((A.x + B.x + C.x)/3, (A.y + B.y + C.y)/3)
  fill(0, 255, 0)
  ellipse(centroid.x, centroid.y, 32, 32)

  # draw tick marks
  drawTick(B, AB_mid, 1)
  drawTick(AB_mid, A, 1)
  drawTick(A, CA_mid, 2)
  drawTick(CA_mid, C, 2)
  drawTick(B, BC_mid, 3)
  drawTick(BC_mid, C, 3)

def drawTick(p1, p2, n):
  strokeWeight(2)
  tickLen = 20
  
  midpoint = p1.copy().add(p2).div(2)
  slope = (p2.y-p1.y)/(p2.x-p1.x)
  rad = atan(slope)
  tickRad = atan(-1/slope)
  
  for i in range(n):
    x = midpoint.x + (i-n/2)*tickLen/2*cos(rad)
    y = midpoint.y + (i-n/2)*tickLen/2*sin(rad)
    line(x-cos(tickRad)*tickLen, y-sin(tickRad)*tickLen, x+cos(tickRad)*tickLen, y+sin(tickRad)*tickLen)

def mousePressed():
  reset()

def keyPressed():
  if (key == ' '):
    saveFrame("centroid_of_a_triangle.png")
  else:
    reset()

def reset():
  A = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
  B = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
  C = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
