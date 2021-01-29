// Refs:
// https://b2renger.github.io/p5js_typo/
// 
// Using the Rune.Font plug-in: https://github.com/runemadsen/rune.font.js

var f;
var path;
var polys;
var drawing = false;

var letterSize = 600;
var message = "G";
var spacingVal = 1.5;

function getPoints(){
    drawing = false;
    // create new font : we use rune
    f = new Rune.Font("data/RobotoCondensed-Bold.ttf");
    // load the font
    f.load(function(err){
        path = f.toPath(message, 0, 0, letterSize); 
        polys = path.toPolygons({spacing:spacingVal});
        drawing = true;
    });
}

function setup() {
  createCanvas(800, 800);
  smooth();
  
  anchorX = 0;
  anchorY = 0;
  
  getPoints();
}


function draw() {
    background(253);
    fill(230);
    stroke(0);
    strokeWeight(2);
    strokeJoin(ROUND);

    if (drawing) {
        push();
        
        // Draw unmodified glyph
        for (var i=0; i < polys.length ; i++){
           var poly = polys[i];
           var points = poly.state.vectors;
           var nPoints = points.length;
           beginShape();
           for(var j = 0; j < nPoints; j++) {
               var vec = points[j];
               var px = vec.x;
               var py = vec.y;
               px += width*0.05;
               py += height*0.75;
               vertex(px, py);
           }
           endShape(CLOSE);
        }
        
        // Draw modified glyph
        for (var ii=0; ii < polys.length ; ii++){
           var poly2 = polys[ii];
           var points2 = poly2.state.vectors;
           var nPoints2 = points2.length;
           
           var amplitude = 6.0; 
           var frequency = 37; 
           
           beginShape();
           for(var jj = 0; jj < nPoints2; jj++) {
               var vec2 = points2[jj];
               var px2 = vec2.x;
               var py2 = vec2.y;
               
               //Make it puffy
               var t = map(jj, 0, nPoints2, 0, TWO_PI); 
               px2 += amplitude * sin(frequency*t);
               py2 += amplitude * cos(frequency*t + PI);
               
               px2 += width*0.50; 
               py2 += height*0.75; 
               vertex(px2, py2);
           }
           endShape(CLOSE);
        }
        
        pop();
    }
}

function keyTyped() {
  if (key === 's') {
    saveFrames('glyph_hacking', 'png', 1, 1);
  }
}
