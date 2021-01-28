myImage = None; 
cursorImg = None; 

def setup():
  global myImage,cursorImg
  size(800,800); 
  myImage = loadImage("3302-800px.png"); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 


def draw():
  background(253); 
  image(myImage, 20,80); 
  
  
  cx = 600; 
  cy = 200; 
  cd = 200; 
  col = get(mouseX, mouseY);
  
  noFill();  
  stroke(0); 
  strokeWeight(8); 
  strokeJoin(MITER); 
  strokeCap(SQUARE); 
  beginShape();
  vertex(mouseX, mouseY+4);
  vertex(cx, mouseY+4); 
  vertex(cx, cy); 
  endShape(); 
  

  fill(col); 
  ellipse(cx, cy, cd, cd); 
  image(cursorImg, mouseX, mouseY, 15*6, 21*6); 


def keyPressed():
  if (key == ' '):
    saveFrame("color_of_a_pixel.png"); 
