XML xmlRaw;
XML xmlCooked;
int pos;
PImage bg;
PGraphics big;
int maxVal;
FloatList gzList;
FloatList aDCList,aFminList,aFmaxList,aVmaxList,gDCList,gFminList,gFmaxList,gVmaxList,mDCList,mFminList,mFmaxList,mVmaxList,eDCList,eFminList,eFmaxList,eVmaxList;
float aDC,aFmin,aFmax,aVmax,gDC,gFmin,gFmax,gVmax,mDC,mFmin,mFmax,mVmax,eDC,eFmin,eFmax,eVmax,happyC;
float normaDC,normaFmin,normaFmax,normaVmax,normgDC,normgFmin,normgFmax,normgVmax,normmDC,normmFmin,normmFmax,normmVmax,normeDC,normeFmin,normeFmax,normeVmax;
float sumaDC,sumaFmin,sumaFmax,sumaVmax,sumgDC,sumgFmin,sumgFmax,sumgVmax,summDC,summFmin,summFmax,summVmax,sumeDC,sumeFmin,sumeFmax,sumeVmax;
float normAvgaDC,normAvgaFmin,normAvgaFmax,normAvgaVmax,normAvggDC,normAvggFmin,normAvggFmax,normAvggVmax,normAvgmDC,normAvgmFmin,normAvgmFmax,normAvgmVmax,normAvgeDC,normAvgeFmin,normAvgeFmax,normAvgeVmax;
float smoothaDC,smoothaFmin,smoothaFmax,smoothaVmax,smoothgDC,smoothgFmin,smoothgFmax,smoothgVmax,smoothmDC,smoothmFmin,smoothmFmax,smoothmVmax,smootheDC,smootheFmin,smootheFmax,smootheVmax;
float smoothAvgaDC,smoothAvgaFmin,smoothAvgaFmax,smoothAvgaVmax,smoothAvggDC,smoothAvggFmin,smoothAvggFmax,smoothAvggVmax,smoothAvgmDC,smoothAvgmFmin,smoothAvgmFmax,smoothAvgmVmax,smoothAvgeDC,smoothAvgeFmin,smoothAvgeFmax,smoothAvgeVmax;
float smoothM,smoothM2;
PFont regF;
PFont boldF;
float scale;
int countSample, countAvg;

void setup() {
  size(450,800);
  big = createGraphics(2160,3840);
  xmlRaw = loadXML("raw_final.xml");
  xmlCooked = loadXML("cooked_final.xml");
  bg = loadImage("perrito.png");
  regF = createFont("gt-walsheim-regular-web.otf",16);
  boldF = createFont("GT-Walsheim-Bold.ttf",21);

  scale = 4.8;
  
  maxVal = 617;

  gzList = new FloatList();

  aDCList = new FloatList();
  aFminList = new FloatList();
  aFmaxList = new FloatList();
  aVmaxList = new FloatList();
  gDCList = new FloatList();
  gFminList = new FloatList();
  gFmaxList = new FloatList();
  gVmaxList = new FloatList();
  mDCList = new FloatList();
  mFminList = new FloatList();
  mFmaxList = new FloatList();
  mVmaxList = new FloatList();
  eDCList = new FloatList();
  eFminList = new FloatList();
  eFmaxList = new FloatList();
  eVmaxList = new FloatList();

  fillList();
  pos = 900;
  countSample = 3;
}

