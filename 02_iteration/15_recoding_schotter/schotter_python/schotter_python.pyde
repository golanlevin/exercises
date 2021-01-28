def setup() :
  size(800,800)
  smooth()
  noLoop()

def draw():
  background(253)
    
  nSquares = 5
  sqSize = 120 
  cL = width/2 - ((nSquares-1)*sqSize)/2
  cR = width/2 + ((nSquares-1)*sqSize)/2
  
  noFill()
  stroke(0) 
  strokeWeight(8)
  rectMode(CENTER)
  
  for row in range(nSquares):
    v = map(row, 0, nSquares-1, 0.0,0.25*row)
    
    for col in range(nSquares):
      px = map(col, 0,nSquares-1,  cL,cR) 
      py = map(row, 0,nSquares-1,  cL,cR) 
      R = random(-v, v) 
      pushMatrix() 
      translate(px, py) 
      rotate(R) 
      rect(0, 0, sqSize, sqSize)
      popMatrix() 
  
