IntList xPoints;
IntList yPoints;
int up = 2;

void setup() {
  size(2000, 1000, P3D);
  smooth(8);
  frameRate(5);
  camera(5000, 0, -1500, 0, 0, 1000, 0, 1, 0);
 // camera(-2500, -2500, -5000, 0, 0, 0, 0, 1, 0);
  xPoints = new IntList();
  yPoints = new IntList();

//  rect(0, 0, 2000, 1000);

  // draw first pentagon
  int xOrigin = 500;
  int yOrigin = 500;
  int rOrigin = 5;
  fill(0, 30);
  stroke(250, 100);

  beginShape();
  for (int i = 0; i < 5; i++)
  {
    int a = int(xOrigin + rOrigin * cos(radians(72 * i)));
    int b = int(yOrigin + rOrigin * sin(radians(72 * i)));
    vertex(a,b);
    xPoints.append(a);
    yPoints.append(b);
  }
  endShape(CLOSE);
}

void draw() {
  // select random point of the available ones and remove it from the list of available points
  int point1 = int(random(xPoints.size()-1));
  int xVal1 = xPoints.get(point1);
  int yVal1 = yPoints.get(point1);
  xPoints.remove(point1);
  yPoints.remove(point1);

  // select a second random point of the available ones and remove it from the list of available points
  int point2 = int(random(xPoints.size()-1));
  int xVal2 = xPoints.get(point2);
  int yVal2 = yPoints.get(point2);
  xPoints.remove(point2);
  yPoints.remove(point2);

  // break loop and save screenshot if distance between points is >= 3000
  if (dist(xVal1, yVal1, xVal2, yVal2) < 6000) {
    createPentagon(xVal1, yVal1, xVal2, yVal2);
  }
  else {
    noLoop();
    saveFrame();    
  }
}

void createPentagon(int xStartValue1, int yStartValue1, int xStartValue2, int yStartValue2) {

  int e_x = xStartValue2 - xStartValue1;
  int e_y = yStartValue2 - yStartValue1;
  println("up: "+up);
  colorMode(HSB, 500);
  color c = color((yStartValue1)-400, 500, 500);
  fill(c, 40);
  stroke(500, 400);
 
  beginShape();
    vertex(xStartValue1, yStartValue1, up);
    vertex(xStartValue2, yStartValue2, up);
    int x1 = xStartValue2;
    int y1 = yStartValue2;
    int x2 = 0;
    int y2 = 0;
    for (int i=1; i<4; i++) {
      x2 = int(x1 + (cos(i*0.4*PI) * e_x - sin(i*0.4*PI) * e_y));
      y2 = int(y1 + (sin(i*0.4*PI) * e_x + cos(i*0.4*PI) * e_y));
      vertex(x2, y2, up);
      xPoints.append(x2);
      yPoints.append(y2);
      x1 = x2;
      y1 = y2;
    }
  endShape(CLOSE);
  up = up + 10 + int(up * 0.1);

  beginShape();
    vertex(xStartValue1, yStartValue1, up);
    vertex(xStartValue2, yStartValue2, up);
    x1 = xStartValue2;
    y1 = yStartValue2;
    x2 = 0;
    y2 = 0;
    for (int i=1; i<4; i++) {
      x2 = int(x1 + (cos(i*0.4*PI) * e_x - sin(i*0.4*PI) * e_y));
      y2 = int(y1 + (sin(i*0.4*PI) * e_x + cos(i*0.4*PI) * e_y));
      vertex(x2, y2, up);
      x1 = x2;
      y1 = y2;
    }
   endShape(CLOSE);
}
