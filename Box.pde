class Box extends GameObject{
  Box(){
    super(0);
  }
  
  Box(float sizeX, float sizeY){
    super(sizeX, sizeY);
  }

  Box(float sizeX, float sizeY, float posX, float posY){
    super(sizeX, sizeY, posX, posY);
  }
  
  Box(float sizeX, float sizeY, float posX, float posY, color boxColor){
    super(sizeX, sizeY, posX, posY, boxColor);
  }

  Box(float sizeX, float sizeY, float posX, float posY, float velX, float velY){
    super(sizeX, sizeY, posX, posY, velX, velY);
  }

  Box(float sizeX, float sizeY, float posX, float posY, float velX, float velY, float accX, float accY){
    super(sizeX, sizeY, posX, posY, velX, velY, accX, accY);
  }
  
  public void draw(){
    paint(
      ()->rect(this.position[X], this.position[Y], this.size[X], this.size[Y])
    );
  }
}
