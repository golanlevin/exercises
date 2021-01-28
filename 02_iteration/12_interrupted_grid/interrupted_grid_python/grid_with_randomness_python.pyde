# Grid with Randomness

def setup():
  size(800, 800) 
  smooth() 
  noLoop()  


def draw()  :
  background(255)  
  strokeWeight(2) 
  stroke(0)  
  noFill()  
  
  n = 8
  w = width/n
  for y in range(0, n):
     for x in range(0, n):
          px = x*w
          py = y*w
          #the chance of drawing a circle is 5%
          #otherwise, it draws a square
          chance = random(1)
          if (chance < .1):
              ellipse(px + w/2, py+w/2, w-25, w-25)
          else:
              rect(px+10, py+10, w-20, w-20)
