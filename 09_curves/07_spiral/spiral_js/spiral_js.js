var diameter = 600;
var skip = 50;

function setup() {
  createCanvas(800, 800);
  background(253);
  noFill();
  stroke(0);
  strokeWeight(8);
}

function draw() {
  if (diameter < 0) {
    noLoop();
  }
  arc(width/2, height/2, diameter, diameter, -1*HALF_PI, HALF_PI);
  diameter = diameter -skip;
  translate(0,-skip/2);
  arc(width/2, height/2, diameter, diameter, HALF_PI,2*PI-HALF_PI );
  diameter = diameter -skip;
}
