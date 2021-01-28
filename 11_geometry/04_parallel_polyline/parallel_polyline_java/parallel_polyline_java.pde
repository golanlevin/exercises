ArrayList<PVector> points;  
PImage cursorImg;


//-----------------------------------------
void setup() {
  size(800, 800);
  cursorImg = loadImage("cursor_with_shadow_15x21.png");  

  points = new ArrayList<PVector>();
}


//-----------------------------------------
void draw() {
  background(253); 

  if (points.size() > 0) {
    strokeCap(ROUND); 
    strokeJoin(ROUND); 

    // Draw main (thick) gesture.
    noFill(); 
    stroke(0); 
    strokeWeight(8);
    beginShape(); 
    for (int j=0; j<points.size(); j++) {
      PVector pJ = points.get(j); 
      vertex(pJ.x, pJ.y);
    }
    endShape(); 

    float offset = 50.0; 
    float minPointDist = 4.0; 

    strokeWeight(2);
    beginShape(); 
    PVector pI = points.get(0); 
    for (int j=1; j<points.size(); j++) {
      PVector pJ = points.get(j);

      float dx = pJ.x - pI.x;
      float dy = pJ.y - pI.y;
      float dh = sqrt(dx*dx + dy*dy); 

      if (j==1) {
        float px = pI.x + offset * dy/dh;
        float py = pI.y - offset * dx/dh;
        vertex(px, py);
      }

      if ((j==(points.size()-1)) || (dh > minPointDist)) {
        float px = pJ.x + offset * dy/dh;
        float py = pJ.y - offset * dx/dh;
        vertex(px, py);
        pI = points.get(j); // swap
      }
    }
    endShape();
  }

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

//-----------------------------------------
void mousePressed() {
  points.clear();
  points.add(new PVector(mouseX, mouseY, 0));
}

//-----------------------------------------
void mouseDragged() {
  points.add(new PVector(mouseX, mouseY, 0));
}

//-----------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("parallel_polyline.png");
  } else if (key == 's') {
    // smooth

    if (points.size() > 3) {

      // Make blurred copy
      ArrayList<PVector> pointsTmp; 
      pointsTmp = new ArrayList<PVector>();
      PVector p0 = points.get(0); 
      pointsTmp.add( new PVector(p0.x, p0.y)); 
      for (int j=1; j<(points.size()-1); j++) {
        PVector pi = points.get(j-1); 
        PVector pj = points.get(j); 
        PVector pk = points.get(j+1);

        float ax = (pi.x + pj.x + pk.x)/3.0; 
        float ay = (pi.y + pj.y + pk.y)/3.0; 
        pointsTmp.add( new PVector( ax, ay));
      }
      PVector pLast = points.get(points.size()-1); 
      pointsTmp.add( new PVector(pLast.x, pLast.y));

      // Copy back
      for (int i=0; i<points.size(); i++) {
        points.get(i).set(pointsTmp.get(i));
      }
    }

  } else {
    points.clear();
  }
}
