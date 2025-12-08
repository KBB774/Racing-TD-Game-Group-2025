class Lap_Counter {
  //Created by Kellen Brim
  float x, y, w, h;      
  boolean visible = false;

  int laps = 0;             
  boolean playerInZone = false; 

  Lap_Counter(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  // Collision detection
  boolean intersects(Player p) {
    return (
      p.x > x && 
      p.x < x + w &&
      p.y > y && 
      p.y < y + h
    );
  }

  // Call every frame from draw()
 void update(float px, float py) {
  boolean currentlyInZone = intersects(px, py);

  if (currentlyInZone && !playerInZone) {
    laps++;
    println("Lap completed! Total laps: " + laps);
  }

  playerInZone = currentlyInZone;
}

boolean intersects(float px, float py) {
  return (px > x && px < x + w && py > y && py < y + h);
}


  // Debug draw
  void display() {
    if (visible) {
      noFill();
      stroke(255, 255, 255);
      strokeWeight(3);
      rect(x, y, w, h);
    }
  }
}
