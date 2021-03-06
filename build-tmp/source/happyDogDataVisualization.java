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

public class happyDogDataVisualization extends PApplet {

//-------------------------- GLOBAL VARIABLES --------------------------//
XML xmlRaw, xmlCooked;
XML[] childrenR, childrenC;
PGraphics big;
int pos, count256, countAvg, count0_255, countID;
float happyC, scale;
Tail tail;
Samples samples;
Bars bars;
Happy happy;
Text txt;
Trees tree;
Background bg;

//-------------------------- SETUP --------------------------//
public void setup() {
  //~~~ SCALE ~~~//
  scale = 0.25f;

  //~~~ SIZE & BACKGROUND ~~~//
  
  big = createGraphics(PApplet.parseInt(2160*scale),PApplet.parseInt(3840*scale));
  //rescale bg
  bg = new Background();

  //~~~ LOAD XML ~~~//
  xmlRaw = loadXML("raw_final.xml");
  xmlCooked = loadXML("cooked_final.xml");
  childrenR = xmlRaw.getChildren("Measure");
  childrenC = xmlCooked.getChildren("measure");
  
  //~~~ PARTS ~~~//
  //Tail(startX, topY, bottomY, minX, maxX, weightLine, radiusBigCircle, colFillBigCircle, colStroke, colHalfCircle)
  tail = new Tail(918.5f*scale, 401*scale, 925*scale, 447.746f*scale, 1388.663f*scale, 5*scale, 110.464f*scale, 0xffFFFBF2, color(0), color(255,0,0));
  //Samples(startX, startY, spacingX, spacingY, radius, weightStroke, colCircles, colInsideCircles, colCrosses)
  samples = new Samples(568.555f*scale, 1055.091f*scale, 26.473f*scale, 20*scale, 13.156f*scale, 2*scale, color(0), 0xffFFFBF2, color(255,0,0));
  //Bars(posX, posY1, posY2, posY3, posY4, rectHeight, spacing, weightStroke, rounding, maxValue, colNormal, colAvg)
  bars = new Bars(1094.548f*scale, 1043.347f*scale, 1364.572f*scale, 1685.798f*scale, 2007.023f*scale, 58.405f*scale, 77.873f*scale, 6*scale, 50*scale, 617*scale, color(0), 0xffffbcb5);
  //Happy(circleX, circleY, circleRadius, bgX, bgY, bgSize, txtX, txtY, txtSize, circleCol, bgCol, txtCol)
  happy = new Happy(1124.29f*scale, 3073.26f*scale, 21.287f*scale, 1422.966f*scale, 3034.104f*scale, 380.358f*scale, 1613.146f*scale, 3227.794f*scale, 30*scale, color(255,0,0), 0xffffbcb5, color(255,0,0));
  tree = new Trees();
  txt = new Text();
  
  //~~~ PARTS THAT NEED SETUP ~~~//
  bars.setup();
  txt.setup();

  //~~~ UNCOMMENT TO START AT FURTHER SAMPLE (just edit pos) ~~~//
   pos = 1100;
  count256 = PApplet.parseInt(pos/256);
  if (pos>1280) {
    countID = PApplet.parseInt(pos/256)-5;
  }
}

//-------------------------- DRAW --------------------------//
public void draw() {
  //~~~ MAIN COUNTER, POS = SAMPLE NUMBER ~~~//
  pos++; 

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
    bg.draw();
    tail.draw();
    samples.draw();
    bars.draw();
    happy.draw();
    tree.draw();
    txt.assignRawData();
    txt.drawTextRawData(503.191f*scale, 1059.28f*scale, 708.946f*scale, 1042.875f*scale, 1364.156f*scale, 1685.798f*scale, 2006.417f*scale, 2327.459f*scale, 14.6f*scale, 10*scale, 12*scale, color(255,0,0));
    txt.drawtextID(918.342f*scale, 3078.907f*scale, 24*scale, color(255, 0, 0));
    txt.drawtextIDList(516.045f*scale, 3230.353f*scale, 161.965f*scale, 14.602f*scale, 13*scale, color(255,0,0), 0xffffc9c2);
  big.endDraw();

  //~~~ UNCOMMENT TO RENDER ~~~//
  //big.save("save" + pos + ".png");

  //~~~ RENDER ON SMALLER SCREEN ~~~//
  //if(pos%10 == 0) {  
   PImage img = big.get(0, 0, big.width, big.height);  
   img.resize(width,height);
   image(img,0,0);
  //} 
  
  fill(0);
  //text(int(frameRate), 50,50);
}
//-------------------------- BACKGROUND CLASS --------------------------//
class Background {

	PImage bg, bgTree1, bgTree2, bgTree3, bgTree4, bgTree5, bgTree6, bgTree7, bgTree8, bgTree9;

	//~~~ CONSTRUCTOR ~~~//
	public Background () {
		bg = loadImage("perrito.png");
		bgTree1 = loadImage("perrito_tree1.png");
		bgTree2 = loadImage("perrito_tree2.png");
		bgTree3 = loadImage("perrito_tree3.png");
  		bgTree4 = loadImage("perrito_tree4.png");
  		bgTree5 = loadImage("perrito_tree5.png");
  		bgTree6 = loadImage("perrito_tree6.png");
  		bgTree7 = loadImage("perrito_tree7.png");
  		bgTree8 = loadImage("perrito_tree8.png");
  		bgTree9 = loadImage("perrito_tree9.png");

  		resizeBg();
	}

	//~~~ SETUP ~~~//

