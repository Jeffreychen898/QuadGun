final int BULLET_RANGE = 600;
final int BULLET_SPEED = 600;

class Bullet {
  PVector initialLocation;
  PVector position;
  float angle;
  color col;
  boolean isDead = false;
  Bullet(PVector location, float ang) {
    position = location.copy();
    initialLocation = location.copy();
    angle = ang;
    col = color(255);
  }
  void Render() {
    fill(col);
    ellipse(position.x, position.y, 30, 30);
  }
  void Update() {
    position.x += cos(angle) * BULLET_SPEED * deltaTime;
    position.y += sin(angle) * BULLET_SPEED * deltaTime;
    
    if(dist(position.x, position.y, initialLocation.x, initialLocation.y) > BULLET_RANGE) {
      isDead = true;
    }
  }
}
