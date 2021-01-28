// Intersection point of two line segments. 

var P1; 
var P2; 
var P3; 
var P4; 

//------------------------------------
function setup() {
  createCanvas(800, 800);
  reset(); 
}

//------------------------------------
function draw() {
  background(253);

  // Draw the 4 points.
  noStroke(); 
  fill(0); 
  ellipse(P1.x, P1.y, 24, 24);
  ellipse(P2.x, P2.y, 24, 24); 
  ellipse(P3.x, P3.y, 24, 24); 
  ellipse(P4.x, P4.y, 24, 24); 

  // Draw the lines. 
  stroke(0); 
  strokeWeight(8);
  line(P1.x, P1.y, P2.x, P2.y); 
  line(P3.x, P3.y, P4.x, P4.y); 

  // Check if they intersect
  // Ref: http://paulbourke.net/geometry/pointlineplane/
  var denominator = ((P4.y-P3.y)*(P2.x-P1.x) - (P4.x-P3.x)*(P2.y-P1.y));
  var ua = ((P4.x-P3.x)*(P1.y-P3.y) - (P4.y-P3.y)*(P1.x-P3.x)) / denominator;
  var ub = ((P2.x-P1.x)*(P1.y-P3.y) - (P2.y-P1.y)*(P1.x-P3.x)) / denominator;
  if (ua < 0 || ub < 0 || ua > 1 || ub > 1) {
    // the line segments don't intersect
    ;
  } else {
    // Find intersection point
    var x = P1.x + ua * (P2.x-P1.x);
    var y = P1.y + ua * (P2.y-P1.y);

    // Draw intersection point. 
    fill(0, 255, 0);
    ellipse(x, y, 32, 32);
  }
}

//------------------------------------
function mousePressed() {
  reset();
}

//------------------------------------
function reset() {
  P1 = createVector(random(width), random(height));
  P2 = createVector(random(width), random(height));
  P3 = createVector(random(width), random(height));
  P4 = createVector(random(width), random(height));
}
