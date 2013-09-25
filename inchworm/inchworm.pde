float inching = 0.0;
float di = 0.01;

void drawWorm(float inched) {
  // println(inched);
  strokeWeight(30);
  fill(0);
  stroke(255);
  beginShape();
  float inchedY = 150-100*inched;
  float dInchedX = 50*inched;
  vertex(50+dInchedX, 150); // first point
  bezierVertex(100+dInchedX/2.0, 150, 100+dInchedX/2.0, inchedY, 150, inchedY);
  bezierVertex(200-dInchedX/2.0, inchedY, 200-dInchedX/2.0, 150, 250-dInchedX, 150);
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
  // println(di);
  // println(inching);
  inching += di;
}