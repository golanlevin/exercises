//Exercises: Arrays
//Living Line 1

var xPos = [];
var yPos = [];

var p=0;
var bDoSave = false;

function setup() {
  createCanvas(800, 800);
  p = 50;
  for (var i=0; i<100; i++) { 
    xPos.push(0);
    yPos.push(0);
  }
}

function draw() {
  background(253);

  noFill(); 
  stroke(0); 
  strokeWeight(8); 
  strokeJoin(ROUND); 
  beginShape(); 
  for (var i=0; i<100; i++) { 
    vertex(xPos[i], yPos[i]);
  }
  endShape(); 

  // add noise to the gesture.
  // add more noise to older points, for fun.
  for (var j=0; j<99; j++) { 
    xPos[j] += 0.2*(99-j)*random(-1, 1);
    yPos[j] += 0.2*(99-j)*random(-1, 1);
  }

}

function mouseMoved() {
  for (var i=0; i<99; i++) { //only change arrays if mouse moved
    line(xPos[i], yPos[i], xPos[i+1], yPos[i+1]); 
    xPos[i]=xPos[i+1]; //move each value along the array
    yPos[i]=yPos[i+1]; //move each value along the array
  }
  xPos[99]=mouseX; //add new value to the end of the array
  yPos[99]=mouseY; //add new value to the end of the array
  bMoved = false;

  
  // smooth the gesture.
  for (var j=1; j<99; j++) { 
    var ix = xPos[j-1];
    var jx = xPos[j  ];
    var kx = xPos[j+1];

    var iy = yPos[j-1];
    var jy = yPos[j  ];
    var ky = yPos[j+1];

    xPos[j] = (ix + 14*jx + kx)/16.0;
    yPos[j] = (iy + 14*jy + ky)/16.0;
  }
}
