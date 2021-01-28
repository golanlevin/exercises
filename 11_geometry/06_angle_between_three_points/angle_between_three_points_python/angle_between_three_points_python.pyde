# Write a program that computes the angle between 
# three points: two randomly placed points, A and B, 
# and the mouse cursor, C. Hint: Use the dot product 
# to compute the angles, and use the cross product 
# to distinguish positive from negative curvature.

cursorImg = None
myFont = None

A = None
B = None

def setup():
  size(800, 800)
  
  global cursorImg, myFont, A, B
  cursorImg = loadImage("cursor_with_shadow_15x21.png")
  myFont = loadFont("CenturySchoolbook-72.vlw")
  textFont(myFont, 72);
  
  # Initialize our points
  A = PVector(225, 150)
  B = PVector(175, 500)


def draw():
  background(253); 
  fill(0);
  stroke(0); 
  strokeWeight(8); 
  
  global cursorImg, myFont, A, B
  
  # Draw the lines
  line(A.x, A.y, mouseX, mouseY) 
  line(B.x, B.y, mouseX, mouseY)
  fill(0, 255, 0)
  ellipse(A.x, A.y, 32, 32)
  fill(255, 50, 50)
  ellipse(B.x, B.y, 32, 32)

  # Compute the angle
  dxam = A.x-mouseX
  dyam = A.y-mouseY
  dham = sqrt(dxam*dxam + dyam*dyam)

  dxbm = B.x-mouseX
  dybm = B.y-mouseY
  dhbm = sqrt(dxbm*dxbm + dybm*dybm)

  dot   = dxam*dxbm + dyam*dybm
  cross = dxam*dybm - dyam*dxbm
  theta = acos(dot/(dham*dhbm))
  if (cross < 0):
    theta = 0-theta

  # Place text labels at the end vertices
  fill(0,0,0)
  textAlign(CENTER, CENTER)
  offset = 75
  text("A", A.x+offset*dxam/dham, A.y+offset*dyam/dham)
  text("B", B.x+offset*dxbm/dhbm, B.y+offset*dybm/dhbm)

  degStr = "Angle: %4.3f" % degrees(abs(theta)) + u"\N{DEGREE SIGN}"
  textFont(myFont, 60)
  text(degStr, width*0.5, height*0.80)

  # Draw the cursor image
  image(cursorImg, mouseX, mouseY, 15*6, 21*6)


def mousePressed():
  # Generate two new random locations for points A and B. 
  A.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8))
  B.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8))

def keyPressed():
  if (key == ' '):
    saveFrame("angle_between_3_points.png")
