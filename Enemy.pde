class Enemy {
  PVector position;
  float cooldown;
  ArrayList<Bullet> bullets;
  float hp = 100;
  boolean isDead;
  Enemy(PVector location) {
    position = location.copy();
    bullets = new ArrayList<Bullet>();
    cooldown = 1;
    isDead = false;
  }
  void Render() {
    for(Bullet bullet : bullets) {
      bullet.Render();
    }
    
    fill(0, 255, 255);
    ellipse(position.x, position.y, 50, 50);
    
    fill(0);
    rect(position.x - 25, position.y + 40, 50, 10);
    fill(0, 255, 0);
    rect(position.x - 25, position.y + 40, hp / 2.f, 10);
  }
  void TakeDamage(float amount) {
    hp -= amount;
    if(hp < 0) {
      isDead = true;
    }
  }
  int getTile() {
    return map[(int)(position.y / 50)][(int)(position.x / 50)];
  }
  void Update() {
    for(int i=0;i<bullets.size();i++) {
      float distance = dist(bullets.get(i).position.x, bullets.get(i).position.y, player.location.x, player.location.y);
      if(distance < 40) {
        bullets.remove(i);
        i --;
      }
    }
    
    if(getTile() == 1) {
      hp -= 25 * deltaTime;
      if(hp < 0) {
        isDead = true;
      }
    }
    
    cooldown -= deltaTime;
    float angToPlayer = atan2(player.location.y - position.y, player.location.x - position.x);
    position.x += cos(angToPlayer) * 50 * deltaTime;
    position.y += sin(angToPlayer) * 50 * deltaTime;
    
    if(cooldown < 0) {
      Bullet newBullet = new Bullet(position, angToPlayer);
      newBullet.col = color(255, 255, 0);
      bullets.add(newBullet);
      cooldown = 1;
    }
    
    for(int i=0;i<bullets.size();i++) {
      bullets.get(i).Update();
      
      if(bullets.get(i).isDead) {
        bullets.remove(i);
        i --;
      }
    }
  }
}
