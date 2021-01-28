var r = 0;
var v = 0;
var w = 90;

function setup() {
  createCanvas(800, 800);
  smooth();
  noLoop();
}

function draw() {
  background(253);
  smooth();
  noFill();

  stroke(0);
  strokeWeight(2);

  //draws a grid of squares that become progressivley randomly rotated
  for (var y=w; y<height-w; y=y+w) {
    for (var x=w; x<width-w; x=x+w) {
      push(); 
      r=random(-v, v);
      translate(x+w/2, y+w/2);
      rotate(r);
      rect(-w/2,-w/2, w, w); 
      pop();
    }
    v=v+0.05;
  }
}
