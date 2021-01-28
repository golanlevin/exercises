// 

PImage cursorImg; 
PFont myFont; 
int lastResetTime; 

XML xml;
ArrayList<Node> nodes;
ArrayList<Link> links; 

float DAMPING = 0.975; 
float ATTRACTION_FORCE = 7.5; 
float REPULSION_FORCE = -1.5; 
float CENTERING_FORCE  = 5.0; 
float NEIGHBORHOOD_SIZE = 128; 
float PERSONAL_SPACE = 64; 

//---------------------------------------------
void setup() {
  size(800, 800); 
  lastResetTime = millis(); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont, 60);

  loadNetwork("dolphin_relations.xml");
  resetForceDirectedLayout();
}


//---------------------------------------------
void draw() {
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

  if (millis() > 30000) {
    displayMouseNode();
    image(cursorImg, mouseX, mouseY, 15*6, 21*6);
  }
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
void displayMouseNode() {
  int closestNode = -1; 
  float minDist = 9999999; 
  for (int i=0; i<nodes.size(); i++) {
    float px = nodes.get(i).pos.x;
    float py = nodes.get(i).pos.y;
    float mouseDist = dist(px, py, mouseX, mouseY); 
    if (mouseDist < minDist) {
      minDist = mouseDist;
      closestNode = i;
    }
  }
  if ((closestNode != -1) && (minDist < PERSONAL_SPACE)) {
    String name = nodes.get(closestNode).name;

    float px = nodes.get(closestNode).pos.x;
    float py = nodes.get(closestNode).pos.y;
    noStroke();
    fill(0); 
    ellipse(px, py, 24, 24); 

    fill(0, 0, 0); 
    textAlign(RIGHT, CENTER); 
    text(name, px-32, py);
  }
}

//---------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("social_network_graph.png");
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
  XML[] linksXML = xmlE[0].getChildren("link"); 

  nodes = new ArrayList<Node>(); 
  for (int i = 0; i < nodesXML.length; i++) {
    int id = nodesXML[i].getInt("id");
    String name = nodesXML[i].getString("name");
    nodes.add(new Node(id, name));
  }

  links = new ArrayList<Link>(); 
  for (int i = 0; i < linksXML.length; i++) {
    int sourceId = linksXML[i].getInt("source");
    int targetId = linksXML[i].getInt("target");
    Node sourceNode = nodes.get(sourceId);
    Node targetNode = nodes.get(targetId);
    links.add(new Link(sourceNode, targetNode));
  }
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
