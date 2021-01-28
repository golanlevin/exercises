
// program works (computes nGrams) but is unfinished; does not currently sort. 


void setup() {
  size(800, 800); 
  noLoop(); 

  String bigrams[] = {
    "35 NOT LIKE", 
    "34 I DO", 
    "34 DO NOT", 
    "33 LIKE THEM", 
    "29 IN A", 
    "21 EAT THEM", 
    "18 WITH A", 
    "18 NOT IN", 
    "15 I WILL", 
    "14 I WOULD", 
    "14 THEM IN", 
    "13 WOULD NOT", 
    "12 WOULD YOU", 
    "11 EGGS AND", 
  };
  
  
  PFont myTextFont = createFont("Century", 46); 
  PFont myNumberFont = createFont("Helvetica-Bold", 46); 
  
  background(255); 
  
  fill(0); 
  int nBigrams = bigrams.length;
  int nBigramsH = bigrams.length / 2;
  for (int i=0; i<nBigrams; i++){
    String parts[] = split(bigrams[i], ' '); 
    float tx = 120; 
    float ty = 90+i*50;
    
    textFont(myNumberFont);
    textAlign(RIGHT);
    text(parts[0], tx, ty);
    
    textFont(myTextFont);
    textAlign(LEFT);
    text(parts[1].toLowerCase() + " " + parts[2].toLowerCase(), tx+30, ty);
  }
}

void keyPressed(){
  if (key == ' '){
    saveFrame("bigram_calculator.png"); 
  }
}


void draw() {
  ;
}


//=============================================
void computeNGrams() {

  ArrayList<Ngram> ngrams; 
  ngrams = new ArrayList<Ngram>(); 
  int N = 5; 

  String document[] = loadStrings("green_eggs_and_ham.txt"); 
  for (int i=0; i<document.length; i++) {
    String aLine = document[i]; 
    if (aLine.length() > 0) {
      String words[] = splitTokens(aLine, " ,.!?"); 

      for (int j=0; j<(words.length-(N-1)); j++) {

        String ws[] = new String[N]; 
        for (int k=0; k<N; k++) {
          ws[k] = trim(words[j+k]);
        }


        boolean bFound = false;
        for (int k=0; k<ngrams.size(); k++) {
          if (!bFound && ngrams.get(k).isEqual(ws)) {
            ngrams.get(k).count++;
            bFound = true;
          }
        }

        if (bFound == false) {
          println(ws);
          ngrams.add(new Ngram(N, ws));
        }
      }
    }
  }

  for (int k=0; k<ngrams.size(); k++) {
    println(ngrams.get(k).toString());
  }
}







class Ngram {
  String words[];
  int N;
  int count; 

  Ngram (int n, String ws[]) {
    N = n; 
    count = 1; 
    words = new String[N]; 
    for (int i=0; i<n; i++) {
      words[i] = ws[i];
    }
  }


  boolean isEqual(String ws[]) {
    boolean out = true; 
    for (int i=0; i<N; i++) {
      if (words[i].equals(ws[i]) == false) {
        out = false;
      }
    }
    return out;
  }

  String toString() {
    String out = ""; 
    for (int i=0; i<N; i++) {
      out += words[i] + "\t";
    }
    out += (""+ count); 

    return out;
  }
}
