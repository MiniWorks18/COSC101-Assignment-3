/**************************************************************
* File: a3.pde
* Group: <Group members,group number>
* Date: 14/03/2018
* Course: COSC101 - Software Development Studio 1
* Desc: Astroids is a ...
* ...
* Usage: Make sure to run in the processing environment and press play etc...
* Notes: If any third party items are use they need to be credited (don't use anything with copyright - unless you have permission)
* ...
**************************************************************/

// Game critical non-variables
float maxSpeed;
final float traction = 0.2;
float shipHeading;
float shipRotSpeed;
final int shipRadius = 15;
final float brakeSpeed = 1.01;
final int difficulty = 3; // 1 for hardest
// The buffer between the text and sides of the window
final int textXBuffer = 20, textYBuffer = 40;
final int textSizeDefault = 25;
final int asteroidSheetRowCount=12;
final int startQuantity=8;


// Game critical variables
boolean sUP=false,sDOWN=false,sRIGHT=false,sLEFT=false;
int score;
int level;
int livesLeft;
boolean gameOver;
float livesLeftLength, asteroidsLeftLength;
boolean alive=true;
boolean asteroidShipContact=false;
Asteroid asteroidInContact;
int currentShip;
int milliseconds;
//Asteroid Texture Sheet Pieces
ArrayList<ArrayList<PImage>> aPieces=new ArrayList<ArrayList<PImage>>();
ArrayList<Asteroid> asteroids;
ArrayList<Asteroid> debris;
ArrayList<Bullet> bullets;
ArrayList<PImage> ships=new ArrayList<PImage>();
PImage aSheet; //Asteroid Texture Sheet
PImage ship;
PVector shipLoc;
PVector shipVel;
PVector shipRot;
PVector shipAccel;



// Defines all variables and spawns asteroids
void setup(){
  size(1500,800);
  strokeWeight(5);
  textSize(textSizeDefault);
  fill(256, 256, 256);
  stroke(256, 256, 256);
  imageMode(CENTER);
  smooth();
  currentShip = 0;
  shipLoc = new PVector(0,0);
  shipVel = new PVector(0,0);
  shipRot = new PVector(0,1);
  shipAccel = new PVector(0,0);
  shipHeading = 0;
  score = 0;
  level = 0;
  livesLeft = 3;
  maxSpeed = 3;
  gameOver = false;
  shipLoc.x = width/2;
  shipLoc.y = height-100;
  ship = loadImage("ships_void.png").get(0,384,31,47);
  asteroids = new ArrayList<Asteroid>();
  debris=new ArrayList<Asteroid>();
  bullets=new ArrayList<Bullet>();

  /** Adds 8 full size asteroids with random velocity **/
  for (int i = 0; i < startQuantity; i++) {
      asteroids.add(new Asteroid(new
      PVector().random2D(),
      random(50, width-50),
      random(50, width-50),
      3, 0, 0));
  }
  packageAsteroids();
  packageShips();
}


// Updates ship coordinates according to acceleration and heaading.
void moveShip(){
  shipRotSpeed = 0.1+currentShip*0.03;
  maxSpeed = 3+currentShip;
  shipHeading = shipRot.heading()+PI/2;

  // Ship control actions
  if(sUP){
      shipAccel = new PVector(0,traction);
      shipAccel.rotate(shipHeading);
  }
  if(sRIGHT){
      shipRot.rotate(+shipRotSpeed);
  }
  if(sLEFT){
      shipRot.rotate(-shipRotSpeed);
  }

  // Checks if ship has left the window, and updates coordinates accordingly
  if (shipLoc.x > width+shipRadius) {
    shipLoc.x = -shipRadius;
  }
  if (shipLoc.x < -shipRadius) {
    shipLoc.x = width+shipRadius;
  }
  if (shipLoc.y > height+shipRadius) {
    shipLoc.y = -shipRadius;
  }
  if (shipLoc.y < -shipRadius) {
    shipLoc.y = height+shipRadius;
  }
  shipLoc.add(shipVel);
}


// Draws the ship with the newly updated coordiantes handled by moveShip()
void drawShip(){
  shipVel.div(brakeSpeed); // Slows down the ship
  tint(255, 255); // Keeps ship image opacity at full
  shipVel.add(shipAccel);
  shipVel.limit(maxSpeed);
  shipLoc.add(shipVel);
  pushMatrix(); // Creating a matrix to render ship at a unique angle
  translate(shipLoc.x,shipLoc.y);
  rotate(shipHeading);
  image(ships.get(currentShip),0,0);
  popMatrix();
  shipAccel = new PVector(0,0);
}


void drawShots(){
   //draw points for each shot from spacecraft
   //at location and updated to new location
}


// Updates and displays each asteroid in Arraylist asteroids. Also
// checks if it should level up.
void drawAstroids(){
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).update(i);
    asteroids.get(i).display(i);
  }

  for (int i = 0; i < debris.size(); i++) {
    debris.get(i).update(i);
    debris.get(i).display(i);
    debris.get(i).fade(20);
    if (debris.get(i).fade > 256) {
      debris.remove(i);
    }
  }

  if (asteroids.size() == 0) {
    levelUp();
  }
}


