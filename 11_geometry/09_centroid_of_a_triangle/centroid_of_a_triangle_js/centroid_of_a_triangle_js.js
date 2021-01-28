var A; 
var B; 
var C;

var cursorImg;
var myFont; 

function setup() {
  createCanvas(800, 800); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  myFont = textFont("Helvetica-Bold", 60); 

  A = createVector(191, 115, 0); 
  B = createVector(141, 699, 0); 
  C = createVector(694, 286, 0);
}



function draw() {
  background(253);

  stroke(0);
  strokeWeight(8);

  // draw triangle
  line(A.x, A.y, B.x, B.y);
  line(A.x, A.y, C.x, C.y);
  line(C.x, C.y, B.x, B.y);

  drawCentroid();
}

function drawCentroid() {

  var AB_mid = createVector((A.x + B.x)/2, (A.y + B.y)/2);
  var BC_mid = createVector((C.x + B.x)/2, (C.y + B.y)/2);
  var CA_mid = createVector((A.x + C.x)/2, (A.y + C.y)/2);

  strokeWeight(2);
  line(A.x, A.y, BC_mid.x, BC_mid.y);
  line(AB_mid.x, AB_mid.y, C.x, C.y);
  line(CA_mid.x, CA_mid.y, B.x, B.y);

  ellipseMode(CENTER); 
  strokeWeight(8);

  fill(0); 
  ellipse(A.x, A.y, 24, 24); 
  ellipse(B.x, B.y, 24, 24); 
  ellipse(C.x, C.y, 24, 24); 

  // draw centroid
  var centroid = createVector((A.x + B.x + C.x)/3, (A.y + B.y + C.y)/3);
  fill(0, 255, 0);
  ellipse(centroid.x, centroid.y, 32, 32); 

  // draw tick marks
  drawTick(B, AB_mid, 1);
  drawTick(AB_mid, A, 1);
  drawTick(A, CA_mid, 2);
  drawTick(CA_mid, C, 2);
  drawTick(B, BC_mid, 3);
  drawTick(BC_mid, C, 3);
}

function drawTick(p1, p2, n) {
  strokeWeight(2);
  var tickLen = 20;
  
  var midpoint = p1.copy().add(p2).div(2);
  var slope = (p2.y-p1.y)/(p2.x-p1.x);
  var rad = atan(slope);
  var tickRad = atan(-1/slope);
  
  for (var i = 0; i < n; i++) {
    var x = midpoint.x + (i-n/2)*tickLen/2*cos(rad);
    var y = midpoint.y + (i-n/2)*tickLen/2*sin(rad);
    line(x-cos(tickRad)*tickLen, y-sin(tickRad)*tickLen, x+cos(tickRad)*tickLen, y+sin(tickRad)*tickLen);
  }
}

function mousePressed() {
  reset();
}

function reset() {
  A = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0); 
  B = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  C = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
}
