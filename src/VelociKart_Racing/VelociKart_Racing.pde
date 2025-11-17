//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin

int playerX, playerY;
int speed, worldWidth, worldHeight;

PImage blue, racetrack_1, nitro, start;
PImage currentCar;

// NEW
PImage settingsPlaceholder;
boolean play = false;
boolean settingsMode = false;

import gifAnimation.*;
Gif title;
Enemy e1;

// ROTATION + SMOOTH TURN SUPPORT
float angle = 0;
float turnSpeed = 4;

// Key states
boolean wDown = false;
boolean sDown = false;
boolean aDown = false;
boolean dDown = false;

void setup() {
  size(1920, 1080, P2D);
  background(85, 197, 115);
 
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

  // NEW placeholder settings image
  settingsPlaceholder = loadImage("settings_placeholder.png");

  currentCar = blue;
}

void draw() {
  if (!play && !settingsMode) {
    startScreen();
  } else if (settingsMode) {
    settingsScreen();
  } else {
    gameScreen();
  }
}

// -----------------------------------------------
// GAME SCREEN
// -----------------------------------------------
void gameScreen() {
  background(85, 197, 115);

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

  for (int x = 0; x < worldWidth; x += 100) {
    line(x, 0, x, worldHeight);
  }
  for (int y = 0; y < worldHeight; y += 100) {
    line(0, y, worldWidth, y);
  }
}

// -----------------------------------------------
// START SCREEN + SETTINGS BUTTON
// -----------------------------------------------
void startScreen() {
  imageMode(CENTER);
  background(start);

  rectMode(CENTER);
  textAlign(CENTER);
  textSize(50);

  // PLAY BUTTON
  fill(0, 150);
  rect(width/2, height/2 + 150, 300, 100);
  fill(255);
  text("PLAY", width/2, height/2 + 165);

  // SETTINGS BUTTON
  fill(0, 150);
  rect(width/2, height/2 + 300, 300, 100);
  fill(255);
  text("SETTINGS", width/2, height/2 + 315);

  if (mousePressed) {
    // PLAY BUTTON
    if (mouseY > height/2 + 100 && mouseY < height/2 + 200) {
      play = true;
    }
    // SETTINGS BUTTON
    if (mouseY > height/2 + 250 && mouseY < height/2 + 350) {
      settingsMode = true;
    }
  }
}

// -----------------------------------------------
// SETTINGS SCREEN
// -----------------------------------------------
void settingsScreen() {
  background(50);

  imageMode(CENTER);
  image(settingsPlaceholder, width/2, height/2);

  // BACK BUTTON
  rectMode(CENTER);
  fill(0, 150);
  rect(150, 80, 200, 80);
  fill(255);
  textSize(40);
  textAlign(CENTER);
  text("BACK", 150, 95);

  if (mousePressed) {
    if (mouseX < 250 && mouseY < 140) {
      settingsMode = false;
    }
  }
}

// -----------------------------------------------
// KEY INPUT
// -----------------------------------------------
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
