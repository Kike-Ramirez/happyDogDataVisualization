// new comment from Kike

//ljdhsfhjezmbhf

XML xml;
int pos;
PImage bg;
int maxVal;
FloatList axList,ayList,azList,gxList,gyList,gzList,mxList,myList,mzList,exList,eyList,ezList;
IntList happyList;
float normAx,normAy,normAz,normGx,normGy,normGz,normMx,normMy,normMz,normEx,normEy,normEz;
float sumAx,sumAy,sumAz,sumGx,sumGy,sumGz,sumMx,sumMy,sumMz,sumEx,sumEy,sumEz;
float normAvgAx,normAvgAy,normAvgAz,normAvgGx,normAvgGy,normAvgGz,normAvgMx,normAvgMy,normAvgMz,normAvgEx,normAvgEy,normAvgEz;
float smoothAx,smoothAy,smoothAz,smoothGx,smoothGy,smoothGz,smoothMx,smoothMy,smoothMz,smoothEx,smoothEy,smoothEz;
float smoothAvgAx,smoothAvgAy,smoothAvgAz,smoothAvgGx,smoothAvgGy,smoothAvgGz,smoothAvgMx,smoothAvgMy,smoothAvgMz,smoothAvgEx,smoothAvgEy,smoothAvgEz;
float smoothM,smoothM2;
PFont regF;
PFont boldF;

void setup() {
  size(450,800);
  xml = loadXML("raw_final.xml");
  bg = loadImage("perrito.png");
  regF = createFont("gt-walsheim-regular-web.otf",12);
  boldF = createFont("GT-Walsheim-Bold.ttf",54);
  smooth();

  maxVal = 250;

  axList = new FloatList();
  ayList = new FloatList();
  azList = new FloatList();
  gxList = new FloatList();
  gyList = new FloatList();
  gzList = new FloatList();
  mxList = new FloatList();
  myList = new FloatList();
  mzList = new FloatList();
  exList = new FloatList();
  eyList = new FloatList();
  ezList = new FloatList();
  happyList = new IntList();

  fillList();
}

