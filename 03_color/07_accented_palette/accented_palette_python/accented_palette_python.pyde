def setup():
  size(800, 800) 
  
  # Complementary is a scheme using one base and its complement, 
  # the on the exact opposite side of the wheel. 
  # The base is main and dominant, while the complementary is used only as an accent. 
  # http:#paletton.com/wiki/index.php?title=Complementary_color_scheme
  
  colorMode(HSB, 360, 100, 100)

def draw():
  
  background(0, 0, 100)
  
  hA = map(mouseX, 0, width, 0, 360)
  sA = 100
  bA = 90 
  c1 = color(hA, sA, bA)

  hB = (hA + 180.0)%360.0
  sB = sA 
  bB = bA 
  c2 = color(hB, sB, bB)

  noStroke()

  fill(c1)
  rect(0, 0, width*0.75, 120)
  fill(c2)
  rect(width*0.75, 0, width*0.25, 120)
  
  for x in range(5):
    xx = width * 0.75 / 5 * x
    b = map(xx, 0, width*0.75, 100, 0)
    fill(hA, sA, b)
    rect(xx, 120, width*0.15, 40) 
  
  
  for x in range(5):
    xx = width * 0.75 +  width * 0.25/ 5 * x
    b = map(xx, width*0.75, width, 100, 0)
    fill(hB, sB, b)
    rect(xx, 120, width*0.05, 40) 
  

  nx = 20 
  ny = 16 
  rw = width/nx 
  rh = height/ny
  for y in range(ny):
    for x in range(nx):
      rx = map(x, 0, nx, 0, width) 
      ry = map(y, 0, ny, 4*rh, height) 
      pick = random(100)
      s = random(50, 100)
      b = random(50, 100)
      if (pick < 75):
        fill(hA, s, b)
      else:
        fill(hB, s, b)
      
      rect(rx, ry, rw, rh)
  noLoop()


def mouseMoved():
  loop()
