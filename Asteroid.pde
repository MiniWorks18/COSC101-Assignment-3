
// Asteroid class object used to keep track of the specifics of each
// asteroid.
class Asteroid {

PVector pvector;
float x, y, radius;
int size, type, fade;
int halfImgWidth, halfImgHeight;

Asteroid (PVector vector, float x, float y, int size, int type, int fade) {
  this.pvector = vector;
  this.x = x;
  this.y = y;
  this.size = size;
  this.type = type;
  this.fade = fade;
  this.radius = size*8;
}


// Displays the asteroid
void display(int index) {
  fill(127);
  tint(255, 255-fade);
  image(aPieces.get(type).get(size), x, y);

}


// Updates the asteroid location. This also checks if the asteroid is
// out of bounds.
void update(int index) {
  x = x + pvector.x;
  y = y + pvector.y;
  halfImgWidth = (aPieces.get(type).get(size).width/2);
  halfImgHeight = (aPieces.get(type).get(size).height/2);
  if (x > width+halfImgWidth) {
    x = -halfImgWidth;
  } else if (x < (-halfImgWidth)) {
    x = width+halfImgWidth;
  }
  if (y > height+halfImgHeight) {
    y = -halfImgHeight;
  } else if (y < (-halfImgHeight)) {
    y = height+halfImgHeight;
  }
}


// Removes a collided asteroid and spawns 2-3 smaller asteroids if
// the removed asteroid is bigger than the smallest size.
void explode(int index) {
  if (asteroids.get(index).size > difficulty) {
    // Spawn multiple smaller asteroids
    for (int i = 0; i < round(random(2,3)); i++){
      asteroids.add(new Asteroid(new
      PVector(random(-1-level/difficulty, 1+level/difficulty),
      random(-1-level/difficulty, 1+level/difficulty)),
      asteroids.get(index).x, asteroids.get(index).y,
      asteroids.get(index).size-1, asteroids.get(index).type, 0));
    }
  }
  // Spawn debris from the explosion
  for (int i = 0; i < round(random(8,10)); i++) {
    debris.add(new Asteroid(new
    PVector(random(-4, 4), random(-4, 4)),
    asteroids.get(index).x, asteroids.get(index).y,
    8, asteroids.get(index).type, 0));
  }

  score += asteroids.get(index).size*10;
  asteroids.remove(index);

}


void fade(int amount) {
  fade += amount;

}
}
