Player player;
Camera camera;
PImage mapImage;

void setup() {
  size(1920, 1080);
  
  // Load map image (place racetrackfinal.png in the "data" folder)
  mapImage = loadImage("racetrackfinal.png");
  
  // Create player with constraints based on map size
  player = new Player(500, 500, mapImage.width, mapImage.height);
  
  // Create camera
  camera = new Camera(mapImage.width, mapImage.height);
  
  // Optional: set initial zoom
  camera.setZoom(3.0); // 2x zoom
}

void draw() {
  background(50);

  // Update player position (movement handled elsewhere)
  player.update();

  // Make camera follow the player
  camera.follow(player.x, player.y);

  // Apply camera transform
  camera.begin();

  // Draw map
  image(mapImage, 0, 0);

  // Draw player
  player.display();

  // End camera transform
  camera.end();
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

class Camera {
  float camX, camY;
  float zoom = 1.0; // 1.0 = normal, >1 = zoom in, <1 = zoom out
  float mapWidth, mapHeight;

  Camera(float mapWidth, float mapHeight) {
    this.mapWidth = mapWidth;
    this.mapHeight = mapHeight;
  }

  void follow(float targetX, float targetY) {
    // Center camera on player
    camX = targetX - width / 2 / zoom;
    camY = targetY - height / 2 / zoom;

    // Clamp camera so it doesn't show outside map edges
    camX = constrain(camX, 0, mapWidth - width / zoom);
    camY = constrain(camY, 0, mapHeight - height / zoom);
  }

  void begin() {
    pushMatrix();
    translate(-camX, -camY);
    scale(zoom);
  }

  void end() {
    popMatrix();
  }

  void setZoom(float z) {
    zoom = max(0.1, z); // prevent zero or negative zoom
  }
}
