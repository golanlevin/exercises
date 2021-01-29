var mx = [];
var my = []; 

function setup() {
  createCanvas(400, 400); 
  //mx = [0]*100;
  //my = new float[100];
}

function mousePressed() {
  background(255);
  for (var i=0; i<100; i++) {
    mx[i] = mouseX;
    my[i] = mouseY;
  }
}

function draw() {
  noStroke(); 
  fill(200, 200, 200, 20); 

  rect(0, 0, width, height); 

  noFill(); 
  stroke(0); 
  beginShape();
  for (var i=0; i<100; i++) {
    vertex(mx[i], my[i]);
  }
  endShape(); 

  if (mousePressed) {
    for (var i=0; i<99; i++) {
      mx[i] = mx[i+1];
      my[i] = my[i+1];
    }
    mx[99] = mouseX; 
    my[99] = mouseY;
  } else {
    for (var i=1; i<99; i++) {
      mx[i] = (mx[i-1] + mx[i] + mx[i+1])/3.0;
      my[i] = (my[i-1] + my[i] + my[i+1])/3.0;
    }
  }
}