var A; 
var B; 
var C;

function setup(){
  createCanvas(800, 800); 
  reset();
}

function draw() {
  background(253);
  
  stroke(0);
  strokeWeight(8);
  
  // draw triangle
  line(A.x, A.y, B.x, B.y);
  line(A.x, A.y, C.x, C.y);
  line(C.x, C.y, B.x, B.y);
  
  drawOrthoCenter();
}

function drawOrthoCenter() { 
  var CDrop = drawPerpendicularLine(A, B, C);
  var BDrop = drawPerpendicularLine(C, A, B);
  var ADrop = drawPerpendicularLine(C, B, A);
  
  // find the intersection between two of the "altitudes"
  var P1 = A; 
  var P2 = ADrop;
  var P3 = B;
  var P4 = BDrop;
  var ua = ((P4.x-P3.x)*(P1.y-P3.y) - (P4.y-P3.y)*(P1.x-P3.x))/((P4.y-P3.y)*(P2.x-P1.x) - (P4.x-P3.x)*(P2.y-P1.y));
  var ub = ((P2.x-P1.x)*(P1.y-P3.y) - (P2.y-P1.y)*(P1.x-P3.x))/((P4.y-P3.y)*(P2.x-P1.x) - (P4.x-P3.x)*(P2.y-P1.y));
  var x = P1.x + ua * (P2.x-P1.x);
  var y = P1.y + ua * (P2.y-P1.y);
  
  ellipseMode(CENTER); 
  
  fill(0); 
  strokeWeight(8);

  ellipse(A.x, A.y, 24, 24); 
  ellipse(B.x, B.y, 24, 24); 
  ellipse(C.x, C.y, 24, 24); 
  
  fill(0, 255, 0);
  ellipse(x, y, 32, 32);
 
}


// draw perpendicularLine from P3 to line segment P1-P2
// return the coordinates of the point where the altitude crosses the opposite side
function drawPerpendicularLine(P1, P2, P3) {
    // http://paulbourke.net/geometry/pointlineplane/
  var numer = ((P3.x-P1.x)*(P2.x-P1.x) + (P3.y-P1.y)*(P2.y-P1.y));
  var denom = ((P2.x-P1.x)*(P2.x-P1.x) + (P2.y-P1.y)*(P2.y-P1.y));
  var u = numer / denom; 
  
  var px = P1.x + u*(P2.x - P1.x);
  var py = P1.y + u*(P2.y - P1.y);
  var pPerp = createVector(px, py);
  
  line(px, py, P3.x, P3.y);
  drawSquare(pPerp, P3);
  
  return pPerp;
}

function drawSquare(p0, p1) {
  var slope = (p0.y - p1.y)/(p0.x - p1.x);
  var rad = atan(slope);
  if (p1.x - p0.x < 0) {
    rad += PI;
  }
  
  push();
  translate(p0.x, p0.y);
  rotate(rad);
  noFill();
  strokeWeight(2);
  rect(0, 0, 30, 30);
  pop();
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
