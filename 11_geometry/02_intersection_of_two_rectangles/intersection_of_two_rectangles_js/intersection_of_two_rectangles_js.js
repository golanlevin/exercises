var A1; 
var A2; 
var B1; 
var B2; 

var myFont; 

var dot_diameter = 24;
var color_dot_diameter = 32;

function setup() {
  createCanvas(800, 800); 
  myFont = textFont("Helvetica-bold", 60); 
  
  reset();
}

function draw() {
  background(253); 
  stroke(0); 
  
  rectMode(CORNERS); // the first two parameters of rect() as the location of one corner, and the third and fourth parameters as the location of the opposite corner

  // draw two rectangles
  noFill();
  strokeWeight(8);
  rect(A1.x, A1.y, A2.x, A2.y);
  rect(B1.x, B1.y, B2.x, B2.y);
  
  var A_mid = createVector((A1.x + A2.x)/2, (A1.y + A2.y)/2);
  var B_mid = createVector((B1.x + B2.x)/2, (B1.y + B2.y)/2);
  intersect(A1, A2, B1, B2);

}

function mousePressed() {
  reset();
}

// Returns true if two rectangles (l1, r1) and (l2, r2) overlap 
function intersect(l1, r1, l2, r2) {
  
  // If one rectangle is on left side of other 
  if (l1.x >= r2.x || l2.x >= r1.x) {
    return false; 
  }
  
  // If one rectangle is above other 
  if (l1.y >= r2.y || l2.y >= r1.y) {
    return false;
  }
  
  corner1 = createVector(max(l1.x, l2.x), max(l1.y, l2.y));
  corner2 = createVector(min(r1.x, r2.x), min(r1.y, r2.y));
  strokeWeight(2);
  line(corner1.x, corner1.y, corner2.x, corner2.y);
  line(corner1.x, corner2.y, corner2.x, corner1.y);
  
  return true;
}

function reset() {
  A1 = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0); 
  A2 = createVector(random(A1.x+10, width*0.9), random(A1.y+10, height*0.9), 0); 
  B1 = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  B2 = createVector(random(B1.x+10, width*0.9), random(B1.y+10, height*0.9), 0); 
  //A1 = createVector(120, 100); 
  //A2 = createVector(500, 420); 
  //B1 = createVector(250, 250);
  //B2 = createVector(650, 700); 
}
