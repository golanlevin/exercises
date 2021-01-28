cursorImg = None;
myFont = None;

points = [] 

def setup():
  size(800, 800)
  
  global cursorImg, myFont, points
  
  cursorImg = loadImage("cursor_with_shadow_15x21.png")
  myFont = loadFont("CenturySchoolbook-64.vlw")
  textFont(myFont, 64)

  points.append(PVector())
  points.append(PVector())

def draw():
  background(253)
  
  global points, myFont, cursorImg
  
  stroke(0)
  strokeWeight(8)
  line(points[0].x, points[0].y, points[1].x, points[1].y)
  fill(0, 255, 0)
  ellipse(points[0].x, points[0].y, 32,32)
  fill(255, 50, 50)
  ellipse(points[1].x, points[1].y, 32,32)

  dx = points[1].x - points[0].x
  dy = points[1].y - points[0].y
  angleR = atan2(dy, dx)
  oriD = (degrees(angleR)+360+180-90)%360
  degStr = "Orientation: %4.3f" % oriD + u"\N{DEGREE SIGN}"

  compassDirs = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"]
  compassDirIndex = min(8, int(round(oriD/45.0)))
  compass = "Compass Bearing: " + compassDirs[compassDirIndex]
  displayStr = degStr + "\n" + compass
  
  fill(0)
  textAlign(CENTER)
  text (displayStr, width*0.5, height*0.80)
  image(cursorImg, mouseX, mouseY, 15*6, 21*6)


def mousePressed():
  global points
  points[0].set(points[1])
  points[1].set(mouseX, mouseY, 0)

def mouseDragged():
  global points
  points[1].set(mouseX, mouseY, 0)
