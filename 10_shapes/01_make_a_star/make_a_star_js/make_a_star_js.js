function setup() {
  createCanvas(800, 800);
}

function draw() {
  background(253); 
  fill(229); 
  stroke(0); 
  strokeJoin(MITER);
  strokeWeight(8);

  var nVertices = 10; 
  var cx = width/2;
  var cy = height/2; 
  var magicFraction = 0.38196; // (1-1/phi)

  beginShape(); 
  for (var i=0; i<nVertices; i++) {
    var t = HALF_PI + map(i, 0, nVertices, 0, TWO_PI); 
    var radius = 300; 
    if (i%2 == 0) {
      radius *= magicFraction;
    }

    var px = cx + radius * cos(t); 
    var py = cy + radius * sin(t); 
    vertex(px, py);
  }
  endShape(CLOSE);
}
