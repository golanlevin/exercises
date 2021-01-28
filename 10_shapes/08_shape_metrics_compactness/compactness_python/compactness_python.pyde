# There is evidence that compactness is one of the basic dimensions 
# of shape features extracted by the human visual system.
# A common compactness measure is the isoperimetric quotient, 
# The ratio of area to perimeter squared, times 4PI. 

xCatData = [81, 83, 83, 83, 83, 82, 79, 77, 80, 83, 
  84, 85, 84, 90, 94, 94, 89, 85, 83, 75, 
  71, 63, 59, 60, 44, 37, 33, 21, 15, 12, 
  14, 19, 22, 27, 32, 35, 40, 41, 38, 37, 
  36, 36, 37, 43, 50, 59, 67, 71]
  
yCatData = [10, 17, 22, 27, 33, 41, 49, 53, 67, 76, 
  93, 103, 110, 112, 114, 118, 119, 118, 121, 121, 
  118, 119, 119, 122, 122, 118, 113, 108, 100, 92, 
  88, 90, 95, 99, 101, 80, 62, 56, 43, 32, 
  24, 19, 13, 16, 23, 22, 24, 20]

xCircData = [90, 85, 73, 54, 35, 19, 10, 10, 19, 35, 54, 73, 85]

yCircData = [71, 89, 104, 111, 109, 98, 80, 61, 44, 33, 30, 37, 52]

myFont18, myFont56 = None, None

def setup():
  size(800, 800) 

  global myFont18, myFont56
  myFont18 = loadFont("CenturySchoolbook-60.vlw") #createFont("Helvetica", 40) 
  myFont56 = loadFont("CenturySchoolbook-106.vlw") #createFont("Helvetica-Bold", 106)



def draw():
  background(253)

  global myFont18, myFont56, xCatData, yCatData, xCircData, yCircData

  # Draw shapes
  pushMatrix() 
  scale(2.0) 
  translate(10+5, 10) 
  renderData(xCatData, yCatData)
  popMatrix()

  pushMatrix() 
  scale (2.0) 
  translate(190+13, 10) 
  renderData(xCircData, yCircData)
  popMatrix()

  # Compute shape metrics
  catArea  = getArea(xCatData, yCatData) 
  catPerimeter  = getPerimeter(xCatData, yCatData) 
  catCompactness  = TWO_PI * 2.0 * catArea  / sq(catPerimeter) 

  circArea  = getArea(xCircData, yCircData) 
  circPerimeter = getPerimeter(xCircData, yCircData) 
  circCompactness =  TWO_PI * 2.0 * circArea / sq(circPerimeter) 

  # Display metrics
  fill(0) 
  textAlign(CENTER) 

  catDiagnostics = "" 
  catDiagnostics += "Area = " + str(int(catArea)) + "\n"
  catDiagnostics += "Perimeter = "  + str(int(round(catPerimeter))) + "\n"
  catDiagnostics += "Compactness = "
  textFont(myFont18, 40) 
  text(catDiagnostics, 200+20, 2*235+50)
  textFont(myFont56)#, 104)
  text(nf(catCompactness, 1, 2), 220, 740) 

  circDiagnostics = "" 
  circDiagnostics += "Area = " + str(int(circArea)) + "\n"
  circDiagnostics += "Perimeter = " + str(int(circPerimeter)) + "\n"
  circDiagnostics += "Compactness = "
  textFont(myFont18, 40) 
  text(circDiagnostics, 600-20, 2*235+50)
  textFont(myFont56)#, 104)
  text(nf(circCompactness, 1, 2), 580, 740)


#==========================================
def renderData(xpts, ypts):
  fill(229) 
  stroke(0) 
  strokeJoin(MITER)
  strokeWeight(4)
  beginShape()
  nPoints = len(xpts)
  for i in range(nPoints):
    vertex(xpts[i]*1.7, ypts[i]*1.7)
  
  endShape(CLOSE)


#==========================================
def getPerimeter(xpts, ypts):
  perimeter = 0 

  nPoints = len(xpts)
  for i in range(nPoints):
    px = xpts[ i           ]
    py = ypts[ i           ]
    qx = xpts[(i+1)%nPoints]
    qy = ypts[(i+1)%nPoints]
    delta = dist(px, py, qx, qy) 
    perimeter += delta
  
  return perimeter


#==========================================
def getArea(xpts, ypts):
  area = 0
  nPoints = len(xpts)
  j = nPoints - 1 
  for k in range(nPoints):
    area += ((xpts[k] + xpts[j]) * (ypts[k] - ypts[j]))/2.0 
    j = k  # swap j is always the vertex previous to k
   
  return area

  
