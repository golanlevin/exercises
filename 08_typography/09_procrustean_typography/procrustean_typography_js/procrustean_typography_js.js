var words;
var myFont;

function setup() {
  createCanvas(800, 800); 
  noLoop();
  myFont = textFont("Century", 10); 
  
  words = ["perspicacious", "polyphiloprogenitive", "piglet"]; 
}


function draw() {
  background(253); 
  
  var margin = 40; 
  var targetTextWidth = width - 2*margin;
  
  // draw borders
  noFill(); 
  stroke(0); 
  strokeWeight(2);
  line(margin-3, margin, margin-3, height-margin); 
  line(width-margin+3, margin, width-margin+3, height-margin); 
  
  var y = margin+50;
  
  strokeWeight(1);
  var nWords = words.length;
  for (var i=0; i<nWords; i++){
    var word = words[i]; 
    var wordFontSize = 1.0; 
    textSize(wordFontSize);
    var w = textWidth(word);
    // note: use a separate variable w for textWidth(word), 
    //   instead of using textWidth(word) in the while loop guard
    while (w < targetTextWidth){ 
       wordFontSize += 0.05; 
       textSize(wordFontSize);
       w = textWidth(word);
    }
    textSize(wordFontSize);
    
    fill(0); 
    textAlign(CENTER, TOP);
    
    text(word, width/2, y); 
    
    y += wordFontSize * 1.2;
  }
}
