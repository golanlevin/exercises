// Press l, r, e, to switch between drawing lines, rectangles, and ellipses.
var mode;

var DRAW_LINE = 0;
var DRAW_ELLIPSE = 1;
var DRAW_RECTANGLE = 2;

var lines = [];
var rectangles = [];
var ellipses = [];

var curP;

var cursor; 

function setup() {
  createCanvas(800, 800);
  mode = DRAW_LINE;
  reset();
  frameRate(24);
  curP = null;
  cursor = loadImage("data/cursor_with_shadow_15x21.png");
}

function draw() {
  background(253);
  
  if (mode == DRAW_LINE) {
    if (curP != null) {
      let l = new LineHand(curP, createVector(mouseX, mouseY));
      l.show();
    }
  } else if (mode == DRAW_RECTANGLE) {
    if (curP != null) {
      let r = new RectHand(curP, createVector(mouseX, mouseY));
      r.show();
    }
  } else if (mode == DRAW_ELLIPSE) {
    if (curP != null) {
      let e = new EllipseHand(curP, createVector(mouseX, mouseY));
      e.show();
    }
  }
  
  for (let i = 0 ; i < lines.length; i++) {
    let l = lines[i];
    l.show();
  }
  for (let i = 0 ; i < rectangles.length; i++) {
    let r = rectangles[i];
    r.show();
  }
  for (let i = 0 ; i < ellipses.length; i++) {
    let e = ellipses[i];
    e.show();
  }
  
  image(cursor, mouseX, mouseY, 90, 126);
}

function reset() {
  lines = [];
  rectangles = [];
  ellipses = [];
}

function mouseReleased() {
  if (mode == DRAW_LINE) {
    if (curP == null) {
      curP = createVector(mouseX, mouseY);
    } else {
      var p = createVector(mouseX, mouseY);
      var l = new LineHand(curP, p);
      curP = null;
      lines.push(l);
    }
  } else if (mode == DRAW_RECTANGLE) {
    if (curP == null) {
      curP = createVector(mouseX, mouseY);
    } else {
      var p = createVector(mouseX, mouseY);
      var r = new RectHand(curP, p);
      curP = null;
      rectangles.push(r);
    }
  } else if (mode == DRAW_ELLIPSE) {
    if (curP == null) {
      curP = createVector(mouseX, mouseY);
    } else {
      var p = createVector(mouseX, mouseY);
      var e = new EllipseHand(curP, p);
      curP = null;
      ellipses.push(e);
    }
  }
}

function keyPressed() {
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


// DRAWING FUNCTIONS

class LineHand {
  
  constructor (pa, pb) {
    var distance = (p5.Vector).dist(pa, pb);
    var n = int(distance/30.0); // number of points
    (this.points) = [];
    (this.points).push(pa);
    for (var i = 1; i < n; i++) {
      var dx =  (pb.x-pa.x)*i/n + (randomGaussian()-0.5)*3;
      var dy =  (pb.y-pa.y)*i/n + (randomGaussian()-0.5)*3;
      var newP = createVector(pa.x + dx, pa.y + dy);
      (this.points).push(newP);
    }
    (this.points).push(pb);
  }
  
  show() {
    noFill();
    stroke(0);
    strokeWeight(8);
    beginShape();
    
    var p = (this.points)[0];
    curveVertex(p.x, p.y);
    for (var i = 0; i < (this.points).length; i++) {
      p = (this.points)[i];
      curveVertex(p.x, p.y);
    }
    p = (this.points)[(this.points).length-1];
    curveVertex(p.x, p.y);
    endShape();
  }
}

class EllipseHand {
  
  constructor (p1, p2) {
    var center = p1;
    var radius = p5.Vector.dist(p1, p2);
    (this.points) = [];
    
    var n = max(2, int(PI*2*radius/30));
    
    for (var i = 0; i < n; i++) {
      var r = 2*PI * i/n;
      var p = createVector(center.x + radius * cos(r) + (randomGaussian()-0.5)*3, 
                              center.y + radius * sin(r) + (randomGaussian()-0.5)*3);
      (this.points).push(p);
    }
  }

  show() {
    noFill();
    stroke(0);
    strokeWeight(8);
    beginShape();
    var p = (this.points)[0];
    curveVertex(p.x, p.y);
    for (var i = 0; i < (this.points).length; i++) {
      p = (this.points)[i];
      curveVertex(p.x, p.y);
    }
    p = (this.points)[(this.points).length-1];
    curveVertex(p.x, p.y);
    p = (this.points)[0];
    curveVertex(p.x, p.y);
    curveVertex(p.x, p.y);
    endShape();
  } 
}

class RectHand {

  constructor  (p1, p2) {
    var p1_ = createVector(p1.x, p2.y);
    var p2_ = createVector(p2.x, p1.y);
    
    this.topEdge = new LineHand(p1, p1_);
    this.leftEdge = new LineHand(p1_, p2);
    this.bottomEdge = new LineHand(p2, p2_);
    this.rightEdge = new LineHand(p2_, p1);    
  }
  
  show() {
    this.topEdge.show();
    this.leftEdge.show();
    this.bottomEdge.show();
    this.rightEdge.show();
  }
}
