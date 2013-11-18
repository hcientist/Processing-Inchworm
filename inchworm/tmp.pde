void setup () {
  size(MAX_W, MAX_H);

  // int wormCount = (int)random(5, 100);
  // println("wormCount: " + wormCount);
  // for (int i = 0; i < wormCount; i++) {
  //   worms.add(new Inchworm());
  // }
}

void parallelWorms(float offset, float tailX, float tailY, float tailCPX, float tailCPY, float humpTCPX, float humpTCPY, float humpX, float humpY, float humpHCPX, float humpHCPY, float headCPX, float headCPY, float headX, float headY) {
  bezierWorm(tailX, tailY, 
    tailCPX - offset / 2.0, tailCPY, 
    humpTCPX, humpTCPY - offset / 2.0, 
    humpX, humpY, 
    humpHCPX, humpHCPY, 
    headCPX+offset, headCPY, 
    headX+offset, headY);
  bezierWorm(tailX, tailY+offset, 
    tailCPX, tailCPY+offset, 
    humpTCPX+offset, humpTCPY, 
    humpX+offset, humpY, 
    humpHCPX+offset, humpHCPY+offset, 
    headCPX+offset, headCPY+offset, 
    headX+offset, headY+offset);

}

void flatWorms(float offset, float tailX, float tailY, float tailCPX, float tailCPY, float humpTCPX, float humpTCPY, float humpX, float humpY) {
  flatWorm(tailX, tailY, 
    tailCPX, tailCPY, 
    humpTCPX, humpTCPY, 
    humpX, humpY);

  flatWorm(tailX, tailY+offset, 
    tailCPX, tailCPY+offset, 
    humpTCPX, humpTCPY+offset, 
    humpX, humpY+offset);
}

void flatWorm(float tailX, float tailY, float tailCPX, float tailCPY, float humpTCPX, float humpTCPY, float humpX, float humpY) {
  noFill();
  strokeWeight(2);
  stroke(0);

  beginShape();
  vertex(tailX, tailY);
  bezierVertex(tailCPX, tailCPY, humpTCPX, humpTCPY, humpX, humpY);
  endShape();

  strokeWeight(8);
  stroke(color(255,0,0));

  point(tailX, tailY);
  point(humpX, humpY);

  stroke(color(0,255,0));

  point(tailCPX, tailCPY);
  point(humpTCPX, humpTCPY);
}

void bezierWorm(float tailX, float tailY, float tailCPX, float tailCPY, float humpTCPX, float humpTCPY, float humpX, float humpY, float humpHCPX, float humpHCPY, float headCPX, float headCPY, float headX, float headY) {
  noFill();
  strokeWeight(2);
  stroke(0);

  beginShape();
  vertex(tailX, tailY);
  bezierVertex(tailCPX, tailCPY, humpTCPX, humpTCPY, humpX, humpY);
  // bezierVertex(humpHCPX, humpHCPY, headCPX, headCPY, headX, headY);
  endShape();

  strokeWeight(8);
  stroke(color(255,0,0));

  point(tailX, tailY);
  point(humpX, humpY);
  // point(headX, headY);

  stroke(color(0,255,0));

  point(tailCPX, tailCPY);
  point(humpTCPX, humpTCPY);
  // point(humpHCPX, humpHCPY);
  // point(headCPX, headCPY);

}

void draw() {
  background(255);
  // for (int i=0; i<worms.size(); i++) {
  //   worms.get(i).step();
  // }

  // strokeWeight(2);
  // stroke(0);

  // parallelWorms(30, 50, 300,100, 300, 100, 300, 100, 250,100, 200, 100, 200, 150, 200);


  flatWorms(30, 50, 300,100, 300, 100, 300, 100, 300);

  // beginShape();
  // vertex(50, 300);
  // bezierVertex(100, 300, 100, 300, 100, 250);
  // bezierVertex(100, 200, 100+30, 200, 150+30, 200);
  // endShape();
  // beginShape();
  // vertex(50, 300+30);
  // bezierVertex(100, 300+30, 100+30, 300+30, 100+30, 250);
  // bezierVertex(100+30, 200+30, 100+30, 200+30, 150+30, 200+30);
  // endShape();

  // // noSmooth();
  // strokeWeight(8);
  // stroke(color(255,0,0));

  // point(50, 300);
  // point(100, 250);
  // point(150+30, 200);
  // point(50, 300+30);
  // point(100+30, 250);
  // point(150+30, 200+30);


  // stroke(color(0,255,0));

  // point(100, 300);
  // point(100, 300);
  // point(100, 200);
  // point(100, 200);
  // point(100+30, 300+30);
  // point(100+30, 300+30);
  // point(100+30, 200+30);
  // point(100+30, 200+30);
}