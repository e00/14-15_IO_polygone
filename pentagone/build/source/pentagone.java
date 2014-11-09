import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pentagone extends PApplet {

IntList xPoints;
IntList yPoints;

public void setup() {
  size(2000, 1000);
  smooth(8);
  frameRate(5);
  xPoints = new IntList();
  yPoints = new IntList();

// draw first pentagon
  int xOrigin = 500;
  int yOrigin = 500;
  int rOrigin = 5;
  fill(0, 30);
  stroke(250, 100);

  beginShape();
  for (int i = 0; i < 5; i++)
  {
    int a = PApplet.parseInt(xOrigin + rOrigin * cos(radians(72 * i)));
    int b = PApplet.parseInt(yOrigin + rOrigin * sin(radians(72 * i)));
    vertex(a,b);
    xPoints.append(a);
    yPoints.append(b);
  }
  endShape(CLOSE);
  
}

public void draw() {
  // select random point of the available ones and remove it from the list of available points
  int point1 = PApplet.parseInt(random(xPoints.size()-1));
  int xVal1 = xPoints.get(point1);
  int yVal1 = yPoints.get(point1);
  xPoints.remove(point1);
  yPoints.remove(point1);

  // select a second random point of the available ones and remove it from the list of available points
  int point2 = PApplet.parseInt(random(xPoints.size()-1));
  int xVal2 = xPoints.get(point2);
  int yVal2 = yPoints.get(point2);
  xPoints.remove(point2);
  yPoints.remove(point2);

  // break loop and save screenshot if distance between points is > 3000
  if (dist(xVal1, yVal1, xVal2, yVal2) < 3000) {
    createPentagon(xVal1, yVal1, xVal2, yVal2);
  }
  else {
    noLoop();
    saveFrame();    
  }
}

public void createPentagon(int xStartValue1, int yStartValue1, int xStartValue2, int yStartValue2) {

  int e_x = xStartValue2 - xStartValue1;
  int e_y = yStartValue2 - yStartValue1;
  
  colorMode(HSB, 500);
  int c = color((yStartValue1)-400, 500, 500);
  fill(c, 20);
  stroke(500, 200);
  
  beginShape();
    vertex(xStartValue1, yStartValue1);
    vertex(xStartValue2, yStartValue2);
    int x1 = xStartValue2;
    int y1 = yStartValue2;
    int x2 = 0;
    int y2 = 0;
    for (int i=1; i<4; i++) {
      x2 = PApplet.parseInt(x1 + (cos(i*0.4f*PI) * e_x - sin(i*0.4f*PI) * e_y));
      y2 = PApplet.parseInt(y1 + (sin(i*0.4f*PI) * e_x + cos(i*0.4f*PI) * e_y));
      vertex(x2, y2);
      xPoints.append(x2);
      yPoints.append(y2);
      x1 = x2;
      y1 = y2;
    }
  endShape(CLOSE);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pentagone" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
