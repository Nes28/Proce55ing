ArrayList<Walker>walkers = new ArrayList<Walker>();
void setup() {
  size(600, 600, P3D);
  colorMode(HSB, 360, 100, 100);
  smooth();

  while (walkers.size() < 200) {
    Walker w = new Walker();
    walkers.add(w);
  }
  blendMode(ADD);
}

void draw() {
  background(0);
  
  for (Walker w : walkers) {
    w.update();
    w.draw(walkers);
  }
}

class Walker {
  PVector pos, vel;
  float size = 3;
  int connectCount = 0;
  color c = color(random(360), 100, 100);
  Walker() {
    pos = new PVector(random(width), random(height));
    float speed = 2;
    vel = new PVector(random(-speed, speed), random(-speed, speed));
  }

  void update() {
    reflectWall();
    pos.add(vel);
  }

  void draw(ArrayList<Walker>walkers) {
    float dist;
    for (int i=0; i<walkers.size(); i++) {
      Walker w = walkers.get(i);
      dist = dist(pos.x, pos.y, w.pos.x, w.pos.y);
      if (dist > 0 && dist < 60) {
        connectCount++;
        stroke(c, 30);
        line(pos.x, pos.y, w.pos.x, w.pos.y);
      }
    }
    
    size = (connectCount+1)*5;
    noStroke();
    fill(c,80);
    ellipse(pos.x, pos.y, size, size);
    connectCount = 0;
  }

  void reflectWall() {
    if (pos.x > width || pos.x < 0) {
      vel.x *= -1;
    }
    if (pos.y > height || pos.y < 0) {
      vel.y *= -1;
    }
  }
}