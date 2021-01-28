PImage myImage;
PFont myFont; 

float D = 130; 
float R = D/2; 
  
//----------------------------------------------
void setup() {
  size(800, 800);
  noLoop(); 
  
  myFont = loadFont("Helvetica-Bold-72.vlw"); 
  textFont(myFont, 72); 
  
  myImage = loadImage("light-lamp-bulb-wire_zoom.png"); 
  image(myImage, 0, 0); 

  int brightestX = -1;
  int brightestY = -1; 
  float brightestBrightness = 0; 
  color[] myImagePixels = myImage.pixels;
  for (int y=0; y<myImage.height; y++) {
    for (int x=0; x<myImage.width; x++) {
      int index = (y*myImage.width) + x; 
      color c = myImagePixels[index];
      float bri = brightness(c); 
      if (bri > brightestBrightness) {
        brightestBrightness = bri; 
        brightestX = x;
        brightestY = y; 
      }
    }
  }


  drawIndicator(brightestX, brightestY, color(0,0,0)); 
  
  
  String xStr = "X: " + brightestX;
  String yStr = "Y: " + brightestY;
  fill(0); 
  textAlign(RIGHT, CENTER); 
  text(yStr, brightestX-(2.666*R)-20, brightestY); 
  textAlign(CENTER, TOP); 
  text(xStr, brightestX, brightestY+(2.666*R)+20); 
}


//----------------------------------------------
void drawIndicator(float cx, float cy, color col){
  
  noFill(); 
  stroke(col); 
  strokeWeight(10); 
  ellipseMode(CENTER); 
  ellipse(cx, cy, D, D);
  
  strokeCap(SQUARE); 
  line(cx-(R*2.666), cy, cx-R, cy); 
  line(cx-(R+40), cy-20, cx-(R+5), cy); 
  line(cx-(R+40), cy+20, cx-(R+5), cy);
  line(cx, cy+(R*2.666), cx, cy+R); 
  line(cx-20, cy+(R+40),  cx, cy+(R+5)); 
  line(cx+20, cy+(R+40),  cx, cy+(R+5)); 
}



//----------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("brightest_point.png");
  }
}











//----------------------------------------------
void drawStar (float cx, float cy, float maxR){
  beginShape(); 
  for (int i=0; i<10; i++) {
    float t = (float)i / 10.0 * TWO_PI + HALF_PI + radians(-10); 
    float r = (((i%2) == 0) ? 0.382*maxR:maxR);
    float px = cx + r * cos(t); 
    float py = cy + r * sin(t); 
    vertex(px, py); 
  }
  endShape(CLOSE); 
}
