//Zac Hawkins
class PowerUp {
  float x, y;
  boolean active = true;
  float size = 80;

  boolean boosting = false;
  int boostEndTime = 0;
  int newRespawnTime = 0;

  // Define track points
  PVector[] trackPoints = {
    new PVector(160, 990),
    new PVector(500, 1400),
    new PVector(780, 1720),
    new PVector(1210, 1550),
    new PVector(1460, 1440),
    new PVector(1850, 1420),
    new PVector(1990, 1100),
    new PVector(1900, 670),
    new PVector(1290, 720),
    new PVector(1060, 410),
    new PVector(640, 270),
    new PVector(350, 300),
    new PVector(200, 610),
    new PVector(220, 850)
  };

  PowerUp() {
    respawn();
  }

  // Respawn on a random track point
  void respawn() {
    PVector p = trackPoints[int(random(trackPoints.length))];
    x = p.x;
    y = p.y;
    active = true;
  }

  void update() {
    // Check if boost ended
    if (boosting && millis() > boostEndTime) {
      speed -= 10;
      boosting = false;
    }

    // Handle respawn timer
    if (!active && millis() > newRespawnTime) {
      respawn();
    }

    if (!active) return;

    // Check collision with player
    float d = dist(playerX, playerY, x, y);
    if (d < size) {
      giveBoost();
      active = false;
      newRespawnTime = millis() + 3000;
    }
  }

  void giveBoost() {
    speed += 10;
    boosting = true;
    boostEndTime = millis() + 1500;
  }

  void display() {
    if (!active) return;

    pushMatrix();
    translate(x, y);
    imageMode(CENTER);
    image(nitro, 0, 0);
    popMatrix();
  }
}
