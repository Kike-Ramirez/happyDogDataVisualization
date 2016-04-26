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
	void draw() {
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

	void resizeBg() {
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