// Rectangle Sequence 

void setup() {
  size(800, 800, FX2D);
  noLoop();
}

void draw() {
  background (253); 
  strokeJoin(MITER); 
  strokeWeight(2);
  stroke(0); 

  //sets the number of rectangles being drawn
  int nRectangles = 14;
  float offset = 50;
  float w = (width-offset*2)/nRectangles;
  for (int i=0; i<nRectangles; i++) {
    //finds the x and y value of current rectangle
    float x0 = offset + i * w;
    float y0 = height-offset; 

    //rectangle height increases by 25
    float rectH = (i+1) * w;
    //creates a color gradient by making color dependent on i
    float g = (float)i / (float)(nRectangles);
    fill (255.0 * pow(g, 0.75));
    //draws the rectangles 
    rect (x0, y0, w, -rectH);
  }
}

void keyPressed() {
  saveFrame("../transitioning_rectangles.png"); 
  exit();
}
