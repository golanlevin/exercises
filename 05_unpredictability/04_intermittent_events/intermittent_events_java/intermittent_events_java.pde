

int happened[];
int historyLen; 

//--------------------------------------------
void setup(){
  size(800, 800, FX2D); 
  
  historyLen = width/4;
  happened = new int[historyLen];
}


//--------------------------------------------
void draw(){
  background(253); 
  
  noFill();
  stroke(0); 
  strokeWeight(4); 
  strokeJoin(ROUND); 
  
  beginShape(); 
  for (int i=0; i<historyLen; i++){
    int h = happened[(historyLen-1)-i];
    int x = (int)map(i, 0, historyLen-1, 0, width); 
    int y = (h == 0) ? height/2 : (height/2 - (height/8)); 
    vertex(x, y); 
  }
  endShape(); 
  
  float probability = 0.02;
  for (int i=historyLen-1; i>0; i--){
    happened[i] = happened[i-1];
  }
  int trigger = 0; 
  float doit = random(1.0); 
  if (doit < probability){
    trigger = 1; 
  }
  happened[0] = trigger;
}

//--------------------------------------------
void keyPressed(){
  if (key == ' '){
    saveFrame("intermittent_events_#####.png"); 
  }
}
