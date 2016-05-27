class Food {

  PVector pos;
  float radius;
  color c = color(255,0,0);
  Food() {
    pos = new PVector(random(10, width-20), random(10, height-20));
    radius = 5;
  }
  
  void update(float dt){
    
  }
  
  void render() {
    fill(c);
    ellipse(pos.x,pos.y,radius,radius);
  }
  
}

