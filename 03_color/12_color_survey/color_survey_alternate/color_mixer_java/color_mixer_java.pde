PFont myFont; 
PImage cursorImg; 
color mauves[] = {
  color(150, 117, 157), 
  color(186, 122, 123), 
  color(172, 114, 148), 
  color(134, 100, 117), 
  color(132, 89, 91), 
  color(167, 139, 146)
};

class Slider {
  float val; 
  float rx, ry, rw, rh; 
  color col; 

  Slider(float x, float y, float w, float h, color c) {
    rx = x; 
    ry = y; 
    rw = w; 
    rh = h;
    val = 0.5; 
    col = c;
  }
  void draw() {
    noStroke();
    fill(0); 
    rect(rx, ry, rw, rh);
    fill(col); 
    float vy = map(val, 0, 1, ry+rh, ry); 
    float vh = map(val, 0, 1, 0, 0-rh); 
    rect(rx, ry+rh, rw, vh);
    stroke(lerpColor(col, color(255), 0.5)); 
    strokeWeight(8); 
    line(rx, vy, rx+rw, vy);
  }
  void handleMouse() {
    if (mousePressed && 
      (mouseX > rx) && (mouseX < (rx+rw)) && 
      (mouseY > ry) && (mouseY < (ry+rh))) {
      val = constrain( map(mouseY, ry+rh, ry, 0, 1), 0, 1);
    }
  }
}

Slider sliders[]; 


//------------------------------------
void setup() {
  size(800, 800);
  cursorImg = loadImage("cursor_with_shadow_15x21.png");
  myFont = loadFont("CenturySchoolbook-60.vlw");
  textFont(myFont, 80);

  sliders = new Slider[3]; 
  color sliderColors[] = {0xFFFF0000, 0xFF00FF00, 0xFF2222FF};
  for (int i=0; i<3; i++) {
    sliders[i] = new Slider(40 + i*100, 420, 60, 340, sliderColors[i]);
  }
}



//------------------------------------
void draw() {

  background(253); 

  for (int i=0; i<3; i++) {
    sliders[i].handleMouse();
    sliders[i].draw();
  }

  float r = 255 * sliders[0].val;
  float g = 255 * sliders[1].val;
  float b = 255 * sliders[2].val;
  color newCol = color(r, g, b); 
  fill(newCol); 
  noStroke(); 
  ellipseMode(CENTER); 
  ellipse(40+130, 120+130, 264, 264); 

  fill(0); 
  textAlign(CENTER, BASELINE); 
  text("mauve", 40+260/2, 80); 

  noStroke(); 
  pushMatrix();
  float CH = height*0.9;
  float CW = width*0.45;
  float rw = CW / 2.0;
  float rh = CH / 3.0; 
  translate(width*0.5, height*0.05); 
  int index = 0; 
  for (int y=0; y<3; y++) {
    for (int x=0; x<2; x++) {
      color m = mauves[index];  
      fill (lerpColor(m, color(255), 0.20)); 
      rect(x*rw, y*rh, rw, rh); 
      index++;
    }
  }
  popMatrix();

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}



//------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("color_mixer.png");
  }
}
