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
  speed = 20;
  playerX = 500;
  playerY = 500;
  worldWidth = 2250;
  worldHeight = 2000;
  e1 = new Enemy();
  e1 = new Enemy();
  n1 = new PowerUp();
  // Images
  blue = loadImage("bluecar_right.png");     // MUST FACE UP
  racetrack_1 = loadImage("racetrackfinal (1).png");
  racetrack_1.loadPixels();
  nitro = loadImage("Nitro.png");
  start = loadImage("StartScreen.png");
  hornSound = new SoundFile(this, "car-honk.mp3");
  engineSound = new SoundFile(this, "engine.mp3");


  currentCar = blue;
}

void draw() {
  if (!play) {
    drawStart();
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
n1.display
  }
}
//Henry Griffin
void drawPausedScreen() {
  fill(255);
  textAlign(CENTER);
  textSize(150);
  text("PAUSED", width/2, height/2);

  textSize(50);
  text("Press P to Resume", width/2, height/2 + 120);
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
  for (int x = 0; x < worldWidth; x += 100) {
    line(x, 0, x, worldHeight);
  }
  for (int y = 0; y < worldHeight; y += 100) {
    line(0, y, worldWidth, y);
  }

  // 🔹 Draw waypoints (for debugging)
  noStroke();

  for (PVector wp : waypoints) {
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
  if (key == 'h') hornSound.play();
  if(key == 'm') engineSound.stop();
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

void mousePressed() {
  switch(screen) {
  case 's' :
    if (btnStart.clicked()) {
  play = true;
  screen = 'p';
  startTime = millis();  // Start the stopwatch
  timerRunning = true;
}

  }
}
//Kellen Brim Screen
void drawStart() {
  background(start);
  textAlign(CENTER);
  textSize(100);
  btnStart.display();
}

void drawPlay() {
  background(75, 189, 104);
}


void drawTimer() {
  fill(255);        // White text
  textSize(50);
  textAlign(RIGHT, TOP);
  
  int seconds = (elapsedTime / 1000) % 60;
  int minutes = (elapsedTime / 1000) / 60;
  int milliseconds = (elapsedTime % 1000) / 10;
  
  String timeString = nf(minutes, 2) + ":" + nf(seconds, 2) + ":" + nf(milliseconds, 2);
  text(timeString, width/2 + 850, height/2 - 500); // Adjust position on screen
}

void gameOver() {
  // btnRestart.display()
}
