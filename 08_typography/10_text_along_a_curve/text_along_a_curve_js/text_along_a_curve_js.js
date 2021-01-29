// Text along a (Bezier) curve.

// See, for reference: 
// https://processing.org/reference/bezierPoint_.html
// https://processing.org/reference/curvePoint_.html

var myFont;   
var ctrlPts; 

function setup() {
  createCanvas(800, 800); 
  myFont = textFont("BirchStd", 72);
  
  ctrlPts = [null, null, null, null]; 
  ctrlPts[0] = createVector(45, 95); 
  ctrlPts[1] = createVector(265, 45);
  ctrlPts[2] = createVector(155, 315);
  ctrlPts[3] = createVector(355, 360);
  
  ctrlPts[0].mult(2);
  ctrlPts[1].mult(2);
  ctrlPts[2].mult(2);
  ctrlPts[3].mult(2);
}


function draw() {
  background(253); 
  
  var ax = ctrlPts[0].x;
  var ay = ctrlPts[0].y;
  var bx = ctrlPts[1].x;
  var by = ctrlPts[1].y;
  var cx = ctrlPts[2].x;
  var cy = ctrlPts[2].y; 
  var dx = ctrlPts[3].x; 
  var dy = ctrlPts[3].y; 
  
  // From https://www.azquotes.com/quotes/topics/curves.html
  // "Magic lives in curves, not angles." -- Mason Cooley
  var phrase = "magic lives in curves";

  noFill(); 
  stroke(200); 
  strokeWeight(2);
  bezier(ax, ay, bx, by, cx, cy, dx, dy);
  
  noStroke(); 
  fill(0,0,0); 
  textFont(myFont);
  textAlign(CENTER); 
  
  var nChars = phrase.length;
  for (var i = 0; i < nChars; i++) {
    
    // First, calculate the position of the i'th letter. 
    var u = map(i, 0, nChars-1, 0,1); 
    var px = bezierPoint(ax, bx, cx, dx, u);
    var py = bezierPoint(ay, by, cy, dy, u);
     
    // We need a second point to calculate the local slope.
    var v = u + 0.01;
    var qx = bezierPoint(ax, bx, cx, dx, v);
    var qy = bezierPoint(ay, by, cy, dy, v);
    var tx = qx - px; 
    var ty = qy - py; 
    var orientation = atan2(ty, tx); 
    
    // Fetch the i'th letter
    var ithChar = phrase.charAt(i);
    
    // Render it at the position, with the orientation. 
    push(); 
    translate(px, py); 
    rotate(orientation); 
    text(ithChar, 0,-5); 
    pop(); 
  }
}


function keyTyped() {
  if (keyCode == 32) { // empty space
    saveFrames('text_along_a_curve', 'png', 1, 1);
  }
}
