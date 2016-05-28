import java.util.Collections;
import java.util.Comparator;

Animal goal;
int generation = 0;
ArrayList<Animal> animals = new ArrayList<Animal>();
int numans = 35;
int bw = 64;
int bh =64;
int blocks = bw*bh;
PImage img, tofind;
int imgw = 512;
int imgh = 512;
float MUTCH = 0.05;
int bpw = imgw/bw;
int bph = imgh/bh;
int[] idxs = new int[bw*bh];
ArrayList<Integer> aridx = new ArrayList<Integer>();

void setup() {
  size(800, 800);
  noStroke();
  frameRate(500);
  colorMode(RGB, 255);
  img = loadImage("dog.png");
  tofind = loadImage("city.png");
  goal = new Animal(img);
  for (int i = 0; i<numans; i++) {
    animals.add(new Animal(goal));
  }
  Collections.sort(animals);
  for (int i = 0; i<bw*bh; i++) {
    aridx.add(i);
  }
}

void fillRandom(int[] idx) {
  ArrayList<Integer> temp = new ArrayList<Integer>();
  for (int i = 0; i<blocks; i++) {
    temp.add(i);
  }
  for (int i = 0; i<blocks; i++) {
    int ii = (int)random(0, temp.size());
    idx[i] = i;//temp.get(ii);
    temp.remove(ii);
  }
  //print("Rando: ");
  //for (int i = 0; i<blocks; i++) {
  //  print(idx[i] + ",");
  //}
  //println();
}

void fillImage(int[] idx, PImage goal, PImage fill) {
  for (int i = 0; i<blocks; i++) {
    int ix = (idx[i]%bw)*bpw;
    int iy = (idx[i]/bw)*bph;
    PImage temp = goal.get(ix, iy, imgw/bw, imgh/bh);
    fill.set((i%bw)*bpw, (i/bw)*bph, temp);
  }
}
void swap(int[] idx, int a, int b) {
  int temp = idx[a];
  idx[a] = idx[b];
  idx[b] = temp;
}

void draw() {
  background(51);
  //for (int i = 0; i<animals.size(); i++) {
  //  animals.get(i).render((i%5)*(imgw+4), (i/5)*(imgh+4));
  //}
  if (animals.get(0).fitness != 0) {

    generation++;
    int max = animals.size();
    for (int i = 0; i<max; i+=2) {
      animals.add(new  Animal(animals.get((int)random(0, max)), animals.get((int)random(0, max))));
      animals.add(new  Animal(animals.get((int)random(0, max)), animals.get((int)random(0, max))));
    }
    Collections.sort(animals);
    for (int i = animals.size ()-1; i>=numans; i--) {
      animals.remove(i);
    }
  }
  animals.get(0).render(10, 100);
  goal.render(300, 100);
  image(tofind, 300, 300, 200,200);
  color(255);
  text("Gens: " + generation, 400, 30);
  text("Best: " + animals.get(0).fitness, 400, 50);
}