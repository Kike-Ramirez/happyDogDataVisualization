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

	void draw() {
		assignRawData();
		drawTextRawData();
		drawTextHappy();
		drawtextID();
		drawtextIDList();

		if (happyC == 1.0) {
			big.noStroke();
		    big.fill(0);
		    big.ellipse(1124.29, 3073.26, 21.287, 21.287);
		}
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

	void drawTextRawData(){
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
		
	}

	void drawTextHappy(){
		if (happyC == 1.0) {
			big.textFont(walReg,30);
		    big.text("HAPPY",1613.146,3227.794);
		} else {
		    big.textFont(walReg,30);
		    big.text("NOT HAPPY",1613.146,3227.794);
		}
	}

	void drawtextID(){
		big.textFont(incBold,24);
  		big.text(nf(pos/256,14),918.343, 3072.907+6);
	}

	void drawtextIDList(){
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

}