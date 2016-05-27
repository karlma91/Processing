class Actor {
  PVector pos;
  PVector dir;
  float r = 5;
  float speed = 100;
  float turnspeed = PI;
  float dt = 0;
  float wiskerslength = 50;
  ArrayList<PVector> antennas = new ArrayList<PVector>();

  Actor(float x, float y) {
    pos = new PVector(x, y);
    dir = new PVector(1, 0);
    //dir.rotate(random(0,2*PI));
    PVector a = new PVector(1,0,wiskerslength);
    PVector b = new PVector(1,0,wiskerslength);
    b.rotate(PI/8);
    PVector c = new PVector(1,0,wiskerslength);
    c.rotate(-PI/8);
    antennas.add(b);
    antennas.add(a);
    antennas.add(c);
  }

  void update(float dt) {
    this.dt = dt;
    if (left) {
      left();
    }
    if (right) {
      right();
    }
    if (forward) {
      forward();
    }
    
    if (pos.x < 0) {
      pos.x = 0;
    }
    if (pos.x > width) {
      pos.x = width;
    }
    if (pos.y < 0) {
      pos.y = 0;
    }
    if (pos.y > height) {
      pos.y = height;
    }
  }

  void render() {
    fill(0,255,255);
    ellipse(pos.x, pos.y, r, r);
    //line(pos.x, pos.y, pos.x+dir.x*10, pos.y+dir.y*10);
    for (int i = 0; i<antennas.size (); i++) {
      PVector temp = antennas.get(i);
      line(pos.x, pos.y, pos.x + temp.x*temp.z, pos.y + temp.y*temp.z);
    }
  }

  void left() {
    dir.rotate(turnspeed*dt);
    for (int i = 0; i<antennas.size (); i++) {
      antennas.get(i).rotate(turnspeed*dt);      
    }
  }
  void right() {
    dir.rotate(-turnspeed*dt);
    for (int i = 0; i<antennas.size (); i++) {
      antennas.get(i).rotate(-turnspeed*dt);      
    }
  }
  void forward() {
    pos.add(dir.x * speed*dt, dir.y*speed*dt, 0);
  }
}

