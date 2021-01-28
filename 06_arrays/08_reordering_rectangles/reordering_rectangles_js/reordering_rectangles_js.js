var offset;
var ssize;
var factor;

var colors;
  
var rectList;
  
  
class Rectangle {
  constructor(xx, yy, ww, hh, cc) {
    this.x = xx;
    this.y = yy;
    this.w = ww;
    this.h = hh;
    this.c = cc;
  }
  
  getArea() {
    return this.w*this.h;
  }
  
  getLeft() {
    return this.x;
  }
}  

function setup() {
  createCanvas(800, 800);
  
  offset = 50;
  ssize = (width - 3*offset)/2;
  factor = ssize/10;
  
  let c1 = color(191, 241, 255);
  let c2 = color(236, 213, 162);
  let c3 = color(223, 255, 191);
  let c4 = color(255, 227, 254);
  colors = [c1, c2, c3, c4];
  
  rectList = [];
  
  var r1 = new Rectangle(0, 4, 5, 4, colors[0]);
  var r2 = new Rectangle(4, 3, 4, 3, colors[1]);
  var r3 = new Rectangle(2, 1, 4, 4, colors[2]);
  var r4 = new Rectangle(1, 0, 6, 2, colors[3]);
  
  rectList.push(r1);
  rectList.push(r2);
  rectList.push(r3);
  rectList.push(r4);
  
  noLoop();
}

//---------------------------------------------------
function draw() {
  
  offset = 70;
  
  background(253);
  stroke(0); 
  strokeWeight(2); 
  
  for (var x=5; x<(width-10); x+=20){
    line(x,height/2, x+10, height/2);  
  }
  for (var y=5; y<(height-10); y+=20){
    line(width/2, y, width/2, y+10);  
  }
  
  stroke(0); 
  strokeWeight(8);
  strokeJoin(MITER); 
  
  var r;
  
  // normal order
  push();
  translate(offset, offset);
  for (var i = 0; i < 4; i++) {
    r = rectList[i];
    fill(r.c);
    rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h);
  }
  pop();
  
  // reverse order
  push();
  translate(offset*2 + ssize, offset);
  for (i = 3; i >= 0; i--) {
    r = rectList[i];
    fill(r.c);
    rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h);
  }
  pop();

  // sort by area
  rectList.sort(function(a, b) {
    return a.getArea()-b.getArea();
  });
  push();
  translate(offset, ssize + 2*offset);
  for (i = 3; i >= 0; i--) {
    r = rectList[i];
    fill(r.c);
    rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h);
  }
  pop();
  
  // sort by left side
  rectList.sort(function(a, b) {
    return a.getLeft()-b.getLeft();
  });
  push();
  translate(ssize + 2*offset, ssize + 2*offset);
  for (i = 3; i >= 0; i--) {
    r = rectList[i];
    fill(r.c);
    rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h);
  }
  pop();
}
