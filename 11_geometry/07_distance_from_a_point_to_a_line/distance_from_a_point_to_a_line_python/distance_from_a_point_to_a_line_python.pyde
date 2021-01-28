cursorImg, myFont, P1, P2, P3 = None, None, None, None, None

def setup():
  size(800, 800)
  
  global cursorImg, myFont, P1, P2, P3
  
  cursorImg = loadImage("cursor_with_shadow_15x21.png")
  myFont = loadFont("CenturySchoolbook-60.vlw")
  textFont(myFont, 60)
  
  P1 = PVector(240, 175)
  P2 = PVector(170, 380)
  P3 = PVector()

def draw():
  background(253); 
  
  global cursorImg, myFont, P1, P2, P3
  
  P3.set(mouseX, mouseY)

  fill(0)
  stroke(0)
  strokeWeight(8)
  textAlign(CENTER, CENTER)

  line(P1.x, P1.y, P2.x, P2.y)
  ellipse(P1.x, P1.y, 24, 24)
  ellipse(P2.x, P2.y, 24, 24)

  # Place text labels at the end vertices
  dx21 = P2.x-P1.x
  dy21 = P2.y-P1.y
  dh21 = sqrt(dx21*dx21 + dy21*dy21)
  fill(0)
  offset = 75
  text("P1", P1.x-offset*dx21/dh21, P1.y-offset*dy21/dh21)
  text("P2", P2.x+offset*dx21/dh21, P2.y+offset*dy21/dh21)

  # http://paulbourke.net/geometry/pointlineplane/
  numer = ((P3.x-P1.x)*(P2.x-P1.x) + (P3.y-P1.y)*(P2.y-P1.y))
  denom = ((P2.x-P1.x)*(P2.x-P1.x) + (P2.y-P1.y)*(P2.y-P1.y))
  u = numer / denom
  
  if ((u >= 0) and (u <=1)):
    px = P1.x + u*(P2.x - P1.x)
    py = P1.y + u*(P2.y - P1.y)
    line(px, py, P3.x, P3.y)
    fill(0)
    ellipse(px, py, 24, 24)
    fill(0, 255, 0)
    ellipse(P3.x, P3.y, 32, 32)
    fill(0)
    text("P3", P3.x-offset*dx21/dh21, P3.y-offset*dy21/dh21)
    
    l = sqrt(sq(P3.x-px)+sq(P3.y-py))
    lenStr = "Distance from \nP3 to Line: %d" % l
    text(lenStr, width*0.5, height*0.80)


  # Draw the cursor image
  image(cursorImg, mouseX, mouseY, 15*6, 21*6)


def mousePressed():
  global cursorImg, myFont, P1, P2, P3
    
  # Generate two new random locations for points A and B. 
  P1.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8))
  P2.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8))
