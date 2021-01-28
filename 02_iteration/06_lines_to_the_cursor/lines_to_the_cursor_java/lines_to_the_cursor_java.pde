PImage cursorImg; 

void setup() {
  size(800, 800); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  smooth();
}

void draw() {
  background (255); 

  strokeWeight (8);
  stroke(0); 

  int nLines = 10;
  float margin = 100; 
  //draws n lines from equidistant starting points to the cursor location
  for (int i=1; i<=nLines; i++) {
    float x0 = map(i, 1,nLines, margin, width-margin); 
    float y0 = margin; 
    line (x0, y0, mouseX, mouseY);
  }
  
  image(cursorImg, mouseX,mouseY,90, 126); 
}

void keyPressed() {
  saveFrame("lines_to_the_cursor.png"); 
  exit();
}
