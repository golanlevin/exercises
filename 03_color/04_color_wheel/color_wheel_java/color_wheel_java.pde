void setup() {
  size(800, 800);
  noLoop();
  
  background(253);
  
  pushMatrix();
  translate(width/2, height/2);
 
  float radius = 320;
  colorMode(HSB, 100);
  ellipseMode(CENTER);
  noStroke();
  
  for (float t = 0; t<720; t++){
    float a = map(t, 0,720, 0, TWO_PI); 
    
    for (float r = 0; r < radius; r += 0.1) {
      float h = map(a, 0, TWO_PI, 0, 100);
      float s = map(r, 0, radius, 0, 100);
      fill(h, s, 100);
      float x = r*cos(a);
      float y = r*sin(a);
      ellipse(x, y, 3, 3);
    }
  }
  popMatrix();
  
}


void draw() {
  
}


void keyPressed() {
  if (key == ' ') {
    saveFrame("color_wheel.png");
  }
}
