class Actor {
  PVector pos;
  PVector dir;
  float r = 5;
  float speed = 50;
  float turnspeed = 2*PI;
  float dt = 0;
  float wiskerslength = 30;
  ArrayList<PVector> antennas = new ArrayList<PVector>();
  ArrayList<Integer> antcolors = new ArrayList<Integer>();

  Actor(float x, float y) {
    pos = new PVector(x, y);
    dir = new PVector(1, 0);
    //dir.rotate(random(0,2*PI));
    int numRays = 8;
    for (int i = 0; i<numRays; i++) {
      PVector a = new PVector(1, 0, wiskerslength);
      a.rotate(i* (2*PI/numRays));
      antennas.add(a);
      antcolors.add(color(0,0,255));
    }
  }

  void update(float dt) {
    this.dt = dt;
    int rand = (int)random(0,10);
    if (rand == 0) {
      turn(turnspeed*dt);
    }else if(rand == 2){
      turn(-turnspeed*dt);
    }
    if (true) {
      forward();
    }
  
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
    if(hitwall){
     turn(PI);
    }
  }

  void render() {
    fill(0, 255, 255);
    stroke(255,255,0);
    for (int i = 0; i<antennas.size (); i++) {
      PVector temp = antennas.get(i);
      stroke(antcolors.get(i));
      line(pos.x, pos.y, pos.x + temp.x*temp.z, pos.y + temp.y*temp.z);
    }
    ellipse(pos.x, pos.y, r, r);
    //line(pos.x, pos.y, pos.x+dir.x*10, pos.y+dir.y*10);
  }

  void turn(float a) {
    dir.rotate(a);
    for (int i = 0; i<antennas.size (); i++) {
      antennas.get(i).rotate(a);
    }
  }
  void forward() {
    pos.add(dir.x * speed*dt, dir.y*speed*dt, 0);
  }
}