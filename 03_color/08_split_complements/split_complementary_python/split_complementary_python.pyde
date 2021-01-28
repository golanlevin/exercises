colorWheelImg, cursorImg = None, None

def setup():
  size(800, 800) 
  
  global colorWheelImg, cursorImg
  colorWheelImg = loadImage("color_wheel.png") 
  cursorImg = loadImage("cursor_with_shadow_15x21.png")


def draw():
  background(253)
  image(colorWheelImg, 0, 0) 

  colorMode(HSB, 100)
  radius = 320
  mx = mouseX - width/2 
  my = mouseY - height/2 
  mr = sqrt(mx*mx + my*my) 
  ma = (TWO_PI + atan2(my, mx))%TWO_PI 
  mh = map(ma, 0, TWO_PI, 0, 100)
  ms = map(mr, 0, radius, 0, 100)
  
  ma1 = (ma + radians(180-30))%TWO_PI 
  ma2 = (ma + radians(180+30))%TWO_PI 
  
  drawColorEllipse( radius, ma, mr)
  drawColorEllipse( radius, ma1, mr)
  drawColorEllipse( radius, ma2, mr)

  image(cursorImg, mouseX, mouseY, 15*6, 21*6)


#---------------------------------------------------
def drawColorEllipse(radius, ma, mr):
  
  mh = map(ma, 0, TWO_PI, 0, 100)
  ms = map(mr, 0, radius, 0, 100)
  mx = width/2  + mr * cos(ma) 
  my = height/2 + mr * sin(ma) 
  
  noStroke()
  fill(0, 0, 0, 10) 
  er = radius*0.4
  ellipse(mx+8, my+8, er+4, er+4) 
  
  stroke(0) 
  strokeWeight(8) 
  ellipseMode(CENTER)
  fill(mh, ms, 100)
  ellipse(mx, my, er, er) 
