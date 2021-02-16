class Player {
  PVector location;
  PVector velocity;
  ArrayList<Bullet> bullets;
  Player() {
    location = new PVector(400, 450);
    velocity = new PVector(0, 0);
    bullets = new ArrayList<Bullet>();
  }
  void Render() {
    //render bullet
    for(Bullet bullet : bullets) {
      bullet.Render();
    }
    //render player
    //fill(255, 0, 0);
    //ellipse(location.x, location.y, 50, 50);
    fill(255, 0, 0);
    shape(playerImg, location.x - 25, location.y - 25, 50, 50);
  }
  void Update() {
    location.x += velocity.x * deltaTime;
    location.y += velocity.y * deltaTime;
    location.x %= width;
    location.y %= height;
    if(location.x < 0) {
      location.x = width;
    }
    if(location.y < 0) {
      location.y = height;
    }
    
    for(int i=0;i<bullets.size();i++) {
      if(bullets.get(i).isDead) {
        bullets.remove(i);
        i --;
        continue;
      }
      bullets.get(i).Update();
      
      for(int j=0;j<enemyList.size();j++) {
        float distToEnemy = dist(enemyList.get(j).position.x, enemyList.get(j).position.y, bullets.get(i).position.x, bullets.get(i).position.y);
        if(distToEnemy < 40) {
          enemyList.get(j).TakeDamage(25);
          bullets.remove(i);
          i --;
          break;
        }
      }
    }
  }
  void shootQuadBullet() {
    float ang = pointToMouse(location.x, location.y);
    bullets.add(new Bullet(location, ang));
    bullets.add(new Bullet(location, ang + PI / 2.f));
    bullets.add(new Bullet(location, ang + PI));
    bullets.add(new Bullet(location, ang + 3.f * (PI / 2.f)));
  }
  void bulletSpray() {
    float ang = pointToMouse(location.x, location.y) - PI / 2.f;
    for(int i=0;i<12;i++) {
      bullets.add(new Bullet(location, ang + 0.26 * i));
    }
  }
  float pointToMouse(float pointX, float pointY) {
    return atan2(mouseY - pointY, mouseX - pointX);
  }
  void keyPress(char c) {
    playerMovements(c, 300);
  }
  void keyRelease(char c) {
    playerMovements(c, -300);
  }
  void playerMovements(char c, float speed) {
    switch(c) {
      case 'w':
      velocity.y -= speed;
      break;
      case 'a':
      velocity.x -= speed;
      break;
      case 's':
      velocity.y += speed;
      break;
      case 'd':
      velocity.x += speed;
      break;
    }
  }
}
