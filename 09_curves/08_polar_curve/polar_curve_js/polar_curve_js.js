var nPoints = 360;
var EPITROCHOID = 0; // Cartesian Parametric Form  [x=f(t), y=g(t)]
var CRANIOID = 1; // Polar explicit form   [r =f(t)]
var titles = ["Epitrochoid", "Cranioid"];
var curveMode = 0;
var cursorImg; 

//--------------------------------------------------
function setup() {
  createCanvas(800, 800);
  smooth();
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png"); 
  textFont("Helvetica-Bold", 72);
}

//--------------------------------------------------
function draw() {
  background(253);

  // draw the frame
  fill(0); 
  noStroke();
  text(titles[curveMode], 50, 100);

  // draw the curve
  push();
  translate(width / 2, height / 2 + 50);
  switch (curveMode) {
    case 0:
      drawEpitrochoidCurve();
      break;
    case 1:
      drawCranioidCurve();
      break;
  }
  pop();

  image(cursorImg, mouseX, mouseY, 15*6,21*6); 
}

//--------------------------------------------------
function drawEpitrochoidCurve() {
  // Epicycloid:
  // http://mathworld.wolfram.com/Epicycloid.html

  var x;
  var y;
  var mx = mouseX; // 510; 
  var my = mouseY; // 546; 
  
  var a = 150;
  var b = a / 2.0;
  var h = constrain(my / 8.0, 0, b);
  var ph = mx / 50.0;

  fill(255, 200, 200);
  stroke(0);
  strokeWeight(8);
  strokeJoin(ROUND); 
  beginShape();
  for (var i = 0; i < nPoints; i++) {
    var t = map(i, 0, nPoints, 0, TWO_PI);

    x = (a + b) * cos(t) - h * cos(ph + t * (a + b) / b);
    y = (a + b) * sin(t) - h * sin(ph + t * (a + b) / b);
    vertex(x, y);
  }
  endShape(CLOSE);

}

//--------------------------------------------------
function drawCranioidCurve() {
  // http://mathworld.wolfram.com/Cranioid.html

  // NOTE: given a curve in the polar form  r = f(theta),
  // 1. sweep theta from 0...TWO_PI,
  // 2. then compute r as a function of theta,
  // 3. then compute x and y using the circular identity:
  //    x = r * cos(theta);
  //    y = r * sin(theta);

  var x;
  var y;
  var r;
  var a = 30.0;
  var b = 8.0;
  var c = 75.0;

  var p = constrain((1.0 * mouseX / width), 0.0, 1.0);
  var q = constrain((1.0 * mouseY / height), 0.0, 1.0);

  fill(200, 200, 255);
  stroke(0);
  strokeWeight(8);
  strokeJoin(ROUND); 
  
  beginShape();
  for (var i = 0; i < nPoints; i++) {
    var t = map(i, 0, nPoints, 0, TWO_PI);

    // cranioid:
    r =
      a * sin(t) +
      b * sqrt(1.0 - p * sq(cos(t))) +
      c * sqrt(1.0 - q * sq(cos(t)));

    x = r * cos(t);
    y = r * sin(t);
    vertex(x, y);
  }
  endShape(CLOSE);
}

//--------------------------------------------------
function mousePressed() {
  curveMode = 1 - curveMode;
}
