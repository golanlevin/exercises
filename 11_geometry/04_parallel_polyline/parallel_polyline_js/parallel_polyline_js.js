var points;  
var cursorImg;


//-----------------------------------------
function setup() {
  createCanvas(800, 800);
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png");  

  points = [];
}


//-----------------------------------------
function draw() {
  background(253); 

  if (points.length > 0) {
    strokeCap(ROUND); 
    strokeJoin(ROUND); 

    // Draw main (thick) gesture.
    noFill(); 
    stroke(0); 
    strokeWeight(8);
    beginShape(); 
    for (var j=0; j<points.length; j++) {
      var pJ = points[j]; 
      vertex(pJ.x, pJ.y);
    }
    endShape(); 

    var offset = 50.0; 
    var minPointDist = 4.0; 

    strokeWeight(2);
    beginShape(); 
    var pI = points[0]; 
    for (var j=1; j < points.length; j++) {
      var pJ = points[j];

      var dx = pJ.x - pI.x;
      var dy = pJ.y - pI.y;
      var dh = sqrt(dx*dx + dy*dy); 

      if (j==1) {
        var px = pI.x + offset * dy/dh;
        var py = pI.y - offset * dx/dh;
        vertex(px, py);
      }

      if ((j==(points.length-1)) || (dh > minPointDist)) {
        var px = pJ.x + offset * dy/dh;
        var py = pJ.y - offset * dx/dh;
        vertex(px, py);
        pI = points[j]; // swap
      }
    }
    endShape();
  }

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

//-----------------------------------------
function mousePressed() {
  points = [];
  points.push(createVector(mouseX, mouseY, 0));
}

//-----------------------------------------
function mouseDragged() {
  points.push(createVector(mouseX, mouseY, 0));
}

//-----------------------------------------
function keyPressed() {
  if (key == 's') {
    // smooth

    if (points.length > 3) {

      // Make blurred copy
      var pointsTmp = [];
      var p0 = points[0]; 
      pointsTmp.push( createVector(p0.x, p0.y)); 
      for (var j=1; j<points.length-1; j++) {
        var pi = points[j-1]; 
        var pj = points[j]; 
        var pk = points[j+1];

        var ax = (pi.x + pj.x + pk.x)/3.0; 
        var ay = (pi.y + pj.y + pk.y)/3.0; 
        pointsTmp.push( createVector( ax, ay));
      }
      var pLast = points[points.length-1]; 
      pointsTmp.push( createVector(pLast.x, pLast.y));

      // Copy back
      for (var i=0; i<points.length; i++) {
        points[i] = pointsTmp[i];
      }
    }

  } else {
    points = [];
  }
}
