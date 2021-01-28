

String documentA = "Given their physiological requirements, \nlimited dispersal abilities, and \nhydrologically sensitive habitats, \namphibians are likely to be highly \nsensitive to future climactic changes.";
// "Projected Climate Impacts for the Amphibians of the Western Hemisphere"
// Joshua J Lawler, Sarah L Shafer, Betsy A Bancroft, Andrew R Blaustein
// PMID: 20121840 DOI: 10.1111/j.1523-1739.2009.01403.x

String documentB = "Frog and Toad ate many cookies, one \nafter another. “You know, Toad,” said \nFrog, with his mouth full, “I think we \nshould stop eating. We will soon be sick.” \n“You are right,” said Toad."; 
// Frog and Toad, Arnold Lobel. 

PFont myTextFont; 
PFont myNumberFont;

void setup() {
  size(800, 800);
  noLoop(); 

  myTextFont = createFont("Century", 38); 
  myNumberFont = createFont("Helvetica-Bold", 105); 

  background(255); 
  fill(0); 

  float ty = 75; 
  textFont (myTextFont, 38);
  textLeading(40); 
  text(documentA, 50, ty); 
  text(documentB, 50, ty + height/2); 


  float avgWordLengthA = getAverageWordLength(documentA); 
  float avgWordLengthB = getAverageWordLength(documentB); 

  textFont (myNumberFont, 105); 
  text( nf(avgWordLengthA, 1, 2), 50, ty + 275); 
  text( nf(avgWordLengthB, 1, 2), 50, ty + height/2 + 275);
}

//------------------------------------------------------------
float getAverageWordLength (String document) {
  float sum = 0; 
  float out = 0;

  String tokens[] = splitTokens(document, "“”., \n");
  int nTokens = tokens.length;
  if (nTokens > 0) {
    for (int i=0; i<nTokens; i++) {
      sum += tokens[i].length();
    }
    out = sum/nTokens; 
  }
  return out; 
}





//----------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("average_word_length.png");
  }
}

//----------------------------------------
void draw() {
  ;
}
