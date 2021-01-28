import rita.*;

RiGrammar grammar;
String[] lines = {"click to", "generate", "a limerick", "woo", "hoo"};

PFont myFont;
float margin;
float lineHeight;

void setup()
{
  size(800, 800);

  fill(0);
  margin = 120;
  
  myFont = loadFont("CenturySchoolbook-60.vlw");
  textFont(myFont, 32);
  lineHeight = 72;
  
  grammar = new RiGrammar(this);
  grammar.loadFrom("lime.yaml");
}

void draw()
{
  background(253);
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    text(line, margin, margin + i*lineHeight);
  }
}

void mouseReleased()
{
  String result = grammar.expand();
  String[] haiku = result.split("%");
  for (int i = 0; i < lines.length; i++)
    lines[i] = haiku[i];
}
