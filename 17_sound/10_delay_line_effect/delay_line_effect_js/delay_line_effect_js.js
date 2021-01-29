var dogSound;
var dogSound1;
var dogSound2;

var dogLen;
var dogWave;

var delay = 0.1; // delay by 0.1 second

var margin = 0;
var delaySize = 80;
var waveLen = 800;

var startTime;

var ready;

function setup() {
  createCanvas(800, 800);
  
  ready = false;
  
  dogSound = new Tone.Player("data/dog.wav", () => {
    var barkWave = (dogSound.buffer.toArray());
    dogWave = barkWave[0];
    dogLen = dogSound.buffer.duration;
    console.log("Loaded track of duration " +  dogLen + " seconds.");
  }).toDestination();
  
  dogSound1 = new Tone.Player("data/dog.wav").toDestination();
  dogSound2 = new Tone.Player("data/dog.wav").toDestination();
  
  frameRate(30);
}


function draw() {
  background(253);
  
  if (dogWave != null) {
    drawWave(margin + delaySize * 1, 180, waveLen);
    drawWave(margin + delaySize * 2, 400, waveLen);
    drawWave(margin + delaySize * 3, 620, waveLen);
  }
  
  var x = map(millis()-startTime, 0, dogLen*1000, margin+delaySize, margin+delaySize+waveLen);
  stroke(0);
  line(x, 0, x, height);
  
}

function drawWave(xStart, y, len) {
  noFill();
  stroke(0);
  strokeWeight(8);
  line(0, y, width, y);
  strokeWeight(2);
  beginShape();
  for (var i = 0; i < dogWave.length; i++) {
    var xx = map(i, 0, dogWave.length, xStart, xStart+len);
    var yy = map(dogWave[i], -1, 1, y-150, y+150);
    vertex(xx, yy);
  }
  endShape();
}

function mousePressed() {
  if (!ready) {
    Tone.start();
    console.log("Audio ready");
    ready = true;
  }
  
  startTime = millis()+ delay*1000;
  
  if (dogSound.state == "started") {
    dogSound.stop();
  }
  if (dogSound1.state == "started") {
    dogSound1.stop();
  }
  if (dogSound2.state == "started") {
    dogSound2.stop();
  }
  //Tone.Transport.pause();
  dogSound.start("+"+delay * 1);
  dogSound1.start("+"+delay * 2);
  dogSound2.start("+"+delay * 3);
  //Tone.Transport.start();
}

function keyPressed() {
  if (keyCode == 32) {
    saveFrames("delay_line_effect", "png");
  }
}
