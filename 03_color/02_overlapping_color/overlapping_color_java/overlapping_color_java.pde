// Overlapping color
// Exercises: Overlapping

void setup() {
  size(800, 800);
  noLoop();
}

void draw() {
  background(253);
  blendMode(DIFFERENCE);
  noStroke();
  
  float alpha = 255;
  float a = width/3;
  float d = a*1.618; 
  float h = a * sqrt(3.0) / 2.0; 
  float m = (height - (a*2+h))/2;

  //colored circles
  fill(0, 255, 0, alpha);
  ellipse(a*1, m+a, d, d);

  fill(255, 0, 0, alpha);
  ellipse(a*2, m+a, d, d);

  fill(0, 0, 255, alpha);
  ellipse(width/2, m+a+h, d, d);
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("../overlapping.png");
  }
}
