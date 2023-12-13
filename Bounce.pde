Arena gameBoard;
  float padding = 20;
  float wallThickness = 50;
  float gravity[] = {0.0, 0.1};
  float mousePullForce = 0.02;

Ball  ball;
  float ballRadius = 10;
 
Gravity gObject;
  PImage gravity_effect_image;
  float gravity_sizeX, gravity_sizeY;
  float angle = 0;
  float rotationSpeed = 0.01;
  
void setup(){
  size(900, 900);
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
  gravity_sizeX = width/2;
  gravity_sizeY = height/2;
}

void draw(){
  if(gameBoard.checkCollision(ball)){
    gameBoard.restitution(ball); //<>//
  }
  else
    ball.extAccelerate(gameBoard.gravity[X], gameBoard.gravity[Y]);
  
  gameBoard.draw();
  ball.draw();
  
  if (gameBoard.checkOutOfBounds(ball))
    //resetBall(); //<>//
    stop();
    
  if(mousePressed){
    tint(0,20);
    angle += rotationSpeed;
    angle = angle % TWO_PI;
    
    push();
    translate(mouseX, mouseY);
    rotate(angle);
    image(gravity_effect_image, -gravity_sizeX/2, -gravity_sizeY/2, gravity_sizeX, gravity_sizeY);
    pop();
    
    gObject = new Gravity(mouseX, mouseY, 50);
    gObject.draw();
    
    //println("Clicked at : "+mouseX+","+mouseY);
    mousePullForce = 1 - constrain(ball.distanceFrom(mouseX, mouseY)*0.001, 0, 1);
    
    //println("\t Ball Distance from Mouse : "+ mousePullForce);
    
    if(ball.position[X] > mouseX){
      //println("\t Ball on RIGHT side");
      ball.extAccelerate(-mousePullForce, 0);
    }
    else if(ball.position[X] < mouseX){
      //println("\t Ball on LEFT side");
      ball.extAccelerate(mousePullForce, 0);
    }
    else{
      //println("Ball on UNDER side");
    }
    
    if(ball.position[Y] > mouseY){
      //println("\t Ball on BELOW side");
      ball.extAccelerate(0, -mousePullForce);
    }
    else if(ball.position[Y] < mouseY){
      //println("\t Ball on ABOVE side");
      ball.extAccelerate(0, mousePullForce);
    }
    else{
      //println("Ball on UNDER side");
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
  - There should be a way to set the gravity to a global constant.
  

*/
