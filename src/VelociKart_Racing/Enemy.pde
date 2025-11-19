// Henry Griffin
class Enemy {
  PVector pos, vel;
  int currentTarget = waypoints.length - 1;
  float speed = 4;
  float turnSpeed = 1;
  PImage enemy;

  Enemy() {
    enemy = loadImage("PixelCarRED.png");
    pos = new PVector(300, 900);  // starting point
    vel = new PVector(1, 0);      // initial direction
  }

  void update() {
    PVector target = waypoints[currentTarget];  //  uses global waypoints
    PVector desired = PVector.sub(target, pos);
    float d = desired.mag();

    desired.normalize();
    desired.mult(speed);

    PVector steer = PVector.sub(desired, vel);
    steer.limit(turnSpeed);
    vel.add(steer);
    pos.add(vel);

    if (d < 40) {
      currentTarget--;
      if (currentTarget < 0) {
        currentTarget = waypoints.length - 1; // loop around
      }
    }
  }

  void display() {
    update();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading() + HALF_PI);
    enemy.resize(103,169);
    imageMode(CENTER);
    image(enemy, 0, 0);
    popMatrix();
  }
}
