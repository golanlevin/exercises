Particle parray[];
int nx = 20; 
int ny = 20; 

PImage curs; 
float tx, ty; 
float sca = 100.0; 
int nParticles = 3; 

void setup() {
  size(800, 800); 
  background(253);
  noiseSeed(3);
  randomSeed(1); 
  tx = random(100); 
  ty = random(100);


  parray = new Particle[nParticles];
  
  reset();
 
}

void draw() {

  background(253); 

  stroke(0);
  strokeWeight(3);
  for (int i=0; i<ny; i++) {
    for (int j=0; j<nx; j++) {
      float y = map(i, -1, ny, 0, height); 
      float x = map(j, -1, nx, 0, width); 
      float nx = 100 + x/sca;
      float ny = 100 + y/sca;

      float dx = 52 * (noise(   nx, ny)-0.5); 
      float dy = 52 * (noise(tx+nx, ty+ny)-0.5); 
      line (x, y, x+dx, y+dy);
    }
  }


  for (int i=0; i<nParticles; i++) {
    parray[i].draw();
  }
  for (int i=0; i<nParticles; i++) {
    float nx = 100 + parray[i].px/sca;
    float ny = 100 + parray[i].py/sca;
    float fx = 52 * (noise(nx, ny)-0.5); 
    float fy = 52 * (noise(tx+nx, ty+ny)-0.5); 
    parray[i].updateForce(fx, fy);
  }
}

void reset() {
  parray[0] = new Particle(150, 300);
  parray[1] = new Particle(500, 500);
  parray[2] = new Particle(random(100, 700), random(100, 700));
}

void mousePressed() {
  background(253);
}

void keyPressed() {
  if (key == ' '){
    saveFrame("flow_field.png");
  } else {
    reset();
  }
}

class Particle {
  float px; 
  float py; 
  float vx; 
  float vy; 
  ArrayList<PVector> history;

  Particle(float x, float y) {
    px = x; 
    py = y; 
    vx = 0; 
    vy = 0;
    history = new ArrayList<PVector>();
  }
  void draw() {
    strokeWeight(8); 
    stroke(255, 0, 0); 
    noFill(); 
    beginShape();
    for (int i=0; i<history.size(); i++) {
      PVector pv = history.get(i); 
      vertex(pv.x, pv.y);
    }
    endShape(); 

    stroke(0); 
    strokeWeight(8); 
    fill(255, 200, 200); 
    ellipse(px, py, 32, 32);
  }
  void updateMouse() {
    float dx = mouseX - px; 
    float dy = mouseY - py; 
    float dh = sqrt(dx*dx + dy*dy); 
    if (dh > 0) {
      float fx = dx/(dh*dh); 
      float fy = dy/(dh*dh);
      float ax = fx * 6; 
      float ay = fy * 6; 
      vx += 0-ax; 
      vy += 0-ay; 
      vx *= 0.95;  
      vy *= 0.95; 
      px += vx; 
      py += vy;
    }
  }

  void updateForce(float fx, float fy) {
    float ax = fx * 0.02; 
    float ay = fy * 0.02; 
    vx += 0-ax; 
    vy += 0-ay; 
    vx *= 0.95; 
    vy *= 0.95; 
    px += vx; 
    py += vy;

    history.add(new PVector(px, py));
  }
}
