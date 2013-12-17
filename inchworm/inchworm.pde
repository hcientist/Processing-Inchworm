import java.util.Map;

// float di = 0.01;
int MIN_W = 0;
int MIN_H = 0;
int MAX_W = 1200;
int MAX_H = 800;

ArrayList<Inchworm> worms = new ArrayList<Inchworm>();

class Position {
  float x;
  float y;

  Position () {}

  Position (float xPos, float yPos) {
    x = xPos;
    y = yPos;
  }
  
  String toString(){
    return "("+this.x+", "+this.y+")";
  }

};

// float randomRange(min, max) {
//   return Math.random() * (MAX_INCHY_RATIO - MIN_INCHY_RATIO) + MIN_INCHY_RATIO
// }

class Inchworm {
  float wormWidth;          // width of worm
  float wormLength;         // length of worm
  float inchHeight;         // max diff in "height" of flat and "inched" worm
  float inched;             // 0.0 - 1.0: how "inched" is the worm (0=not inched, 1=fully inched)
  float bearing;            // current bearing
  float bearingNormal;
  float bearingNormalReverse;
  float bearingReverse;
  Position tail;
  color wormColor;          // color of this worm
  float speed;
  float originalSpeed;
  float di;                 // delta inched, how much should the hump move "up or down"

  float MAX_WORM_WIDTH = 100;
  float MIN_WORM_WIDTH = 10;
  float MAX_L_RATIO = 3.0;
  float MIN_L_RATIO = 1.0;
  float MAX_INCHY_RATIO = 3.0/4.0;
  float MIN_INCHY_RATIO = 1.0/4.0;

  Position tailControl;
  Position hump;
  Position humpTailControl;
  Position humpHeadControl;
  Position headControl;
  Position head;
  Position tailControlShifted;
  Position humpTailControlShifted;
  Position humpHeadControlShifted;
  Position headControlShifted;
  Position headShifted;
  Position tailShifted;
  Position humpShifted;

  Position frontFace;
  Position bottomFace;
  Position frontFaceTail;
  Position bottomFaceTail;

  void resetSpeed() {
    speed = originalSpeed;
  }

  void setup() {
    this.tail = new Position(random(MAX_W), random(MAX_H));

    bearing = random(TAU);
    wormColor = color(random(255), random(255), random(255));
    this.bearingNormal = bearing - HALF_PI;
    this.bearingReverse = bearing + PI;
    this.bearingNormalReverse = bearing + HALF_PI;
    this.wormColor = wormColor;

    wormWidth = random(MIN_WORM_WIDTH, MAX_WORM_WIDTH);
    wormLength = wormWidth * random(MIN_L_RATIO, MAX_L_RATIO);

    inched = random(1.0);
    inchHeight = wormLength * random(MIN_INCHY_RATIO, MAX_INCHY_RATIO);

    speed = random(0.005, 0.2); // consider making this a normal or other (non-random) distribution
    originalSpeed = speed;
    di = speed;
  }

  Inchworm(float x, float y, color wormColor, float b) {
    setup();
    this.tail = new Position(x, y);
    this.bearing = b;
    this.bearingNormal = bearing - HALF_PI;
    this.bearingNormalReverse = bearing + HALF_PI;
    this.bearingReverse = bearing + PI;
    this.wormColor = wormColor;
  }

  Inchworm() {
    setup();
  }

  // String toString() {
  //   return "tail: "+tail + "\n" +
  //     "tailControl: "+tailControl + "\n" +
  //     "humpTailControl: "+humpTailControl + "\n" +
  //     "hump: "+hump + "\n" +
  //     "humpHeadControl: "+humpHeadControl + "\n" +
  //     "headControl: "+headControl + "\n" +
  //     "head: "+head + "\n" +
  //     "\n" +
  //     "tailShifted: "+tailShifted + "\n" +
  //     "tailControlShifted: "+tailControlShifted + "\n" +
  //     "humpTailControlShifted: "+humpTailControlShifted + "\n" +
  //     "humpShifted: "+humpShifted + "\n" +
  //     "humpHeadControlShifted: "+humpHeadControlShifted + "\n" +
  //     "headControlShifted: "+headControlShifted + "\n" +
  //     "headShifted: "+headShifted + "\n" +
  //     "\n";

