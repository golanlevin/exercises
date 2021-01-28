// Transform a circle to a triangle
// by approximating a circle with 
// three Bezier cubic splines and 
// modulating the spline control points
// Golan Levin, January 2017

// Ref:
// Golan Levin, January 2017
// https://github.com/golanlevin/circle-morphing/blob/master/circle-to-triangle/circle02/sketch.js

var radius1;
var radius2;
var radius3;
var radius4;
var radius5;
var cx, cy;
var trianglePoints1 = [];
var trianglePoints2 = [];
var trianglePoints3 = [];
var trianglePoints4 = [];
var trianglePoints5 = [];

var bShowDebug = false;

function setup() {
  createCanvas(800, 800);

  radius1 = width / 2 * 0.25;
  radius2 = width / 2 * 0.4;
  radius3 = width / 2 * 0.5;
  radius4 = width / 2 * 0.6;
  radius5 = width / 2 * 0.7;

  cx = width / 2;
  cy = height / 2;

  for (var i = 0; i < 3; i++) { // triangle vertices
    var x = cx + radius1 * cos(i * TWO_PI / 3.0 - HALF_PI);
    var y = cy + radius1 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints1[i] = {
      x, y
    };
    x = cx + radius2 * cos(i * TWO_PI / 3.0 - HALF_PI);
    y = cy + radius2 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints2[i] = {
      x, y
    };
    x = cx + radius3 * cos(i * TWO_PI / 3.0 - HALF_PI);
    y = cy + radius3 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints3[i] = {
      x, y
    };
    x = cx + radius4 * cos(i * TWO_PI / 3.0 - HALF_PI);
    y = cy + radius4 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints4[i] = {
      x, y
    };
    x = cx + radius5 * cos(i * TWO_PI / 3.0 - HALF_PI);
    y = cy + radius5 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints5[i] = {
      x, y
    };
    
  }
  
  background(253);
  noFill();

  //angle

  var amount1 = 0;
  var amount2 = 0.2;
  var amount3 = 0.4;
  var amount4 = 0.6;
  var amount5 = 0.77;

  stroke(0);
  strokeWeight(8);
  strokeJoin(MITER);
  
  for (var i = 0; i < 3; i++) {
    var p0x = trianglePoints1[i].x;
    var p0y = trianglePoints1[i].y;
    var p3x = trianglePoints1[(i + 2) % 3].x;
    var p3y = trianglePoints1[(i + 2) % 3].y;
    var p1x = p0x + (amount1 * (p0y - cy));
    var p1y = p0y - (amount1 * (p0x - cx));
    var p2x = p3x - (amount1 * (p3y - cy));
    var p2y = p3y + (amount1 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);
    
    p0x = trianglePoints2[i].x;
    p0y = trianglePoints2[i].y;
    p3x = trianglePoints2[(i + 2) % 3].x;
    p3y = trianglePoints2[(i + 2) % 3].y;
    p1x = p0x + (amount2 * (p0y - cy));
    p1y = p0y - (amount2 * (p0x - cx));
    p2x = p3x - (amount2 * (p3y - cy));
    p2y = p3y + (amount2 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);

    p0x = trianglePoints3[i].x;
    p0y = trianglePoints3[i].y;
    p3x = trianglePoints3[(i + 2) % 3].x;
    p3y = trianglePoints3[(i + 2) % 3].y;
    p1x = p0x + (amount3 * (p0y - cy));
    p1y = p0y - (amount3 * (p0x - cx));
    p2x = p3x - (amount3 * (p3y - cy));
    p2y = p3y + (amount3 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);
    
    p0x = trianglePoints4[i].x;
    p0y = trianglePoints4[i].y;
    p3x = trianglePoints4[(i + 2) % 3].x;
    p3y = trianglePoints4[(i + 2) % 3].y;
    p1x = p0x + (amount4 * (p0y - cy));
    p1y = p0y - (amount4 * (p0x - cx));
    p2x = p3x - (amount4 * (p3y - cy));
    p2y = p3y + (amount4 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);
    
    p0x = trianglePoints5[i].x;
    p0y = trianglePoints5[i].y;
    p3x = trianglePoints5[(i + 2) % 3].x;
    p3y = trianglePoints5[(i + 2) % 3].y;
    p1x = p0x + (amount5 * (p0y - cy));
    p1y = p0y - (amount5 * (p0x - cx));
    p2x = p3x - (amount5 * (p3y - cy));
    p2y = p3y + (amount5 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);
  }
  
  
}

//-----------------------------------------
function draw() {
}

function keyTyped() {
  if (keyCode == 32) { // empty space
    saveFrames('circle_to_triangle', 'png', 1, 1);
  }
}
