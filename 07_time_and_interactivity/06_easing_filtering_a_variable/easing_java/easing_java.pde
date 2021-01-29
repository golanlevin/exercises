float mx, my; 
PImage cursorImg;
boolean bScreenshotRequested = false; 

void setup() {
  size(800, 800);
  noStroke();
  cursorImg = loadImage("cursor_with_shadow_15x21.png");
  background(253);
  frameRate(10); 
}

void draw() {
  
  fill (0,0,0, 64); 
  ellipse(mx, my, 80, 80);
  float A = 0.7; 
  float B = 1.0-A;
  mx = A*mx + B*mouseX; 
  my = A*my + B*mouseY; 

  if (bScreenshotRequested) {
    image(cursorImg, mouseX, mouseY, 15*6, 21*6);
    saveFrame("easing_####.png");
    bScreenshotRequested = false; 
    background(253);
  }
}

void keyPressed() {
  if (key == ' ') {
    bScreenshotRequested = true;
  } else {
    background(253);
  }
}
