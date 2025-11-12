//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin
int playerX, playerY, speed, worldWidth, worldHeight;
PImage blue, blue_right, blue_left, blue_down;
PImage currentCar; // Track the car's current direction


void setup() {
  size (1920, 1080);
  background(128, 126, 120);
  speed = 10;
  playerX = 500;
  playerY = 500;
  worldWidth = 2560;
  worldHeight = 1440;
  
  // Images
  blue = loadImage("bluecar.png");
  blue_right = loadImage("bluecar_right.png");
  blue_left = loadImage("bluecar_left.png");
  blue_down = loadImage("bluecar_down.png");
  
  
  // Default facing up
  currentCar = blue;
  
}

void draw() {
  background(128, 126, 120);
  translate(width/2 - playerX, height/2 - playerY);
  imageMode(CENTER);

  // Movement and direction
  if (keyPressed) {
    if (key == 'w' || keyCode == UP) {
      playerY -= speed;
      currentCar = blue; // facing up
    } 
    else if (key == 's' || keyCode == DOWN) {
      playerY += speed;
      currentCar = blue_down;
    } 
    else if (key == 'a' || keyCode == LEFT) {
      playerX -= speed;
      currentCar = blue_left;
    } 
    else if (key == 'd' || keyCode == RIGHT) {
      playerX += speed;
      currentCar = blue_right;
    }
  }

  // Draw the world and player
  drawWorld();
  image(currentCar, playerX, playerY);

  // Keep player within world bounds
  playerX = constrain(playerX, 0, worldWidth);
  playerY = constrain(playerY, 0, worldHeight);
}

void drawWorld() {
  stroke(0, 50);
  for (int x = 0; x < worldWidth; x += 100) {
    line(x, 0, x, worldHeight);
  }
  for (int y = 0; y < worldHeight; y += 100) {
    line(0, y, worldWidth, y);
  }
}
