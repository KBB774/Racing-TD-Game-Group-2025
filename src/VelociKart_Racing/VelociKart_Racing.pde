//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin

import gifAnimation.*;

Enemy e1;

// WORLD SIZE
int worldWidth = 2250;
int worldHeight = 2000;

// PLAYER
PVector playerPos;
float angle = 0;           // rotation angle

float speed = 10;          // constant movement speed
float turnSpeed = 4;       // how fast the car rotates

// KEYS
boolean wDown = false;
boolean sDown = false;
boolean aDown = false;
boolean dDown = false;

// IMAGES
PImage carImage;
PImage racetrack_1;
PImage nitro;
PImage start;

boolean play = false;

void setup() {
  size(1920, 1080, P2D);   // GPU renderer — prevents rotation lag

  playerPos = new PVector(500, 500);
  e1 = new Enemy();

  // Load images
  carImage = loadImage("bluecar_right.png");  // car must face UP
  racetrack_1 = loadImage("racetrackfinal (1).png");
  nitro = loadImage("Nitro.png");
  start = loadImage("StartScreen.png");
}

void draw() {

  // ---- START SCREEN ----
  if (!play) {
    startScreen();
    return;
  }

  background(128);

  // Camera follows player
  translate(width/2 - playerPos.x, height/2 - playerPos.y);

  // ---- TURN (EVEN WHILE MOVING) ----
  if (aDown) angle -= turnSpeed;
  if (dDown) angle += turnSpeed;

  // ---- MOVE ----
  float rad = radians(angle);

  if (wDown) {
    playerPos.x += cos(rad) * speed;
    playerPos.y += sin(rad) * speed;
  }
  if (sDown) {
    playerPos.x -= cos(rad) * speed;
    playerPos.y -= sin(rad) * speed;
  }

  // ---- KEEP CAR IN WORLD ----
  playerPos.x = constrain(playerPos.x, 0, worldWidth);
  playerPos.y = constrain(playerPos.y, 0, worldHeight);

  // ---- DRAW WORLD & ENEMY ----
  drawWorld();
  e1.display();

  // ---- DRAW CAR ----
  drawCar();
}


// -------------------- DRAW FUNCTIONS --------------------

void drawWorld() {
  imageMode(CORNER);
  image(racetrack_1, 0, 0);

  // optional grid
  stroke(255, 20);
  for (int x = 0; x < worldWidth; x += 100)
    line(x, 0, x, worldHeight);
  for (int y = 0; y < worldHeight; y += 100)
    line(0, y, worldWidth, y);
}

void drawCar() {
  pushMatrix();
  translate(playerPos.x, playerPos.y);
  rotate(radians(angle));
  imageMode(CENTER);
  image(carImage, 0, 0);
  popMatrix();
}


// -------------------- INPUT HANDLING --------------------

void keyPressed() {
  if (key == 'w' || keyCode == UP)    wDown = true;
  if (key == 's' || keyCode == DOWN)  sDown = true;
  if (key == 'a' || keyCode == LEFT)  aDown = true;
  if (key == 'd' || keyCode == RIGHT) dDown = true;
}

void keyReleased() {
  if (key == 'w' || keyCode == UP)    wDown = false;
  if (key == 's' || keyCode == DOWN)  sDown = false;
  if (key == 'a' || keyCode == LEFT)  aDown = false;
  if (key == 'd' || keyCode == RIGHT) dDown = false;
}


// -------------------- START SCREEN --------------------

void startScreen() {
  background(0);
  imageMode(CENTER);
  image(start, width/2, height/2);

  fill(255);
  textSize(50);
  textAlign(CENTER);
  text("Click to Start", width/2, height - 150);

  if (mousePressed) {
    play = true;
  }
}
