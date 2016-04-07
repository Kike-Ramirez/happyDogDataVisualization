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
PFont walReg,walBold, incReg, incBold;
int count256, countAvg, count0_255, count30, countID;

void setup() {
  /* SETUP + BACKGROUND */
  size(450,800);
  big = createGraphics(2160,3840);
  bg = loadImage("perrito.png");

  /* INITIALISE RAW AND COOKED DATA FILES */
  xmlRaw = loadXML("raw_final.xml");
  xmlCooked = loadXML("cooked_final.xml");
  
  /* INITIALISE FONTS */
  walReg = createFont("gt-walsheim-regular-web.otf",12);
  walBold = createFont("GT-Walsheim-Bold.ttf",12);
  incReg = createFont("Inconsolata-Regular.ttf",12);
  incBold = createFont("Inconsolata-Bold.ttf",12);

  /* INITIALISE LISTS (used for normalising) + FILL LIST ON STARTUP */
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

  /* maxVal IS MAXIMUM BAR WIDTH */
  maxVal = 617;

  /* SETUP SMOOTH TO START IN THE MIDDLE NOT FROM ZERO */
  smoothM = 918.205;
  smoothM2 = 918.205;

  /* UNCOMMENT TO START AT LATER SAMPLES */
   pos = 1000;
   count256 = int(pos/256);
}

