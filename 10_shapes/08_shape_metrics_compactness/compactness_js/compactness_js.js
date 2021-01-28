// There is evidence that compactness is one of the basic dimensions 
// of shape features extracted by the human visual system.
// A common compactness measure is the isoperimetric quotient, 
// The ratio of area to perimeter squared, times 4PI. 

var xCatData = [81, 83, 83, 83, 83, 82, 79, 77, 80, 83, 
  84, 85, 84, 90, 94, 94, 89, 85, 83, 75, 
  71, 63, 59, 60, 44, 37, 33, 21, 15, 12, 
  14, 19, 22, 27, 32, 35, 40, 41, 38, 37, 
  36, 36, 37, 43, 50, 59, 67, 71];
var yCatData = [10, 17, 22, 27, 33, 41, 49, 53, 67, 76, 
  93, 103, 110, 112, 114, 118, 119, 118, 121, 121, 
  118, 119, 119, 122, 122, 118, 113, 108, 100, 92, 
  88, 90, 95, 99, 101, 80, 62, 56, 43, 32, 
  24, 19, 13, 16, 23, 22, 24, 20];

var xCircData = [90, 85, 73, 54, 35, 19, 10, 10, 19, 35, 54, 73, 85];

var yCircData = [71, 89, 104, 111, 109, 98, 80, 61, 44, 33, 30, 37, 52];

var myFont18;
var myFont56; 

function setup() {
  createCanvas(800, 800); 
  myFont18 = textFont("Helvetica"); //createFont("Helvetica", 40); 
  myFont56 = textFont("Helvetica-Bold"); //createFont("Helvetica-Bold", 106);
}

function draw() {
  background(253);

  // Draw shapes
  push(); 
  scale (2.0); 
  translate(10+5, 10); 
  renderData(xCatData, yCatData);
  pop();

  push(); 
  scale (2.0); 
  translate(190+13, 10); 
  renderData(xCircData, yCircData);
  pop();

  // Compute shape metrics
  var catArea  = getArea(xCatData, yCatData); 
  var catPerimeter  = getPerimeter(xCatData, yCatData); 
  var catCompactness  = TWO_PI * 2.0 * catArea  / sq(catPerimeter); 

  var circArea  = getArea(xCircData, yCircData); 
  var circPerimeter = getPerimeter(xCircData, yCircData); 
  var circCompactness =  TWO_PI * 2.0 * circArea / sq(circPerimeter); 

  // Display metrics
  fill(0); 
  textAlign(CENTER); 

  var catDiagnostics = ""; 
  catDiagnostics += "Area = " + int(catArea) + "\n";
  catDiagnostics += "Perimeter = "  + int(round(catPerimeter)) + "\n";
  catDiagnostics += "Compactness = ";
  textFont("Helvetica", 40); 
  text(catDiagnostics, 200+20, 2*235+50);
  textFont("Helvetica-Bold", 104);//, 104);
  text(nf(catCompactness, 1, 2), 220, 740); 

  var circDiagnostics = ""; 
  circDiagnostics += "Area = " + int(circArea) + "\n";
  circDiagnostics += "Perimeter = " + int(circPerimeter) + "\n";
  circDiagnostics += "Compactness = ";
  textFont("Helvetica", 40); 
  text(circDiagnostics, 600-20, 2*235+50);
  textFont("Helvetica-Bold", 104);//, 104);
  text(nf(circCompactness, 1, 2), 580, 740);
}

//==========================================
function renderData(xpts, ypts) {
  var nPoints = xpts.length;
  fill(229); 
  stroke(0); 
  strokeJoin(MITER);
  strokeWeight(8/2); 
  beginShape();
  for (var i=0; i<nPoints; i++) {
    vertex(xpts[i]*1.7, ypts[i]*1.7);
  }
  endShape(CLOSE);
}

//==========================================
function getPerimeter(xpts, ypts) {
  var perimeter = 0; 

  var nPoints = xpts.length;
  for (var i=0; i<nPoints; i++) {
    var px = xpts[ i           ];
    var py = ypts[ i           ];
    var qx = xpts[(i+1)%nPoints];
    var qy = ypts[(i+1)%nPoints];
    var delta = dist(px, py, qx, qy); 
    perimeter += delta;
  }
  return perimeter;
}

//==========================================
function getArea(xpts, ypts) {
  var area = 0;
  var nPoints = xpts.length;
  var j = nPoints - 1; 
  for (var k = 0; k < nPoints; k++) { 
    area += ((xpts[k] + xpts[j]) * (ypts[k] - ypts[j]))/2.0; 
    j = k;  // swap; j is always the vertex previous to k
  } 
  return area;
}
