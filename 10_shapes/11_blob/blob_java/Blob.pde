// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/ccYLb7cLB1I

class Blob {
  PVector pos;
  float r;
  PVector vel;

  Blob() {
    r = random(80, 300);
    pos = new PVector(random(r, width-r), random(r, height-r));
    vel = PVector.random2D();
    vel.mult(random(2, 5));
  }

  void update() {
    pos.add(vel); 
    if (pos.x > width-r/2 || pos.x < r/2) {
      vel.x *= -1;
    }
    if (pos.y > height-r/2 || pos.y < r/2) {
      vel.y *= -1;
    }
  }

  void show() {
    noFill();
    stroke(0);
    strokeWeight(4);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
}
