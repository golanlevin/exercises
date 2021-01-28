myFont, cursorImg = None, None
mauves = [color(150, 117, 157), color(186, 122, 123), 
          color(172, 114, 148), color(134, 100, 117), 
          color(132, 89, 91), color(167, 139, 146)]
sliders = [None, None, None]

class Slider:
  def __init__(self, x, y, w, h, c):
    self.rx = x 
    self.ry = y 
    self.rw = w 
    self.rh = h
    self.val = 0.5 
    self.col = c
  
  def show(self):
    noStroke()
    fill(0) 
    rect(self.rx, self.ry, self.rw, self.rh)
    fill(self.col) 
    vy = map(self.val, 0, 1, self.ry+self.rh, self.ry) 
    vh = map(self.val, 0, 1, 0, 0-self.rh) 
    rect(self.rx, self.ry+self.rh, self.rw, vh)
    stroke(lerpColor(self.col, color(255), 0.5)) 
    strokeWeight(8) 
    line(self.rx, vy, self.rx+self.rw, vy)
  
  def handleMouse(self):
    if (mousePressed and 
      (mouseX > self.rx) and (mouseX < (self.rx+self.rw)) and 
      (mouseY > self.ry) and (mouseY < (self.ry+self.rh))):
      self.val = constrain( map(mouseY, self.ry+self.rh, self.ry, 0, 1), 0, 1)
  

#------------------------------------
def setup():
    
  global myFont, cursorImg
  global mauves, sliders
  
  size(800, 800)
  cursorImg = loadImage("cursor_with_shadow_15x21.png")
  myFont = loadFont("CenturySchoolbook-60.vlw")
  textFont(myFont, 80)

  sliderColors = [0xFFFF0000, 0xFF00FF00, 0xFF2222FF]
  for i in range(3):
    sliders[i] = Slider(40 + i*100, 420, 60, 340, sliderColors[i])
  



#------------------------------------
def draw():

  global myFont, cursorImg
  global mauves, sliders

  background(253) 

  for i in range(3):
    sliders[i].handleMouse()
    sliders[i].show()
  
  r = 255 * sliders[0].val
  g = 255 * sliders[1].val
  b = 255 * sliders[2].val
  newCol = color(r, g, b) 
  fill(newCol) 
  noStroke() 
  ellipseMode(CENTER) 
  ellipse(40+130, 120+130, 264, 264) 

  fill(0) 
  textAlign(CENTER, BASELINE) 
  text("mauve", 40+260/2, 80) 

  noStroke() 
  pushMatrix()
  CH = height*0.9
  CW = width*0.45
  rw = CW / 2.0
  rh = CH / 3.0 
  translate(width*0.5, height*0.05) 
  index = 0 
  for y in range(3):
    for x in range(2):
      m = mauves[index]  
      fill (lerpColor(m, color(255), 0.20)) 
      rect(x*rw, y*rh, rw, rh) 
      index += 1
    
  popMatrix()

  image(cursorImg, mouseX, mouseY, 15*6, 21*6)
