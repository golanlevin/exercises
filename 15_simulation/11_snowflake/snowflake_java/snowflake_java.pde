//////////////////////////////////////////
// "Snowflake Generator"                //
// or DLA with dihexagonal symmetry     //
// Exercise on page 177 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

int nSymmetry = 12;    // number of symmetric parts, must be even number: 2,4,6,8,10,12...
int batch = 16;        // number of simulation iterations for each screen update
int maxFrames = 500;   // stop before it becomes a mess after too many iters
float petalSweep = 1.0;// 0.0-1.0 sweep of flake petals

boolean[] map;  // an array for holding state of all pixels

// generate symmetric points
PVector[] symmetry(PVector v){
  PVector[] pts = new PVector[nSymmetry];
  // first the point is reflected about x axis
  pts[0] = v;
  pts[1] = new PVector(v.x,-v.y);
  // then the pair of points are rotated for all the axes
  for (int i = 0; i < nSymmetry/2-1; i++){
    pts[2+i*2  ] = pts[i*2  ].copy().rotate(PI*4/nSymmetry);
    pts[2+i*2+1] = pts[i*2+1].copy().rotate(PI*4/nSymmetry);
  }
  return pts;
}

// check out of bounds
boolean outOfBounds(int x, int y){
  return (x < 0 || x >= width || y < 0 || y>= height);
}

// an iteration of DLA:
// - spawn a particle
// - check if it has a neighbor with on-state
//   * yes -> turn on the pixel (and its symmetric counterparts) and exit
//   * no  -> roam around and repeat
void iteration(){
  
  // generate a random point in the "quadrant"
  // based on nSymmetry
  float angRange = PI/nSymmetry*2;
  float angMin = (1-petalSweep)/2;
  float angMax = angMin+petalSweep;
  float a = random(angMin*angRange,angMax*angRange);
  float d = random(min(width/2,height/2));
  int x = (int)(cos(a)*d)+width/2;
  int y = (int)(sin(a)*d)+height/2;

  while (true){
    if (outOfBounds(x,y)){
      return;
    }
    
    // try (un)commenting the block below
    // to disallow roaming into other "quadrants"
    // produces a slightly different look
    //float ang = atan2(y-height/2,x-width/2);
    //if (ang < 0 || angRange < ang){
    //  return;
    //}
    
    // Moore neighborhood (8-connected):
    int[][] neighbors = {
      {x-1,y-1},{x,y-1},{x+1,y-1},
      {x-1,y  },        {x+1,y  },
      {x-1,y+1},{x,y-1},{x+1,y+1},
    };
    
    
    // see if a neighbor is "on", so we can "stick" onto it
    for (int i = 0; i < neighbors.length; i++){
      int qx = neighbors[i][0];
      int qy = neighbors[i][1];
      if (!outOfBounds(qx,qy) && map[qy*width+qx]){
        PVector v = new PVector(x-width/2,y-height/2);
        
        // also turn on all the symmetric pixels
        PVector[] pts = symmetry(v);
        for (int j = 0; j < pts.length; j++){
          int px = (int)(pts[j].x+width/2);
          int py = (int)(pts[j].y+height/2);
          if (!outOfBounds(px,py))
            map[py*width+px]=true;

        }
        
        return;
      }
    }
    // pick a random direction to roam toward
    int dir = (int)random(8);
    switch (dir) {
      case 0: x--; break;
      case 1: x++; break;
      case 2: y--; break;
      case 3: y++; break;
      case 4: x--; y--; break;
      case 5: x++; y--; break;
      case 6: x--; y++; break;
      case 7: x++; y++; break;
    }
  }
}

//--------------------------------------------

void setup(){
  size(800,800);
  map = new boolean[width*height];
  
  // here we cheat by drawing a line on the canvas in advance
  // to kickstart the DLA
  // otherwise it won't look much like a snowflake
  for (int i = width/2+width/8; i < width-width/16; i++){
    
    // change the probability below for slightly diifferent looks
    if (random(1)<0.25){ 
      map[height/2*width+i] = true;
    }
  }
  
  
}

//--------------------------------------------

void draw(){
  // run the simulation
  for (int i = 0; i < batch; i++) iteration();
  
  // update the canvas
  
  loadPixels();
  
  for (int i = 0; i < pixels.length; i++)
    pixels[i] = map[i]?0xFFFFFFFF:0xFF000000;
  
  updatePixels();
  
  if (frameCount > maxFrames){
    noLoop();
  }
}
