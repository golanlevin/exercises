
PFont myFont; 
float amounts[] = {8, 5, 11, 16};
String names[] = {"breakfast", "coffee", "lunch", "dinner"};
color colors[] = {
  color(191, 241, 255), 
  color(236, 213, 162), 
  color(223, 255, 191), 
  color(255, 227, 254)};


void setup() {
  noLoop();
  size(800, 800);
  myFont = createFont("Helvetica-Bold", 48);
  textFont(myFont);
}

void draw() {
  background(253); 
  noLoop(); 

  float total = 0; 
  for (int i=0; i<amounts.length; i++) {
    total += amounts[i];
  }



  float cx = width/2;
  float cy = height/2; 
  float diam = 600;
  float angleStart = 0-HALF_PI; 
  for (int i=0; i<amounts.length; i++) {
    float ithFraction = amounts[i]/total;
    float ithAngle = ithFraction * TWO_PI; 
    float angleEnd = angleStart + ithAngle;

    fill(colors[i]); //(255);
    stroke(0, 0, 0); 
    strokeWeight(8); 
    strokeJoin(ROUND); 
    arc(cx, cy, diam, diam, angleStart, angleEnd, PIE); 

    fill(0); 
    pushMatrix();
    translate(cx, cy); 
    rotate(angleEnd); 
    textAlign(RIGHT, BOTTOM); 
    text(names[i], diam/2 - 20, -8); 
    popMatrix();

    angleStart += ithAngle;
  }
}

//===================================
void keyPressed() {
  if (key == ' ') {
    saveFrame("pie_chart.png");
  }
}
