//-------------------------- GLOBAL VARIABLES --------------------------//
XML xmlRaw, xmlCooked;
XML[] childrenR, childrenC;
PGraphics big;
PImage bg, img;
int pos, count256, countAvg, count0_255, countID;
float happyC, scale;
Tail tail;
Samples samples;
Bars bars;
Happy happy;
Text txt;

//-------------------------- SETUP --------------------------//
void setup() {
  //~~~ SCALE ~~~//
  scale = 0.25;

  //~~~ SIZE & BACKGROUND ~~~//
  size(450,800);
  big = createGraphics(int(2160*scale),int(3840*scale));
  //if scale = 2 perrito_x2.png & if scale 0,25 perrito_x0,25.png
  bg = loadImage("perrito_x0,25.png");

  //~~~ LOAD XML ~~~//
  xmlRaw = loadXML("raw_final.xml");
  xmlCooked = loadXML("cooked_final.xml");
  childrenR = xmlRaw.getChildren("Measure");
  childrenC = xmlCooked.getChildren("measure");
  
  //~~~ PARTS ~~~//
  //Tail(startX, topY, bottomY, minX, maxX, weightLine, radiusBigCircle, colFillBigCircle, colStroke, colHalfCircle)
  tail = new Tail(918.5*scale, 401*scale, 925*scale, 447.746*scale, 1388.663*scale, 5*scale, 110.464*scale, #FFFBF2, color(0), color(255,0,0));
  //Samples(startX, startY, spacingX, spacingY, radius, weightStroke, colCircles, colInsideCircles, colCrosses)
  samples = new Samples(568.555*scale, 1055.091*scale, 26.473*scale, 20*scale, 13.156*scale, 2*scale, color(0), #FFFBF2, color(255,0,0));
  //Bars(posX, posY1, posY2, posY3, posY4, rectHeight, spacing, weightStroke, rounding, maxValue, colNormal, colAvg)
  bars = new Bars(1094.548*scale, 1043.347*scale, 1364.572*scale, 1685.798*scale, 2007.023*scale, 58.405*scale, 77.873*scale, 6*scale, 50*scale, 617*scale, color(0), #ffbcb5);
  //Happy(circleX, circleY, circleRadius, bgX, bgY, bgSize, txtX, txtY, txtSize, circleCol, bgCol, txtCol)
  happy = new Happy(1124.29*scale, 3073.26*scale, 21.287*scale, 1422.966*scale, 3034.104*scale, 380.358*scale, 1613.146*scale, 3227.794*scale, 30*scale, color(255,0,0), #ffbcb5, color(255,0,0));
  txt = new Text();
  
  //~~~ PARTS THAT NEED SETUP ~~~//
  bars.setup();
  txt.setup();

  //~~~ UNCOMMENT TO START AT FURTHER SAMPLE (just edit pos) ~~~//
   //pos = 900;
  // count256 = int(pos/256);
  // if (pos>1280) {
  //   countID = int(pos/256)-5;
  // }
}

//-------------------------- DRAW --------------------------//
void draw() {
  //~~~ MAIN COUNTER, POS = SAMPLE NUMBER ~~~//
  pos++;

  //~~~ RENDER ON SMALLER SCREEN ~~~//
  if(pos%2 == 0) {  
   img = big.get(0, 0, big.width, big.height);  
   img.resize(width,height);
   image(img,0,0);
  }  

  //~~~ SUBCOUNTERS & HAPPY COOKED STORED FOR GLOBAL USE ~~~//
  if (pos%256 == 0) {
    happyC = childrenC[pos/256-1].getFloat("happy");
    count256++;
    if (pos>1280) {
      countID++;
    }
  }
  count0_255 = pos-256*count256;

  //~~~ DRAW ON PGRAPHICS ~~~//
  big.beginDraw();
    big.background(bg);
    tail.draw();
    samples.draw();
    bars.draw();
    happy.draw();
    txt.assignRawData();
    txt.drawTextRawData(503.191*scale, 1059.28*scale, 708.946*scale, 1042.875*scale, 1364.156*scale, 1685.798*scale, 2006.417*scale, 2327.459*scale, 14.6*scale, 10*scale, 12*scale, color(255,0,0));
    txt.drawtextID(918.342*scale, 3078.907*scale, 24*scale, color(255, 0, 0));
    txt.drawtextIDList(516.045*scale, 3230.353*scale, 161.965*scale, 14.602*scale, 13*scale, color(255,0,0), #ffc9c2);
  big.endDraw();

  //~~~ UNCOMMENT TO RENDER ~~~//
  //big.save("save" + pos + ".png");
}