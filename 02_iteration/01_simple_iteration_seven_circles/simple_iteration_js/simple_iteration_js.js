
function setup(){
  createCanvas(800, 800);
  background (253); 
  fill(229); 
  
  strokeWeight(8); 
  y = height * (1.0 - 0.61803398875); 

  //draws 7 circles
  for (var i=0; i<7; i++) {
    //sets space between circle centers to 50
    var x = 100 + i*100;
    //draws circles of radius 30
    ellipse(x, y, 60, 60);
  }
}
