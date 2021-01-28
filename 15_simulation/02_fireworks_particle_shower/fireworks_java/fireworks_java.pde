// ref:
// https://github.com/CodingTrain/website/tree/master/CodingChallenges/CC_027_FireWorks/Processing/CC_027_FireWorks_2D
// 
// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain


ArrayList<Firework> fireworks;

PVector gravity = new PVector(0, 0.2);

void setup() {
  size(800, 800, P2D);
  fireworks = new ArrayList<Firework>();
  colorMode(RGB);
  background(253);
}

void draw() {
  background(253);
  
  if (random(1) < 0.2) {
    fireworks.add(new Firework());
  }
  
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
  
}