  // }

  float inchiness() {
    return inched*inchHeight;
  }

  Position translatePosition(Position p0, float bearing, float w) { //pass in width?
    return new Position(p0.x+w*cos(bearing), p0.y+w*sin(bearing));
  }

  void aestheticWormAdjustment(float humpBloat) {
    // println(bearing);
    // println(bearingNormal);
    // println(humpTailControlShifted);
    humpTailControlShifted = translatePosition(humpTailControlShifted, bearingNormal, humpBloat);
    humpTailControlShifted = translatePosition(humpTailControlShifted, bearing, humpBloat);
    // println(humpTailControlShifted);
    // println();
    humpShifted = translatePosition(humpShifted, bearingNormal, humpBloat);
    humpHeadControlShifted = translatePosition(humpHeadControlShifted, bearingNormal, humpBloat);
    humpHeadControlShifted = translatePosition(humpHeadControlShifted, bearingReverse, humpBloat);
    // humpTailControlShifted.y = humpTailControlShifted.y + humpBloat*sin(bearingNormal);
    // humpTailControlShifted.x = humpTailControlShifted.x + humpBloat*cos(bearingNormal);
    // humpShifted.x = humpShifted.x + humpBloat*cos(bearingNormal);
    // humpShifted.y = humpShifted.y + humpBloat*sin(bearingNormal);
    // humpHeadControlShifted.x = humpHeadControlShifted.x + humpBloat*cos(bearingNormal);
    // humpHeadControlShifted.y = humpHeadControlShifted.y + humpBloat*sin(bearingNormal);
  }

