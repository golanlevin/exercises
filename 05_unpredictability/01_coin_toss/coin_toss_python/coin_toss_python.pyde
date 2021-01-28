# Program which flips a coin whenever the user clicks the mouse. 
theDisplayString = ""
coinTossCount = 0

def setup():
  size(240, 240)
  tossCoin()

def mousePressed():
  tossCoin()

def draw():
  background(255)
  drawCoin()

def tossCoin():
  # Generate a random number between 0 and 1
  global coinTossCount, theDisplayString
  coinTossCount+=1
  aRandomValue = random(1.0)

  if (aRandomValue < 0.5):
    theDisplayString = "T"
    println("Coin toss #" + str(coinTossCount) + ": (T)ails") 
  else: 
    theDisplayString = "H"
    println("Coin toss #" + str(coinTossCount) + ": (H)eads")

def drawCoin():
  textAlign(CENTER, CENTER)
  textSize(80)
  
  noStroke()
  fill(100) 
  ellipse(width/2+6, height/2+1, 120, 120)
  fill(170)
  ellipse(width/2, height/2, 120, 120)

  fill(110)
  text(theDisplayString, width/2-2, height/2-9)
  fill(255, 200)
  text(theDisplayString, width/2, height/2-7)
