# Hexagonal Grid

sqrt3 = sqrt(3)

def setup():
  size(800, 800)
  smooth()
 
def draw() :
  background(253) 
  side = 19.05 
  nDown   = 2*height / (3*side*sqrt3)+1 
  nAcross = width / (3 * side) +1 
  j = 0
  while(j <= nAcross):
    offsetX = j * (3*side) 
    i =0
    while(i <=nDown):
      hx = offsetX + (i%2)*1.5*side 
      hy = i * side * 1.5 * sqrt3
      stroke(0)
      strokeWeight(4.0) 
      gray = random(255)
      fill (gray) 
      hexagon(hx, hy, side)
      i+=1
    j+=1
    
def hexagon( x,  y,  side):
  pushMatrix() 
  translate(x, y) 
  beginShape()
  vertex ( 1.5 * side, 0.5 * sqrt3 * side) # SE
  vertex ( 0.0 * side, 1.0 * sqrt3 * side) # S
  vertex (-1.5 * side, 0.5 * sqrt3 * side) # SW
  vertex (-1.5 * side, -0.5 * sqrt3 * side) # NW
  vertex ( 0.0 * side, -1.0 * sqrt3 * side) # N
  vertex ( 1.5 * side, -0.5 * sqrt3 * side) # NE
  endShape(CLOSE)
  popMatrix()
