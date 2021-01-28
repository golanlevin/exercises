import java.util.Arrays;
import java.util.Comparator;

public class Rectangle {
  public int x;  //
  public int y;
  public int w;
  public int h;
  public color c;

  // Create a class constructor for the MyClass class
  public Rectangle(int xx, int yy, int ww, int hh, color cc) {
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    c = cc;
  }
  
  public int getArea() {
    return w*h;
  }
  
  public int getLeft() {
    return x;
  }

}

public class RectangleComparatorByArea implements Comparator<Rectangle> {
    public int compare(Rectangle r1, Rectangle r2) {
        return r2.getArea() - r1.getArea();
    }
}

public class RectangleComparatorByLeftSide implements Comparator<Rectangle> {
    public int compare(Rectangle r1, Rectangle r2) {
        return r1.getLeft() - r2.getLeft();
    }
}
