// Overlapping color
// Exercises: Overlapping

function setup() {
  createCanvas(800, 800);
  
  noLoop();
}

function draw() {
  background(253);
  
  blendMode(DIFFERENCE);
  noStroke();
  
  var alpha = 255;
  var a = width/3;
  var d = a*1.618; 
  var h = a * sqrt(3.0) / 2.0; 
  var m = (height - (a*2+h))/2;

  //colored circles
  fill(0, 255, 0, alpha);
  ellipse(a*1, m+a, d, d);

  fill(255, 0, 0, alpha);
  ellipse(a*2, m+a, d, d);

  fill(0, 0, 255, alpha);
  ellipse(width/2, m+a+h, d, d);
}
