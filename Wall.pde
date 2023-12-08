class Wall extends Box implements PhysicalObject{
  float coe = 0;
  boolean horizontal = false;
  
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
    if(horizontal)
      setSize(sizeY, sizeX);
  }
}
