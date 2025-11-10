//Kellen Brim, Mark Connell, Zac Hawkins, Henry Griffin
int playerX, playerY, speed, worldWidth, worldHeight;
PImage blue, blue_right, blue_left, blue_down;

void setup() {
  size (1920, 1080);
  background(128, 126, 120);
  speed = 5;
  playerX = 500;
  playerY = 500;
  worldWidth = 2560;
  worldHeight = 1440;
  blue = loadImage("bluecar.png");
  blue_right = loadImage("bluecar_right.png");
   blue_left = loadImage("bluecar_left.png");
   blue_down = loadImage("bluecar_down.png");
}

void draw() {
  background(128, 126, 120);


  translate(width/2 - playerX, height/2 - playerY);
  imageMode(CENTER);

  if (keyPressed) {
    if (key == 'w' || keyCode == UP) playerY -= speed;
     if (key == 'w' || keyCode == UP) image(blue, playerX, playerY);
    if (key == 's' || keyCode == DOWN) playerY += speed;
    if (key == 's' || keyCode == DOWN) image(blue_down, playerX, playerY);
    if (key == 'a' || keyCode == LEFT) playerX -= speed;
    if (key == 'a' || keyCode == LEFT) image(blue_left, playerX, playerY);
    if (key == 'd' || keyCode == RIGHT) playerX += speed;
   if (key == 'd' || keyCode == RIGHT) image(blue_right, playerX, playerY);
   if (key == 'd' || keyCode == RIGHT);
  
    
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
