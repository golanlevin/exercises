var cursorImg;
var myFont;

var A; 
var B; 
var index = 0; 

//---------------------------------------------
function setup() {
  createCanvas(800, 800);
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png"); 
  myFont = textFont("Helvetica-Bold", 72); 

  // Initialize our points
  A = createVector(225, 150);
  B = createVector(175, 500);
}

//---------------------------------------------
function draw() {
  background(253); 
  fill(0);
  stroke(0); 
  strokeWeight(8); 
  
  // Draw the lines
  line(A.x, A.y, mouseX, mouseY); 
  line(B.x, B.y, mouseX, mouseY);
  fill(0, 255, 0);
  ellipse(A.x, A.y, 32, 32); 
  fill(255, 50, 50);
  ellipse(B.x, B.y, 32, 32); 

  // Compute the angle
  var dxam = A.x-mouseX;
  var dyam = A.y-mouseY;
  var dham = sqrt(dxam*dxam + dyam*dyam);

  var dxbm = B.x-mouseX;
  var dybm = B.y-mouseY;
  var dhbm = sqrt(dxbm*dxbm + dybm*dybm);

  var dot   = dxam*dxbm + dyam*dybm;
  var cross = dxam*dybm - dyam*dxbm;
  var theta = acos(dot/(dham*dhbm));
  if (cross < 0) {
    theta = 0-theta;
  }

  // Place text labels at the end vertices
  fill(0,0,0);
  noStroke();
  textAlign(CENTER, CENTER); 
  var offset = 75;
  text("A", A.x+offset*dxam/dham, A.y+offset*dyam/dham);
  text("B", B.x+offset*dxbm/dhbm, B.y+offset*dybm/dhbm);

  var degStr = "Angle: " + nf(degrees(abs(theta)), 1, 1) + "°"; 
  textFont(myFont, 60); 
  text(degStr, width*0.5, height*0.80); 

  // Draw the cursor image
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

//---------------------------------------------
function mousePressed() {
  // Generate two new random locations for points A and B. 
  A.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8)); 
  B.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8));
}
