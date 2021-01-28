rot = 0 

def setup():
  size(800, 800, FX2D)
  smooth()

def draw():
  global rot
  
  background(255)
  strokeWeight(2)
  stroke(0)
  
  pushMatrix(); 
  translate(-50, 0)
  
  mx = -mouseX/200.0;
  rot = 0.95*rot + 0.05*(mx)


  nLines = 80
  for i in range(nLines):
    x = map(i, 0, nLines-1, width/2-250, width/2+250); 
    line(x, 0, x, height)
  
  tx = 0.598
  pushMatrix()
  translate(width*tx, height/2)
  rotate(rot)
  for i in range(nLines):
    x = map(i, 0, nLines-1, -250, 250)
    line(x, -height*0.4, x, height*0.4)
  
  popMatrix()
  popMatrix()
