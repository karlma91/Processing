class SimpleController implements Controller {

  PVector prev = new PVector(random(-2, 2), random(-2, 2));
  PVector vsum = new PVector();
  PVector pv = new PVector();

  public void init(Actor a) {
  }
  public void update(Actor a) {
    vsum.set(0, 0);
    for (int i = 0; i<a.scores.size (); i++) {
      float score = a.scores.get(i);
      pv.set(a.antennas.get(i));
      pv.normalize();
      if (score < 0.0) {
        pv.x = -pv.x + random(0,0.2);
        pv.y = -pv.y+ random(0,0.2);
        pv.mult(1-abs(score));
        pv.mult(0.8);
      } else if (score > -0.1 && score <0.1) {
        pv.set(0, 0);
        continue;
      }else{
        
      }
      vsum.add(pv);
    }
    if (vsum.mag() < 0.1) {
      vsum.set(prev);
      vsum.rotate(random(-PI/5, PI/5));
    }
    prev.set(vsum);
    a.accellerate(vsum);
  }

  public void render(Actor a) {
    textSize(14);
    fill(0);
    //text("Speed: " + a.vel.mag(), 0, 14);
  }
}