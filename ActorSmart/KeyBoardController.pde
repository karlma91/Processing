class KeyBoardController implements Controller {

  public void init(Actor a) {
  }
  public void update(Actor a) {
    
    float sum = 0;
    PVector pv = new PVector();
    for (int i = 0; i<a.scores.size (); i++) {
      float score = a.scores.get(i);
      pv.set(a.antennas.get(i));
      if(score < 0.0){
        pv.x = -pv.x;
        pv.y = -pv.y;
      }else if(score > -0.5 && score <0.5){
        pv.set(0,0);
        continue;
      }
      pv.mult(100);
      print(score + " " + "(" + pv.x + ", " + pv.y + "),");
      sum += a.scores.get(i);
      a.accellerate(pv);
    }
    println();
    if (allkeys['w']) {
      a.up();
    }
    if (allkeys['a']) {
      a.left();
    }
    if (allkeys['s']) {
      a.down();
    }
    if (allkeys['d']) {
      a.right();
    }
  }
  public void render(Actor a) {
    textSize(14);
    fill(0);
    text("Speed: " + a.vel.mag(), 0, 14);
    text("Score: " + a.food, 0, 28);
  }
}

