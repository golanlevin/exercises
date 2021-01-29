numRings = 50
currentRing = 0
rings = [0]*numRings # Declare the array

def setup():
  size(300, 300)
  smooth()
  global numRings
  for i in range(numRings): 
    rings[i] = Ring(0, 0, 0, False) # Create each object

def draw():
  background(251,128,114)
  global numRings, rings
  for i in range(numRings):
    rings[i].grow()
    rings[i].display()

# Click to create a new Ring
def mousePressed():
  global currentRing, numRings
  rings[currentRing].start(mouseX, mouseY)
  currentRing+=1
  if (currentRing >= numRings):
    currentRing = 0

class Ring(object):
  def __init__(self, x, y, diameter, on):
    self.x = x # x-coordinate
    self.y = y # y-coordinate
    self.diameter = diameter # Diameter of the ring
    self.on = False # Turns the display on and off
    
  def start(self, xpos, ypos):
    self.x = xpos;
    self.y = ypos;
    self.on = True;
    self.diameter = 1;

  def grow(self):
    if (self.on == True):
      self.diameter += 1.5
      if (self.diameter > 400):
        self.on = False
  
  def display(self):
    if (self.on == True):
      noFill()
      strokeWeight(4)
      stroke(255, 153)
      ellipse(self.x, self.y, self.diameter, self.diameter)
