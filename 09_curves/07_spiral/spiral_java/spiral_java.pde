int diameter = 300;
int skip = 50;

void setup() {
  size(800, 800);
  shapeMode(CENTER);
  background(253);
  noFill();
  stroke(0);
  strokeWeight(8);
}

void draw() {
  arc(width/2, height/2, diameter, diameter, -1*HALF_PI, HALF_PI);
  diameter = diameter-skip;
  translate(0,-skip/2);
  arc(width/2, height/2, diameter, diameter, HALF_PI,2*PI-HALF_PI );
  diameter = diameter-skip;
}

void mousePressed() {
  saveFrame("spiral.png");
}