void draw() {
  pos++;
  if(pos%10 == 0) {  
    PImage img = big.get(0, 0, big.width, big.height);  
    img.resize(width,height);
    image(img,0,0);
  }  
  
  //testDraw();

  XML[] childrenC = xmlCooked.getChildren("measure");
  if (pos%256 == 0) {
    countSample++;
    aDC = childrenC[pos/256].getFloat("aDC");
    aFmin = childrenC[pos/256].getFloat("aFmin");
    aFmax = childrenC[pos/256].getFloat("aFmax");
    aVmax = childrenC[pos/256].getFloat("aVmax");
    gDC = childrenC[pos/256].getFloat("gDC");
    gFmin = childrenC[pos/256].getFloat("gFmin");
    gFmax = childrenC[pos/256].getFloat("gFmax");
    gVmax = childrenC[pos/256].getFloat("gVmax");
    mDC = childrenC[pos/256].getFloat("mDC");
    mFmin = childrenC[pos/256].getFloat("mFmin");
    mFmax = childrenC[pos/256].getFloat("mFmax");
    mVmax = childrenC[pos/256].getFloat("mVmax");
    eDC = childrenC[pos/256].getFloat("eDC");
    eFmin = childrenC[pos/256].getFloat("eFmin");
    eFmax = childrenC[pos/256].getFloat("eFmax");
    eVmax = childrenC[pos/256].getFloat("eVmax");
    happyC = childrenC[pos/256].getFloat("happy");

    normaDC = ((aDC - aDCList.min())*maxVal)/(aDCList.max()-aDCList.min());
    normaFmin = ((aFmin - aFminList.min())*maxVal)/(aFminList.max()-aFminList.min());
    normaFmax = ((aFmax - aFmaxList.min())*maxVal)/(aFmaxList.max()-aFmaxList.min());
    normaVmax = ((aVmax - aVmaxList.min())*maxVal)/(aVmaxList.max()-aVmaxList.min());
    normgDC = ((gDC - gDCList.min())*maxVal)/(gDCList.max()-gDCList.min());
    normgFmin = ((gFmin - gFminList.min())*maxVal)/(gFminList.max()-gFminList.min());
    normgFmax = ((gFmax - gFmaxList.min())*maxVal)/(gFmaxList.max()-gFmaxList.min());
    normgVmax = ((gVmax - gVmaxList.min())*maxVal)/(gVmaxList.max()-gVmaxList.min());
    normmDC = ((mDC - mDCList.min())*maxVal)/(mDCList.max()-mDCList.min());
    normmFmin = ((mFmin - mFminList.min())*maxVal)/(mFminList.max()-mFminList.min());
    normmFmax = ((mFmax - mFmaxList.min())*maxVal)/(mFmaxList.max()-mFmaxList.min());
    normmVmax = ((mVmax - mVmaxList.min())*maxVal)/(mVmaxList.max()-mVmaxList.min());
    normeDC = ((eDC - eDCList.min())*maxVal)/(eDCList.max()-eDCList.min());
    normeFmin = ((eFmin - eFminList.min())*maxVal)/(eFminList.max()-eFminList.min());
    normeFmax = ((eFmax - eFmaxList.min())*maxVal)/(eFmaxList.max()-eFmaxList.min());
    normeVmax = ((eVmax - eVmaxList.min())*maxVal)/(eVmaxList.max()-eVmaxList.min());
    
    if (happyC == 1.0) {
      countAvg++;
      sumaDC = sumaDC + aDC;
      sumaFmin = sumaFmin + aFmin;
      sumaFmax = sumaFmax + aFmax;
      sumaVmax = sumaVmax + aVmax;
      sumgDC = sumgDC + gDC;
      sumgFmin = sumgFmin + gFmin;
      sumgFmax = sumgFmax + gFmax;
      sumgVmax = sumgVmax + gVmax;
      summDC = summDC + mDC;
      summFmin = summFmin + mFmin;
      summFmax = summFmax + mFmax;
      summVmax = summVmax + mVmax;
      sumeDC = sumeDC + eDC;
      sumeFmin = sumeFmin + eFmin;
      sumeFmax = sumeFmax + eFmax;
      sumeVmax = sumeVmax + eVmax;
      normAvgaDC = ((sumaDC/countAvg - aDCList.min())*maxVal)/(aDCList.max()-aDCList.min()); 
      normAvgaFmin = ((sumaFmin/countAvg - aFminList.min())*maxVal)/(aFminList.max()-aFminList.min()); 
      normAvgaFmax = ((sumaFmax/countAvg - aFmaxList.min())*maxVal)/(aFmaxList.max()-aFmaxList.min()); 
      normAvgaVmax = ((sumaVmax/countAvg - aVmaxList.min())*maxVal)/(aVmaxList.max()-aVmaxList.min());
      normAvggDC = ((sumgDC/countAvg - gDCList.min())*maxVal)/(gDCList.max()-gDCList.min()); 
      normAvggFmin = ((sumgFmin/countAvg - gFminList.min())*maxVal)/(gFminList.max()-gFminList.min()); 
      normAvggFmax = ((sumgFmax/countAvg - gFmaxList.min())*maxVal)/(gFmaxList.max()-gFmaxList.min()); 
      normAvggVmax = ((sumgVmax/countAvg - gVmaxList.min())*maxVal)/(gVmaxList.max()-gVmaxList.min());
      normAvgmDC = ((summDC/countAvg - mDCList.min())*maxVal)/(mDCList.max()-mDCList.min()); 
      normAvgmFmin = ((summFmin/countAvg - mFminList.min())*maxVal)/(mFminList.max()-mFminList.min()); 
      normAvgmFmax = ((summFmax/countAvg - mFmaxList.min())*maxVal)/(mFmaxList.max()-mFmaxList.min()); 
      normAvgmVmax = ((summVmax/countAvg - mVmaxList.min())*maxVal)/(mVmaxList.max()-mVmaxList.min());
      normAvgeDC = ((sumeDC/countAvg - eDCList.min())*maxVal)/(eDCList.max()-eDCList.min()); 
      normAvgeFmin = ((sumeFmin/countAvg - eFminList.min())*maxVal)/(eFminList.max()-eFminList.min()); 
      normAvgeFmax = ((sumeFmax/countAvg - eFmaxList.min())*maxVal)/(eFmaxList.max()-eFmaxList.min()); 
      normAvgeVmax = ((sumeVmax/countAvg - eVmaxList.min())*maxVal)/(eVmaxList.max()-eVmaxList.min()); 
    }
  }

  float amt = 0.05;
  smoothaDC = lerp(smoothaDC, normaDC, amt);
  smoothaFmin = lerp(smoothaFmin, normaFmin, amt);
  smoothaFmax = lerp(smoothaFmax, normaFmax, amt);
  smoothaVmax = lerp(smoothaVmax, normaVmax, amt);
  smoothgDC = lerp(smoothgDC, normgDC, amt);
  smoothgFmin = lerp(smoothgFmin, normgFmin, amt);
  smoothgFmax = lerp(smoothgFmax, normgFmax, amt);
  smoothgVmax = lerp(smoothgVmax, normgVmax, amt);
  smoothmDC = lerp(smoothmDC, normmDC, amt);
  smoothmFmin = lerp(smoothmFmin, normmFmin, amt);
  smoothmFmax = lerp(smoothmFmax, normmFmax, amt);
  smoothmVmax = lerp(smoothmVmax, normmVmax, amt);
  smootheDC = lerp(smootheDC, normeDC, amt);
  smootheFmin = lerp(smootheFmin, normeFmin, amt);
  smootheFmax = lerp(smootheFmax, normeFmax, amt);
  smootheVmax = lerp(smootheVmax, normeVmax, amt);

  smoothAvgaDC = lerp(smoothAvgaDC, normAvgaDC, amt);
  smoothAvgaFmin = lerp(smoothAvgaFmin, normAvgaFmin, amt);
  smoothAvgaFmax = lerp(smoothAvgaFmax, normAvgaFmax, amt);
  smoothAvgaVmax = lerp(smoothAvgaVmax, normAvgaVmax, amt);
  smoothAvggDC = lerp(smoothAvggDC, normAvggDC, amt);
  smoothAvggFmin = lerp(smoothAvggFmin, normAvggFmin, amt);
  smoothAvggFmax = lerp(smoothAvggFmax, normAvggFmax, amt);
  smoothAvggVmax = lerp(smoothAvggVmax, normAvggVmax, amt);
  smoothAvgmDC = lerp(smoothAvgmDC, normAvgmDC, amt);
  smoothAvgmFmin = lerp(smoothAvgmFmin, normAvgmFmin, amt);
  smoothAvgmFmax = lerp(smoothAvgmFmax, normAvgmFmax, amt);
  smoothAvgmVmax = lerp(smoothAvgmVmax, normAvgmVmax, amt);
  smoothAvgeDC = lerp(smoothAvgeDC, normAvgeDC, amt);
  smoothAvgeFmin = lerp(smoothAvgeFmin, normAvgeFmin, amt);
  smoothAvgeFmax = lerp(smoothAvgeFmax, normAvgeFmax, amt);
  smoothAvgeVmax = lerp(smoothAvgeVmax, normAvgeVmax, amt);

  big.beginDraw();
    big.background(bg);
    textDraw();

  float rectX = 1094.548;
  float rectH = 58.405;  
  big.stroke(0);
  big.strokeWeight(6);
  big.noFill();
  big.rect(rectX+3, 1131.347 + 0*77.873 + 3, smoothAvgaDC-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1131.347 + 1*77.873 + 3, smoothAvgaFmin-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1131.347 + 2*77.873 + 3, smoothAvgaFmax-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1131.347 + 3*77.873 + 3, smoothAvgaVmax-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1452.572 + 0*77.873 + 3, smoothAvggDC-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1452.572 + 1*77.873 + 3, smoothAvggFmin-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1452.572 + 2*77.873 + 3, smoothAvggFmax-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1452.572 + 3*77.873 + 3, smoothAvggVmax-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1773.798 + 0*77.873 + 3, smoothAvgmDC-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1773.798 + 1*77.873 + 3, smoothAvgmFmin-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1773.798 + 2*77.873 + 3, smoothAvgmFmax-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 1773.798 + 3*77.873 + 3, smoothAvgmVmax-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 2094.798 + 0*77.873 + 3, smoothAvgeDC-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 2094.798 + 1*77.873 + 3, smoothAvgeFmin-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 2094.798 + 2*77.873 + 3, smoothAvgeFmax-3, rectH-6, 0, 20, 20, 0);
  big.rect(rectX+3, 2094.798 + 3*77.873 + 3, smoothAvgeVmax-3, rectH-6, 0, 20, 20, 0);

  big.noStroke();
  big.fill(0);
  big.rect(rectX, 1131.347 + 0*77.873, smoothaDC, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1131.347 + 1*77.873, smoothaFmin, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1131.347 + 2*77.873, smoothaFmax, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1131.347 + 3*77.873, smoothaVmax, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1452.572 + 0*77.873, smoothgDC, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1452.572 + 1*77.873, smoothgFmin, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1452.572 + 2*77.873, smoothgFmax, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1452.572 + 3*77.873, smoothgVmax, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1773.798 + 0*77.873, smoothmDC, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1773.798 + 1*77.873, smoothmFmin, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1773.798 + 2*77.873, smoothmFmax, rectH, 0, 20, 20, 0);
  big.rect(rectX, 1773.798 + 3*77.873, smoothmVmax, rectH, 0, 20, 20, 0);
  big.rect(rectX, 2094.798 + 0*77.873, smootheDC, rectH, 0, 20, 20, 0);
  big.rect(rectX, 2094.798 + 1*77.873, smootheFmin, rectH, 0, 20, 20, 0);
  big.rect(rectX, 2094.798 + 2*77.873, smootheFmax, rectH, 0, 20, 20, 0);
  big.rect(rectX, 2094.798 + 3*77.873, smootheVmax, rectH, 0, 20, 20, 0);

  XML[] childrenR = xmlRaw.getChildren("Measure");
  float gz = childrenR[pos].getFloat("gz");
  int happy = childrenR[pos].getInt("happy");

  if (pos>23) {
    for (int i=0;i<23;i++) { 
      if(childrenR[pos-i].getInt("happy") == 1) {
        big.noStroke();
        big.fill(0);
        big.ellipse(594.072, 1191 + i*73, 21.287, 21.287);
      }
    }
  }

  float m = map(gz, gzList.min(), gzList.max(), 447.746, 1388.663);
  float m2 = map(gz, gzList.min(), gzList.max(), 682.975, 1153.434);
  smoothM = lerp(smoothM, m, .1);
  smoothM2 =lerp(smoothM2, m2, .1);

  big.stroke(0);
  big.strokeWeight(6);
  big.fill(255);

  big.line(918.5,1013.667,smoothM,372);

  big.ellipse(smoothM2, 692.8335, 116.323,116.323);

  big.stroke(0);
  big.strokeWeight(6);
  big.noFill();
  big.arc(smoothM2, 692.8335, 54.232, 54.232, PI-QUARTER_PI, TWO_PI-QUARTER_PI);

  big.noStroke();
  big.fill(0);
  big.arc(smoothM2, 692.8335, 60.232, 60.232, 0-QUARTER_PI, HALF_PI+QUARTER_PI);

  if (happyC == 1.0) {
    big.noStroke();
    big.fill(0);
    big.ellipse(1124.29, 3161.26, 21.287, 21.287);
  }

  if (pos == 15490) {
    pos = 0;
  }

  big.endDraw();
  //big.save("save"+pos+".png");

}

