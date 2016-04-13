XML xmlRaw, xmlCooked;
XML[] childrenR, childrenC;
PGraphics big;
PImage bg;
int pos, count256, countAvg, count0_255, countID;
float happyC;
Tail tail;
Bars bars;
Samples samples;
Text txt;

void setup() {
  size(450,800);
  big = createGraphics(2160,3840);
  bg = loadImage("perrito.png");

  xmlRaw = loadXML("raw_final.xml");
  xmlCooked = loadXML("cooked_final.xml");
  childrenR = xmlRaw.getChildren("Measure");
  childrenC = xmlCooked.getChildren("measure");
  
  //Tail(startX, topY, bottomY, minX, maxX, weightLine, radiusBigCircle, colFillBigCircle, colStroke, colHalfCircle)
  tail = new Tail(918.5, 401, 925, 447.746, 1388.663, 5, 110.464, #FFFBF2, color(0), color(255,0,0));
  //Samples(startX, startY, spacingX, spacingY, radius, weightStroke, colCircles, colInsideCircles, colCrosses)
  samples = new Samples(568.555, 1055.091, 26.473, 20, 13.156, 2, color(0), #FFFBF2, color(255,0,0));
  //Bars(posX, posY1, posY2, posY3, posY4, rectHeight, spacing, weightStroke, rounding, colNormal, colAvg, maxValue)
  bars = new Bars(1094.548, 1043.347, 1364.572, 1685.798, 2007.023, 58.405, 77.873, 6, 50, color(0), #ffbcb5, 617);
  txt = new Text();
  
  bars.setup();
  txt.setup();

  pos = 1420;
  count256 = int(pos/256);
}

void draw() {
  pos++;

  if(pos%10 == 0) {  
   PImage img = big.get(0, 0, big.width, big.height);  
   img.resize(width,height);
   image(img,0,0);
  }  

  happyC = childrenC[pos/256-1].getFloat("happy");
  if (pos%256 == 0) {
    count256++;
    if (pos>1280) {
      countID++;
    }
  }
  count0_255 = pos-256*count256;

  big.beginDraw();
    big.background(bg);
    tail.draw();
    bars.draw();
    samples.draw();
    txt.draw();
  big.endDraw();
  //big.save("save"+pos+".png");
}