	//~~~ DRAW ~~~//
	public void draw() {
		if (count0_255 > 11 && count0_255 < 47) {
	      	big.background(bgTree1);
	    } else if (count0_255 > 47 && count0_255 < 63) {
	      	big.background(bgTree2);
	    } else if (count0_255 > 63 && count0_255 < 89) {
	      	big.background(bgTree3);
	    } else if (count0_255 > 89 && count0_255 < 120) {
	      	big.background(bgTree4);
	    } else if (count0_255 > 120 && count0_255 < 146) {
	      	big.background(bgTree5);
	    } else if (count0_255 > 146 && count0_255 < 182) {
	      	big.background(bgTree6);
	    } else if (count0_255 > 182 && count0_255 < 203) {
	      	big.background(bgTree7);
	    } else if (count0_255 > 203 && count0_255 < 229) {
	      	big.background(bgTree8);
	    } else if (count0_255 > 229 && count0_255 < 255) {
	      	big.background(bgTree9);
	    } else {
	      	big.background(bg);
	    }
	}

	public void resizeBg() {
		bg.resize(big.width,big.height);
		bgTree1.resize(big.width,big.height);
		bgTree2.resize(big.width,big.height);
		bgTree3.resize(big.width,big.height);
		bgTree4.resize(big.width,big.height);
		bgTree5.resize(big.width,big.height);
		bgTree6.resize(big.width,big.height);
		bgTree7.resize(big.width,big.height);
		bgTree8.resize(big.width,big.height);
		bgTree9.resize(big.width,big.height);
	}

}
//-------------------------- BARS CLASS --------------------------//
class Bars {

	float x,y1,y2,y3,y4,h,s,w,r,maxVal;
	int cN, cA;

	FloatList aDCList,aFminList,aFmaxList,aVmaxList,gDCList,gFminList,gFmaxList,gVmaxList,mDCList,mFminList,mFmaxList,mVmaxList,eDCList,eFminList,eFmaxList,eVmaxList;
	float aDC,aFmin,aFmax,aVmax,gDC,gFmin,gFmax,gVmax,mDC,mFmin,mFmax,mVmax,eDC,eFmin,eFmax,eVmax;
	float normaDC,normaFmin,normaFmax,normaVmax,normgDC,normgFmin,normgFmax,normgVmax,normmDC,normmFmin,normmFmax,normmVmax,normeDC,normeFmin,normeFmax,normeVmax;
	float sumaDC,sumaFmin,sumaFmax,sumaVmax,sumgDC,sumgFmin,sumgFmax,sumgVmax,summDC,summFmin,summFmax,summVmax,sumeDC,sumeFmin,sumeFmax,sumeVmax;
	float normAvgaDC,normAvgaFmin,normAvgaFmax,normAvgaVmax,normAvggDC,normAvggFmin,normAvggFmax,normAvggVmax,normAvgmDC,normAvgmFmin,normAvgmFmax,normAvgmVmax,normAvgeDC,normAvgeFmin,normAvgeFmax,normAvgeVmax;
	float smoothaDC,smoothaFmin,smoothaFmax,smoothaVmax,smoothgDC,smoothgFmin,smoothgFmax,smoothgVmax,smoothmDC,smoothmFmin,smoothmFmax,smoothmVmax,smootheDC,smootheFmin,smootheFmax,smootheVmax;
	float smoothAvgaDC,smoothAvgaFmin,smoothAvgaFmax,smoothAvgaVmax,smoothAvggDC,smoothAvggFmin,smoothAvggFmax,smoothAvggVmax,smoothAvgmDC,smoothAvgmFmin,smoothAvgmFmax,smoothAvgmVmax,smoothAvgeDC,smoothAvgeFmin,smoothAvgeFmax,smoothAvgeVmax;

	//~~~ CONSTRUCTOR ~~~//
	public Bars (float posX, float posY1, float posY2, float posY3, float posY4, float rectHeight, float spacing, float weightStroke, float rounding, float maxValue, int colNormal, int colAvg) {
		x = posX;
		y1 = posY1;
		y2 = posY2;
		y3 = posY3;
		y4 = posY4;
		h = rectHeight; 
		s = spacing;
		w = weightStroke; 
		r = rounding;
		maxVal = maxValue;
		cN = colNormal; 
		cA = colAvg;
	}

	//~~~ SETUP ~~~//
	public void setup() {
		initialiseLists();
		fillList();
	}

	//~~~ DRAW ~~~//
	public void draw() {
		if (pos%256 == 0) {
			assignCookedData();
			normaliseCookedData();
			if (happyC == 1.0f) {
				countAvg++;
				sumAvg();
				normaliseAvgCookedData();
			}
		}

		smoothCookedData();
		smoothAvgCookedData();

		drawAvgData();
		drawNormalData();
	}

	//~~~ INITIALISE LISTS ~~~//
	public void initialiseLists() {
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
	}

