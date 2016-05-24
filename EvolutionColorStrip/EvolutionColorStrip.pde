import java.util.Collections;
import java.util.Comparator;

Animal goal = new Animal();
int generation = 0;
ArrayList<Animal> animals = new ArrayList<Animal>();
int numans = 30;
void setup() {
  size(640, 360);
  noStroke();
  for (int i = 0; i<numans; i++) {
    animals.add(new Animal(goal));
  }
  Collections.sort(animals);
  frameRate(100);
}

void draw() {

  background(51);
  for (int i = 0; i<animals.size(); i++) {
    animals.get(i).render(0+11*i, 20);
  }
  if (animals.get(0).fitness != 0) {

    generation++;
    int max = animals.size();
    for (int i = 0; i<max; i+=2) {
      animals.add(new  Animal(animals.get((int)random(0,max)), animals.get((int)random(0,max))));
      animals.add(new  Animal(animals.get((int)random(0,max)), animals.get((int)random(0,max))));
    }
    Collections.sort(animals);
    for (int i = animals.size()-1; i>=numans; i--) {
      animals.remove(i);
    }
  }
  goal.render(numans * 11 + 12, 20);
  color(255);
  text("Gens: " + generation, 400, 30);
  text("Best: " + animals.get(0).fitness, 400, 50);
}