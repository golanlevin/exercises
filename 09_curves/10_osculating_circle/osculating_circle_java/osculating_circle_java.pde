// Press keys 0 (draw), 1 (set c1), 2 (set c2).

int MODE_DRAW = 0; 
int MODE_PLACE1 = 1; 
int MODE_PLACE2 = 2; 
int mode;

ArrayList<PVector> myLine;
PVector C1; 
PVector C2; 
int C1index; 
int C2index;
int indexOfClosest;

void setup() {
  size(800, 800); 
  mode = MODE_DRAW;
  myLine = new ArrayList<PVector>();
  C1 = new PVector(); 
  C2 = new PVector(); 

  indexOfClosest = -1;
  C1index = -1;
  C2index = -1;
}

//--------------------------------------------------
void draw() {
  background(253); 
  ellipseMode(CENTER); 

  findClosestPointOnLine(); 
  drawMyLine();
  // drawMyTangents();

  drawOsculatingCircle(C1index);
  drawOsculatingCircle(C2index);
}



//==============================================================
void drawOsculatingCircle (int index) {
  if (index > 0) {
    PVector pt1 = myLine.get(index-1); 
    PVector pt2 = myLine.get(index  ); 
    PVector pt3 = myLine.get(index+1); 
    PVector C1 = calcCircleFrom3Points(pt1.x, pt1.y, pt2.x, pt2.y, pt3.x, pt3.y); 

    fill(255); 
    stroke(0); 
    strokeWeight(2); 
    ellipse(C1.x, C1.y, C1.z*2, C1.z*2);

    fill(0);
    noStroke();
    ellipse(C1.x, C1.y, 24, 24);
  }
}


//==============================================================
//From http://paulbourke.net/geometry/circlesphere/

PVector calcCircleFrom3Points (
  float pt1x, float pt1y, 
  float pt2x, float pt2y, 
  float pt3x, float pt3y) {

  PVector out = new PVector(); 

  float yDelta_a = pt2y - pt1y;
  float xDelta_a = pt2x - pt1x;
  float yDelta_b = pt3y - pt2y;
  float xDelta_b = pt3x - pt2x;

  float m_Centerx = 0; 
  float m_Centery = 0; 
  float m_dRadius = 0; 
  if (abs(xDelta_a) <= EPSILON && abs(yDelta_b) <= EPSILON) {
    m_Centerx = 0.5*(pt2x + pt3x);
    m_Centery = 0.5*(pt1y + pt2y);
    m_dRadius = sqrt(sq(m_Centerx-pt1x) + sq(m_Centery-pt1y));
    return out;
  }

  // IsPerpendicular() assure that xDelta(s) are not zero
  float aSlope = yDelta_a / xDelta_a; 
  float bSlope = yDelta_b / xDelta_b;
  if (abs(aSlope-bSlope) <= EPSILON) {  // checking whether the given points are colinear.   
    return out;
  }

  // calc center
  m_Centerx = (aSlope*bSlope*(pt1y - pt3y) + bSlope*(pt1x + pt2x)- aSlope*(pt2x+pt3x) )/(2* (bSlope-aSlope) );
  m_Centery = -1*(m_Centerx - (pt1x+pt2x)/2)/aSlope +  (pt1y+pt2y)/2;
  m_dRadius = sqrt(sq(m_Centerx-pt1x) + sq(m_Centery-pt1y));

  out.x = m_Centerx;
  out.y = m_Centery;
  out.z = m_dRadius;
  return out;
}


//--------------------------------------------------
void findClosestPointOnLine() {
  if ((mode == MODE_PLACE1) || (mode == MODE_PLACE2)) {
    // find closest point on line
    indexOfClosest = -1; 
    if (myLine.size() > 0) {
      float minDist = 99999; 
      for (int i=0; i<myLine.size(); i++) {
        float dx = mouseX - myLine.get(i).x; 
        float dy = mouseY - myLine.get(i).y; 
        float dh = sqrt (dx*dx + dy*dy);
        if (dh < minDist) {
          minDist = dh; 
          indexOfClosest = i;
        }
      }
    }

    /*
    if (indexOfClosest != -1) {
     PVector closest = myLine.get(indexOfClosest); 
     float cx = closest.x;
     float cy = closest.y;
     noStroke();
     fill(0); 
     ellipse(cx, cy, 24, 24);
     }
     */
  }
}

//--------------------------------------------------
void drawMyTangents() {

  stroke(0);
  strokeWeight(8); 
  fill(255, 200, 200); 

  if (C1index != -1) {
    PVector tangentP1 = myLine.get(C1index); 
    ellipse(tangentP1.x, tangentP1.y, 32, 32);
  }
  if (C2index != -1) {
    PVector tangentP2 = myLine.get(C2index); 
    ellipse(tangentP2.x, tangentP2.y, 32, 32);
  }
}

//--------------------------------------------------
void drawMyLine() {
  noFill();
  stroke(0); 
  strokeWeight(8); 
  strokeJoin(ROUND); 
  strokeCap(ROUND); 
  beginShape(); 
  for (int i=0; i<myLine.size(); i++) {
    float px = myLine.get(i).x; 
    float py = myLine.get(i).y; 
    curveVertex(px, py);
  }
  endShape();
}


//--------------------------------------------------
void smoothMyLine() {
  for (int j=1; j<(myLine.size()-1); j++) {
    PVector vi = myLine.get(j-1);
    PVector vj = myLine.get(j  );
    PVector vk = myLine.get(j+1); 

    float px = (vi.x + vj.x + vk.x)/3.0;
    float py = (vi.y + vj.y + vk.y)/3.0; 
    myLine.get(j).set(px, py);
  }
}

//--------------------------------------------------
void keyPressed() {
  if (key == '1') {
    mode = MODE_PLACE1;
  } else if (key == '2') {
    mode = MODE_PLACE2;
  } else if (key == '0') {
    mode = MODE_DRAW;
  } else if (key == ' ') {
    saveFrame("osculating_circle.png");
  } else if (key == 's') {
    smoothMyLine();
  }
}

//--------------------------------------------------
void mousePressed() {
  if (mode == MODE_DRAW) {

    indexOfClosest = -1;
    C1index = -1;
    C2index = -1; 

    myLine.clear(); 
    myLine.add(new PVector(mouseX, mouseY));
    ;
  } else if ((mode == MODE_PLACE1) && (indexOfClosest != -1)) {
    C1index = indexOfClosest;
  } else if ((mode == MODE_PLACE2) && (indexOfClosest != -1)) {
    C2index = indexOfClosest;
  }
}

//--------------------------------------------------
void mouseDragged() {
  if (mode == MODE_DRAW) {
    myLine.add(new PVector(mouseX, mouseY));
  } else if ((mode == MODE_PLACE1) && (indexOfClosest != -1)) {
    C1index = indexOfClosest;
  } else if ((mode == MODE_PLACE2) && (indexOfClosest != -1)) {
    C2index = indexOfClosest;
  }
}
