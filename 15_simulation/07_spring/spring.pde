float restLength = 400; 
float displacement = 0; 
float velocity = 0; 
float damping = 0.96;
float K = 0.1;
float y0;

PImage cursorImg;

void setup() {
  size(800, 800); 
  displacement = 0;
  velocity = 0;
  y0 = height * 0.75;
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
}

void draw() {
  background(253); 
  

  if (!mousePressed) {
    float force = (0-K)*displacement; // Hooke's law
    velocity += force;
    velocity *= damping; 
    displacement += velocity;
  } else {
    displacement = y0 - restLength - mouseY;
  }

  noStroke();
  fill(236);
  rect(0,y0, width, height-y0);
  stroke(0); 
  strokeWeight(8); 
  strokeJoin(ROUND); 
  line(0, y0, width, y0); 

  float springLength = restLength + displacement; 
  drawSpring( y0, springLength);
  ellipseMode(CENTER); 
  
  strokeWeight(8);
  fill(255, 200, 200); 
  float ex = width/2; 
  float ey = y0 - springLength;
  ellipse(width/2, y0-springLength, 80, 80);
  
  
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

void mousePressed() {
  displacement = y0 - restLength - mouseY;
}

void keyPressed(){
  if (key == ' '){
    saveFrame("spring.png"); 
  }
}



void drawSpring(float y0, float springLength) {
  float crx = 150; 
  float cry = 30;
  springLength -= cry*2;

  float nLoops = 5.5;
  int nSegsPerLoop = 40; 
  int nPoints = (int)round(nSegsPerLoop*nLoops);
  float dy = springLength / nPoints;
  float cx = width/2;

  noFill(); 
  beginShape(); 
  for (int i=0; i<=nPoints; i++) {
    float t = (float)i / (float) nSegsPerLoop * TWO_PI - HALF_PI;
    float sx = cx + crx * cos(t);
    float sy = y0 - cry * sin(t) - (i*dy) - cry; 
    vertex(sx, sy);
  }
  endShape();
}
