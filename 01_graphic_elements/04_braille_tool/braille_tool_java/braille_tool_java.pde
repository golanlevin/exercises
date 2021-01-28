int A = 0b000001;
int B = 0b000011;
int C = 0b001001;
int D = 0b011001;
int E = 0b010001; 
int F = 0b001011; 
int G = 0b011011; 
int H = 0b010011; 
int I = 0b001010; 
int J = 0b011010; 
int K = 0b000101; 
int L = 0b000111; 
int M = 0b001101; 
int N = 0b011101; 
int O = 0b010101; 
int P = 0b001111; 
int Q = 0b011111; 
int R = 0b010111; 
int S = 0b001110; 
int T = 0b011110; 
int U = 0b100101; 
int V = 0b100111;
int W = 0b111010; 
int X = 0b101101; 
int Y = 0b111101; 
int Z = 0b110101; 
int alphabet[] = {A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z};


//  Braile dimensions (in inches, using average of max and min)
//  Ref: https://www.avalisway.com/resources/ada-raised-text-braille-requirements
float dotBaseDiameter = (0.059 + 0.063)/2; // base diameter of any individual dot
float distBtwDot = (0.090 + 0.100)/2; // distance between dots in the same cell
float distBtwCellH = (0.241 + 0.300)/2; // distance between corresponding dots in adjacent cells
float distBtwCellV = (0.395 + 0.400)/2; // distance between corresponding dots from one cell directly below
float dotHeight = (0.025 + 0.037)/2; // dot height

float scale = 550;

void setup() {
  size(800, 800); 
  noLoop();
  println(alphabet);
}

void draw() {
  background(253); 

  String[] str = new String[2];
  str[0] = "HELLO";
  str[1] = "WORLD";
  float marginLeft = (width-((str[0].length()-1)*distBtwCellH + distBtwDot)*scale)/2;
  float marginTop = (height-((str.length-1)*distBtwCellV+distBtwDot*2)*scale)/2;

  renderBraille(str, marginLeft, marginTop); 
}

void renderBraille(String[] str, float mLeft, float mTop) {
  ellipseMode(CENTER); 
  noStroke(); 

  for (int i = 0; i < str.length; i++) {
    String word = str[i];
    word = word.toUpperCase(); 
    int nChars = word.length();
    
    for (int j=0; j<nChars; j++) {
      char c = word.charAt(j);
      int charIndex = c - 'A'; 
      int binaryPattern = alphabet[charIndex];
      
      pushMatrix();
      translate(mLeft + j*distBtwCellH*scale, mTop + i*distBtwCellV*scale); 
      
      for (int b = 0; b < 6; b++) {
        float px = int(b/3) * distBtwDot * scale;
        float py = int(b%3) * distBtwDot * scale;
        
        fill(0);
        ellipse(px, py, dotBaseDiameter*scale, dotBaseDiameter*scale);
        
        int mask = 1 << b;
        if ((binaryPattern & mask) == 0) {
          // not a raised dot -> draw a blank dot
          fill(255); 
          ellipse(px, py, dotBaseDiameter*scale-8, dotBaseDiameter*scale-8);
        }
      }
      
      popMatrix();
    } 
  }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("braille_tool.png");
  }
}
