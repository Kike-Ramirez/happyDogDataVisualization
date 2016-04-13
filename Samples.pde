class Samples {

	float x, y, sX, sY, r, w;
	color cCi, cICi, cCr;

	public Samples (float startX, float startY, float spacingX, float spacingY, float radius, float weightStroke, color colCircles, color colInsideCircles, color colCrosses) {
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

	void draw() {
		drawCircles();
		drawCrosses();
	}

	void drawCircles() {
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

	void drawCrosses() {
		big.stroke(cCr);
  		big.strokeWeight(w);
  		strokeCap(SQUARE);
  		big.noFill();
  		for (int i = count0_255; i < 256; ++i) {
    		if (i<86) {
      			big.line(x-(r/2-1.5*w), (y + i*sY)-(r/2-1.5*w), x+(r/2-1.5*w), (y + i*sY)+(r/2-1.5*w));
      			big.line(x-(r/2-1.5*w), (y + i*sY)+(r/2-1.5*w), x+(r/2-1.5*w), (y + i*sY)-(r/2-1.5*w));
    		}
    		if (i>=86 && i<172) {
      			big.line(x+sX-(r/2-1.5*w), (y + i*sY-sY*86)-(r/2-1.5*w), x+sX+(r/2-1.5*w), (y + i*sY-sY*86)+(r/2-1.5*w));
      			big.line(x+sX-(r/2-1.5*w), (y + i*sY-sY*86)+(r/2-1.5*w), x+sX+(r/2-1.5*w), (y + i*sY-sY*86)-(r/2-1.5*w));
    		}
    		if (i>=172) {
      			big.line(x+sX*2-(r/2-1.5*w), (y + i*sY-sY*172)-(r/2-1.5*w), x+sX*2+(r/2-1.5*w), (y + i*sY-sY*172)+(r/2-1.5*w));
      			big.line(x+sX*2-(r/2-1.5*w), (y + i*sY-sY*172)+(r/2-1.5*w), x+sX*2+(r/2-1.5*w), (y + i*sY-sY*172)-(r/2-1.5*w));
    		}
  		}
	}

}