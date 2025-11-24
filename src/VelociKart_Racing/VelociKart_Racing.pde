// Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin

import processing.sound.*;

Player player;
Enemy e1;

int worldWidth = 2250;
int worldHeight = 2000;
Lap_Counter lapZone;

PImage blue, racetrack_1, nitro, start;
PImage currentCar;

boolean play = false;

char screen = 's'; // s = start, p = play

Button btnStart;
PFont font;

void setup() {
  size(1920, 1080, P2D);
  background(75, 189, 104);

  font = createFont("RasterForgeRegular-JpBgm.ttf", 30);
  textFont(font);

  btnStart = new Button("PLAY", 650, 830, 600, 100);
  lapZone = new Lap_Counter(70, 890, 400, 40); // x, y, w, h
lapZone.visible = true; // Set to false to make invisible

  // Images
  blue = loadImage("bluecar_right.png");
  currentCar = blue;

  racetrack_1 = loadImage("racetrackfinal (1).png");
  racetrack_1.loadPixels();

  nitro = loadImage("Nitro.png");
  start = loadImage("StartScreen.png");

  SoundFile hornSound = new SoundFile(this, "car-honk.mp3");
  SoundFile engineSound = new SoundFile(this, "engine.mp3");

  // Create the player
  player = new Player(500, 500, currentCar, hornSound, engineSound);

  // Enemy
  e1 = new Enemy();
}

void draw() {
  if (!play || screen == 's') {
    drawStart();
    return;
  }

  if (screen == 'p') {
    background(85, 197, 115);

    player.startEngine();  // Start engine once

if (lapZone.intersects(player)) {
    println("Player touched lap area!");
}



    // CAMERA CENTER
    translate(width/2 - player.x, height/2 - player.y);
    
    lapZone.update(player);


    // Update + display enemy
    e1.update();
    e1.display();

    // Player update & display
    player.update();
   

    drawWorld();
    lapZone.display();
    player.display();
    player.drawTimer();
  }
  fill(255);
textSize(60);
text("Laps: " + lapZone.laps, player.x - 300, player.y - 400);

}

// ------------------- WORLD DRAWING -------------------

void drawWorld() {
  imageMode(CORNER);
  image(racetrack_1, 0, 0);

  // Debug world grid (optional)
  stroke(255, 40);
  for (int x = 0; x < worldWidth; x += 100) {
    line(x, 0, x, worldHeight);
  }
  for (int y = 0; y < worldHeight; y += 100) {
    line(0, y, worldWidth, y);
  }

  noStroke();
}

// ------------------- START SCREEN -------------------

void drawStart() {
  background(start);
  btnStart.display();
}

void mousePressed() {
  if (screen == 's') {
    if (btnStart.clicked()) {
      play = true;
      screen = 'p';
      player.timerRunning = true;
      player.startTime = millis();
    }
  }
}

// ------------------- INPUT -------------------

void keyPressed() {
  player.keyDown(key, keyCode);

  if (key == 'm') {
    player.engineSound.stop();
  }
}

void keyReleased() {
  player.keyUp(key, keyCode);
}
