mousePositions = []
debug = None
cursorImg = None
bMoved = False

def setup():
  size(800, 800)
  frameRate(16)
  
  global cursorImg
  cursorImg = loadImage("cursor_with_shadow_15x21.png")


def draw():
  background(253)
  
  global debug, cursorImg, mousePositions, bMoved
  
  debug = False
  
  if (bMoved):
    mousePositions.append([mouseX, mouseY])
    if (len(mousePositions) > 50):
        mousePositions = mousePositions[1:]
    bMoved = False
  
  drawPolyline_by_quads()
  
  image(cursorImg, mouseX, mouseY, 90, 126)


def drawPolyline_by_ellipses(): 
  noStroke()  
  fill(0)
  for i in range(1, len(mousePositions.size)):
    cur = mousePositions[i]
    prev = mousePositions[i-1]
    d = constrain(map(dist(cur[0], cur[1], prev[0], prev[1]), 50, 10, 8, 50), 8, 50)
    ellipse(cur[0], cur[1], d, d)
  


def drawPolyline_by_segments():
  noFill()
  stroke(0)
  for i in range(1, len(mousePositions.size)): 
    cur = mousePositions[i]
    prev = mousePositions[i-1]
    w = map(dist(cur[0], cur[1], prev[0], prev[1]), 30, 0, 3, 10)
    strokeWeight(max(1, w))
    line(cur[0], cur[1], prev[0], prev[1])

def drawPolyline_by_quads():
  fill(0)
  stroke(0)
  strokeWeight(1)
  beginShape(TRIANGLE_STRIP) 
  
  rad, l, cur, prev, next = 0.0, 0, 0, 0, 0
  
  if (len(mousePositions) < 2):
    return
  
  cur = mousePositions[0]
  vertex(cur[0], cur[1])
  
  for i in range(1, len(mousePositions)-1): 
    cur = mousePositions[i]
    prev = mousePositions[i-1]
    next = mousePositions[i+1]
    rad = estimateSlope(cur, prev, next)
    if (rad == None):
        rad = 0.0
    l = getWidth(i)
    p1 = [cur[0] + l*cos(rad), cur[1] + l*sin(rad)]
    p2 = [cur[0] - l*cos(rad), cur[1] - l*sin(rad)]
    vertex(p1[0], p1[1])
    vertex(p2[0], p2[1])
    
    if (debug):
      noFill()
      strokeWeight(1)
      stroke(0)
      line(p1[0], p1[1], p2[0], p2[1])
      
      noStroke()
      fill(255, 0, 0)
      ellipse(p1[0], p1[1], 5, 5)
      
      fill(0)
      noStroke()
  
  cur = mousePositions[len(mousePositions)-1]
  vertex(cur[0], cur[1])
  
  endShape()

def mouseMoved():
  global bMoved
  bMoved = True

def estimateSlope(cur, prev, next):
  if (cur[0] - prev[0] == 0 or next[0] - cur[0] == 0):
      return None
  slope1 = 1.0 * (cur[1] - prev[1])/(cur[0] - prev[0])
  slope2 = 1.0 * (next[1] - cur[1])/(next[0] - cur[0])
  dist1 = dist(cur[0], cur[1], prev[0], prev[1])
  dist2 = dist(cur[0], cur[1], next[0], next[1])
  slopeAve = (slope1*dist1 + slope2*dist2 + 1)/(dist1+dist2+1)
  slopeAveInverse = -1.0/slopeAve
  rad = atan(slopeAveInverse)
  if (next[1] - prev[1] <= 0) :
    if (next[0] - prev[0] <= 0):
      rad += PI
    else:
      rad -= PI
  return rad


def getWidth(index):
  count = 0
  distAccum = 0
  for i in range(max(index-3, 1), min(index+3, len(mousePositions)-1)):
    count += 1
    cur = mousePositions[i-1]
    next = mousePositions[i]
    distAccum += dist(cur[0], cur[1], next[0], next[1])
  
  w = constrain(map(distAccum/count, 50, 0, 2, 40), 2, 40)
  return w
  
