
void setup() {
  size(800, 800, FX2D);
  smooth();
  noLoop();
}

void draw() {
  background(253);
  
  int nSquares = 5;
  float sqSize = 120; 
  float cL = width/2 - ((nSquares-1)*sqSize)/2;
  float cR = width/2 + ((nSquares-1)*sqSize)/2;
  
  noFill();
  stroke(0); 
  strokeWeight(8);
  rectMode(CENTER);
  
  for (int row=0; row<nSquares; row++){
    float v = map(row, 0, nSquares-1, 0.0,0.25*row);
    
    for(int col=0; col<nSquares; col++){
      float px = map(col, 0,nSquares-1,  cL,cR); 
      float py = map(row, 0,nSquares-1,  cL,cR); 
      float R = random(-v, v); 
      pushMatrix(); 
      translate(px, py); 
      rotate(R); 
      rect(0, 0, sqSize, sqSize);
      popMatrix(); 
    }
  }

}

void keyPressed() {
  if (key == ' ') {
    saveFrame("schotter.png");
  }
}
