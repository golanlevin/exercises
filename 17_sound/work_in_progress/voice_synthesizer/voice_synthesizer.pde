PFont myFont; 

byte bytes[];
void setup(){
  size(800, 800); 
  String filename = "voice_raw_8bit_signed.raw";
  bytes = loadBytes(filename); 
  
  myFont = loadFont("OCRAStd-96.vlw");
  textFont(myFont, 128); 
}

void draw(){
  background(253); 
  
  if (bytes.length > 0){
    int nBytes = bytes.length;
    
    noFill(); 
    stroke(0); 
    strokeWeight(2); 
    strokeJoin(ROUND);
    beginShape(); 
    for (int i=0; i<nBytes; i++){
      float x = map(i, 0, nBytes, width*0.1, width*0.9); 
      float y = map(bytes[i], -128, 127, height*0.20, height*0.50); 
      vertex(x, y); 
    }
    endShape(); 
  }
  
  fill(0); 
  noStroke(); 
  textAlign (CENTER, BASELINE); 
  text("TE  GA", width/2, height*0.75); 
}

void keyPressed(){
  if (key == ' '){
    saveFrame("synthetic_voice.png"); 
  }
}
