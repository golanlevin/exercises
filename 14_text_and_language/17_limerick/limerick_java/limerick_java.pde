// What's a limerick?
//   --> https://whvvugt.home.xs4all.nl/Archives_TCCMB/Limericks/Structure.html#:~:text=Limericks%20are%20short%20poems%20of,%3A%20da%2Dda%2DDA
// Currently not compiling, needs correction

import rita.*;

RiLexicon lexicon;

StringList locations_stress2;
StringList adjectives_stress2;
String[] lime;

int maxTries = 10000;

PFont font;
float margin = 80;

void setup() {
  size(800, 800);
  lexicon = new RiLexicon();
  lime = new String[5];
  
  font = loadFont("CenturySchoolbook-60.vlw");

  loadLocations();
  loadAdjectives();
  
  getLimerick();
}

void draw() {
  background(253);
  textFont(font, 48);
  textLeading(72);
  fill(0);
  noStroke();
  String toDraw = String.join("\n", lime);
  text(toDraw, margin, margin, width-2*margin, height-2*margin);
}

void getLimerick() {
  String r1 = getLine1();
  getLine2(r1);
  String r2 = getLine3();
  getLine4(r2);
  getLine5(r1);
}

String getLine1() {
  String[] words = {"There", "was", "a", "-", "*", "-", "-*"};
  
  String[] subjects = {"dude", "lad", "guy", "bro"};
  String[] c = {"in", "of", "from"};
  
  words[3] = RiTa.randomWord("jj", 1);//adjectives[floor(random(adjectives.length))];
  words[4] = subjects[floor(random(subjects.length))];
  words[5] = c[floor(random(c.length))];
  words[6] = locations_stress2.get(floor(random(locations_stress2.size())));
  
  String line = String.join(" ", words) + ",";
  lime[0] = line;
  return words[words.length-1];
}


void getLine2(String r) {
  String[] words = {"Who's", "*-", "-*", "-", "-*"};
  
  String[] adv = {"never", "neither", "super", "often", "very"};
  String[] conj = {"or", "nor", "and", "and", "and"};
  
  int index = floor(random(adv.length));
  words[1] = adv[index];
  words[2] = adjectives_stress2.get(floor(random(adjectives_stress2.size())));
  words[3] = conj[index];
  
  String[] rhymes = lexicon.rhymes(r);
  
  for (String rhyme: rhymes) {
    String stress_pattern_str = RiTa.getStresses(rhyme);
    String[] stress_pattern = stress_pattern_str.split("/| ");
    if (stress_pattern.length >= 2 
        && RiTa.isAdjective(rhyme)
        && (Integer.valueOf(stress_pattern[1])) == 1) {
      words[4] = rhyme;
    }
  }
  
  //if (words[4] == "-*") {
  //  int tries = maxTries;
  //  while (tries > 0) {
  //    String word = RiTa.randomWord("jj", 2);
  //    String stress_pattern_str = RiTa.getStresses(word);
  //    String[] stress_pattern = stress_pattern_str.split("/| ");
  //    if (RiTa.isRhyme(r, word) && (Integer.valueOf(stress_pattern[1])) == 1) {
  //      words[4] = word;
  //      break;
  //    }
  //    tries -= 1;
  //  }
  //}
  
  String line = String.join(" ", words) + ",";
  lime[1] = line;
}


String getLine3() {
  String[] words = {"He", "-", "in", "the", "-"};
  words[1] = RiTa.randomWord("vbz", 1); // verb, 3rd. singular present; 2 syllables
  words[4] = RiTa.randomWord("nn", 1);
  String line = String.join(" ", words) + ",";
  lime[2] = line;
  return words[words.length-1];
}

void getLine4(String r) {
  String[] words = {"And", "-", "on", "the", "-"};
  words[1] = RiTa.randomWord("vbz", 1); // verb, 3rd. singular present; 2 syllables
  
  String[] rhymes = lexicon.rhymes(r);
  
  for (String rhyme: rhymes) {
    String stress_pattern_str = RiTa.getStresses(rhyme);
    String[] stress_pattern = stress_pattern_str.split("/| ");
    if (stress_pattern.length == 1
        && RiTa.isNoun(rhyme)
        && (Integer.valueOf(stress_pattern[0])) == 1) {
      words[4] = rhyme;
    }
  }
  
  //int tries = maxTries;
  //while (tries > 0) {
  //  String word = RiTa.randomWord("nn", 1);
  //  if (RiTa.isRhyme(r, word)) {
  //    words[4] = word;
  //    break;
  //  }
  //  tries -= 1;
  //}
  
  String line = String.join(" ", words) + ",";
  lime[3] = line;
}

void getLine5(String r) {
  String[] words = {"There's", "always", "a", "*-", "to", "*"};
  
  int tries = maxTries;
  while (tries > 0) {
    String word = RiTa.randomWord("nn", 2);
    String stress_pattern_str = RiTa.getStresses(word);
    String[] stress_pattern = stress_pattern_str.split("/| ");
    if ((Integer.valueOf(stress_pattern[0])) == 1) {
      words[3] = word;
      if ((word.substring(0, 1)).contains("a|e|i|o|u")) {
        words[2] = "an";
      }
      break;
    }
    tries -= 1;
  }
  
  tries = maxTries;
  while (tries > 0) {
    String word = RiTa.randomWord("vb");
    String stress_pattern_str = RiTa.getStresses(word);
    String[] stress_pattern = stress_pattern_str.split("/| ");
    if (RiTa.isRhyme(r, word) && (Integer.valueOf(stress_pattern[0])) == 1) {
      words[5] = word;
      break;
    }
    tries -= 1;
  }
  
  String line = String.join(" ", words) + "!";
  lime[4] = line;
}


void loadLocations() {
  locations_stress2 = new StringList();
  String[] lines = loadStrings("scotland_places.txt");
  for (String line: lines) {
    String place = line.substring(0, line.indexOf(","));
    String stress_pattern_str = RiTa.getStresses(place);
    String[] stress_pattern = stress_pattern_str.split("/| ");
    if (stress_pattern.length >= 2 && (Integer.valueOf(stress_pattern[1])) == 1) {
      locations_stress2.append(place);
    }
  }
  
  println("Finished loading " + locations_stress2.size() + " places.");
}

void loadAdjectives() {
  adjectives_stress2 = new StringList();
  String[] lines = loadStrings("adjectives.txt");
  for (String line: lines) {
    String stress_pattern_str = RiTa.getStresses(line);
    String[] stress_pattern = stress_pattern_str.split("/| ");
    if (stress_pattern.length == 2 
        && RiTa.isAdjective(line)
        && (Integer.valueOf(stress_pattern[1])) == 1) {
      adjectives_stress2.append(line);
    }
  }
  
  println("Finished loading " + locations_stress2.size() + " adjectives.");
}


void mousePressed() {
  getLimerick();
  println(lime);
}
