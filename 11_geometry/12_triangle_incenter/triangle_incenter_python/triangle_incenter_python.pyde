A, B, C = None, None, None

def setup():
  size(800, 800) 

  reset()

def draw():
  background(253)
  
  global A, B, C
  
  stroke(0)
  strokeWeight(8)
  
  # draw triangle
  line(A.x, A.y, B.x, B.y)
  line(A.x, A.y, C.x, C.y)
  line(C.x, C.y, B.x, B.y)
  
  drawIncenter()


def drawIncenter():
  strokeWeight(8)

  global A, B, C
  
  # find incenter
  AB = PVector.sub(A, B)
  BC = PVector.sub(C, B)
  AC = PVector.sub(A, C)
  a = BC.mag()
  b = AC.mag()
  c = AB.mag()
  x = (a * A.x + b * B.x + c * C.x) / (a + b + c) 
  y = (a * A.y + b * B.y + c * C.y) / (a + b + c) 
  
  # find inradius
  # semi-perimeter of the circle 
  p = (a + b + c) / 2 
  
  # area of the traingle 
  area = sqrt(p * (p - a) * (p - b) * (p - c)) 
  
  # Radius of the incircle 
  radius = area / p 
  
  strokeWeight(2)
  line(x, y, A.x, A.y)
  line(x, y, B.x, B.y)
  line(x, y, C.x, C.y)
  
  drawMarks(A, B, C, x, y, 1)
  drawMarks(B, C, A, x, y, 2)
  drawMarks(C, A, B, x, y, 3)

  fill(0) 
  ellipse(A.x, A.y, 24, 24) 
  ellipse(B.x, B.y, 24, 24) 
  ellipse(C.x, C.y, 24, 24) 
    
  noFill()
  strokeWeight(2)
  ellipse(x, y, radius*2, radius*2)
  strokeWeight(8)
  fill(0, 255, 0)
  ellipse(x, y, 32, 32)

def drawMarks(a, b, c, x, y, n):
  slope_AB = (a.y-b.y)/(a.x-b.x)
  slope_BC = (b.y-c.y)/(b.x-c.x)
  slope_B_center = (y-b.y)/(x-b.x)
  
  dist = 12
  l = 100 - dist*(n/2)
  
  noFill()
  
  rad_AB = atan(slope_AB)
  if ((a.x-b.x) < 0):
    rad_AB += PI
  
  rad_center = atan(slope_B_center)
  if ((x-b.x) < 0):
    rad_center += PI

  rad_BC = atan(slope_BC)
  if (c.x-b.x < 0):
    rad_BC += PI
  
  for i in range(n):
    if (max(rad_AB, rad_center) > PI and min(rad_AB, rad_center) < 0):
      arc(b.x, b.y, l+i*dist-dist/2, l+i*dist-dist/2, max(rad_AB, rad_center), min(rad_AB, rad_center)+2*PI)
    else:
      arc(b.x, b.y, l+i*dist-dist/2, l+i*dist-dist/2, min(rad_AB, rad_center), max(rad_AB, rad_center))
    
    if (max(rad_center, rad_BC) > PI and min(rad_center, rad_BC) < 0):
       arc(b.x, b.y, l+i*dist, l+i*dist, max(rad_center, rad_BC), min(rad_center, rad_BC)+2*PI)
    else:
       arc(b.x, b.y, l+i*dist, l+i*dist, min(rad_center, rad_BC), max(rad_center, rad_BC))
    

def mousePressed():
  reset()

def reset():
  global A, B, C
  A = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0) 
  B = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
  C = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
  # A = PVector(191, 115, 0) 
  # B = PVector(141, 699, 0) 
  # C = PVector(694, 286, 0) 
