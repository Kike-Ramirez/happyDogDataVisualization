//-------------------------- HAPPY CLASS --------------------------//
class Trees {

	PFont walBold;
	float aDC,aFmin,aFmax,aVmax,gDC,gFmin,gFmax,gVmax,mDC,mFmin,mFmax,mVmax,eDC,eFmin,eFmax,eVmax;
	float rW, rH, sW, fS;
	color rC;
	boolean happyTree1, happyTree2, happyTree3, happyTree4, happyTree5, happyTree6, happyTree7, happyTree8, happyTree9;

	//~~~ CONSTRUCTOR ~~~//
	public Trees () {
		rW = 189.402*scale;
		rH = 43.04*scale;
		sW = 5*scale;
		fS = 14*scale;
		rC = #ffbcb5;



		walBold = createFont("GT-Walsheim-Bold.ttf", fS);
	}

	//~~~ DRAW ~~~//
	void draw() {
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
	    // gFmin = -1;
	    // mVmax = 1;
	    // gVmax = -1;
	    // gDC = 0;
	}

	void drawTree1() {
		if (count0_255 > 16 && count0_255 < 47) {
			kleur(1197.646, 2590.955, "gVmax <= -1.0149");
			if (gVmax <= -1.0149 && count0_255 > 21) {
				kleur(1415.966, 2665.291, "T  R  U  E");
			  	happyTree1 = true;
			    kleur(1197.646, 2665.291, "eDC <= 0.1089");
			    if (eDC <= 0.1089 && count0_255 > 26) {
			    	kleur(1197.646, 2739.627, "mDC <= 0.5142"); 
			      	if (mDC <= 0.5142 && count0_255 > 31) {
			        	kleur(1197.646, 2813.964, "eVmax <= -0.8200"); 
			        	if (eVmax <= -0.8200 && count0_255 > 36) {
					        kleur(1197.646, 2888.631, "mDC <= -0.5134"); 
					        if (mDC <= -0.5134 && count0_255 > 41) {
					        	kleur(1197.646, 2962.968, "T  R  U  E"); 
					        	happyTree1 = true;
						    } else if (mDC > -0.5134 && count0_255 > 41) {
						      	kleur(1415.966, 2962.968, "F  A  L  S  E");
						    }
					    } else if (eVmax > -0.8200 && count0_255 > 36) {
					      	kleur(1415.966, 2888.631, "F  A  L  S  E");
					    }
			      	} else if (mDC > 0.5142 && count0_255 > 31) {
			      		kleur(1415.966, 2813.964, "T  R  U  E");
			      		happyTree1 = true;
			      	}
			    } else if (eDC > 0.1089 && count0_255 > 26) {
			    	kleur(1415.966, 2739.627, "T  R  U  E");
			    	happyTree1 = true;
			    }
			} else if (gVmax > -1.0149 && count0_255 > 21) {
			  	kleur(1415.966, 2665.291, "T  R  U  E");
			  	happyTree1 = true;
			}
		}
	}

	void drawTree2() {
		if (count0_255 > 52 && count0_255 < 63) {
			kleur(1197.646, 2620.272, "gDC <= 0.4528");
			if (gDC <= 0.4528 && count0_255 > 57) {
			    kleur(1197.646, 2694.609, "T  R  U  E");
			    happyTree2 = true;
			} else if (gDC > 0.4528 && count0_255 > 57) {
			  	kleur(1415.966, 2694.609, "F  A  L  S  E");
			}
		}
	}

	void drawTree3() {
		if (count0_255 > 68 && count0_255 < 89) {
			kleur(1197.646, 2620.272, "aFmin <= 1.0180");
			if (aFmin <= 1.0180 && count0_255 > 73) {
			    kleur(1197.646, 2694.608, "gVmax <= -1.0025");
			    if (gVmax <= -1.0025 && count0_255 > 78) {
			    	kleur(1197.646, 2768.945, "aDC <= 0.7502"); 
			      if (aDC <= 0.7502 && count0_255 > 83) {
			        kleur(1197.646, 2843.282, "T  R  U  E"); 
			        happyTree3 = true;
			      } else if (aDC > 0.7502 && count0_255 > 83) {
			      	kleur(1415.966, 2843.282, "F  A  L  S  E");
			      }
			    } else if (gVmax > -1.0025 && count0_255 > 78) {
			    	kleur(1415.966, 2768.945, "T  R  U  E");
			    	happyTree3 = true;
			    }
			} else if (aFmin > 1.0180 && count0_255 > 73) {
			  	kleur(1415.966, 2694.608, "F  A  L  S  E");
			}
		}
	}

