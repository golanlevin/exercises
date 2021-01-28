float offset;
float x;

void setup() {
  size(800, 800);
  noLoop(); 
  
  offset = width/10;
  x = offset * 2;
}

void draw() {
  background(253);
  strokeWeight(8);
  ellipseMode(CENTER); 
  strokeJoin(MITER); 
  
  // rectangle, ellipse, arc, line segment, Bézier curve, polyline, or polygon
  
  // triangle 
  pushMatrix();
  fill(255); 
  translate(offset, offset);
  triangle(0, x, x/2, 0, x, x);
  popMatrix();
  
  // rectangle
  pushMatrix();
  fill(255); 
  translate(offset*2+x, offset);
  rect(0, x/6, x, x*4/6);
  popMatrix();
  
  // ellipse
  pushMatrix();
  fill(255); 
  translate(offset*3+x*2, offset);
  ellipse(x/2, x/2, x, x);
  popMatrix();
  
  // line and point
  pushMatrix();
  translate(offset, offset*2 + x);
  line(0, 0, x, x);
  strokeWeight(16);
  point(0+x/4, x-x/4);
  point(x-x/4, 0+x/4);
  strokeWeight(8);
  popMatrix();
  
  // curve
  pushMatrix();
  noFill(); 
  translate(offset*2 + x, offset*2 + x);
  bezier(0, x, 0, 0, x, x, x, 0);
  line(0, x, 0, 0);
  line(x, x, x, 0);
  popMatrix();
  
  // vertices
  noFill(); 
  strokeJoin(ROUND); 
  pushMatrix();
  translate(offset*3 + x*2, offset*2 + x);
  beginShape();
  vertex(x*0/4, x/2);
  vertex(x*1/4, x);
  vertex(x*1/4, 0);
  vertex(x*3/4, x);
  vertex(x*3/4, 0);
  vertex(x*4/4, x/2);
  endShape();
  popMatrix();
  strokeJoin(MITER); 
  
  // arc
  fill(255); 
  pushMatrix();
  translate(offset, offset*3 + x*2);
  arc(x/2, x/2, x, x, 0.25*PI, 1.75*PI, PIE);
  popMatrix();
  
  // quad
  fill(255); 
  pushMatrix();
  translate(offset*2 + x, offset*3 + x*2);
  quad(0, 0, 0, x, x, x, x*2/3, 0);
  popMatrix();
  
  // ellipse n.2
  fill(255); 
  pushMatrix();
  translate(offset*3 + x*2, offset*3 + x*2);
  translate(x/2, x/2); 
  rotate(radians(41.4096)); 
  ellipse(0,0, x*1.3333, x*0.6666);
  popMatrix();
  
  /*
  pushMatrix();
  translate(offset*3 + x*2, offset*3 + x*2);
  beginShape();
  curveVertex(0,  0);
  curveVertex(0,  0);
  curveVertex(x*2/3, x/3);
  curveVertex(x/3, x*2/3);
  curveVertex(x, x);
  curveVertex(x, x);
  endShape();
  popMatrix();
  */
}

void keyPressed() {
  if (key == ' '){
    saveFrame("one_with_everything.png");
  }
}
