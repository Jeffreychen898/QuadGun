int map[][] = {
  {1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
  {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0},
  {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1},
};
PImage tilesImage[] = new PImage[2];
Player player;
float deltaTime;
ArrayList<Enemy> enemyList = new ArrayList<Enemy>();

PShape playerImg;
void setup() {
  size(800, 600, P2D);
  tilesImage[0] = loadImage("floor.png");
  tilesImage[1] = loadImage("lava.png");
  playerImg = loadShape("player.svg");
  player = new Player();
}
void draw() {
  deltaTime = 1.f / frameRate;
  
  player.Update();
  for(int i=0;i<enemyList.size();i++) {
    enemyList.get(i).Update();
    if(enemyList.get(i).isDead) {
      enemyList.remove(i);
      i --;
    }
  }
  
  background(0);
  for(int i=0;i<12;i++) {
    for(int j=0;j<16;j++) {
      image(tilesImage[map[i][j]], j * 50, i * 50, 50, 50);
    }
  }
  player.Render();
  for(Enemy enemy : enemyList) {
    enemy.Render();
  }
}
void mousePressed() {
  if(mouseButton == RIGHT) {
    player.bulletSpray();
  } else if(mouseButton == LEFT) {
    player.shootQuadBullet();
  }
}
void keyPressed() {
  player.keyPress(key);
  if(key == ' ') {
    enemyList.add(new Enemy(new PVector(mouseX, mouseY)));
  }
}
void keyReleased() {
  player.keyRelease(key);
}
