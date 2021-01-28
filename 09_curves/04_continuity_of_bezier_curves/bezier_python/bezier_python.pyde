mode = None

cp1 = PVector(300, 100)
p1 = PVector(750, 200)

cp2 = PVector(300, 500)
p2 = PVector(400, 450)

cp3 = PVector(500, 400)
p3 = PVector(400, 450)

def setup():
  size(800, 800)
  strokeWeight(8)
  stroke(0)
  smooth()
  noFill()
  
  global mode
  mode = ' '
  
def draw():
  background(253)
  
  global mode, cp1, p1, cp2, p2, cp3, p3

  noFill()

  if (mode == '1'):
    p1 = PVector(mouseX, mouseY)
  elif (mode == '2'):
    p2 = PVector(mouseX, mouseY)
  elif (mode == '3'):
    p3 = PVector(mouseX, mouseY)
  elif (mode == "a"):
    cp1 = PVector(mouseX, mouseY)
  elif (mode == "b"):
    cp2 = PVector(mouseX, mouseY)
  elif (mode == 'c'):
    cp3 = PVector(mouseX, mouseY)
  

  cp2_ = PVector(p2.x + (p2.x - cp2.x), p2.y + (p2.y - cp2.y))

  stroke(0) 
  strokeWeight(3)
  line(cp1.x, cp1.y, p1.x, p1.y)
  line(cp2.x, cp2.y, cp2_.x, cp2_.y)
  line(cp3.x, cp3.y, p3.x, p3.y)
  strokeWeight(8)
  bezier(p1.x, p1.y, cp1.x, cp1.y, cp2.x, cp2.y, p2.x, p2.y)
  bezier(p2.x, p2.y, cp2_.x, cp2_.y, cp3.x, cp3.y, p3.x, p3.y)

  R = 32
  r = 24 

  stroke(0) 
  strokeWeight(8)
  fill(255, 200, 200)
  ellipse(cp1.x, cp1.y, R, R)
  ellipse(cp2.x, cp2.y, R, R)
  ellipse(cp2_.x, cp2_.y, R, R)
  ellipse(cp3.x, cp3.y, R, R)

  fill(0) 
  noStroke() 
  ellipse(p1.x, p1.y, r, r)
  ellipse(p2.x, p2.y, r, r)
  ellipse(p3.x, p3.y, r, r)

def keyPressed():
  print(key)
  global mode
  mode = key