void draw() {
  pos++;
  background(255);
  
  testDraw();
    
  XML[] children = xml.getChildren("Measure");
  float ax = children[pos].getFloat("ax");
  float ay = children[pos].getFloat("ay");
  float az = children[pos].getFloat("az");
  float gx = children[pos].getFloat("gx");
  float gy = children[pos].getFloat("gy");
  float gz = children[pos].getFloat("gz");
  float mx = children[pos].getFloat("mx");
  float my = children[pos].getFloat("my");
  float mz = children[pos].getFloat("mz");
  float ex = children[pos].getFloat("ex");
  float ey = children[pos].getFloat("ey");
  float ez = children[pos].getFloat("ez");
  int happy = children[pos].getInt("happy");

  normAx = ((ax - axList.min())*maxVal)/(axList.max()-axList.min());
  normAy = ((ay - ayList.min())*maxVal)/(ayList.max()-ayList.min());
  normAz = ((az - azList.min())*maxVal)/(azList.max()-azList.min());
  normGx = ((gx - gxList.min())*maxVal)/(gxList.max()-gxList.min());
  normGy = ((gy - gyList.min())*maxVal)/(gyList.max()-gyList.min());
  normGz = ((gz - gzList.min())*maxVal)/(gzList.max()-gzList.min());
  normMx = ((mx - mxList.min())*maxVal)/(mxList.max()-mxList.min());
  normMy = ((my - myList.min())*maxVal)/(myList.max()-myList.min());
  normMz = ((mz - mzList.min())*maxVal)/(mzList.max()-mzList.min());
  normEx = ((ex - exList.min())*maxVal)/(exList.max()-exList.min());
  normEy = ((ey - eyList.min())*maxVal)/(eyList.max()-eyList.min());
  normEz = ((ez - ezList.min())*maxVal)/(ezList.max()-ezList.min());
  sumAx = sumAx + ax;
  sumAy = sumAy + ay;
  sumAz = sumAz + az;
  sumGx = sumGx + gx;
  sumGy = sumGy + gy;
  sumGz = sumGz + gz;
  sumMx = sumMx + mx;
  sumMy = sumMy + my;
  sumMz = sumMz + mz;
  sumEx = sumEx + ex;
  sumEy = sumEy + ey;
  sumEz = sumEz + ez;
  if (pos%256 == 0) {
    normAvgAx = ((sumAx/pos - axList.min())*maxVal)/(axList.max()-axList.min());
    normAvgAy = ((sumAy/pos - ayList.min())*maxVal)/(ayList.max()-ayList.min());
    normAvgAz = ((sumAz/pos - azList.min())*maxVal)/(azList.max()-azList.min());
    normAvgGx = ((sumGx/pos - gxList.min())*maxVal)/(gxList.max()-gxList.min());
    normAvgGy = ((sumGy/pos - gyList.min())*maxVal)/(gyList.max()-gyList.min());
    normAvgGz = ((sumGz/pos - gzList.min())*maxVal)/(gzList.max()-gzList.min());
    normAvgMx = ((sumMx/pos - mxList.min())*maxVal)/(mxList.max()-mxList.min());
    normAvgMy = ((sumMy/pos - myList.min())*maxVal)/(myList.max()-myList.min());
    normAvgMz = ((sumMz/pos - mzList.min())*maxVal)/(mzList.max()-mzList.min());
    normAvgEx = ((sumEx/pos - exList.min())*maxVal)/(exList.max()-exList.min());
    normAvgEy = ((sumEy/pos - eyList.min())*maxVal)/(eyList.max()-eyList.min());
    normAvgEz = ((sumEz/pos - ezList.min())*maxVal)/(ezList.max()-ezList.min());

    
  }

  float amt = 0.05;
  smoothAx = lerp(smoothAx, normAx, amt);
  smoothAy = lerp(smoothAy, normAy, amt);
  smoothAz = lerp(smoothAz, normAz, amt);
  smoothGx = lerp(smoothGx, normGx, amt);
  smoothGy = lerp(smoothGy, normGy, amt);
  smoothGz = lerp(smoothGz, normGz, amt);
  smoothMx = lerp(smoothMx, normMx, amt);
  smoothMy = lerp(smoothMy, normMy, amt);
  smoothMz = lerp(smoothMz, normMz, amt);
  smoothEx = lerp(smoothEx, normEx, amt);
  smoothEy = lerp(smoothEy, normEy, amt);
  smoothEz = lerp(smoothEz, normEz, amt);

    smoothAvgAx = lerp(smoothAvgAx, normAvgAx, amt);
    smoothAvgAy = lerp(smoothAvgAy, normAvgAy, amt);
    smoothAvgAz = lerp(smoothAvgAz, normAvgAz, amt);
    smoothAvgGx = lerp(smoothAvgGx, normAvgGx, amt);
    smoothAvgGy = lerp(smoothAvgGy, normAvgGy, amt);
    smoothAvgGz = lerp(smoothAvgGz, normAvgGz, amt);
    smoothAvgMx = lerp(smoothAvgMx, normAvgMx, amt);
    smoothAvgMy = lerp(smoothAvgMy, normAvgMy, amt);
    smoothAvgMz = lerp(smoothAvgMz, normAvgMz, amt);
    smoothAvgEx = lerp(smoothAvgEx, normAvgEx, amt);
    smoothAvgEy = lerp(smoothAvgEy, normAvgEy, amt);
    smoothAvgEz = lerp(smoothAvgEz, normAvgEz, amt);

  stroke(0);
  strokeWeight(1);
  noFill();
  rect(125.5, 270.5, smoothAvgAx-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 290.5, smoothAvgAy-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 310.5, smoothAvgAz-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 380.5, smoothAvgGx-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 400.5, smoothAvgGy-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 420.5, smoothAvgGz-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 490.5, smoothAvgMx-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 510.5, smoothAvgMy-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 530.5, smoothAvgMz-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 600.5, smoothAvgEx-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 620.5, smoothAvgEy-0.5, 11, 0, 20, 20, 0);
  rect(125.5, 640.5, smoothAvgEz-0.5, 11, 0, 20, 20, 0);

  noStroke();
  fill(0);
  rect(125, 270, smoothAx, 12, 0, 20, 20, 0);
  rect(125, 290, smoothAy, 12, 0, 20, 20, 0);
  rect(125, 310, smoothAz, 12, 0, 20, 20, 0);
  rect(125, 380, smoothAx, 12, 0, 20, 20, 0);
  rect(125, 400, smoothGy, 12, 0, 20, 20, 0);
  rect(125, 420, smoothGz, 12, 0, 20, 20, 0);
  rect(125, 490, smoothMx, 12, 0, 20, 20, 0);
  rect(125, 510, smoothMy, 12, 0, 20, 20, 0);
  rect(125, 530, smoothMz, 12, 0, 20, 20, 0);
  rect(125, 600, smoothEx, 12, 0, 20, 20, 0);
  rect(125, 620, smoothEy, 12, 0, 20, 20, 0);
  rect(125, 640, smoothEz, 12, 0, 20, 20, 0);

  if (pos>23) {
    for (int i=0;i<23;i++) { 
      if(children[pos-i].getInt("happy") == 1) {
        noStroke();
        fill(0);
        ellipse(400, 100 + i*25, 10, 10);
      }
      if(children[pos-24].getInt("happy") == 1) {
        noStroke();
        fill(0);
        arc(400, 675, 10, 10, PI, TWO_PI);
      }
    }
  }

  stroke(0);
  strokeWeight(1);
  noFill();
  for (int i=0;i<23;i++) {
    ellipse(400, 100 + i*25, 22.5, 22.5);
  }
  arc(400, 675, 22.5, 22.5, PI, TWO_PI);

  float m = map(gz, gzList.min(), gzList.max(), 0, width);
  float m2 = map(gz, gzList.min(), gzList.max(), width/4, 3*width/4);
  smoothM = lerp(smoothM, m, .1);
  smoothM2 =lerp(smoothM2, m2, .1);

  stroke(0);
  strokeWeight(2);
  fill(255);

  line(width/2,height/4,smoothM,0);

  ellipse(smoothM2, 1*height/8, 40,40);

  stroke(0);
  strokeWeight(2);
  noFill();
  arc(smoothM2, 1*height/8, 18, 18, PI-QUARTER_PI, TWO_PI-QUARTER_PI);

  noStroke();
  fill(0);
  arc(smoothM2, 1*height/8, 20, 20, 0-QUARTER_PI, HALF_PI+QUARTER_PI);

  if (pos == 15490) {
    pos = 0;
  }


// save("save-####.png");

}

