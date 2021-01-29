var myFonts;   

function setup() {
  createCanvas(800, 800); 

  myFonts = [null, null, null];
  myFonts[0] = "Times-Bold";
  myFonts[1] = "Courier-Bold";
  myFonts[2] = "Helvetica-Bold";
  noLoop();
}


function draw() {
  background(253); 

  var phrase = "STEAL\nTHIS\nBOOK"; 
  var nChars = phrase.length; 

  fill(0); 
  textAlign(LEFT, TOP);
  
  var xinit = 120;
  var tx = xinit;
  var ty = 120; 
  for (var i=0; i<nChars; i++) {
    var ithChar = phrase.charAt(i); 
    if (ithChar == '\n') {
      ty += 200;  
      tx = xinit;
    } else {
      var r = (int)(Math.floor(random(2.99999))); 
      textFont(myFonts[r], random(150, 220)); 
      text(ithChar, tx, ty); 
      tx += textWidth(ithChar);
    }
  }
}


function keyTyped() {
  if (key === 's') {
    saveFrames('ransom_letter', 'png', 1, 1);
  }
}
