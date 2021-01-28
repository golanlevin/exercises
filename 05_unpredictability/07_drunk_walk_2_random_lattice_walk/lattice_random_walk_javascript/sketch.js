// Lattice Drunk Walk
// Create a sketch in which a small element travels 
// erratically from one moment to the next, 
// leaving a trail as it moves. It should have a 1-in-4 
// chance of moving up, down, left or right.

var prevx;
var prevy;

function setup() {
	createCanvas(400,400);
	clearCanvas(); 
}


function clearCanvas(){
	background(255,255,255);
	prevx = width/2;
	prevy = height/2; 
}


function movePoint(){
	var stepSize = 8; // pixels
	var nextx = prevx; 
	var nexty = prevy; 

	var directionChoice = int(random(0,4));
	if (directionChoice == 0){
		nextx += stepSize;
	}
	else if (directionChoice == 1){
		nextx -= stepSize;
	}
	else if (directionChoice == 2){
		nexty -= stepSize;
	}
	else if (directionChoice == 3){
		nexty += stepSize;
	}

	stroke(0,0,0); 
	strokeWeight(2);
	line (prevx,prevy, nextx,nexty);

	prevx = nextx;
	prevy = nexty; 
}


function draw() {
	movePoint();
}

function mousePressed(){
	clearCanvas(); 
}

function keyPressed(){
	saveCanvas("lattice_random_walk.png","png");
}