# Simple iteration. 
# Uses introductory "immediate mode"
# With no setup() or draw() functions. 

size(800, 800)
background (253) 

stroke(0) 
fill(229)
strokeWeight(8)

#draws 7 circles
for i in range (0, 7):
  #sets space between circle centers to 50
  x = 100 + i*100
  #draws circles of radius 30
  ellipse(x, 300, 60, 60)
