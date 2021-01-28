//mapping of international space station location

var world;
var iss;

function preload() {

  world = loadImage("world1.jpg");

  var url = 'http://api.open-notify.org/iss-now.json';
  iss = loadJSON(url);
}

function setup() {
  createCanvas(400, 400);
  noStroke();

}

function draw() {

  image(world, 0, 00, 805, 400);
  // get the location of iss
  var lat = iss.iss_position.latitude;
  console.log("lat:" + lat);
  console.log("lon:" + lon);
  var lon = iss.iss_position.longitude;
  lat = map(lat, -90, 90, height, 0);
  lon = map(lon, -180, 180, 0, width);

  fill(100, 150, 150, 100); // use the humidity value to set the alpha
  ellipse(lon, lat, 50, 50);
}

function keyPressed() {
  saveCanvas('myCanvas', 'png');
}