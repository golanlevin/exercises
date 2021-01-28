import java.util.Arrays;
PImage img;


void setup() {
  size(800, 800);
  img = loadImage("jzg.jpg");
  
  img.loadPixels();
  
  Color[] sortedColors = new Color[img.width*img.height];
  for (int i = 0; i < sortedColors.length; i++) {
    sortedColors[i] = new Color(img.pixels[i]);
  }
  
  Arrays.sort(sortedColors);
  
  for (int i = 0; i < sortedColors.length; i++) {
    img.pixels[i] = sortedColors[i].c;
  }
  
  img.updatePixels();
  
  image(img, 0, 0);
}

void draw() {
}


class Color implements Comparable<Color> {
    // variables
    // constructor
    // getters and setters
    
    color c;
    
    public Color(color cc) {
      c = cc;
    }
 
    //@Override
    //public int compareTo(Color cc) {
    //    return Float.compare(red(cc.c)+green(cc.c)+blue(cc.c), red(this.c)+green(this.c)+blue(this.c));
    //}
    
    //@Override
    //public int compareTo(Color cc) {
    //    return Float.compare(hue(cc.c), hue(this.c));
    //}
    
    //@Override
    //public int compareTo(Color cc) {
    //    return Float.compare(saturation(cc.c), saturation(this.c));
    //}
    
    @Override
    public int compareTo(Color cc) {
        return Float.compare(brightness(cc.c), brightness(this.c));
    }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("pixel_sorting.png");
  }
}
