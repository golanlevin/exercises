cursorImg, points = None, None

#-----------------------------------------
def setup():
  size(800, 800)
  
  global cursorImg, points
  cursorImg = loadImage("cursor_with_shadow_15x21.png")  
  points = []


#-----------------------------------------
def draw():
  background(253) 
  
  global cursorImg, points
  
  if (len(points) > 0):
    strokeCap(ROUND) 
    strokeJoin(ROUND) 

    # Draw main (thick) gesture.
    noFill() 
    stroke(0) 
    strokeWeight(8)
    beginShape() 
    for j in range(0, len(points)):
      pJ = points[j] 
      vertex(pJ.x, pJ.y)
    endShape() 

    offset = 50.0 
    minPointDist = 4.0 

    strokeWeight(2)
    beginShape() 
    pI = points[0] 
    for j in range(1, len(points)):
      pJ = points[j]

      dx = pJ.x - pI.x
      dy = pJ.y - pI.y
      dh = sqrt(dx*dx + dy*dy) 

      if (j==1):
        px = pI.x + offset * dy/dh
        py = pI.y - offset * dx/dh
        vertex(px, py)

      if ((j==(len(points)-1)) or (dh > minPointDist)):
        px = pJ.x + offset * dy/dh
        py = pJ.y - offset * dx/dh
        vertex(px, py)
        pI = points[j] # swap
    endShape()

  image(cursorImg, mouseX, mouseY, 15*6, 21*6)

#-----------------------------------------
def mousePressed():
  global points
  points = []
  points.append(PVector(mouseX, mouseY, 0))

#-----------------------------------------
def mouseDragged():
  global points
  points.append(PVector(mouseX, mouseY, 0))

#-----------------------------------------
def keyPressed():
    
  global points
  
  if (key == 's'):
    # smooth

    if (len(points) > 3):

      # Make blurred copy
      pointsTmp = []
      p0 = points[0]
      pointsTmp.append(PVector(p0.x, p0.y)) 
      for j in range(1, len(points)-1):
        pi = points[j-1] 
        pj = points[j]
        pk = points[j+1]

        ax = (pi.x + pj.x + pk.x)/3.0 
        ay = (pi.y + pj.y + pk.y)/3.0 
        pointsTmp.append(PVector( ax, ay))
        
      pLast = points[len(points)-1]
      pointsTmp.append(PVector(pLast.x, pLast.y))

      # Copy back
      for i in range(0, len(points)):
        points[i] = pointsTmp[i]
