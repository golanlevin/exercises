// 

int lastResetTime; 

XML xml;
ArrayList<Node> nodes;
ArrayList<Link> links; 


//---------------------------------------------
void setup() {
  size(800, 800, FX2D); 
  lastResetTime = millis();  
  smooth(); 

  loadNetwork("monkey_relations.xml");
}


color getMappedColor(float val01) {
  float phase = map(mouseX, 0, width, 0, TWO_PI); 
  //float phase = 0 - HALF_PI;
  float valPi = val01 * PI; 
  float cr = 255 * (0.5 + 0.25*cos(valPi)); 
  float cg = 255 * (0.50 + 0.25*cos(valPi + phase));  
  float cb = 127;
  color c = color(cr, cg, cb); 
  return c;
}


void draw() {

  background(253); 


  int nNodes = nodes.size();
  float marginA = 0;
  float marginB = 0; 
  float maxWeight = 0; 
  for (int i=0; i<links.size(); i++) {
    Link L = links.get(i); 
    float weight = L.weight; 
    if (weight > maxWeight) {
      maxWeight = weight;
    }
  }



  float matrixW = (width - marginB - marginA);
  float matrixH = (height - marginB - marginA);
  fill(0); 
  rect(marginA, marginA, matrixW, matrixH); 

  if ((maxWeight > 0) && (nNodes > 0)) {
    float pw = (width - marginB - marginA)/ (float) nNodes;
    float ph = (height - marginB - marginA)/ (float) nNodes;

    for (int i=0; i<links.size(); i++) {
      Link L = links.get(i); 
      int sid = L.sid;
      int tid = L.tid;

      float weight = L.weight;
      float val = map(weight, 0, maxWeight, 1, 0); 
      val = pow(val, 1.5); 
      fill(val*255); 

      float sidx = map(sid, 0, nNodes, marginA, width-marginB);
      float tidy = map(tid, 0, nNodes, marginA, height-marginB);
      rect(sidx, tidy, pw, ph);
    }
  }




  // draw a white grid
  stroke(0,0,0, 60); 
  strokeWeight(1); 
  for (int i=0; i<=nNodes; i++) {
    float px = map(i, 0, nNodes, marginA, width-marginB);
    float py = map(i, 0, nNodes, marginA, height-marginB);
    line(px, marginA, px, height-marginB); 
    line(marginA, py, width-marginB, py);
  }
}




















float DAMPING = 0.975; 
float ATTRACTION_FORCE = 7.5; 
float REPULSION_FORCE = -1.5; 
float CENTERING_FORCE  = 5.0; 
float NEIGHBORHOOD_SIZE = 128; 
float PERSONAL_SPACE = 64; 

//---------------------------------------------
void drawGraph() {
  background(253);

  if (mousePressed) {
    ATTRACTION_FORCE = map(mouseX, 0, width, 0, 1) * 10; 
    REPULSION_FORCE =  map(mouseY, 0, height, 0, 1) * -10; 
    println(ATTRACTION_FORCE + "\t" + REPULSION_FORCE);
  }

  // For every Link, pull its nodes closer together
  for (int i=0; i<links.size(); i++) {
    links.get(i).attractNodesTogether();
  }

  // Mutually repel all Nodes (n^2) 
  for (int i=0; i<nodes.size(); i++) {
    for (int j=0; j<i; j++) {
      repelTwoNodes(i, j);
    }
  }

  // Attract all Nodes to center of screen
  for (int i=0; i<nodes.size(); i++) {
    nodes.get(i).attractToPosition(width/2, height/2);
  }

  // Apply friction and update positions via Euler integration
  for (int i=0; i<nodes.size(); i++) {
    nodes.get(i).update();
  }

  displayNetwork();
}

//---------------------------------------------
void displayNetwork() {
  for (int i=0; i<nodes.size(); i++) {
    nodes.get(i).draw(); // Draw all Nodes
  }

  for (int i=0; i<links.size(); i++) {
    links.get(i).draw(); // Draw all Links
  }
}



//---------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("social_network_matrix.png");
  } else {
    resetForceDirectedLayout();
  }
}

//---------------------------------------------
void resetForceDirectedLayout() {
  lastResetTime = millis(); 
  for (int i=0; i<nodes.size(); i++) {
    float rx = random(0.49, 0.51) * width; 
    float ry = random(0.49, 0.51) * height; 
    nodes.get(i).pos.set(rx, ry); 
    nodes.get(i).vel.set(0, 0);
  }
}

