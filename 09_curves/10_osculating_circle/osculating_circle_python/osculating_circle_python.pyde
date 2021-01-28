# Press keys 0 (draw), 1 (set c1), 2 (set c2).

MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode = 0, 1, 2, 0
myLine, C1, C2, C1index, C2index, indexOfClosest = None, None, None, None, None, None

def setup():
  size(800, 800) 
  
  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest
  
  mode = MODE_DRAW
  myLine = []
  C1 = []
  C2 = []

  indexOfClosest = -1
  C1index = -1
  C2index = -1


#--------------------------------------------------
def draw():
  background(253) 
  ellipseMode(CENTER) 

  findClosestPointOnLine() 
  drawMyLine()
  # drawMyTangents()

  drawOsculatingCircle(C1index)
  drawOsculatingCircle(C2index)

#==============================================================
def drawOsculatingCircle (index):
  
  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest

  if (index > 0):
    pt1 = myLine[index-1]
    pt2 = myLine[index  ] 
    pt3 = myLine[index+1] 
    C1 = calcCircleFrom3Points(pt1[0], pt1[1], pt2[0], pt2[1], pt3[0], pt3[1]) 

    fill(255) 
    stroke(0) 
    strokeWeight(2) 
    ellipse(C1[0], C1[1], C1[2]*2, C1[2]*2)

    fill(0)
    noStroke()
    ellipse(C1[0], C1[1], 24, 24)


#==============================================================
#From http:#paulbourke.net/geometry/circlesphere/

def calcCircleFrom3Points(pt1x, pt1y, pt2x, pt2y, pt3x, pt3y):

  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest

  out = [0, 0, 0]

  yDelta_a = pt2y - pt1y
  xDelta_a = pt2x - pt1x
  yDelta_b = pt3y - pt2y
  xDelta_b = pt3x - pt2x
  m_Centerx = 0 
  m_Centery = 0 
  m_dRadius = 0 
  
  if (abs(xDelta_a) <= EPSILON and abs(yDelta_b) <= EPSILON):
    m_Centerx = 0.5*(pt2x + pt3x)
    m_Centery = 0.5*(pt1y + pt2y)
    m_dRadius = sqrt(sq(m_Centerx-pt1x) + sq(m_Centery-pt1y))
    return out

  # IsPerpendicular() assure that xDelta(s) are not zero
  aSlope = yDelta_a / (xDelta_a+0.001)
  bSlope = yDelta_b / (xDelta_b+0.001)
  if (abs(aSlope-bSlope) <= EPSILON):  # checking whether the given points are colinear.   
    return out
  
  # calc center
  m_Centerx = (aSlope*bSlope*(pt1y-pt3y) + bSlope*(pt1x + pt2x)-aSlope*(pt2x+pt3x))/(2*(bSlope-aSlope))
  m_Centery = 0 - 1*(m_Centerx - (pt1x+pt2x)/2)/aSlope + (pt1y+pt2y)/2
  m_dRadius = sqrt(sq(m_Centerx-pt1x) + sq(m_Centery-pt1y))

  out[0] = m_Centerx
  out[1] = m_Centery
  out[2] = m_dRadius
  return out



#--------------------------------------------------
def findClosestPointOnLine():

  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest

  if ((mode == MODE_PLACE1) or (mode == MODE_PLACE2)):
    # find closest point on line
    indexOfClosest = -1 
    if (len(myLine) > 0):
      minDist = 99999 
      for i in range(len(myLine)):
        dx = mouseX - myLine[i][0] 
        dy = mouseY - myLine[i][1] 
        dh = sqrt (dx*dx + dy*dy)
        if (dh < minDist):
          minDist = dh 
          indexOfClosest = i

#--------------------------------------------------
def drawMyTangents():
    
  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest

  stroke(0)
  strokeWeight(8) 
  fill(255, 200, 200) 

  if (C1index != -1):
    tangentP1 = myLine[C1index]
    ellipse(tangentP1[0], tangentP1[1], 32, 32)
  
  if (C2index != -1):
    tangentP2 = myLine[C2index]
    ellipse(tangentP2[0], tangentP2[1], 32, 32)
  

#--------------------------------------------------
def drawMyLine():
    
  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest

  noFill()
  stroke(0) 
  strokeWeight(8) 
  strokeJoin(ROUND) 
  strokeCap(ROUND) 
  beginShape() 
  for i in range(1, len(myLine)-1):
    px = myLine[i][0] 
    py = myLine[i][1] 
    curveVertex(px, py)
  
  endShape()


#--------------------------------------------------
def smoothMyLine():
    
  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest

  for j in range(1, len(myLine)-1):
    vi = myLine[j-1]
    vj = myLine[i]
    vk = myLine[j+1]

    px = (vi[0] + vj[0] + vk[0])/3.0
    py = (vi[1] + vj[1] + vk[1])/3.0 
    myLine[j] = [px, py]
  


#--------------------------------------------------
def keyPressed():
    
  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest

  if (key == '1'):
    mode = MODE_PLACE1
  elif (key == '2'):
    mode = MODE_PLACE2
  elif (key == '0'):
    mode = MODE_DRAW
  elif (key == ' '):
    saveFrame("osculating_circle.png")
  elif (key == 's'):
    smoothMyLine()
  


#--------------------------------------------------
def mousePressed():
    
  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest

  if (mode == MODE_DRAW):

    indexOfClosest = -1
    C1index = -1
    C2index = -1 

    myLine = []
    myLine.append([mouseX, mouseY])
    
  elif ((mode == MODE_PLACE1) and (indexOfClosest != -1)):
    C1index = indexOfClosest
  elif ((mode == MODE_PLACE2) and (indexOfClosest != -1)):
    C2index = indexOfClosest
  


#--------------------------------------------------
def mouseDragged():
  global MODE_DRAW, MODE_PLACE1, MODE_PLACE2, mode, myLine, C1, C2, C1index, C2index, indexOfClosest

  if (mode == MODE_DRAW):
    myLine.append([mouseX, mouseY])
  elif ((mode == MODE_PLACE1) and (indexOfClosest != -1)):
    C1index = indexOfClosest
  elif ((mode == MODE_PLACE2) and (indexOfClosest != -1)):
    C2index = indexOfClosest
  