void fillList() {
  XML[] childrenR = xmlRaw.getChildren("Measure");
  XML[] childrenC = xmlCooked.getChildren("measure");

  for (int i = 0; i < childrenR.length; i++) {
    gzList.append(childrenR[i].getFloat("gz"));
  }

  for (int i = 0; i < childrenC.length; i++) {
    aDCList.append(childrenC[i].getFloat("aDC"));
    aFminList.append(childrenC[i].getFloat("aFmin"));
    aFmaxList.append(childrenC[i].getFloat("aFmax"));
    aVmaxList.append(childrenC[i].getFloat("aVmax"));
    gDCList.append(childrenC[i].getFloat("gDC"));
    gFminList.append(childrenC[i].getFloat("gFmin"));
    gFmaxList.append(childrenC[i].getFloat("gFmax"));
    gVmaxList.append(childrenC[i].getFloat("gVmax"));
    mDCList.append(childrenC[i].getFloat("mDC"));
    mFminList.append(childrenC[i].getFloat("mFmin"));
    mFmaxList.append(childrenC[i].getFloat("mFmax"));
    mVmaxList.append(childrenC[i].getFloat("mVmax"));
    eDCList.append(childrenC[i].getFloat("eDC"));
    eFminList.append(childrenC[i].getFloat("eFmin"));
    eFmaxList.append(childrenC[i].getFloat("eFmax"));
    eVmaxList.append(childrenC[i].getFloat("eVmax"));
  }
}


