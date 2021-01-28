// Write a program that computes the angle between 
// three points: two randomly placed points, A and B, 
// and the mouse cursor, C. Hint: Use the dot product 
// to compute the angles, and use the cross product 
// to distinguish positive from negative curvature.

PImage cursorImg;
PFont myFont; 

PVector A; 
PVector B; 
int index = 0; 

//---------------------------------------------
void setup() {
  size(800, 800);
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  myFont = loadFont("CenturySchoolbook-72.vlw");
  textFont(myFont, 72); 
  
  // Initialize our points
  A = new PVector(225, 150);
  B = new PVector(175, 500);
}

//---------------------------------------------
void draw() {
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
  float dxam = A.x-mouseX;
  float dyam = A.y-mouseY;
  float dham = sqrt(dxam*dxam + dyam*dyam);

  float dxbm = B.x-mouseX;
  float dybm = B.y-mouseY;
  float dhbm = sqrt(dxbm*dxbm + dybm*dybm);

  float dot   = dxam*dxbm + dyam*dybm;
  float cross = dxam*dybm - dyam*dxbm;
  float theta = acos(dot/(dham*dhbm));
  if (cross < 0) {
    theta = 0-theta;
  }

  // Place text labels at the end vertices
  fill(0,0,0);
  textAlign(CENTER, CENTER); 
  float offset = 75;
  text("A", A.x+offset*dxam/dham, A.y+offset*dyam/dham);
  text("B", B.x+offset*dxbm/dhbm, B.y+offset*dybm/dhbm);

  String degStr = "Angle: " + nf(degrees(abs(theta)), 1, 1) + "°"; 
  textFont(myFont, 60); 
  text(degStr, width*0.5, height*0.80); 

  // Draw the cursor image
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

//---------------------------------------------
void mousePressed() {
  // Generate two new random locations for points A and B. 
  A.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8)); 
  B.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8));
}

//---------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("angle_between_3_points.png");
  }
}
