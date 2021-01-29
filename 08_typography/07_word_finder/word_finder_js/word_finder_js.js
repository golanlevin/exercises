// Word finder 
//
// Text from "This Is Not a Small Voice" by Sonia Sanchez, 1995
// https://poets.org/poem/not-small-voice


var poem = [
  "This is not a small voice", 
  "you hear              this is a large", 
  "voice coming out of these cities.", 
  "This is the voice of LaTanya.", 
  "Kadesha. Shaniqua. This", 
  "is the voice of Antoine.", 
  "Darryl. Shaquille."];

var myFont; 

//------------------------------
function setup() {
  createCanvas(800, 800); 
  myFont = "Sentinel-Medium";
}

//------------------------------
function draw() {
  background(253); 
  push();
  translate(80, 124); 

  textFont(myFont, 48); 
  textAlign(LEFT, BASELINE); 
  var textSpacing = 96; 

  // Choose the "word of interest"
  var myWord = "voice";
  if (second()%2 == 0) {
    myWord = "This";
  }

  // Display the text. 
  fill(0, 0, 0); 
  for (var i=0; i<poem.length; i++) {
    text(poem[i], 0, i*textSpacing);
  }

  // Find and highlight the word's instances
  noStroke(); 
  fill(200); 
  var wordWidth = textWidth(myWord); 
  for (var i=0; i<poem.length; i++) {
    var aLine = poem[i];
    var wordLoc = aLine.indexOf(myWord); 
    if (wordLoc >= 0) {
      var prefix = aLine.substring(0, wordLoc); 
      var prefixWidth = textWidth(prefix); 
      var px = prefixWidth; 
      var py = i*textSpacing + 4;
      rect(px, py, wordWidth, 14);
    }
  }

  pop();
}


function keyTyped() {
  if (keyCode == 32) { // empty space
    saveFrames('word_finder', 'png', 1, 1);
  }
}
