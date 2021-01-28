def setup():
  size(800, 800)


def draw():
  background(253)
  strokeWeight(8)
  stroke(0)
  
  pushMatrix()
  translate(width/2, 0)
  for x in range(-500, 500):
    y = 700.0-pow(x, 2)/140
    point(x, y)
  popMatrix()
