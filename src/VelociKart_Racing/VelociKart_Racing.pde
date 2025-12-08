//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin

int playerX, playerY;
int speed, worldWidth, worldHeight;
SoundFile hornSound, engineSound;
char screen = 's';   // s = start, m = menu, t = settings, p = play, u = pause, g = game over, a = app stats
Button btnStart, btnMenu, btnSettings, btnBack, btnRestart, btnPause;
PFont font;
PowerUp nitroPU;
PImage blue, racetrack_1, nitro, start, over;
PImage currentCar;
Player player;
boolean play;
boolean isGameOver = false;

Lap_Counter lapZone;


// PAUSE SUPPORT
boolean gamePaused = false;

import processing.sound.*;

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
  background(75, 189, 104);
  font = createFont("RasterForgeRegular-JpBgm.ttf", 30);
  textFont(font);

  btnStart    = new Button("PLAY", 660, 830, 600, 100);
  btnMenu    = new Button("MENU", 220, 300, 160, 50);
  btnRestart = new Button("Restart", 220, 150, 160, 50);
  lapZone = new Lap_Counter(70, 890, 400, 40); // x, y, w, h
  lapZone.visible = true; // Set to false to make invisible
  nitroPU = new PowerUp(1);
nitroPU = new PowerUp(2);
  speed = 20;
  playerX = 500;
  playerY = 500;
  worldWidth = 2250;
  worldHeight = 2000;
  e1 = new Enemy();

  blue = loadImage("bluecar_right.png");
  racetrack_1 = loadImage("racetrackfinal (1).png");
  racetrack_1.loadPixels();
  nitro = loadImage("Nitro.png");
  start = loadImage("StartScreen.png");
  over = loadImage("Game_Over.png");
  hornSound = new SoundFile(this, "car-honk.mp3");
  engineSound = new SoundFile(this, "engine.mp3");
  player = new Player(playerX, playerY, currentCar, hornSound, null); 
// replace 'null' with engineSound if you have it


  currentCar = blue;
}

void draw() {

  if (!play) {
    drawStart();
    return;
  }

  // ======== PAUSED — STOP EVERYTHING EXCEPT OVERLAY ========
  if (gamePaused) {
    drawPausedScreen();
    return;
  }
  // =========================================================

  background(85, 197, 115);

  switch(screen) {
  case 's' :
    drawStart();
    break;
  case 'p' :
    drawPlay();
    break;
  }
  if (lapZone.intersects(player)) {
    println("Player touched lap area!");
  }
   lapZone.update(playerX, playerY);


  // CAMERA CENTER
  translate(width/2 - playerX, height/2 - playerY);

  imageMode(CENTER);
 


  // TURNING
  if (aDown) angle -= turnSpeed;
  if (dDown) angle += turnSpeed;

  float rad = radians(angle);

  // TRACK COLOR CHECK
  color c = racetrack_1.pixels[playerY * 2250 + playerX];
  boolean isGray = (red(c) == green(c) && green(c) == blue(c));
  float nspeed = 1 - .5 * int(!isGray);

  // MOVEMENT
  if (wDown) {
    playerX += cos(rad) * speed * nspeed;
    playerY += sin(rad) * speed * nspeed;
  }
  if (sDown) {
    playerX -= cos(rad) * speed;
    playerY -= sin(rad) * speed;
  }

  drawWorld();
  lapZone.display();
  drawCar();
  e1.display();
  e1.update();
  nitroPU.update();
  nitroPU.display();
  nitro.resize(100,100);

  // WORLD LIMITS
  playerX = constrain(playerX, 0, worldWidth);
  playerY = constrain(playerY, 0, worldHeight);

fill(255,10,10);
strokeWeight(5);
ellipse(playerX -300, playerY - 400, 400, 150);
  fill(255);
textSize(65);
text("Laps: " + lapZone.laps, playerX - 300, playerY - 400);

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
  if(lapZone.laps > 10){
    gameOver();
  }
}

//PauseScreen Henry Griffin and help with ai
void drawPausedScreen() {
  fill(255);
  textAlign(CENTER);
  textSize(150);
  text("PAUSED", width/2, height/2);

  textSize(50);
  text("Press P to Resume", width/2, height/2 + 120);
}

// ------------------- KEY INPUT HANDLERS -------------------
void keyPressed() {
  if (key == 'w' || keyCode == UP)    wDown = true;
  if (key == 's' || keyCode == DOWN)  sDown = true;
  if (key == 'a' || keyCode == LEFT)  aDown = true;
  if (key == 'd' || keyCode == RIGHT) dDown = true;

  if (key == 'h') hornSound.play();

  // ======== PRESS P → PAUSE / RESUME ========
  if (key == 'p' || key == 'P') {
    gamePaused = !gamePaused;
  }
}

void keyReleased() {
  if (key == 'w' || keyCode == UP)    wDown = false;
  if (key == 's' || keyCode == DOWN)  sDown = false;
  if (key == 'a' || keyCode == LEFT)  aDown = false;
  if (key == 'd' || keyCode == RIGHT) dDown = false;
}



void drawStart() {
  background(start);
  btnStart.display();
}

void mousePressed() {
  if (screen == 's') {
    if (btnStart.clicked()) {
      play = true;
      screen = 'p';
    }
  }
}

void drawPlay() {
  background(75, 189, 104);
}

void gameOver() {
  fill(255);
 textSize(36);
  text("Time: " + lapZone.laps, width/2, height/3);
  image(over, playerX-960, playerY-560);
  noLoop();

}
