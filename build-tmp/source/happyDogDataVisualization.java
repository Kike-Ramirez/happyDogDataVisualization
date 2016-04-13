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

public void setup() {
  
  big = createGraphics(2160,3840);
  bg = loadImage("perrito.png");

  xmlRaw = loadXML("raw_final.xml");
  xmlCooked = loadXML("cooked_final.xml");
  childrenR = xmlRaw.getChildren("Measure");
  childrenC = xmlCooked.getChildren("measure");
  
  //Tail(startX, topY, bottomY, minX, maxX, weightLine, radiusBigCircle, colFillBigCircle, colStroke, colHalfCircle)
  tail = new Tail(918.5f, 401, 925, 447.746f, 1388.663f, 5, 110.464f, 0xffFFFBF2, color(0), color(255,0,0));
  //Samples(startX, startY, spacingX, spacingY, radius, weightStroke, colCircles, colInsideCircles, colCrosses)
  samples = new Samples(568.555f, 1055.091f, 26.473f, 20, 13.156f, 2, color(0), 0xffFFFBF2, color(255,0,0));
  //Bars(posX, posY1, posY2, posY3, posY4, rectHeight, spacing, weightStroke, rounding, colNormal, colAvg, maxValue)
  bars = new Bars(1094.548f, 1043.347f, 1364.572f, 1685.798f, 2007.023f, 58.405f, 77.873f, 6, 50, color(0), 0xffffbcb5, 617);
  txt = new Text();
  
  bars.setup();
  txt.setup();

  pos = 1420;
  count256 = PApplet.parseInt(pos/256);
}

