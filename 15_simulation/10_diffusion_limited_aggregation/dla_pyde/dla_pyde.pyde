########################################
# "Diffusion-Limited Aggregation"      #
# Exercise on page 177 of CCM          #
# demo code by Lingdong Huang          #
########################################

map = [];   # an array for holding state of all pixels

batch = 16; # number of simulation iterations for each screen update

# an iteration of DLA:
# - spawn a particle
# - check if it has a neighbor with on-state
#   * yes -> turn on the pixel and exit
#   * no  -> roam around and repeat
def iteration():
  global map
  x = floor(random(width));
  y = floor(random(height));

  while (True):
    # check border condition
    # here we exclude a 1px border to simplify neighbor checking
    if (x <= 0 or x >= width-1 or y <= 0 or y>= height-1):
      return;
    
    # Moore neighborhood (8-connected):
    dirs = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]];

    # see if a neighbor is "on", so we can "stick" onto it
    for i in range(len(dirs)):
      if (map[(y+dirs[i][1])*width+(x+dirs[i][0])]):
        map[y*width+x]=True;
        return;
      
    # pick a random direction to roam toward
    dir = dirs[floor(random(len(dirs)))];
    x += dir[0]
    y += dir[1]

#--------------------------------------------

def setup():
  global map
  size(512,512);

  map = [False for _ in range(width*height)]
  
  # turn on center pixel, so the first particle
  # can have something to stick onto.
  # try initializing with another pattern, 
  # e.g. a circle or a binary image, for fun results
  map[height/2*width+width/2]=1;

  


#--------------------------------------------

def draw():
  # run the simulation
  for i in range(batch): iteration();
  
  # update the canvas
  
  loadPixels();
  
  for i in range(len(pixels)):
    pixels[i] = 0xFFFFFFFF if map[i] else 0xFF000000;
  
  updatePixels();
