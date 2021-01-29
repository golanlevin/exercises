import geomerative.*;

RShape myShapeGroup;
RPoint[] points;

void setup() {
  size(800, 800);
  smooth();

  RG.init(this);
  myShapeGroup = RG.getText("G", "RobotoCondensed-Bold.ttf", 600, CENTER);
}

void draw() {
  background(253);
  fill(230); 
  stroke(0); 
  strokeWeight(2);
  strokeJoin(ROUND);

  RG.setPolygonizer(RG.ADAPTATIVE);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(1.5);
  int nGlyphs = myShapeGroup.children.length; 

  //------------------
  // Draw unmodified glyph
  for (int g=0; g<nGlyphs; g++) {
    RShape aGlyph = myShapeGroup.children[g];
    RPoint[] points = aGlyph.getPoints();
    int nPoints = points.length; 

    beginShape();
    for (int i=0; i<nPoints; i++) {
      float px = points[i].x;
      float py = points[i].y;
      px += width*0.235; 
      py += height*0.75; 
      vertex(px, py);
    }
    endShape(CLOSE);
  }

  //------------------
  // Draw modified glyph
  for (int g=0; g<nGlyphs; g++) {
    RShape aGlyph = myShapeGroup.children[g];
    RPoint[] points = aGlyph.getPoints();
    int nPoints = points.length; 

    float amplitude = 6.0; 
    float frequency = 37; 
    beginShape();
    for (int i=0; i<nPoints; i++) {
      float px = points[i].x;
      float py = points[i].y;

      // Make it puffy
      float t = map(i, 0, nPoints, 0, TWO_PI); 
      px += amplitude * sin(frequency*t);
      py += amplitude * cos(frequency*t + PI);

      px += width*0.70; 
      py += height*0.75; 
      vertex(px, py);
    }
    endShape(CLOSE);
  }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("glyph_hacking.png");
  }
}
