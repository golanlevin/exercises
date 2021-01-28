c, d = None, None

def setup():
  size(800, 800)
  global c, d
  c= color(random(255), random(255), random(255))
  d= color(random(255), random(255), random(255))


def draw():
  global c, d
  for x in range(width): # loop through every x
    p = lerpColor(c, d, 1.0* x/width)
    stroke(p)
    line(x, 0, x, height)


def mousePressed():
  global c, d
  c= color(random(255), random(255), random(255))
  d= color(random(255), random(255), random(255))
