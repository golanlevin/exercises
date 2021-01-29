// Exercises: Interactivity
// Eyes Following Cursor

function setup() {
  createCanvas(800, 800);
  noStroke();
  smooth();
  //noLoop();
}

function draw() {
  background(216); 
  push();
  scale(8.0);
  fill(255);
  ellipse(50, 50, 60, 60); // White circle
  var ex = map(mouseX, 0, width, 30, 50);
  var ey = map(mouseY, height, 0, 60, 40);

  pupil(ex, ey);
  pop(); 
}

function pupil(x, y) {
  fill(0);
  ellipse(x+10, y, 30, 30); // Black circle
  fill(255);
  ellipse(x+16, y-5, 6, 6); // Small, white circle
}
