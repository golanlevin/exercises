PFont myFonts[];   

void setup() {
  size(800, 800); 
  
  println("Creating fonts..."); 
  myFonts = new PFont[3];
  myFonts[0] = createFont("Times-Bold", 80);
  myFonts[1] = createFont("Courier-Bold", 80);
  myFonts[2] = createFont("Helvetica-Bold", 80);
  noLoop();
}


void draw() {
  background(253); 

  String phrase = "STEAL\nTHIS\nBOOK"; 
  int nChars = phrase.length(); 

  fill(0); 
  textAlign(LEFT, TOP);

  float xinit = 120;
  float tx = xinit;
  float ty = 120; 
  for (int i=0; i<nChars; i++) {
    char ithChar = phrase.charAt(i); 
    if (ithChar == '\n') {
      ty += 200;  
      tx = xinit;
    } else {
      int r = (int)floor(random(2.99999)); 
      textFont(myFonts[r], random(120, 220)); 
      text(ithChar, tx, ty); 
      tx += textWidth(ithChar);
    }
  }
}


void keyPressed() {
  saveFrame("ransom_letter.png");
}
