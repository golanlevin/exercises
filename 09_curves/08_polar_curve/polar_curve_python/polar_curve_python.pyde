nPoints = 360
EPITROCHOID = 0 # Cartesian Parametric Form  [x=f(t), y=g(t)]
CRANIOID = 1 # Polar explicit form   [r =f(t)]
myFont = None
titles = ["Epitrochoid", "Cranioid"]
curveMode = 0

#--------------------------------------------------
def setup():
  size(800, 800, FX2D)
  smooth()
  
  global myFont
  myFont = loadFont("CenturySchoolbook-72.vlw")
  textFont(myFont, 72)


#--------------------------------------------------
def draw():
  background(253)
  
  global titles, curveMode

  # draw the frame
  fill(0) 
  noStroke()
  text(titles[curveMode], 50, 100)

  # draw the curve
  pushMatrix()
  translate(width / 2, height / 2 + 50)
  if (curveMode == 0):
    drawEpitrochoidCurve()
  else:
    drawCranioidCurve()
  
  popMatrix()


#--------------------------------------------------
def drawEpitrochoidCurve():
  # Epicycloid:
  # http:#mathworld.wolfram.com/Epicycloid.html

  global nPoints

  x, y = 0.0, 0.0
  mx = mouseX # 510 
  my = mouseY # 546 
  
  a = 150
  b = a / 2.0
  h = constrain(my / 8.0, 0, b)
  ph = mx / 50.0

  fill(255, 200, 200)
  stroke(0)
  strokeWeight(8)
  strokeJoin(ROUND) 
  beginShape()
  for i in range(nPoints):
    t = map(i, 0, nPoints, 0, TWO_PI)
    x = (a + b) * cos(t) - h * cos(ph + t * (a + b) / b)
    y = (a + b) * sin(t) - h * sin(ph + t * (a + b) / b)
    vertex(x, y)
  
  endShape(CLOSE)



#--------------------------------------------------
def drawCranioidCurve():
  # http:#mathworld.wolfram.com/Cranioid.html

  # NOTE: given a curve in the polar form  r = f(theta),
  # 1. sweep theta from 0...TWO_PI,
  # 2. then compute r as a function of theta,
  # 3. then compute x and y using the circular identity:
  #    x = r * cos(theta)
  #    y = r * sin(theta)

  global nPoints

  x = 0.0
  y = 0.0
  r = 0.0
  a = 30.0
  b = 8.0
  c = 75.0
  p = constrain((1.0* mouseX / width), 0.0, 1.0)
  q = constrain((1.0* mouseY / height), 0.0, 1.0)

  fill(200, 200, 255)
  stroke(0)
  strokeWeight(8)
  strokeJoin(ROUND) 
  
  beginShape()
  for i in range(nPoints):
    t = map(i, 0, nPoints, 0, TWO_PI)

    # cranioid:
    r = a * sin(t) + b * sqrt(1.0 - p * sq(cos(t))) + c * sqrt(1.0 - q * sq(cos(t)))

    x = r * cos(t)
    y = r * sin(t)
    vertex(x, y)
  
  endShape(CLOSE)


#--------------------------------------------------
def mousePressed():
  global curveMode
  curveMode = 1 - curveMode
