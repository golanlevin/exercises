# Color Bar Gradient


#Using iteration, generate a gradient that interpolates 
#from one fill color to another across exactly 17 rectangles. 
#You may find it helpful to learn about your environment’s lerp() 
#function. Implement some code that randomizes the two end-colors 
#whenever the user clicks the mouse.


nRectangles = 17 
colorA = color(255, 255, 0)
colorB = color(255, 0, 255)

def setup() :
  size(800, 800)

def draw() :
  background(253)
  rectMode(CENTER) 
  noStroke() 
  for i in range(0, nRectangles):
    #finds the different color values for each rectangle in order to create an even gradient
    fraction = float(i)/(nRectangles-1)
    aBarColor = lerpColor(colorA, colorB, fraction)
    barX = map(i, 0, nRectangles-1, 50, width-50) 
    
    #changes fill to the proper color and draws rectangle
    fill(aBarColor)
    rect(barX, height/2, height*.05, height*.9)
  
def mousePressed() :
  #changes colors when mouse is pressed
  colorA = color(random(0, 255), random(0, 255), random(0, 255))
  colorB = color(random(0, 255), random(0, 255), random(0, 255))
