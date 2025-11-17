//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin

int playerX, playerY;
int speed, worldWidth, worldHeight;
char screen = 's';   // s = start, m = menu, t = settings, p = play, u = pause, g = game over, a = app stats
Button btnStart, btnMenu, btnSettings, btnBack;

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

  btnStart    = new Button("PLAY", 220, 150, 160, 50);
  btnMenu    = new Button("MENU", 220, 300, 160, 50);

  speed = 10;
  playerX = 500;
  playerY = 500;
  worldWidth = 2250;
  worldHeight = 2000;

  e1 = new Enemy();

  // Images
  blue = loadImage("bluecar_right.png");     // MUST FACE UP
  racetrack_1 = loadImage("racetrackfinal (1).png");
  nitro = loadImage("Nitro.png");
  start = loadImage("StartScreen.png");

  currentCar = blue;
}

void draw() {
  if (!play) {
    drawStart();
  } else {
    background(85, 197, 115);

    switch(screen) {
    case 's' :
      drawStart();
      break;
    case 'p' :
      drawPlay();
      break;
    }

    // CAMERA CENTER
    translate(width/2 - playerX, height/2 - playerY);

    imageMode(CENTER);
    e1.display();

    // -------- TURN ANYTIME --------
    if (aDown) angle -= turnSpeed;
    if (dDown) angle += turnSpeed;

    float rad = radians(angle);

    // -------- MOVE --------
    if (wDown) {
      playerX += cos(rad) * speed;
      playerY += sin(rad) * speed;
    }
    if (sDown) {
      playerX -= cos(rad) * speed;
      playerY -= sin(rad) * speed;
    }

    // -------- DRAW WORLD + CAR --------
    drawWorld();
    drawCar();

    // WORLD LIMITS
    playerX = constrain(playerX, 0, worldWidth);
    playerY = constrain(playerY, 0, worldHeight);
  }
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

//void startScreen() {
//  imageMode(CENTER);
//  background(start);
//  fill(255);
//  if (mousePressed) {
//    play = true;
//  }
//}

// ------------------- KEY INPUT HANDLERS -------------------

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

void mousePressed() {
  switch(screen) {
  case 's' :
    if (btnStart.clicked()) {
      play = true;
      screen = 'p';
    }
  }
}

void drawStart() {
  background(start);
  textAlign(CENTER);
  textSize(100);
  btnStart.display();
}

void drawPlay() {
  background(85, 197, 115);
  //text("PLAY SCREEN (fill this in)", 200, 200);
}
