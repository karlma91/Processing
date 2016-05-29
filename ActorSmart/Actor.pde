
static PVector upacc = new PVector(0, -1);
static PVector downacc = new PVector(0, 1);
static PVector leftacc = new PVector(-1, 0);
static PVector rightacc = new PVector(1, 0);

class Actor {
  PVector pos;
  PVector vel;
  PVector acc;
  float r = 5;
  float maxSpeed = 50; // pixels per second
  float maxAcc = 1000; // pixels per second per second
  float dt = 1.0/fps;
  float damping = 0.8;

  float wiskerslength = 30;

  ArrayList<PVector> antennas = new ArrayList<PVector>();
  ArrayList<Integer> antcolors = new ArrayList<Integer>();
  Controller c;

  Actor(float x, float y, Controller co) {
    c =  co;
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    int numRays = 8;
    for (int i = 0; i<numRays; i++) {
      PVector a = new PVector(1, 0, wiskerslength);
      a.rotate(i* (2*PI/numRays));
      antennas.add(a);
      antcolors.add(color(0, 0, 255));
    }
    c.init(this);
  }

  void update() {
    c.update(this);
    vel.add(acc.x*dt*dt, acc.y*dt*dt);
    if (acc.mag()<=0) {
      vel.mult(damping);
    }
    acc.set(0, 0);
    if (vel.mag() > maxSpeed) {
      vel.normalize();
      vel.mult(maxSpeed);
    }
    pos.add(vel.x*dt, vel.y*dt);
    checkCollision();
  }

  private void checkCollision() {
    boolean hitwall = false;
    if (pos.x < 0) {
      pos.x = 0;
      hitwall = true;
    }
    if (pos.x > width) {
      pos.x = width;
      hitwall = true;
    }
    if (pos.y < 0) {
      pos.y = 0;
      hitwall = true;
    }
    if (pos.y > height) {
      pos.y = height;
      hitwall = true;
    }
    if (hitwall) {
      vel.set(0, 0);
    }
  }

  void render() {
    c.render(this);
    fill(0, 255, 255);
    stroke(255, 255, 0);
    for (int i = 0; i<antennas.size (); i++) {
      PVector temp = antennas.get(i);
      stroke(antcolors.get(i));
      line(pos.x, pos.y, pos.x + temp.x*temp.z, pos.y + temp.y*temp.z);
    }
    ellipse(pos.x, pos.y, r, r);
  }
  void accellerate(PVector dir) {
    dir.normalize();
    dir.mult(maxAcc);
    acc.add(dir);
    acc.normalize();
    acc.mult(maxAcc);
  }
  void up() {
    accellerate(upacc);
  }
  void down() {
    accellerate(downacc);
  }
  void left() {
    accellerate(leftacc);
  }
  void right() {
    accellerate(rightacc);
  }
}