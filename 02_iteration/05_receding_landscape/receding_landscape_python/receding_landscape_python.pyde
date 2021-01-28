# Receding Horizon
# Iteration exercise 
# Java solution

size(800, 800)
background(255)
strokeWeight(3)
stroke(0)
smooth()
i=0-100

#iterativly draws lines, changing the angle and startpoint, but keeping the endpoint
#this creates a perspective that recedes into the distance
while (i<=width+100):
  xTop = width/2 + i*10 
  xBot = width/2 + i*55 
  line (xTop, -1, xBot, height) 
  i=i+1
