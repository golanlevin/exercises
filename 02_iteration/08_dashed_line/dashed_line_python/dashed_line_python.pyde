# Dashed line

def setup() :
  size(800, 800)
  smooth() 


def draw() :
  background(253) 

  #these x and y values represent the line from the point to your cursor
  x0 = width * 0.75
  y0 = height * 0.25
  x1 = mouseX
  y1 = mouseY 

  dashLength = 50.0 
  lineLength = dist(x0, y0, x1, y1) 
  nDashesf = (lineLength / dashLength)

  noStroke()
  fill(0)
  strokeWeight(8)
  ellipse(x0, y0, 20, 20) 

  #splits the calculated line into multiple lines, making dashes
  for i in range(0, int(nDashesf)):
    percentA = map(i+0.0, 0, nDashesf, 0, 1)
    percentB = map(min(i+0.6, nDashesf), 0, nDashesf, 0, 1)

    dashXa = map(percentA, 0, 1, x0, x1) 
    dashYa = map(percentA, 0, 1, y0, y1)
    dashXb = map(percentB, 0, 1, x0, x1) 
    dashYb = map(percentB, 0, 1, y0, y1)

    stroke(0)
    line (dashXa, dashYa, dashXb, dashYb)
