abstract class GameObject{
  float coe = 0;
  float size[] = new float[2];  
  float position[] = new float[2];
  float velocity[] = new float[2];
  float acceleration[] = new float[2];

  color fillColor = color(255,255,255);
  color borderColor = color(0,0,0);
  
  boolean inRestitutionX = false;
  boolean inRestitutionY = false;

  GameObject(){
    this(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  }
  
  GameObject(float size){
    this(size, size, size, size, 0.0, 0.0 , 0.0, 0.0);
  }

  GameObject(float sizeX, float sizeY){
    this(sizeX, sizeY, sizeX, sizeY, 0.0, 0.0 , 0.0, 0.0);
  }

  GameObject(float sizeX, float sizeY, float posX, float posY){
    this(sizeX, sizeY, posX, posY, 0.0, 0.0 , 0.0, 0.0);
  }

  GameObject(float sizeX, float sizeY, float posX, float posY, color objectColor){
    this(sizeX, sizeY, posX, posY, 0.0, 0.0 , 0.0, 0.0, objectColor);
  }

  GameObject(float sizeX, float sizeY, float posX, float posY, float velX, float velY){
    this(sizeX, sizeY, posX, posY, velX, velY, 0.0, 0.0);
  }

  GameObject(float sizeX, float sizeY, float posX, float posY, float velX, float velY, float accX, float accY){
    this(sizeX, sizeY, posX, posY, velX, velY, accX, accY, color(255,255,255));
  }
  
  GameObject(float sizeX, float sizeY, float posX, float posY, float velX, float velY, float accX, float accY, color objectColor){
    this.setSize(sizeX, sizeY);
    this.setPosition(posX, posY);
    this.setVelocity(velX, velY);
    this.setAcceleration(accX, accY);
    this.setColor(objectColor);
    this.borderColor = objectColor;
  }
  
  public float[] getSize(){
    return this.size;
  }
  
  public float[] getPosition(){
    return this.position;
  }
  
  public float[] getVelocity(){
    return this.velocity;
  }
  
  public float[] getAcceleration(){
    return this.acceleration;
  }
  
  public color getColor(){
    return this.fillColor;
  }
  
  public void setSize(float sizeX, float sizeY){
    this.size[X] = sizeX;
    this.size[Y] = sizeY;
  }
  
  public void setPosition(float posX, float posY){
    this.position[X] = posX;
    this.position[Y] = posY;
  }
  
  public void setVelocity(float velX, float velY){
    this.velocity[X] = velX;
    this.velocity[Y] = velY;
  }
  
  public void setAcceleration(float accX, float accY){
    this.acceleration[X] = accX;
    this.acceleration[Y] = accY;
  }
  
  public void setColor(color objectColor){
    this.fillColor = objectColor;
  }
  
  public void bounceX(){
    if(inRestitutionX)
      return;
    setVelocity(this.velocity[X]*-1*this.coe, this.velocity[Y]);
    this.inRestitutionX = true;
  }
  
  public void bounceY(){ //<>//
    if(inRestitutionY)  //<>//
      return; //<>//
    setVelocity(this.velocity[X], this.velocity[Y]*-1*this.coe); //<>//
    this.inRestitutionY = true; //<>//
  }
  
  public void update(){
    this.setPosition(
      this.position[X] + this.velocity[X],
      this.position[Y] + this.velocity[Y]
    );
    
    this.setVelocity(
      this.velocity[X] + this.acceleration[X],
      this.velocity[Y] + this.acceleration[Y]
    );
  }
  
  public float distanceFrom(GameObject o){
    return sqrt(sq(this.getPosition()[X] - o.getPosition()[X]) + sq(this.getPosition()[Y] - o.getPosition()[Y]));
  }
  
  public float distanceFrom(float x, float y){
    return sqrt(sq(this.getPosition()[X] - x) + sq(this.getPosition()[Y] - y));
  }
  
  //Save previous color, paint and restore color
  public void paint(Runnable action){
    color prevColor = getCurrentFillColor();
    color prevStroke = getCurrentStrokeColor();
    
    stroke(fillColor);
    fill(fillColor);
    action.run();
    fill(prevColor);
    stroke(prevStroke);
  }
  
  public boolean checkCollision(GameObject o){
    return false;
  };

  abstract public void draw();
}
