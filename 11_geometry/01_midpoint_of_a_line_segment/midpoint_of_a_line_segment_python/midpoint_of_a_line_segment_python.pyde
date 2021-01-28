A, B = None, None 
myFont = None

def setup():
  size(800, 800); 
  
  global myFont, A, B
  myFont = loadFont("CenturySchoolbook-72.vlw")
  textFont(myFont, 72)
  
  A = PVector(width*0.22, height*0.65)
  B = PVector(width*0.75, height*0.3)

def draw():
  background(253)
  
  global A, B
  
  dx = B.x-A.x
  dy = B.y-A.y
  dh = sqrt(dx*dx + dy*dy)

  midx = A.x+dx/2
  midy = A.y+dy/2
  
  stroke(0)
  strokeWeight(8)
  line(A.x, A.y, B.x, B.y)
  
  # Draw end points and midpoint
  fill(0)
  noStroke()
  ellipseMode(CENTER)
  ellipse(A.x, A.y, 24, 24)
  ellipse(B.x, B.y, 24, 24)
  ellipse(midx, midy, 32, 32)

  # Draw one-third point
  stroke(0)
  strokeWeight(8)
  fill(0, 255, 0)
  x3 = lerp(A.x, B.x, 1.0/3.0)
  y3 = lerp(A.y, B.y, 1.0/3.0)
  ellipse(x3, y3, 32, 32)
  
  # Draw text labels
  fill(0)
  textAlign(CENTER, CENTER)
  dist = 70
  text("A", A.x - dist*dx/dh, A.y - dist*dy/dh)
  text("B", B.x + dist*dx/dh, B.y + dist*dy/dh)


def mousePressed():
  reset()
  

def reset():
  global A, B
  A = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
  B = PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0)
