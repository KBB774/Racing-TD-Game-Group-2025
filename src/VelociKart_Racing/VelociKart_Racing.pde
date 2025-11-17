//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin

int playerX, playerY;
int speed, worldWidth, worldHeight;
char screen = 's';   // s = start, p = play, t = settings

Button btnStart, btnSettings, btnBack;

PImage blue, racetrack_1, nitro, start;
PImage currentCar;

boolean play;

import gifAnimation.*;
Gif title;
Enemy e1;

// ROTATION + SMOOTH TURN SUPPORT
float angle = 0;
float turnSpeed = 4;

// Key states (lets W + A work at the same time)
boolean wDown = false;
boolean sDown = false;
boolean aDown = false;
boolean dDown = false;

void setup() {
  size(1920, 1080, P2D);   // P2D = NO rotation lag
  background(85, 197, 115);

  // BUTTONS
  btnStart    = new Button("PLAY",     width/2, 600, 300, 100);
  btnSettings = new Button("SETTINGS", width/2, 760, 300, 100);
  btnBack     = new Button("BACK",     200, 100, 200, 80);

  speed = 10;
  playerX = 500;
  playerY = 500;
  worldWidth = 2250;
  worldHeight = 2000;

  e1 = new Enemy();

  // Images
  blue = loadImage("bluecar_right.png");
  racetrack_1 = loadImage("racetrackfinal (1).png");
  nitro = loadImage("Nitro.png");
  start = loadImage("StartScreen.png");

  currentCar = blue;
}

void draw() {

  switch(screen) {

  case 's':   // START SCREEN
    drawStart();
    break;

  case 't':   // SETTINGS SCREEN
    drawSettings();
    break;

  case 'p':   // GAME
    drawPlay();
    break;
  }
}

// ----------------------------------------------------
// ------------------ GAME SCREEN ----------------------
// ----------------------------------------------------
void drawPlay() {
  background(85, 197, 115);

  // CAMERA
  translate(width/2 - playerX, height/2 - playerY);

  imageMode(CENTER);
  e1.display();

  if (aDown) angle -= turnSpeed;
  if (dDown) angle += turnSpeed;

  float rad = radians(angle);

  if (wDown) {
    playerX += cos(rad) * speed;
    playerY += sin(rad) * speed;
  }
  if (sDown) {
    playerX -= cos(rad) * speed;
    playerY -= sin(rad) * speed;
  }

  drawWorld();
  drawCar();

  playerX = constrain(playerX, 0, worldWidth);
  playerY = constrain(playerY, 0, worldHeight);
}

void drawCar() {
  pushMatrix();
  translate(playerX, playerY);
  rotate(radians(angle));
  imageMode(CENTER);
  image(currentCar, 0, 0);
  popMatrix();
}

void drawWorld() {
  imageMode(CORNER);
  image(racetrack_1, 0, 0);

  textSize(100);
  fill(255);
  text("score: ", height-30, width-30);

  for (int x = 0; x < worldWidth; x += 100) line(x, 0, x, worldHeight);
  for (int y = 0; y < worldHeight; y += 100) line(0, y, worldWidth, y);
}

// ----------------------------------------------------
// ------------------ START SCREEN ---------------------
// ----------------------------------------------------
void drawStart() {
  background(start);

  textAlign(CENTER);
  fill(255);
  textSize(100);
  
  btnStart.display();
  btnSettings.display();
}

// ----------------------------------------------------
// ---------------- SETTINGS SCREEN --------------------
// ----------------------------------------------------
void drawSettings() {
  background(40);

  textAlign(CENTER);
  fill(255);
  textSize(80);
  text("SETTINGS", width/2, 200);

  textSize(40);
  fill(200);
  text("This is a placeholder settings screen.", width/2, 350);

  btnBack.display();
}

// ----------------------------------------------------
// ------------------- INPUT ---------------------------
// ----------------------------------------------------
void mousePressed() {

  switch(screen) {

  case 's':  // START SCREEN
    if (btnStart.clicked()) {
      play = true;
      screen = 'p';
    }

    if (btnSettings.clicked()) {
      screen = 't';
    }
    break;

  case 't':  // SETTINGS SCREEN
    if (btnBack.clicked()) {
      screen = 's';
    }
    break;
  }
}

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
