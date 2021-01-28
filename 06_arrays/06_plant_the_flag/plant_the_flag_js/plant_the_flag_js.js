// Exercises: Array
// Plant the Flag

// A bumpy "landscape" or terrain, 
// consisting of an array of height values, 
// has been provided to you. 
// Write code which searches through this array, 
// and draws "flags" on the peaks (i.e. local maxima).

var terrain = [];

function placeFlagsOnTerrain() {
  // PLACE YOUR CODE HERE TO DETECT HILLS
  
  for (var i=1; i<(width-1); i++) {
    var yA = terrain[i - 1]; 
    var yB = terrain[i + 0];
    var yC = terrain[i + 1];

    if ((yA > yB) && (yC > yB)) { 
      drawFlag(i, yB); // We found a peak... draw a flag!
    }
  }
}

function drawFlag(flagx, flagy) {
  // For example...
  stroke(0); 
  strokeWeight(2.0); 
  line(flagx, flagy, flagx, flagy - 160);
  rect(flagx, flagy-160, 66, 40);
}

//----------------------------------------------------------------------
// There should be no reason for you to modify any code below this line: 
function setup() {
  createCanvas(800, 800);
  terrain = [];
}

function draw() {
  background(253); 
  
  var skyColor = color(200,230,255); 
  for (var y=0; y<height; y++){
    var t = map(y, 0, height, 0, 1);
    t = pow(t, 0.25); 
    var alpha = map(t, 0,1, 255, 0); 
    stroke(200,230,255, alpha);
    line(0,y, width, y); 
  }
  
  calculateTerrain();
  renderTerrain(); 
  placeFlagsOnTerrain();
}

function calculateTerrain() {
  noiseDetail(2, 0.2); 
  noiseSeed(12345); 
  for (var i=0; i<width; i++) {
    var val = noise(i/100.0 + frameCount/50.0);
    var y = map(val, 0, 1, height*0.25, height*0.80); 
    terrain[i] = y;
  }
}

function renderTerrain() {
  stroke(0); 
  for (var i=0; i<width; i++) {
    var y = terrain[i]; 
    line (i, height, i, y);
  }
}
