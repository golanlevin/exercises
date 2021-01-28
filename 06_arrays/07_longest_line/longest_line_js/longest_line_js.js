var xpos1 = [];
var ypos1 = [];
var xpos2 = [];
var ypos2 = [];

var longestLength = 0;
var indexOfLongest;

function setup() {
  longestLength = 0;
  createCanvas(800, 800);
}

function draw() {
  background(253);

  // Determine which line is longest.
  for (var i = 0; i < xpos1.length; i++) {
    if (dist(xpos1[i], ypos1[i], xpos2[i], ypos2[i]) > longestLength) {
      longestLength = dist(xpos1[i], ypos1[i], xpos2[i], ypos2[i]);
      indexOfLongest = i;
    }
  }

  // Draw all of the lines
  for (var i = 0; i < xpos1.length; i++) {
    if (i == indexOfLongest) { 
      // Longest line is thick and red
      stroke("red");
      strokeWeight(17);
    } else {
      // All other stored lines are thin and black
      stroke("black");
      strokeWeight(8);
    }
    line(xpos1[i], ypos1[i], xpos2[i], ypos2[i]);
  }

  // Draw a gray diagnostic mark for the active line
  if (mouseIsPressed) {
    stroke("lightgray");
    strokeWeight(1);
    line(mouseX, mouseY, xpos1[xpos1.length - 1], ypos1[xpos1.length - 1]);
  }
}

// Store data based on interaction
function mousePressed() {
  xpos1.push(mouseX);
  ypos1.push(mouseY);
}

function mouseReleased() {
  xpos2.push(mouseX);
  ypos2.push(mouseY);
}

function mouseDragged() {
  // prevent default
  return false;
}
