// Press l, r, e, to switch between drawing lines, rectangles, and ellipses.

int mode;

final int DRAW_LINE = 0;
final int DRAW_ELLIPSE = 1;
final int DRAW_RECTANGLE = 2;

ArrayList<LineHand> lines;
ArrayList<RectHand> rectangles;
ArrayList<EllipseHand> ellipses;

PVector curP;

PImage cursor; 

void setup() {
  size(800, 800);
  mode = DRAW_LINE;
  reset();
  frameRate(24);
  
  cursor = loadImage("cursor_with_shadow_15x21.png");
}

void draw() {
  background(253);
  
  if (mode == DRAW_LINE) {
    if (curP != null) {
      LineHand l = new LineHand(curP, new PVector(mouseX, mouseY));
      l.show();
    }
  } else if (mode == DRAW_RECTANGLE) {
    if (curP != null) {
      RectHand r = new RectHand(curP, new PVector(mouseX, mouseY));
      r.show();
    }
  } else if (mode == DRAW_ELLIPSE) {
    if (curP != null) {
      EllipseHand e = new EllipseHand(curP, new PVector(mouseX, mouseY));
      e.show();
    }
  }
  
  for (LineHand l: lines) {
    l.show();
  }
  for (RectHand r: rectangles) {
    r.show();
  }
  for (EllipseHand e: ellipses) {
    e.show();
  }
  
  image(cursor, mouseX, mouseY, 90, 126);
}

void reset() {
  lines = new ArrayList<LineHand>();
  rectangles = new ArrayList<RectHand>();
  ellipses = new ArrayList<EllipseHand>();
}

void mousePressed() {
  if (mode == DRAW_LINE) {
    if (curP == null) {
      curP = new PVector(mouseX, mouseY);
    } else {
      PVector p = new PVector(mouseX, mouseY);
      LineHand l = new LineHand(curP, p);
      curP = null;
      lines.add(l);
    }
  } else if (mode == DRAW_RECTANGLE) {
    if (curP == null) {
      curP = new PVector(mouseX, mouseY);
    } else {
      PVector p = new PVector(mouseX, mouseY);
      RectHand r = new RectHand(curP, p);
      curP = null;
      rectangles.add(r);
    }
  } else if (mode == DRAW_ELLIPSE) {
    if (curP == null) {
      curP = new PVector(mouseX, mouseY);
    } else {
      PVector p = new PVector(mouseX, mouseY);
      EllipseHand e = new EllipseHand(curP, p);
      curP = null;
      ellipses.add(e);
    }
  }
}

void keyPressed() {
  if (key == 'r') {
    mode = DRAW_RECTANGLE;
  } else if (key == 'l') {
    mode = DRAW_LINE;
  } else if (key == 'e') {
    mode = DRAW_ELLIPSE;
  } else if (key == 'c') {
    reset();
  } else if (key == ' ') {
    saveFrame("hand_drawn.png");
  }
}
