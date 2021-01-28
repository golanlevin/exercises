PVector A; 
PVector B; 
PImage cursorImg;

void setup() {
  size(800, 800);
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); //cursor1.png");
}

void draw() {
  background(253); 

  // Write a program that draws a line from the 
  // center of the canvas to the cursor. Construct
  // a second line which starts at the cursor, 
  // which is 50 pixels long, and which is 
  // perpendicular to the first line. 

  float cx = width/2.0; 
  float cy = height/2.0; 
  float mx = mouseX-5;
  float my = mouseY;

  fill(0);
  stroke(0); 
  strokeCap(PROJECT);
  strokeWeight(8);
  line (cx, cy, mx, my); 

  float dx = mx - cx;
  float dy = my - cy;
  float dh = sqrt(dx*dx + dy*dy); 

  float len = 100.0; 
  float px = mx + len * dy/dh;
  float py = my - len * dx/dh;
  line (mx, my, px, py); 

  noStroke();
  ellipse(cx, cy, 24, 24); 
  ellipse(px, py, 24, 24); 

  image(cursorImg, mouseX, mouseY, 15*6, 21*6); 
}



void keyPressed() {
  if (key == ' ') {
    saveFrame("construction_of_a_perpendicular.png");
  }
}
