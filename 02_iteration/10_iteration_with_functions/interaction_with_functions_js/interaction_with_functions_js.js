// Iteration with Functions. 
// A function which drawa a smily face, 
// is invoked inside a nested iteration.

function setup() {
  createCanvas(800, 800);
}

function draw() {
  background(253);
  smooth(); 
  
  var offset = 50;
  var n = 5;
  var side = (width-2*offset)/n;
 
  //draws 5 rows of 5 faces
  for (var i=0; i<n; i++) {
    for (var j=0; j<n; j++) {
      var y = (i+1)*side + offset - side/2; 
      var x = (j+1)*side + offset - side/2; 
      drawFace(x, y, side*4/5);
    }
  }
}


function drawFace(x, y, side) {
  //constructs a face through arcs and circles
  ellipseMode(CENTER); 
  stroke(0, 0, 0);
  strokeWeight(8); 
  push();
  translate(x, y); 
  
  ellipse(0, 0, side, side);  
  ellipse (-side*0.15, -side*0.10, side*0.18, side*0.24);
  line(     side*0.16, -side*0.10+side*0.10, 
            side*0.16, -side*0.10-side*0.10);
  
  arc(0, 0, side/2, side/2, PI*0.25, PI*0.75); 
  pop();
}
