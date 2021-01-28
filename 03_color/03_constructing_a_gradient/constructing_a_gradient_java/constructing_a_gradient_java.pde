// Exercises: Color
// Two Color Gradient

color p;
color c, d;
void setup() {
  size(800, 800);
  c= color(random(255), random(255), random(255));
  d= color(random(255), random(255), random(255));
}

void draw() {
  for (int x=0; x<width; x++) { //loop through every x
    p = lerpColor(c, d, (float)x/(float)width);
    stroke(p);
    line(x, 0, x, height); //draw a vertical line at every x
  }
}


void mousePressed() {
  c= color(random(255), random(255), random(255));
  d= color(random(255), random(255), random(255));
}

void keyPressed(){
  if (key == ' '){
    saveFrame("constructing_a_gradient.png"); 
  }
}
