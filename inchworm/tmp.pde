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
  beginShape();
  vertex(50, 300);
  bezierVertex(100, 300, 100, 300, 100, 250);
  bezierVertex(100, 200, 100, 200, 150, 200);
  endShape();
  beginShape();
  vertex(50+30, 300+30);
  bezierVertex(100+30, 300+30, 100+30, 300+30, 100+30, 250+30);
  bezierVertex(100+30, 200+30, 100+30, 200+30, 150+30, 200+30);
  endShape();
}