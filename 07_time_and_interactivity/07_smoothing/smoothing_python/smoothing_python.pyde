mx = [0]*100
my = [0]*100 

def setup():
  size(400, 400) 

def mousePressed():
  background(255)
  for i in range(100):
    mx[i] = mouseX
    my[i] = mouseY

def draw():
  noStroke()
  fill(200, 200, 200, 20)

  rect(0, 0, width, height)

  noFill()
  stroke(0)
  beginShape()
  for i in range(100):
    vertex(mx[i], my[i])
  endShape(); 

  if (mousePressed):
    for i in range(99): 
      mx[i] = mx[i+1]
      my[i] = my[i+1]
    mx[99] = mouseX;
    my[99] = mouseY
  else:
    for i in range(99):
      mx[i] = (mx[i-1] + mx[i] + mx[i+1])/3.0
      my[i] = (my[i-1] + my[i] + my[i+1])/3.0
