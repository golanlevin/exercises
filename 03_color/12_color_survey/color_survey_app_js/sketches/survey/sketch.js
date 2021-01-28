//////////////////////////////////////////
// "Color Survey"                       //
// Exercise on page 156 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// hosted on: https://color-survey.glitch.me/

// This is the surveyor, see viewer for the viewer

var prompts = ["mauve","teal","plum"]; // controversial color names
var answers = new Array(prompts.length*3); // r,g,b,r,g,b,r,g,b
  
var db; //database
var isMouseOverSubmitButton = false;

function setup(){
  createCanvas(512,512);

  // initialize with random colors
  for (var i = 0; i < answers.length; i++){
    answers[i] = random(1);
  }
}

// check if mouse is over a rectangular region
function isMouseOver(x,y,w,h){
  return (x <= mouseX && mouseX <= x+w && y <= mouseY && mouseY <= y+h);
}

// simplistic vertical slider
function slider(container,idx,x,y,w,h,col){
  fill(50);
  stroke(0);
  rect(x,y,w,h);
  fill(col);
  H = h*container[idx];
  rect(x,y+h-H,w,H);
  fill(255);
  stroke(0);
  rect(x-4,y+h-H-8,w+8,16);
  if (mouseIsPressed){
    if (isMouseOver(x,y,w,h)){
      var v = 1-(mouseY-y)/h;
      container[idx] = v;
    }
  }
}

function submitButton(x,y,w,h){
  push();
  fill(255);
  stroke(0);
  if (isMouseOverSubmitButton = isMouseOver(x,y,w,h)){//not accidental
    cursor(HAND);
    fill(255,255,0);
  }else{
    cursor(ARROW);
  }
  rect(x,y,w,h);
  fill(0);
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(h*0.75);
  text("Submit",x+w/2,y+h*0.5);
  pop();
}

function draw(){
  
  // drawing parameters
  var pad = 10;
  var pickerHeight = height-60;
  var buttonHeight = height-pickerHeight-pad*2;
  var panelWidth = width/prompts.length;
  var sliderWidth = (panelWidth-pad*4)/3;
  var textHeight = 30;
  var wellWidth = panelWidth-pad*2;
  var sliderHeight = pickerHeight-pad*4-wellWidth-textHeight;
  
  background(204);
  // draw the color picker
  for (var i = 0; i < prompts.length; i++){
    push();
    fill(255);
    stroke(0);
    rect(i*panelWidth,0,panelWidth,pickerHeight);
    fill(answers[i*3]*255,answers[i*3+1]*255,answers[i*3+2]*255);
    rect(i*panelWidth+pad,pad*2+textHeight,wellWidth,wellWidth);
    
    slider(answers,i*3+0,i*panelWidth+pad,pad*3+textHeight+wellWidth,sliderWidth,sliderHeight,color(255,0,0));
    slider(answers,i*3+1,i*panelWidth+pad+sliderWidth+pad,pad*3+textHeight+wellWidth,sliderWidth,sliderHeight,color(0,255,0));
    slider(answers,i*3+2,i*panelWidth+pad+(sliderWidth+pad)*2,pad*3+textHeight+wellWidth,sliderWidth,sliderHeight,color(0,0,255));

    fill(0);
    noStroke();
    textSize(textHeight);
    text(prompts[i],i*panelWidth+pad,pad+textHeight);
    pop();
  }
  
  submitButton(pad,pickerHeight+pad,width-pad*2,buttonHeight);
}

function mousePressed(){ // or mouseClicked(), which seems to have janky behaviour

  // check if user pressed the submit button
  if (isMouseOverSubmitButton){
    var req = new XMLHttpRequest();
    req.open( "GET",
       "/push"
      +"?colors="+JSON.stringify(answers)
      ,false // sync
    );
    req.send( null );
    alert("Submitted! Taking you to the viewer now...");
    window.location.href = "/viewer"
  }
}