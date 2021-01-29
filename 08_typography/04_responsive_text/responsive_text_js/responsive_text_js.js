// Responsive Text (mouse-sensitive): TICKLE

var myRegularFont;  
var myItalicFont; 
var cursorImg;
var theWord;
var tx, ty; // current text coordinates
var ux, uy; // target coordinates

//----------------------------------------
function setup() {
  createCanvas(800, 800); 

  myRegularFont = "Helvetica-Bold";
  myItalicFont = "Helvetica-BoldOblique";
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png");
  theWord = "avoid"; 

  ux = tx = width/2;
  uy = ty = height/2;
}

//----------------------------------------
function draw() {
  noStroke();
  fill(253, 50);
  rect(0, 0, width, height); 

 // Compute the txt's bounding box
  var rw = textWidth(theWord); 
  var rh = textAscent() + textDescent();
  var rx = tx - rw/2;
  var ry = ty - rh/2;

  // Check to see if the mouse is in the box,
  // and update the text's target position.
  var bMoving = false; 
  if ((mouseX > rx) && (mouseX < (rx+rw)) && 
    (mouseY > ry) && (mouseY < (ry+rh))) {
    var dx = (mouseX - tx); 
    var dy = (mouseY - ty);
    var avoidAmount = 1.2; 
    ux = tx - avoidAmount * dx;
    uy = ty - avoidAmount * dy;
    bMoving = true; 
  }
  
  // Draw the text
  if (bMoving){
    textFont(myItalicFont, 144); 
  } else {
    textFont(myRegularFont, 144); 
  }
  textAlign(CENTER, CENTER); 
  fill(0, 0, 0); 
  text(theWord, tx, ty); 

  
  // Interpolate the text position to target position, 
  // using Zeno's method (simple easing)
  var A = 0.96; 
  var B = 1.0-A;
  tx = A*tx + B*ux;
  ty = A*ty + B*uy;

  // Draw the cursor (for print output)
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

//----------------------------------------
function keyPressed() {
  if (keyCode == 32) {
    saveFrames('responsive_text', 'png', 1, 1);
  } else {
    background(253); 
    ux = tx = width/2;
    uy = ty = height/2;
  }
}
