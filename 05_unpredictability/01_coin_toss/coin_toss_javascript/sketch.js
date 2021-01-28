var noise_offset = 0;
var n;

function setup() {
  createCanvas(300, 300);
  noStroke();
  noLoop();
}


function draw() {
  background(1, 22, 39);
  for (var i = 40; i < width-40; i+=1) {
    n = noise(noise_offset) * height;
    for (var j = 0; j < height; j+=2) {
      if (int(random(0, 20)) < 1) {
        noise_offset = noise_offset + .01;
        fill(255, 255, 255, 10);
        var radius = random(40, 90);
        ellipse(i, n, radius, radius);
      }
    }
  }
}