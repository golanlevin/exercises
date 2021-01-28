# Tracing the contours of metaballs (implicit curves) using Marching Square
# 
# Reference:
# Metaballs (by Daniel Shiffman): https:#thecodingtrain.com/CodingChallenges/028-metaballs.html
# Marching Squares (also by the wonderful Daniel Shiffman): https:#thecodingtrain.com/challenges/coding-in-the-cabana/005-marching-squares.html

blobs = [None] * 5

field = None
rez = 5
cols, rows = 0, 0
increment = 0.1
zoff = 0

def setup():
  size(800, 800)
  colorMode(HSB)

  global blobs, field, rez, cols, rows, increment, zoff
  for i in range(len(blobs)):
    blobs[i] = Blob()
  
  cols = 1 + width / rez
  rows = 1 + height / rez
  field = [([0.0] * rows) for i in range(cols)]


def line_2(v1, v2):
  line(v1.x, v1.y, v2.x, v2.y)


def draw():
  background(253)

  global blobs, field, rez, cols, rows, increment, zoff

  for x in range(cols):
    for y in range(rows):
      sum = 0
      for b in blobs:
        d = dist(x*rez, y*rez, b.pos.x, b.pos.y)
        sum += 20 * b.r / d
      
      if (sum > 105):
        field[x][y] = 1
      else:
        field[x][y] = 0
      
  
  for i in range(cols-1):
    for j in range(rows-1):
      x = i * rez
      y = j * rez
      a = PVector(x + rez * 0.5, y)
      b = PVector(x + rez, y + rez * 0.5)
      c = PVector(x + rez * 0.5, y + rez)
      d = PVector(x, y + rez * 0.5)
      state = getState(ceil(field[i][j]), ceil(field[i+1][j]), ceil(field[i+1][j+1]), ceil(field[i][j+1]))
      drawSquare(state, a, b, c, d)

  for b in blobs:
    b.update()
    # b.show()


def drawSquare(state, a, b, c, d):
  strokeWeight(8)
  stroke(0)

  if (state == 1) :
      line_2(c, d)
  elif (state == 2):
      line_2(b, c)
  elif (state == 3): 
      line_2(b, d)
  elif (state == 4):  
      line_2(a, b)
  elif (state == 5): 
      line_2(a, d)
      line_2(b, c)
  elif (state == 6):  
      line_2(a, c)
  elif (state == 7):
      line_2(a, d)
  elif (state == 8):
      line_2(a, d)
  elif (state == 9):
    line_2(a, c)
  elif (state == 10):
      line_2(a, b)
      line_2(c, d)
  elif (state == 11):
      line_2(a, b)
  elif (state == 12):
      line_2(b, d)
  elif (state == 13):
      line_2(b, c)
  elif (state == 14):
      line_2(c, d)
  
def getState(a, b, c, d):
  return a * 8 + b * 4  + c * 2 + d * 1



class Blob:
  def __init__(self):
    self.r = random(80, 300);
    self.pos = PVector(random(self.r, width-self.r), random(self.r, height-self.r));
    self.vel = PVector.random2D();
    self.vel.mult(random(2, 5));

  def update(self):
    self.pos.add(self.vel)
    if (self.pos.x > width-self.r/2 or self.pos.x < self.r/2):
      self.vel.x *= -1
    if (self.pos.y > height-self.r/2 or self.pos.y < self.r/2):
      self.vel.y *= -1

  def show(self):
    noFill()
    stroke(0)
    strokeWeight(4)
    ellipse(self.pos.x, self.pos.y, self.r*2, self.r*2)
