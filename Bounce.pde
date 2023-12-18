Arena gameBoard;
  float wallThickness = 1000;
  float padding = -wallThickness+15;
  float gravity[] = {0.1, 0.0};

//Ball  ball;
  float ballRadius = 20;
  ArrayList<Ball> balls = new ArrayList<Ball>();
 
Gravity gObject;
  PImage gravity_effect_image;
  float gravity_sizeX, gravity_sizeY;
  float angle = 0;
  float rotationSpeed = 0.01;
  ArrayList<Gravity> heavyObjects = new ArrayList<Gravity>();
  
void setup(){
  size(1900, 1100);
  //frameRate(1);
  gameBoard = new Arena(width - padding*2, height - padding*2, padding, padding, wallThickness, color(255, 255, 255, 90));
  gameBoard.setGravity(gravity);
  
  gravity_effect_image=loadImage("gravity_effect.png");
  gravity_sizeX = height/4;
  gravity_sizeY = height/4;
  
  background(0);
}

int i=0;

void draw(){
  i = i<500?++i:0;
  
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
      println(i+" COLLISION " + balls.indexOf(b2) +", "+ b.checkCollision(b2));
      if(b.checkCollision(b2))
        b.restitution(b2); //<>// //<>//
    }
    
    b.draw();
    
    if (gameBoard.checkOutOfBounds(b))
      stop();
  }
 //<>//
}

void mousePressed(){
  switch(mouseButton){
    case LEFT:
        gravity[X] = 0;
        gravity[Y] = 0;
        gameBoard.setGravity(gravity);
        heavyObjects.add(new Gravity(mouseX-gravity_sizeX/2, mouseY-gravity_sizeY/2, gravity_sizeX, gravity_effect_image));
        break;
    
    case RIGHT:
        Gravity gUnderCursor = null;
        Ball bUnderCursor = null;

        for(Gravity g: heavyObjects){
          if(g.checkCollision(mouseX, mouseY)){
            gUnderCursor = g;
            break;
          }
        }
        if(gUnderCursor != null)
          heavyObjects.remove(gUnderCursor);
        
        for(Ball b: balls){
          if(b.checkCollision(mouseX, mouseY)){
            bUnderCursor = b;
            break;
          }
        }

        if(bUnderCursor != null)
          balls.remove(bUnderCursor);
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
