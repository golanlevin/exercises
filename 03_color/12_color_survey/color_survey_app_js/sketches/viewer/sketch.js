//////////////////////////////////////////
// "Color Survey" (Viewer)              //
// Exercise on page 156 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// hosted on: https://color-survey.glitch.me/

// This is the viewer, see survey for the surveyor

var prompts = ["mauve","teal","plum"]; // controversial color names

function setup(){
  createCanvas(512,512);
  
  // load the databse. make sure you have the right folder structure
  
  var req = new XMLHttpRequest();
  req.open( "GET",
     "/pull"
    ,false // sync
  );
  req.send( null );
  var db = JSON.parse(req.responseText);
  console.log(db)
  
  var textHeight = 30;
  var columns = 5;
  var panelWidth = width/prompts.length;
  var pad = 10;
  for (var j = 0; j < prompts.length; j++){
    fill(255);
    stroke(0);
    rect(j*panelWidth,0,panelWidth,height);
    fill(0);
    noStroke();
    textSize(textHeight);
    text(prompts[j],j*panelWidth+pad,textHeight);
  }
  
  // read from the database and draw the colors
  for (var i = 0; i < db.length; i++){
    var row = JSON.parse(db[i].colors);   
    var cellWidth = (panelWidth-pad*2)/columns;
    
    var n = prompts.length;
    var c = i % columns;
    var r = ~~(i / columns);
    
    for (var j = 0; j < n; j++){
      var rgb = [
        ~~(row[j*3  ]*255),
        ~~(row[j*3+1]*255),
        ~~(row[j*3+2]*255)
      ]
      fill(...rgb);
      stroke(...rgb);
      rect(j*panelWidth+c*cellWidth+pad,textHeight+pad+r*cellWidth,cellWidth,cellWidth);
    }
  }
}