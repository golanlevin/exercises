mx = 0
my = 0

def setup():
  size(400,400)
  noStroke()

def draw():
  background(200)
  global mx, my
  ellipse(mx, my, 30, 30)
  mx = 0.95*mx + 0.05*mouseX 
  my = 0.95*my + 0.05*mouseY 
