class RectHand {
  LineHand topEdge;
  LineHand leftEdge;
  LineHand bottomEdge;
  LineHand rightEdge;
  
  RectHand (PVector p1, PVector p2) {
    PVector p1_ = new PVector(p1.x, p2.y);
    PVector p2_ = new PVector(p2.x, p1.y);
    
    topEdge = new LineHand(p1, p1_);
    leftEdge = new LineHand(p1_, p2);
    bottomEdge = new LineHand(p2, p2_);
    rightEdge = new LineHand(p2_, p1);    
  }
  
  void show() {
    topEdge.show();
    leftEdge.show();
    bottomEdge.show();
    rightEdge.show();
  }
}