	//~~~ FILL LISTS ~~~//
	public void fillList() {
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

	//~~~ ASSIGN COOKED DATA ~~~//
	public void assignCookedData() {
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
	}

	//~~~ NORMALISE COOKED DATA ~~~//
	public void normaliseCookedData() {
		normaDC = map(aDC, aDCList.min(), aDCList.max(), w*2, maxVal);
	    normaFmin = map(aFmin, aFminList.min(), aFminList.max(), w*2, maxVal);
	    normaFmax = map(aFmax, aFmaxList.min(), aFmaxList.max(), w*2, maxVal);
	    normaVmax = map(aVmax, aVmaxList.min(), aVmaxList.max(), w*2, maxVal);
	    normgDC = map(gDC, gDCList.min(), gDCList.max(), w*2, maxVal);
	    normgFmin = map(gFmin, gFminList.min(), gFminList.max(), w*2, maxVal);
	    normgFmax = map(gFmax, gFmaxList.min(), gFmaxList.max(), w*2, maxVal);
	    normgVmax = map(gVmax, gVmaxList.min(), gVmaxList.max(), w*2, maxVal);
	    normmDC = map(mDC, mDCList.min(), mDCList.max(), w*2, maxVal);
	    normmFmin = map(mFmin, mFminList.min(), mFminList.max(), w*2, maxVal);
	    normmFmax = map(mFmax, mFmaxList.min(), mFmaxList.max(), w*2, maxVal);
	    normmVmax = map(mVmax, mVmaxList.min(), mVmaxList.max(), w*2, maxVal);
	    normeDC = map(eDC, eDCList.min(), eDCList.max(), w*2, maxVal);
	    normeFmin = map(eFmin, eFminList.min(), eFminList.max(), w*2, maxVal);
	    normeFmax = map(eFmax, eFmaxList.min(), eFmaxList.max(), w*2, maxVal);
	    normeVmax = map(eVmax, eVmaxList.min(), eVmaxList.max(), w*2, maxVal);
	}

	//~~~ SUM FUNCTION ~~~//
	public void sumAvg() {
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
	}

	//~~~ NORMALISE AVERAGE COOKED DATA ~~~//
	public void normaliseAvgCookedData() {
	    normAvgaDC = map(sumaDC/countAvg, aDCList.min(), aDCList.max(), w*2, maxVal); 
	    normAvgaFmin = map(sumaFmin/countAvg, aFminList.min(), aFminList.max(), w*2, maxVal);
	    normAvgaFmax = map(sumaFmax/countAvg, aFmaxList.min(), aFmaxList.max(), w*2, maxVal);
	    normAvgaVmax = map(sumaVmax/countAvg, aVmaxList.min(), aVmaxList.max(), w*2, maxVal);
	    normAvggDC = map(sumgDC/countAvg, gDCList.min(), gDCList.max(), w*2, maxVal);
	    normAvggFmin = map(sumgFmin/countAvg, gFminList.min(), gFminList.max(), w*2, maxVal);
	    normAvggFmax = map(sumgFmax/countAvg, gFmaxList.min(), gFmaxList.max(), w*2, maxVal);
	    normAvggVmax = map(sumgVmax/countAvg, gVmaxList.min(), gVmaxList.max(), w*2, maxVal);
	    normAvgmDC = map(summDC/countAvg, mDCList.min(), mDCList.max(), w*2, maxVal);
	    normAvgmFmin = map(summFmin/countAvg, mFminList.min(), mFminList.max(), w*2, maxVal);
	    normAvgmFmax = map(summFmax/countAvg, mFmaxList.min(), mFmaxList.max(), w*2, maxVal);
	    normAvgmVmax = map(summVmax/countAvg, mVmaxList.min(), mVmaxList.max(), w*2, maxVal);
	    normAvgeDC = map(sumeDC/countAvg, eDCList.min(), eDCList.max(), w*2, maxVal);
	    normAvgeFmin = map(sumeFmin/countAvg, eFminList.min(), eFminList.max(), w*2, maxVal);
	    normAvgeFmax = map(sumeFmax/countAvg, eFmaxList.min(), eFmaxList.max(), w*2, maxVal);
	    normAvgeVmax = map(sumeVmax/countAvg, eVmaxList.min(), eVmaxList.max(), w*2, maxVal);	
	}

	//~~~ LINEAR INTERPOLATION COOKED DATA ~~~//
	public void smoothCookedData() {
		float amt = 0.05f;
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
	}

	//~~~ LINEAR INTERPOLATION AVERAGE COOKED DATA ~~~//
	public void smoothAvgCookedData(){
		float amt = 0.05f;
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

	}

	public void drawNormalData() {
		big.stroke(cN);
		big.strokeWeight(w);
		big.noFill();
		big.rect(x + w/2, y1 + 0 * s + w/2, smoothaDC - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y1 + 1 * s + w/2, smoothaFmin - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y1 + 2 * s + w/2, smoothaFmax - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y1 + 3 * s + w/2, smoothaVmax - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y2 + 0 * s + w/2, smoothgDC - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y2 + 1 * s + w/2, smoothgFmin - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y2 + 2 * s + w/2, smoothgFmax - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y2 + 3 * s + w/2, smoothgVmax - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y3 + 0 * s + w/2, smoothmDC - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y3 + 1 * s + w/2, smoothmFmin - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y3 + 2 * s + w/2, smoothmFmax - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y3 + 3 * s + w/2, smoothmVmax - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y4 + 0 * s + w/2, smootheDC - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y4 + 1 * s + w/2, smootheFmin - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y4 + 2 * s + w/2, smootheFmax - w, h - w, 0, r, r, 0);
		big.rect(x + w/2, y4 + 3 * s + w/2, smootheVmax - w, h - w, 0, r, r, 0);
	}

	public void drawAvgData() {
		big.noStroke();
		big.fill(cA);
		big.rect(x, y1 + 0 * s, smoothAvgaDC, h, 0, r, r, 0);
		big.rect(x, y1 + 1 * s, smoothAvgaFmin, h, 0, r, r, 0);
		big.rect(x, y1 + 2 * s, smoothAvgaFmax, h, 0, r, r, 0);
		big.rect(x, y1 + 3 * s, smoothAvgaVmax, h, 0, r, r, 0);
		big.rect(x, y2 + 0 * s, smoothAvggDC, h, 0, r, r, 0);
		big.rect(x, y2 + 1 * s, smoothAvggFmin, h, 0, r, r, 0);
		big.rect(x, y2 + 2 * s, smoothAvggFmax, h, 0, r, r, 0);
		big.rect(x, y2 + 3 * s, smoothAvggVmax, h, 0, r, r, 0);
		big.rect(x, y3 + 0 * s, smoothAvgmDC, h, 0, r, r, 0);
		big.rect(x, y3 + 1 * s, smoothAvgmFmin, h, 0, r, r, 0);
		big.rect(x, y3 + 2 * s, smoothAvgmFmax, h, 0, r, r, 0);
		big.rect(x, y3 + 3 * s, smoothAvgmVmax, h, 0, r, r, 0);
		big.rect(x, y4 + 0 * s, smoothAvgeDC, h, 0, r, r, 0);
		big.rect(x, y4 + 1 * s, smoothAvgeFmin, h, 0, r, r, 0);
		big.rect(x, y4 + 2 * s, smoothAvgeFmax, h, 0, r, r, 0);
		big.rect(x, y4 + 3 * s, smoothAvgeVmax, h, 0, r, r, 0);
	}

}
//-------------------------- HAPPY CLASS --------------------------//
class Happy {

