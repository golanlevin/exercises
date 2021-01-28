// Checker board generation
// Using nested iteration

void setup() {
  size(800, 800, FX2D);
  noLoop(); 
}

void draw() {
  noStroke(); 
  int S = 100; 
  for (int row=0; row<8; row++){
    for (int col=0; col<8; col++){
      int c = (((row%2)+(col%2)+1)%2)*255;
      fill(c); 
      rect(col*S, row*S, S,S); 
    }
  }
}

void keyPressed(){
  saveFrame("checkers.png"); 
}
