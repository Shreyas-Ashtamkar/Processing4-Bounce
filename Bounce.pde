Arena gameBoard;
  float padding = 20;
  float wallThickness = 50;
  float gravity[] = {0.0, 0.1};

Ball  ball;
  float ballRadius = 10;
 
Gravity gObject;
  PImage gravity_effect_image;
  float gravity_sizeX, gravity_sizeY;
  float angle = 0;
  float rotationSpeed = 0.01;
  
void setup(){
  size(1900, 1100);
  //frameRate(1300);
  gameBoard = new Arena(width - padding*2, height - padding*2, padding, padding, wallThickness, color(255, 255, 255, 90));
  
  ball = new Ball(
    ballRadius, // -----------------------------------> Radius of Ball 
    ballRadius + padding + gameBoard.wallThickness+2,// ---> Position X
    ballRadius + padding + gameBoard.wallThickness+2, // ---> Position Y
    9, // ---------------------------------------------> Velocity X
    0 // ---------------------------------------------> Velocity Y
  );
  
  ball.coe = 0.8;
  gameBoard.setGravity(gravity);
  
  gravity_effect_image=loadImage("gravity_effect.png");
  gravity_sizeX = height/2;
  gravity_sizeY = height/2;
  
  background(0);
}

void draw(){
  if(gameBoard.checkCollision(ball)){
    gameBoard.restitution(ball); //<>// //<>//
  }
  else
    ball.extAccelerate(gameBoard.gravity[X], gameBoard.gravity[Y]);
  
  gameBoard.draw();
  
  if(gObject != null){
    //println("Drawing Gravity : "+(gObject.position[X]-mouseX));
    gObject.draw();
    gObject.apply(ball);
  }
  
  ball.draw();
  
  if (gameBoard.checkOutOfBounds(ball))
    stop(); //<>// //<>//
}

void resetBall(){
  ball = new Ball(
    ballRadius, // -----------------------------------> Radius of Ball 
    random(ballRadius+gameBoard.position[X]+gameBoard.wallThickness, ballRadius+gameBoard.position[X]+gameBoard.size[X]-gameBoard.wallThickness), // ---> Position X
    random(ballRadius+gameBoard.position[Y]+gameBoard.wallThickness, ballRadius+gameBoard.position[Y]+gameBoard.size[Y]-gameBoard.wallThickness), // ---> Position Y
    random(-wallThickness, wallThickness), // --------------------------------------------> Velocity X
    random(-wallThickness, wallThickness)// ---------------------------------------------> Velocity Y
  );

  ball.coe = 0.8;
  
  print("Reset");
}

void mousePressed(){
  if(mouseButton == 39) 
    gObject = null;
  else
    gObject = new Gravity(mouseX-gravity_sizeX/2, mouseY-gravity_sizeY/2, gravity_sizeX, gravity_effect_image);
}

/*
Remaining tasks 
- Gravity Objectification
  - There should be a way to calculate the resultant gravity and apply it only once.
  - ArrayList of Ball Type
    - Check Ball-Ball collisions also
    - Check Ball-Wall collisions
  - 
*/
