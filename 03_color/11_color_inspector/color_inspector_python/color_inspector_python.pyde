sourceImg, cursorImg, myFont = None, None, None

#------------------------------------
def setup():
  size(800, 800)
  
  global sourceImg, cursorImg, myFont
  sourceImg = loadImage("monet_haystack.jpg") 
  cursorImg = loadImage("cursor_with_shadow_15x21.png")
  myFont = createFont("Helvetica-Bold", 60)


#------------------------------------
def draw():
  global sourceImg, cursorImg, myFont
  
  background(253) 
  textFont(myFont, 60) 

  image(sourceImg, 0, 0, 800, 629) 
  col = get(mouseX, mouseY) 
  colr = int(red(col))
  colg = int(green(col)) 
  colb = int(blue(col))

  fill(col) 
  noStroke() 
  m = 24 
  eh = (height-629)-2*m
  println(eh) 
  rect(m, 629+m, eh, eh, m) 

  ellipseMode(CENTER) 
  noStroke() 
  ew = (width - eh - 2*m)/3 - m
  fill(colr, 0, 0) 
  ellipse(m+eh+m+ew/2, 629+m+ eh/2, ew, eh) 
  fill(0, colg, 0) 
  ellipse(m+eh+m+ew+m+ew/2, 629+m+ eh/2, ew, eh) 
  fill(0, 0, colb) 
  ellipse(m+eh+m+ew+m+ew+m+ew/2, 629+m+ eh/2, ew, eh) 

  fill(255) 
  textAlign(CENTER, CENTER) 
  text(colr, m+eh+m+ew/2, 629+m+ eh/2 - 4) 
  text(colg, m+eh+m+ew+m+ew/2, 629+m+ eh/2 - 4) 
  text(colb, m+eh+m+ew+m+ew+m+ew/2, 629+m+ eh/2 - 4) 

  image(cursorImg, mouseX, mouseY, 15*6, 21*6)
