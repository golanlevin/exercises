//////////////////////////////////////////
// "What Do You See?"                   //
// Obj. Recognition + TTS               //
// Exercise on page 178 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

//based on ml5.js example:
//https://editor.p5js.org/ml5/sketches/ObjectDetector_COCOSSD_Video


let useCam = true;       // use webcam instead of stock footage ?
let video;               // the video to be processed
let detector;            // object detector neural net
let detections = [];     // list of detections
let prevDetections = []; // previous detections (for finding difference)
let description = "";    // description of the detections

// urls of some interesting stock footage:
let videoURLs = [
  "https://upload.wikimedia.org/wikipedia/commons/0/08/Manchester_Street_Scene_%281901%29.webm",
  "https://upload.wikimedia.org/wikipedia/commons/6/68/A_Trip_Down_Market_Street_%28High_Res%29.webm",
]


// count the objects in the detection for making the description
function getCountedObjects(){
  var counted = {};
  for (var i = 0; i < detections.length; i++){
    var lbl = detections[i].label;
    if (!counted[lbl]) counted[lbl] = 0;
    counted[lbl]++;
  }
  return counted;
}

// check if the new detection is any different from previous detection
// (to determine if a new description needs to be synthesized)
function gotSomethingDifferent(){
  if (prevDetections.length != detections.length){
    return true;
  }
  var prev = getCountedObjects(prevDetections);
  var curr = getCountedObjects(detections);
  for (var k in curr){
    if (curr[k] !== prev[k]){
      return true;
    }
  }
  for (var k in prev){
    if (prev[k] !== curr[k]){
      return true;
    }
  }
  return false;
}

// callback for receiving a detection from the neural net
function gotDetections(error, results) {
  if (error) {
    console.error(error);
  }
  prevDetections = detections;
  detections = results || [];
  if (gotSomethingDifferent()){
    describe();
  }
  detector.detect(video, gotDetections);
}

// when neural net model is loaded:
function modelReady() {
  print("model ready.");
  detector.detect(video, gotDetections);
  
  // say the description every 10 seconds,
  // even if there's no change in frame content
  setInterval(describe,10000);
}

// generate a description and say it with 
// Web text-to-speech API
function describe(){
  description = "I see";
  
  // apply English grammar rules to construct a sentence
  if (detections.length){
    var counted = getCountedObjects(detections);
    var names = Object.keys(counted);
    var pluraleTantum = [
      "scissors","pants","trousers","glasses",
      "spectacles","panties","jeans","chopsticks",
      "shorts","boxers","briefs","tights","pyjamas",
      "pliers","tongs","tweezers","binoculars",
      "goggles","sunglasses","contact lenses",
      "headphones","earphones","earbuds","earmuffs",
      "skis",
    ];
    var irregularPlural = { // just some common ones
      mouse:"mice",louse:"lice",ox:"oxen",axis:"axes",
      goose:"geese",tooth:"teeth",foot:"feet",child:"children",
      dice:"dice",die:"dice",potato:"potatoes",tomato:"tomatoes",
      deer:"deer",swine:"swine",sheep:"sheep",moose:"moose"
    }
    for (var i = 0; i < names.length; i++){
      var name = names[i];
      var n = counted[name];
      var numeral;
      if (n == 1){
        numeral = "a";
        if (!pluraleTantum.includes(name)){
          if (['a','e','i','o','u'].includes(name[0])){
            if (name.startsWith("uni") || name.startsWith("eu")){
            }else{
              numeral += "n";
            }
          }
        }else{
          name = "pair of "+name;
        }
      }else{
        numeral = [
          "zero","one","two","three","four","five","six",
          "seven","eight","nine","ten","eleven","twelve"
        ][n] || "many";
        if (irregularPlural[name]){
          name = irregularPlural[name];
        }else if (pluraleTantum.includes(name)){
          name = "pairs of "+name;
        }else{
          if (['x','s','z'].includes(name[name.length-1])
               || name.endsWith('sh') || name.endsWith('ch')
             ){
            name += "e";
          }
          if (name.endsWith('f')||name.endsWith('fe')){
            name = name.slice(0,name.length-1-name.endsWith('fe'))+"ve";
          }
          if (name[name.length-1]=="y" && !['a','e','i','o','u'].includes(name[name.length-2])){
            name = name.slice(0,name.length-1)+"ie";
          }
          name += "s";
          if (name.endsWith('mans')){
            name = name.slice(0,name.length-4)+"men";
          }
        }
      }
      description += (i != 0 && i == names.length-1) ? " and ": " ";
      description += numeral + " " + name;
      description += (i == names.length-1) ? "." : ",";
    }
  }else{
    description += " nothing."
  }
  print(description);
  
  // synthesize with text to speech.
  // currently, the utterance is skipped if there's already something being voiced.
  // see below for alternative behaviors:
  
  // uncomment the line below to interrupt previous utterance
  // speechSynthesis.cancel();
  
  // comment out the if condition to queue up the utterance
  if (!speechSynthesis.pending){
    speechSynthesis.speak(new SpeechSynthesisUtterance(description));
  }
}

// test the English grammar rules
function testDescription(){
  detections = [ // some hard plurals
    {label:"toy"},{label:"factory"},{label:"ox"},{label:"mouse"},
    {label:"knife"},{label:"leaf"},{label:"firewoman"},{label:"scissors"},
    {label:"photo"},{label:"potato"},{label:"tooth"},{label:"toothbrush"},
  ]
  detections = detections.concat(detections);
  detections = detections.concat([ // some hard singulars
    {label:"unicycle"},{label:"apple"},{label:"goggles"},
  ])
  describe();
  print(description);
  detections = [];
}

//--------------------------------------------


function setup() {
  createCanvas(640, 520);

  if (useCam){
    video = createCapture(VIDEO);
    video.size(640, 480);
  }else{
    video = createVideo([videoURLs[1]]);
    video.loop();
  }
  video.hide();
  
  video.elt.onloadeddata = function(){
    print("video loaded.");
    // Models available are 'cocossd', 'yolo'
    detector = ml5.objectDetector('cocossd', modelReady);
  }    
  
  // uncomment the line below to test English grammar rules
  // testDescription();
}


//--------------------------------------------

function draw() {

  // draw the video frame and the description
  
  fill(0,50);
  rect(0,0,width,height);
  image(video, 0, 0);
  fill(255);
  noStroke();
  textSize(32);
  text(description,10,height-8);
  
  // draw the detection boxes and labels
  
  for (let i = 0; i < detections.length; i++) {
    let object = detections[i];
    stroke(255);
    noFill();
    rect(object.x, object.y, object.width, object.height);
    noStroke();
    fill(255);
    textSize(12);
    text(object.label, object.x + 4, object.y + 12);
  }
}