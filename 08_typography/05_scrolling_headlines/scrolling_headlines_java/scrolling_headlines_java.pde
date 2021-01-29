PFont myFont; 
float px = 127; 

void setup() {
  size(800, 800);
  myFont = createFont("FranklinGothic-Medium", 72); 
  textFont(myFont); 
}

void draw() {
  background(253); 
  fill(0);
  String headline ="A Crisis That Began With an Image of Police Violence Keeps Providing More"; 
  
  int N = 10; 
  for (int i=0; i<=N; i++){
    float g = map(i, 0, N, 255, 200); 
    if (i == N) g = 0; 
    fill (g);
    float tx = map(i, 0, N, 0, -127) + px; 
    float ty = map(i, 0, N, height/4, height/2); 
    text(headline, tx, ty); 
  }
  px--; 
  if (abs(px) > textWidth(headline)){
    px = 0; 
  }
}

void keyPressed(){
  if (key == ' '){
    saveFrame("scrolling_text.png"); 
  }
}
