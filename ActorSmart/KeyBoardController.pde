class KeyBoardController implements Controller {

  PVector temp = new PVector();
  public void init(Actor a) {
  }
  public void update(Actor a) {

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
    for (int i = 0; i<a.scores.size (); i++) {
      float score = a.scores.get(i);
      print(score+ ", ");
    }
    println();
  }
  public void render(Actor a) {
    textSize(14);
    fill(0);
    //text("Speed: " + a.vel.mag(), 0, 14);

    for (int i = 0; i<a.scores.size (); i++) {
      float score = a.scores.get(i);
      temp.set(a.antennas.get(i));
      temp.mult(1-abs(score));
      if (score != 0.0) {
        ellipse(a.pos.x + temp.x, a.pos.y + temp.y, 2, 2);
      }
    }
  }
}