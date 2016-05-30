
static PVector upacc = new PVector(0, -1);
static PVector downacc = new PVector(0, 1);
static PVector leftacc = new PVector(-1, 0);
static PVector rightacc = new PVector(1, 0);

class Actor {
  PVector pos;
  PVector vel;
  PVector acc;
  float r = 6;
  float maxSpeed = 50; // pixels per second
  float maxAcc = 100000; // pixels per second per second
  float dt = 1.0/fps;
  float damping = 0.8;
  boolean alive = true;
  float wiskerslength = 50;
  float food = 2;

  ArrayList<PVector> antennas = new ArrayList<PVector>();
  ArrayList<Float> scores = new ArrayList<Float>();
  ArrayList<Integer> antcolors = new ArrayList<Integer>();
  Controller c;

  int numRays = 16;
  Actor(float x, float y, Controller co) {
    c =  co;
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    for (int i = 0; i<numRays; i++) {
      PVector a = new PVector(1, 0, wiskerslength);
      a.rotate(i* (2*PI/numRays));
      antennas.add(a);
      antcolors.add(color(0, 0, 255));
      scores.add(0.0);
    }
    c.init(this);
  }

  void update() {
    c.update(this);

    if (food <0) {
      alive = false;
    }
    vel.add(acc.x*dt*dt, acc.y*dt*dt, 0);
    if (acc.mag()<=0) {
      //vel.mult(damping);
    }
    acc.set(0, 0);
    if (vel.mag() > maxSpeed) {
      vel.normalize();
      vel.mult(maxSpeed);
    }
    pos.add(vel.x*dt, vel.y*dt, 0);
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
  PVector temp = new PVector();
  void accellerate(PVector dir) {
    temp.set(dir);
    temp.normalize();
    temp.mult(maxAcc);
    acc.add(temp);
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

