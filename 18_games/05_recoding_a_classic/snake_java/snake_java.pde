// Adapted from original implementation by Daniel Shiffman
// Source: https://github.com/CodingTrain/website/tree/master/CodingChallenges/CC_003_Snake_game/Processing/CC_003_Snake_game
// 
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/AaGK-fj-BAM

Snake s;
int scl = 50;

PVector food;

void setup() {
  size(800, 800);
  s = new Snake();
  frameRate(5);
  pickLocation();
}

void pickLocation() {
  int cols = width/scl;
  int rows = height/scl;
  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
}

void mousePressed() {
  s.total++;
}

void draw() {
  background(253);

  if (s.eat(food)) {
    pickLocation();
  }
  s.death();
  s.update();
  s.show();


  noStroke();
  fill(255, 50, 50);
  rect(food.x, food.y, scl, scl);
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("snake.png");
  } else if (keyCode == UP) {
    s.dir(0, -1);
  } else if (keyCode == DOWN) {
    s.dir(0, 1);
  } else if (keyCode == RIGHT) {
    s.dir(1, 0);
  } else if (keyCode == LEFT) {
    s.dir(-1, 0);
  }
}

class Snake {
  float x = 0;
  float y = 0;
  float xspeed = 1;
  float yspeed = 0;
  int total = 20;
  ArrayList<PVector> tail = new ArrayList<PVector>();

  Snake() {
  }

  boolean eat(PVector pos) {
    float d = dist(x, y, pos.x, pos.y);
    if (d < 1) {
      total++;
      return true;
    } else {
      return false;
    }
  }

  void dir(float x, float y) {
    xspeed = x;
    yspeed = y;
  }

  void death() {
    for (int i = 0; i < tail.size(); i++) {
      PVector pos = tail.get(i);
      float d = dist(x, y, pos.x, pos.y);
      if (d < 1) {
        println("starting over");
        total = 0;
        tail.clear();
      }
    }
  }

  void update() {
    //println(total + " " + tail.size());
    if (total > 0) {
      if (total == tail.size() && !tail.isEmpty()) {
        tail.remove(0);
      }
      tail.add(new PVector(x, y));
    }

    x = x + xspeed*scl;
    y = y + yspeed*scl;

    x = constrain(x, 0, width-scl);
    y = constrain(y, 0, height-scl);
  }

  void show() {
    noStroke();
    fill(255, 200, 200);
    for (PVector v : tail) {
      rect(v.x, v.y, scl, scl);
    }
    rect(x, y, scl, scl);
  }
}