  void step() {

    // strokeWeight(wormWidth);
    float theta = atan(inchiness()/(wormLength/2.0));
    float hypot = sqrt(sq(inchiness())+sq(wormLength/2.0));
    
    tailControl = new Position(tail.x + wormLength/4.0 * cos(bearing), tail.y + wormLength/4.0 * sin(bearing));
    hump = new Position(hypot * cos(bearing-theta) + tail.x, hypot * sin(bearing-theta) + tail.y);
    humpTailControl = new Position(hump.x - wormLength/4.0 * cos(bearing), hump.y - wormLength/4.0 * sin(bearing));
    humpHeadControl = new Position(hump.x + wormLength/4.0 * cos(bearing), hump.y + wormLength/4.0 * sin(bearing));
    headControl = new Position(tail.x + 3.0*wormLength/4.0 * cos(bearing), tail.y + 3.0*wormLength/4.0 * sin(bearing));
    head = new Position(tail.x + wormLength * cos(bearing), tail.y + wormLength * sin(bearing));

    tailControlShifted = intersect(translatePosition(tail, bearingNormal, wormWidth), 
                                            translatePosition(tailControl, bearingNormal, wormWidth),
                                            translatePosition(tailControl, bearingReverse, wormWidth),
                                            translatePosition(humpTailControl, bearingReverse, wormWidth)
                                            );

    humpTailControlShifted = intersect(translatePosition(tailControl, bearingReverse, wormWidth),
                                                translatePosition(humpTailControl, bearingReverse, wormWidth),
                                                translatePosition(humpTailControl, bearingNormal, wormWidth),
                                                translatePosition(hump, bearingNormal, wormWidth)
                                                );

    humpHeadControlShifted = intersect(translatePosition(hump, bearingNormal, wormWidth), 
                                                translatePosition(humpHeadControl, bearingNormal, wormWidth),
                                                translatePosition(humpHeadControl, bearing, wormWidth),
                                                translatePosition(headControl, bearing, wormWidth)
                                                );

    headControlShifted = intersect(translatePosition(humpHeadControl, bearing, wormWidth), 
                                            translatePosition(headControl, bearing, wormWidth),
                                            translatePosition(headControl, bearingNormal, wormWidth),
                                            translatePosition(head, bearingNormal, wormWidth)
                                            );

    headShifted = translatePosition(translatePosition(head, bearingNormal, wormWidth), bearing, wormWidth);
    tailShifted = translatePosition(translatePosition(tail, bearingNormal, wormWidth), bearingReverse, wormWidth);
    humpShifted = translatePosition(hump, bearingNormal, wormWidth);

    frontFace = translatePosition(headShifted, bearing, wormWidth/2.0);
    bottomFace = translatePosition(head, bearing, wormWidth * 2.0);
    // frontFace = translatePosition(headShifted, bearing+HALF_PI/2.0, wormWidth/2.0);
    // bottomFace = translatePosition(head, bearing, wormWidth/2.0);
    // Position headShifted = head;
    // Position tailShifted = tail;
    // Position humpShifted = hump;

    frontFaceTail = translatePosition(tailShifted, bearingReverse, wormWidth/2.0);
    bottomFaceTail = translatePosition(tail, bearingReverse, wormWidth * 2.0);

    
    aestheticWormAdjustment(this.wormWidth/3.0*inched);

    strokeWeight(5);
    noFill();
    stroke(wormColor);
    beginShape();
    vertex(tail.x, tail.y);
    bezierVertex(tailControl.x, tailControl.y, humpTailControl.x, humpTailControl.y, hump.x, hump.y);
    bezierVertex(humpHeadControl.x, humpHeadControl.y, headControl.x, headControl.y, head.x, head.y);
    // endShape(); // use endShape(CLOSE) in the future

    // beginShape();
    // vertex(tailShifted.x, tailShifted.y);
    // bezierVertex(tailControlShifted.x, tailControlShifted.y, humpTailControlShifted.x, humpTailControlShifted.y, humpShifted.x, humpShifted.y);
    // bezierVertex(humpHeadControlShifted.x, humpHeadControlShifted.y, headControlShifted.x, headControlShifted.y, headShifted.x, headShifted.y);

    bezierVertex(bottomFace.x, bottomFace.y, frontFace.x, frontFace.y, headShifted.x, headShifted.y);
    bezierVertex(headControlShifted.x, headControlShifted.y, humpHeadControlShifted.x, humpHeadControlShifted.y, humpShifted.x, humpShifted.y);
    bezierVertex(humpTailControlShifted.x, humpTailControlShifted.y, tailControlShifted.x, tailControlShifted.y, tailShifted.x, tailShifted.y);

    bezierVertex(frontFaceTail.x, frontFaceTail.y, bottomFaceTail.x, bottomFaceTail.y, tail.x, tail.y);

    endShape(CLOSE);

    stroke(0, 0, 255);
    // point(headControlShifted.x, headControlShifted.y);
    // point(humpHeadControlShifted.x, humpHeadControlShifted.y);
    // point(humpTailControlShifted.x, humpTailControlShifted.y);
    // point(tailControlShifted.x, tailControlShifted.y);

    point(frontFace.x, frontFace.y);
    point(bottomFace.x, bottomFace.y);

    stroke(255,0,0);
    point(head.x, head.y);
    point(headShifted.x, headShifted.y);

    // stroke(255,0,0);
    // point(tailShifted.x, tailShifted.y);
    // point(humpShifted.x, humpShifted.y);
    // point(headShifted.x, headShifted.y);

    // strokeWeight(2);
    // line(translatePosition(tail, bearingNormal).x, translatePosition(tail, bearingNormal).y, translatePosition(tailControl, bearingNormal).x, translatePosition(tailControl, bearingNormal).y);
    // line(translatePosition(tailControl, -bearing).x, 
    //   translatePosition(tailControl, -bearing).y,
    //   translatePosition(humpTailControl, -bearing).x,
    //   translatePosition(humpTailControl, -bearing).y);

    // make the worm hump oscillate
    if (inched >= 1.0) {
      di = -speed;

    }
    else if (inched <= 0.0) {
      di = speed;
    }

    wormLength = wormLength - di*inchHeight;

    inched += di;
    
    if (di >=0 ){ // when di > 0, we're moving the tail.
      tail.x += di*inchHeight*cos(bearing);
      tail.y += di*inchHeight*sin(bearing);

      float modBearing = (bearing % TAU);

      if (tail.x + wormWidth < MIN_W && !(modBearing > -HALF_PI && modBearing < HALF_PI)) { // off screen to left
        tail.x = MAX_W + (wormLength + wormWidth);
      } else if (tail.x - wormWidth > MAX_W && modBearing > -HALF_PI && modBearing < HALF_PI) { // off screen to right
        tail.x = 0 - (wormLength + wormWidth);
      }

      if (tail.y + wormWidth < MIN_H && !(modBearing > 0 && modBearing < PI)) { // off screen to top
        tail.y = MAX_H + (wormLength + wormWidth);
      } else if (tail.y - wormWidth > MAX_H && modBearing > 0 && modBearing < PI) { // off screen to bottom
        tail.y = 0 - (wormLength + wormWidth);
      }
    }
  }

