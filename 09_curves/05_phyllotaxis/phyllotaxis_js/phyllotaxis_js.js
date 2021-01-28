var turtle;
var angle;

function setup() {
  createCanvas(800, 800);
  background(253);
  turtle = new Turtle(width/2, height/2);
  angle = 137.507764;
  turtle.penUp();

  fill(0); 
  noStroke(); 
  for (var i = 0; i < 150; i += 1) {
    turtle.forward(i*4.0);
    turtle.left(angle);

    if (i>1){
      var D = map(i, 0, 150, 16,24);
      ellipse(turtle.x, turtle.y, D,D);
    }
  }

}

function draw() {
}

function keyTyped() {
  if (keyCode == 32) { // empty space
    saveFrames('phyllotaxis', 'png', 1, 1);
  }
}

//=======================================================
// TURTLE GRAPHICS IMPLEMENTATION
// Roger Dannenberg, 2015
//
// Turtle(x, y) -- make a turtle at x, y, facing right, pen down
// left(d) -- turn left by d degrees
// right(d) -- turn right by d degrees
// forward(p) -- move forward by p pixels
// back(p) -- move back by p pixels
// penDown() -- pen down
// penUp() -- pen up
// goto(x, y) -- go straight to this location
// setColor(color) -- set the drawing color
// setWeight(w) -- set line width to w
// face(d) -- turn to this absolute direction in degrees
// angleTo(x, y) -- what is the angle from my heading to location x, y?
// turnToward(x, y, d) -- turn by d degrees toward location x, y
// distanceTo(x, y) -- how far is it to location x, y?
//
function Turtle(x, y) {
this.x = x;
this.y = y;
this.angle = 0.0;
this.penIsDown = true;
this.color = color(128);
this.weight = 1;

this.left = function(d) {
this.angle -= d;
};
this.right = function(d) {
this.angle += d;
};
this.forward = function(p) {
var rad = radians(this.angle);
var newx = this.x + cos(rad) * p;
var newy = this.y + sin(rad) * p;
this.goto(newx, newy);
};
this.back = function(p) {
this.forward(-p);
};
this.penDown = function() {
this.penIsDown = true;
};
this.penUp = function() {
this.penIsDown = false;
};
this.goto = function(x, y) {
if (this.penIsDown) {
stroke(this.color);
strokeWeight(this.weight);
line(this.x, this.y, x, y);
}
this.x = x;
this.y = y;
};
this.distanceTo = function(x, y) {
return sqrt(sq(this.x - x) + sq(this.y - y));
};
this.angleTo = function(x, y) {
var absAngle = degrees(atan2(y - this.y, x - this.x));
var angle = ((absAngle - this.angle) + 360) % 360.0;
return angle;
};
this.turnToward = function(x, y, d) {
var angle = this.angleTo(x, y);
if (angle < 180) {
this.angle += d;
} else {
this.angle -= d;
}
};
this.setColor = function(c) {
this.color = c;
};
this.setWeight = function(w) {
this.weight = w;
};
this.face = function(angle) {
this.angle = angle;
}
}
