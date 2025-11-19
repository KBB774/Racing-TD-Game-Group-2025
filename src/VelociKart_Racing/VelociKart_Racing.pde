//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin

int playerX, playerY;
int speed, worldWidth, worldHeight;
char screen = 's';   // s = start, m = menu, t = settings, p = play, u = pause, g = game over, a = app stats
Button btnStart, btnMenu, btnSettings, btnBack, btnRestart;
PFont font;

PImage blue, racetrack_1, nitro, start;
PImage currentCar;

boolean play;

import gifAnimation.*;
Gif title;
Enemy e1;
PVector[] waypoints = {
  new PVector(160, 990),
  new PVector (500, 1400),
  new PVector (780, 1720),
  new PVector (1210, 1550),
  new PVector(1460, 1440),
  new PVector (1850, 1420),
  new PVector(1990, 1100),
  new PVector(1900, 670),
  new PVector(1290, 720),
  new PVector(1060, 410),
  new PVector(640, 270),
  new PVector(350, 300),
  new PVector(200, 610),
  new PVector(220, 850)
};
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

  btnStart    = new Button("PLAY", 460, 830, 600, 100);
  btnMenu    = new Button("MENU", 220, 300, 160, 50);
  btnRestart = new Button("Restart", 220, 150, 160, 50);

  speed = 15;
  playerX = 500;
  playerY = 500;
  worldWidth = 2250;
  worldHeight = 2000;
  e1 = new Enemy();
  e1 = new Enemy();
  //n1 = new PowerUp();
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
    e1.update();
    //n1 = new PowerUp();
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
    e1.display();
    e1.update();
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
  image(racetrack_1,0,0);
  for (int x = 0; x < worldWidth; x += 100) {
    line(x, 0, x, worldHeight);
  }
  for (int y = 0; y < worldHeight; y += 100) {
    line(0, y, worldWidth, y);
  }

  // 🔹 Draw waypoints (for debugging)
  noStroke();
  fill(255, 0, 0);
  for (PVector wp : waypoints) {
    ellipse(wp.x, wp.y, 12, 12);
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
  background(75, 189, 104);
  //text("PLAY SCREEN (fill this in)", 200, 200);
}
void gameOver() {
  // btnRestart.display()
}
