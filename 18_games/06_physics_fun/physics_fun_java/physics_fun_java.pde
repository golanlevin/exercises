PVector location;  // Location of shape
PVector velocity;  // Velocity of shape
PVector gravity;   // Gravity acts at the shape's acceleration
float basket;
int mode;
int score;

ArrayList<PVector> trail;

final int PLAY = 1;
final int PREP = 0;

float ballSize;
float basketSize;
PFont myFont; 


void setup() {
  size(800, 800);
  location = new PVector(0, 0);
  velocity = new PVector(1.5, 2.1);
  gravity = new PVector(0, 0.2);
  trail = new ArrayList<PVector>();

  ballSize = 100;
  basketSize = ballSize*1.5;

  score = 0;

  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont, 72);

  reset();
}

void draw() {
  background(253);

  if (mode == PREP) {
    // Display circle at location vector
    location.y = mouseY;
    location.x = 0;
  } else {
    // Add velocity to the location.
    location.add(velocity);
    // Add gravity to velocity
    velocity.add(gravity);

    // In order to score a point, 
    // The center of the ball must pass through the bounding rectangle
    // of the gray ellipse which defines the top of the basket, drawn at:
    // ellipse(basket, height-basketSize, basketSize, basketSize/3); AND
    // The ball must be heading DOWNWARD (it shouldn't be allowed to 
    // bounce upwards into the winning zone)
    if (
      (location.x-(ballSize/2) >= basket-basketSize/2) &&
      (location.x+(ballSize/2) <= basket+basketSize/2) && 
      (location.y >= (height-basketSize - basketSize/6)) && 
      (location.y <= (height-basketSize + basketSize/6)) && 
      (velocity.y > 0)) {
        
      score += 1;
      reset();
    }
    
    
    trail.add(new PVector(location.x, location.y));

    // Bounce off edges
    if ((location.x > width) || (location.x < 0)) {
      reset();
    }
    if (location.y > height) {
      // We're reducing velocity ever so slightly 
      // when it hits the bottom of the window
      velocity.y = velocity.y * -0.95; 
      location.y = height;
    }
  }
  drawTrail();
  drawBasket();
  drawBall();
  drawScore();
}


void reset() {
  mode = PREP;
  basket = random(50, width-50);
  velocity = new PVector(1.5, 2.1);
  gravity = new PVector(0, 0.2);
  trail = new ArrayList<PVector>();
}

void drawBall() {
  // Display circle at location vector
  stroke(0);
  strokeWeight(8);
  ellipseMode(CENTER);
  fill(255, 200, 200);
  ellipse(location.x, location.y, ballSize, ballSize);
}

void drawBasket() {
  stroke(0);
  strokeWeight(8);
  fill(200);
  ellipseMode(CENTER);
  ellipse(basket, height-basketSize, basketSize, basketSize/3);
  line(basket - basketSize/2, height-basketSize, basket - basketSize/2 + basketSize/5, height);
  line(basket + basketSize/2, height-basketSize, basket + basketSize/2 - basketSize/5, height);
}

void drawScore() {
  textAlign(LEFT, TOP);
  fill(0);
  text("score: " + score, 30, 30);
}

void drawTrail() {
  stroke(0);
  strokeWeight(3);

  for (int i = 2; i < trail.size(); i+=4) {
    PVector q = trail.get(i-2);
    PVector p = trail.get(i);
    line(p.x, p.y, q.x, q.y);
  }
}

void mousePressed() {
  trail.clear(); 
  mode = PLAY;
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("physics_fun_#####.png");
  }
}
