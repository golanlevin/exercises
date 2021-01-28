
def setup():
  size(800, 800)
  smooth()


def draw():
  background(253)
  strokeWeight (8)
  stroke(0)

  nLines = 10
  margin = 100
  #draws n lines from equidistant starting points to the cursor location
  for i in range(0, nLines):
    x0 = map(i, 0, nLines-1, margin, width-margin) 
    y0 = margin
    line (x0, y0, mouseX, mouseY)
