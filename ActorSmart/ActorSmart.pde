
int fps = 15;
ArrayList<Actor> actors = new ArrayList<Actor>();
ArrayList<Food> foods = new ArrayList<Food>();

boolean[] allkeys = new boolean[256];

Controller cc = new KeyBoardController();
Controller cs = new SimpleController();
Controller[] controllers = {cc, cs};
int maxfood = 150;
void setup()
{
  size(640, 360);
  frameRate(30);
  ellipseMode(RADIUS);
  for (int i = 0; i<controllers.length; i++) {
    actors.add(new Actor(random(0, width), random(0, height), controllers[i]));
  }
  for (int i = 0; i<maxfood; i++) {
    foods.add(new Food((int)random(1, 3)));
  }
}

void draw()
{
  background(255);
  strokeWeight(1);
  PVector di = new PVector();
  for (int i = 0; i<actors.size (); i++) {
    Actor aa = actors.get(i);
    for (int j = 0; j<aa.antennas.size (); j++) {
      aa.antcolors.set(j, color(0, 0, 0));
      aa.scores.set(j, 0.0);
    }
    for (int j = 0; j<aa.antennas.size (); j++) {
      PVector an = aa.antennas.get(j);
      for (int k = foods.size ()-1; k>=0; k--) {
        di.set(aa.pos);
        Food f = foods.get(k);
        di.sub(f.pos);
        if (di.mag() < f.radius+aa.r) {
          aa.life +=f.value;
          foods.remove(k);          
          break;
        }
        float dist = circleLine(aa.pos.x, aa.pos.y, aa.pos.x+an.x, aa.pos.y+an.y, f.pos.x, f.pos.y, f.radius);
        if (dist>=0) {
          aa.antcolors.set(j, f.c);
          aa.scores.set(j, 1 - dist);
          if (f.type == 1) {
            aa.scores.set(j, -(1 - dist));
          }
          //f.render();
          break;
        }
      }
    }
  }
  for (int i = foods.size (); i<maxfood; i++) {
    foods.add(new Food((int)random(1, 3)));
  }
  for (int i = 0; i<actors.size (); i++) {
    Actor aa = actors.get(i);
    for (int j = 0; j<aa.antennas.size (); j++) {
      PVector an = aa.antennas.get(j);
      if (aa.scores.get(j) == 0 && wallCollision(aa.pos.x+an.x, aa.pos.y+an.y)) {
        aa.scores.set(j, -0.5);
        aa.antcolors.set(j, color(0, 0, 255));
      }
    }
  }

  for (int k = actors.size ()-1; k>=0; k--) {
    if (actors.get(k).life < 0) {
      actors.remove(k);
    }
  }

  for (int i = 0; i<foods.size (); i++) {
    foods.get(i).render();
  }
  for (int i = 0; i<actors.size (); i++) {
    Actor aa = actors.get(i);
    aa.update();
    aa.render();
  }
}

void keyPressed() {
  allkeys[key] = true;
}

void keyReleased() {
  allkeys[key] = false;
}


boolean wallCollision(float x, float y) {
  if (x < 0) {
    return true;
  }
  if (x > width) {
    return true;
  }
  if (y < 0) {
    return true;
  }
  if (y > height) {
    return true;
  }
  return false;
}

float circleLine(float ax, float ay, float bx, float by, float cx, float cy, float radius) {
  float dx = bx - ax;
  float dy = by - ay;
  float fx = ax - cx;
  float fy = ay - cy;
  float a = dx * dx + dy * dy;
  float b = 2*(dx * fx + dy * fy);
  float c = fx * fx + fy * fy - radius * radius;
  float discriminant = b*b-4*a*c;
  if (discriminant < 0) {
    return -1;
  }
  discriminant = sqrt( discriminant );
  float t1 = (-b - discriminant)/(2*a);
  float t2 = (-b + discriminant)/(2*a);
  if ( t1 >= 0 && t1 <= 1)
  {
    if (t2 >= 0 && t2 <= 1 && t2 >= t1) {
      return t1;
    } else {
      return t2;
    }
  }
  if ( t2 >= 0 && t2 <= 1 )
  {
    if (t1 >= 0 && t1 <= 1 && t2 >= t1) {
      return t1;
    } else {
      return t2;
    }
  }
  return -1;
}