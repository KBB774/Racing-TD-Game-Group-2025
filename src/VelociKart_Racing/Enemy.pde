//Henry Griffin
class Enemy {
  int x, y, w;
  PImage enemy;
  //Constructor
  Enemy() {
    enemy = loadImage("PixelCarRED.png");
  }

  //Member Variables
  void display() {
    imageMode(CENTER);
    image(enemy, x, y);
    enemy.resize(103,169);
  }
}
//Member Methods
