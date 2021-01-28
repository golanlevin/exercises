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
  
  drawIncenter();
}

function drawIncenter() {
  strokeWeight(8);

  // find incenter
  var AB = p5.Vector.sub(A, B);
  var BC = p5.Vector.sub(C, B);
  var AC = p5.Vector.sub(A, C);
  var a = BC.mag();
  var b = AC.mag();
  var c = AB.mag();
  var x = (a * A.x + b * B.x + c * C.x) / (a + b + c); 
  var y = (a * A.y + b * B.y + c * C.y) / (a + b + c); 
  
  // find inradius
  // semi-perimeter of the circle 
  var p = (a + b + c) / 2; 
  
  // area of the traingle 
  var area = Math.sqrt(p * (p - a) * (p - b) * (p - c)); 
  
  // Radius of the incircle 
  var radius = area / p; 
  
  strokeWeight(2);
  line(x, y, A.x, A.y);
  line(x, y, B.x, B.y);
  line(x, y, C.x, C.y);
  
  drawMarks(A, B, C, x, y, 1);
  drawMarks(B, C, A, x, y, 2);
  drawMarks(C, A, B, x, y, 3);

  fill(0); 
  ellipse(A.x, A.y, 24, 24); 
  ellipse(B.x, B.y, 24, 24); 
  ellipse(C.x, C.y, 24, 24); 
    
  noFill();
  strokeWeight(2);
  ellipse(x, y, radius*2, radius*2);
  strokeWeight(8);
  fill(0, 255, 0);
  ellipse(x, y, 32, 32);
}

function drawMarks(a, b, c, x, y, n) {
  var slope_AB = (a.y-b.y)/(a.x-b.x);
  var slope_BC = (b.y-c.y)/(b.x-c.x);
  var slope_B_center = (y-b.y)/(x-b.x);
  
  var dist = 10;
  var l = 80 - dist*(n/2);
  
  noFill();
  
  var rad_AB = atan(slope_AB);
  if ((a.x-b.x) < 0) {
    rad_AB += PI;
  }
  var rad_center = atan(slope_B_center);
  if ((x-b.x) < 0) {
    rad_center += PI;
  }
  var rad_BC = atan(slope_BC);
  if (c.x-b.x < 0) {
    rad_BC += PI;
  }
  
  for (var i = 0; i < n; i++) {
    if (max(rad_AB, rad_center) > PI && min(rad_AB, rad_center) < 0) {
      arc(b.x, b.y, l+i*dist-dist/2, l+i*dist-dist/2, max(rad_AB, rad_center), min(rad_AB, rad_center)+2*PI);
    } else {
      arc(b.x, b.y, l+i*dist-dist/2, l+i*dist-dist/2, min(rad_AB, rad_center), max(rad_AB, rad_center));
    }
    
    if (max(rad_center, rad_BC) > PI && min(rad_center, rad_BC) < 0) {
       arc(b.x, b.y, l+i*dist, l+i*dist, max(rad_center, rad_BC), min(rad_center, rad_BC)+2*PI);
    } else {
       arc(b.x, b.y, l+i*dist, l+i*dist, min(rad_center, rad_BC), max(rad_center, rad_BC));
    }
    
  }
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
