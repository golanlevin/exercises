// Tracing the contours of metaballs (implicit curves) using Marching Square
// 
// Reference:
// Metaballs (by Daniel Shiffman): https://thecodingtrain.com/CodingChallenges/028-metaballs.html
// Marching Squares (also by the wonderful Daniel Shiffman): https://thecodingtrain.com/challenges/coding-in-the-cabana/005-marching-squares.html

var blobs = [];

let field = [];
let rez = 5;
let cols, rows;

function setup() {
  createCanvas(800, 800);
  colorMode(HSB);
  for (i = 0; i < 5; i++)
    blobs.push(new Blob(random(0, width), random(0, height)));
    
  cols = 1 + width / rez;
  rows = 1 + height / rez;
  for (let i = 0; i < cols; i++) {
    let k = [];
    for (let j = 0; j < rows; j++) {
      k.push(0);
    }
    field.push(k);
  }
}

function drawLine(v1, v2) {
  stroke(0);
  strokeWeight(8);
  line(v1.x, v1.y, v2.x, v2.y);
}

function draw() {
  background(253);
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      var sum = 0.0;
      for (let bb = 0; bb < blobs.length; bb++) {
        var b = blobs[bb];
        var d = dist(i*rez, j*rez, b.x, b.y);
        sum += 20 * b.r / d;
      }
      if (sum < 50) {
        field[i][j] = 0;
      } else {
        field[i][j] = 1;
      }
    }
  }
  
  
  for (let i = 0; i < cols - 1; i++) {
    for (let j = 0; j < rows - 1; j++) {
      let x = i * rez;
      let y = j * rez;
      let a = createVector(x + rez * 0.5, y);
      let b = createVector(x + rez, y + rez * 0.5);
      let c = createVector(x + rez * 0.5, y + rez);
      let d = createVector(x, y + rez * 0.5);
      let state = getState(
        ceil(field[i][j]),
        ceil(field[i + 1][j]),
        ceil(field[i + 1][j + 1]),
        ceil(field[i][j + 1])
      );
      stroke(255);
      strokeWeight(1);
      switch (state) {
        case 1:
          drawLine(c, d);
          break;
        case 2:
          drawLine(b, c);
          break;
        case 3:
          drawLine(b, d);
          break;
        case 4:
          drawLine(a, b);
          break;
        case 5:
          drawLine(a, d);
          drawLine(b, c);
          break;
        case 6:
          drawLine(a, c);
          break;
        case 7:
          drawLine(a, d);
          break;
        case 8:
          drawLine(a, d);
          break;
        case 9:
          drawLine(a, c);
          break;
        case 10:
          drawLine(a, b);
          drawLine(c, d);
          break;
        case 11:
          drawLine(a, b);
          break;
        case 12:
          drawLine(b, d);
          break;
        case 13:
          drawLine(b, c);
          break;
        case 14:
          drawLine(c, d);
          break;
      }
    }
  }

  for (i = 0; i < blobs.length; i++) {
    blobs[i].update();
  }
}

function getState(a, b, c, d) {
  return a * 8 + b * 4 + c * 2 + d * 1;
}

// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/ccYLb7cLB1I

class Blob {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    let angle = random(0, 2 * PI);
    this.xspeed = random(2, 5) * Math.cos(angle);
    this.yspeed = random(2, 5) * Math.sin(angle);
    this.r = random(120, 240);
  }

  update() {
    this.x += this.xspeed;
    this.y += this.yspeed;
    if (this.x > width || this.x < 0) this.xspeed *= -1;
    if (this.y > height || this.y < 0) this.yspeed *= -1;
  }

  show() {
    noFill();
    stroke(0);
    strokeWeight(4);
    ellipse(this.x, this.y, this.r * 2, this.r * 2);
  }
}
