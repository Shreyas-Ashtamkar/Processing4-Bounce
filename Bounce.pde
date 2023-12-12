float padding = 20;
float ballRadius = 10;

float wallThickness = 50;

Arena gameBoard;
Ball  ball;

float collisionWall = -1;

float gravity[] = {0, 0.2};

float mousePullForce = 0.2;

void setup(){
  size(1200, 1200);
  //frameRate(120);
  gameBoard = new Arena(width - padding*2, height - padding*2, padding, padding, wallThickness, color(255, 255, 255, 40));
  
  ball = new Ball(
    ballRadius, // -----------------------------------> Radius of Ball 
    ballRadius+padding+gameBoard.wallThickness+2,// ---> Position X
    gameBoard.size[Y] - ballRadius + padding - gameBoard.wallThickness-2, // ---> Position Y
    10, // --------------------------------------------> Velocity X
    -10 // ---------------------------------------------> Velocity Y
  );
  
  ball.coe = 0.8;
  gameBoard.setGravity(gravity);
  
  background(0);
}

void draw(){
  if(gameBoard.checkCollision(ball))
    gameBoard.restitution(ball); //<>//
  else
    ball.extAccelerate(gameBoard.gravity[X], gameBoard.gravity[Y]);
  
  gameBoard.draw();
  ball.draw();
  
  if (gameBoard.checkOutOfBounds(ball))
    //resetBall(); //<>//
    stop();
    
  if(mousePressed){
    println("Clicked at : "+mouseX+","+mouseY);
    mousePullForce = 1 - constrain(ball.distanceFrom(mouseX, mouseY)*0.001, 0, 1);
    
    println("\t Ball Distance from Mouse : "+ mousePullForce);
    
    if(ball.position[X] > mouseX){
      println("\t Ball on RIGHT side");
      ball.extAccelerate(-mousePullForce, 0);
    }
    else if(ball.position[X] < mouseX){
      println("\t Ball on LEFT side");
      ball.extAccelerate(mousePullForce, 0);
    }
    else{
      println("Ball on UNDER side");
    }
    
    if(ball.position[Y] > mouseY){
      println("\t Ball on BELOW side");
      ball.extAccelerate(0, -mousePullForce);
    }
    else if(ball.position[Y] < mouseY){
      println("\t Ball on ABOVE side");
      ball.extAccelerate(0, mousePullForce);
    }
    else{
      println("Ball on UNDER side");
    }
  }
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

/*
Remaining tasks 
- Gravity Objectification
  - Create Class Gravity (POJO) ( Or HeavyObject )
  - Can be extended from GameObject itself
  - Every object of gravity will be an affecting force on the ball.
  - There should be a way to calculate the resultant gravity and apply it only once.
  - Each gravitational Object should have a position, which will be it's center of application.
  - There should be a way to 
  

*/
