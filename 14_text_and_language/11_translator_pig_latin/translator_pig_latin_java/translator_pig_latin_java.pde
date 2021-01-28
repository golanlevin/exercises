PFont myFont; 
String original;
String pigged;

void setup() {
  size(800, 800); 
  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  noLoop();
  
  original = "Once upon a midnight dreary, while I pondered, weak and weary, Over many a quaint and curious volume of forgotten lore"; // While I nodded, nearly napping, suddenly there came a tapping, As of some one gently rapping, rapping at my chamber door. 'Tis some visitor,' I muttered, 'tapping at my chamber door - Only this, and nothing more.'";
  
  String clean_word = (((original.toLowerCase().replaceAll("'", " ' ")).replaceAll(";"," ; ")).replaceAll(","," , "));
  String[] clean_word_list = clean_word.split(" ");
  ArrayList<String> pigged_list = new ArrayList<String>();
  
  for (int i = 0; i < clean_word_list.length; i++) {
    pigged_list.add(translate(clean_word_list[i]));
  }
  
  pigged = String.join(" ", pigged_list);
  pigged = ((pigged.replaceAll(" ' ", "'")).replaceAll(" ; ",";")).replaceAll(" , ",",");
  
  // pigged = 
  //  "onceway uponway a idnightmay earydray, ilewhay i onderedpay, eakway andyay earyway, overway anymay a aintquay andyay uriouscay olumevay ofyay orgottenfay orelay";

}

String translate(String word) {
  if (word.length() > 1) {
    if ("aeiou".contains(word.substring(0,1)) && word.length() != 1){
      word = word + "way";
    } else if ("sm sh ch fl gr ph str th dr wh qu".contains(word.substring(0,2))) {
      word = word.substring(2) + word.substring(0,2) + "ay";
    } else {
      word = word.substring(1) + word.substring(0,1) + "ay";
    }
  }
  return word;
}

void draw() {
  background(253); 
  
  float fontSize = 60;
  float fontLeading = 72;
  
  fill(0);  
  textFont(myFont, fontSize);
  String words[] = split(pigged, ' '); 

  float textL = 80; 
  float textR = width - 80; 
  float posX = textL; 
  float posY = 120; 
  for (int i=0; i<words.length; i++) {
    int j=i;
    while ((j < words.length) && ((posX + textWidth(words[j]) < textR))) {
      text(words[j]+" ", posX, posY); 
      posX += textWidth(words[j]+ " ");
      j++;
    }
    if (j>i) {
      i = j-1;
    }
    posX = textL;
    posY += fontLeading;
  }
}

void keyPressed(){
  if (key == ' '){
    saveFrame("translate_pig_latin.png"); 
  }
}