void testDraw() {   
  XML[] childrenR = xmlRaw.getChildren("Measure");

  int number = childrenR[pos].getInt("Number");
  float ax = childrenR[pos].getFloat("ax");
  float ay = childrenR[pos].getFloat("ay");
  float az = childrenR[pos].getFloat("az");
  float gx = childrenR[pos].getFloat("gx");
  float gy = childrenR[pos].getFloat("gy");
  float gz = childrenR[pos].getFloat("gz");
  float mx = childrenR[pos].getFloat("mx");
  float my = childrenR[pos].getFloat("my");
  float mz = childrenR[pos].getFloat("mz");
  float ex = childrenR[pos].getFloat("ex");
  float ey = childrenR[pos].getFloat("ey");
  float ez = childrenR[pos].getFloat("ez");
  int happy = childrenR[pos].getInt("happy");
  
  fill(0);
  textFont(regF, 12);

  text("framerate: " + String.format("%.2f", frameRate),45, 55);
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

  text("aDC: " + String.format("%.2f", aDC),150, 55);
  text("aFmin: " + String.format("%.2f", aFmin),150, 65);
  text("aFmax: " + String.format("%.2f", aFmax),150, 75);
  text("aVmax: " + String.format("%.2f", aVmax),150, 85);
  text("gDC: " + String.format("%.2f", gDC),150, 95);
  text("gFmin: " + String.format("%.2f", gFmin),150, 105);
  text("gFmax: " + String.format("%.2f", gFmax),150, 115);
  text("gVmax: " + String.format("%.2f", gVmax),150, 125);
  text("mDC: " + String.format("%.2f", mDC),150, 135);
  text("mFmin: " + String.format("%.2f", mFmin),150, 145);
  text("mFmax: " + String.format("%.2f", mFmax),150, 155);
  text("mVmax: " + String.format("%.2f", mVmax),150, 165);
  text("eDC: " + String.format("%.2f", eDC),150, 175);
  text("eFmin: " + String.format("%.2f", eFmin),150, 185);
  text("eFmax: " + String.format("%.2f", eFmax),150, 195);
  text("eVmax: " + String.format("%.2f", eVmax),150, 205);
  text("happy: " + happyC,150, 215);

  textFont(boldF);
  //text("A",50,330);
  //text("G",50,430);
  //text("M",50,530);
  //text("E",50,630);
}