public void draw() {
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

	public Bars (float posX, float posY1, float posY2, float posY3, float posY4, float rectHeight, float spacing, float weightStroke, float rounding, int colNormal, int colAvg, float maxValue) {
		x = posX;
		y1 = posY1;
		y2 = posY2;
		y3 = posY3;
		y4 = posY4;
		h = rectHeight; 
		s = spacing;
		w = weightStroke; 
		r = rounding;
		cN = colNormal; 
		cA = colAvg;
		maxVal = maxValue;
	}

	public void setup() {
		initialiseLists();
		fillList();
	}

	public void draw() {
		assignCookedData();
		normaliseCookedData();
		if (happyC == 1.0f) {
			countAvg++;
			sumAvg();
			normaliseAvgCookedData();
		}
		smoothCookedData();
		smoothAvgCookedData();

		drawAvgData();
		drawNormalData();
	}

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

	public void normaliseCookedData() {
		normaDC = map(aDC, aDCList.min(), aDCList.max(), 0, maxVal);
	    normaFmin = map(aFmin, aFminList.min(), aFminList.max(), 0, maxVal);
	    normaFmax = map(aFmax, aFmaxList.min(), aFmaxList.max(), 0, maxVal);
	    normaVmax = map(aVmax, aVmaxList.min(), aVmaxList.max(), 0, maxVal);
	    normgDC = map(gDC, gDCList.min(), gDCList.max(), 0, maxVal);
	    normgFmin = map(gFmin, gFminList.min(), gFminList.max(), 0, maxVal);
	    normgFmax = map(gFmax, gFmaxList.min(), gFmaxList.max(), 0, maxVal);
	    normgVmax = map(gVmax, gVmaxList.min(), gVmaxList.max(), 0, maxVal);
	    normmDC = map(mDC, mDCList.min(), mDCList.max(), 0, maxVal);
	    normmFmin = map(mFmin, mFminList.min(), mFminList.max(), 0, maxVal);
	    normmFmax = map(mFmax, mFmaxList.min(), mFmaxList.max(), 0, maxVal);
	    normmVmax = map(mVmax, mVmaxList.min(), mVmaxList.max(), 0, maxVal);
	    normeDC = map(eDC, eDCList.min(), eDCList.max(), 0, maxVal);
	    normeFmin = map(eFmin, eFminList.min(), eFminList.max(), 0, maxVal);
	    normeFmax = map(eFmax, eFmaxList.min(), eFmaxList.max(), 0, maxVal);
	    normeVmax = map(eVmax, eVmaxList.min(), eVmaxList.max(), 0, maxVal);
	}

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

	public void normaliseAvgCookedData() {
	    normAvgaDC = map(sumaDC/countAvg, aDCList.min(), aDCList.max(), 0, maxVal); 
	    normAvgaFmin = map(sumaFmin/countAvg, aFminList.min(), aFminList.max(), 0, maxVal);
	    normAvgaFmax = map(sumaFmax/countAvg, aFmaxList.min(), aFmaxList.max(), 0, maxVal);
	    normAvgaVmax = map(sumaVmax/countAvg, aVmaxList.min(), aVmaxList.max(), 0, maxVal);
	    normAvggDC = map(sumgDC/countAvg, gDCList.min(), gDCList.max(), 0, maxVal);
	    normAvggFmin = map(sumgFmin/countAvg, gFminList.min(), gFminList.max(), 0, maxVal);
	    normAvggFmax = map(sumgFmax/countAvg, gFmaxList.min(), gFmaxList.max(), 0, maxVal);
	    normAvggVmax = map(sumgVmax/countAvg, gVmaxList.min(), gVmaxList.max(), 0, maxVal);
	    normAvgmDC = map(summDC/countAvg, mDCList.min(), mDCList.max(), 0, maxVal);
	    normAvgmFmin = map(summFmin/countAvg, mFminList.min(), mFminList.max(), 0, maxVal);
	    normAvgmFmax = map(summFmax/countAvg, mFmaxList.min(), mFmaxList.max(), 0, maxVal);
	    normAvgmVmax = map(summVmax/countAvg, mVmaxList.min(), mVmaxList.max(), 0, maxVal);
	    normAvgeDC = map(sumeDC/countAvg, eDCList.min(), eDCList.max(), 0, maxVal);
	    normAvgeFmin = map(sumeFmin/countAvg, eFminList.min(), eFminList.max(), 0, maxVal);
	    normAvgeFmax = map(sumeFmax/countAvg, eFmaxList.min(), eFmaxList.max(), 0, maxVal);
	    normAvgeVmax = map(sumeVmax/countAvg, eVmaxList.min(), eVmaxList.max(), 0, maxVal);	
	}

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
class Samples {

	float x, y, sX, sY, r, w;
	int cCi, cICi, cCr;

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

	public void draw() {
		drawCircles();
		drawCrosses();
	}

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
class Tail {
	
	float x, yTop, yBot, xMin, xMax, w, r, gz, s1, s2, yCircle;
	int cF, cS, cH;
	FloatList gzList;

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

	public void drawLine() {
		big.stroke(cS);
		big.strokeWeight(w);
		big.noFill();
		big.line(s1, yTop, x, yBot);
	}

	public void drawBigCircle() {
		big.stroke(cS);
		big.strokeWeight(w);
		big.fill(cF);
		big.ellipse(s2, yCircle, r, r);
	}

	public void drawSmallCircle() {
		big.noStroke();
		big.fill(cH);
		big.arc(s2, yCircle, r/2+w/2, r/2+w/2, -QUARTER_PI, HALF_PI+QUARTER_PI);

		big.stroke(cS);
		big.strokeWeight(w);
		big.noFill();
		big.ellipse(s2, yCircle, r/2, r/2);
	}

	public void fillList() {
	  	for (int i = 0; i < childrenR.length; i++) {
	    	gzList.append(childrenR[i].getFloat("gz"));
	  	}
	}

	public float Normalise(float minVal, float maxVal) {
		float normVal = map(gz, gzList.min(), gzList.max(), minVal, maxVal);
		return normVal;
	}

}
class Text {

	float number,ax,ay,az,gx,gy,gz,mx,my,mz,ex,ey,ez;
	int happy;
	PFont walReg, walBold, incReg, incBold;

	public Text () {
		
	}

	public void setup() {
		walReg = createFont("gt-walsheim-regular-web.otf", 12);
  		walBold = createFont("GT-Walsheim-Bold.ttf", 12);
  		incReg = createFont("Inconsolata-Regular.ttf", 12);
  		incBold = createFont("Inconsolata-Bold.ttf", 12);
	}

	public void draw() {
		assignRawData();
		drawTextRawData();
		drawTextHappy();
		drawtextID();
		drawtextIDList();

		if (happyC == 1.0f) {
			big.noStroke();
		    big.fill(0);
		    big.ellipse(1124.29f, 3073.26f, 21.287f, 21.287f);
		}
	}

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

	public void drawTextRawData(){
		big.fill(0);
		big.pushMatrix();
		big.rotate(radians(-90));
		big.textAlign(CENTER);

		big.textFont(walReg, 10);
		big.text(count0_255 + "      /      255",-1098.563f, 505.097f);

		big.textFont(walReg, 12);
		big.text("ax = " + String.format("%.2f", ax),-1068.918f, 709.885f);
		big.text("ay = " + String.format("%.2f", ay),-1068.918f, 724.485f);
		big.text("az = " + String.format("%.2f", az),-1068.918f, 739.085f);
		big.text("gx = " + String.format("%.2f", gx),-1392.175f, 709.885f);
		big.text("gy = " + String.format("%.2f", gy),-1392.175f, 724.485f);
		big.text("gz = " + String.format("%.2f", gz),-1392.175f, 739.085f);
		big.text("mx = " + String.format("%.2f", mx),-1718.025f, 709.885f);
		big.text("my = " + String.format("%.2f", my),-1718.025f, 724.485f);
		big.text("mz = " + String.format("%.2f", mz),-1718.025f, 739.085f);
		big.text("ex = " + String.format("%.2f", ex),-2036.524f, 709.885f);
		big.text("ey = " + String.format("%.2f", ey),-2036.524f, 724.485f);
		big.text("ez = " + String.format("%.2f", ez),-2036.524f, 739.085f);
		big.text("happy = " + happy,-2356.194f,739.085f);
		big.popMatrix();
		
	}

	public void drawTextHappy(){
		if (happyC == 1.0f) {
			big.textFont(walReg,30);
		    big.text("HAPPY",1613.146f,3227.794f);
		} else {
		    big.textFont(walReg,30);
		    big.text("NOT HAPPY",1613.146f,3227.794f);
		}
	}

	public void drawtextID(){
		big.textFont(incBold,24);
  		big.text(nf(pos/256,14),918.343f, 3072.907f+6);
	}

	public void drawtextIDList(){
		float col1 = 516.045f;
	  float col2 = 678.01f;
	  float col3 = 838.942f;
	  float col4 = 1000.907f;
	  float col5 = 1162.675f;
	  float col6 = 1324.64f;
	  float b = 3230.353f;
	  float spacing = 14.602f;
	  big.textFont(incReg,13);

	  for (int i = 0; i < count256; ++i) {
	    if (i<5) {
	      if (childrenC[i+countID].getFloat("happy") == 0.0f) {
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
	        if (childrenC[i-5].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-5,14), col2, b-(i-count256)*spacing-spacing);
	      } else {
	        if (childrenC[i-10+countID].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-10+countID,14), col2, b-(i-10)*spacing-spacing);
	      }
	    }
	    if (i>=10 && i<15) {
	      if (count256<15) {
	        if (childrenC[i-10].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-10,14), col3, b-(i-count256)*spacing-spacing);
	      } else {
	        if (childrenC[i-20+countID].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-20+countID,14), col3, b-(i-15)*spacing-spacing);
	      }
	    }
	    if (i>=15 && i<20) {
	      if (count256<20) {
	        if (childrenC[i-15].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-15,14), col4, b-(i-count256)*spacing-spacing);
	      } else {
	        if (childrenC[i-30+countID].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-30+countID,14), col4, b-(i-20)*spacing-spacing);
	      }
	    }
	    if (i>=20 && i<25) {
	      if (count256<25) {
	        if (childrenC[i-20].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-20,14), col5, b-(i-count256)*spacing-spacing);
	      } else {
	        if (childrenC[i-40+countID].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-40+countID,14), col5, b-(i-25)*spacing-spacing);
	      }
	    }
	    if (i>=25 && i<30) {
	      if (count256<30) {
	        if (childrenC[i-25].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-25,14), col6, b-(i-count256)*spacing-spacing);
	      } else {
	        if (childrenC[i-50+countID].getFloat("happy") == 0.0f) {
	          big.fill(179, 179, 179);
	        } else {
	          big.fill(0);
	        }
	        big.text(nf(i-50+countID,14), col6, b-(i-30)*spacing-spacing);
	      }
	    }
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