void fillList() {
  XML[] children = xml.getChildren("Measure");

  for (int i = 0; i < children.length; i++) {
    axList.append(children[i].getFloat("ax"));
    ayList.append(children[i].getFloat("ay"));
    azList.append(children[i].getFloat("az"));
    gxList.append(children[i].getFloat("gx"));
    gyList.append(children[i].getFloat("gy"));
    gzList.append(children[i].getFloat("gz"));
    mxList.append(children[i].getFloat("mx"));
    myList.append(children[i].getFloat("my"));
    mzList.append(children[i].getFloat("mz"));
    exList.append(children[i].getFloat("ex"));
    eyList.append(children[i].getFloat("ey"));
    ezList.append(children[i].getFloat("ez"));
    happyList.append(children[i].getInt("happy"));
  }
}

void testDraw() {   
  XML[] children = xml.getChildren("Measure");

  int number = children[pos].getInt("Number");
  float ax = children[pos].getFloat("ax");
  float ay = children[pos].getFloat("ay");
  float az = children[pos].getFloat("az");
  float gx = children[pos].getFloat("gx");
  float gy = children[pos].getFloat("gy");
  float gz = children[pos].getFloat("gz");
  float mx = children[pos].getFloat("mx");
  float my = children[pos].getFloat("my");
  float mz = children[pos].getFloat("mz");
  float ex = children[pos].getFloat("ex");
  float ey = children[pos].getFloat("ey");
  float ez = children[pos].getFloat("ez");
  int happy = children[pos].getInt("happy");
  
  fill(0);
  textFont(regF, 12);

  text("framerate: " + frameRate,45, 55);
  text("number: " + number,45, 65);
  text("ax: " + String.format("%.2f", ax),45, 75);
  text("ay: " + String.format("%.2f", ay),45, 85);
  text("az: " + String.format("%.2f", az),45, 95);
  text("gx: " + String.format("%.2f", gx),45, 105);
  text("gy: " + String.format("%.2f", gy),45, 115);
  text("gz: " + String.format("%.2f", gz),45, 125);
  text("mx: " + String.format("%.2f", mx),45, 135);
  text("my: " + String.format("%.2f", my),45, 145);
  text("mz: " + String.format("%.2f", mz),45, 155);
  text("ex: " + String.format("%.2f", ex),45, 165);
  text("ey: " + String.format("%.2f", ey),45, 175);
  text("ez: " + String.format("%.2f", ez),45, 185);
  text("happy: " + happy,45, 195);

  textFont(boldF);
  text("A",50,310);
  text("G",50,420);
  text("M",50,530);
  text("E",50,640);
}

void keyPressed(){
  pos = 0;
}

 