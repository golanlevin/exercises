// Hexagonal Grid

var sqrt3;

function setup() {
  createCanvas(800, 800);
  smooth();
  sqrt3 =  sqrt(3);
  noLoop();
}

function draw() {
  background(253); 

  var side = 19.05; 
  var nDown   = 2*height / (3*side*sqrt3)+1; 
  var nAcross = width / (3 * side) +1; 

  for (var j=0; j<=nAcross; j++) {
    var offsetX = j * (3*side); 

    for (var i=0; i<=nDown; i++) {
      var hx = offsetX + (i%2)*1.5*side; 
      var hy = i * side * 1.5 * sqrt3;

      stroke(0);
      strokeWeight(4.0); 
      
      var gray = random(255);
      fill (gray); 
      hexagon(hx, hy, side);
    }
  }
}


function hexagon(x, y, side) {
  push(); 
  translate(x, y); 
  beginShape();
  vertex ( 1.5 * side, 0.5 * sqrt3 * side); // SE
  vertex ( 0.0 * side, 1.0 * sqrt3 * side); // S
  vertex (-1.5 * side, 0.5 * sqrt3 * side); // SW
  vertex (-1.5 * side, -0.5 * sqrt3 * side); // NW
  vertex ( 0.0 * side, -1.0 * sqrt3 * side); // N
  vertex ( 1.5 * side, -0.5 * sqrt3 * side); // NE
  endShape(CLOSE);
  pop();
}
