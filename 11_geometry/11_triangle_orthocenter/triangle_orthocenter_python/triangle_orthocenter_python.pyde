A, B, C = None, None, None

def setup():
  size(800, 800) 
  reset()


def draw() :
  background(253)
  
  stroke(0)
  strokeWeight(8)
  
  global A, B, C
  
  # draw triangle
  line(A.x, A.y, B.x, B.y)
  line(A.x, A.y, C.x, C.y)
  line(C.x, C.y, B.x, B.y)
  
  drawOrthoCenter()


def drawOrthoCenter() : 

  global A, B, C
    
  CDrop = drawPerpendicularLine(A, B, C)
  BDrop = drawPerpendicularLine(C, A, B)
  ADrop = drawPerpendicularLine(C, B, A)
  
  # find the intersection between two of the "altitudes"
  P1 = A 
  P2 = ADrop
  P3 = B
  P4 = BDrop
  ua = ((P4.x-P3.x)*(P1.y-P3.y) - (P4.y-P3.y)*(P1.x-P3.x))/((P4.y-P3.y)*(P2.x-P1.x) - (P4.x-P3.x)*(P2.y-P1.y))
  ub = ((P2.x-P1.x)*(P1.y-P3.y) - (P2.y-P1.y)*(P1.x-P3.x))/((P4.y-P3.y)*(P2.x-P1.x) - (P4.x-P3.x)*(P2.y-P1.y))
  x = P1.x + ua * (P2.x-P1.x)
  y = P1.y + ua * (P2.y-P1.y)
  
  ellipseMode(CENTER) 
  
  fill(0) 
  strokeWeight(8)

  ellipse(A.x, A.y, 24, 24) 
  ellipse(B.x, B.y, 24, 24) 
  ellipse(C.x, C.y, 24, 24) 
  
  fill(0, 255, 0)
  ellipse(x, y, 32, 32)
 



# draw perpendicularLine from P3 to line segment P1-P2
# return the coordinates of the point where the altitude crosses the opposite side
def drawPerpendicularLine(P1, P2, P3) :
    # http:#paulbourke.net/geometry/pointlineplane/
  numer = ((P3.x-P1.x)*(P2.x-P1.x) + (P3.y-P1.y)*(P2.y-P1.y))
  denom = ((P2.x-P1.x)*(P2.x-P1.x) + (P2.y-P1.y)*(P2.y-P1.y))
  u = numer / denom
   
  px = P1.x + u*(P2.x - P1.x)
  py = P1.y + u*(P2.y - P1.y)
  pPerp = PVector(px, py)
  
  line(px, py, P3.x, P3.y)
  drawSquare(pPerp, P3)
  
  return pPerp


def drawSquare(p0, p1) :
  slope = (p0.y - p1.y)/(p0.x - p1.x)
  rad = atan(slope)
  if (p1.x - p0.x < 0) :
    rad += PI
  
  pushMatrix()
  translate(p0.x, p0.y)
  rotate(rad)
  noFill()
  strokeWeight(2)
  rect(0, 0, 30, 30)
  popMatrix()



def mousePressed() :
  reset()

def reset() :
  global A, B, C
  A = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0) 
  B = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
  C = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
  # A = PVector(191, 115, 0) 
  # B = PVector(141, 699, 0) 
  # C = PVector(694, 286, 0)
