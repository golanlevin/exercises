########################################
# "Circle Packing"                     #
# Exercise on page 177 of CCM          #
# demo code by Lingdong Huang          #
########################################

# this demo uses a Monte Carlo algorithm to
# optimize circle placement for maximum radii

nProposals = 64;     # number of "proposals" for each iteration:
                     # pick the "best" circle among this number
                     # of candidates
maxRadius = 100;     # maximum radius for each circle
colorful = True;     # paint circles with random colors?

# array for holding all the circles
circles = [];

# make a "proposal" for circle placement
def propose():
  x, y, r = 0,0,0;
  
  # repeat until we have a circle with positive radius,
  # i.e. one that is not overlapping with anything
  while True:
    x = random(width);
    y = random(height);
    # first, bound the radius with canvas borders
    r = min(maxRadius,min(min(x,width-x),min(y,height-y)));
    # then, bound the radius by computing distance to every other circle
    for i in range(len(circles)):
      d = dist(x,y,circles[i][0],circles[i][1]);
      r = min(r,d-circles[i][2]);
      if (r<=0): break; # already invalid, give up early
    
    if (r > 0):
      break;
  
  return (x,y,r);


# add a new circle by comparing a few proposals
def addCircle():
  proposals = [propose() for _ in range(nProposals)]
  proposals.sort(key=lambda x: x[2]);

  # we want the largest circle, which is
  # the last item in an array sorted ascendingly
  circles.append(proposals[-1]);
  return proposals[-1][2];


#--------------------------------------------

def setup():
  size(640,480);


#--------------------------------------------

def draw():
  if (colorful): background(150,130,170);
  stroke(0);

  if (addCircle()<=0.1):
    # even the best radius is small, so canvas 
    # is probably already full -- stop iterating
    noLoop();
  
  
  # draw the circles
  
  for i in range(len(circles)):
    
    if (colorful):fill(250,
                       155+100*noise(circles[i][0]*0.01,
                                     circles[i][1]*0.01),
                       100+155*noise(circles[i][2]*0.1));
         
    circle(circles[i][0],circles[i][1],circles[i][2]*2);
  
