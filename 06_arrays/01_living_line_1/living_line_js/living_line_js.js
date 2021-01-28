// Exercises: Arrays
// Living Line 1

var nPoints = 100;
var xPos = []; 
var yPos = []; 

function setup() {
  createCanvas(800, 800);
  stroke(0, 0, 0); 
  strokeWeight(8); 
}

function draw() {
  background(253);
  
  xPos[nPoints-1] = mouseX; // add new value to the end of the array
  yPos[nPoints-1] = mouseY; // add new value to the end of the array
  for (var i=0; i<(nPoints-1); i++) {
    line(xPos[i], yPos[i], xPos[i+1], yPos[i+1]); 
    xPos[i]=xPos[i+1]; // move each value along the array
    yPos[i]=yPos[i+1]; // move each value along the array
  }
}
