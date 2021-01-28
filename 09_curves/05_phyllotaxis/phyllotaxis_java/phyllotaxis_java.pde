// Turtle Graphics in Processing
// Natalie Freed, February 2013
// This program shows another way to think about moving
// through Processing's coordinate system. Instead of placing
// points on a grid, you can imagine yourself as being somewhere
// on the grid, facing a direction. You can move forward or turn.
// The drawn line follows behind you.

PVector loc; //current location
float angle; //current orientation

void setup()
{
   size(800, 800);
   background(253);
   loc = new PVector(width/2, height/2); //starting position is at center
   angle = 0; //starting orientation
   noLoop();
}

void draw() //this example draws a polygon. Can you change the number of sides?
{
  //forward(50); //go forward 200 pixels
  //left(radians(30)); //turn 30 degrees to the left
   
  fill(0); 
  noStroke();
  for (int i = 0; i < 150; i += 1) {
    forward(i*4.0);
    left(radians(137.507764));

    if (i>1) {
      float D = map(i, 0, 150, 8, 24);
      ellipse(loc.x, loc.y, D, D);
    }
  }
}


// Below are utility functions to calculate new positions and orientations 
// when moving forward or turning. You don't need to change these.

void forward(float l) //calculate positions when moving forward
{
  PVector start = loc;
  PVector end = PVector.add(loc, new PVector(cos(angle)*l, sin(angle)*l));
  //line(start.x, start.y, end.x, end.y);
  loc = end;
}

void left(float theta) //calculate new orientation
{
  angle += theta;
}

void right(float theta)  //calculate new orientation
{
  angle -= theta;
}

void jumpTo(int x, int y) //jump directly to a specific position
{
  loc = new PVector(x, y);
}

void line(PVector a, PVector b) //new line function with PVectors. used by forward function
{
  line(a.x, a.y, b.x, b.y);
}

PVector polar(float r, float theta) //converts an angle and radius into a vector
{
  return new PVector(r*cos(theta),r*sin(-theta)); // negate y for left handed coordinate system
}

void keyPressed() {
  saveFrame("phyllotaxis.png");
}
