function setup() {
  createCanvas(800, 800);
}

function draw() {
  var a=1;
  //color of each individual square
  var c=0;

  for (var x=0; x<width; x=x+80) {
    //alternates the fill between black and white
    a=a*-1;
    for (var y=0; y<height; y=y+80) {
      //alternates the fill between black and white
      a=a*-1;
      if (a<0) {
        //set color to black
        c=0;
      }
      if (a>0) {
        //set color to white
        c=255;
      }
      //changes fill to c
      fill(c);
      //draws the checkers square
      rect(x, y, 80, 80);
    }
  }
}
