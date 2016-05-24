
static int NUMGENES = 100;
static float MUTCH = 0.01;
class Animal implements Comparable<Animal> {
  int[] genes = new int[NUMGENES];
  int fitness = 0;

 Animal() {
    for (int i = 0; i<NUMGENES; i++) {
      genes[i] =  (int)random(0, 255);
    }
  }

  Animal(Animal goal) {
    for (int i = 0; i<NUMGENES; i++) {
      genes[i] =  (int)random(0, 255);
    }
    fitness = getFitness(goal);
  }
  
  Animal(Animal a, Animal b) {
    for (int i = 0; i<NUMGENES; i++) {
      int ch = (int) random(0,1 / MUTCH);
      int mutation = 0;
      if(ch == 0){
        mutation = (int)random(-10,10);
      }
      if (i >= NUMGENES/2) {
        genes[i] = b.genes[i] + mutation;
      } else {
        genes[i] = a.genes[i] + mutation;
      }
    }
    fitness = getFitness(goal);
  }

  public int compareTo(Animal a) {

    if (fitness == a.fitness) {
      return 0;
    } else if (fitness > a.fitness) {
      return 1;
    } else {
      return -1;
    }
  }

  void render(int x, int y) {
    //text(fitness, x, y-10); 
    for (int i = 0; i<NUMGENES; i++) {
      color c = color(genes[i]);  // Define color 'c'
      fill(c);
      rect(x, y + i*3, 10, 3);
    }
  }

  int getFitness(Animal a) {
    int sumdiff = 0; 
    for (int i = 0; i<NUMGENES; i++) {
      sumdiff += abs(genes[i] - a.genes[i]);
    }
    return sumdiff;
  }
} 