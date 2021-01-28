var mousePositions;
var debug;

function setup() {
  createCanvas(800, 800);
  mousePositions = [];
  frameRate(16);
  
  debug = false;
}

function draw() {
  background(253);  
  drawPolyline_by_quads();
}

function drawPolyline_by_ellipses() {  
  noStroke();  
  fill(0);
  for (var i = 1; i < mousePositions.length; i++) {
    var cur = mousePositions[i];
    var prev = mousePositions[i-1];
    var d = constrain(map(dist(cur.x, cur.y, prev.x, prev.y), 50, 10, 8, 50), 8, 50);
    ellipse(cur.x, cur.y, d, d);
  }
}

function drawPolyline_by_segments() {
  noFill();
  stroke(0);
  for (var i = 1; i < mousePositions.length; i++) {
    var cur = mousePositions[i];
    var prev = mousePositions[i-1];
    var w = map(dist(cur.x, cur.y, prev.x, prev.y), 30, 0, 3, 10);
    strokeWeight(max(1, w));
    line(cur.x, cur.y, prev.x, prev.y);
  }
}

function drawPolyline_by_quads() {
  fill(0);
  stroke(0);
  strokeWeight(1);
  beginShape(TRIANGLE_STRIP); 
  
  var rad;
  var len;
  var cur;
  var prev;
  var next;
  
  if (mousePositions.length < 2) {
    return;
  }
  
  cur = mousePositions[0];
  vertex(cur.x, cur.y);
  
  for (var i = 1; i < mousePositions.length-1; i++) {
    cur = mousePositions[i];
    prev = mousePositions[i-1];
    next = mousePositions[i+1];
    rad = estimateSlope(cur, prev, next);
    len = getWidth(i);
    var p1 = createVector(cur.x + len*cos(rad), cur.y + len*sin(rad));
    var p2 = createVector(cur.x - len*cos(rad), cur.y - len*sin(rad));
    console.log(cur.x, cur.y, rad, len);
    //console.log(p2.x, p2.y);
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    
    if (debug) {
      noFill();
      strokeWeight(1);
      stroke(0);
      line(p1.x, p1.y, p2.x, p2.y);
      
      noStroke();
      fill(255, 0, 0);
      ellipse(p1.x, p1.y, 5, 5);
      
      fill(0);
      noStroke();
    }
    
  }
  
  cur = mousePositions[mousePositions.length-1];
  vertex(cur.x, cur.y);
  
  endShape();
}

function estimateSlope(cur, prev, next) {
  var slope1 = (cur.y - prev.y)/(cur.x - prev.x+0.0001);
  var slope2 = (next.y - cur.y)/(next.x - cur.x+0.0001);
  var dist1 = dist(cur.x, cur.y, prev.x, prev.y);
  var dist2 = dist(cur.x, cur.y, next.x, next.y);
  var slopeAve = (slope1*dist1 + slope2*dist2)/(dist1+dist2+0.0001);
  var slopeAveInverse = -1/slopeAve;
  var rad = atan(slopeAveInverse);
  if (next.y - prev.y <= 0) {
    if (next.x - prev.x <= 0) {
      rad += PI;
    } else {
      rad -= PI;
    }
  }
  return rad;
}

function getWidth(index) {
  var count = 0;
  var distAccum = 0;
  for (var i = max(index-3, 1); i < min(index+3, mousePositions.length-1); i++) {
    count += 1;
    var cur = mousePositions[i-1];
    var next = mousePositions[i];
    distAccum += dist(cur.x, cur.y, next.x, next.y);
  }
  var w = constrain(map(distAccum/count, 50, 0, 2, 40), 2, 40);
  return w;
}

function mouseMoved() {
  mousePositions.push(createVector(mouseX, mouseY));
  if (mousePositions.length > 50) {
    mousePositions.splice(0, 1);
  }
  console.log(mousePositions[mousePositions.length-1].x, mousePositions[mousePositions.length-1].y);
}
