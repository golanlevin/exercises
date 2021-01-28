PFont font1;
PFont font2;
String[] joke;
ArrayList<String> allNames;
HashMap<String, String> dict;

void setup() {
  size(800, 800); 
  font1 = loadFont("CenturySchoolbook-60.vlw");
  font2 = createFont("Helvetica-Bold", 60);
  joke = new String[5];
  loadDictionary();
  getJoke();
}

void draw() {
  background(253);
  
  fill(0);
  noStroke();
  
  float x = 100;
  float y = 100;
  float lineHeight = 80;
  for (int i = 0; i < 5; i++) {
    String line = joke[i];
    if (i%2 == 0) {
      textFont(font2, 60);
    } else {
      textFont(font1, 60);
    }
    text(line, x, y+i*lineHeight, width-x*2, height-y);
  }
}

void loadDictionary() {
  dict = new HashMap<String, String>();
  allNames = new ArrayList<String>();
  
  String line = "";
  BufferedReader reader = createReader("noun-definition.txt");;
  
  println("Loading dictionary...");

  while (true) {
    
    try {
      line = reader.readLine();
    } catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    
    if (line == null) { // Finished reading
      break;
    }
    int i = line.indexOf(":");
    String name = line.substring(0, i);
    String def = line.substring(i+1, line.length()) + ".";
    dict.put(name, def);
    allNames.add(name);
  }
  
  println("Finished loading dictionary.");
}

void getJoke() {
  int pick = floor(random(allNames.size()));
  String name = allNames.get(pick);
  String def = dict.get(name);
  joke[0] = "Knock knock!";
  joke[1] = "Who's there?";
  joke[2] = name + ".";
  joke[3] = name + " who?";
  joke[4] = def;
}

void mousePressed() {
  getJoke();
}
