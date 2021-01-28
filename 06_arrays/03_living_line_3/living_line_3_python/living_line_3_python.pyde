#Exercises: Arrays
#Living Line 1

xPos = [0]*100
yPos = [0]*100

p=0
cursorImg = None
bMoved = False
bDoSave = False

def setup():
  size(800, 800)
  global cursorImg, p
  cursorImg = loadImage("cursor_with_shadow_15x21.png")
  p = 50

def draw():
  background(253)
  
  global cursorImg, p, xPos, yPos, bMoved, bDoSave

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
    
    xPos[99]= mouseX #add new value to the end of the array
    yPos[99]= mouseY #add new value to the end of the array
    bMoved = False

    
    # smooth the gesture.
    for j in range(1, 99): 
      ix = xPos[j-1]
      jx = xPos[j  ]
      kx = xPos[j+1]

      iy = yPos[j-1]
      jy = yPos[j  ]
      ky = yPos[j+1]

      xPos[j] = (ix + 14*jx + kx)/16.0
      yPos[j] = (iy + 14*jy + ky)/16.0
    
  # add noise to the gesture.
  # add more noise to older points, for fun.
  for j in range(99):  
    xPos[j] += 0.2*(99-j)*random(-1, 1)
    yPos[j] += 0.2*(99-j)*random(-1, 1)

  image(cursorImg, mouseX, mouseY, 15*6, 21*6)


def mouseMoved():
  global bMoved
  bMoved = True
  
