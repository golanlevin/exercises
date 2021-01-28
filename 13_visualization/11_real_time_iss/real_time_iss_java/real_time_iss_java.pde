PShape equirectangularWorld; 

//-----------------------------------------------------
void setup() {
  size(800, 800);
  // noLoop();
  
  // This SVG of the world is 360x180, equirectangular projection:
  equirectangularWorld = loadShape("equirectangular_medgray_nostroke.svg"); 
}

//-----------------------------------------------------
void draw() {
  background(253); 
  shapeMode(CENTER); 
  
  // We are using this API -->
  //   http://open-notify.org/Open-Notify-API/ISS-Location-Now/
  
  JSONObject json = loadJSONObject("http://api.open-notify.org/iss-now.json");
  JSONObject iss_pos = json.getJSONObject("iss_position");
  float ISS_latitude = iss_pos.getFloat("latitude"); // °North
  float ISS_longitude = iss_pos.getFloat("longitude"); // °West

  pushMatrix();
  translate(width/2, height/2); 
  float justify = height/ (float)equirectangularWorld.height;
  scale(justify); 
  
  // Draw the world.
  float dx = -4; // offset for display
  float dy = 16;
  float sc = 1.5; // scale for display
  scale(sc);
  translate(dx,dy); 
  shape(equirectangularWorld, 0,0);
  
  // Draw the ISS!
  fill(0,255,0); 
  stroke(0,0,0); 
  strokeWeight(8/(justify*sc)); 
  ellipse(ISS_longitude,0-ISS_latitude, 32/(justify*sc), 32/(justify*sc)); 
  
  // If possible, show a trail of where it has been...
  
  popMatrix();
}

//===================================
void keyPressed() {
  if (key == ' ') {
    saveFrame("real_time_iss.png");
  }
}