  // thanks to: http://processingjs.org/learning/custom/intersect/ for the intersection code!

  Position intersect(Position p1, Position p2, Position p3, Position p4){
    float x1 = p1.x;
    float y1 = p1.y;
    float x2 = p2.x;
    float y2 = p2.y;
    float x3 = p3.x;
    float y3 = p3.y;
    float x4 = p4.x;
    float y4 = p4.y;

    float a1, a2, b1, b2, c1, c2;
    float r1, r2 , r3, r4;
    float denom, offset, num;
    float x;
    float y;

    // Compute a1, b1, c1, where line joining points 1 and 2
    // is "a1 x + b1 y + c1 = 0".
    a1 = y2 - y1;
    b1 = x1 - x2;
    c1 = (x2 * y1) - (x1 * y2);

    // Compute r3 and r4.
    r3 = ((a1 * x3) + (b1 * y3) + c1);
    r4 = ((a1 * x4) + (b1 * y4) + c1);

    // Check signs of r3 and r4. If both point 3 and point 4 lie on
    // same side of line 1, the line segments do not intersect.
    // if ((r3 != 0) && (r4 != 0) && same_sign(r3, r4)){
    //   return DONT_INTERSECT;
    // }

    // Compute a2, b2, c2
    a2 = y4 - y3;
    b2 = x3 - x4;
    c2 = (x4 * y3) - (x3 * y4);

    // Compute r1 and r2
    r1 = (a2 * x1) + (b2 * y1) + c2;
    r2 = (a2 * x2) + (b2 * y2) + c2;

    // Check signs of r1 and r2. If both point 1 and point 2 lie
    // on same side of second line segment, the line segments do
    // not intersect.
    // if ((r1 != 0) && (r2 != 0) && (same_sign(r1, r2))){
    //   return DONT_INTERSECT;
    // }

    //Line segments intersect: compute intersection point.
    denom = (a1 * b2) - (a2 * b1);

    // if (denom == 0) {
    //   return COLLINEAR;
    // }

    if (denom < 0){ 
      offset = -denom / 2; 
    } 
    else {
      offset = denom / 2 ;
    }

    // The denom/2 is to get rounding instead of truncating. It
    // is added or subtracted to the numerator, depending upon the
    // sign of the numerator.
    num = (b1 * c2) - (b2 * c1);
    if (num < 0){
      x = (num - offset) / denom;
    } 
    else {
      x = (num + offset) / denom;
    }

    num = (a2 * c1) - (a1 * c2);
    if (num < 0){
      y = ( num - offset) / denom;
    } 
    else {
      y = (num + offset) / denom;
    }

    // lines_intersect
    return new Position(x,y);
  }


  boolean same_sign(float a, float b){

    return (( a * b) >= 0);
  }

};


void setup () {
  size(MAX_W, MAX_H);

  // int wormCount = (int)random(5, 100);
  int wormCount = 1;
  println("wormCount: " + wormCount);
  for (int i = 0; i < wormCount; i++) {
    worms.add(new Inchworm());
  }
}

boolean paused = false;



void keyPressed() {
  if (key == ' ') {
    paused = !paused;
  } else if (key == '-') {
    for (int i=0; i<worms.size(); i++) {
      worms.get(i).speed *= 0.9;
    }
  } else if (key == '=') {
    for (int i=0; i<worms.size(); i++) {
      worms.get(i).speed *= 1.1;
    }
  } else if (key == '0') {
    for (int i=0; i<worms.size(); i++) {
      worms.get(i).resetSpeed();
    }
  }
}

void draw() {
  if (!paused) {
    background(255);
    for (int i=0; i<worms.size(); i++) {
      worms.get(i).step();
    }
  }
}