void setup() {
  size(800, 800);
  background(253);
  
  float L = width/4;
  float h = 150;
  
  pushMatrix(); 
  translate(0, height/2); 
  
  stroke(0); 
  strokeJoin(ROUND); 
  strokeWeight(8);
  beginShape();
  int ox = 30; 
  for (int x = (0-ox); x < (width+ox); x++) {
    float y = 0;
    for (int n = 1; n < 8; n += 2) {
      y += h*4.0/PI*1.0/n * sin(n*PI*(x-2*L)/L * 0.75);
    }
    vertex(x, y);
  }
  endShape();
  
  stroke(0); 
  strokeWeight(2); 
  line(0,0, width, 0); 
  
  popMatrix(); 
}

void draw() {


}

void keyPressed() {
  saveFrame("fourier.png");
}