	PFont walReg;
	float cX, cY, cR, bX, bY, bS, tX, tY, tS;
	int cC, bC, tC;

	//~~~ CONSTRUCTOR ~~~//
	public Happy (float circleX, float circleY, float circleRadius, float bgX, float bgY, float bgSize, float txtX, float txtY, float txtSize, int circleCol, int bgCol, int txtCol) {
		cX = circleX; 
		cY = circleY; 
		cR = circleRadius; 
		bX = bgX; 
		bY = bgY; 
		bS = bgSize; 
		tX = txtX; 
		tY = txtY;
		tS = txtSize;
		cC = circleCol; 
		bC = bgCol; 
		tC = txtCol;
	}

	//~~~ DRAW ~~~//
	public void draw() {
		drawCircleHappy();
		drawHappyBg();
		drawTextHappy();	
	}

	//~~~ DRAW CIRCLE HAPPY ~~~//
	public void drawCircleHappy() {
		if (happyC == 1.0f) {
			big.noStroke();
		    big.fill(cC);
		    big.ellipse(cX, cY, cR, cR);
		}
	}

	//~~~ DRAW BACKGROUND HAPPY ~~~//
	public void drawHappyBg() {
		if (happyC == 1.0f) {
			big.noStroke();
		    big.fill(bC);
		    big.rect(bX, bY, bS, bS);
		}
	}

	//~~~ TEXT HAPPY OR NOT HAPPY ~~~//
	public void drawTextHappy(){
		big.textAlign(CENTER);
		walReg = createFont("gt-walsheim-regular-web.otf", 12);
		big.fill(tC);
		if (happyC == 1.0f) {
			big.textFont(walReg, tS);
		    big.text("H A P P Y", tX, tY);
		} else {
		    big.textFont(walReg, tS);
		    big.text("N O T   H A P P Y", tX, tY);
		}
	}

}
//-------------------------- SAMPLES CLASS --------------------------//
class Samples {

	float x, y, sX, sY, r, w;
	int cCi, cICi, cCr;

	//~~~ CONSTRUCTOR ~~~//
	public Samples (float startX, float startY, float spacingX, float spacingY, float radius, float weightStroke, int colCircles, int colInsideCircles, int colCrosses) {
		x = startX;
		y = startY;
		sX = spacingX;
		sY = spacingY;
		r = radius;
		w = weightStroke;
		cCi = colCircles;
		cICi = colInsideCircles;
		cCr = colCrosses;
	}

	//~~~ DRAW ~~~//
	public void draw() {
		drawCircles();
		drawCrosses();
	}

	//~~~ DRAW CIRCLES ~~~//
	public void drawCircles() {
		for (int i = 0; i < count0_255; ++i) {
			if (i<86) {
		      	if(childrenR[i + 256*count256].getInt("happy") == 1){
		        	big.fill(cCi);
		        	big.noStroke();
		        	big.ellipse(x, y + i*sY, r, r);
		    	} else {
		    		big.fill(cCi);
		    		big.noStroke();
		    		big.ellipse(x, y + i*sY, r, r);
		    		big.fill(cICi);
		        	big.ellipse(x, y + i*sY, r-w*2, r-w*2);
		    	}
		    } 
		    if (i>=86 && i<172) {
		      	if(childrenR[i + 256*count256].getInt("happy") == 1){
		        	big.fill(cCi);
		        	big.noStroke();
		        	big.ellipse(x+sX, y + i*sY-sY*86, r, r);
		      	} else {
		      		big.fill(cCi);
		    		big.noStroke();
		    		big.ellipse(x+sX, y + i*sY-sY*86, r, r);
		    		big.fill(cICi);
		        	big.ellipse(x+sX, y + i*sY-sY*86, r-w*2, r-w*2);
		      	}
		    }
		    if (i>=172) {
		      	if(childrenR[i + 256*count256].getInt("happy") == 1){
		        	big.fill(cCi);
		        	big.noStroke();
		        	big.ellipse(x+sX*2, y + i*sY-sY*172, r, r);
		      	} else {
		        	big.fill(cCi);
		    		big.noStroke();
		    		big.ellipse(x+sX*2, y + i*sY-sY*172, r, r);
		    		big.fill(cICi);
		    		big.ellipse(x+sX*2, y + i*sY-sY*172, r-w*2, r-w*2);
		      	}
		    }
		}
	}

	//~~~ DRAW CROSSES ~~~//
	public void drawCrosses() {
		big.stroke(cCr);
  		big.strokeWeight(w);
  		strokeCap(SQUARE);
  		big.noFill();
  		for (int i = count0_255; i < 256; ++i) {
    		if (i<86) {
      			big.line(x-(r/2-1.5f*w), (y + i*sY)-(r/2-1.5f*w), x+(r/2-1.5f*w), (y + i*sY)+(r/2-1.5f*w));
      			big.line(x-(r/2-1.5f*w), (y + i*sY)+(r/2-1.5f*w), x+(r/2-1.5f*w), (y + i*sY)-(r/2-1.5f*w));
    		}
    		if (i>=86 && i<172) {
      			big.line(x+sX-(r/2-1.5f*w), (y + i*sY-sY*86)-(r/2-1.5f*w), x+sX+(r/2-1.5f*w), (y + i*sY-sY*86)+(r/2-1.5f*w));
      			big.line(x+sX-(r/2-1.5f*w), (y + i*sY-sY*86)+(r/2-1.5f*w), x+sX+(r/2-1.5f*w), (y + i*sY-sY*86)-(r/2-1.5f*w));
    		}
    		if (i>=172) {
      			big.line(x+sX*2-(r/2-1.5f*w), (y + i*sY-sY*172)-(r/2-1.5f*w), x+sX*2+(r/2-1.5f*w), (y + i*sY-sY*172)+(r/2-1.5f*w));
      			big.line(x+sX*2-(r/2-1.5f*w), (y + i*sY-sY*172)+(r/2-1.5f*w), x+sX*2+(r/2-1.5f*w), (y + i*sY-sY*172)-(r/2-1.5f*w));
    		}
  		}
	}

}
//-------------------------- TAIL CLASS --------------------------//
class Tail {
	
