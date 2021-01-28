// Write a program that stores the locations of the 
// two most recent mouse clicks. Draw a line segment 
// from the older point to the newer one. Using the atan2() 
// function, calculate and display the angular orientation 
// of this line. Try displaying this angle in degrees 
// instead of radians. Try displaying this angle using 
// the nearest of the four cardinal compass directions 
// (N, S, E, W) and intercardinal directions (NE, SE, SW, NW).

PImage cursorImg;
PFont myFont; 

PVector points[]; 
int index = 0; 

void setup() {
  size(800, 800);
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  myFont = loadFont("CenturySchoolbook-64.vlw"); 
  textFont(myFont, 64); 

  points = new PVector[2]; 
  points[0] = new PVector();
  points[1] = new PVector();
}

//----------------------------------
void draw() {
  background(253); 
  
  stroke(0); 
  strokeWeight(8);
  line(points[0].x, points[0].y, points[1].x, points[1].y); 
  fill(0, 255, 0); 
  ellipse(points[0].x, points[0].y, 32,32); 
  fill(255, 50, 50); 
  ellipse(points[1].x, points[1].y, 32,32); 

  float dx = points[1].x - points[0].x;
  float dy = points[1].y - points[0].y;
  float angleR = atan2(dy, dx); 
  float oriD = (degrees(angleR)+360+180-90)%360;
  String degStr = "Orientation: " + nf(oriD, 1, 1) + "°"; 

  String compassDirs[] = {"N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"};
  int compassDirIndex = min(8, (int)round(oriD/45.0));
  String compass = "Compass Bearing: " + compassDirs[compassDirIndex]; 
  String displayStr = degStr + "\n" + compass;
  
  fill(0); 
  textAlign(CENTER);
  text (displayStr, width*0.5, height*0.80);
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}


//----------------------------------
void mousePressed() {
  points[0].set(points[1]); 
  points[1].set(mouseX, mouseY, 0);
}
void mouseDragged() {
  points[1].set(mouseX, mouseY, 0);
}


//----------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("compass_orientation.png");
  }
}
