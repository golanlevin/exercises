float rot; 

void setup() {
  size(800, 800, FX2D);
  smooth();
  rot = 0;
}

void draw() {
  background(253); 
  strokeWeight(2.0); 
  stroke(0); 
  
  pushMatrix(); 
  translate(-50, 0); 
  
  float mx = -mouseX/200.0; //-0.06;
  rot = 0.95*rot + 0.05*(mx); 


  int nLines = 80; 
  for (int i=0; i<nLines; i++) {
    float x = map(i, 0, nLines-1, width/2-250, width/2+250); 
    line(x, 0, x, height);
  }
  
  float tx = 0.598;
  pushMatrix();
  translate(width*tx, height/2); 
  rotate(rot); 
  for (int i=0; i<nLines; i++) {
    float x = map(i, 0, nLines-1, -250, 250); 
    line(x, -height*0.4, x, height*0.4);
  }
  popMatrix();
  popMatrix();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("moire.png");
  }
}
