
def setup() :
  size(800, 800) 
  noSmooth()


def draw() :
  background (253) 
  strokeWeight(2)
  
  nRectangles = 14
  offset = 50
  w = (width-offset*2)/nRectangles
  
  for i in range(0, nRectangles):
    #finds the x and y value of the current rectangle
    x0 = offset + i * w
    y0 = height-offset
	
	  #increases the rectangle height by 25
    rectH = (i+1) * w
	  #creates a color gradient by making fill dependent on i
    fill(i* (255.0/nRectangles))
	  #draws the current rectangle
    rect(x0, y0, w, -rectH)
