var osc; // an oscillator
var wave;

var cursor;
var isOn;

var drawWaveLastTime;
var drawWaveInterval;
var curWave;

var offset;

function preload(){
  cursor = loadImage("data/cursor_with_shadow_15x21.png");
}

function setup()
{
  createCanvas(800, 800);
  textFont("Helvetica-Bold", 60);

  isOn = false;

  //create a synth and connect it to the master output (your speakers)
  osc = new Tone.Oscillator({
      type: "sawtooth",
      frequency: 440,
      volume: 0
  }).toDestination();
  
  wave = new Tone.Waveform();
  osc.connect(wave);
  
  drawWaveInterval = 100;
  drawWaveLastTime = -1000;
  
  offset = 80;
}

function draw()
{
  background(253);

  osc.volume.value = constrain(map(mouseX, offset, width-offset, -48, 0), -48, 0);
  osc.frequency.value = constrain(map(mouseY, height-offset-100, offset, 30, 600), 30, 600);
  
  fill(0);
  strokeWeight(8);
  line(offset, offset, offset, height-offset-100);
  triangle(offset, offset, offset-10, offset+30, offset+10, offset+30);
  line(offset, height-offset-100, width-offset, height-offset-100);
  triangle(width-offset, height-offset-100, 
            width-offset-30, height-offset-100-10, 
            width-offset-30, height-offset-100+10);
            
  textAlign(LEFT, TOP);
  noStroke();
  text("Frequency", offset+40, offset-20);
  textAlign(RIGHT, BOTTOM);
  text("Volume", width-offset+15, height-offset-100-30);
  
  image(cursor, mouseX, mouseY, 15*6, 21*6);
  
  strokeWeight(2);
  stroke(0);
  line(mouseX, mouseY, mouseX, height-offset-100);
  line(mouseX, mouseY, offset, mouseY);
  
  // draw wave form
  if (millis() - drawWaveLastTime > drawWaveInterval) {
    drawWaveLastTime = millis();
    curWave = wave.getValue();
  }
  
  var len = curWave.length;
  noFill();
  stroke(0);
  strokeWeight(8);
  beginShape();
  for (var i = 0; i < len; i++) {
    var x = map(i, 0, len, 0, width);
    var y = map(curWave[i], -2, 2, 600, 800);
    vertex(x, y);
  }
  endShape();
}


function keyPressed(){
  // saveCanvas('theremin', 'png');
}

function mousePressed() {
  if (isOn) {
    osc.stop();
    isOn = false;
  } else {
    osc.start();
    isOn = true;
  }
}
