myImage = None;
myFont = None; 

D = 130; 
R = D/2; 
  
#----------------------------------------------
def setup():
  global myImage,myFont
  size(800, 800);
  noLoop(); 
  
  myFont = loadFont("Helvetica-Bold-72.vlw"); 
  textFont(myFont, 72); 
  
  myImage = loadImage("light-lamp-bulb-wire_zoom.png"); 
  image(myImage, 0, 0); 

  brightestX = -1;
  brightestY = -1; 
  brightestBrightness = 0; 
  myImagePixels = myImage.pixels;
  for y in range(myImage.height):
    for x in range(myImage.width):
      index = (y*myImage.width) + x; 
      c = myImagePixels[index];
      bri = brightness(c); 
      if (bri > brightestBrightness):
        brightestBrightness = bri; 
        brightestX = x;
        brightestY = y; 


  drawIndicator(brightestX, brightestY, color(0,0,0)); 
  
  
  xStr = "X: " + str(brightestX);
  yStr = "Y: " + str(brightestY);
  fill(0); 
  textAlign(RIGHT, CENTER); 
  text(yStr, brightestX-(2.666*R)-20, brightestY); 
  textAlign(CENTER, TOP); 
  text(xStr, brightestX, brightestY+(2.666*R)+20); 



#----------------------------------------------
def drawIndicator(cx,cy,col):
  
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




#----------------------------------------------
def keyPressed():
  if (key == ' '):
    saveFrame("brightest_point.png");
  











#----------------------------------------------
def drawStar (cx,cy,maxR):
  beginShape(); 
  for i in range(10):
    t = float(i) / 10.0 * TWO_PI + HALF_PI + radians(-10); 
    r = 0.382*maxR if (i%2)==0 else maxR;
    px = cx + r * cos(t); 
    py = cy + r * sin(t); 
    vertex(px, py); 
  
  endShape(CLOSE); 
