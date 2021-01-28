ArrayList<PVector> mousePositions;
boolean debug;

PImage cursor;

void setup() {
  size(800, 800);
  mousePositions = new ArrayList<PVector>();
  frameRate(16);
  
  cursor = loadImage("cursor_with_shadow_15x21.png");
}

void draw() {
  background(253);
  
  debug = false;
  
  mousePositions.add(new PVector(mouseX, mouseY));
  if (mousePositions.size() > 50) {
    mousePositions.remove(0);
  }
  
  drawPolyline_by_quads();
  
  image(cursor, mouseX, mouseY, 90, 126);
}

void drawPolyline_by_ellipses() {  
  noStroke();  
  fill(0);
  for (int i = 1; i < mousePositions.size(); i++) {
    PVector cur = mousePositions.get(i);
    PVector prev = mousePositions.get(i-1);
    float d = constrain(map(dist(cur.x, cur.y, prev.x, prev.y), 50, 10, 8, 50), 8, 50);
    ellipse(cur.x, cur.y, d, d);
  }
}

void drawPolyline_by_segments() {
  noFill();
  stroke(0);
  for (int i = 1; i < mousePositions.size(); i++) {
    PVector cur = mousePositions.get(i);
    PVector prev = mousePositions.get(i-1);
    float w = map(dist(cur.x, cur.y, prev.x, prev.y), 30, 0, 3, 10);
    strokeWeight(max(1, w));
    line(cur.x, cur.y, prev.x, prev.y);
  }
}

void drawPolyline_by_quads() {
  fill(0);
  stroke(0);
  strokeWeight(1);
  beginShape(TRIANGLE_STRIP); 
  
  float rad;
  float len;
  PVector cur;
  PVector prev;
  PVector next;
  
  if (mousePositions.size() < 2) {
    return;
  }
  
  
  cur = mousePositions.get(0);
  vertex(cur.x, cur.y);
  
  for (int i = 1; i < mousePositions.size()-1; i++) {
    cur = mousePositions.get(i);
    prev = mousePositions.get(i-1);
    next = mousePositions.get(i+1);
    rad = estimateSlope(cur, prev, next);
    len = getWidth(i);
    PVector p1 = new PVector(cur.x + len*cos(rad), cur.y + len*sin(rad));
    PVector p2 = new PVector(cur.x - len*cos(rad), cur.y - len*sin(rad));
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    
    if (debug) {
      noFill();
      strokeWeight(1);
      stroke(0);
      line(p1.x, p1.y, p2.x, p2.y);
      
      noStroke();
      fill(255, 0, 0);
      ellipse(p1.x, p1.y, 5, 5);
      
      fill(0);
      noStroke();
    }
    
  }
  
  cur = mousePositions.get(mousePositions.size()-1);
  vertex(cur.x, cur.y);
  
  endShape();
}

float estimateSlope(PVector cur, PVector prev, PVector next) {
  float slope1 = (cur.y - prev.y)/(cur.x - prev.x);
  float slope2 = (next.y - cur.y)/(next.x - cur.x);
  float dist1 = dist(cur.x, cur.y, prev.x, prev.y);
  float dist2 = dist(cur.x, cur.y, next.x, next.y);
  float slopeAve = (slope1*dist1 + slope2*dist2)/(dist1+dist2);
  float slopeAveInverse = -1/slopeAve;
  float rad = atan(slopeAveInverse);
  if (next.y - prev.y <= 0) {
    if (next.x - prev.x <= 0) {
      rad += PI;
    } else {
      rad -= PI;
    }
  }
  return rad;
}

float getWidth(int index) {
  int count = 0;
  float distAccum = 0;
  for (int i = max(index-3, 1); i < min(index+3, mousePositions.size()-1); i++) {
    count += 1;
    PVector cur = mousePositions.get(i-1);
    PVector next = mousePositions.get(i);
    distAccum += dist(cur.x, cur.y, next.x, next.y);
  }
  float w = constrain(map(distAccum/count, 50, 0, 2, 40), 2, 40);
  return w;
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("calligraphic_polyline.png");
  }
}
