var myFont;
var typedText = "type:"; 

function setup() {
  createCanvas(800, 800); 
  myFont = textFont("Courier", 72);
}


function draw() {
  background(253); 
  fill(0); 
  
  var textX = width * 0.925;
  var textY = height/2 - 5;

  textFont(myFont, 72); 
  textAlign(RIGHT, CENTER); 
  text(typedText, textX, textY);
  
  // draw a very simple text-cursor 
  stroke(0); 
  strokeWeight(8); 
  line(textX, textY+50, textX, textY-45); 
}


function keyPressed() {
  if (keyCode == 32) {
    saveFrames('one_line_typewriter', 'png', 1, 1);
  } else if ((keyCode == RETURN) || (keyCode == ENTER)) {
    typedText = "";
  } else if (keyCode == BACKSPACE) {
    var len = typedText.length;
    if (len > 0) {
      typedText = typedText.substring(0, len-1);
    }
  } else if ((keyCode >= 20) && (keyCode <= 126)){
    typedText += key;
  }
}
