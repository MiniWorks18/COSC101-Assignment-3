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

PShape ship; // don't have to use pshape - can use image
int astroNums=20;
PVector[] astroids = new PVector[astroNums];
PVector[] astroDirect = new PVector[astroNums];
float speed = 0;
float maxSpeed = 4;
float radians=radians(270); //if your ship is facing up (like in atari game)
PVector shipCoord;
PVector direction;
ArrayList shots= new ArrayList();
ArrayList sDirections= new ArrayList();
boolean sUP=false,sDOWN=false,sRIGHT=false,sLEFT=false;
int score=0;
String asteroidsLeft;
boolean alive=true;
int startQuantity = 8;
int asteroidSheetRowCount = 12;
ArrayList<Asteroid> asteroids= new ArrayList<Asteroid>();
PImage aSheet; //Asteroid Texture Sheet
//Asteroid Texture Sheet Pieces
ArrayList<ArrayList<PImage>> aPieces= new ArrayList<ArrayList<PImage>>();


void setup(){
  size(1000,800);
  strokeWeight(5);
  textSize(25);
  fill(256, 256, 256);
  stroke(256, 256, 256);
  smooth();
  /** Adds 8 full size asteroids with random velocity **/
  for (int i = 0; i < startQuantity; i++) {
      asteroids.add(new Asteroid(new
      PVector(random(-1, 1), random(-1, 1)),
      random(0, width),
      random(0, width),
      3, 1));
  }
  packageAsteroids();
  //initialise pvtecotrs
  //random astroid initial positions and directions;
  //initialise shapes if needed
}

/**************************************************************
* Function: myFunction()

* Parameters: None ( could be integer(x), integer(y) or String(myStr))

* Returns: Void ( again this could return a String or integer/float type )

* Desc: Each funciton should have appropriate documentation.
        This is designed to benefit both the marker and your team mates.
        So it is better to keep it up to date, same with usage in the header comment

***************************************************************/

void moveShip(){

  //this function should update if keys are pressed down
     // - this creates smooth movement
  //update rotation,speed and update current location
  //you should also check to make sure your ship is not outside of the window
  if(sUP){
  }
  if(sDOWN){

  }
  if(sRIGHT){
  }
  if(sLEFT){
  }
}
void drawShots(){
   //draw points for each shot from spacecraft
   //at location and updated to new location
}

void drawAstroids(){
  //check to see if astroid is not already destroyed
  //otherwise draw at location
  //initial direction and location should be randomised
  //also make sure the astroid has not moved outside of the window
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).update(i);
    asteroids.get(i).display(i);
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

// Checks distance between projectile and asteroid.
// Calls explode() if projectile is too close.
void collisionDetection(){
  //check if shots have collided with astroids
  //check if ship as collided wiht astroids
  Asteroid asteroid;
  for (int i = 0; i < asteroids.size(); i++) {
    asteroid = asteroids.get(i);
    if (dist(asteroid.x, asteroid.y, mouseX, mouseY) < 30){
      asteroid.explode(i);
    }

  }
}

// Draws the score and how many asteroids are left.
void drawScore() {
  text("Score: "+str(score),20,40);
  asteroidsLeft = "Asteroids Left: "+str(asteroids.size());
  text(asteroidsLeft,width-(20+textWidth(asteroidsLeft)),40);
}

// Master draw function
void draw(){
  background(0);
  //might be worth checking to see if you are still alive first
  moveShip();
  collisionDetection();
  drawShots();
  // draw ship - call shap(..) if Pshape
  // report if game over or won
  drawAstroids();
  drawScore();
}

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
  if (key == ' ') {
    //fire a shot
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
  }
}
