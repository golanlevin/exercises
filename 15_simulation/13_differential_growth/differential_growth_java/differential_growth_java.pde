// This code is by Alberto Giachino with suggestions from Frederik Vanhoutte
// From: http://www.codeplastic.com/2017/07/22/differential-line-growth-with-processing/
// Should be replaced!

// PARAMETERS
float _maxForce = 0.5; // Maximum steering force
float _maxSpeed = 15; // Maximum speed
float _desiredSeparation = 40;
float _separationCohesionRation = 1.02;
float _maxEdgeLen = 5;

DifferentialLine _diff_line;  

void keyPressed(){
  if (key == ' '){
    saveFrame("differential_growth.png");
  }
}

void setup() {
  size(600, 600, FX2D);
  _diff_line = new DifferentialLine(_maxForce, _maxSpeed, _desiredSeparation, _separationCohesionRation, _maxEdgeLen);
  float nodesStart = 30;
  float angInc = TWO_PI/nodesStart;
  float rayStart = 150;
  for (float a=0; a<TWO_PI; a+=angInc) {
    float x = width/2 + cos(a) * rayStart;
    float y = height/2 + sin(a) * rayStart;
    _diff_line.addNode(new Node(x, y, _diff_line.maxForce, _diff_line.maxSpeed));
  }
}
void draw() {
  background(255);
  stroke(0);
  strokeWeight(3.0); 
  _diff_line.run();
  _diff_line.renderLine();
}
class DifferentialLine {
  ArrayList<Node> nodes;
  float maxForce;
  float maxSpeed;
  float desiredSeparation;
  float sq_desiredSeparation;
  float separationCohesionRation;
  float maxEdgeLen;
  DifferentialLine(float mF, float mS, float dS, float sCr, float eL) {
    nodes = new ArrayList<Node>();
    maxSpeed = mF;
    maxForce = mS;
    desiredSeparation = dS;
    sq_desiredSeparation = sq(desiredSeparation);
    separationCohesionRation = sCr;
    maxEdgeLen = eL;
  }
  void addNode(Node n) {
    nodes.add(n);
  }
  void addNodeAt(Node n, int index) {
    nodes.add(index, n);
  }
  void run() {
    differentiate();
    growth();
  }
  void growth() {
    for (int i=0; i<nodes.size()-1; i++) {
      Node n1 = nodes.get(i);
      Node n2 = nodes.get(i+1);
      float d = PVector.dist(n1.position, n2.position);
      if (d>maxEdgeLen) { // Can add more rules for inserting nodes
        int index = nodes.indexOf(n2);
        PVector middleNode = PVector.add(n1.position, n2.position).div(2);
        addNodeAt(new Node(middleNode.x, middleNode.y, maxForce, maxSpeed), index);
      }
    }
  }
  void differentiate() {
    PVector[] separationForces = getSeparationForces();
    PVector[] cohesionForces = getEdgeCohesionForces();
    for (int i=0; i<nodes.size(); i++) {
      PVector separation = separationForces[i];
      PVector cohesion = cohesionForces[i];
      separation.mult(separationCohesionRation);
      nodes.get(i).applyForce(separation);
      nodes.get(i).applyForce(cohesion);
      nodes.get(i).update();
    }
  }
  PVector[] getSeparationForces() {
    int n = nodes.size();
    PVector[] separateForces=new PVector[n];
    int[] nearNodes = new int[n];
    Node nodei;
    Node nodej;
    for (int i=0; i<n; i++) {
      separateForces[i]=new PVector();
    }
    for (int i=0; i<n; i++) {
      nodei=nodes.get(i);
      for (int j=i+1; j<n; j++) {
        nodej=nodes.get(j);
        PVector forceij = getSeparationForce(nodei, nodej);
        if (forceij.mag()>0) {
          separateForces[i].add(forceij);        
          separateForces[j].sub(forceij);
          nearNodes[i]++;
          nearNodes[j]++;
        }
      }
      if (nearNodes[i]>0) {
        separateForces[i].div((float)nearNodes[i]);
      }
      if (separateForces[i].mag() >0) {
        separateForces[i].setMag(maxSpeed);
        separateForces[i].sub(nodes.get(i).velocity);
        separateForces[i].limit(maxForce);
      }
    }
    return separateForces;
  }
  PVector getSeparationForce(Node n1, Node n2) {
    PVector steer = new PVector(0, 0);
    float sq_d = sq(n2.position.x-n1.position.x)+sq(n2.position.y-n1.position.y);
    if (sq_d>0 && sq_d<sq_desiredSeparation) {
      PVector diff = PVector.sub(n1.position, n2.position);
      diff.normalize();
      diff.div(sqrt(sq_d)); //Weight by distacne
      steer.add(diff);
    }
    return steer;
  }
  PVector[] getEdgeCohesionForces() {
    int n = nodes.size();
    PVector[] cohesionForces=new PVector[n];
    for (int i=0; i<nodes.size(); i++) {
      PVector sum = new PVector(0, 0);      
      if (i!=0 && i!=nodes.size()-1) {
        sum.add(nodes.get(i-1).position).add(nodes.get(i+1).position);
      } else if (i == 0) {
        sum.add(nodes.get(nodes.size()-1).position).add(nodes.get(i+1).position);
      } else if (i == nodes.size()-1) {
        sum.add(nodes.get(i-1).position).add(nodes.get(0).position);
      }
      sum.div(2);
      cohesionForces[i] = nodes.get(i).seek(sum);
    }
    return cohesionForces;
  }
  void renderShape() {
    beginShape();
    for (int i=0; i<nodes.size(); i++) {
      vertex(nodes.get(i).position.x, nodes.get(i).position.y);
    }
    endShape(CLOSE);
  }
  void renderLine() {
    fill(128); 
    beginShape(); 
    for (int i=0; i<nodes.size(); i++) {
      PVector p1 = nodes.get(i).position;
      vertex(p1.x, p1.y);
    }
    endShape(CLOSE); 
    /*
    for (int i=0; i<nodes.size()-1; i++) {
      PVector p1 = nodes.get(i).position;
      PVector p2 = nodes.get(i+1).position;
      line(p1.x, p1.y, p2.x, p2.y);
      if (i==nodes.size()-2) {
        line(p2.x, p2.y, nodes.get(0).position.x, nodes.get(0).position.y);
      }
    }
    */
    
  }
}
class Node {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxForce;
  float maxSpeed;
  Node(float x, float y, float mF, float mS) {
    acceleration = new PVector(0, 0);
    velocity =PVector.random2D();
    position = new PVector(x, y);
    maxSpeed = mF;
    maxForce = mS;
  }
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.setMag(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    return steer;
  }
}
