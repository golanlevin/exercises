// sequencer
// <3 rld

var colors = new Array(16); // new Array

var osc1, osc2, echo1, echo2;
var notes = [60, 63, 65, 67, 70]; // MIDI
var sequence = [60, 63, 58, 65, 70, 67, 62, 72, 63, 60, 62, 67, 65, 70, 58, 67]; // MIDI
var octave = [-24, -12, 0, 12, 24];
var step = 0; // which note am i playing out of 'sequence'

var img;

function preload(){

  img = loadImage("cursor1.png");
}

function setup()
{
  createCanvas(300, 300);
  background(0);
  noStroke();
  rectMode(CENTER);

  for(var i = 0;i<colors.length;i++)
  {
    colors[i] = [random(255), random(255), random(255), 20];
  }

  // set up oscillator:
  osc1 = new p5.Oscillator();
  osc1.setType('square');
  osc1.freq(240);
  osc1.amp(0);
  osc1.start();

  // set up echo:
  echo1 = new p5.Delay();
  // input, time (s), feedback (0-1), damping (freq)
  echo1.process(osc1, 0.375, 0.7, 5000);

  // set up oscillator 2:
  osc2 = new p5.Oscillator();
  osc2.setType('sawtooth');
  osc2.freq(240);
  osc2.amp(0);
  osc2.start();

  // set up echo 2:
  echo2 = new p5.Delay();
  // input, time (s), feedback (0-1), damping (freq)
  echo2.process(osc2, 0.25, 0.7, 5000);
}

function draw()
{
  background(colors[step]);
  var w = imap(mouseX, 0, width, 0, colors.length); // x => index of colors
  var o = imap(mouseY, 0, height, 5, 0); // y => octaves

  fill(colors[w]);
  rect(mouseX, mouseY, 50, 50);

  // add the note to the octave and convert
  osc1.amp(0.3);
  osc1.freq(midiToFreq(sequence[step]+octave[o]));

  osc2.amp(0.3);
  osc2.freq(midiToFreq(sequence[step]));

  // advance the sequence every 15 frames:
  if(frameCount % 15 == 0) step = (step+1) % sequence.length;

}

// clear the screen:
function keyPressed()
{
image(img, mouseX,mouseY, 2*12, 2*19);
      saveCanvas('theremin2', 'png');
}

// constrained integer map function:
function imap(v, a, b, c, d)
{
  return(constrain(floor(map(v, a, b, c, d)), min(c,d), max(c, d)-1));
}
