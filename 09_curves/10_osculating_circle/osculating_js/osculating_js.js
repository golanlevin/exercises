// Press keys 0 (draw), 1 (set c1), 2 (set c2).

var MODE_DRAW = 0; 
var MODE_PLACE1 = 1; 
var MODE_PLACE2 = 2; 
var mode;
var EPSILON = 0.0001;

var myLine;
var C1; 
var C2; 
var C1index; 
var C2index;
var indexOfClosest;

function setup() {
  createCanvas(800, 800); 
  mode = MODE_DRAW;
  myLine = [];
  C1 = createVector(); 
  C2 = createVector(); 

  indexOfClosest = -1;
  C1index = -1;
  C2index = -1;
}

//--------------------------------------------------
function draw() {
  background(253); 
  ellipseMode(CENTER); 

  findClosestPointOnLine(); 
  drawMyLine();
  // drawMyTangents();

  drawOsculatingCircle(C1index);
  drawOsculatingCircle(C2index);
}



//==============================================================
function drawOsculatingCircle (index) {
  if (index > 0) {
    var pt1 = myLine[index-1]; 
    var pt2 = myLine[index  ]; 
    var pt3 = myLine[index+1]; 
    var C1 = calcCircleFrom3Points(pt1.x, pt1.y, pt2.x, pt2.y, pt3.x, pt3.y); 

    fill(255); 
    stroke(0); 
    strokeWeight(2); 
    ellipse(C1.x, C1.y, C1.z*2, C1.z*2);

    fill(0);
    noStroke();
    ellipse(C1.x, C1.y, 24, 24);
  }
}


//==============================================================
//From http://paulbourke.net/geometry/circlesphere/

function calcCircleFrom3Points (pt1x, pt1y, pt2x, pt2y, pt3x, pt3y) {

  var out = [0, 0, 0]; 

  var yDelta_a = pt2y - pt1y;
  var xDelta_a = pt2x - pt1x;
  var yDelta_b = pt3y - pt2y;
  var xDelta_b = pt3x - pt2x;

  var m_Centerx = 0; 
  var m_Centery = 0; 
  var m_dRadius = 0; 
  if (abs(xDelta_a) <= EPSILON && abs(yDelta_b) <= EPSILON) {
    m_Centerx = 0.5*(pt2x + pt3x);
    m_Centery = 0.5*(pt1y + pt2y);
    m_dRadius = sqrt(sq(m_Centerx-pt1x) + sq(m_Centery-pt1y));
    return out;
  }

  // IsPerpendicular() assure that xDelta(s) are not zero
  var aSlope = yDelta_a / xDelta_a; 
  var bSlope = yDelta_b / xDelta_b;
  if (abs(aSlope-bSlope) <= EPSILON) {  // checking whether the given points are colinear.   
    return out;
  }

  // calc center
  m_Centerx = (aSlope*bSlope*(pt1y - pt3y) + bSlope*(pt1x + pt2x)- aSlope*(pt2x+pt3x) )/(2* (bSlope-aSlope) );
  m_Centery = -1*(m_Centerx - (pt1x+pt2x)/2)/aSlope +  (pt1y+pt2y)/2;
  m_dRadius = sqrt(sq(m_Centerx-pt1x) + sq(m_Centery-pt1y));

  out.x = m_Centerx;
  out.y = m_Centery;
  out.z = m_dRadius;
  return out;
}


//--------------------------------------------------
function findClosestPointOnLine() {
  if ((mode == MODE_PLACE1) || (mode == MODE_PLACE2)) {
    // find closest point on line
    indexOfClosest = -1; 
    if (myLine.length > 0) {
      var minDist = 99999; 
      for (var i=0; i<myLine.length; i++) {
        var dx = mouseX - myLine[i].x; 
        var dy = mouseY - myLine[i].y; 
        var dh = sqrt (dx*dx + dy*dy);
        if (dh < minDist) {
          minDist = dh; 
          indexOfClosest = i;
        }
      }
    }
  }
}

//--------------------------------------------------
function drawMyTangents() {

  stroke(0);
  strokeWeight(8); 
  fill(255, 200, 200); 

  if (C1index != -1) {
    var tangentP1 = myLine[C1index]; 
    ellipse(tangentP1.x, tangentP1.y, 32, 32);
  }
  if (C2index != -1) {
    var tangentP2 = myLine[C2index]; 
    ellipse(tangentP2.x, tangentP2.y, 32, 32);
  }
}

//--------------------------------------------------
function drawMyLine() {
  noFill();
  stroke(0); 
  strokeWeight(8); 
  strokeJoin(ROUND); 
  strokeCap(ROUND); 
  beginShape(); 
  for (var i=0; i<myLine.length; i++) {
    var px = myLine[i].x; 
    var py = myLine[i].y; 
    curveVertex(px, py);
  }
  endShape();
}


//--------------------------------------------------
function smoothMyLine() {
  for (var j=1; j<(myLine.length-1); j++) {
    var vi = myLine[j-1];
    var vj = myLine[j];
    var vk = myLine[j+1]; 

    var px = (vi.x + vj.x + vk.x)/3.0;
    var py = (vi.y + vj.y + vk.y)/3.0; 
    myLine[j] = createVector(px, py);
  }
}

//--------------------------------------------------
function keyPressed() {
  if (key == '1') {
    mode = MODE_PLACE1;
  } else if (key == '2') {
    mode = MODE_PLACE2;
  } else if (key == '0') {
    mode = MODE_DRAW;
  } else if (key == ' ') {
    saveFrame("osculating_circle.png");
  } else if (key == 's') {
    smoothMyLine();
  }
}

//--------------------------------------------------
function mousePressed() {
  if (mode == MODE_DRAW) {

    indexOfClosest = -1;
    C1index = -1;
    C2index = -1; 

    myLine= []; 
    myLine.push(createVector(mouseX, mouseY));
    ;
  } else if ((mode == MODE_PLACE1) && (indexOfClosest != -1)) {
    C1index = indexOfClosest;
  } else if ((mode == MODE_PLACE2) && (indexOfClosest != -1)) {
    C2index = indexOfClosest;
  }
}

//--------------------------------------------------
function mouseDragged() {
  if (mode == MODE_DRAW) {
    myLine.push(createVector(mouseX, mouseY));
  } else if ((mode == MODE_PLACE1) && (indexOfClosest != -1)) {
    C1index = indexOfClosest;
  } else if ((mode == MODE_PLACE2) && (indexOfClosest != -1)) {
    C2index = indexOfClosest;
  }
}
