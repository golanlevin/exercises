import rita.*;

// Ref: https://rednoise.org/rita/reference/RiTa/RiTa.isRhyme/index.php

PFont myFont;
RiLexicon lexicon;

BufferedReader reader;
PrintWriter debugWriter;
PrintWriter rhymeWriter;

String rhymes;

float margin = 100;

void setup() {
  size(800, 800);
  background(253);
  textFont(loadFont("CenturySchoolbook-60.vlw"), 72);
  fill(0);

  rhymes = "";
  
  //System.out.println("Setting up Rita.");

  lexicon = new RiLexicon();
  
  reader = createReader("little_women.txt");
  //debugWriter = createWriter("debug.txt"); 
  
  rhymeWriter = createWriter("rhymes.txt");
  
  readAndGetRhymes(30000);
  
}

void draw() {
  text(rhymes, margin, margin, width-2*margin, height-2*margin);
  noLoop();
}

void readAndGetRhymes(int maxLen) {
  println("Reading and cleaning...");
  
  String line;
  String paragraph = "";
  int accum = 0;
  
  try {
    line = reader.readLine();
    accum += line.length();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  
  while (line != null && accum < maxLen) {
    if (line.length() < 2) {
      // new paragraph
      getRhymes(paragraph);
      //debugWriter.print(paragraph + "\n");
      paragraph = "";
    } else {
      paragraph += " " + line.trim();
    }
    
    accum += line.length();
    try {
      line = reader.readLine();
    } catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
  }
  
  println("Finished reading.");
  //debugWriter.flush(); 
  //debugWriter.close();
  
  rhymeWriter.flush(); // Writes the remaining data to the file
  rhymeWriter.close(); // Finishes the file
}

StringList getRhymes(String line) {
  
  // take out all special characters
  String cleaned = (line.replaceAll("[^0-9a-zA-Z., ]+", ""));
  
  // split into a list of short sentences
  StringList sentences = new StringList();
  int fromIndex = 0;
  int nextComma = cleaned.indexOf(",", fromIndex);
  int nextPeriod = cleaned.indexOf(".", fromIndex);
  
  while (nextComma != -1 || nextPeriod != -1) {
    if (nextComma != -1 && nextPeriod != -1){
      if (nextComma < nextPeriod) {
        sentences.append((cleaned.substring(fromIndex, nextComma+1)).trim());
        fromIndex = nextComma+1;
        nextComma = cleaned.indexOf(",", fromIndex);
      } else {
        sentences.append((cleaned.substring(fromIndex, nextPeriod+1)).trim());
        fromIndex = nextPeriod+1;
        nextPeriod = cleaned.indexOf(".", fromIndex);
      }
    } else if (nextComma != -1) {
        sentences.append((cleaned.substring(fromIndex, nextComma+1)).trim());
        fromIndex = nextComma+1;
        nextComma = cleaned.indexOf(",", fromIndex);
    } else {
        sentences.append((cleaned.substring(fromIndex, nextPeriod+1)).trim());
        fromIndex = nextPeriod+1;
        nextPeriod = cleaned.indexOf(".", fromIndex);
    }
  }
  
  
  StringList result = new StringList();
  
  // check if any of the consecutives rhyme
  for (int i = 1; i < sentences.size(); i++) {
    String phrase1 = sentences.get(i-1).replaceAll("[^0-9a-zA-Z ]+", "");
    String phrase2 = sentences.get(i).replaceAll("[^0-9a-zA-Z ]+", "");
    String[] phrase1_arr = phrase1.split(" ");
    String[] phrase2_arr = phrase2.split(" ");
    String lastword1 = phrase1_arr[phrase1_arr.length-1].toLowerCase();
    String lastword2 = phrase2_arr[phrase2_arr.length-1].toLowerCase();
    String firstWord = phrase1_arr[0];
    if (RiTa.isRhyme(lastword1, lastword2)) {
      if (Character.isUpperCase(firstWord.charAt(0)) && 
        phrase1_arr.length > 3 && phrase2_arr.length > 3) {
        rhymeWriter.println(sentences.get(i-1));
        rhymeWriter.println(sentences.get(i));
        rhymeWriter.println();
        rhymes += sentences.get(i-1) + "\n\n" + sentences.get(i) + "\n\n";
      }
    } 
  }
  
  return result;
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("rhyming_couplets.png");
  }
}
