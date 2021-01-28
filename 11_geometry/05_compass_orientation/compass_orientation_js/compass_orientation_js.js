var cursorImg;
var myFont; 

var points; 
var index = 0; 

function setup() {
  createCanvas(800, 800);
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png"); 
  myFont = textFont("Helvetica-bold", 64); 
  textFont(myFont, 64); 

  points = [null, null]; 
  points[0] = createVector();
  points[1] = createVector();
}

//----------------------------------
function draw() {
  background(253); 
  
  stroke(0); 
  strokeWeight(8);
  line(points[0].x, points[0].y, points[1].x, points[1].y); 
  fill(0, 255, 0); 
  ellipse(points[0].x, points[0].y, 32,32); 
  fill(255, 50, 50); 
  ellipse(points[1].x, points[1].y, 32,32); 

  var dx = points[1].x - points[0].x;
  var dy = points[1].y - points[0].y;
  var angleR = atan2(dy, dx); 
  var oriD = (degrees(angleR)+360+180-90)%360;
  var degStr = "Orientation: " + nf(oriD, 1, 1) + "°"; 

  var compassDirs = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"];
  var compassDirIndex = min(8, round(oriD/45.0));
  var compass = "Compass Bearing: " + compassDirs[compassDirIndex]; 
  var displayStr = degStr + "\n" + compass;
  
  noStroke();
  fill(0); 
  textAlign(CENTER);
  text (displayStr, width*0.5, height*0.80);
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}


//----------------------------------
function mousePressed() {
  points[0].set(points[1]); 
  points[1].set(mouseX, mouseY, 0);
}

function mouseDragged() {
  points[1].set(mouseX, mouseY, 0);
}
