Player player;

PImage mapImage;

void setup() {
  size(1920, 1080);
  
  // Load map image (place racetrackfinal.png in the "data" folder)
  mapImage = loadImage("racetrackfinal.png");
  
  // Create player with constraints based on map size
  player = new Player(500, 500, mapImage.width, mapImage.height);
  
  
  
  
}

void draw() {
  background(50);

  // Update player position (movement handled elsewhere)
  player.update();

 

 
  // Draw map
  image(mapImage, 0, 0);

  // Draw player
  player.display();


}

// ---------------- CLASSES ---------------- //

class Player {
  float x, y;
  float size = 40;

  // Map boundaries
  float minX, maxX, minY, maxY;

  Player(float startX, float startY, float mapWidth, float mapHeight) {
    x = startX;
    y = startY;

    // Define boundaries so player doesn't leave map
    minX = size / 2;
    maxX = mapWidth - size / 2;
    minY = size / 2;
    maxY = mapHeight - size / 2;
  }

  void update() {
    // Movement handled elsewhere
    // Clamp player inside boundaries
    x = constrain(x, minX, maxX);
    y = constrain(y, minY, maxY);
  }

  void display() {
    fill(255, 50, 50);
    noStroke();
    ellipse(x, y, size, size);
  }
}



  
  
  void follow(float targetX, float targetY) {
   

   
  }


 

  void end() {
    popMatrix();
  }

  
  
