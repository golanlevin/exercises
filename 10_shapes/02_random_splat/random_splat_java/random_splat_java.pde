void setup() {
  size(800, 800);
  noLoop(); 
}

void draw() {
  background(253); 
  fill(229); 
  stroke(0);
  strokeJoin(ROUND);
  strokeWeight(8); 
  

  int nVertices = 55; 
  float cx = width/2;
  float cy = height/2; 
  beginShape(); 
  for (int i=0; i<nVertices; i++) {
    float t = map(i, 0, nVertices, 0, TWO_PI); 
    float radius = 260 + random(-8,8); 
    float px = cx + radius * cos(t); 
    float py = cy + radius * sin(t); 
    curveVertex(px, py);
  }
  endShape(CLOSE);
}

//===================================
void keyPressed() {
  if (key == ' ') {
    saveFrame("random_splat.png");
  }
}
