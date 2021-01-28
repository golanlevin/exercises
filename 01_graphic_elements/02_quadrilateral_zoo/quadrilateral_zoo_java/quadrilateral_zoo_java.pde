float offset;
float x;

void setup() {
  size(800, 800);
  offset = width/10;
  x = offset * 2;
}

void draw() {
  background(253);
  strokeWeight(8);
  strokeJoin(MITER); // sharp
  fill(255); 
  
  // square 
  pushMatrix();
  translate(offset, offset);
  square(0, 0, x);
  popMatrix();
  
  // rectangle
  pushMatrix();
  translate(offset*2 + x, offset);
  rect(0, 0, x*2.5, x);
  popMatrix();
  
  // parallelogram
  pushMatrix();
  translate(offset, offset*2 + x);
  quad(0, x, x/sqrt(3), 0, sqrt(3)*x + x/2, 0, 2/sqrt(3)*x + x/2, x);
  popMatrix();
  
  // rhombus
  pushMatrix();
  translate(offset*1.5 + x*2, offset*2 + x);
  quad(0, x, x/sqrt(3), 0, sqrt(3)*x, 0, 2/sqrt(3)*x, x);
  popMatrix();
  
  // trapezoid
  pushMatrix();
  translate(offset, offset*3 + 2*x);
  quad(0, x, x/3, 0, x*2/3, 0, x, x);
  popMatrix();
  
  // kite
  pushMatrix();
  translate(offset*3 + x*2, offset*3 + 2*x);
  quad(0, 0, 0, x*0.75, x, x, x*0.75, 0);
  popMatrix();
  
  // dart
  pushMatrix();
  translate(offset*2 + x, offset*3 + 2*x);
  translate(x/2, x*0.75); 
  rotate(radians(180+45)); 
  translate(-x/2, -x/2);
  quad(0, x-x/8, x, x, x-x/8, 0, x*2/3, x*2/3);
  popMatrix();
  
}


void keyPressed() {
  if (key == ' '){
    saveFrame("quadrilateral_zoo.png");
  }
}
