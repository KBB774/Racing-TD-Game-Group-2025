//Zac Hawkins and Henry Griffin
class PowerUp {
  float x, y;
  boolean active = true;
  float size = 80;

  // Boost timing
  boolean boosting = false;
  int boostEndTime = 0;

  PowerUp() {
    respawn();
  }

  void respawn() {
    x = random(200, worldWidth - 200);
    y = random(200, worldHeight - 200);
    active = true;
  }

  void update() {

    // If currently boosting, check if boost ended
    if (boosting && millis() > boostEndTime) {
      speed -= 10;      // remove boost
      boosting = false;
    }

    if (!active) return;

    float d = dist(playerX, playerY, x, y);

    if (d < size) {
      giveBoost();
      active = false;

      // Respawn after 3 seconds — NON-BLOCKING timer
      boostEndTime = millis() + 3000;
      newRespawnTime = millis() + 3000;
    }

    // Handle respawn without freezing
    if (!active && millis() > newRespawnTime) {
      respawn();
    }
  }

  int newRespawnTime = 0;

  void giveBoost() {
    speed += 10;
    boosting = true;

    // boost lasts 1.5 sec
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
