PVector A; 
PVector B; 
PVector C;

void setup() {
  size(800, 800); 
  reset();
}

void draw() {
  background(253); 

  // get circle from 3 points
  // ref: https://www.geeksforgeeks.org/equation-of-circle-when-three-points-on-the-circle-are-given/#:~:text=Equation%20of%20circle%20in%20general,and%20r%20is%20the%20radius.&text=Radius%20%3D%201-,The%20equation%20of%20the%20circle,2%20%2B%20y2%20%3D%201.
  float x12 = A.x - B.x; 
  float x13 = A.x - C.x; 

  float y12 = A.y - B.y; 
  float y13 = A.y - C.y; 

  float y31 = C.y - A.y; 
  float y21 = B.y - A.y; 

  float x31 = C.x - A.x; 
  float x21 = B.x - A.x; 

  float sx13 = sq(A.x) - sq(C.x);
  float sy13 = sq(A.y) - sq(C.y); 
  float sx21 = sq(B.x) - sq(A.x); 
  float sy21 = sq(B.y) - sq(A.y); 

  float f = ((sx13) * (x12) 
    + (sy13) * (x12) 
    + (sx21) * (x13) 
    + (sy21) * (x13)) 
    / (2 * ((y31) * (x12) - (y21) * (x13))); 
  float g = ((sx13) * (y12) 
    + (sy13) * (y12) 
    + (sx21) * (y13) 
    + (sy21) * (y13)) 
    / (2 * ((x31) * (y12) - (x21) * (y13))); 

  float c = - sq(A.x) - sq(A.y) - 2*g*A.x - 2*f*A.y; 

  // Eqn of circle is x^2 + y^2 + 2*g*x + 2*f*y + c = 0 
  // where center is (h = -g, k = -f) and radius r 
  // as r^2 = h^2 + k^2 - c 
  float h = -g; 
  float k = -f; 
  float r = sqrt(h * h + k * k - c); 

  // circle in background
  noFill();
  stroke(0); 
  strokeWeight(2);
  ellipse(h, k, (2*r), (2*r));

  // draw triangle
  stroke(0); 
  strokeWeight(8);
  line(A.x, A.y, B.x, B.y);
  line(A.x, A.y, C.x, C.y);
  line(C.x, C.y, B.x, B.y);

  // draw points at vertices
  fill(0); 
  noStroke(); 
  ellipse(A.x, A.y, 24, 24); 
  ellipse(B.x, B.y, 24, 24); 
  ellipse(C.x, C.y, 24, 24); 

  // draw center point
  fill(0, 255, 0);
  stroke(0); 
  strokeWeight(8);
  ellipse(h, k, 32, 32);
}

void mousePressed() {
  reset();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("triangle_circumcenter.png");
  } else {
    reset();
  }
}

void reset() {
  A = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0); 
  B = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  C = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  A = new PVector(191, 115, 0); 
  B = new PVector(141, 699, 0); 
  C = new PVector(694, 286, 0);
}
