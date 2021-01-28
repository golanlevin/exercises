dice_width = 100
num_dice = 1

# x,y, is top left of die
def drawDie(x, y):
  number = int(random(1,6))
  d = int(dice_width/7)
  #fill(231,29,54);
  fill(200)
  rect(x,y,dice_width,dice_width, 10)
  
  fill(255)
  if(number == 1):
    ellipse(x+d*3.5, y+d*3.5,d,d)
  elif(number == 2):
    if(int(random(1)) == 0):
      ellipse(x+d*1.5,y+d*5.5,d,d)
      ellipse(x+d*5.5,y+d*1.5,d,d)
    else:
      ellipse(x+d*1.5,y+d*1.5,d,d)
      ellipse(x+d*5.5,y+d*5.5,d,d)
      
  elif(number == 3):
    ellipse(x+d*3.5, y+d*3.5,d,d)
    if(int(random(1)) == 0):
      ellipse(x+d*1.5,y+d*5.5,d,d)
      ellipse(x+d*5.5,y+d*1.5,d,d)
    else:
      ellipse(x+d*1.5,y+d*1.5,d,d)
      ellipse(x+d*5.5,y+d*5.5,d,d)

  elif(number == 4):
    ellipse(x+d*1.5,y+d*5.5,d,d)
    ellipse(x+d*5.5,y+d*1.5,d,d)
    ellipse(x+d*1.5,y+d*1.5,d,d)
    ellipse(x+d*5.5,y+d*5.5,d,d)

  elif(number == 5):
    ellipse(x+d*3.5, y+d*3.5,d,d)
    ellipse(x+d*1.5,y+d*5.5,d,d)
    ellipse(x+d*5.5,y+d*1.5,d,d)
    ellipse(x+d*1.5,y+d*1.5,d,d)
    ellipse(x+d*5.5,y+d*5.5,d,d)
  
  else:
    ellipse(x+d*1.5,y+d*5.5,d,d)
    ellipse(x+d*5.5,y+d*1.5,d,d)
    ellipse(x+d*1.5,y+d*1.5,d,d)
    ellipse(x+d*5.5,y+d*5.5,d,d)
    if(int(random(1))==0):
        ellipse(x+d*3.5,y+d*1.5,d,d)
        ellipse(x+d*3.5,y+d*5.5,d,d)    
    else:
        ellipse(x+d*5.5,y+d*3.5,d,d)
        ellipse(x+d*1.5,y+d*3.5,d,d)

def setup():
  size(300,300)
  background(255)
  noStroke();

def overlaps(x, y):
  global dice_width
  loadPixels()
  white = color(255)
  if(pixels[x+width*y] != white or
     pixels[(x+dice_width)+width*y] != white or 
     pixels[x+width*(y+dice_width)] != white or
     pixels[(x+dice_width)+width*(y+dice_width)] != white):
       return True
  else:
    return False

def drawDice():
  background(255)
  global num_dice 
  global dice_width
  for i in range(num_dice):

    x = int(random(width-dice_width))
    y = int(random(height-dice_width))
   
    while (overlaps(x,y)):
        x = int(random(width-dice_width))
        y = int(random(height-dice_width))
   
    drawDie(x, y)

def keyPressed():
  global num_dice
  global dice_width
  dice_width = 100
  
  if (key == '1'):
    num_dice = 1
    print("1")
  elif (key == '2'):
    num_dice = 2
  elif (key == '3'):
    num_dice = 3
  elif (key == '4'):
    num_dice = 4
  elif (key == '5'):
    dice_width = 80
    num_dice = 5
  elif (key == '6'):
    dice_width = 60
    num_dice = 6

  drawDice()
  
def draw():
    return
