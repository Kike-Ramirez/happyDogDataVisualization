class Tail {
	
	float x, yTop, yBot, xMin, xMax, w, r, gz, s1, s2, yCircle;
	color cF, cS, cH;
	FloatList gzList;

	public Tail (float startX, float topY, float bottomY, float minX, float maxX, float weightLine, float radiusBigCircle, color colFillBigCircle, color colStroke, color colHalfCircle) {
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

	void draw() {
  		gz = childrenR[pos].getFloat("gz");

		float n1 = Normalise(xMin, xMax);
		float boundsCircle = (xMax-xMin)/4;
		float n2 = Normalise(xMin+boundsCircle, xMax-boundsCircle);
		s1 = lerp(s1, n1, .1);
		s2 = lerp(s2, n2, .1);

		drawLine();
		drawBigCircle();
		drawSmallCircle();
	}

	void drawLine() {
		big.stroke(cS);
		big.strokeWeight(w);
		big.noFill();
		big.line(s1, yTop, x, yBot);
	}

	void drawBigCircle() {
		big.stroke(cS);
		big.strokeWeight(w);
		big.fill(cF);
		big.ellipse(s2, yCircle, r, r);
	}

	void drawSmallCircle() {
		big.noStroke();
		big.fill(cH);
		big.arc(s2, yCircle, r/2+w/2, r/2+w/2, -QUARTER_PI, HALF_PI+QUARTER_PI);

		big.stroke(cS);
		big.strokeWeight(w);
		big.noFill();
		big.ellipse(s2, yCircle, r/2, r/2);
	}

	void fillList() {
	  	for (int i = 0; i < childrenR.length; i++) {
	    	gzList.append(childrenR[i].getFloat("gz"));
	  	}
	}

	float Normalise(float minVal, float maxVal) {
		float normVal = map(gz, gzList.min(), gzList.max(), minVal, maxVal);
		return normVal;
	}

}