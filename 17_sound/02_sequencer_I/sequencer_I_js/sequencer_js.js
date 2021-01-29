var synth;
var seq;
var notes;
var all = ["C","D","E","F","G","A","B"];
var offset = 80;
var grid;
var ready;


function setup() {
  createCanvas(800, 800);
  
  ready = false;
  
  notes = ["B4_1", "G4_2", "A4_3", "E4_4", "A4_5", "G4_6", "F4_7", "A4_7"];
  grid = (width-offset*2)/max(notes.length, all.length);
  
  synth = new Tone.Synth().toDestination();
  seq = new Tone.Sequence((time, note) => {
    synth.triggerAttackRelease(note.substring(0, 2), 0.2, time); 
    console.log(time);
    
    background(253);
    drawGuidelines();
    drawSequence(notes);
    drawNote(note);
    
  }, notes, 1);
    
  background(253);
  drawGuidelines();
  drawSequence(notes);
  
}

function drawGuidelines() {
  stroke(0);
  strokeWeight(2);
  line(offset, offset, offset, height-offset);
  line(offset, height-offset, width-offset, height-offset);
}

function drawSequence(notes) {
  noStroke();
  fill(200);
  for (var i = 0; i < notes.length; i++) {
    var note = notes[i];
    var y = all.indexOf(note[0]);
    rect(offset+grid*i, height-offset-grid*(y+1), grid, grid);
  }
}


function drawNote(note) {
  var y = all.indexOf(note[0]);
  var x = notes.indexOf(note);
  stroke(0);
  strokeWeight(8);
  fill(255, 200, 200);
  rect(offset+grid*x, height-offset-grid*(y+1), grid, grid);
}

function draw() {
}


function mousePressed() {
  if (!ready) {
    Tone.start();
    console.log("Audio ready");
    ready = true;
  }
  seq.start();
  Tone.Transport.start();
}


function keyPressed() {
  if (keyCode == 32) { // white space
    saveFrames('sequencer', 'png');
  }
}
