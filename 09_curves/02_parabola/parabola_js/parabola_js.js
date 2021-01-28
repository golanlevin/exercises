function setup() {
  createCanvas(800, 800);
}

function draw() {
  background(253);
  strokeWeight(8);
  stroke(0);
  
  push();
  translate(width/2, 0);
  for (var x = -500; x < 500; x++) {
    var y = 700.0-pow(x, 2)/140;
    point(x, y);
  }
  pop();
}
