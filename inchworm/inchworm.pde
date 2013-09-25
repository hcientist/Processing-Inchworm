float inching = 0.0;
float di = 0.01;

void drawWorm(float inched) {
  // println(inched);
  strokeWeight(30);
  fill(0);
  stroke(255);
  beginShape();
  vertex(50, 150); // first point
  float inchedY = 150-100*inched;
  bezierVertex(100, 150, 100, inchedY, 150, inchedY);
  bezierVertex(200, inchedY, 200, 150, 250, 150);
  endShape();
}

void setup () {
	size(640, 360);
}

void draw() {
  background(0);
  drawWorm(inching);
  if (inching >= 1.0) {
    di = -0.01;
  }
  else if (inching <= 0.0) {
    di = 0.01;
  }
  println(di);
  println(inching);
  inching += di;
}