	float x, yTop, yBot, xMin, xMax, w, r, gz, s1, s2, yCircle;
	int cF, cS, cH;
	FloatList gzList;

	//~~~ CONSTRUCTOR ~~~//
	public Tail (float startX, float topY, float bottomY, float minX, float maxX, float weightLine, float radiusBigCircle, int colFillBigCircle, int colStroke, int colHalfCircle) {
		x = startX;
		yTop = topY;
		yBot = bottomY;
		xMin = minX;
		xMax = maxX;
		w = weightLine;
		r = radiusBigCircle;
		cF = colFillBigCircle;
		cS = colStroke;
		cH = colHalfCircle;
		
		s1 = x;
		s2 = x;
		yCircle = yTop+(yBot-yTop)/2;
		gzList = new FloatList();
		fillList();
	}

	//~~~ DRAW ~~~//
	public void draw() {
  		gz = childrenR[pos].getFloat("gz");

		float n1 = Normalise(xMin, xMax);
		float boundsCircle = (xMax-xMin)/4;
		float n2 = Normalise(xMin+boundsCircle, xMax-boundsCircle);
		s1 = lerp(s1, n1, .1f);
		s2 = lerp(s2, n2, .1f);

		drawLine();
		drawBigCircle();
		drawSmallCircle();
	}

	//~~~ LINE TAIL ~~~//
	public void drawLine() {
		big.stroke(cS);
		big.strokeWeight(w);
		big.noFill();
		big.line(s1, yTop, x, yBot);
	}

	//~~~ BIG CIRCLE TAIL ~~~//
	public void drawBigCircle() {
		big.stroke(cS);
		big.strokeWeight(w);
		big.fill(cF);
		big.ellipse(s2, yCircle, r, r);
	}

	//~~~ SMALL CIRCLE TAIL ~~~//
	public void drawSmallCircle() {
		big.noStroke();
		big.fill(cH);
		big.arc(s2, yCircle, r/2+w/2, r/2+w/2, -QUARTER_PI, HALF_PI+QUARTER_PI);

		big.stroke(cS);
		big.strokeWeight(w);
		big.noFill();
		big.ellipse(s2, yCircle, r/2, r/2);
	}

	//~~~ FILL LIST ~~~//
	public void fillList() {
	  	for (int i = 0; i < childrenR.length; i++) {
	    	gzList.append(childrenR[i].getFloat("gz"));
	  	}
	}

	//~~~ NORMALISE ~~~//
	public float Normalise(float minVal, float maxVal) {
		float normVal = map(gz, gzList.min(), gzList.max(), minVal, maxVal);
		return normVal;
	}

}
//-------------------------- TEXT CLASS --------------------------//
class Text {

	float number,ax,ay,az,gx,gy,gz,mx,my,mz,ex,ey,ez;
	int happy;
	PFont walReg, walBold, incReg, incBold;

	//~~~ SETUP FONTS ~~~//
	public void setup() {
		walReg = createFont("gt-walsheim-regular-web.otf", 12);
  		walBold = createFont("GT-Walsheim-Bold.ttf", 12);
  		incReg = createFont("Inconsolata-Regular.ttf", 12);
  		incBold = createFont("Inconsolata-Bold.ttf", 12);
	}

	//~~~ ASSIGN RAW DATA ~~~//
	public void assignRawData() {
		number = childrenR[pos].getInt("Number");
	  	ax = childrenR[pos].getFloat("ax");
	  	ay = childrenR[pos].getFloat("ay");
	  	az = childrenR[pos].getFloat("az");
	  	gx = childrenR[pos].getFloat("gx");
	  	gy = childrenR[pos].getFloat("gy");
	  	gz = childrenR[pos].getFloat("gz");
	  	mx = childrenR[pos].getFloat("mx");
	  	my = childrenR[pos].getFloat("my");
	  	mz = childrenR[pos].getFloat("mz");
	  	ex = childrenR[pos].getFloat("ex");
	  	ey = childrenR[pos].getFloat("ey");
	  	ez = childrenR[pos].getFloat("ez");
	  	happy = childrenR[pos].getInt("happy");
	}

	//~~~ FUNCTION DRAW SAMPLE COUNTER AND RAW DATA ~~~//
	public void drawTextRawData(float sampleX, float sampleY, float startX, float axY, float gxY, float mxY, float exY, float happyY, float rawSpacingX, float txtSizeSample, float txtSizeRaw, int txtColor){
		big.fill(txtColor);
		big.pushMatrix();
		big.rotate(radians(-90));
		big.textAlign(RIGHT);

		big.textFont(walReg, txtSizeSample);
		big.text(count0_255 + "      /      255",-sampleY, sampleX);

		big.textFont(incReg, txtSizeRaw);
		big.text("ax =   " + String.format("%.2f", ax),-axY, startX);
		big.text("ay =   " + String.format("%.2f", ay),-axY, startX + rawSpacingX);
		big.text("az =   " + String.format("%.2f", az),-axY, startX + 2 * rawSpacingX);
		big.text("gx =   " + String.format("%.2f", gx),-gxY, startX);
		big.text("gy =   " + String.format("%.2f", gy),-gxY, startX + rawSpacingX);
		big.text("gz =   " + String.format("%.2f", gz),-gxY, startX + 2 * rawSpacingX);
		big.text("mx =   " + String.format("%.2f", mx),-mxY, startX);
		big.text("my =   " + String.format("%.2f", my),-mxY, startX + rawSpacingX);
		big.text("mz =   " + String.format("%.2f", mz),-mxY, startX + 2 * rawSpacingX);
		big.text("ex =   " + String.format("%.2f", ex),-exY, startX);
		big.text("ey =   " + String.format("%.2f", ey),-exY, startX + rawSpacingX);
		big.text("ez =   " + String.format("%.2f", ez),-exY, startX + 2 * rawSpacingX);
		big.text("happy = " + happy,-happyY, startX + 2 * rawSpacingX);
		big.popMatrix();
		
	}

