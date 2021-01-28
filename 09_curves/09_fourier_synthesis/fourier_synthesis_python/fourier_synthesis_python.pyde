def setup():
  size(800, 800)
  background(253)
  
  L = width/4
  h = 150
  
  pushMatrix() 
  translate(0, height/2) 
  
  stroke(0) 
  strokeJoin(ROUND) 
  strokeWeight(8)
  beginShape()
  ox = 30 
  for x in range(0-ox, width+ox):
    y = 0
    for n in range(1, 8, 2):
      y += h*4.0/PI*1.0/n * sin(n*PI*(x-2*L)/L * 0.75)
    
    vertex(x, y)
  
  endShape()
  
  stroke(0) 
  strokeWeight(2) 
  line(0,0, width, 0) 
  
  popMatrix() 


def draw():
    return
