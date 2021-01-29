//////////////////////////////////////////
// "Emoji Translator"                   //
// KNN Classifier + Face API            //
// Exercise on page 178 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// based on ml5.js examples:
// https://editor.p5js.org/ml5/sketches/KNNClassification_Video
// https://editor.p5js.org/ml5/sketches/FaceApi_Video_Landmarks

let video;
// Create a KNN classifier
const knnClassifier = ml5.KNNClassifier();
let faceapi;
let featureExtractor;
let confidences = {};
let currEmoji = "";
let faceBox = {x:0,y:0,w:0,h:0};
let startedPrediction = false;

var pokerFace = "😐";
var classes = [
  {emoji:"😛",label:"tongue"},
  {emoji:"😙",label:"kiss"},
  {emoji:"😱",label:"scream"},
  {emoji:"🤔",label:"think"},
  {emoji:"😊",label:"smile"},
  {emoji:"😷",label:"covid"}
]

function setup() {
  // Create a video element
  video = createCapture(VIDEO);
  // Append it to the videoContainer DOM element
  video.hide();
  
  // Create a featureExtractor that can extract the already learned features from MobileNet
  
  video.elt.onloadeddata = function(){
    featureExtractor = ml5.featureExtractor('MobileNet', modelFeatureExtractorReady);
    
    faceapi = ml5.faceApi(video, {
      withLandmarks: true,
      withDescriptors: false,
    }, modelFaceAPIReady);
  }
  createCanvas(640,480);

  // Create the UI buttons
  createButtons();
}


// Initialize the magicFeature

function modelFeatureExtractorReady(){
  select('#status').html('FeatureExtractor(mobileNet model) Loaded; ',true);
}

function modelFaceAPIReady(){
  select('#status').html('FaceAPI Loaded; ',true);
  function proc(err,result){
    if (result && result.length){
      const x = result[0].alignedRect._box._x;
      const y = result[0].alignedRect._box._y;
      const w = result[0].alignedRect._box._width;
      const h = result[0].alignedRect._box._height;
      faceBox = {x,y,w,h};
    }
    faceapi.detect(proc);
  }
  faceapi.detect(proc);
}

// Add the current frame from the video to the classifier
function addExample(label) {
  // Get the features of the input video
  const features = featureExtractor.infer(video);
  // You can also pass in an optional endpoint, defaut to 'conv_preds'
  // const features = featureExtractor.infer(video, 'conv_preds');
  // You can list all the endpoints by calling the following function
  // console.log('All endpoints: ', featureExtractor.mobilenet.endpoints)

  // Add an example with a label to the classifier
  knnClassifier.addExample(features, label);
  updateCounts();
}

// Predict the current frame.
function classify() {
  startedPrediction = true;
  
  // Get the total number of labels from knnClassifier
  const numLabels = knnClassifier.getNumLabels();
  if (numLabels <= 0) {
    console.error('There is no examples in any label');
    return;
  }
  // Get the features of the input video
  const features = featureExtractor.infer(video);

  // Use knnClassifier to classify which label do these features belong to
  // You can pass in a callback function `gotResults` to knnClassifier.classify function
  knnClassifier.classify(features, gotResults);
  // You can also pass in an optional K value, K default to 3
  // knnClassifier.classify(features, 3, gotResults);

  // You can also use the following async/await function to call knnClassifier.classify
  // Remember to add `async` before `function predictClass()`
  // const res = await knnClassifier.classify(features);
  // gotResults(null, res);
}

// A util function to create UI buttons
function createButtons() {
  var status = createDiv('');
  status.position(10,height-50);
  status.id("status");
  status.style('color', 'white');
  var savebtn = createButton(`Save Dataset`);
  savebtn.position(0,0);
  savebtn.size(120,30);
  savebtn.mousePressed(saveMyKNN);
  var loadbtn = createButton(`Load Dataset`);
  loadbtn.position(0,30);
  loadbtn.size(120,30);
  loadbtn.mousePressed(loadMyKNN);
  var nukebtn = createButton(`Clear Dataset`);
  nukebtn.position(0,60);
  nukebtn.size(120,30);
  nukebtn.mousePressed(clearAllLabels);
  var predbtn = createButton(`Start Predicting!`);
  predbtn.position(0,90);
  predbtn.size(120,60);
  predbtn.mousePressed(classify);
  
  for (var i = 0; i < classes.length; i++){
    var button = createButton(`➕ ${classes[i].emoji} (0)`);
    button.position(i*width/classes.length,height-30);
    button.size(width/classes.length,30);
    
    ;;(function(){
      var lbl = classes[i].label; 
      var btn = button;
      btn.id(`add${lbl}`);
      btn.mousePressed(function(){addExample(lbl)});
    })();
  }
}

// Show the results
function gotResults(err, result) {
  // Display any error
  if (err) {
    console.error(err);
  }
  if (result){
    confidences = result.confidencesByLabel
    
    if (result.classIndex == undefined){
      result.classIndex = Number(result.label);
    }
    currEmoji = classes[result.classIndex].emoji || pokerFace;
  }
  classify();
}

// Update the example count for each label	
function updateCounts() {
  const counts = knnClassifier.getCountByLabel();
  for (var i = 0; i < classes.length; i++){
    select('#add'+classes[i].label).html(
      `➕ ${classes[i].emoji} (${counts[classes[i].label] || 0})`
    );
  } 
}

// Clear the examples in one label
function clearLabel(label) {
  knnClassifier.clearLabel(label);
  updateCounts();
}

// Clear all the examples in all labels
function clearAllLabels() {
  knnClassifier.clearAllLabels();
  updateCounts();
}

// Save dataset as myKNNDataset.json
function saveMyKNN() {
  knnClassifier.save('myKNNDataset');
}

// Load dataset to the classifier
function loadMyKNN() {
  knnClassifier.load('./myKNNDataset.json', updateCounts);
}


function draw(){
  image(video,0,0,width,height);
  for (var i = 0; i < classes.length; i++){
    var conf = confidences[classes[i].label] || 0;
    fill(0,0,255);
    noStroke();
    rect(width-100,i*20+8,conf*100,16);
    fill(255);
    text(classes[i].emoji+" "+(~~(conf*1000)/10)+"%",width-100,i*20+20);
  }
  push();
  noFill();
  stroke(0,0,255);
  strokeWeight(1);
  rect(faceBox.x,faceBox.y,faceBox.w,faceBox.h);
  if (startedPrediction){
    textSize((faceBox.w+faceBox.h)/2);
    textAlign(CENTER,CENTER);
    text(currEmoji,faceBox.x+faceBox.w/2,faceBox.y+faceBox.h/2);
  }
  pop();
  
}

