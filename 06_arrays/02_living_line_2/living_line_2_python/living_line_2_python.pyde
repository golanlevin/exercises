# Exercises: Arrays
# Living Line 2

xPos = None
yPos = None
p = 0
step = 1
cursorImg = None
bMoved = False
bDoSave = False

def setup():
  size(800, 800)
  
  global cursorImg, p, xPos, yPos
  xPos = [0.0] * 100
  yPos = [0.0] * 100
  cursorImg = loadImage("cursor_with_shadow_15x21.png")
  p = 50

def draw():
  background(253)

  global xpos, ypos, p, step, cursorImg, bMoved, bDoSave

  noFill() 
  stroke(0) 
  strokeWeight(8) 
  strokeJoin(ROUND) 
  beginShape() 
  for i in range(100):
    vertex(xPos[i], yPos[i])
  
  endShape() 

  if (bMoved):
    for i in range(99):
      #only change arrays if mouse moved
      line(xPos[i], yPos[i], xPos[i+1], yPos[i+1]) 
      xPos[i]=xPos[i+1] #move each value along the array
      yPos[i]=yPos[i+1] #move each value along the array
    
    xPos[99]=mouseX #add new value to the end of the array
    yPos[99]=mouseY #add new value to the end of the array
    bMoved = False

    # smooth the gesture.
    for j in range(1, 99):
      ix = xPos[j-1]
      jx = xPos[j  ]
      kx = xPos[j+1]

      iy = yPos[j-1]
      jy = yPos[j  ]
      ky = yPos[j+1]

      xPos[j] = (ix + jx + kx)/3.0
      yPos[j] = (iy + jy + ky)/3.0

  # draw ellipse
  p += step
  if (p == 0):
    step = 1
    p = 1
  
  if (p == 99):
    step = -1
    p = 98
  
  stroke(0) 
  strokeWeight(8) 
  fill(255, 200, 200)
  pushMatrix()
  translate(0, 0, 10)
  ellipse(xPos[p], yPos[p], 60, 60)
  image(cursorImg, mouseX, mouseY, 15*6, 21*6)
  popMatrix() 


def mouseMoved():
  global bMoved
  bMoved = True
