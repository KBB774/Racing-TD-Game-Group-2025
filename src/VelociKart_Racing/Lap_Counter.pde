class Lap_Counter {
  float x, y, w, h;      
  boolean visible = false;

  int laps = 0;        // total laps counted
  boolean active = true; // prevents multiple counts
  int cooldown = 3000;   // ms before it can count again
  int lastTriggerTime = -1000;

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
  void update(Player p) {
    // Has enough time passed to re-activate?
    if (millis() - lastTriggerTime > cooldown) {
      active = true;
    }

    // If player touches the rectangle AND it's active
    if (active && intersects(p)) {
      laps++;
      println("Lap: " + laps);
      active = false;                   // disable until cooldown
      lastTriggerTime = millis();       // start cooldown timer
    }
  }

  // Debug draw
  void display() {
    if (visible) {
      noFill();
      stroke(255);
      strokeWeight(3);
      rect(x, y, w, h);
    }
  }
}
