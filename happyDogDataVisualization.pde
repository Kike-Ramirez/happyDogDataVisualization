XML xml;
int pos;
PImage bg;
PGraphics big;
FloatList axList;
float sum;

void setup() {
  size(450,800,P2D);
  big = createGraphics(2160,3840,P2D);
  xml = loadXML("raw_final.xml");
  bg = loadImage("perrito.png");

  axList = new FloatList();
  fillList();
}

void draw() {
  pos++;
  //if(pos%10 == 0) {  
      PImage img = big.get(0, 0, big.width, big.height);  
      img.resize(width,height);
      image(img,0,0);
  //}  
  
  testDraw();

  big.beginDraw();
    big.background(bg);
    
    XML[] children = xml.getChildren("Measure");
    float ax = children[pos].getFloat("ax");

  big.endDraw();
  //big.save("save-####.png");

}

void fillList() {
  XML[] children = xml.getChildren("Measure");
  for (int i = 0; i < children.length; i++) {
    axList.append(children[i].getFloat("ax"));

  }
}


void testDraw() {   
  XML[] children = xml.getChildren("Measure");

  int number = children[pos].getInt("Number");
  float ax = children[pos].getFloat("ax");
  float ay = children[pos].getFloat("ay");
  float az = children[pos].getFloat("az");
  float gx = children[pos].getFloat("gx");
  float gy = children[pos].getFloat("gy");
  float gz = children[pos].getFloat("gz");
  float mx = children[pos].getFloat("mx");
  float my = children[pos].getFloat("my");
  float mz = children[pos].getFloat("mz");
  float ex = children[pos].getFloat("ex");
  float ey = children[pos].getFloat("ey");
  float ez = children[pos].getFloat("ez");
  int happy = children[pos].getInt("happy");
  
  fill(0);
  
  text("framerate: " + frameRate,45, 55);
  text("number: " + number,45, 65);
  text("ax: " + String.format("%.2f", ax),45, 75);
  text("ay: " + String.format("%.2f", ay),45, 85);
  text("az: " + String.format("%.2f", az),45, 95);
  text("gx: " + String.format("%.2f", gx),45, 105);
  text("gy: " + String.format("%.2f", gy),45, 115);
  text("gz: " + String.format("%.2f", gz),45, 125);
  text("mx: " + String.format("%.2f", mx),45, 135);
  text("my: " + String.format("%.2f", my),45, 145);
  text("mz: " + String.format("%.2f", mz),45, 155);
  text("ex: " + String.format("%.2f", ex),45, 165);
  text("ey: " + String.format("%.2f", ey),45, 175);
  text("ez: " + String.format("%.2f", ez),45, 185);
  text("happy: " + happy,45, 195);
}

 