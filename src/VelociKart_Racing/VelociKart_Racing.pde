//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin
int playerX, playerY, speed, worldWidth, worldHeight;
PImage blue, blue_right, blue_left, blue_down, racetrack_1;
PImage currentCar; // Track the car's current direction


void setup() {
  size (1920, 1080);
  background(128, 126, 120);
  speed = 10;
  playerX = 500;
  playerY = 500;
  worldWidth = 2250;
  worldHeight = 2000;
  
  // Images
  blue = loadImage("bluecar.png");
  blue_right = loadImage("bluecar_right.png");
  blue_left = loadImage("bluecar_left.png");
  blue_down = loadImage("bluecar_down.png");
  racetrack_1 = loadImage("racetrackfinal (1).png");
  
  
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
  playerX = constrain(playerX, 0, 2250);
  playerY = constrain(playerY, 0, 2000);
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
}
