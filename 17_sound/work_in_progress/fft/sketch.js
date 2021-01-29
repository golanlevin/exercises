// plot an FFT
// <3 rld

var samp; // sound
var fft; // analyzer

// do this first:
function preload()
{
  samp = loadSound('./data/samuraibeat.mp3'); // new soundfile player
}

// do this second:
function setup()
{
  createCanvas(300, 300);

  fft = new p5.FFT(); // new FFT object
}

function draw()
{
  background(0);
  fill(255)
  noStroke();
  text('any key to play/stop the sound', 20, 20);

  var spectrum = fft.analyze(); // analyze the sound
  var usable = spectrum.length/2; // only use the bottom half of the FFT analysis frame
  noFill();
  stroke(255,0,255); // spectrum is purple
  beginShape();
  curveVertex(0, height);
  for (var i = 0; i< usable; i++){
    var xl = 1.0-sqrt(1.0-(i/(usable-1))); // DODGY LOG HACK
    var x = map(xl, 0, 1.0, 0, width-1);
    var h = map(spectrum[i], 0, 255, 0, height);
    curveVertex(x, height-h);
    ellipse(x, height-h, 5, 5);
  }
  curveVertex(x, height);
  endShape();
}

// toggle sound playing:
function keyPressed()
{
  if(samp.isPlaying()) samp.stop(); else samp.loop();

}

function mousePressed(){
    saveCanvas('visualise','png');
}
