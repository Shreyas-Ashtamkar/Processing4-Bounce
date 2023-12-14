class Arena extends Box implements Physics{
  float wallThickness;
  boolean collision_complete = true;
  float gravity[] = {0.0, 0.0};
  
  float prevCollisionWall = -1;

  Wall[] walls = new Wall[4];
  
  Arena(){
    this(50,50);
  }
  
  Arena(float sizeX, float sizeY){
    this(sizeX, sizeY, 0, 0);
  }

  Arena(float sizeX, float sizeY, float posX, float posY){
    this(sizeX, sizeY, posX, posY, 0, color(255));
  }
  
  Arena(float sizeX, float sizeY, float posX, float posY, float wallThickness){
    this(sizeX, sizeY, posX, posY, wallThickness, color(255));
  }
  
  Arena(float sizeX, float sizeY, float posX, float posY, float wallThickness, color bgColor){
    super(sizeX, sizeY, posX, posY);
    setWallThickness(wallThickness);
    this.fillColor = bgColor;
  }
  
  public void __init__(){    
    walls[0] = new Wall( 
      wallThickness, size[Y], 
      position[X], position[Y],
      color(100, 100  , 100, 55)
    );
    walls[1] = new Wall(
      wallThickness, size[X], 
      position[X], position[Y],
      color(100  , 100, 100  , 55), 
      true
    );
    walls[2] = new Wall(
      wallThickness, size[Y], 
      position[X]+size[X]-wallThickness, position[Y],
      color(100  , 100  , 100  , 55)      
    );
    walls[3] = new Wall(
      wallThickness, size[X], 
      position[X], position[Y]+size[Y]-wallThickness,
      color(100, 100, 100  , 55), 
      true
    );
  }
  
  public void setWallThickness(float wallThickness){
    this.wallThickness = wallThickness;
    __init__();
  }
  
  public void setGravity(float gravity[]){
    this.gravity = gravity;
  }
  
  @Override
  public int collision(GameObject a){
    //walls[i].checkCollision(b)
    for(int i=0;i<4;i++)
      if(walls[i].checkCollision(a))        
        return i;
    
    a.inRestitutionY = false;
    a.inRestitutionX = false;
    
    return -1;
  }
  
  public boolean checkCollision(GameObject o){
    return collision(o) != -1;
  }
   //<>// //<>//
  public void restitution(GameObject a){
    Ball b = (Ball)a; //<>// //<>//
    
    if (collision(ball) % 2 == 0)
        b.bounceX(); //<>// //<>//
    else
        b.bounceY(); //<>// //<>//
  }
  
  public boolean checkOutOfBounds(GameObject o){
    return (o.position[X] > position[X]+size[X]) || 
           (o.position[Y] > position[Y]+size[Y]) || 
           (o.position[X] < position[X]) ||      
           (o.position[Y] < position[Y]);
  }
  
  public void draw(){
    paint(
      ()->rect(position[X], position[Y], size[X], size[Y])
    );
    
    for(Wall w : walls){
      w.draw();
    }
  }
}
