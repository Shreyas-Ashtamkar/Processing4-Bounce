Arena gameBoard;
  float wallThickness = 1000;
  float padding = -wallThickness+15;
  float gravity[] = {0.0, 0.0};

//Ball  ball;
  float ballRadius = 70;
  ArrayList<Ball> balls = new ArrayList<Ball>();
 
Gravity gObject;
  PImage gravity_effect_image;
  float gravity_sizeX, gravity_sizeY;
  float angle = 0;
  float rotationSpeed = 0.01;
  ArrayList<Gravity> heavyObjects = new ArrayList<Gravity>();
  
void setup(){
  size(1900, 1100);
  //frameRate(1300);
  gameBoard = new Arena(width - padding*2, height - padding*2, padding, padding, wallThickness, color(255, 255, 255, 90));
  
  //ball = new Ball(
  //  ballRadius, // -----------------------------------> Radius of Ball 
  //  ballRadius + padding + gameBoard.wallThickness+2,// ---> Position X
  //  ballRadius + padding + gameBoard.wallThickness+2, // ---> Position Y
  //  9, // ---------------------------------------------> Velocity X
  //  4  // ---------------------------------------------> Velocity Y
  //);
  
  //ball.coe = 0.8;
  gameBoard.setGravity(gravity);
  
  gravity_effect_image=loadImage("gravity_effect.png");
  gravity_sizeX = height/4;
  gravity_sizeY = height/4;
  
  background(0);
}

void draw(){
  //if(gameBoard.checkCollision(ball)){
  //  gameBoard.restitution(ball);
  //}
  //else{
  //  ball.extAccelerate(gameBoard.gravity[X], gameBoard.gravity[Y]);
  //  ball.applyMultiGravity(heavyObjects);
  //}
  
  gameBoard.draw(); 
  
  for(Gravity g: heavyObjects)
    g.draw();
  
  for(Ball b: balls){
    if(gameBoard.checkCollision(b)){
      gameBoard.restitution(b);
    }
    else{
      b.extAccelerate(gameBoard.gravity[X], gameBoard.gravity[Y]);
      b.applyMultiGravity(heavyObjects);
    }
    
    println("\n\n\n");
    for(Ball b2: balls){
      println(" COLLISION " + balls.indexOf(b2) +", "+ b.checkCollision(b2));
      if(b != b2 && b.checkCollision(b2))
        b.restitution(b2); //<>//
    }
    
    b.draw();
    
    if (gameBoard.checkOutOfBounds(b))
      stop();
  }
  
  //ball.draw();
  
  //if (gameBoard.checkOutOfBounds(ball))
  //  stop(); //<>// //<>//
}

//void resetBall(){
//  ball = new Ball(
//    ballRadius, // -----------------------------------> Radius of Ball 
//    random(ballRadius+gameBoard.position[X]+gameBoard.wallThickness, ballRadius+gameBoard.position[X]+gameBoard.size[X]-gameBoard.wallThickness), // ---> Position X
//    random(ballRadius+gameBoard.position[Y]+gameBoard.wallThickness, ballRadius+gameBoard.position[Y]+gameBoard.size[Y]-gameBoard.wallThickness), // ---> Position Y
//    random(-wallThickness/2, wallThickness/2), // --------------------------------------------> Velocity X
//    random(-wallThickness/2, wallThickness/2)  // ---------------------------------------------> Velocity Y
//  );

//  ball.coe = 0.8;
  
//  print("Reset");
//}

void mousePressed(){
  switch(mouseButton){
    case LEFT:
        heavyObjects.add(new Gravity(mouseX-gravity_sizeX/2, mouseY-gravity_sizeY/2, gravity_sizeX, gravity_effect_image));
        break;
    
    case RIGHT:
        Gravity gUnderCursor = null;
        for(Gravity g: heavyObjects){
          if(g.checkCollision(mouseX, mouseY)){
            gUnderCursor = g;
            break;
          }
        }
        if(gUnderCursor != null)
          heavyObjects.remove(gUnderCursor);
        break;
    
    case CENTER:
        print("MIDDLE BUTTON CLICKED");
        Ball b = new Ball(
          ballRadius, // -----------------------------------> Radius of Ball 
          mouseX,
          mouseY,
          2,
          3
        );
        
        b.setColor(color(random(255), random(255), random(255)));
        balls.add(b);
        break;
      
    default:
        println("mousePressed.mouseButton.this : Unimplemented");
  }
}

/*
Remaining tasks 
- Gravity Objectification
  - There should be a way to calculate the resultant gravity and apply it only once.

- Multi-Ball Physics
  - ArrayList of Ball Type
    - Check Ball-Wall collisions
    - Check Ball-Ball collisions
    - Gravity Act on each ball
*/
