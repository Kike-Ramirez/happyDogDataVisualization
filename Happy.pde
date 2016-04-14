class Happy {

	PFont walReg;
	float cX, cY, cR, bX, bY, bS, tX, tY, tS;
	color cC, bC, tC;

	public Happy (float circleX, float circleY, float circleRadius, float bgX, float bgY, float bgSize, float txtX, float txtY, float txtSize, color circleCol, color bgCol, color txtCol) {
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

	void draw() {
		drawCircleHappy();
		drawHappyBg();
		drawTextHappy();	
	}

	void drawCircleHappy() {
		if (happyC == 1.0) {
			big.noStroke();
		    big.fill(cC);
		    big.ellipse(cX, cY, cR, cR);
		}
	}

	void drawHappyBg() {
		if (happyC == 1.0) {
			big.noStroke();
		    big.fill(bC);
		    big.rect(bX, bY, bS, bS);
		}
	}

	void drawTextHappy(){
		walReg = createFont("gt-walsheim-regular-web.otf", 12);
		big.fill(tC);
		if (happyC == 1.0) {
			big.textFont(walReg, tS);
		    big.text("HAPPY", tX, tY);
		} else {
		    big.textFont(walReg, tS);
		    big.text("NOT HAPPY", tX, tY);
		}
	}

}