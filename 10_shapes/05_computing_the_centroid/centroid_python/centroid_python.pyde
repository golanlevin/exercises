# The following two arrays define a sequence of x-values, 
# and a sequence of y-values, which describe a certain shape or polygon. 
# 
# (1) In a canvas of size 300x250 pixels, plot this shape.
# You should use array.length to automatically determine 
# the number of points to plot. Also, use beginShape()/endShape() 
# to plot the polygon.
#
# (2) The "centroid" of a set of points is defined as a location, whose:
# x-coordinate is the average of the x-coordinates of the points, and whose
# y-coordinate is the average of the y-coordinates of the points.
# Compute and plot the centroid of this shape, using a small crosshair.

xData = [81, 83, 83, 83, 83, 82, 79, 77, 80, 83, 
  84, 85, 84, 90, 94, 94, 89, 85, 83, 75, 
  71, 63, 59, 60, 44, 37, 33, 21, 15, 12, 
  14, 19, 22, 27, 32, 35, 40, 41, 38, 37, 
  36, 36, 37, 43, 50, 59, 67, 71]
  
yData = [10, 17, 22, 27, 33, 41, 49, 53, 67, 76, 
  93, 103, 110, 112, 114, 118, 119, 118, 121, 121, 
  118, 119, 119, 122, 122, 118, 113, 108, 100, 92, 
  88, 90, 95, 99, 101, 80, 62, 56, 43, 32, 
  24, 19, 13, 16, 23, 22, 24, 20]

heart = None
mag = 5

def setup():
  size(800, 800)
  global heart
  heart = loadImage("heart.png") 
  noLoop()


def draw():
  global xData, yData, mag, heart

  background(253) 
  fill(229) 
  stroke(0) 
  strokeJoin(MITER) 
  strokeWeight(6.0/mag)

  pushMatrix() 
  scale(mag)
  translate(23, 9)
  cx = 0 
  cy = 0 

  beginShape()
  for i in range(len(xData)):
    px = xData[i]
    py = yData[i]
    cx += px 
    cy += py 
    vertex(px, py)
  
  endShape(CLOSE) 

  cx /= len(xData)
  cy /= len(yData) 
  imageMode(CENTER)
  image(heart, cx, cy, heart.width/40.0, heart.height/40.0) 

  fill(0) 
  noStroke() 
  for i in range(len(xData)):
    px = xData[i]
    py = yData[i]
    ellipse(px, py, 3.6, 3.6)

  popMatrix()
