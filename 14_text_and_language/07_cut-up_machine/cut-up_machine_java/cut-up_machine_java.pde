/* News headlines from npr.org and cnn.com
 */

PFont myFont;

BufferedReader reader;
StringList lines;

float margin;


void setup() {
  size(800, 800);
  
  myFont = loadFont("CenturySchoolbook-60.vlw");
  textFont(myFont, 48);
  
  margin = 100;
  
  lines = new StringList();
  String line = "";
  
  reader = createReader("news.txt");
  boolean finished = false;
  while (!finished) {
    try {
      line = reader.readLine();
    } catch (IOException e) {
      e.printStackTrace();
    }
    
    if (line == null) {
      finished = true;
      break;
    } else {
      lines.append(line);
    }
  }

  reset();

}

void draw() {
  background(253);
  fill(0);
  String s = String.join(", ", lines) + ".";
  text(s, margin, margin, width-margin*2, height-margin*2);
}

void mousePressed() {
  reset();
}

void reset() {
  println("shuffling");
  lines.shuffle();
}
