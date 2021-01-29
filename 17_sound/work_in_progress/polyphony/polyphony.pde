

Tone tones[]; 
int nTones; 
float MIN_SEP = 100; 
float MAX_STRAY = 200; 
float SEP_FORCE = 4.0;
float COH_FORCE = 0.04; 
float MOUSE_FORCE = 0.5; 
float MAX_VEL = 40; 
float DAMPING = 0.99;

PImage cursorImg; 

//--------------------------------------
void setup() {
  size(800, 800); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  nTones = 15; 
  tones = new Tone[nTones]; 
  for (int i=0; i<nTones; i++) {
    float rx = random(width*0.3, width*0.7); 
    float ry = random(height*0.3, height*0.7); 
    tones[i] = new Tone(rx, ry);
  }
}

void draw() {
  background(253); 

  update(); 
  for (int i=0; i<nTones; i++) {
    tones[i].render();
  }
  
  image(cursorImg, mouseX, mouseY, 15*6, 21*6); 
}




//--------------------------------------
void update() {

  // Clear forces
  for (int i=0; i<nTones; i++) {
    tones[i].F.set(0, 0);
  }

  // Attraction to cursor
  for (int i=0; i<nTones; i++) {
    Tone iTone = tones[i];
    float ix = iTone.P.x;
    float iy = iTone.P.y;
    float dx = (mouseX + random(-10,10)) - ix; 
    float dy = (mouseY + random(-10,10)) - iy;
    float dh = sqrt (dx*dx + dy*dy); 
    if (dh > MIN_SEP) {
      float fx = dx/dh * MOUSE_FORCE;
      float fy = dy/dh * MOUSE_FORCE;
      iTone.addForce(fx, fy); 
    }
  }



  // Separation
  for (int i=0; i<nTones; i++) {
    Tone iTone = tones[i];
    float ix = iTone.P.x;
    float iy = iTone.P.y;
    for (int j=0; j<i; j++) {
      Tone jTone = tones[j];
      float jx = jTone.P.x;
      float jy = jTone.P.y;
      float dx = ix - jx; 
      float dy = iy - jy; 
      float dh = sqrt(dx * dx + dy * dy); 
      if ((dh < MIN_SEP) && (dh > 0.0001)) {
        float fx = dx/dh * SEP_FORCE * (1.0/dh); 
        float fy = dy/dh * SEP_FORCE * (1.0/dh); 
        iTone.addForce(fx, fy); 
        jTone.addForce(-fx, -fy);
      }
    }
  }


  // Alignment 


  // Cohesion
  float cx = 0; 
  float cy = 0;
  for (int i=0; i<nTones; i++) {
    Tone iTone = tones[i];
    cx += iTone.P.x; 
    cy += iTone.P.y;
  }
  cx /= (float) nTones; 
  cy /= (float) nTones; 
  for (int i=0; i<nTones; i++) {
    Tone iTone = tones[i];
    float ix = iTone.P.x;
    float iy = iTone.P.y;
    float dx = cx - ix; 
    float dy = cy - iy;
    float dh = sqrt (dx*dx + dy*dy); 
    if (dh > MAX_STRAY) {
      float pull = dh - MAX_STRAY;
      float fx = dx/dh * COH_FORCE * pull;
      float fy = dy/dh * COH_FORCE * pull;
      
      iTone.addForce(fx, fy); 
    }
  }


  // Update
  for (int i=0; i<nTones; i++) {
    tones[i].update();
  }
}

void keyPressed(){
  if (key == ' '){
    saveFrame("polyphony_####.png"); 
  }
}



class Tone {
  PVector P; 
  PVector V;
  PVector F; 

  Tone (float px, float py) {
    P = new PVector(px, py); 
    V = new PVector(0, 0);
    F = new PVector(0, 0);
  }

  void render() {
    float ang = atan2(V.y, V.x) + HALF_PI; 
    fill(0); 
    noStroke(); 
    pushMatrix();
    translate(P.x, P.y); 
    rotate(ang); 
    triangle(20, 20, -20, 20, 0, -60); 
    popMatrix();
  }

  void addForce(float fx, float fy) {
    F.x += fx; 
    F.y += fy;
  }

  void update() {

    // Add Force (acceleration) to Vel
    V.x += F.x;
    V.y += F.y;
    float Vh = sqrt(V.x * V.x + V.y * V.y); 
    if (Vh > MAX_VEL) {
      float frac = MAX_VEL / Vh;
      V.x *= frac; 
      V.y *= frac;
    }

    V.x *= DAMPING * random(0.97, 0.99); 
    V.y *= DAMPING * random(0.97, 0.99); 

    P.x += V.x; 
    P.y += V.y;
  }
}
