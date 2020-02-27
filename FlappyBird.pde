Flappy flappy;
Point point;
float score=0;
int vite = 5;

void setup(){
  size(800, 500);
  flappy = new Flappy();
  point = new Point();
  textSize(20);
}

void draw(){
  background(0);
  fill(0, 255, 255);
  text("Vite : " + vite, 15, 25);
  text("Punteggio : " + int(score), width-170, 25);
  flappy.show();
  point.show();
  checkX();
  hit();
  checkVite();
}

void checkVite(){
  if(vite == 0){
    noLoop();
    text("Premere SPAZIO per ricominciare", 250, 240);
  }
}

void checkX(){
   if(point.x < 0){
     vite -= 1;
     point.destroy();
   }
}

void hit(){
  boolean xhit = false;
  boolean yhit = false;
  
  if((point.x - flappy.x) <= 40 && (point.x - flappy.x) >= -40){
    xhit = true;
  }
  
  if((point.y - flappy.y) <= 40 && (point.y - flappy.y) >= -40){
    yhit = true;
  }
  
  
  if(xhit && yhit){
    score += 1;
    flappy.hit = true;
    point.destroy();
    point.updvel();
  }
}

class Flappy
{
  float x = 80;
  float y = (height+25)/2;
  float vel = 0;
  int gravity = 1;
  int lift = -35;
  boolean hit = false;
  int c=0;
  
  void show(){
    fill(255);
    if (hit && c < 20){
      c++;
      fill(0, 255, 0);
    }else{
    hit = false;
    c = 0;
    }
 
    ellipse(x, y, 40, 40);
    update();
  }
  
  void update(){
    vel += gravity;
    vel *= 0.9;
    y += vel;
    checkY();
  }
  
  void jump(){
    vel += lift;
  }
  
  void checkY(){
    if(y > height){
      y = height;
      vel = 0;
    }
    if(y < 55){
      y = 55;
      vel = 0;
    }
  }
  
}

class Point
{
  float x = width-30;
  float y = (height+25)/2;
  float vel = -3.2;
  
  void update(){
    x += vel;
  }
  
  void getY(){
    y = (random(height-55)+55);
  }
  
  void updvel(){
    vel -= 0.14; 
    
  }
  
  void show(){
    fill(255, 0, 0);
    ellipse(x, y, 40, 40);
    update();
  }
  
  void destroy(){
    getY();
    x = width-30;
  }
  
}

void mousePressed(){
  flappy.jump();
}

void keyPressed(){
  if(key == ' '){
    vite = 5;
    score = 0;
    point.vel = -3;
    loop();
  }
}
