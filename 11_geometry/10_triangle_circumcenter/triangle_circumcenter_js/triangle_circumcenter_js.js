var A; 
var B; 
var C;

function setup() {
  createCanvas(800, 800); 
  reset();
}

function draw() {
  background(253); 

  // get circle from 3 points
  // ref: https://www.geeksforgeeks.org/equation-of-circle-when-three-points-on-the-circle-are-given/#:~:text=Equation%20of%20circle%20in%20general,and%20r%20is%20the%20radius.&text=Radius%20%3D%201-,The%20equation%20of%20the%20circle,2%20%2B%20y2%20%3D%201.
  var x12 = A.x - B.x; 
  var x13 = A.x - C.x; 

  var y12 = A.y - B.y; 
  var y13 = A.y - C.y; 

  var y31 = C.y - A.y; 
  var y21 = B.y - A.y; 

  var x31 = C.x - A.x; 
  var x21 = B.x - A.x; 

  var sx13 = sq(A.x) - sq(C.x);
  var sy13 = sq(A.y) - sq(C.y); 
  var sx21 = sq(B.x) - sq(A.x); 
  var sy21 = sq(B.y) - sq(A.y); 

  var f = ((sx13) * (x12) 
    + (sy13) * (x12) 
    + (sx21) * (x13) 
    + (sy21) * (x13)) 
    / (2 * ((y31) * (x12) - (y21) * (x13))); 
  var g = ((sx13) * (y12) 
    + (sy13) * (y12) 
    + (sx21) * (y13) 
    + (sy21) * (y13)) 
    / (2 * ((x31) * (y12) - (x21) * (y13))); 

  var c = - sq(A.x) - sq(A.y) - 2*g*A.x - 2*f*A.y; 

  // Eqn of circle is x^2 + y^2 + 2*g*x + 2*f*y + c = 0 
  // where center is (h = -g, k = -f) and radius r 
  // as r^2 = h^2 + k^2 - c 
  var h = -g; 
  var k = -f; 
  var r = sqrt(h * h + k * k - c); 

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

function mousePressed() {
  reset();
}

function reset() {
  A = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0); 
  B = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  C = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  //A = createVector(191, 115, 0); 
  //B = createVector(141, 699, 0); 
  //C = createVector(694, 286, 0);
}
