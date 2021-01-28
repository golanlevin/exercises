var nRectangles = 17;
var colorA;
var colorB;

function setup() {
  createCanvas(800, 800);
  rectMode(CENTER);
  noStroke();
  fill(23);

  colorA = color(255, 255, 0);
  colorB = color(255, 0, 255);
  
}

function draw() {
  background(253);
  for (var i = 0; i<nRectangles; i++){
    //finds the different color values for each rectangle in order to create an even gradient
    var fraction = i/(nRectangles-1);
    var aBarColor = lerpColor(colorA, colorB, fraction);
    var barX = map(i, 0, nRectangles-1, 25, width-25);
    //changes fill to the proper color and draws rectangle
    fill(aBarColor);
    rect(barX, height/2, 40, 720);
    
  }
}

function mousePressed() {
  //changes colors when mouse is pressed
  colorA = color(random(0, 255), random(0, 255), random(0, 255));
  colorB = color(random(0, 255), random(0, 255), random(0, 255));
}
