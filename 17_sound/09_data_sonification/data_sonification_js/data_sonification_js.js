var osc;
var wave;

var drawWaveLastTime;
var drawWaveInterval;
var curWave;

var offset;

var isOn;

var lati = 0;
var longi = 0;

var url = 'http://api.open-notify.org/iss-now.json';

var myFont;

var ready;

function setup() {
  createCanvas(800, 800);
  
  ready = false;
  
  textFont("Helvetica-Bold", 72);
  
  //create a synth and connect it to the master output (your speakers)
  osc = new Tone.Oscillator({
      type: "sine",
      frequency: 440,
      volume: -8
  }).toDestination();
  
  wave = new Tone.Waveform();
  osc.connect(wave);
  
  drawWaveInterval = 100;
  drawWaveLastTime = -1000;
  
  offset = 100;
  
  osc.start();
  isOn = true;
  
  frameRate(2);
  
}

function draw() {
  background(253);
  
  // Request the data
  loadJSON(url, gotData);
  
  osc.volume.value = constrain(map(lati, -90, 90, -32, 4), -32, 4);
  osc.frequency.value = constrain(map(longi, -180, 80, 200, 600), 200, 600);
  
  textAlign(CENTER, TOP);
  noStroke();
  fill(0);
  textAlign(LEFT, CENTER);
  text("Latitude: " + str(lati) + "\n" + "Longitude: " + str(longi), 80, 250);
  
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
    var y = map(curWave[i], -0.5, 0.5, 0, 1100);
    vertex(x, y);
  }
  endShape();
}

function gotData(data) {
  var iss = data.iss_position;
  longi = iss.longitude;
  lati = iss.latitude;
}

function mousePressed() {
  if (!ready) {
    Tone.start();
    console.log("Audio ready");
    ready = true;
  }
  
  if (isOn) {
    osc.stop();
    isOn = false;
  } else {
    osc.start();
    isOn = true;
  }
}

function keyPressed(){
  saveCanvas('data_sonification', 'png');
}
