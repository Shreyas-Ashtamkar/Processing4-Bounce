static enum Direction{LEFT, RIGHT, UP, DOWN};

class Wall extends Box implements PhysicalObject{
  float coe = 0;
  boolean horizontal = false;
  
  //Core Properties
  float thickness; //<>// //<>// //<>// //<>// //<>// //<>// //<>//
  float wallLength;
  
  
  Direction side;
  
  Wall(float sizeX, float sizeY){
    super(sizeX, sizeY);
  }

  Wall(float sizeX, float sizeY, float posX, float posY){
    this(sizeX, sizeY, posX, posY, color(255,255,255));
  }
  
  Wall(float sizeX, float sizeY, float posX, float posY, color wallColor){
    this(sizeX, sizeY, posX, posY, wallColor, false);
  }
  
  Wall(float sizeX, float sizeY, float posX, float posY, color wallColor, boolean horizontal){
    super(sizeX, sizeY, posX, posY, wallColor);
    
    this.horizontal = horizontal;
    if(horizontal){
      setSize(sizeY, sizeX);
    }
    
    this.setThickness();
  }
  
  public void setThickness(){
    this.thickness = horizontal?size[Y]:size[X];
  }
  
  public void extAccelerate(float accX, float accY){
    //setVelocity(getVelocity()[X] + accX, getVelocity()[Y] + accY);
  }
  
  @Override
  public float distanceFrom(GameObject o){
    Ball b = (Ball)o;
      // Calculate the closest point to the o on the wall
    float closestX = constrain(b.position[X], position[X], position[X] + size[X]);
    float closestY = constrain(b.position[Y], position[Y], position[Y] + size[Y]);
  
    // Calculate the distance between the o and the closest point
    float distanceX = b.position[X] - closestX;
    float distanceY = b.position[Y] - closestY;
    
    return sqrt(distanceX * distanceX + distanceY * distanceY);
  }

  public boolean checkCollision(GameObject o){
    if (o instanceof Wall){
      return false;
    }
    else if(o instanceof Ball){
      Ball b = (Ball)o;
      return distanceFrom(o) < b.radius;
    }
    return false;
  }
  
  @Override
  public void draw(){
    //int prevRectMode = getCurrentRectMode();
    
    //rectMode(CENTER);
    paint(
      ()->rect(this.position[X], this.position[Y], this.size[X], this.size[Y])
    );
    //rectMode(prevRectMode);
  }
}
