//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin
int playerX, playerY, speed, worldWidth, worldHeight;
PImage blue;

void setup() {
  size (1920, 1080);
  background(150, 400, 800);
  speed = 5;
  playerX = 500;
  playerY = 500;
  worldWidth = 2560;
  worldHeight = 1440;
  blue = loadImage("bluecar.png");
}

void draw() {
  background(150, 400, 800);


  translate(width/2 - playerX, height/2 - playerY);
  image(blue,playerX,playerY);
  
   if (keyPressed) {
    if (key == 'w' || keyCode == UP) playerY -= speed;
    if (key == 's' || keyCode == DOWN) playerY += speed;
    if (key == 'a' || keyCode == LEFT) playerX -= speed;
    if (key == 'd' || keyCode == RIGHT) playerX += speed;
  }

  drawWorld();

  playerX = constrain(playerX, 0, worldWidth);
  playerY = constrain(playerY, 0, worldHeight);
}


void drawWorld() {
  // Simple visual grid for the world
  stroke(0, 50);
  for (int x = 0; x < worldWidth; x += 100) {
    line(x, 0, x, worldHeight);
  }
  for (int y = 0; y < worldHeight; y += 100) {
    line(0, y, worldWidth, y);
  }
}