void draw() {
  /* MAIN COUNTER, FOLLOWS SAMPLES RAW DATA */
  pos++;

  /* SHOW SMALLER RENDER EVERY 10TH POSITION THAT FITS SCREEN */
  if(pos%10 == 0) {  
    PImage img = big.get(0, 0, big.width, big.height);  
    img.resize(width,height);
    image(img,0,0);
  }  

  /* GET COOKED DATA */
  XML[] childrenC = xmlCooked.getChildren("measure");

  /* CHANGES EVERY 256 SAMPLES */
  if (pos%256 == 0) {
    /* SUBCOUNTER EVERY 256 SAMPLES */
    count256++;
    /* SUBCOUNTER FOR ID LIST */
    if (pos>1280) {
      countID++;
    }
    /* ASSIGN COOKED DATA */
    aDC = childrenC[pos/256-1].getFloat("aDC");
    aFmin = childrenC[pos/256-1].getFloat("aFmin");
    aFmax = childrenC[pos/256-1].getFloat("aFmax");
    aVmax = childrenC[pos/256-1].getFloat("aVmax");
    gDC = childrenC[pos/256-1].getFloat("gDC");
    gFmin = childrenC[pos/256-1].getFloat("gFmin");
    gFmax = childrenC[pos/256-1].getFloat("gFmax");
    gVmax = childrenC[pos/256-1].getFloat("gVmax");
    mDC = childrenC[pos/256-1].getFloat("mDC");
    mFmin = childrenC[pos/256-1].getFloat("mFmin");
    mFmax = childrenC[pos/256-1].getFloat("mFmax");
    mVmax = childrenC[pos/256-1].getFloat("mVmax");
    eDC = childrenC[pos/256-1].getFloat("eDC");
    eFmin = childrenC[pos/256-1].getFloat("eFmin");
    eFmax = childrenC[pos/256-1].getFloat("eFmax");
    eVmax = childrenC[pos/256-1].getFloat("eVmax");
    happyC = childrenC[pos/256-1].getFloat("happy");

    /* NORMALISE VALUES FOR BARS */
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
    
    /* CALCULATE DATA FOR GETTING AVERAGE ONLY WHEN HAPPY */
    if (happyC == 1.0) {
      /* SUBCOUNTER EVERY TIME VECTOR IS HAPPY */
      countAvg++;
      /* MAKE SUM FOR AVERAGE BARS */
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

      /* NORMALISE AVERAGE VALUES FOR AVERAGE BARS */
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

  /* SMOOTHEN VALUES FOR HIGHER READABILITY WITH LINEAR INTERPOLATION, amt = 1 NORMAL */
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

  /* START DRAWING ON BIG RENDER */
  big.beginDraw();
  big.background(bg);
  
  /* DRAW ALL THE TEXT */
  textDraw();

  /* ------------------------ BARS SECTION ------------------------ */
  float rectX = 1094.548;
  float rectY1 = 1043.347;
  float rectY2 = 1364.572;
  float rectY3 = 1685.798;
  float rectY4 = 2007.023;
  float rectH = 58.405;  
  float rectSpacing = 77.873;
  float rectStrokeWeight = 6;
  float rectRounding = 30;

  /* AVERAGE BARS BEFORE BARS */
  big.stroke(0);
  big.strokeWeight(rectStrokeWeight);
  big.noFill();
  big.rect(rectX + 3, rectY1 + 0 * rectSpacing + 3, smoothAvgaDC - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY1 + 1 * rectSpacing + 3, smoothAvgaFmin - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY1 + 2 * rectSpacing + 3, smoothAvgaFmax - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY1 + 3 * rectSpacing + 3, smoothAvgaVmax - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY2 + 0 * rectSpacing + 3, smoothAvggDC - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY2 + 1 * rectSpacing + 3, smoothAvggFmin - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY2 + 2 * rectSpacing + 3, smoothAvggFmax - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY2 + 3 * rectSpacing + 3, smoothAvggVmax - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY3 + 0 * rectSpacing + 3, smoothAvgmDC - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY3 + 1 * rectSpacing + 3, smoothAvgmFmin - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY3 + 2 * rectSpacing + 3, smoothAvgmFmax - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY3 + 3 * rectSpacing + 3, smoothAvgmVmax - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY4 + 0 * rectSpacing + 3, smoothAvgeDC - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY4 + 1 * rectSpacing + 3, smoothAvgeFmin - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY4 + 2 * rectSpacing + 3, smoothAvgeFmax - 3, rectH - 6, 0, rectRounding, rectRounding, 0);
  big.rect(rectX + 3, rectY4 + 3 * rectSpacing + 3, smoothAvgeVmax - 3, rectH - 6, 0, rectRounding, rectRounding, 0);

  /* BARS */
  big.noStroke();
  big.fill(0);
  big.rect(rectX, rectY1 + 0 * rectSpacing, smoothaDC, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY1 + 1 * rectSpacing, smoothaFmin, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY1 + 2 * rectSpacing, smoothaFmax, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY1 + 3 * rectSpacing, smoothaVmax, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY2 + 0 * rectSpacing, smoothgDC, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY2 + 1 * rectSpacing, smoothgFmin, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY2 + 2 * rectSpacing, smoothgFmax, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY2 + 3 * rectSpacing, smoothgVmax, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY3 + 0 * rectSpacing, smoothmDC, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY3 + 1 * rectSpacing, smoothmFmin, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY3 + 2 * rectSpacing, smoothmFmax, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY3 + 3 * rectSpacing, smoothmVmax, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY4 + 0 * rectSpacing, smootheDC, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY4 + 1 * rectSpacing, smootheFmin, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY4 + 2 * rectSpacing, smootheFmax, rectH, 0, rectRounding, rectRounding, 0);
  big.rect(rectX, rectY4 + 3 * rectSpacing, smootheVmax, rectH, 0, rectRounding, rectRounding, 0);

  /* ASSIGN COOKED DATA (used for tail and sample counter) */
  XML[] childrenR = xmlRaw.getChildren("Measure");
  float gz = childrenR[pos].getFloat("gz");
  int happy = childrenR[pos].getInt("happy");
  
  /* SUBCOUNTER THAT GOES FROM 0 TO 255 EVERY 256 SAMPLES */  
  count0_255 = pos-256*count256;

  /* ------------------------ SAMPLE COUNTER SECTION ------------------------ */ 
  float column1 = 568.555;
  float column2 = 595.028;
  float column3 = 621.501;
  float radius = 15.156;

  /* DRAW FULL OR EMPTY CIRCLES */
  big.stroke(0);
  big.strokeWeight(2.6);
  big.noFill();
  for (int i = 0; i < count0_255; ++i) {
    if (i<86) {
      if(childrenR[i + 256*count256].getInt("happy") == 1){
        big.fill(0);
        big.noStroke();
        big.ellipse(column1, 1055.091 + i*20, radius, radius);
      } else {
        big.ellipse(column1, 1055.091 + i*20, radius-0.5, radius-0.5);
      }
    } 
    if (i>=86 && i<172) {
      if(childrenR[i + 256*count256].getInt("happy") == 1){
        big.fill(0);
        big.noStroke();
        big.ellipse(column2, 1055.091 + i*20-1720, radius, radius);
      } else {
        big.ellipse(column2, 1055.091 + i*20-1720, radius-0.5, radius-0.5);
      }
    }
    if (i>=172) {
      if(childrenR[i + 256*count256].getInt("happy") == 1){
        big.fill(0);
        big.noStroke();
        big.ellipse(column3, 1055.091 + i*20-3440, radius, radius);
      } else {
        big.ellipse(column3, 1055.091 + i*20-3440, radius-0.5, radius-0.5);
      }
    }
  }

  /* DRAW CROSSES */
  big.stroke(0);
  big.strokeWeight(2.6);
  big.noFill();
  for (int i = count0_255; i < 256; ++i) {
    if (i<86) {
      big.line(column1-(radius/2-3), (1055.091 + i*20)-(radius/2-3), column1+(radius/2-3), (1055.091 + i*20)+(radius/2-3));
      big.line(column1-(radius/2-3), (1055.091 + i*20)+(radius/2-3), column1+(radius/2-3), (1055.091 + i*20)-(radius/2-3));
    }
    if (i>=86 && i<172) {
      big.line(column2-(radius/2-3), (1055.091 + i*20-1720)-(radius/2-3), column2+(radius/2-3), (1055.091 + i*20-1720)+(radius/2-3));
      big.line(column2-(radius/2-3), (1055.091 + i*20-1720)+(radius/2-3), column2+(radius/2-3), (1055.091 + i*20-1720)-(radius/2-3));
    }
    if (i>=172) {
      big.line(column3-(radius/2-3), (1055.091 + i*20-3440)-(radius/2-3), column3+(radius/2-3), (1055.091 + i*20-3440)+(radius/2-3));
      big.line(column3-(radius/2-3), (1055.091 + i*20-3440)+(radius/2-3), column3+(radius/2-3), (1055.091 + i*20-3440)-(radius/2-3));
    }
  }

  /* ------------------------ TAIL SECTION ------------------------ */
  float m = map(gz, gzList.min(), gzList.max(), 447.746, 1388.663);
  float m2 = map(gz, gzList.min(), gzList.max(), 682.975, 1153.434);
  smoothM = lerp(smoothM, m, .1);
  smoothM2 =lerp(smoothM2, m2, .1);

  big.stroke(0);
  big.strokeWeight(6);
  big.fill(255);

  big.line(918.343,926.335,smoothM,401);

  big.ellipse(smoothM2, 692.8335, 116.323,116.323);

  big.stroke(0);
  big.strokeWeight(6);
  big.noFill();
  big.arc(smoothM2, 692.8335, 54.232, 54.232, PI-QUARTER_PI, TWO_PI-QUARTER_PI);

  big.noStroke();
  big.fill(0);
  big.arc(smoothM2, 692.8335, 60.232, 60.232, 0-QUARTER_PI, HALF_PI+QUARTER_PI);

  /* ------------------------ HAPPY CIRCLE SECTION ------------------------ */
  if (happyC == 1.0) {
    big.noStroke();
    big.fill(0);
    big.ellipse(1124.29, 3073.26, 21.287, 21.287);
  }

  /* START DRAWING ON BIG RENDER */
  big.endDraw();

  /* ------------------------ SAVE SECTION ------------------------ */
  //big.save("save"+pos+".png");

}

/* FILLLIST FUNCTION */
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

/* DRAW TEXT FUNCTION */
void textDraw() {   
  XML[] childrenR = xmlRaw.getChildren("Measure");
  XML[] childrenC = xmlCooked.getChildren("measure");

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
  
  /* RAW DATA */
  big.fill(0);
  big.pushMatrix();
  big.rotate(radians(-90));
  big.textAlign(CENTER);

  big.textFont(walReg, 10);
  big.text(count0_255 + "      /      255",-1098.563, 505.097);

  big.textFont(walReg, 12);
  big.text("ax = " + String.format("%.2f", ax),-1068.918, 709.885);
  big.text("ay = " + String.format("%.2f", ay),-1068.918, 724.485);
  big.text("az = " + String.format("%.2f", az),-1068.918, 739.085);
  big.text("gx = " + String.format("%.2f", gx),-1392.175, 709.885);
  big.text("gy = " + String.format("%.2f", gy),-1392.175, 724.485);
  big.text("gz = " + String.format("%.2f", gz),-1392.175, 739.085);
  big.text("mx = " + String.format("%.2f", mx),-1718.025, 709.885);
  big.text("my = " + String.format("%.2f", my),-1718.025, 724.485);
  big.text("mz = " + String.format("%.2f", mz),-1718.025, 739.085);
  big.text("ex = " + String.format("%.2f", ex),-2036.524, 709.885);
  big.text("ey = " + String.format("%.2f", ey),-2036.524, 724.485);
  big.text("ez = " + String.format("%.2f", ez),-2036.524, 739.085);
  big.text("happy = " + happy,-2356.194,739.085);

  big.popMatrix();

  /* HAPPY OR NOT HAPPY */
  if (happyC == 1.0) {
    big.textFont(walReg,30);
    big.text("HAPPY",1613.146,3227.794);
  } else {
     big.textFont(walReg,30);
     big.text("NOT HAPPY",1613.146,3227.794);
  }

  /* ID */
  big.textFont(incBold,24);
  big.text(nf(pos/256,14),918.343, 3072.907+6);
  
  /* ID LIST */
  float col1 = 516.045;
  float col2 = 678.01;
  float col3 = 838.942;
  float col4 = 1000.907;
  float col5 = 1162.675;
  float col6 = 1324.64;
  float b = 3230.353;
  float spacing = 14.602;
  big.textFont(incReg,13);

  for (int i = 0; i < count256; ++i) {
    if (i<5) {
      if (childrenC[i+countID].getFloat("happy") == 0.0) {
        big.fill(179, 179, 179);
      } else {
        big.fill(0);
      }
      if (count256<5) {
        big.text(nf(i,14), col1, b-(i-count256)*spacing-spacing);
      } else {
        big.text(nf(i+countID,14), col1, b-(i-5)*spacing-spacing);
      }
    } 
    if (i>=5 && i<10) {
      if (count256<10) {
        if (childrenC[i-5].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-5,14), col2, b-(i-count256)*spacing-spacing);
      } else {
        if (childrenC[i-10+countID].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-10+countID,14), col2, b-(i-10)*spacing-spacing);
      }
    }
    if (i>=10 && i<15) {
      if (count256<15) {
        if (childrenC[i-10].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-10,14), col3, b-(i-count256)*spacing-spacing);
      } else {
        if (childrenC[i-20+countID].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-20+countID,14), col3, b-(i-15)*spacing-spacing);
      }
    }
    if (i>=15 && i<20) {
      if (count256<20) {
        if (childrenC[i-15].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-15,14), col4, b-(i-count256)*spacing-spacing);
      } else {
        if (childrenC[i-30+countID].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-30+countID,14), col4, b-(i-20)*spacing-spacing);
      }
    }
    if (i>=20 && i<25) {
      if (count256<25) {
        if (childrenC[i-20].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-20,14), col5, b-(i-count256)*spacing-spacing);
      } else {
        if (childrenC[i-40+countID].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-40+countID,14), col5, b-(i-25)*spacing-spacing);
      }
    }
    if (i>=25 && i<30) {
      if (count256<30) {
        if (childrenC[i-25].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-25,14), col6, b-(i-count256)*spacing-spacing);
      } else {
        if (childrenC[i-50+countID].getFloat("happy") == 0.0) {
          big.fill(179, 179, 179);
        } else {
          big.fill(0);
        }
        big.text(nf(i-50+countID,14), col6, b-(i-30)*spacing-spacing);
      }
    }
  }
}