	//~~~ FUNCTION DRAW CURRENT ID ~~~//
	public void drawtextID(float x, float y, float txtSize, int txtColor){
		big.textAlign(CENTER);
		big.fill(txtColor);
		big.textFont(incBold, txtSize);
  		big.text(nf(pos/256,14), x, y);
	}

	//~~~ FUNCTION DRAW ID LIST WITH PREVIOUS ID'S AND IF WAS HAPPY OR NOT ~~~//
	public void drawtextIDList(float startX, float startY, float spacingX, float spacingY, float txtSize, int happyCol, int sadCol){
	  big.textAlign(CENTER);
	  big.textFont(incReg, txtSize);

	  for (int i = 0; i < count256; ++i) {
	    if (i<5) {
	      if (childrenC[i+countID].getFloat("happy") == 0.0f) {
	        big.fill(sadCol);
	      } else {
	        big.fill(happyCol);
	      }
	      if (count256<5) {
	        big.text(nf(i,14), startX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        big.text(nf(i+countID,14), startX, startY-(i-5)*spacingY-spacingY);
	      }
	    } 
	    if (i>=5 && i<10) {
	      if (count256<10) {
	        if (childrenC[i-5].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-5,14), startX + spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-10+countID].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-10+countID,14), startX + spacingX, startY-(i-10)*spacingY-spacingY);
	      }
	    }
	    if (i>=10 && i<15) {
	      if (count256<15) {
	        if (childrenC[i-10].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-10,14), startX + 2 * spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-20+countID].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-20+countID,14), startX + 2 * spacingX, startY-(i-15)*spacingY-spacingY);
	      }
	    }
	    if (i>=15 && i<20) {
	      if (count256<20) {
	        if (childrenC[i-15].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-15,14), startX  + 3 * spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-30+countID].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-30+countID,14), startX  + 3 * spacingX, startY-(i-20)*spacingY-spacingY);
	      }
	    }
	    if (i>=20 && i<25) {
	      if (count256<25) {
	        if (childrenC[i-20].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-20,14), startX  + 4 * spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-40+countID].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-40+countID,14), startX  + 4 * spacingX, startY-(i-25)*spacingY-spacingY);
	      }
	    }
	    if (i>=25 && i<30) {
	      if (count256<30) {
	        if (childrenC[i-25].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-25,14), startX + 5 * spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-50+countID].getFloat("happy") == 0.0f) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-50+countID,14), startX + 5 * spacingX, startY-(i-30)*spacingY-spacingY);
	      }
	    }
	  }	
	}

}
//-------------------------- HAPPY CLASS --------------------------//
class Trees {

	PFont walBold;
	float aDC,aFmin,aFmax,aVmax,gDC,gFmin,gFmax,gVmax,mDC,mFmin,mFmax,mVmax,eDC,eFmin,eFmax,eVmax;
	float rW, rH, sW, fS;
	int rC;
	boolean happyTree1, happyTree2, happyTree3, happyTree4, happyTree5, happyTree6, happyTree7, happyTree8, happyTree9;

	//~~~ CONSTRUCTOR ~~~//
	public Trees () {
		rW = 189.402f*scale;
		rH = 43.04f*scale;
		sW = 5*scale;
		fS = 14*scale;
		rC = 0xffffbcb5;



		walBold = createFont("GT-Walsheim-Bold.ttf", fS);
	}

	//~~~ DRAW ~~~//
	public void draw() {
		assignCookedData();

		big.textFont(walBold, fS);
		big.textAlign(CENTER);
		  
		drawTree1();
		drawTree2();
		drawTree3();
		drawTree4();
		drawTree5();
		drawTree6();
		drawTree7();
		drawTree8();
		drawTree9();

		circlesTrees();
	}

	public void assignCookedData() {
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
	    // gFmin = -1;
	    // mVmax = 1;
	    // gVmax = -1;
	    // gDC = 0;
	}

	public void drawTree1() {
		if (count0_255 > 16 && count0_255 < 47) {
			kleur(1197.646f, 2590.955f, "gVmax <= -1.0149");
			if (gVmax <= -1.0149f && count0_255 > 21) {
			    kleur(1197.646f, 2665.291f, "eDC <= 0.1089");
			    if (eDC <= 0.1089f && count0_255 > 26) {
			    	kleur(1197.646f, 2739.627f, "mDC <= 0.5142"); 
			      	if (mDC <= 0.5142f && count0_255 > 31) {
			        	kleur(1197.646f, 2813.964f, "eVmax <= -0.8200"); 
			        	if (eVmax <= -0.8200f && count0_255 > 36) {
					        kleur(1197.646f, 2888.631f, "mDC <= -0.5134"); 
					        if (mDC <= -0.5134f && count0_255 > 41) {
					        	kleur(1197.646f, 2962.968f, "T  R  U  E"); 
					        	happyTree1 = true;
						    } else if (mDC > -0.5134f && count0_255 > 41) {
						      	kleur(1415.966f, 2962.968f, "F  A  L  S  E");
						    }
					    } else if (eVmax > -0.8200f && count0_255 > 36) {
					      	kleur(1415.966f, 2888.631f, "F  A  L  S  E");
					    }
			      	} else if (mDC > 0.5142f && count0_255 > 31) {
			      		kleur(1415.966f, 2813.964f, "T  R  U  E");
			      		happyTree1 = true;
			      	}
			    } else if (eDC > 0.1089f && count0_255 > 26) {
			    	kleur(1415.966f, 2739.627f, "T  R  U  E");
			    	happyTree1 = true;
			    }
			} else if (gVmax > -1.0149f && count0_255 > 21) {
			  	kleur(1415.966f, 2665.291f, "T  R  U  E");
			  	happyTree1 = true;
			}
		}
	}

