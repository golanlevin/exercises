/*** 

Press ENTER to play or pause.
Press LEFT or RIGHT arrow keys to change the tempo.

***/


var mySeq = ["A4", "F4", "G4", "D4", "G4", "F4", "E4", "G4"];

var synth;
var seq;
var notes;
var notes_with_index;
var all = ["C","D","E","F","G","A","B"];
var curNote;

var curTempo;

var offset = 80;
var grid;
var slider;
var tempo_text;
var playButton;
var reverseButton;

var onReverse;

var cursor;
var myCursor;

var ready;

function preload(){
  cursor = loadImage("data/cursor_with_shadow_15x21.png");
}

function setup() {
  createCanvas(800, 800);
  
  ready = false;
  
  // UI elements
  //slider = createSlider(1, 5, 2);
  //slider.position(offset/2, offset-20);
  //slider.style('width', '600px');
  //slider.style("outline", "none");
  //slider.style("background", "#rgb(200, 200, 200)");
  //slider.style("height", "25px");
  
  //tempo_text = createElement('p', 'TEMPO');
  //tempo_text.style("font-family", "Helvetica-Bold");
  //tempo_text.style("font-size","16");
  //tempo_text.position(offset/2+5, offset-55);
  
  //myCursor = createImg("data/cursor_with_shadow_15x21.png", "cursor");
  //myCursor.size(90, 126);
  
  //playButton = createButton("PLAY");
  //playButton.mousePressed(playPause);
  //playButton.position(offset/2, offset/3);
  //playButton.size(280,60);
  //playButton.style("font-family","Helvetica-Bold");
  //playButton.style("font-size","16");
  //playButton.style("background-color","rgb(200, 200, 255)");
  //playButton.style("color","rgb(0, 0, 0)");
  
  //reverseButton = createButton("REVERSE");
  //reverseButton.mousePressed(backward);
  //reverseButton.position(width/2+20, offset/3);
  //reverseButton.size(300,60);
  //reverseButton.style("font-family","Helvetica-Bold");
  //reverseButton.style("font-size","16");
  //reverseButton.style("background-color","rgb(200, 200, 255)");
  //reverseButton.style("color","rgb(0, 0, 0)");

  // set up synth
  synth = new Tone.Synth().toDestination();
  
  // set up sequence
  setupNotes(mySeq);

  grid = (width-offset*2)/max(notes.length, all.length);
  
  background(253);
  drawGuidelines();
  drawSequence();
  
  curTempo = 2;
  
  seq.start();
  
}

function setupNotes(input) {
  notes = input;
  notes_with_index = [];
  for (var i = 0; i<notes.length; i++) {
    notes_with_index.push(notes[i] + "_" + str(i));
  }
  if (seq != null) {
    seq.dispose();
  }
  seq = new Tone.Sequence((time, note) => {
    synth.triggerAttackRelease(note.substring(0, 2), 0.2, time); 
    curNote = note;
  }, notes_with_index, 1);
  seq.start();
}

function drawGuidelines() {
  stroke(0);
  strokeWeight(2);
  line(offset, offset+grid, offset, height-offset);
  line(offset, height-offset, width-offset, height-offset);
}

function drawSequence(notes) {
  for (var i = 0; i < notes_with_index.length; i++) {
    var note = notes_with_index[i];
    var y = all.indexOf(note[0]);
    if (note == curNote) {
      stroke(0);
      strokeWeight(8);
      fill(255, 200, 200);
      rect(offset+grid*i, height-offset-grid*(y+1), grid-4, grid-4);
    } else {
      noStroke();
      fill(200);
      rect(offset+grid*i, height-offset-grid*(y+1), grid, grid);
    }
  }
}

function draw() {
  //if (seq.playbackRate != slider.value()) {
  //  seq.playbackRate = slider.value();
  //}
  
  background(253);
  
  
  // draw notes
  drawSequence(notes);
  drawGuidelines();
  
  // draw tempo slider  
  drawTempoSlider();
  
  image(cursor, mouseX, mouseY, 90, 126);

}

function drawTempoSlider() {
  noStroke();
  fill(200);
  rect(offset, offset+20, width-offset*2, offset/2);
  var tempolen = map(curTempo, 1, 5, 0, width-offset*2);
  fill(255, 100, 100);
  rect(offset, offset+20, tempolen, offset/2);
  textFont("Helvetica-Bold", 60);
  text("TEMPO", offset+10, offset+10);
}

function backward() {
  console.log("hello");
  
  notes = notes.reverse();
  setupNotes(notes);

  onReverse = true;
}


function playPause() {
  if (Tone.Transport.state == "started") {
    Tone.Transport.pause();
    playButton.html("PLAY");
  } else {
    Tone.Transport.start();
    playButton.html("PAUSE");
  }
}

function mousePressed() {
  if (!ready) {
    Tone.start();
    console.log("Audio ready");
    ready = true;
  }
  
  var note = 6-floor(((mouseY-(height-offset-grid*(all.length))))/grid);
  var index = floor((mouseX-offset)/grid);
  //note = constrain(note, 0, 6);
  //index = constrain(index, 0, 7);
  if (note >= 0 && note < 7 && index >= 0 && index < 8) {
    var note_l = all[note];
    mySeq[index] = note_l+"4";
    setupNotes(mySeq);
  }
}

function keyPressed() {
  if (keyCode == 32) { // white space
    saveFrames('sequencer_2', 'png', 1, 1);
  }
  
  if (keyCode == RIGHT_ARROW) {
    curTempo = min(curTempo + 0.5, 5);
    seq.playbackRate = curTempo;
  } else if (keyCode == LEFT_ARROW) {
    curTempo = max(curTempo - 0.5, 1);
    seq.playbackRate = curTempo;
  }
  
  if (keyCode == ENTER) {
    if (Tone.Transport.state == "started") {
      Tone.Transport.pause();
    } else {
      Tone.Transport.start();
    }
  }

  
}
