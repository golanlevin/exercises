/* list of English prefixes, roots, and suffixes from the following sites 
 *
 *      https://en.wikipedia.org/w/index.php?oldid=516380353
 *      https://en.wikipedia.org/wiki/English_prefix
 *      https://en.wikipedia.org/wiki/Suffix#English
 */

String[] words;
int word_num;

String[] prefixes;
String[] roots;
String[] suffixes;

PFont myFont;
PFont myFont_bold;

void setup() {
  size(800, 800);
  
  myFont = createFont("Helvetica", 80); // CenturySchoolbook-60.vlw"
  myFont_bold = createFont("Helvetica-Bold", 80); // CenturySchoolbook-60.vlw"
  
  prefixes = loadStrings("prefixes.txt");
  roots = loadStrings("roots.txt");
  suffixes = loadStrings("suffixes.txt");
  
  word_num = 5;
  words = new String[word_num];
  reset();
  
}

void draw() {
  background(253);
  
  float offset = 70;
  float leading = 130;
  float y = height-leading*words.length+10;
  float tSize = 100;
  textLeading(leading);
  
  fill(0);
  
  for (int i = 0; i < word_num; i++) {
    String[] word_l = words[i].split(" ");
    String p = word_l[0];
    String r = word_l[1];
    String s = word_l[2];
    float x = offset;
    
    if (i%2 == 1) {
        textFont(myFont_bold, tSize);
        text(p+"·", x, y);
        
        x += textWidth(p+"·");
        textFont(myFont, tSize);
        text(r, x, y);
        
        x += textWidth(r);
        textFont(myFont_bold, tSize);
        text("·" + s, x, y);
    } else {
        textFont(myFont, tSize);
        text(p+"·", x, y);
        
        x += textWidth(p+"·");
        textFont(myFont_bold, tSize);
        text(r, x, y);
        
        x += textWidth(r);
        textFont(myFont, tSize);
        text("·" + s, x, y);
    }
    y += leading;
  }

}

void reset() {
  for (int i = 0; i < word_num; i++) {
    words[i] = getWord();
  }
}

String getWord() {
  String pre = prefixes[floor(random(prefixes.length))];
  String roo = roots[floor(random(roots.length))];
  String suf = suffixes[floor(random(suffixes.length))];
  return pre + " " + roo + " " + suf;
}

void mousePressed() {
  reset();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("nonsense_word.png");
  }
}
