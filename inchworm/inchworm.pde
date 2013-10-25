import java.util.Map;

float di = 0.01;
int MIN_W = 0;
int MIN_H = 0;
int MAX_W = 640;
int MAX_H = 360;

ArrayList<Inchworm> worms = new ArrayList<Inchworm>();

class Position {
  float x;
  float y;

  Position () {}

  Position (float xPos, float yPos) {
    x = xPos;
    y = yPos;
  }
  
};

class Inchworm {
  float w;          // width of worm
  float l;          // length of worm
  float inchHeight; // max diff in "height" of flat and "inched" worm
  float inched;     // 0.0 - 1.0: how "inched" is the worm (0=not inched, 1=fully inched)
  float bearing;    // current bearing
  float x;          // current x position of worm tail
  float y;          // current y position of worm tail
  float x0;         // original x position of worm
  float y0;         // original y position of worm
  color c;          // color of this worm
  float humpBearing = 0;
  float alt = sqrt(sq(l/2.0)+sq(inchiness()));

  Inchworm(float x, float y, color c, float b) {
    w = 90;
    l = 200;
    bearing = b;
    inched = 0;
    inchHeight = 100;
    humpBearing = degrees(atan(inchHeight/(l/2.0)));
    this.x = x;
    this.y = y;
    y = 200;
    x0 = x;
    y0 = y;
    this.c = c;
  }

  Inchworm() {
    w = 90;
    l = 200;
    bearing = 3.14/4.0;
    inched = 0;
    inchHeight = 100;
    humpBearing = degrees(atan(inchHeight/(l/2.0)));
    x = 50;
    y = 200;
    x0 = x;
    y0 = y;
    c = color(255);
  }

  float inchiness() {
    return inched*inchHeight;
  }

  void step() {

    strokeWeight(w);
    fill(0);
    stroke(c);
    float theta = atan(inchiness()/(l/2.0));
    float hypot = sqrt(sq(inchiness())+sq(l/2.0));
    float xh = hypot * cos(bearing-theta) + x; // note to self, think about degrees/radians and processing's origin
    float yh = hypot * sin(bearing-theta) + y; // note to self, think about degrees/radians and processing's origin
    float xhtc = xh - l/4.0 * cos(bearing);
    float yhtc = yh - l/4.0 * sin(bearing);
    float xhhc = xh + l/4.0 * cos(bearing);
    float yhhc = yh + l/4.0 * sin(bearing);
    float xtc = x + l/4.0 * cos(bearing);
    float ytc = y + l/4.0 * sin(bearing);
    float xhc = x + 3.0*l/4.0 * cos(bearing);
    float yhc = y + 3.0*l/4.0 * sin(bearing);
    float xhead = x + l * cos(bearing);
    float yhead = y + l * sin(bearing);

    beginShape();
    vertex(x, y);
    bezierVertex(xtc, ytc, xhtc, yhtc, xh, yh);
    bezierVertex(xhhc, yhhc, xhc, yhc, xhead, yhead);
    endShape();

    // make the worm hump oscillate
    if (inched >= 1.0) {
      di = -0.1;
    }
    else if (inched <= 0.0) {
      di = 0.1;
    }

    //if the worm goes off screen, make it start coming back

    if (x - w > MAX_W) {
      x = 0-(l+w);
    } else if (x+w < MIN_W) {
      x = MAX_W+l+2*w;
    } else if (y+w < MIN_H) {
      y = MAX_H+l+2*w;
    } else if (y-w > MAX_H) {
      y = 0-(l+w);
    } 

    l = l - di*inchHeight;

    inched += di;
    if (di >=0 ){
      x += di*inchHeight*cos(bearing); //figure out what's special about 50 here
      y += di*inchHeight*sin(bearing); //figure out what's special about 50 here
    }
  }

  void draw() {
    
    strokeWeight(w);
    fill(0);
    stroke(c);
  }
};

void setup () {
	size(MAX_W, MAX_H);
  worms.add(new Inchworm());
  worms.add(new Inchworm(200, 50, color(150), -0.25));
  worms.add(new Inchworm(175, 100, color(50), 3.14+0.25));
}

void draw() {
  background(0);
  for (int i=0; i<worms.size(); i++) {
    worms.get(i).step();
  }
}

//  eventually start back on other side, sort of like:
 // if (xpos > width) {
 //     xpos = 0;
 //   }
 //   if (ypos > height) {
 //     ypos = 0;
 //   }
 //   if (xpos < 0) {
 //     xpos = width;
 //   }
 //   if (ypos < 0) {
 //     ypos = height;
 //   }