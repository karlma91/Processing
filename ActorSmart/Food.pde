class Food {

  PVector pos;
  float radius;
  color c = color(255, 0, 0);
  int type = 0;
  float value = 0;
  Food(int type) {
    this.type = type;
    pos = new PVector(random(10, width-20), random(10, height-20));
    radius = 5;
    if (type == 1) {
      value = -1;
      c = color(230, 20, 20);
    } else if (type == 2) {
      value = 1;
      c = color(20, 230, 20);
    }
  }

  void update(float dt) {
  }

  void render() {
    fill(c);
    stroke(0);
    ellipse(pos.x, pos.y, radius, radius);
  }
}

