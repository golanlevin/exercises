def setup():
  size(800, 800)


def draw():
  background(253) 
  fill(229) 
  stroke(0) 
  strokeJoin(MITER)
  strokeWeight(8)

  nVertices = 10 
  cx = width/2
  cy = height/2 
  magicFraction = 0.38196 # (1-1/phi)

  beginShape() 
  for i in range(nVertices):
    t = HALF_PI + map(i, 0, nVertices, 0, TWO_PI) 
    radius = 300 
    if (i%2 == 0):
      radius *= magicFraction
    px = cx + radius * cos(t) 
    py = cy + radius * sin(t) 
    vertex(px, py)
  
  endShape(CLOSE)
