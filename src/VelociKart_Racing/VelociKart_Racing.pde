//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin

int playerX, playerY;
int speed, worldWidth, worldHeight;
SoundFile hornSound, engineSound;
char screen = 's';   // s = start, m = menu, t = settings, p = play, u = pause, g = game over, a = app stats
Button btnStart, btnMenu, btnControls, btnBack, btnRestart;
PFont font;
PowerUp nitroPU;
PImage blue, racetrack_1, nitro, start;
PImage currentCar;

boolean play;
boolean engineStarted = false;
boolean gamePaused = false;
int startTime;       // Stores the millis() when the race starts
int elapsedTime = 0; // Elapsed time in milliseconds
boolean timerRunning = false; // Is the timer running?


import processing.sound.*;

Enemy e1;
PowerUp n1;
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

  btnStart    = new Button("PLAY", 650, 830, 600, 100);
  btnMenu    = new Button("MENU", 220, 300, 160, 50);
  btnRestart = new Button("Restart", 220, 150, 160, 50);
nitroPU = new PowerUp();
  nitroPU = new PowerUp();
  speed = 20;
  playerX = 500;
  playerY = 500;
@@ -66,73 +66,73 @@
void draw() {
  if (!play) {
    drawStart();
return;
  } 
if (gamePaused) {
    return;
  }
  if (gamePaused) {
    drawPausedScreen();
    return;
  }
 background(85, 197, 115);
    switch(screen) {
    case 's' :
      drawStart();
      break;
    case 'p' :

      if (screen == 'p' && !engineStarted) {
        engineSound.loop();   // safe to start now
        engineSound.amp(0.4);
        engineStarted = true;
      }
if (timerRunning) {
  elapsedTime = millis() - startTime;
}

      drawPlay();
      break;
    }
  background(85, 197, 115);
  switch(screen) {
  case 's' :
    drawStart();
    break;
  case 'p' :

    // CAMERA CENTER
    translate(width/2 - playerX, height/2 - playerY);

    imageMode(CENTER);
    e1.display();
    e1.update();
    n1.display();
nitroPU.update();
nitroPU.display();
    // -------- TURN ANYTIME --------
    if (aDown) angle -= turnSpeed;
    if (dDown) angle += turnSpeed;

    float rad = radians(angle);

    // -------- MOVE --------
    color c = racetrack_1.pixels[playerY * 2250 + playerX]; // change it so that this iis a class variable
    boolean isGray = (red(c) == green(c) && green(c) == blue(c));

    float nspeed = 1 - .5 * int(!isGray);
    if (wDown) {
      playerX += cos(rad) * speed * nspeed;
      playerY += sin(rad) * speed * nspeed;
    if (screen == 'p' && !engineStarted) {
      engineSound.loop();   // safe to start now
      engineSound.amp(0.4);
      engineStarted = true;
    }
    if (sDown) {
      playerX -= cos(rad) * speed;
      playerY -= sin(rad) * speed;
    if (timerRunning) {
      elapsedTime = millis() - startTime;
    }

    // -------- DRAW WORLD + CAR --------
    drawWorld();
    drawCar();
    drawTimer();

    // WORLD LIMITS
    playerX = constrain(playerX, 0, worldWidth);
    playerY = constrain(playerY, 0, worldHeight);
    e1.display();
    e1.update();
n1.display
    drawPlay();
    break;
  }

  // CAMERA CENTER
  translate(width/2 - playerX, height/2 - playerY);

  imageMode(CENTER);
  e1.display();
  e1.update();
  n1.display();
  nitroPU.update();
  nitroPU.display();
  // -------- TURN ANYTIME --------
  if (aDown) angle -= turnSpeed;
  if (dDown) angle += turnSpeed;

  float rad = radians(angle);

  // -------- MOVE --------
  color c = racetrack_1.pixels[playerY * 2250 + playerX]; // change it so that this iis a class variable
  boolean isGray = (red(c) == green(c) && green(c) == blue(c));

  float nspeed = 1 - .5 * int(!isGray);
  if (wDown) {
    playerX += cos(rad) * speed * nspeed;
    playerY += sin(rad) * speed * nspeed;
  }
  if (sDown) {
    playerX -= cos(rad) * speed;
    playerY -= sin(rad) * speed;
  }

  // -------- DRAW WORLD + CAR --------
  drawWorld();
  drawCar();
  drawTimer();

  // WORLD LIMITS
  playerX = constrain(playerX, 0, worldWidth);
  playerY = constrain(playerY, 0, worldHeight);
  e1.display();
  e1.update();
  nitroPU.update();
  nitroPU.display();
}
//Henry Griffin
void drawPausedScreen() {
@@ -189,8 +189,8 @@
  if (key == 'a' || keyCode == LEFT)  aDown = true;
  if (key == 'd' || keyCode == RIGHT) dDown = true;
  if (key == 'h') hornSound.play();
  if(key == 'm') engineSound.stop();
 if (key == 'p' || key == 'P') {
  if (key == 'm') engineSound.stop();
  if (key == 'p' || key == 'P') {
    gamePaused = !gamePaused;
  }
}
@@ -206,12 +206,11 @@
  switch(screen) {
  case 's' :
    if (btnStart.clicked()) {
  play = true;
  screen = 'p';
  startTime = millis();  // Start the stopwatch
  timerRunning = true;
}

      play = true;
      screen = 'p';
      startTime = millis();  // Start the stopwatch
      timerRunning = true;
    }
  }
}
//Kellen Brim Screen
@@ -231,11 +230,11 @@
  fill(255);        // White text
  textSize(50);
  textAlign(RIGHT, TOP);
  

  int seconds = (elapsedTime / 1000) % 60;
  int minutes = (elapsedTime / 1000) / 60;
  int milliseconds = (elapsedTime % 1000) / 10;
  

  String timeString = nf(minutes, 2) + ":" + nf(seconds, 2) + ":" + nf(milliseconds, 2);
  text(timeString, width/2 + 850, height/2 - 500); // Adjust position on screen
}
