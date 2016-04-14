class Text {

	float number,ax,ay,az,gx,gy,gz,mx,my,mz,ex,ey,ez;
	int happy;
	PFont walReg, walBold, incReg, incBold;

	public Text () {
		
	}

	void setup() {
		walReg = createFont("gt-walsheim-regular-web.otf", 12);
  		walBold = createFont("GT-Walsheim-Bold.ttf", 12);
  		incReg = createFont("Inconsolata-Regular.ttf", 12);
  		incBold = createFont("Inconsolata-Bold.ttf", 12);
	}

	void assignRawData() {
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

	void drawTextRawData(float sampleX, float sampleY, float startX, float axY, float gxY, float mxY, float exY, float happyY, float rawSpacingX, float txtSizeSample, float txtSizeRaw, color txtColor){
		big.fill(txtColor);
		big.pushMatrix();
		big.rotate(radians(-90));
		big.textAlign(CENTER);

		big.textFont(walReg, txtSizeSample);
		big.text(count0_255 + "      /      255",-sampleY, sampleX);

		big.textFont(walReg, txtSizeRaw);
		big.text("ax = " + String.format("%.2f", ax),-axY, startX);
		big.text("ay = " + String.format("%.2f", ay),-axY, startX + rawSpacingX);
		big.text("az = " + String.format("%.2f", az),-axY, startX + 2 * rawSpacingX);
		big.text("gx = " + String.format("%.2f", gx),-gxY, startX);
		big.text("gy = " + String.format("%.2f", gy),-gxY, startX + rawSpacingX);
		big.text("gz = " + String.format("%.2f", gz),-gxY, startX + 2 * rawSpacingX);
		big.text("mx = " + String.format("%.2f", mx),-mxY, startX);
		big.text("my = " + String.format("%.2f", my),-mxY, startX + rawSpacingX);
		big.text("mz = " + String.format("%.2f", mz),-mxY, startX + 2 * rawSpacingX);
		big.text("ex = " + String.format("%.2f", ex),-exY, startX);
		big.text("ey = " + String.format("%.2f", ey),-exY, startX + rawSpacingX);
		big.text("ez = " + String.format("%.2f", ez),-exY, startX + 2 * rawSpacingX);
		big.text("happy = " + happy,-happyY, startX + 2 * rawSpacingX);
		big.popMatrix();
		
	}

	void drawtextID(float x, float y, float txtSize, color txtColor){
		big.fill(txtColor);
		big.textFont(incBold, txtSize);
  		big.text(nf(pos/256,14), x, y);
	}

	void drawtextIDList(float startX, float startY, float spacingX, float spacingY, float txtSize, color happyCol, color sadCol){
	  
	  big.textFont(incReg, txtSize);

	  for (int i = 0; i < count256; ++i) {
	    if (i<5) {
	      if (childrenC[i+countID].getFloat("happy") == 0.0) {
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
	        if (childrenC[i-5].getFloat("happy") == 0.0) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-5,14), startX + spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-10+countID].getFloat("happy") == 0.0) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-10+countID,14), startX + spacingX, startY-(i-10)*spacingY-spacingY);
	      }
	    }
	    if (i>=10 && i<15) {
	      if (count256<15) {
	        if (childrenC[i-10].getFloat("happy") == 0.0) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-10,14), startX + 2 * spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-20+countID].getFloat("happy") == 0.0) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-20+countID,14), startX + 2 * spacingX, startY-(i-15)*spacingY-spacingY);
	      }
	    }
	    if (i>=15 && i<20) {
	      if (count256<20) {
	        if (childrenC[i-15].getFloat("happy") == 0.0) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-15,14), startX  + 3 * spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-30+countID].getFloat("happy") == 0.0) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-30+countID,14), startX  + 3 * spacingX, startY-(i-20)*spacingY-spacingY);
	      }
	    }
	    if (i>=20 && i<25) {
	      if (count256<25) {
	        if (childrenC[i-20].getFloat("happy") == 0.0) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-20,14), startX  + 4 * spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-40+countID].getFloat("happy") == 0.0) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-40+countID,14), startX  + 4 * spacingX, startY-(i-25)*spacingY-spacingY);
	      }
	    }
	    if (i>=25 && i<30) {
	      if (count256<30) {
	        if (childrenC[i-25].getFloat("happy") == 0.0) {
	          big.fill(sadCol);
	        } else {
	          big.fill(happyCol);
	        }
	        big.text(nf(i-25,14), startX + 5 * spacingX, startY-(i-count256)*spacingY-spacingY);
	      } else {
	        if (childrenC[i-50+countID].getFloat("happy") == 0.0) {
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