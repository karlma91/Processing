class KeyBoardController implements Controller {

  public void init(Actor a){
    
  }
  public void update(Actor a){
    if(allkeys['w']){
      a.up();
    }
    if(allkeys['a']){
      a.left();
    }
    if(allkeys['s']){
      a.down();
    }
    if(allkeys['d']){
      a.right();
    }
  }
  public void render(Actor a){
    textSize(14);
    fill(0);
    text("Speed: " + a.vel.mag(),0,14);
  }
}