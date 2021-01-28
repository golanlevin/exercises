var mode;

var cp1;
var p1;

var cp2;
var p2;

var cp3;
var p3;

function setup() {
  createCanvas(800, 800);
  strokeWeight(8);
  stroke(0);
  smooth();
  noFill();
  mode = ' ';
  frameRate(100);
  
  
  cp1 = createVector(300, 100);
  p1 = createVector(750, 200);

  cp2 = createVector(300, 500);
  p2 = createVector(400, 450);

  cp3 = createVector(500, 400);
  p3 = createVector(400, 450);
}

function draw() {
  background(253);

  noFill();

  if (mode == '1') {
    p1 = createVector(mouseX, mouseY);
  } else if (mode == '2') {
    p2 = createVector(mouseX, mouseY);
  } else if (mode == '3') {
    p3 = createVector(mouseX, mouseY);
  } else if (mode == 'a') {
    cp1 = createVector(mouseX, mouseY);
  } else if (mode == 'b') {
    cp2 = createVector(mouseX, mouseY);
  } else if (mode == 'c') {
    cp3 = createVector(mouseX, mouseY);
  }

  var cp2_ = createVector(p2.x + (p2.x - cp2.x), p2.y + (p2.y - cp2.y));

  stroke(0); 
  strokeWeight(3);
  line(cp1.x, cp1.y, p1.x, p1.y);
  line(cp2.x, cp2.y, cp2_.x, cp2_.y);
  line(cp3.x, cp3.y, p3.x, p3.y);
  strokeWeight(8);
  bezier(p1.x, p1.y, cp1.x, cp1.y, cp2.x, cp2.y, p2.x, p2.y);
  bezier(p2.x, p2.y, cp2_.x, cp2_.y, cp3.x, cp3.y, p3.x, p3.y);

  var R = 32;
  var r = 24; 

  stroke(0); 
  strokeWeight(8);
  fill(255, 200, 200);
  ellipse(cp1.x, cp1.y, R, R);
  ellipse(cp2.x, cp2.y, R, R);
  ellipse(cp2_.x, cp2_.y, R, R);
  ellipse(cp3.x, cp3.y, R, R);

  fill(0); 
  noStroke(); 
  ellipse(p1.x, p1.y, r, r);
  ellipse(p2.x, p2.y, r, r);
  ellipse(p3.x, p3.y, r, r);
}

//-----------------------------------------------
function keyPressed() {
  mode = key;
}
