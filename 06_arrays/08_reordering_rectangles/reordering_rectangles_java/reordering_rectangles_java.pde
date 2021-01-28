import java.util.Collections;
import java.util.Comparator;

float offset;
float ssize;
float factor;
color colors[] = {
  color(191, 241, 255), 
  color(236, 213, 162), 
  color(223, 255, 191), 
  color(255, 227, 254)};
  
ArrayList<Rectangle> rectList;
  
void setup() {
  size(800, 800);
  
  offset = 50;
  ssize = (width - 3*offset)/2;
  factor = ssize/10;
  
  rectList = new ArrayList<Rectangle>();
  
  Rectangle r1 = new Rectangle(0, 4, 5, 4, colors[0]);
  Rectangle r2 = new Rectangle(4, 3, 4, 3, colors[1]);
  Rectangle r3 = new Rectangle(2, 1, 4, 4, colors[2]);
  Rectangle r4 = new Rectangle(1, 0, 6, 2, colors[3]);
  
  rectList.add(r1);
  rectList.add(r2);
  rectList.add(r3);
  rectList.add(r4);
}

//---------------------------------------------------
void draw() {
  
  offset = 70;
  
  background(253);
  stroke(0); 
  strokeWeight(2); 
  for (int x=5; x<(width-10); x+=20){
    line(x,height/2, x+10, height/2);  
  }
  for (int y=5; y<(height-10); y+=20){
    line(width/2, y, width/2, y+10);  
  }
  
  
  stroke(0); 
  strokeWeight(8);
  strokeJoin(MITER); 
  
  // normal order
  pushMatrix();
  translate(offset, offset);
  for (int i = 0; i < 4; i++) {
    Rectangle r = rectList.get(i);
    fill(r.c);
    rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h);
  }
  popMatrix();
  
  
  // reverse order
  pushMatrix();
  translate(offset*2 + ssize, offset);
  for (int i = 3; i >= 0; i--) {
    Rectangle r = rectList.get(i);
    fill(r.c);
    rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h);
  }
  popMatrix();

  // sort by area
  ArrayList<Rectangle> sortedByArea = new ArrayList<Rectangle>(rectList);
  Comparator<Rectangle> cmp_area = new RectangleComparatorByArea();
  Collections.sort(sortedByArea, cmp_area);
  pushMatrix();
  translate(offset, ssize + 2*offset);
  for (int i = 3; i >= 0; i--) {
    Rectangle r = sortedByArea.get(i);
    fill(r.c);
    rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h);
  }
  popMatrix();
  
  // sort by left side
  ArrayList<Rectangle> sortedByLeftSide = new ArrayList<Rectangle>(rectList);
  Comparator<Rectangle> cmp_left = new RectangleComparatorByLeftSide();
  Collections.sort(sortedByLeftSide, cmp_left);
  pushMatrix();
  translate(ssize + 2*offset, ssize + 2*offset);
  for (int i = 3; i >= 0; i--) {
    Rectangle r = sortedByLeftSide.get(i);
    fill(r.c);
    rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h);
  }
  popMatrix();
  

}

//---------------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("reordering_rectangles.png");
  }
}
