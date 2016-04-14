class Bars {

	float x,y1,y2,y3,y4,h,s,w,r,maxVal;
	color cN, cA;

	FloatList aDCList,aFminList,aFmaxList,aVmaxList,gDCList,gFminList,gFmaxList,gVmaxList,mDCList,mFminList,mFmaxList,mVmaxList,eDCList,eFminList,eFmaxList,eVmaxList;
	float aDC,aFmin,aFmax,aVmax,gDC,gFmin,gFmax,gVmax,mDC,mFmin,mFmax,mVmax,eDC,eFmin,eFmax,eVmax;
	float normaDC,normaFmin,normaFmax,normaVmax,normgDC,normgFmin,normgFmax,normgVmax,normmDC,normmFmin,normmFmax,normmVmax,normeDC,normeFmin,normeFmax,normeVmax;
	float sumaDC,sumaFmin,sumaFmax,sumaVmax,sumgDC,sumgFmin,sumgFmax,sumgVmax,summDC,summFmin,summFmax,summVmax,sumeDC,sumeFmin,sumeFmax,sumeVmax;
	float normAvgaDC,normAvgaFmin,normAvgaFmax,normAvgaVmax,normAvggDC,normAvggFmin,normAvggFmax,normAvggVmax,normAvgmDC,normAvgmFmin,normAvgmFmax,normAvgmVmax,normAvgeDC,normAvgeFmin,normAvgeFmax,normAvgeVmax;
	float smoothaDC,smoothaFmin,smoothaFmax,smoothaVmax,smoothgDC,smoothgFmin,smoothgFmax,smoothgVmax,smoothmDC,smoothmFmin,smoothmFmax,smoothmVmax,smootheDC,smootheFmin,smootheFmax,smootheVmax;
	float smoothAvgaDC,smoothAvgaFmin,smoothAvgaFmax,smoothAvgaVmax,smoothAvggDC,smoothAvggFmin,smoothAvggFmax,smoothAvggVmax,smoothAvgmDC,smoothAvgmFmin,smoothAvgmFmax,smoothAvgmVmax,smoothAvgeDC,smoothAvgeFmin,smoothAvgeFmax,smoothAvgeVmax;

	public Bars (float posX, float posY1, float posY2, float posY3, float posY4, float rectHeight, float spacing, float weightStroke, float rounding, float maxValue, color colNormal, color colAvg) {
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

	void setup() {
		initialiseLists();
		fillList();
	}

	void draw() {
		assignCookedData();
		normaliseCookedData();
		if (happyC == 1.0) {
			countAvg++;
			sumAvg();
			normaliseAvgCookedData();
		}
		smoothCookedData();
		smoothAvgCookedData();

		drawAvgData();
		drawNormalData();
	}

	void initialiseLists() {
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

	void fillList() {
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

	void assignCookedData() {
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

	void normaliseCookedData() {
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

	void sumAvg() {
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

	void normaliseAvgCookedData() {
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

	void smoothCookedData() {
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
	}

	void smoothAvgCookedData(){
		float amt = 0.05;
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

	void drawNormalData() {
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

	void drawAvgData() {
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