//---------------------------------------------
void loadNetwork(String filename) {
  xml = loadXML(filename);

  XML[] xmlA = xml.getChildren("MetaNetwork");
  XML[] xmlB = xmlA[0].getChildren("nodes");
  XML[] xmlC = xmlB[0].getChildren("nodeclass");
  XML[] nodesXML = xmlC[0].getChildren("node"); 

  XML[] xmlD = xmlA[0].getChildren("networks"); 
  XML[] xmlE = xmlD[0].getChildren("network"); 
  XML[] linksXML = xmlE[1].getChildren("link");  

  nodes = new ArrayList<Node>(); 
  for (int i = 0; i < nodesXML.length; i++) {
    int id = nodesXML[i].getInt("id")-1;
    String name = ""+id;
    Node N = new Node(id, name);
    nodes.add(N);
  }

  links = new ArrayList<Link>(); 
  for (int i = 0; i < linksXML.length; i++) {
    int sourceId = linksXML[i].getInt("source");
    int targetId = linksXML[i].getInt("target");
    int weight   = linksXML[i].getInt("value");
    println(i + " " + weight); 
    Node sourceNode = nodes.get(sourceId-1);
    Node targetNode = nodes.get(targetId-1);
    Link L = new Link(sourceNode, targetNode);
    L.weight = weight;
    links.add(L);
  }

  resetForceDirectedLayout();
}




//---------------------------------------------
class Node {
  int id; 
  String name; 

  PVector pos; 
  PVector vel;

  Node(int i, String n) {
    id = i;
    name = n;
    pos = new PVector(0, 0); 
    vel = new PVector(0, 0);
  }
  void draw() {
    noStroke(); 
    fill(0, 0, 0); 
    ellipse(pos.x, pos.y, 16, 16);
  }
  String toString() {
    return (id + "\t" + name);
  }

  void attractToPosition(float px, float py) {
    float dx = px - pos.x; 
    float dy = py - pos.y; 
    float dh2 = (dx*dx + dy*dy);
    float dh = sqrt(dh2); 
    if (dh > NEIGHBORHOOD_SIZE) {
      float fx = CENTERING_FORCE * (dx/dh) * (1.0/dh);
      float fy = CENTERING_FORCE * (dy/dh) * (1.0/dh);
      applyForce(fx, fy);
    }
  }

  void applyForce(float fx, float fy) {
    vel.x += fx; 
    vel.y += fy;
  }
  void update() {
    vel.x *= DAMPING; 
    vel.y *= DAMPING; 
    pos.x += vel.x;
    pos.y += vel.y;
  }
}

//---------------------------------------------
class Link {
  int sid; 
  int tid; 
  Node source; 
  Node target; 
  boolean bIsDirected;
  float weight;

  Link (Node s, Node t) {
    source = s; 
    target = t;
    sid = source.id; 
    tid = target.id;
    bIsDirected = false;
    weight = 1.0;
  }
  String toString() {
    return (sid + "\t" + tid);
  }

  void attractNodesTogether() {
    attractTwoNodes(sid, tid);
  }

  void draw() {
    stroke(0); 
    strokeWeight(2); 
    line(source.pos.x, source.pos.y, target.pos.x, target.pos.y);
  }
}



//---------------------------------------------
void attractTwoNodes(int s, int t) {
  // Currently mutual (non-directed) 
  Node ns = nodes.get(s);
  Node nt = nodes.get(t);

  float sx = ns.pos.x; 
  float sy = ns.pos.y; 
  float tx = nt.pos.x; 
  float ty = nt.pos.y; 
  float dx = tx - sx; 
  float dy = ty - sy; 
  float dh2 = (dx*dx + dy*dy); 
  float dh = sqrt(dh2); 

  float fx = 0; 
  float fy = 0; 
  if (dh > PERSONAL_SPACE) {
    fx = ATTRACTION_FORCE * (dx/dh) * (1.0/dh);
    fy = ATTRACTION_FORCE * (dy/dh) * (1.0/dh);
    ns.applyForce( fx, fy);
    nt.applyForce(-fx, -fy);
  }
}



void repelTwoNodes(int s, int t) {
  // 1/r

  Node ns = nodes.get(s);
  Node nt = nodes.get(t);

  float sx = ns.pos.x; 
  float sy = ns.pos.y; 
  float tx = nt.pos.x; 
  float ty = nt.pos.y; 
  float dx = tx - sx; 
  float dy = ty - sy; 
  float dh2 = (dx*dx + dy*dy); 
  float dh = sqrt(dh2); 

  // Don't bother repelling if they are further apart than 100 pixels
  if ((dh > 1.0) && (dh < NEIGHBORHOOD_SIZE)) {

    float tfrac = min(1.0, (millis()-lastResetTime)/20000.0);
    float timeRamp = pow(tfrac, 2.0); 

    float neighFrac = 1.0 - (dh/NEIGHBORHOOD_SIZE);
    float fx = timeRamp * REPULSION_FORCE * (dx/dh) * neighFrac * (1.0/dh);
    float fy = timeRamp * REPULSION_FORCE * (dy/dh) * neighFrac * (1.0/dh);
    ns.applyForce( fx, fy);
    nt.applyForce(-fx, -fy);
  }
}