	public void drawTree2() {
		if (count0_255 > 52 && count0_255 < 63) {
			kleur(1197.646f, 2620.272f, "gDC <= 0.4528");
			if (gDC <= 0.4528f && count0_255 > 57) {
			    kleur(1197.646f, 2694.609f, "T  R  U  E");
			    happyTree2 = true;
			} else if (gDC > 0.4528f && count0_255 > 57) {
			  	kleur(1415.966f, 2694.609f, "F  A  L  S  E");
			}
		}
	}

	public void drawTree3() {
		if (count0_255 > 68 && count0_255 < 89) {
			kleur(1197.646f, 2620.272f, "aFmin <= 1.0180");
			if (aFmin <= 1.0180f && count0_255 > 73) {
			    kleur(1197.646f, 2694.608f, "gVmax <= -1.0025");
			    if (gVmax <= -1.0025f && count0_255 > 78) {
			    	kleur(1197.646f, 2768.945f, "aDC <= 0.7502"); 
			      if (aDC <= 0.7502f && count0_255 > 83) {
			        kleur(1197.646f, 2843.282f, "T  R  U  E"); 
			        happyTree3 = true;
			      } else if (aDC > 0.7502f && count0_255 > 83) {
			      	kleur(1415.966f, 2843.282f, "F  A  L  S  E");
			      }
			    } else if (gVmax > -1.0025f && count0_255 > 78) {
			    	kleur(1415.966f, 2768.945f, "T  R  U  E");
			    	happyTree3 = true;
			    }
			} else if (aFmin > 1.0180f && count0_255 > 73) {
			  	kleur(1415.966f, 2694.608f, "F  A  L  S  E");
			}
		}
	}

	public void drawTree4() {
		if (count0_255 > 94 && count0_255 < 120) {
			kleur(1415.209f, 2620.272f, "gFmin <= -0.3535");
			if (gFmin <= -0.3535f && count0_255 > 99) {
			    kleur(1415.646f, 2694.608f, "mVmax <= 1.1080");
			    if (mVmax <= 1.1080f && count0_255 > 104) {
			    	kleur(1197.646f, 2768.945f, "gVmax <= -0.0097"); 
			      if (gVmax <= -0.0097f && count0_255 > 109) {
			        kleur(1197.646f, 2843.281f, "eVmax <= -0.7995"); 
			        if (eVmax <= -0.7995f && count0_255 > 114) {
			          	kleur(1197.646f, 2917.281f, "T  R  U  E");
			          	happyTree4 = true;
			        } else if (eVmax > -0.7995f && count0_255 > 114){
			        	kleur(1415.966f, 2917.281f, "F  A  L  S  E");
			        }
			      } else if (gVmax > -0.0097f && count0_255 > 109) {
			      	kleur(1415.966f, 2843.281f, "F  A  L  S  E");
			      }
			    } else if (mVmax > 1.1080f && count0_255 > 104) {
			    	kleur(1415.966f, 2768.945f, "T  R  U  E");
			    	happyTree4 = true;
			    }
			} else if (gFmin > -0.3535f && count0_255 > 99) {
			  	kleur(1633.966f, 2694.608f, "gDC <= 0.5389");
			  	if (gDC <= 0.5389f && count0_255 > 104) {
			      	kleur(1633.646f, 2768.945f, "T  R  U  E");
			      	happyTree4 = true;
			    } else if (gDC > 0.5389f && count0_255 > 104){
			    	kleur(1631.299f, 2840.945f, "F  A  L  S  E");
			    }
			}
		}
	}

	public void drawTree5() {
		if (count0_255 > 125 && count0_255 < 146) {
			kleur(1197.646f, 2620.272f, "aFmax <= -0.1135");
			if (aFmax <= -0.1135f && count0_255 > 130) {
			    kleur(1197.646f, 2694.608f, "aFmax <= -0.4794");
			    if (aFmax <= -0.4794f && count0_255 > 135) {
			    	kleur(1197.646f, 2768.945f, "aDC <= 0.7502"); 
			      if (aDC <= 0.2837f && count0_255 > 140) {
			        kleur(1197.646f, 2843.282f, "T  R  U  E"); 
			        happyTree5 = true;
			      } else if (aDC > 0.2837f && count0_255 > 140) {
			      	kleur(1415.966f, 2843.282f, "F  A  L  S  E");
			      }
			    } else if (aFmax > -0.47945f && count0_255 > 135) {
			    	kleur(1415.966f, 2768.945f, "F  A  L  S  E");
			    }
			} else if (aFmax > -0.1135f && count0_255 > 130) {
			  	kleur(1415.966f, 2694.608f, "T  R  U  E");
			  	happyTree5 = true;
			}
		}
	}

	public void drawTree6() {
		if (count0_255 > 151 && count0_255 < 182) {
			kleur(1197.646f, 2590.955f, "eDC <= 0.1089");
			if (eDC <= 0.1089f && count0_255 > 156) {
			    kleur(1197.646f, 2665.291f, "aDC <= -0.4988");
			    if (aDC <= -0.4988f && count0_255 > 161) {
			    	kleur(1197.646f, 2739.627f, "eVmax <= -0.8159"); 
			      	if (eVmax <= -0.8159f && count0_255 > 166) {
			        	kleur(1197.646f, 2813.964f, "eVmax <= 1.1893"); 
			        	if (eVmax <= 1.1893f && count0_255 > 171) {
					        kleur(1197.646f, 2888.631f, "mFmin <= 0.3847"); 
					        if (mFmin <= 0.3847f && count0_255 > 176) {
					        	kleur(1197.646f, 2962.968f, "T  R  U  E");
					        	happyTree6 = true; 
						    } else if (mFmin <= 0.3847f && count0_255 > 176) {
						      	kleur(1415.966f, 2962.968f, "F  A  L  S  E");
						    }
					    } else if (eVmax <= 1.1893f && count0_255 > 171) {
					      	kleur(1415.966f, 2888.631f, "F  A  L  S  E");
					    }
			      	} else if (eVmax > -0.8159f && count0_255 > 166) {
			      		kleur(1415.966f, 2813.964f, "T  R  U  E");
			      		happyTree6 = true; 
			      	}
			    } else if (aDC > -0.4988f && count0_255 > 161) {
			    	kleur(1415.966f, 2739.627f, "T  R  U  E");
			    	happyTree6 = true; 
			    }
			} else if (eDC > 0.1089f && count0_255 > 156) {
			  	kleur(1415.966f, 2665.291f, "T  R  U  E");
			  	happyTree6 = true; 
			}
		}
	}

