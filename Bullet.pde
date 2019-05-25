class Bullet {
  PVector shotLoc, shotVel;


  Bullet (PVector shotLoc, PVector shotVel) {
    this.shotLoc = shotLoc;
    this.shotVel = shotVel;
  }


  void display(int index) {
    fill(255, 255, 255);
    circle(shotLoc.x, shotLoc.y, bulletSize);
  }

  void update(int index) {
    shotLoc.add(shotVel);

    if (shotLoc.x > width || shotLoc.x < 0 ||
        shotLoc.y > height || shotLoc.y < 0) {
          bullets.remove(index);
    }

    for (int i = 0; i < bullets.size(); i++) {
      for (int j = 0; j < asteroids.size(); j++) {
        try { // Sometimes bullets leave the window while the loop is running
        if (dist(asteroids.get(j).x, asteroids.get(j).y,
            bullets.get(i).shotLoc.x, bullets.get(i).shotLoc.y) <
            bulletSize+asteroids.get(j).radius) {
          bullets.remove(i);
          asteroids.get(j).explode(j);
        }
      } catch (Exception IndexOutOfBoundsException) {}
      }
    }
  }

}