	void drawTree4() {
		if (count0_255 > 94 && count0_255 < 120) {
			kleur(1415.209, 2620.272, "gFmin <= -0.3535");
			if (gFmin <= -0.3535 && count0_255 > 99) {
			    kleur(1415.646, 2694.608, "mVmax <= 1.1080");
			    if (mVmax <= 1.1080 && count0_255 > 104) {
			    	kleur(1197.646, 2768.945, "gVmax <= -0.0097"); 
			      if (gVmax <= -0.0097 && count0_255 > 109) {
			        kleur(1197.646, 2843.281, "eVmax <= -0.7995"); 
			        if (eVmax <= -0.7995 && count0_255 > 114) {
			          	kleur(1197.646, 2917.281, "T  R  U  E");
			          	happyTree4 = true;
			        } else if (eVmax > -0.7995 && count0_255 > 114){
			        	kleur(1415.966, 2917.281, "F  A  L  S  E");
			        }
			      } else if (gVmax > -0.0097 && count0_255 > 109) {
			      	kleur(1415.966, 2843.281, "F  A  L  S  E");
			      }
			    } else if (mVmax > 1.1080 && count0_255 > 104) {
			    	kleur(1415.966, 2768.945, "T  R  U  E");
			    	happyTree4 = true;
			    }
			} else if (gFmin > -0.3535 && count0_255 > 99) {
			  	kleur(1633.966, 2694.608, "gDC <= 0.5389");
			  	if (gDC <= 0.5389 && count0_255 > 104) {
			      	kleur(1633.646, 2768.945, "T  R  U  E");
			      	happyTree4 = true;
			    } else if (gDC > 0.5389 && count0_255 > 104){
			    	kleur(1631.299, 2840.945, "F  A  L  S  E");
			    }
			}
		}
	}

	void drawTree5() {
		if (count0_255 > 125 && count0_255 < 146) {
			kleur(1197.646, 2620.272, "aFmax <= -0.1135");
			if (aFmax <= -0.1135 && count0_255 > 130) {
			    kleur(1197.646, 2694.608, "aFmax <= -0.4794");
			    if (aFmax <= -0.4794 && count0_255 > 135) {
			    	kleur(1197.646, 2768.945, "aDC <= 0.7502"); 
			      if (aDC <= 0.2837 && count0_255 > 140) {
			        kleur(1197.646, 2843.282, "T  R  U  E"); 
			        happyTree5 = true;
			      } else if (aDC > 0.2837 && count0_255 > 140) {
			      	kleur(1415.966, 2843.282, "F  A  L  S  E");
			      }
			    } else if (aFmax > -0.47945 && count0_255 > 135) {
			    	kleur(1415.966, 2768.945, "F  A  L  S  E");
			    }
			} else if (aFmax > -0.1135 && count0_255 > 130) {
			  	kleur(1415.966, 2694.608, "T  R  U  E");
			  	happyTree5 = true;
			}
		}
	}

	void drawTree6() {
		if (count0_255 > 151 && count0_255 < 182) {
			kleur(1197.646, 2590.955, "eDC <= 0.1089");
			if (eDC <= 0.1089 && count0_255 > 156) {
			    kleur(1197.646, 2665.291, "aDC <= -0.4988");
			    if (aDC <= -0.4988 && count0_255 > 161) {
			    	kleur(1197.646, 2739.627, "eVmax <= -0.8159"); 
			      	if (eVmax <= -0.8159 && count0_255 > 166) {
			        	kleur(1197.646, 2813.964, "eVmax <= 1.1893"); 
			        	if (eVmax <= 1.1893 && count0_255 > 171) {
					        kleur(1197.646, 2888.631, "mFmin <= 0.3847"); 
					        if (mFmin <= 0.3847 && count0_255 > 176) {
					        	kleur(1197.646, 2962.968, "T  R  U  E");
					        	happyTree6 = true; 
						    } else if (mFmin <= 0.3847 && count0_255 > 176) {
						      	kleur(1415.966, 2962.968, "F  A  L  S  E");
						    }
					    } else if (eVmax <= 1.1893 && count0_255 > 171) {
					      	kleur(1415.966, 2888.631, "F  A  L  S  E");
					    }
			      	} else if (eVmax > -0.8159 && count0_255 > 166) {
			      		kleur(1415.966, 2813.964, "T  R  U  E");
			      		happyTree6 = true; 
			      	}
			    } else if (aDC > -0.4988 && count0_255 > 161) {
			    	kleur(1415.966, 2739.627, "T  R  U  E");
			    	happyTree6 = true; 
			    }
			} else if (eDC > 0.1089 && count0_255 > 156) {
			  	kleur(1415.966, 2665.291, "T  R  U  E");
			  	happyTree6 = true; 
			}
		}
	}

