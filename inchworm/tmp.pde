void setup () {
  size(MAX_W, MAX_H);

  // int wormCount = (int)random(5, 100);
  // println("wormCount: " + wormCount);
  // for (int i = 0; i < wormCount; i++) {
  //   worms.add(new Inchworm());
  // }
}

void draw() {
  background(255);
  // for (int i=0; i<worms.size(); i++) {
  //   worms.get(i).step();
  // }

  strokeWeight(2);
  stroke(0);

  beginShape();
  vertex(50, 300);
  bezierVertex(100, 300, 100, 300, 100, 250);
  bezierVertex(100, 200, 100+30, 200, 150+30, 200);
  endShape();
  beginShape();
  vertex(50, 300+30);
  bezierVertex(100, 300+30, 100+30, 300+30, 100+30, 250);
  bezierVertex(100+30, 200+30, 100+30, 200+30, 150+30, 200+30);
  endShape();

  // noSmooth();
  strokeWeight(8);
  stroke(color(255,0,0));

  point(50, 300);
  point(100, 250);
  point(150+30, 200);
  point(50, 300+30);
  point(100+30, 250);
  point(150+30, 200+30);


  stroke(color(0,255,0));

  point(100, 300);
  point(100, 300);
  point(100, 200);
  point(100, 200);
  point(100+30, 300+30);
  point(100+30, 300+30);
  point(100+30, 200+30);
  point(100+30, 200+30);
}