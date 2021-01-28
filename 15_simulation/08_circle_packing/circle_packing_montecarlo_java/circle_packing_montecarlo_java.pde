//////////////////////////////////////////
// "Circle Packing"                     //
// Exercise on page 177 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// this demo uses a Monte Carlo algorithm to
// optimize circle placement for maximum radii

int nProposals = 64;     // number of "proposals" for each iteration:
                         // pick the "best" circle among this number
                         // of candidates
float maxRadius = 100;   // maximum radius for each circle
boolean colorful = true; // paint circles with random colors?

// array for holding all the circles
ArrayList<Circle> circles = new ArrayList<Circle>();

// datastructure for a circle
class Circle implements Comparable<Circle>{
  float x, y, r;
  Circle(float _x, float _y, float _r){
    x = _x; y = _y; r = _r;
  }
  // for sorting circles by radius
  public int compareTo(Circle other) {
    return ((Float)r).compareTo((Float)other.r);
  }
}

// make a "proposal" for circle placement
Circle propose(){
  float x, y, r;
  
  // repeat until we have a circle with positive radius,
  // i.e. one that is not overlapping with anything
  do {
    x = random(width);
    y = random(height);
    // first, bound the radius with canvas borders
    r = min(maxRadius,min(min(x,width-x),min(y,height-y)));
    // then, bound the radius by computing distance to every other circle
    for (int i = 0; i < circles.size(); i++){
      float d = dist(x,y,circles.get(i).x,circles.get(i).y);
      r = min(r,d-circles.get(i).r);
      if (r<=0) break; // already invalid, give up early
    }
  } while (r <= 0);
  return new Circle(x,y,r);
}

// add a new circle by comparing a few proposals
float addCircle(){
  Circle[] proposals = new Circle[nProposals];
  for (int i = 0; i < nProposals; i++){
    proposals[i] = propose();
  }
  java.util.Arrays.sort(proposals);
  
  // we want the largest circle, which is
  // the last item in an array sorted ascendingly
  circles.add(proposals[nProposals-1]);
  return proposals[nProposals-1].r;
}

//--------------------------------------------

void setup(){
  size(640,480);
}

//--------------------------------------------

void draw(){
  if (colorful) background(150,130,170);
  stroke(0);

  if (addCircle()<=0.1){ 
    // even the best radius is small, so canvas 
    // is probably already full -- stop iterating
    noLoop();
  }
  
  // draw the circles
  
  for (int i = 0; i < circles.size(); i++){
    
    if (colorful) fill(250,
                       155+100*noise(circles.get(i).x*0.01,
                                     circles.get(i).y*0.01),
                       100+155*noise(circles.get(i).r*0.1));
         
    circle(circles.get(i).x,circles.get(i).y,circles.get(i).r*2);
  }
}
