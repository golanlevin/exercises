def setup():
  size(800, 800)
  noLoop() 


def draw():
  background(253) 
  fill(229) 
  stroke(0)
  strokeJoin(ROUND)
  strokeWeight(8) 
  

  nVertices = 55 
  cx = width/2
  cy = height/2 
  beginShape() 
  for i in range(nVertices):
    t = map(i, 0, nVertices, 0, TWO_PI) 
    radius = 260 + random(-8,8) 
    px = cx + radius * cos(t) 
    py = cy + radius * sin(t) 
    curveVertex(px, py)
  
  endShape(CLOSE)
