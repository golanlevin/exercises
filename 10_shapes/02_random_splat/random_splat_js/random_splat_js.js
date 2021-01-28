function setup() {
  createCanvas(800, 800);
  noLoop(); 
}

function draw() {
  background(253); 
  fill(229); 
  stroke(0);
  strokeJoin(ROUND);
  strokeWeight(8); 
  

  var nVertices = 55; 
  var cx = width/2;
  var cy = height/2; 
  beginShape(); 
  for (var i=0; i<nVertices; i++) {
    var t = map(i, 0, nVertices, 0, TWO_PI); 
    var radius = 260 + random(-8,8); 
    var px = cx + radius * cos(t); 
    var py = cy + radius * sin(t); 
    curveVertex(px, py);
  }
  endShape(CLOSE);
}
