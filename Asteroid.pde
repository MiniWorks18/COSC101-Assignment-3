class Asteroid {

PVector pvector;
float x, y;
int size, type;
int imgWidth, imgHeight;

Asteroid (PVector vector, float x, float y, int size, int type) {
  this.pvector = vector;
  this.x = x;
  this.y = y;
  this.size = size;
  this.type = type;
}

void display(int index) {
  fill(127);
  image(aPieces.get(type).get(size), x, y);

}

void update(int index) {
  x = x + pvector.x;
  y = y + pvector.y;
  imgWidth = aPieces.get(type).get(size).width;
  imgHeight = aPieces.get(type).get(size).height;
  if (x > width+imgWidth) {
    x = -imgWidth;
  } else if (x < (-imgWidth)) {
    x = width+imgWidth;
  }
  if (y > height+imgHeight) {
    y = -imgHeight;
  } else if (y < (-imgHeight)) {
    y = height+imgHeight;
  }
}


void explode(int index) {
  if (asteroids.get(index).size > 0) {
    for (int i = 0; i < round(random(2,3)); i++){
      asteroids.add(new Asteroid(new
      PVector(random(-1, 1), random(-1, 1)),
      asteroids.get(index).x, asteroids.get(index).y,
      asteroids.get(index).size-1, asteroids.get(index).type+1));
    }
  }
  score += asteroids.get(index).size*10;
  asteroids.remove(index);

}

void decreaseSize() {
  size = size - 1;
}

}
