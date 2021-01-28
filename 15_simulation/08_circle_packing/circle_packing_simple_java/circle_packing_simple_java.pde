// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QHEQuoIKgNE

ArrayList<Circle> circles;

void setup() {
  size(800, 800);
  circles = new ArrayList<Circle>();
}


void keyPressed() {
  if (key == ' ') {
    saveFrame("circle_packing.png");
  }
}

void draw() {
  background(253);


  int total = 2;
  int count = 0;
  int attempts = 0;

  while (count <  total) {
    Circle newC = newCircle();
    if (newC != null) {
      circles.add(newC);
      count++;
    }
    attempts++;
    if (attempts > 1000000) {
      noLoop();
      println("FINISHED");
      break;
    }
  }


  for (Circle c : circles) {
    if (c.growing) {
      if (c.edges()) {
        c.growing = false;
      } else {
        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d - 2 < c.r + other.r) {
              c.growing = false;
              break;
            }
          }
        }
      }
    }

    if ((c.growing == false) && (c.r < 4)) {
      // circles.remove(c);
      c.grow();
    } else {
      c.show();
      c.grow();
    }
  }
}


Circle newCircle() {

  float x = random(width);
  float y = random(height);

  boolean valid = true;
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r) {
      valid = false;
      break;
    }
  }

  if (valid) {
    return new Circle(x, y);
  } else {
    return null;
  }
}


// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QHEQuoIKgNE

class Circle {
  float x;
  float y;
  float r;

  boolean growing = true;

  Circle(float x_, float y_) {
    x = x_;
    y = y_;
    r = 1;
  }

  void grow() {
    if (growing) {
      r = r + 2.5;
    }
  }

  boolean edges() {
    float e = 3; 
    return (x + r >= (width-e) || x -  r <= e || y + r >= (height-e) || y -r <= e);
  }

  void show() {
    stroke(0);
    strokeWeight(2);
    fill(255);
    ellipse(x, y, r*2, r*2);
  }
}
