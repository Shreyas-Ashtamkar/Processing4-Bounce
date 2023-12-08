class Arena extends Box implements Physics{
  float wallThickness = 10;
  boolean collision_complete = true;

  Wall[] walls = new Wall[4];
  
  Arena(){
    super(50,50);
    init_walls();
  }
  
  Arena(float sizeX, float sizeY){
    super(sizeX, sizeY);
    init_walls();
  }
  
  Arena(float sizeX, float sizeY, float padding){
    this(
      sizeX  - padding*2, 
      sizeY  - padding*2, 
      padding, 
      padding
    );
    init_walls();
  }

  Arena(float sizeX, float sizeY, float posX, float posY){
    super(sizeX, sizeY, posX, posY);
    init_walls();
  }
  
  Arena(float sizeX, float sizeY, float posX, float posY, color bgColor){
    super(sizeX, sizeY, posX, posY);
    this.fillColor = bgColor;
    init_walls();
  }
  
  public void init_walls(){
    walls[0] = new Wall( 
      wallThickness, size[Y], 
      position[X], position[Y],
      color(100, 0  , 100, 55)
    );
    walls[1] = new Wall(
      wallThickness, size[X], 
      position[X], position[Y],
      color(0  , 100, 0  , 55), 
      true
    );
    walls[2] = new Wall(
      wallThickness, size[Y], 
      position[X]+size[X]-wallThickness, position[Y],
      color(0  , 0  , 0  , 55)      
    );
    walls[3] = new Wall(
      wallThickness, size[X], 
      position[X], position[Y]+size[Y]-wallThickness,
      color(100, 100, 0  , 55), 
      true
    );
  }
  
  public boolean collision(GameObject a, GameObject b){
    for(Wall w : walls){
      //if a.
    }
    return false;
  }
  
  public void restitution(){
    
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
