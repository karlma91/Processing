
class Animal implements Comparable<Animal> {
  PImage image;
  int fitness = 0;
  int[] genes;

  Animal(PImage img) {
    image = img;
    image.loadPixels();
  }

  Animal(Animal goal) {
    image = createImage(imgw, imgh, RGB);
    image.loadPixels();
    genes = new int[blocks];
    fillRandom(genes);
    fillImage(genes, tofind, image);
    fitness = getFitness(goal);
  }

  Animal(Animal aa, Animal bb) {
    image = createImage(imgw, imgh, RGB);
    image.loadPixels();
    genes = new int[blocks];
    boolean[] taken1 = new boolean[blocks];
    boolean[] taken2 = new boolean[blocks];
    for (int i = 0; i<blocks; i++) {
      if (i < blocks/2) {
        taken2[aa.genes[i]] = true;
      } else {
        taken2[bb.genes[i]] = true;
      }
    }
    for (int i = 0; i<blocks; i++) {
      if (i < blocks/2) {
        genes[i] = aa.genes[i];
        taken1[aa.genes[i]] = true;
      } else {
        if (taken1[bb.genes[i]]) {
          for (int j = 0; j<blocks; j++) {
            if (!taken2[j]) {
              genes[i] = j;
              taken2[j] = true;
              break;
            }
          }
        } else {
          genes[i] = bb.genes[i];
          taken1[bb.genes[i]] = true;
        }
      }
    }
    int ch = (int) random(0, 1 / MUTCH);
    if (ch == 0) {
      int r1 = (int)random(0, blocks);
      int r2 = (int)random(0, blocks);
      while (r2==r1) {
        r2 = (int)random(0, blocks);
      }
      swap(genes, r1, r2);
    }
    //print("Genes: ");
    //for (int i = 0; i<blocks; i++) {
   //  print(genes[i]+ ",");
   // }
   // println();
    fillImage(genes, tofind, image);
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
    image.updatePixels();
    image(image, x, y,200,200);//, imgw*2, imgh*2);
  }

  int getFitness(Animal a) {
    int sumdiff = 0; 
    for (int i = 0; i<imgw*imgh; i++) {
      sumdiff += abs((image.pixels[i] >> 16 & 0xFF) - (a.image.pixels[i] >> 16 & 0xFF));
    }
    return sumdiff;
  }
} 