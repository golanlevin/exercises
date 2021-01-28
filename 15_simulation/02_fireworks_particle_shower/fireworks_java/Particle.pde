// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for:

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  boolean seed = false;

  float r;

  Particle(float x, float y, float h) {
    r = h;

    acceleration = new PVector(0, -5);
    velocity = new PVector(0, random(-12, -8));
    location =  new PVector(x, y);
    seed = true;
    lifespan = 255.0;
  }

  Particle(PVector l, float h) {
    r = h;
    acceleration = new PVector(0, 0);
    velocity = PVector.random2D();
    velocity.mult(random(4, 8));
    location = l.copy();
    lifespan = 255.0;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void run() {
    update();
    display();
  }

  boolean explode() {
    if (seed && velocity.y > 0) {
      lifespan = 0;
      return true;
    }
    return false;
  }

  // Method to update location
  void update() {

    velocity.add(acceleration);
    location.add(velocity);
    if (!seed) {
      lifespan -= 5.0;
      velocity.mult(0.95);
    }
    acceleration.mult(0);
  }

  // Method to display
  void display() {
    stroke(255, r, r, lifespan);
    if (seed) {
      strokeWeight(16);
    } else {
      strokeWeight(8);
    }
    point(location.x, location.y);
    //ellipse(location.x, location.y, 12, 12);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("fireworks.png");
  }
}
