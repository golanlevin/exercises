# Turtle Graphics in Processing
# Natalie Freed, February 2013
# This program shows another way to think about moving
# through Processing's coordinate system. Instead of placing
# points on a grid, you can imagine yourself as being somewhere
# on the grid, facing a direction. You can move forward or turn.
# The drawn line follows behind you.

loc = None#current location
angle = None #current orientation

def setup():
   size(800, 800)
   background(253)
   
   global loc, angle
   loc = PVector(width/2, height/2) #starting position is at center
   angle = 0 #starting orientation
   
   noLoop()
   

def draw(): #this example draws a polygon. Can you change the number of sides?
  global loc, angle
  
  #forward(50) #go forward 200 pixels
  #left(radians(30)) #turn 30 degrees to the left
   
  fill(0) 
  noStroke()
  for i in range(150):
    forward(i*4.0)
    left(radians(137.507764))

    if (i>1):
      D = map(i, 0, 150, 8, 24)
      ellipse(loc.x, loc.y, D, D)

# Below are utility functions to calculate new positions and orientations 
# when moving forward or turning. You don't need to change these.

def forward(l): #calculate positions when moving forward
  global loc, angle
  
  start = loc
  end = PVector.add(loc, PVector(cos(angle)*l, sin(angle)*l))
  #line(start.x, start.y, end.x, end.y)
  loc = end


def left(theta): #calculate new orientation
  global angle
  angle += theta


def right(theta):  #calculate new orientation
  global angle
  angle -= theta


def jumpTo(x, y): #jump directly to a specific position
  global loc
  loc = PVector(x, y)


def line(a, b): #new line function with PVectors. used by forward function
  line(a.x, a.y, b.x, b.y)

def polar(r, theta): #converts an angle and radius into a vector
  return PVector(r*cos(theta),r*sin(-theta)) # negate y for left handed coordinate system
