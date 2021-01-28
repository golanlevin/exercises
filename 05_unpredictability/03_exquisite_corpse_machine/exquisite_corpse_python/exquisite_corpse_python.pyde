def setup():
  size(300, 300)
  drawBackground()
  makeNewExquisiteCorpse()

def draw():
    return

def mousePressed():
  drawBackground()
  makeNewExquisiteCorpse()

def makeNewExquisiteCorpse():
  numParts = 5;
  head = loadImage("head" + str(int(random(numParts))+1) + ".png")
  body = loadImage("body" + str(int(random(numParts))+1) + ".png")
  feet = loadImage("feet" + str(int(random(numParts))+1) + ".png")

  image(head, 0, 0)
  image(body, 0, 0)
  image(feet, 0, 0)

def drawBackground():
  background(255)
  noStroke()

  fill(250)
  rect(0, 0*height/3, width, height/3)
  fill(230)
  rect(0, 1*height/3, width, height/3)
  fill(250)
  rect(0, 2*height/3, width, height/3)
