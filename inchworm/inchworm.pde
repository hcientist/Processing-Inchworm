float inching = 0.0;
float di = 0.01;
float initX = 50.0;

ArrayList<Inchworm> worms = new ArrayList<Inchworm>();

void drawWorm(float inched, float initialX) {
  // println(inched);
  float inchedY = 150-100*inched;
  float dInchedX = 50*inched;
  strokeWeight(30);
  fill(0);
  stroke(255);
  translate(initialX, 0);
  beginShape();
  vertex(50+dInchedX, 150); // first point
  bezierVertex(100+dInchedX/2.0, 150, 100+dInchedX/2.0, inchedY, 150, inchedY);
  bezierVertex(200-dInchedX/2.0, inchedY, 200-dInchedX/2.0, 150, 250-dInchedX, 150);
  endShape();
}

class Inchworm {
  float w;          // width of worm
  float l;          // length of worm
  float inchHeight; // diff in "height" of flat and "inched" worm
  float inched;     // 0.0 - 1.0: how "inched" is the worm (0=not inched, 1=fully inched)
  float bearing;    // current bearing
  float x;          // current x position of worm
  float y;          // current y position of worm
  color c;          // color of this worm

  Inchworm() {
    w = 30;
    l = 200;
    bearing = 0;
    inched = 0;
    inchHeight = 100;
    x = 50;
    y = 150;
    c = color(255);
  }

  void draw() {
    float inchedY = y-inchHeight*inched;  //distance from baseline of worm "up" 
                                          // to current hump peak
    float dInchedX = inchHeight/2*inched;
    strokeWeight(w);
    fill(0);
    stroke(c);
    beginShape();
    vertex(x+dInchedX, y); // first point
    bezierVertex(x+l/4.0+dInchedX/2.0, y, x+l/4.0+dInchedX/2.0, inchedY, x+l/2.0, inchedY);
    bezierVertex(x+3*l/4.0-dInchedX/2.0, inchedY, x+3*l/4.0-dInchedX/2.0, y, x+l-dInchedX, y);
    endShape();

    if (inched >= 1.0) {
      di = -0.01;
    }
    else if (inched <= 0.0) {
      di = 0.01;
    }
    inched += di;
    x += 50*abs(di); //figure out what's special about 50 here
  }
};

void setup () {
	size(640, 360);
  worms.add(new Inchworm());
}

void draw() {
  background(0);
  for (int i=0; i<worms.size(); i++) {
    worms.get(i).draw();
  }
}