class EllipseHand {
  ArrayList<PVector> points;
  
  EllipseHand (PVector p1, PVector p2) {
    PVector center = p1;
    float radius = PVector.dist(p1, p2);
    points = new ArrayList<PVector>();
    
    int n = max(2, int(PI*2*radius/30));
    
    for (int i = 0; i < n; i++) {
      float r = 2*PI * i/n;
      PVector p = new PVector(center.x + radius * cos(r) + (randomGaussian()-0.5)*3, 
                              center.y + radius * sin(r) + (randomGaussian()-0.5)*3);
      points.add(p);
    }
  }

  void show() {
    noFill();
    stroke(0);
    strokeWeight(8);
    beginShape();
    PVector p = points.get(0);
    curveVertex(p.x, p.y);
    for (int i = 0; i < points.size(); i++) {
      p = points.get(i);
      curveVertex(p.x, p.y);
    }
    p = points.get(points.size()-1);
    curveVertex(p.x, p.y);
    p = points.get(0);
    curveVertex(p.x, p.y);
    curveVertex(p.x, p.y);
    endShape();
  }
  
}
