
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
    genes = new int[bw*bh];
    fillRandom(genes);
    fillImage(genes, goal.image, image);
    fitness = getFitness(goal);
  }

  Animal(Animal aa, Animal bb) {
    image = createImage(imgw, imgh, RGB);
    image.loadPixels();
    for (int i = 0; i<imgw*imgh; i++) {
      int ch = (int) random(0, 1 / MUTCH);
      int mutation = 0;
      if (ch == 0) {
        mutation = (int)random(-2, 2);
      }
      if (i >= (imgw*imgh)/2) {
        int r = bb.image.pixels[i]>>16 & 0xFF;
        r = (r+mutation) >= 0  ? (r+mutation) : (r+mutation) <= 255  ? (r+mutation) : 255;
        int g = bb.image.pixels[i]>>8 & 0xFF;
        g = (g+mutation) >= 0  ? (g+mutation) : (g+mutation) <= 255  ? (g+mutation) : 255;
        int b = bb.image.pixels[i] & 0xFF;
        b = (b+mutation) >= 0  ? (b+mutation) : (b+mutation) <= 255  ? (b+mutation) : 255;

        image.pixels[i] = (r<<16 |g<<8 | b) ;
      } else {
        int r = aa.image.pixels[i]>>16 & 0xFF;
        r = (r+mutation) >= 0  ? (r+mutation) : (r+mutation) <= 255  ? (r+mutation) : 255;
        int g = aa.image.pixels[i]>>8 & 0xFF;
        g = (g+mutation) >= 0  ? (g+mutation) : (g+mutation) <= 255  ? (g+mutation) : 255;
        int b = aa.image.pixels[i] & 0xFF;
        b = (b+mutation) >= 0  ? (b+mutation) : (b+mutation) <= 255  ? (b+mutation) : 255;
        image.pixels[i] = (r<<16 |g<<8 | b);
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
    image.updatePixels();
    image(image, x, y);//, imgw*2, imgh*2);
  }

  int getFitness(Animal a) {
    int sumdiff = 0; 
    for (int i = 0; i<imgw*imgh; i++) {
      sumdiff += abs((image.pixels[i] >> 16 & 0xFF) - (a.image.pixels[i] >> 16 & 0xFF));
    }
    return sumdiff;
  }
} 

