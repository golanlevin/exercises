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

var mag = 5; 

function setup() {
  createCanvas(800, 800);
  noLoop();
}

function draw() {
  background(253); 

  push();
  scale(5); 
  translate(23, 9);

  var L = 9999;
  var R = 0; 
  var T = 9999;
  var B = 0; 
  var nPoints = xData.length;
  for (var i=0; i<nPoints; i++) {
    if (xData[i] < L) {
      L = xData[i];
    }
    if (xData[i] > R) {
      R = xData[i];
    }
    if (yData[i] < T) {
      T = yData[i];
    }
    if (yData[i] > B) {
      B = yData[i];
    }
  }
  noFill(); 
  strokeJoin(MITER);
  strokeWeight(8/mag); 
  stroke(255, 50, 50); 
  rect(L, T, R-L, B-T);

  renderData(xData, yData);

  pop();
}

//==========================================
function renderData(xpts, ypts) {
  var nPoints = xpts.length;
  fill(229); 
  stroke(0); 
  strokeJoin(MITER);
  strokeWeight(8/mag); 
  beginShape();
  for (var i=0; i<nPoints; i++) {
    vertex(xpts[i], ypts[i]);
  }
  endShape(CLOSE);
}
