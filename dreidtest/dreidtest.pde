import shapes3d.utils.*;
import shapes3d.*;
import peasy.*;

PeasyCam cam;
ArrayList<Extrusion> eArray = new ArrayList<Extrusion>();
Path path;
Contour contour;
ContourScale conScale;
FloatList xPoints = new FloatList();
FloatList yPoints = new FloatList();

public void setup() {
  size(800, 800, P3D);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(2000);
  smooth(8);
  volumeConstructor(60, 5, 3);
}

public void draw() {
  cam.beginHUD();
  fill(0, 40);
  rect(0, 0, 800, 800);
  cam.endHUD();
  println("starting draw");
  for (int i=0; i < eArray.size(); i++) {
    println("extrusion #" + i);
    Extrusion e = eArray.get(i);
    e.draw();
  }
  println("draw done");
}

public void volumeConstructor(int sliceNumber, float rOrigin, int sliceThickness) {
  int lastSize = 200;
  int currentSize;
  int point1;
  int point2;
  float xVal1;
  float yVal1;
  float xVal2;
  float yVal2;
  int layer = sliceThickness;

  // create base pentagon points
  for (int i = 0; i < 5; i++) {
    xPoints.append(rOrigin * cos(radians(72 * i)));
    yPoints.append(rOrigin * sin(radians(72 * i)));
  }
  // create a number of pentagon extrusions
  for (int i=0; i<sliceNumber; i++) {
    //repeat the selection process until the size of the new pentagon extrusion is not larger than 1.5 times the last one
    do {
      // select random point of the available ones
      point1 = int(random(xPoints.size()-1));
      xVal1 = xPoints.get(point1);
      yVal1 = yPoints.get(point1);
      // select a second random point of the available ones
      point2 = int(random(xPoints.size()-1));
      xVal2 = xPoints.get(point2);
      yVal2 = yPoints.get(point2);
      currentSize = int(dist(xVal1, yVal1, xVal2, yVal2));
      println("looped "+ (i+1) +" times");
    } while (currentSize >= lastSize*1.5); 
    // delete the used points from the list of available points
    xPoints.remove(point1);
    yPoints.remove(point1);
    xPoints.remove(point2);
    yPoints.remove(point2);
    // update the lastSize for the next Slice
    if (currentSize>100) {
      lastSize = currentSize;
    }
    // create Extrusion via Shapes3D
    path = new P_LinearPath(new PVector(0, sliceThickness+layer, 0), new PVector(0, layer, 0));
    layer = layer + sliceThickness;
    contour = getShape(xVal1, yVal1, xVal2, yVal2);
    conScale = new CS_ConstantScale();
    eArray.add(new Extrusion(this, path, 1, contour, conScale));    
  }
println("volume creation end");
}


public Contour getShape(float x1, float y1, float x2, float y2) {
  float e_x = x2 - x1;
  float e_y = y2 - y1;
  float x3 = x2 + (cos(1*0.4*PI) * e_x - sin(1*0.4*PI) * e_y);
  float y3 = y2 + (sin(1*0.4*PI) * e_x + cos(1*0.4*PI) * e_y);
  xPoints.append(x3);
  yPoints.append(y3);
  float x4 = x3 + (cos(2*0.4*PI) * e_x - sin(2*0.4*PI) * e_y);
  float y4 = y3 + (sin(2*0.4*PI) * e_x + cos(2*0.4*PI) * e_y);
  xPoints.append(x4);
  yPoints.append(y4);
  float x5 = x4 + (cos(3*0.4*PI) * e_x - sin(3*0.4*PI) * e_y);
  float y5 = y4 + (sin(3*0.4*PI) * e_x + cos(3*0.4*PI) * e_y);
  xPoints.append(x5);
  yPoints.append(y5);
  PVector[] c = new PVector[] {
    new PVector(x1, y1),
    new PVector(x2, y2),
    new PVector(x3, y3),
    new PVector(x4, y4),
    new PVector(x5, y5)
  };
  return new eShape(c);
}

public class eShape extends Contour {
  public eShape(PVector[] c) {
    this.contour = c;
  }
}



