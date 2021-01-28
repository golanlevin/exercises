// Hexagonal Grid

float sqrt3 = sqrt(3);

void setup() {
  size(800, 800);
  smooth();
}

void draw() {
  background(253); 

  float side = 19.05; 
  float nDown   = 2*height / (3*side*sqrt3)+1; 
  float nAcross = width / (3 * side) +1; 

  for (int j=0; j<=nAcross; j++) {
    float offsetX = j * (3*side); 

    for (int i=0; i<=nDown; i++) {
      float hx = offsetX + (i%2)*1.5*side; 
      float hy = i * side * 1.5 * sqrt3;

      stroke(0);
      strokeWeight(4.0); 
      
      float gray = random(255);
      fill (gray); 
      hexagon(hx, hy, side);
    }
  }
}


void hexagon(float x, float y, float side) {
  pushMatrix(); 
  translate(x, y); 
  beginShape();
  vertex ( 1.5 * side, 0.5 * sqrt3 * side); // SE
  vertex ( 0.0 * side, 1.0 * sqrt3 * side); // S
  vertex (-1.5 * side, 0.5 * sqrt3 * side); // SW
  vertex (-1.5 * side, -0.5 * sqrt3 * side); // NW
  vertex ( 0.0 * side, -1.0 * sqrt3 * side); // N
  vertex ( 1.5 * side, -0.5 * sqrt3 * side); // NE
  endShape(CLOSE);
  popMatrix();
}

void keyPressed(){
  if (key == 's'){
    saveFrame("../hexagonal_grid.png"); 
  }
}
