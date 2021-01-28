function setup() {
  createCanvas(800, 800);
  noSmooth();
}

function draw() {
  background(253);
  strokeWeight(2);

  //sets the number of rectangles being drawn
  var nRectangles = 14;
  for (var i = 0; i < nRectangles; i++){
    //finds the x and y value of current rectangle
    var x0 = 50 + i*50;
    var y0 = height-50;

    //rectangle height increases by 25
    var rectH = (i+1)*50;
    //creates a color gradient by making color dependent on i
    fill(i*(255.0/nRectangles));
    //draws the rectangle
    rect(x0,y0,50,-rectH);
  }
}