// Fetches asteroids from asteroid pixel art sheet
// Source: https://opengameart.org/content/shmup-ships surt (2012)
void packageAsteroids(){
  aSheet = loadImage("asteroids.png");
  // Coordinates on the asteroid sheet
  int[] sheetCoords = {
    4,4,11,11,16,0,15,20,32,0,31,32,65,0,47,48,
    116,0,8,15,128,4,16,27,148,0,28,32,176,0,31,47,
    212,0,7,12,224,0,15,15,244,0,23,31,272,4,31,43
  };
  // Using the coordinates, this collects the pixels
  for (int i = 0, j = 0; i < asteroidSheetRowCount; i++, j += 48) {
    aPieces.add(new ArrayList<PImage>());
    for (int k = 0; k < 48; k = k+4) {
      aPieces.get(i).add(aSheet.get(
        sheetCoords[k],j+sheetCoords[k+1],
        sheetCoords[k+2],sheetCoords[k+3]
      ));
    }
  }

}


// Gets differnet ships from the ship pixel art sheet
void packageShips() {
  PImage shipSheet = loadImage("ships_void.png");
    ships.add(shipSheet.get(0,144,31,47));
    ships.add(shipSheet.get(0,384,31,47));
    ships.add(shipSheet.get(0,624,31,47));
    ships.add(shipSheet.get(0,864,31,47));
}


// Iterates into next level. Spawns new asteroids.
// Updates ship and asteroid types.
void levelUp() {
  if (level < 11) {
    level = level + 1;
  }

  if (currentShip < 3) {
    currentShip++;
  }
  // Spawns new astreoids of type according to the leve
  for (int i = 0; i < startQuantity; i++) {
      asteroids.add(new Asteroid(new
      PVector(random(-1-level/difficulty, 1+level/difficulty),
      random(-1-level/difficulty, 1+level/difficulty)),
      random(50, width-50),
      random(50, width-50),
      3, level, 0));
  }
}


// Checks distance between projectile and asteroid.
// Removes a life if the ship is too close.
void collisionDetection(){
  //check if ship as collided wiht astroids
  Asteroid asteroid;
  for (int i = 0; i < asteroids.size(); i++) {
    asteroid = asteroids.get(i);

    if (dist(asteroid.x, asteroid.y, shipLoc.x, shipLoc.y) <
    shipRadius+asteroid.radius) {
      if (!asteroidShipContact){
        asteroidInContact = asteroid;
        asteroidShipContact = true;
        livesLeft--;
        if (livesLeft < 1) {
          milliseconds = millis(); // Capturing time of game end
          gameOver();
        }
      }
    }

    try { // Checking if the ship is far enough away to re-enable collisions
      if (dist(asteroidInContact.x, asteroidInContact.y, shipLoc.x, shipLoc.y) >
        2*(asteroid.radius+shipRadius)) {
        asteroidShipContact = false;
      }
    } catch (Exception NullPointerException) {
      asteroidShipContact = false;
      }
  }

}


// Draws the score, how many lives are left, and how many asteroids are left.
void drawScore() {
  text("Score: "+str(score),textXBuffer,textYBuffer);
  livesLeftLength = textWidth("Lives Left: "+str(livesLeft));
  text("Lives Left: "+livesLeft,width-(textXBuffer+livesLeftLength),textYBuffer);
  asteroidsLeftLength = textWidth("Asteroids Left: "+str(asteroids.size()));
  text("Asteroids Left: "+asteroids.size(),
  width-(textXBuffer+asteroidsLeftLength), textYBuffer*2);
}


// Will trigger the game over screen
void gameOver() {
 gameOver = true;

}


// Master draw function
void draw() {
  background(0);
  if (gameOver) { // Brings up the game over screen
    textSize(60);
    fill(255,0,0);
    text("GAMEOVER",(width-textWidth("GAMEOVER"))/2,height/2);
    textSize(textSizeDefault);
    // Waits 2 seconds before showing restart option
    if (milliseconds+2000 < millis()) {
      fill(50,205,50);
      text("Press \"r\" to restart",
      (width-textWidth("Press \"r\" to restart"))/2, height/2+textYBuffer*2);
    }

  } else {
  //might be worth checking to see if you are still alive first
  moveShip();
  collisionDetection();
  // draw ship - call shap(..) if Pshape
  // report if game over or won
  }
  drawShots();
  drawShip();
  drawAstroids();
  drawScore();
}


// Handles key pressing for movement, shooting, and restarting.
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=true;
    }
    if (keyCode == DOWN) {
      sDOWN=true;
    }
    if (keyCode == RIGHT) {
      sRIGHT=true;
    }
    if (keyCode == LEFT) {
      sLEFT=true;
    }
  }
  if (key == BACKSPACE) {
    //fire a shot
    bullets.add(new Bullet(new PVector(shipLoc.x, shipLoc.y), new PVector(0.1,0.1),
                shipLoc.x, shipLoc.y));
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=false;
    }
    if (keyCode == DOWN) {
      sDOWN=false;
    }
    if (keyCode == RIGHT) {
      sRIGHT=false;
    }
    if (keyCode == LEFT) {
      sLEFT=false;
    }
  } else if (key == 'r') {
    setup(); // Will restart the game
  }
}
