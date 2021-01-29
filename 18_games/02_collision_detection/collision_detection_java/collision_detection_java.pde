float off_1;
float off_2;
float off_3;
float off_4;

float x_1;
float y_1;
float x_2;
float y_2;

float diam = 300;

void setup() {
  size(800, 800);
  ellipseMode(CENTER); 

  off_1 = random(10);
  off_2 = random(10);
  off_3 = random(10);
  off_4 = random(10);
}

//---------------------------------------
void draw() {
  background(253);

  float speed = 0.5; 
  off_1 += speed*0.01;
  off_2 += speed*0.015;
  off_3 += speed*0.005;
  off_4 += speed*0.020;

  x_1 = map(noise(off_1), 0, 1, 0, width);
  y_1 = map(noise(off_2), 0, 1, 0, height);
  x_2 = map(noise(off_3), 0, 1, 0, width);
  y_2 = map(noise(off_4), 0, 1, 0, height);

  // x_1 = mouseX; //334;
  // y_1 = mouseY; // 350;
  // x_2 = 475;
  // y_2 = 475;

  if (overlap(x_1, y_1, x_2, y_2)) {
    noStroke(); 

    blendMode(EXCLUSION);
    fill(0, 255, 255);
    ellipse(x_1, y_1, diam, diam);
    ellipse(x_2, y_2, diam, diam);

    blendMode(BLEND);
    fill(255, 255, 255, 200); 
    rect(0, 0, width, height);
  } 

  blendMode(BLEND);
  noFill(); 
  stroke(0, 0, 0);
  strokeWeight(8); 
  ellipse(x_1, y_1, diam, diam);
  ellipse(x_2, y_2, diam, diam);

  identifyIntersections();
}

//---------------------------------------
boolean overlap (float x1, float y1, float x2, float y2) {
  if (sqrt(pow(x2-x1, 2) + pow(y2-y1, 2)) < diam) {
    return true;
  } else {
    return false;
  }
}

//---------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("collision_detection.png");
  }
}



void identifyIntersections() {
  // From http://paulbourke.net/geometry/circlesphere/.
  // Assumes radii are equal. 

  float dx = x_1 - x_2; 
  float dy = y_1 - y_2; 
  float dh = sqrt(dx*dx + dy*dy); 
  if (dh < diam) {
    
    float cx = (x_1 + x_2)/2; 
    float cy = (y_1 + y_2)/2; 

    float r = diam/2;
    float a = (dh*dh)/(2*dh); 
    float h = sqrt(r*r - a*a);
    float x3 = cx + h * (dy/dh);
    float y3 = cy - h * (dx/dh);
    float x4 = cx - h * (dy/dh);
    float y4 = cy + h * (dx/dh);

    boolean bDrawIntersectionPoints = false; 
    if (bDrawIntersectionPoints) {
      fill(0); 
      noStroke();
      ellipse(x3, y3, 24, 24); 
      ellipse(x4, y4, 24, 24);
    }

    float Kx = (dy/dh) * max(0, (75-h));
    float Ky = (dx/dh) * max(0, (75-h));

    stroke(0);
    strokeWeight(8); 

    pushMatrix(); 
    translate(x3 + Kx, y3 - Ky); 
    rotate(PI + atan2(dy, dx)); 
    line(0, 60, 0, 100); 
    rotate( radians(20)); 
    line(0, 60, 0, 100);
    rotate( radians(-40)); 
    line(0, 60, 0, 100);
    popMatrix();

    pushMatrix(); 
    translate(x4 - Kx, y4 + Ky); 
    rotate(atan2(dy, dx)); 
    line(0, 60, 0, 100); 
    rotate( radians(20)); 
    line(0, 60, 0, 100);
    rotate( radians(-40)); 
    line(0, 60, 0, 100);
    popMatrix();
  }
}
