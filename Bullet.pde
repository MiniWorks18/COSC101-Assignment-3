class Bullet {
  PVector shotLoc, shotVel;
  float x, y;


  Bullet (PVector shotLoc, PVector shotVel, float x, float y) {
    this.shotLoc = shotLoc;
    this.shotVel = shotVel;
    this.x = x;
    this.y = y;
  }


  void display(int index) {
    fill(255);
    circle(x, y, 5);
  }

  void update(int index) {
    shotLoc.add(shotVel);

    for (int i = 0; i < asteroids.size(); i++) {
      if (dist(shotLoc.x, shotLoc.y, asteroids.get(i).x, asteroids.get(i).y)
          < (asteroids.get(i).size/2)) {
        asteroids.get(i).explode(i);
        bullets.remove(i);
      }
    }
  }

}
