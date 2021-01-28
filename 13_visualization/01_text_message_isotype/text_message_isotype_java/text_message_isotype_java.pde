
String svgFilenames[] = {
  "1F469-200D-1F9B1.svg", 
  "1F9D5.svg", 
  "1F469-200D-2695-FE0F.svg", 
  
  "1F9D1-200D-1F9B3.svg", 
  "1F9D1-200D-1F527.svg", 
  "1F9D4.svg",  
  "1F464.svg"
};

int peopleCounts[] = {
  4, 6, 3,  7, 2, 1, 5  
};

PShape peopleSvg[]; 

void setup() {
  noLoop();
  size(800, 800, FX2D);

  peopleSvg = new PShape[svgFilenames.length]; 
  for (int i=0; i<svgFilenames.length; i++) {
    peopleSvg[i] = loadShape(svgFilenames[i]);
  }
}

void draw() {
  background(253); 
  shapeMode(CENTER); 

  int pw = 116; 
  float marginL = width*0.14;
  float marginT = height*0.14; 
  float marginB = height - marginT; 
  int nPeople = peopleSvg.length;
  for (int i=0; i<nPeople; i++) {
    int nCols = peopleCounts[i]; 
    float py = map(i, 0, nPeople-1, marginT, marginB); 
    PShape svg = peopleSvg[i]; 
    
    for (int j=0; j<nCols; j++) {
      float px = marginL + j*(pw*0.80); 
      float ph = (svg.height / svg.width) * pw;  
      shape(svg, px, py, pw, ph);
    }
  }
}

//===================================
void keyPressed() {
  if (key == ' ') {
    saveFrame("text_message_isotype.png");
  }
}
