function setup() {
  createCanvas(800, 800);
}

function draw() {
  background(253);
  
  var nPoints = 20;
  var radius = 300;
  var separation = 125;
  // draw the circle normally
  push();
  translate(width/2, height/2);
  noFill();
  stroke(0); 
  strokeWeight(8);
  beginShape();
  for (var i = 0; i < nPoints; i++) {
    var theta = map(i, 0, nPoints, 0, TWO_PI);
    var px = radius * cos(theta);
    var py = radius * sin(theta);
    vertex(px, py); 
  }
  endShape(CLOSE);
  pop();
  
  push();
  translate(width/2, height /2);
  for (var i = 0; i < nPoints; i++) {
    var theta = map(i, 0, nPoints, 0, TWO_PI);
    var px = radius * cos(theta);
    var py = radius * sin(theta);
    // fill(255, 200, 200);
    // ellipse(px, py, 32, 32);
    fill(0); 
    noStroke();
    ellipse(px, py, 24,24);
  }
  pop();
}
