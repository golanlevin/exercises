import rita.*;

RiMarkov markov;
String line = "click to (re)generate!";
String[] files = { "wittgenstein.txt", "kafka.txt" };
int x = 160, y = 240;

void setup()
{
  size(800, 800);

  fill(0);
  textFont(createFont("times", 16));

  // create a markov model w' n=3 from the files
  markov = new RiMarkov(4);
  markov.loadFrom(files, this);
}

void draw()
{
  background(250);
  text(line, x, y, 400, 400);
}

void mouseReleased()
{
  if (!markov.ready()) return;
  x = y = 50;
  String[] tokens = markov.generateTokens(5);
  line = RiTa.join(tokens, " ");
  isLegalLine(line, "A");
}

void isLegalLine(String line, String form) {
  String[] line_arr = line.split(" ");
  String stressed = RiTa.getStresses(line_arr);
  String syllas = RiTa.getSyllables(line_arr);
  println(RiTa.join(line_arr, " "));
  println(stressed);
  println(syllas);
  println("");
  if (form == "A") { // 3 anapest
  } else { // form == "B" // 2 anapests
  }
  
}
