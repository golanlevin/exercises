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
mag = 5.0

def setup():
  size(800, 800)

def draw():
  global xData, yData, mag

  background(253) 
  pushMatrix()
  scale (mag) 
  translate(23, 9)

  renderPointsOfHighCurvature(xData, yData)
  renderData(xData, yData)


  popMatrix()


#==========================================
def renderData(xpts, ypts):
  nPoints = len(xpts)
  fill(229) 
  stroke(0) 
  strokeJoin(MITER) 
  strokeWeight(8.0/mag)
  beginShape()
  for i in range(nPoints):
    vertex(xpts[i], ypts[i])
  
  endShape(CLOSE)


#==========================================
def renderPointsOfHighCurvature(xpts, ypts):

  nPoints = len(xpts)

  for j in range(nPoints):
    xi = xpts[(j-1+nPoints)%nPoints]
    yi = ypts[(j-1+nPoints)%nPoints]

    xj = xpts[j]
    yj = ypts[j]

    xk = xpts[(j+1)%nPoints]
    yk = ypts[(j+1)%nPoints]

    dxij = xi-xj
    dyij = yi-yj
    dhij = sqrt(dxij*dxij + dyij*dyij)

    dxkj = xk-xj
    dykj = yk-yj
    dhkj = sqrt(dxkj*dxkj + dykj*dykj)

    dot = dxij*dxkj + dyij*dykj
    cross = dxij*dykj - dyij*dxkj
    theta = acos(dot/(dhij*dhkj))
    # if (Float.isNaN(theta) == False):

    deg = degrees(abs(theta))
    if (deg < mouseX):

      r = map(abs(theta), 0, PI, 30, 0) 
      if (cross < 0):
        noStroke() 
        fill(255, 0, 0, 150) 
        ellipse(xj, yj, r, r)
