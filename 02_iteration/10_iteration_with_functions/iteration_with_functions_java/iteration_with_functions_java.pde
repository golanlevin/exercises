// Iteration with Functions. 
// A function which drawa a smily face, 
// is invoked inside a nested iteration.

void setup() {
  size(800, 800, FX2D);
  noLoop();
}

void draw() {
  background(253);
  smooth(); 
  
  float offset = 50;
  float n = 5;
  float side = (width-2*offset)/n;

  //draws 5 rows of 5 faces
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float y = (i+1)*side + offset - side/2; 
      float x = (j+1)*side + offset - side/2; 
      drawFace(x, y, side*4/5);
    }
  }
}


void drawFace(float x, float y, float side) {
  //constructs a face through arcs and circles
  ellipseMode(CENTER); 
  stroke(0, 0, 0);
  strokeWeight(8); 
  pushMatrix();
  translate(x, y); 
  
  ellipse(0, 0, side, side);  
  ellipse (-side*0.15, -side*0.10, side*0.18, side*0.24);
  line(     side*0.16, -side*0.10+side*0.10, 
            side*0.16, -side*0.10-side*0.10);
  
  arc(0, 0, side/2, side/2, PI*0.25, PI*0.75); 
  popMatrix();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("../iteration_with_functions.png");
  }
}