	void drawTree7() {
		if (count0_255 > 187 && count0_255 < 203) {
			kleur(1197.646, 2620.272, "gFmax <= -0.3826");
			if (gFmax <= -0.3826 && count0_255 > 192) {
			    kleur(1197.646, 2694.608, "gDC <= 0.3016"); 
			      if (gDC <= 0.3016 && count0_255 > 197) {
			        kleur(1197.646, 2769.276, "T  R  U  E"); 
			        happyTree7 = true; 
			      } else if (gDC > 0.3016 && count0_255 > 197) {
			      	kleur(1415.966, 2769.276, "F  A  L  S  E");
			      }
			} else if (gFmax > -0.3826 && count0_255 > 192) {
			  	kleur(1415.966, 2694.608, "T  R  U  E");
			  	happyTree7 = true;
			}
		}
	}

	void drawTree8() {
		if (count0_255 > 208 && count0_255 < 229) {
			kleur(1197.646, 2620.272, "aFmax <= -0.0630");
			if (aFmax <= -0.0630 && count0_255 > 213) {
			    kleur(1197.646, 2694.608, "eVmax <= -0.8159");
			    if (eVmax <= -0.8159 && count0_255 > 218) {
			    	kleur(1197.646, 2768.945, "aVmax <= 0.0912"); 
			      if (aVmax <= 0.0912 && count0_255 > 223) {
			        kleur(1197.646, 2843.282, "T  R  U  E"); 
			        happyTree8 = true;
			      } else if (aVmax <= 0.0912 && count0_255 > 223) {
			      	kleur(1415.966, 2843.282, "F  A  L  S  E");
			      }
			    } else if (eVmax <= -0.8159 && count0_255 > 218) {
			    	kleur(1415.966, 2768.945, "F  A  L  S  E");
			    }
			} else if (aFmax > -0.0630 && count0_255 > 213) {
			  	kleur(1415.966, 2694.608, "T  R  U  E");
			  	happyTree8 = true;
			}
		}
	}

	void drawTree9() {
		if (count0_255 > 234 && count0_255 < 255) {
			kleur(1197.646, 2620.272, "gDC <= 0.6194");
			if (gDC <= 0.6194 && count0_255 > 239) {
			    kleur(1197.646, 2694.608, "mFmin <= 0.8170");
			    if (mFmin <= 0.8170 && count0_255 > 244) {
			    	kleur(1197.646, 2768.945, "aFmax <= -0.3312"); 
			      if (aFmax <= -0.3312 && count0_255 > 249) {
			        kleur(1197.646, 2843.282, "T  R  U  E"); 
			        happyTree9 = true;
			      } else if (aFmax > -0.3312 && count0_255 > 249) {
			      	kleur(1415.966, 2843.282, "F  A  L  S  E");
			      }
			    } else if (mFmin > 0.8170 && count0_255 > 244) {
			    	kleur(1415.966, 2768.945, "T  R  U  E");
			    	happyTree9 = true;
			    }
			} else if (gDC > 0.6194 && count0_255 > 239) {
			  	kleur(1415.966, 2694.608, "F  A  L  S  E");
			}
		}
	}

	void kleur(float x, float y, String string) {
		big.fill(rC);
		big.noStroke();
		big.rect(x*scale+sW/2, y*scale+sW/2, rW-sW, rH-sW);

		big.fill(0);
		big.text(string, x*scale+rW/2, y*scale+rH/2+fS/3);
	}

	void circlesTrees() {
		big.fill(255, 0, 0);
		big.noStroke();
		if (happyTree1 == true) {
			big.ellipse(1123.85*scale, 2649.474*scale, 11.278*scale, 11.278*scale);
		}
		if (happyTree2 == true) {
			big.ellipse(1123.85*scale, 2689.45*scale, 11.278*scale, 11.278*scale);
		}
		if (happyTree3 == true) {
			big.ellipse(1123.85*scale, 2729.45*scale, 11.278*scale, 11.278*scale);
		}
		if (happyTree4 == true) {
			big.ellipse(1123.85*scale, 2769.849*scale, 11.278*scale, 11.278*scale);
		}
		if (happyTree5 == true) {
			big.ellipse(1123.85*scale, 2809.974*scale, 11.278*scale, 11.278*scale);
		}
		if (happyTree6 == true) {
			big.ellipse(1123.85*scale, 2850.099*scale, 11.278*scale, 11.278*scale);
		}
		if (happyTree7 == true) {
			big.ellipse(1123.85*scale, 2890.224*scale, 11.278*scale, 11.278*scale);
		}
		if (happyTree8 == true) {
			big.ellipse(1123.85*scale, 2930.349*scale, 11.278*scale, 11.278*scale);
		}
		if (happyTree9 == true) {
			big.ellipse(1123.85*scale, 2970.474*scale, 11.278*scale, 11.278*scale);
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