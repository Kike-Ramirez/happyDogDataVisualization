//-------------------------- HAPPY CLASS --------------------------//
class Happy {

	PFont walReg;
	float cX, cY, cR, bX, bY, bS, tX, tY, tS;
	color cC, bC, tC;

	//~~~ CONSTRUCTOR ~~~//
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

	//~~~ DRAW ~~~//
	void draw() {
		drawCircleHappy();
		drawHappyBg();
		drawTextHappy();	
	}

	//~~~ DRAW CIRCLE HAPPY ~~~//
	void drawCircleHappy() {
		if (happyC == 1.0) {
			big.noStroke();
		    big.fill(cC);
		    big.ellipse(cX, cY, cR, cR);
		}
	}

	//~~~ DRAW BACKGROUND HAPPY ~~~//
	void drawHappyBg() {
		if (happyC == 1.0) {
			big.noStroke();
		    big.fill(bC);
		    big.rect(bX, bY, bS, bS);
		}
	}

	//~~~ TEXT HAPPY OR NOT HAPPY ~~~//
	void drawTextHappy(){
		big.textAlign(CENTER);
		walReg = createFont("gt-walsheim-regular-web.otf", 12);
		big.fill(tC);
		if (happyC == 1.0) {
			big.textFont(walReg, tS);
		    big.text("H A P P Y", tX, tY);
		} else {
		    big.textFont(walReg, tS);
		    big.text("N O T   H A P P Y", tX, tY);
		}
	}

}