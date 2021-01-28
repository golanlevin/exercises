/* Adapted from example script "Kafgenstein" from the RiTa library */

import rita.*;

RiMarkov markov;
String line = "click to (re)generate!";
String file = "transcript.txt";

float margin;

void setup()
{
  size(800, 800);
  
  fill(0);
  PFont myFont = loadFont("CenturySchoolbook-60.vlw");
  textFont(myFont, 60);

  // create a markov model w' n=3 from the files
  markov = new RiMarkov(4);
  markov.loadFrom(file, this);
  
  margin = 100;
  
  reset();
  
}

void draw()
{
  background(253);
  text(line, margin, margin, width-2*margin, height-2*margin);
}

void reset() {
  if (!markov.ready()) return;
  String[] lines = markov.generateSentences(3);
  line = RiTa.join(lines, " ");
}

void mouseReleased()
{
  reset();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("markov_text_generator.png");
  }
}
