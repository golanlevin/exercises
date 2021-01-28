# Geometric Progression

def setup() :
  size(800, 800)
  smooth() 


def draw():
  background(253)
  stroke(0) 
  noFill()  
  constantFactor = 1.315
  circleSize = 20 
  
  for i in range(0,20):
    #draws 20 concentric circles of decreasing diameter and decreasing lineWeight
    strokeWeight(circleSize/25.0) 
    ellipse(width/2,height, circleSize, circleSize)
    circleSize = circleSize * constantFactor 