	public void drawTree7() {
		if (count0_255 > 187 && count0_255 < 203) {
			kleur(1197.646f, 2620.272f, "gFmax <= -0.3826");
			if (gFmax <= -0.3826f && count0_255 > 192) {
			    kleur(1197.646f, 2694.608f, "gDC <= 0.3016"); 
			      if (gDC <= 0.3016f && count0_255 > 197) {
			        kleur(1197.646f, 2769.276f, "T  R  U  E"); 
			        happyTree7 = true; 
			      } else if (gDC > 0.3016f && count0_255 > 197) {
			      	kleur(1415.966f, 2769.276f, "F  A  L  S  E");
			      }
			} else if (gFmax > -0.3826f && count0_255 > 192) {
			  	kleur(1415.966f, 2694.608f, "T  R  U  E");
			  	happyTree7 = true;
			}
		}
	}

	public void drawTree8() {
		if (count0_255 > 208 && count0_255 < 229) {
			kleur(1197.646f, 2620.272f, "aFmax <= -0.0630");
			if (aFmax <= -0.0630f && count0_255 > 213) {
			    kleur(1197.646f, 2694.608f, "eVmax <= -0.8159");
			    if (eVmax <= -0.8159f && count0_255 > 218) {
			    	kleur(1197.646f, 2768.945f, "aVmax <= 0.0912"); 
			      if (aVmax <= 0.0912f && count0_255 > 223) {
			        kleur(1197.646f, 2843.282f, "T  R  U  E"); 
			        happyTree8 = true;
			      } else if (aVmax <= 0.0912f && count0_255 > 223) {
			      	kleur(1415.966f, 2843.282f, "F  A  L  S  E");
			      }
			    } else if (eVmax <= -0.8159f && count0_255 > 218) {
			    	kleur(1415.966f, 2768.945f, "F  A  L  S  E");
			    }
			} else if (aFmax > -0.0630f && count0_255 > 213) {
			  	kleur(1415.966f, 2694.608f, "T  R  U  E");
			  	happyTree8 = true;
			}
		}
	}

	public void drawTree9() {
		if (count0_255 > 234 && count0_255 < 255) {
			kleur(1197.646f, 2620.272f, "gDC <= 0.6194");
			if (gDC <= 0.6194f && count0_255 > 239) {
			    kleur(1197.646f, 2694.608f, "mFmin <= 0.8170");
			    if (mFmin <= 0.8170f && count0_255 > 244) {
			    	kleur(1197.646f, 2768.945f, "aFmax <= -0.3312"); 
			      if (aFmax <= -0.3312f && count0_255 > 249) {
			        kleur(1197.646f, 2843.282f, "T  R  U  E"); 
			        happyTree9 = true;
			      } else if (aFmax > -0.3312f && count0_255 > 249) {
			      	kleur(1415.966f, 2843.282f, "F  A  L  S  E");
			      }
			    } else if (mFmin > 0.8170f && count0_255 > 244) {
			    	kleur(1415.966f, 2768.945f, "T  R  U  E");
			    	happyTree9 = true;
			    }
			} else if (gDC > 0.6194f && count0_255 > 239) {
			  	kleur(1415.966f, 2694.608f, "F  A  L  S  E");
			}
		}
	}

	public void kleur(float x, float y, String string) {
		big.fill(rC);
		big.noStroke();
		big.rect(x*scale+sW/2, y*scale+sW/2, rW-sW, rH-sW);

		big.fill(0);
		big.text(string, x*scale+rW/2, y*scale+rH/2+fS/3);
	}

	public void circlesTrees() {
		big.fill(255, 0, 0);
		big.noStroke();
		if (happyTree1 == true) {
			big.ellipse(1123.85f*scale, 2649.474f*scale, 11.278f*scale, 11.278f*scale);
		}
		if (happyTree2 == true) {
			big.ellipse(1123.85f*scale, 2689.45f*scale, 11.278f*scale, 11.278f*scale);
		}
		if (happyTree3 == true) {
			big.ellipse(1123.85f*scale, 2729.45f*scale, 11.278f*scale, 11.278f*scale);
		}
		if (happyTree4 == true) {
			big.ellipse(1123.85f*scale, 2769.849f*scale, 11.278f*scale, 11.278f*scale);
		}
		if (happyTree5 == true) {
			big.ellipse(1123.85f*scale, 2809.974f*scale, 11.278f*scale, 11.278f*scale);
		}
		if (happyTree6 == true) {
			big.ellipse(1123.85f*scale, 2850.099f*scale, 11.278f*scale, 11.278f*scale);
		}
		if (happyTree7 == true) {
			big.ellipse(1123.85f*scale, 2890.224f*scale, 11.278f*scale, 11.278f*scale);
		}
		if (happyTree8 == true) {
			big.ellipse(1123.85f*scale, 2930.349f*scale, 11.278f*scale, 11.278f*scale);
		}
		if (happyTree9 == true) {
			big.ellipse(1123.85f*scale, 2970.474f*scale, 11.278f*scale, 11.278f*scale);
		}

		
		if (pos%256 ==  0) {
			happyTree1 = false;
			happyTree2 = false;
			happyTree3 = false;
			happyTree4 = false;
			happyTree5 = false;
			happyTree6 = false;
			happyTree7 = false;
			happyTree8 = false;
			happyTree9 = false;
		}
	}
}
  public void settings() {  size(450,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "happyDogDataVisualization" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
