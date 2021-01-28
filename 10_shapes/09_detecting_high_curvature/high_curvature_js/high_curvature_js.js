var xData = [
  81, 83, 83, 83, 83, 82, 79, 77, 80, 83, 
  84, 85, 84, 90, 94, 94, 89, 85, 83, 75, 
  71, 63, 59, 60, 44, 37, 33, 21, 15, 12, 
  14, 19, 22, 27, 32, 35, 40, 41, 38, 37, 
  36, 36, 37, 43, 50, 59, 67, 71];
var yData = [
  10, 17, 22, 27, 33, 41, 49, 53, 67, 76, 
  93, 103, 110, 112, 114, 118, 119, 118, 121, 121, 
  118, 119, 119, 122, 122, 118, 113, 108, 100, 92, 
  88, 90, 95, 99, 101, 80, 62, 56, 43, 32, 
  24, 19, 13, 16, 23, 22, 24, 20];

function setup() {
  createCanvas(800, 800);
}

var mag = 5.0;
function draw() {
  background(253); 
  push();
  scale (5); 
  translate(23, 9);

  renderPointsOfHighCurvature(xData, yData);
  renderData(xData, yData);


  pop();
}

//==========================================
function renderData(xpts, ypts) {
  var nPoints = xpts.length;
  fill(229); 
  stroke(0); 
  strokeJoin(MITER); 
  strokeWeight(8.0/mag);
  beginShape();
  for (var i=0; i<nPoints; i++) {
    vertex(xpts[i], ypts[i]);
  }
  endShape(CLOSE);
}

//==========================================
function renderPointsOfHighCurvature(xpts, ypts) {

  var nPoints = xpts.length;

  for (var j=0; j<nPoints; j++) {
    var xi = xpts[(j-1+nPoints)%nPoints];
    var yi = ypts[(j-1+nPoints)%nPoints];

    var xj = xpts[j];
    var yj = ypts[j];

    var xk = xpts[(j+1)%nPoints];
    var yk = ypts[(j+1)%nPoints];

    var dxij = xi-xj;
    var dyij = yi-yj;
    var dhij = sqrt(dxij*dxij + dyij*dyij);

    var dxkj = xk-xj;
    var dykj = yk-yj;
    var dhkj = sqrt(dxkj*dxkj + dykj*dykj);

    var dot = dxij*dxkj + dyij*dykj;
    var cross = dxij*dykj - dyij*dxkj;
    var theta = acos(dot/(dhij*dhkj));
    if (theta != null) {

      var deg = degrees(abs(theta));
      if (deg < mouseX) {


        var r = map(abs(theta), 0, PI, 30, 0); 
        if (cross < 0) {
          noStroke(); 
          fill(255, 0, 0, 150); 
          ellipse(xj, yj, r, r);
        }
      }
    }
  }
}
