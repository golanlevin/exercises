class LineHand {
  ArrayList<PVector> points;
  
  LineHand (PVector pa, PVector pb) {
    float distance = PVector.dist(pa, pb);
    int n = int(distance/30); // number of points
    points = new ArrayList<PVector>();
    points.add(pa);
    for (int i = 1; i < n; i++) {
      float dx =  (pb.x-pa.x)*i/n + (randomGaussian()-0.5)*3;
      float dy =  (pb.y-pa.y)*i/n + (randomGaussian()-0.5)*3;
      PVector newP = new PVector(pa.x + dx, pa.y + dy);
      points.add(newP);
    }
    points.add(pb);
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
    endShape();
  }

}
