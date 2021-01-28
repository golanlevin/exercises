def setup():
  size(800, 800)
  noLoop()
  
  background(253)
  
  pushMatrix()
  translate(width/2, height/2)
 
  radius = 320
  colorMode(HSB, 100)
  ellipseMode(CENTER)
  noStroke()
  
  for t in range(720):
    a = map(t, 0,720, 0, TWO_PI) 
    
    for r in range(0, radius*10):
      rr = r * 0.1
      h = map(a, 0, TWO_PI, 0, 100)
      s = map(rr, 0, radius, 0, 100)
      fill(h, s, 100)
      x = rr*cos(a)
      y = rr*sin(a)
      ellipse(x, y, 3, 3)

  popMatrix()
