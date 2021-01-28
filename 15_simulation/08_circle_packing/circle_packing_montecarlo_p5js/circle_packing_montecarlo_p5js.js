//////////////////////////////////////////
// "Circle Packing"                     //
// Exercise on page 177 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// this demo uses a Monte Carlo algorithm to
// optimize circle placement for maximum radii

var nProposals = 64;     // number of "proposals" for each iteration:
                         // pick the "best" circle among this number
                         // of candidates
var maxRadius = 100;     // maximum radius for each circle
var colorful = true;     // paint circles with random colors?

// array for holding all the circles
var circles = [];

// make a "proposal" for circle placement
function propose(){
  var x, y, r;
  
  // repeat until we have a circle with positive radius,
  // i.e. one that is not overlapping with anything
  do {
    x = random(width);
    y = random(height);
    // first, bound the radius with canvas borders
    r = min(maxRadius,min(min(x,width-x),min(y,height-y)));
    // then, bound the radius by computing distance to every other circle
    for (var i = 0; i < circles.length; i++){
      var d = dist(x,y,circles[i].x,circles[i].y);
      r = min(r,d-circles[i].r);
      if (r<=0) break; // already invalid, give up early
    }
  } while (r <= 0);
  return {x,y,r};
}

// add a new circle by comparing a few proposals
function addCircle(){
  var proposals = [];
  for (var i = 0; i < nProposals; i++){
    proposals.push(propose());
  }
  proposals.sort((a,b)=>a.r-b.r);
  
  // we want the largest circle, which is
  // the last item in an array sorted ascendingly
  circles.push(proposals[nProposals-1]);
  return proposals[nProposals-1].r;
}

//--------------------------------------------

function setup(){
  createCanvas(640,480);
}

//--------------------------------------------

function draw(){
  if (colorful) background(150,130,170);
  stroke(0);

  if (addCircle()<=0.1){ 
    // even the best radius is small, so canvas 
    // is probably already full -- stop iterating
    noLoop();
  }
  
  // draw the circles
  
  for (var i = 0; i < circles.length; i++){
    
    if (colorful) fill(250,
                       155+100*noise(circles[i].x*0.01,
                                     circles[i].y*0.01),
                       100+155*noise(circles[i].r*0.1));
         
    circle(circles[i].x,circles[i].y,circles[i].r*2);
  }
}
