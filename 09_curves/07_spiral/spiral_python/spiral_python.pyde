diameter = 600
skip = 50

def setup():
  size(800, 800)
  shapeMode(CENTER)
  background(253)
  noFill()
  stroke(0)
  strokeWeight(8)

def draw():
  global diameter, skip
  
  arc(width/2, height/2, diameter, diameter, -1*HALF_PI, HALF_PI)
  diameter = diameter -skip
  translate(0,-skip/2)
  arc(width/2, height/2, diameter, diameter, HALF_PI,2*PI-HALF_PI )
  diameter = diameter -skip
