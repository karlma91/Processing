
int fps = 30;
Actor a = new Actor(10, 100);

ArrayList<Actor> actors = new ArrayList<Actor>();
ArrayList<Food> foods = new ArrayList<Food>();

boolean left = false;
boolean right = false;
boolean forward = false;
void setup()
{
  size(640, 360);
  frameRate(30);
  ellipseMode(RADIUS);
  for (int i = 0; i<1; i++) {
    actors.add(new Actor(random(0, width), random(0, height)));
  }
  for (int i = 0; i<100; i++) {
    foods.add(new Food());
  }
}

void draw()
{
  background(102);
  for (int i = 0; i<actors.size (); i++) {
    Actor aa = actors.get(i);
    aa.update(1.0/(float)fps);
    for (int j = 0; j<aa.antennas.size (); j++) {
      PVector an = aa.antennas.get(j);
      for (int k = foods.size ()-1; k>=0; k--) {
        Food f = foods.get(k);
        if (circleLine(aa.pos.x, aa.pos.y, aa.pos.x+an.x*an.z, aa.pos.y+an.y*an.z, f.pos.x, f.pos.y, f.radius)) {
          foods.remove(k);
        }
      }
    }
    aa.render();
  }
  for (int i = 0; i<foods.size (); i++) {
    foods.get(i).render();
  }
}

void keyPressed() {
  if (key == 'a') {
    left = true;
  } else if (key == 'd') {
    right = true;
  } else if (key == 'w') {
    forward = true;
  }
}

void keyReleased() {
  if (key == 'a') {
    left = false;
  } else if (key == 'd') {
    right = false;
  } else if (key == 'w') {
    forward = false;
  }
}

boolean circleLine(float ax, float ay, float bx, float by, float cx, float cy, float radius) {
  float dx = bx - ax;
  float dy = by - ay;
  float fx = ax - cx;
  float fy = ay - cx;
  float a = dx * dx + dy * dy;
  float b = 2*(dx * fx + dy * fy);
  float c = fx * fx + fy * fy - radius * radius;
  float discriminant = b*b-4*a*c;
  if (discriminant < 0) {
    return false;
  }
  discriminant = sqrt( discriminant );
  float t1 = (-b - discriminant)/(2*a);
  float t2 = (-b + discriminant)/(2*a);
  if ( t1 >= 0 && t1 <= 1 )
  {
    return true;
  }
  if ( t2 >= 0 && t2 <= 1 )
  {
    return true;
  }
  return false;
}
