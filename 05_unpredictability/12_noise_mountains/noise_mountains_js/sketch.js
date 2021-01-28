//http://genekogan.com/code/p5js-perlin-noise/ edited from this
function setup() {
  createCanvas(300, 300);
}

function draw() {
  var highestPoint = 0;
  background(1,22,39);
  noFill();
  noStroke();

  //mountain (made by drawing sky on top of brown)
  beginShape();
  vertex(0,0)
  fill(240,248,255)

  for (var x = 0; x < width+1; x++) {
	var nx = map(x, 0, width, 0, 3);
	var y = height/2 * noise(nx);
	vertex(x, y+100);
  }
  vertex(300,0)
  endShape();

  noLoop()
}