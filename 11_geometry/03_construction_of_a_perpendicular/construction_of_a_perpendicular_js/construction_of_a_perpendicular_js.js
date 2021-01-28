var A; 
var B; 
var cursorImg;

function setup() {
  createCanvas(800, 800);
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png"); //cursor1.png");
}

function draw() {
  background(253); 

  // Write a program that draws a line from the 
  // center of the canvas to the cursor. Construct
  // a second line which starts at the cursor, 
  // which is 50 pixels long, and which is 
  // perpendicular to the first line. 

  var cx = width/2.0; 
  var cy = height/2.0; 
  var mx = mouseX-5;
  var my = mouseY;

  fill(0);
  stroke(0); 
  strokeCap(PROJECT);
  strokeWeight(8);
  line (cx, cy, mx, my); 

  var dx = mx - cx;
  var dy = my - cy;
  var dh = sqrt(dx*dx + dy*dy); 

  var len = 100.0; 
  var px = mx + len * dy/dh;
  var py = my - len * dx/dh;
  line (mx, my, px, py); 

  noStroke();
  ellipse(cx, cy, 24, 24); 
  ellipse(px, py, 24, 24); 

  image(cursorImg, mouseX, mouseY, 15*6, 21*6); 
}
