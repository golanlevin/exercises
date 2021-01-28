void setup() {
  size(800, 800);
}

void draw() {
  background(253); 
  fill(229); 
  stroke(0); 
  strokeJoin(MITER);
  strokeWeight(8);

  int nVertices = 10; 
  float cx = width/2;
  float cy = height/2; 
  float magicFraction = 0.38196; // (1-1/phi)

  beginShape(); 
  for (int i=0; i<nVertices; i++) {
    float t = HALF_PI + map(i, 0, nVertices, 0, TWO_PI); 
    float radius = 300; 
    if (i%2 == 0) {
      radius *= magicFraction;
    }

    float px = cx + radius * cos(t); 
    float py = cy + radius * sin(t); 
    vertex(px, py);
  }
  endShape(CLOSE);
}

//===================================
void keyPressed() {
  if (key == ' ') {
    saveFrame("make_a_star.png");
  }
}
