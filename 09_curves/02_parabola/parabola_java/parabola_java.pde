void setup() {
  size(800, 800);
}

void draw() {
  background(253);
  strokeWeight(8);
  stroke(0);
  
  pushMatrix();
  translate(width/2, 0);
  for (float x = -500; x < 500; x++) {
    float y = 700.0-pow(x, 2)/140;
    point(x, y);
  }
  popMatrix();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("parabola.png");
  }
}
