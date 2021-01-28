//////////////////////////////////////////
// "Diffusion-Limited Aggregation"      //
// Exercise on page 177 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

boolean[] map;  // an array for holding state of all pixels

int batch = 16; // number of simulation iterations for each screen update

// an iteration of DLA:
// - spawn a particle
// - check if it has a neighbor with on-state
//   * yes -> turn on the pixel and exit
//   * no  -> roam around and repeat
void iteration(){
  int x = (int)random(width);
  int y = (int)random(height);

  while (true){
    // check border condition
    // here we exclude a 1px border to simplify neighbor checking
    if (x <= 0 || x >= width-1 || y <= 0 || y>= height-1){
      return;
    }
    // Moore neighborhood (8-connected):
    int[] neighbors = {
      (y-1)*width+x-1, (y-1)*width+x, (y-1)*width+x+1,
      (y  )*width+x-1,                (y  )*width+x+1,
      (y+1)*width+x-1, (y+1)*width+x, (y+1)*width+x+1
    };
    // see if a neighbor is "on", so we can "stick" onto it
    for (int i = 0; i < neighbors.length; i++){
      if (map[neighbors[i]]){
        map[y*width+x]=true;
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
  size(512,512);
  map = new boolean[width*height];
  
  // turn on center pixel, so the first particle
  // can have something to stick onto.
  // try initializing with another pattern, 
  // e.g. a circle or a binary image, for fun results
  map[height/2*width+width/2]=true;
  
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
}
