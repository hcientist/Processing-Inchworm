import java.util.Map;

float di = 0.01;

int MAX_W = 640;
int MAX_H = 360;

ArrayList<Inchworm> worms = new ArrayList<Inchworm>();

class Position {
  float x;
  float y;

  Position () {
    // x = 0;
    // y = 0;
  }

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


  HashMap<String, Position> splinePoints = new HashMap<String,Position>();

  Inchworm(float x, float y, color c, float b) {
    Inchworm i = new Inchworm();
    i.x = x;
    i.y = y;
    i.c = c;
    i.bearing = b;
    // this = i;
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
    // splinePoints.put("tail", new Position(x,y));
    // splinePoints.put("tailControl", new Position(x+l/4.0, y));
    // splinePoints.put("humpTailControl", new Position(x+l/4.0, y));
    // splinePoints.put("hump", new Position(x+l/2.0, y));
    // splinePoints.put("humpHeadControl", new Position(x+3*l/4.0, y));
    // splinePoints.put("headControl", new Position(x+3*l/4.0, y));
    // splinePoints.put("head", new Position(x+l, y));

  }

  float inchiness() {
    return inched*inchHeight;
  }

  // Position tailPos() {
  //   return new Position(x,y);
  // }

  // Position tailCtrlPos() {
  //   Position t = tailPos();
  //   float tcPosX = t.x+l/4.0*cos(radians(bearing));
  //   float tcPosY = t.y+l/4.0*sin(radians(bearing));
  //   return new Position(tcPosX, tcPosY);
  // }

  //this depends on alt getting updated at each step before this is run.
  // Position humpPos() {
  //   Position t = tailPos();
  //   println(t.x + " " + t.y);

  //   println(alt);

  //   float thetaT = bearing-humpBearing;
  //   println(thetaT);
  //   float thetaTRadians = radians(thetaT);
  //   println(thetaTRadians);

  //   println(cos(thetaTRadians));

  //   println(sin(thetaTRadians));

  //   float humpX = t.x+alt*cos(thetaTRadians);
  //   float humpY = t.y+alt*sin(thetaTRadians);
  //   return new Position(humpX, humpY);    
  // }

  // Position humpTailCtrlPos() {
  //   Position p = humpPos();
  //   float htcX = p.x-l/4.0*cos(radians(bearing));
  //   float htcY = p.y-l/4.0*sin(radians(bearing));
  //   return new Position(htcX, htcY);
  // }

  // Position humpHeadCtrlPos() {
  //   Position p = humpPos();
  //   float hhcX = p.x+l/4.0*cos(radians(bearing));
  //   float hhcY = p.y+l/4.0*sin(radians(bearing));
  //   return new Position(hhcX, hhcY);
  // }

  // Position headPos() {
  //   Position t = tailPos();
  //   float hpX = t.x + l*cos(radians(bearing));
  //   float hpY = t.y + l*sin(radians(bearing));
  //   return new Position(hpX, hpY);
  // }

  // Position headCtrlPos() {
  //   Position head = headPos();
  //   float hcX = head.x - l/4.0*cos(radians(bearing));
  //   float hcY = head.y - l/4.0*sin(radians(bearing));
  //   return new Position(hcX, hcY);
  // }

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


    // humpBearing = degrees(atan(inchHeight/(l/2.0)));
    // float newNormalInchDisplacement = inchHeight * inched;  //distance from baseline of worm "up" 
    //                                                         // to current hump peak

    // float normalInchDisplacement = y - (inchHeight * inched); //distance from baseline of worm "up" 
    //                                                           // to current hump peak

    // float longitudinalInchDisplacement = inchHeight/2.0*inched;

    // alt = sqrt(sq(l/2.0)+sq(inchiness()));
    // println(alt);
    
    // splinePoints.put("tail", new Position(x+longitudinalInchDisplacement,y));
    // splinePoints.put("tailControl", new Position(x+(l/4.0+longitudinalInchDisplacement/2.0), y));
    // splinePoints.put("humpTailControl", new Position(x+(l/4.0+longitudinalInchDisplacement/2.0), y-newNormalInchDisplacement));
    // splinePoints.put("hump", new Position(x+(l/2.0), y-newNormalInchDisplacement));
    // splinePoints.put("humpHeadControl", new Position(x+(3*l/4.0-longitudinalInchDisplacement/2.0), y-newNormalInchDisplacement));
    // splinePoints.put("headControl", new Position(x+(3*l/4.0-longitudinalInchDisplacement/2.0), y));
    // splinePoints.put("head", new Position(x+(l-longitudinalInchDisplacement), y));

    // splinePoints.put("tail", tailPos());
    // splinePoints.put("tailControl", tailCtrlPos());
    // splinePoints.put("humpTailControl", humpTailCtrlPos());
    // splinePoints.put("hump", humpPos());
    // splinePoints.put("humpHeadControl", humpHeadCtrlPos());
    // splinePoints.put("headControl", headCtrlPos());
    // splinePoints.put("head", headPos());

    // draw();

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

    // println(splinePoints.get("tail").x + " " + splinePoints.get("tail").y);
    // println(splinePoints.get("hump").x + " " + splinePoints.get("hump").y);

    // beginShape();
    // vertex()
    // vertex(splinePoints.get("tail").x, splinePoints.get("tail").y); // first point
    // bezierVertex(splinePoints.get("tailControl").x, splinePoints.get("tailControl").y, splinePoints.get("humpTailControl").x, splinePoints.get("humpTailControl").y, splinePoints.get("hump").x, splinePoints.get("hump").y);
    // bezierVertex(splinePoints.get("humpHeadControl").x, splinePoints.get("humpHeadControl").y, splinePoints.get("headControl").x, splinePoints.get("headControl").y, splinePoints.get("head").x, splinePoints.get("head").y);
    // endShape();
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