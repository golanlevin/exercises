// Transform a circle to a triangle
// by approximating a circle with 
// three Bezier cubic splines and 
// modulating the spline control points
// Golan Levin, January 2017

// Ref:
// Golan Levin, January 2017
// https://github.com/golanlevin/circle-morphing/blob/master/circle-to-triangle/circle02/sketch.js

float radius1;
float radius2;
float radius3;
float radius4;
float radius5;
float cx;
float cy;
PVector[] trianglePoints1;
PVector[] trianglePoints2;
PVector[] trianglePoints3;
PVector[] trianglePoints4;
PVector[] trianglePoints5;

boolean bShowDebug = false;

void setup() {
  size(800, 800);
  
  trianglePoints1 = new PVector[3];
  trianglePoints2 = new PVector[3];
  trianglePoints3 = new PVector[3];
  trianglePoints4 = new PVector[3];
  trianglePoints5 = new PVector[3];

  radius1 = width / 2 * 0.25;
  radius2 = width / 2 * 0.4;
  radius3 = width / 2 * 0.5;
  radius4 = width / 2 * 0.6;
  radius5 = width / 2 * 0.7;

  cx = width / 2;
  cy = height / 2;

  for (int i = 0; i < 3; i++) { // triangle vertices
    float x = cx + radius1 * cos(i * TWO_PI / 3.0 - HALF_PI);
    float y = cy + radius1 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints1[i] = new PVector(
      x, y
    );
    x = cx + radius2 * cos(i * TWO_PI / 3.0 - HALF_PI);
    y = cy + radius2 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints2[i] = new PVector(
      x, y
    );
    x = cx + radius3 * cos(i * TWO_PI / 3.0 - HALF_PI);
    y = cy + radius3 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints3[i] = new PVector(
      x, y
    );
    x = cx + radius4 * cos(i * TWO_PI / 3.0 - HALF_PI);
    y = cy + radius4 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints4[i] = new PVector(
      x, y
    );
    x = cx + radius5 * cos(i * TWO_PI / 3.0 - HALF_PI);
    y = cy + radius5 * sin(i * TWO_PI / 3.0 - HALF_PI);
    trianglePoints5[i] = new PVector(
      x, y
    );
    
  }
  
  background(253);
  noFill();

  //angle

  float amount1 = 0;
  float amount2 = 0.2;
  float amount3 = 0.4;
  float amount4 = 0.6;
  float amount5 = 0.77;

  stroke(0);
  strokeWeight(8);
  strokeJoin(MITER);
  
  for (int i = 0; i < 3; i++) {
    float p0x = trianglePoints1[i].x;
    float p0y = trianglePoints1[i].y;
    float p3x = trianglePoints1[(i + 2) % 3].x;
    float p3y = trianglePoints1[(i + 2) % 3].y;
    float p1x = p0x + (amount1 * (p0y - cy));
    float p1y = p0y - (amount1 * (p0x - cx));
    float p2x = p3x - (amount1 * (p3y - cy));
    float p2y = p3y + (amount1 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);
    
    p0x = trianglePoints2[i].x;
    p0y = trianglePoints2[i].y;
    p3x = trianglePoints2[(i + 2) % 3].x;
    p3y = trianglePoints2[(i + 2) % 3].y;
    p1x = p0x + (amount2 * (p0y - cy));
    p1y = p0y - (amount2 * (p0x - cx));
    p2x = p3x - (amount2 * (p3y - cy));
    p2y = p3y + (amount2 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);

    p0x = trianglePoints3[i].x;
    p0y = trianglePoints3[i].y;
    p3x = trianglePoints3[(i + 2) % 3].x;
    p3y = trianglePoints3[(i + 2) % 3].y;
    p1x = p0x + (amount3 * (p0y - cy));
    p1y = p0y - (amount3 * (p0x - cx));
    p2x = p3x - (amount3 * (p3y - cy));
    p2y = p3y + (amount3 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);
    
    p0x = trianglePoints4[i].x;
    p0y = trianglePoints4[i].y;
    p3x = trianglePoints4[(i + 2) % 3].x;
    p3y = trianglePoints4[(i + 2) % 3].y;
    p1x = p0x + (amount4 * (p0y - cy));
    p1y = p0y - (amount4 * (p0x - cx));
    p2x = p3x - (amount4 * (p3y - cy));
    p2y = p3y + (amount4 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);
    
    p0x = trianglePoints5[i].x;
    p0y = trianglePoints5[i].y;
    p3x = trianglePoints5[(i + 2) % 3].x;
    p3y = trianglePoints5[(i + 2) % 3].y;
    p1x = p0x + (amount5 * (p0y - cy));
    p1y = p0y - (amount5 * (p0x - cx));
    p2x = p3x - (amount5 * (p3y - cy));
    p2y = p3y + (amount5 * (p3x - cx));
    bezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y);
  }
  
  
}
