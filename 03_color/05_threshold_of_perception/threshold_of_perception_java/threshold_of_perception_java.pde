void setup() {
  size(800, 800);
}

void draw() {
  noStroke();
  
  float phi = 0.618034; 
  
  fill( 60, 130, 235);
  rect(0, 0, width, height);
  fill( 65, 135, 240);
  ellipse(width/2, height/2, width*phi, height*phi);
}

void keyPressed() {
  saveFrame("../color_and_perception.png");
}
