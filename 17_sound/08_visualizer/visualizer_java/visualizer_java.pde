
byte bytes[];
void setup() {
  size(800, 800, FX2D); 
  String filename = "beat_8bitsigned.raw";
  bytes = loadBytes(filename);
  smooth(); 
}

void draw() {
  background(253); 

  if (bytes.length > 0) {
    int nBytes = bytes.length;//)/8;
    float cx = width/2; 
    float cy = height/2;
    float V = map(bytes[0], -128, 127, -1, 1); 
 
    noFill(); 
    stroke(0); 
    strokeWeight(3); 
    strokeJoin(ROUND);
    beginShape(); 
    
    float A = 0.8;//map(mouseX, 0,width, 0,1); 
    float B = 1.0-A;
    float R = 75; 
    int skip = 32; 
    float wrap = 8.04;
    println(mouseX);
    
    for (int i=0; i<nBytes; i+=skip) {
      float t = map(i, 0, nBytes, 0, wrap*TWO_PI); 
      float b = (map(bytes[i], -128, 127, -1, 1)); 

      V = b; 
      float RR = map(i, 0, nBytes, 75, 350); 
      float r = RR + map(V, -1,1, -60,60); 
      R = A*R + B*r;
      
      float x = cx + R*cos(t); 
      float y = cy + R*sin(t);
      vertex(x, y);
    }
    endShape();
  }
}

void keyPressed(){
 if (key == ' '){
   saveFrame("sound_visualizer.png"); 
 }
}
