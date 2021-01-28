// Take a "Big Five" personality quiz to (ostensibly) quantify 
// your openness, conscientiousness, extraversion,  agreeableness, 
// and neuroticism. Generate a radar chart to visualize this 
// multivariate data. Ask some friends to take the quiz, and create 
// a trellis plot that allows their radar charts to be compared.

String titles[] = {"O", "C", "E", "A", "N"};
float dims0[]  = { 7.0, 6.0, 3.0, 8.0, 5.5};
float dims1[]  = { 5.5, 8.0, 2.0, 5.0, 6.0};
float dims2[]  = { 8.0, 5.0, 5.0, 7.5, 2.0};
float dims3[]  = { 4.0, 6.0, 4.0, 5.0, 7.0};
float dims[][] = {dims0, dims1, dims2, dims3};

// PFont myFont; 


void setup() {
  noLoop();
  size(800, 800);
  // myFont = createFont("Helvetica-Bold", 72);
  // textFont(myFont);
}

void draw() {
  background(253); 

  float my = 0.750;
  float mx = 0.625;

  int count = 0; 
  for (int y=0; y<2; y++) {
    for (int x=0; x<2; x++) {

      float cx = my*(x-0.5)*width;
      float cy = my*(y-0.5)* width;

      pushMatrix();
      translate(width/2, height/2);
      scale(mx); 
      translate(cx, cy); 
      drawRadarChart(0, 0, dims[count++]);
      popMatrix();
    }
  }
}





//-----------------------------------------------------------  
void drawRadarChart(float cx, float cy, float dimensions[]) {

  float diagramD = 550; 
  float R = diagramD/2;

  int nDimensions = dimensions.length;

  fill(255);  
  stroke(0, 0, 0);
  strokeWeight(8 / 0.625); 
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER); 
  ellipse(cx, cy, diagramD, diagramD); 

  // Draw the radar chart, 
  // Also known as a star plot or web chart
  fill(255, 200, 200); 
  stroke(0); 
  strokeJoin(MITER); 
  strokeWeight(8 / 0.625); 
  beginShape(); 
  for (int i=0; i<nDimensions; i++) {
    float t = map(i, 0, nDimensions, 0, TWO_PI) - HALF_PI; 
    float radius = map(dimensions[i], 0, 10, 0, R); 
    float px = cx + radius * cos(t); 
    float py = cy + radius * sin(t); 
    vertex(px, py);
  }
  endShape(CLOSE);


  fill(0);
  for (int i=0; i<nDimensions; i++) {
    float t = map(i, 0, nDimensions, 0, TWO_PI) - HALF_PI;

    float px = cx+R*cos(t);
    float py = cy+R*sin(t); 
    strokeWeight(2 / 0.625);
    stroke(0, 0, 0);
    line(cx, cy, px, py);

    pushMatrix(); 
    float tx = cx+(R+50)*cos(t);
    float ty = cy+(R+50)*sin(t);
    translate(tx, ty);

    rotate(t + HALF_PI);
    if ((t > 0.9) && (t < 2.5)) {
      rotate(PI);
    }

    // text(titles[i], 0, 0);
    popMatrix();
  }
}

//===================================
void keyPressed() {
  if (key == ' ') {
    saveFrame("radar_chart.png");
  }
}
