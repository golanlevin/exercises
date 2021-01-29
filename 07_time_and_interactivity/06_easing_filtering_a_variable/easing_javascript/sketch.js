var mx = 0;
var my = 0;

function setup() {
  createCanvas(400,400);
  noStroke();
}

function draw() {
  background(200); 
  fill(255);
  ellipse(mx, my, 30, 30);
  mx = 0.95*mx + 0.05*mouseX; 
  my = 0.95*my + 0.05*mouseY; 
}