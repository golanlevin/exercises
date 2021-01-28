A, B, cursorImg = None, None, None

def setup():
  size(800, 800)
  global A, B, cursorImg
  cursorImg = loadImage("cursor_with_shadow_15x21.png")

def draw():
  background(253)
  
  global A, B, cursorImg

  cx = width/2.0
  cy = height/2.0
  mx = mouseX-5
  my = mouseY

  fill(0)
  stroke(0)
  strokeCap(PROJECT)
  strokeWeight(8)
  line (cx, cy, mx, my)

  dx = mx - cx
  dy = my - cy
  dh = sqrt(dx*dx + dy*dy)

  l = 100.0
  px = mx + l * dy/dh
  py = my - l * dx/dh
  line (mx, my, px, py)

  noStroke()
  ellipse(cx, cy, 24, 24)
  ellipse(px, py, 24, 24)

  image(cursorImg, mouseX, mouseY, 15*6, 21*6)
