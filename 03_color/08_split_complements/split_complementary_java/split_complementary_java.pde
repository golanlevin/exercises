
PImage colorWheelImg; 
PImage cursorImg; 

void setup() {
  size(800, 800); 
  colorWheelImg = loadImage("color_wheel.png"); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png");
}

void draw() {
  background(253);
  image(colorWheelImg, 0, 0); 

  colorMode(HSB, 100);
  float radius = 320;
  float mx = mouseX - width/2; 
  float my = mouseY - height/2; 
  float mr = sqrt(mx*mx + my*my); 
  float ma = (TWO_PI + atan2(my, mx))%TWO_PI; 
  float mh = map(ma, 0, TWO_PI, 0, 100);
  float ms = map(mr, 0, radius, 0, 100);
  
  float ma1 = (ma + radians(180-30))%TWO_PI; 
  float ma2 = (ma + radians(180+30))%TWO_PI; 
  
  drawColorEllipse( radius, ma, mr);
  drawColorEllipse( radius, ma1, mr);
  drawColorEllipse( radius, ma2, mr);

  /*
  noStroke();
  fill(0, 0, 0, 10); 
  
  ellipse(mouseX+8, mouseY+8, er+4, er+4); 
  stroke(0); 
  strokeWeight(8); 
  ellipseMode(CENTER);
  fill(mh, ms, 100);
  ellipse(mouseX, mouseY, er, er); 
  */
  
  


  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}


//---------------------------------------------------
void drawColorEllipse(float radius, float ma, float mr){
  
  float mh = map(ma, 0, TWO_PI, 0, 100);
  float ms = map(mr, 0, radius, 0, 100);
  float mx = width/2  + mr * cos(ma); 
  float my = height/2 + mr * sin(ma); 
  
  noStroke();
  fill(0, 0, 0, 10); 
  float er = radius*0.4;
  ellipse(mx+8, my+8, er+4, er+4); 
  
  stroke(0); 
  strokeWeight(8); 
  ellipseMode(CENTER);
  fill(mh, ms, 100);
  ellipse(mx, my, er, er); 
}




void keyPressed() {
  if (key == ' ') {
    saveFrame("split_complementary.png");
  }
}
