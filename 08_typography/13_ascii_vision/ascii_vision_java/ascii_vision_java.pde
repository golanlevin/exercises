// ASCII Vision
// See Paul Bourke, "Character representation of grey scale images", 
// http://paulbourke.net/dataformats/asciiart/

PFont myFont;
PImage myImage;

String grays10 = "@%#*+=-:. ";
String grays58 = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft1?+-~i!lI;:,\"^`. ";

//----------------------------------------
void setup() {
  size(800, 800); 
  // noLoop();

  myFont = createFont("Courier-Bold", 32);
  myImage = loadImage("muriel_cooper.jpg");
}

//----------------------------------------
void draw() {
  background(253); 
  textAlign(LEFT, BASELINE); 
  textFont(myFont, 40);
  fill(0, 0, 0); 

  String grays = grays58;
  int nGrays = grays.length();

  int charW = 25; 
  int charH = 32; 
  int nCharX = width/charW; 
  int nCharY = height/charH; 

  for (int ty = 0; ty<nCharY; ty++) {
    for (int tx = 0; tx<nCharX; tx++) {

      int px = (int)((tx + 0.5)*charW); 
      int py = (int)((ty + 0.5)*charH);
      color pixelColor = myImage.get(px, py); 
      float pixelGray = brightness(pixelColor);

      int grayLevel = (int) map(pixelGray, 0, 255, 0, nGrays-1); 
      char grayChar = grays.charAt(grayLevel); 
      text(grayChar, tx*charW+1, ty*charH + 30);
    }
  }
}

//----------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("ascii_vision.png");
  }
}
