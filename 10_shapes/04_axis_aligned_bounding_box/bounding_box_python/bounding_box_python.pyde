xData = [81, 83, 83, 83, 83, 82, 79, 77, 80, 83, 
  84, 85, 84, 90, 94, 94, 89, 85, 83, 75, 
  71, 63, 59, 60, 44, 37, 33, 21, 15, 12, 
  14, 19, 22, 27, 32, 35, 40, 41, 38, 37, 
  36, 36, 37, 43, 50, 59, 67, 71]

yData = [  10, 17, 22, 27, 33, 41, 49, 53, 67, 76, 
  93, 103, 110, 112, 114, 118, 119, 118, 121, 121, 
  118, 119, 119, 122, 122, 118, 113, 108, 100, 92, 
  88, 90, 95, 99, 101, 80, 62, 56, 43, 32, 
  24, 19, 13, 16, 23, 22, 24, 20]

mag = 5 

def setup():
  size(800, 800)
  noLoop()

def draw():
  background(253) 

  global mag, xData, yData

  pushMatrix()
  scale(mag) 
  translate(23, 9)

  L = MAX_INT
  R = MIN_INT 
  T = MAX_INT
  B = MIN_INT 
  nPoints = len(xData)
  for i in range(nPoints):
    if (xData[i] < L):
      L = xData[i]
    
    if (xData[i] > R):
      R = xData[i]
    
    if (yData[i] < T):
      T = yData[i]
    
    if (yData[i] > B):
      B = yData[i]
    
  
  noFill() 
  strokeJoin(MITER)
  strokeWeight(8/mag) 
  stroke(255, 50, 50) 
  rect(L, T, R-L, B-T)

  renderData(xData, yData)

  popMatrix()


#==========================================
def renderData(xpts, ypts):
  global mag, xData, yData

  nPoints = len(xpts)
  fill(229) 
  stroke(0) 
  strokeJoin(MITER)
  strokeWeight(8/mag) 
  beginShape()
  for i in range(nPoints):
    vertex(xpts[i], ypts[i])
  
  endShape(CLOSE)
