// Composition C (No.III) with Red, Yellow and Blue
// https://www.wikiart.org/en/piet-mondrian/composition-c-no-iii-with-red-yellow-and-blue-1935

void setup() {
  size(800, 800);
}

void draw() {
  background(253);
  
  noStroke();
  fill(231, 6, 4);
  rect(0, 0, width * 5/11, height*10/24);
  fill(253, 213, 4);
  rect(0, height*15/23, width * 2/19, height);
  fill(23, 13, 92);
  rect(width * 5/11, height*15/23, width * 10/13-width * 5/11, height * 22/23-height*15/23);
  
  stroke(0);
  strokeWeight(18);
  line(0, height*10/24, width, height*10/24);
  line(0, height*15/23, width, height*15/23);
  stroke(14);
  line(width * 5/11, height*10/24, width * 5/11, height*15/23);
  strokeWeight(12);
  line(width * 5/11 + 2, 0, width * 5/11+ 2, height*10/24);
  strokeWeight(14);
  line(width * 5/11+1, height*15/23, width * 5/11+1, height);
  strokeWeight(12);
  line(width * 2/19, height*15/23, width * 2/19, height);
  strokeWeight(13);
  line(width * 10/13, height*15/23, width * 10/13, height);
  strokeWeight(14);
  line(width * 5/11+1, height * 22/23, width * 10/13-1, height * 22/23);

}

void keyPressed() {
  if (key == ' '){
    saveFrame("mondrian.png");
  }
}
