// Ubbi dubbi translator
PFont myFont; 
String original = "Once upon a midnight dreary, while I pondered, weak and weary, Over many a quaint and curious volume of forgotten lore"; // While I nodded, nearly napping, suddenly there came a tapping, As of some one gently rapping, rapping at my chamber door. 'Tis some visitor,' I muttered, 'tapping at my chamber door - Only this, and nothing more.'";

void setup() {
  size(800, 800); 
  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  
  // debug
  println(translate("hello")); // => hubellubo
  println(translate("speak")); // => spubeak
  println(translate("Zoom")); // => Zuboom
  println(translate("Extra")); // => Ubextruba
  println(translate("extra")); // => ubextruba
  
  String[] original_list = original.split(" ");
  StringList translated_list = new StringList();
  for (int i = 0; i < original_list.length; i++) {
    translated_list.append(translate(original_list[i]));
  }
  
  String translated = translated_list.join(" ");
  
  background(253);
  textFont(myFont, 60);
  float margin = 80;
  fill(0);
  text(translated, margin, margin, width-2*margin, height-2*margin);
  
  noLoop();
}

void draw() {
  
}

String translate(String word) {
  StringList result = new StringList();
  for (int i = word.length()-1; i >= 0; i--) {
    if ("aeiou".contains((word.substring(i, i+1)).toLowerCase())) {
      if (i == 0) {
        if (Character.isUpperCase(word.charAt(i))) {
          result.append(word.substring(i, i+1).toLowerCase());
          result.append("Ub");
        } else {
          result.append(word.substring(i, i+1));
          result.append("ub");
        }
      } else if (!"aeiou".contains(word.substring(i-1, i))) {
        result.append(word.substring(i, i+1));
        result.append("ub");
      } else {
        result.append(word.substring(i, i+1));
      }
    } else {
      result.append(word.substring(i, i+1));
    }
  }
  result.reverse();
  String translatedWord = String.join("", result);
  return translatedWord;
}

void keyPressed(){
  if (key == ' '){
    saveFrame("translate_argots.png"); 
  }
}
