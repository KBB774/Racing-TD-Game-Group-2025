class Player {

  // --- position + movement ---
  float x, y;
  float angle = 0;
  float turnSpeed = 4;
  float speed = 20;

  // --- key states ---
  boolean wDown, sDown, aDown, dDown;

  // --- images & sounds ---
  PImage carImg;
  SoundFile hornSound;
  SoundFile engineSound;
  boolean engineStarted = false;

  // --- timer ---
  int startTime;
  int elapsedTime;
  boolean timerRunning = false;

  Player(float startX, float startY, PImage img, SoundFile horn, SoundFile engine) {
    x = startX;
    y = startY;
    carImg = img;
    hornSound = horn;
    engineSound = engine;
  }

  // -----------------------------
  // UPDATE MOVEMENT
  // -----------------------------
  void update() {

    // TURNING
    if (aDown) angle -= turnSpeed;
    if (dDown) angle += turnSpeed;

    float rad = radians(angle);

    // SPEED REDUCTION ON GRASS
    color c = racetrack_1.pixels[(int)y * worldWidth + (int)x];
    boolean isGray = (red(c) == green(c) && green(c) == blue(c));
    float nspeed = 1 - .5 * int(!isGray);

    // FORWARD
    if (wDown) {
      x += cos(rad) * speed * nspeed;
      y += sin(rad) * speed * nspeed;
    }

    // BACKWARD
    if (sDown) {
      x -= cos(rad) * speed;
      y -= sin(rad) * speed;
    }

    // KEEP WITHIN WORLD
    x = constrain(x, 0, worldWidth);
    y = constrain(y, 0, worldHeight);

    // TIMER UPDATE
    if (timerRunning) {
      elapsedTime = millis() - startTime;
    }
  }

  // -----------------------------
  // DRAW CAR
  // -----------------------------
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    imageMode(CENTER);
    image(carImg, 0, 0);
    popMatrix();
  }

  // -----------------------------
  // TIMER DRAW
  // -----------------------------
  void drawTimer() {
    fill(255);
    textSize(100);
    textAlign(RIGHT, TOP);

    int seconds = (elapsedTime / 1000) % 60;
    int minutes = (elapsedTime / 1000) / 60;
    int milliseconds = (elapsedTime % 1000) / 10;

    String timeString = nf(minutes, 2) + ":" + nf(seconds, 2) + ":" + nf(milliseconds, 2);
    text(timeString, 1450, 1140);
  }

  // -----------------------------
  // SOUND CONTROLS
  // -----------------------------
  void startEngine() {
    if (!engineStarted) {
      engineSound.loop();
      engineSound.amp(0.4);
      engineStarted = true;
    }
  }

  void honk() {
    hornSound.play();
  }

  // -----------------------------
  // KEY INPUT
  // -----------------------------
  void keyDown(char k, int kCode) {
    if (k == 'w' || kCode == UP) wDown = true;
    if (k == 's' || kCode == DOWN) sDown = true;
    if (k == 'a' || kCode == LEFT) aDown = true;
    if (k == 'd' || kCode == RIGHT) dDown = true;

    if (k == 'h') honk();
  }

  void keyUp(char k, int kCode) {
    if (k == 'w' || kCode == UP) wDown = false;
    if (k == 's' || kCode == DOWN) sDown = false;
    if (k == 'a' || kCode == LEFT) aDown = false;
    if (k == 'd' || kCode == RIGHT) dDown = false;
  }
}
