// -------------------------------------------
// BUTTON CLASS
// -------------------------------------------
class Button {
  String label;
  float x, y, w, h;

  Button(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    fill(255,0,0);
    stroke(0);
    rect(x, y, w, h+10, 100);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);
    text(label, x + w/2, y + h/2);
  }

  boolean clicked() {
    return (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h);
  }
}
