// Exercises: Interactivity
// Eyes Following Cursor

PImage img;

void setup() {
  size(800, 800);
  noStroke();
  smooth();
  //noLoop();
  img = loadImage("cursor_with_shadow_15x21.png");
}

void draw() {
  background(216); 
  pushMatrix();
  scale(8.0);
  fill(255);
  ellipse(50, 50, 60, 60); // White circle
  float ex = map(mouseX, 0, width, 30, 50);
  float ey = map(mouseY, height, 0, 60, 40);

  pupil(ex, ey);
  popMatrix();
  
  image(img, mouseX, mouseY, 15*6, 21*6); 
}

void pupil(float x, float y) {
  fill(0);
  ellipse(x+10, y, 30, 30); // Black circle
  fill(255);
  ellipse(x+16, y-5, 6, 6); // Small, white circle
}

void keyPressed() {
  saveFrame("eyes.png");
}