void textDraw() {   
  XML[] childrenR = xmlRaw.getChildren("Measure");

  int number = childrenR[pos].getInt("Number");
  float ax = childrenR[pos].getFloat("ax");
  float ay = childrenR[pos].getFloat("ay");
  float az = childrenR[pos].getFloat("az");
  float gx = childrenR[pos].getFloat("gx");
  float gy = childrenR[pos].getFloat("gy");
  float gz = childrenR[pos].getFloat("gz");
  float mx = childrenR[pos].getFloat("mx");
  float my = childrenR[pos].getFloat("my");
  float mz = childrenR[pos].getFloat("mz");
  float ex = childrenR[pos].getFloat("ex");
  float ey = childrenR[pos].getFloat("ey");
  float ez = childrenR[pos].getFloat("ez");
  int happy = childrenR[pos].getInt("happy");
  
  big.fill(0);
  big.textFont(regF, 10);
  big.pushMatrix();
  //big.translate(big.width/2,0);
  big.rotate(radians(-90));
  big.textAlign(CENTER);

  big.text((number-256*countSample)+1 + "   /   256",-1180, 499.634+5.463);
  big.textFont(regF, 12);
  big.text(String.format("%.2f", ax),-1146.262, 712.754);
  big.text(String.format("%.2f", ay),-1147.521, 727.354);
  big.text(String.format("%.2f", az),-1147.293, 741.954);
  big.text(String.format("%.2f", gx),-1467.543, 712.754);
  big.text(String.format("%.2f", gy),-1468.804, 727.354);
  big.text(String.format("%.2f", gz),-1468.576, 741.954);
  big.text(String.format("%.2f", mx),-1789.184, 712.754);
  big.text(String.format("%.2f", my),-1790.445, 727.354);
  big.text(String.format("%.2f", mz),-1790.217, 741.954);
  big.text(String.format("%.2f", ex),-2109.803, 712.754);
  big.text(String.format("%.2f", ey),-2111.064, 727.354);
  big.text(String.format("%.2f", ez),-2110.836, 741.954);
  big.text(happy,-2438.25,733.129+8.684);

  // text("happy: " + happyC,150, 215);
  big.popMatrix();

  if (happyC == 1.0) {
    big.textFont(boldF,35);
    big.text("HAPPY",1286.048,3170.563);
  } else {
     big.textFont(boldF,26);
     big.text("NOT HAPPY",1286.048,3167.563);
  }

  // textFont(boldF);
  //text("A",50,330);
  //text("G",50,430);
  //text("M",50,530);
  //text("E",50,630);
}

void keyPressed(){
  pos = 0;
}

 