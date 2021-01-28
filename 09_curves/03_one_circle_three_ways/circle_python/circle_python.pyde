def setup():
  size(800, 800)

def draw():
  background(253)
  
  nPoints = 20
  radius = 300
  separation = 125

  # draw the circle normally
  pushMatrix()
  translate(width/2, height/ 2)
  noFill()
  stroke(0)
  strokeWeight(8)
  beginShape()
  for i in range(nPoints): 
    theta = map(i, 0, nPoints, 0, TWO_PI)
    px = radius * cos(theta)
    py = radius * sin(theta)
    vertex(px, py)
  endShape(CLOSE)
  popMatrix()
  
  pushMatrix()
  translate(width/2, height/ 2)
  fill(0)
  noStroke()
  for i in range(nPoints): 
    theta = map(i, 0, nPoints, 0, TWO_PI)
    px = radius * cos(theta)
    py = radius * sin(theta)
    ellipse(px, py, 24, 24)
  popMatrix()
