class Gravity extends GameObject{
  float rotationSpeed = 0.01;
  
  Gravity(float posX, float posY, float acc){
    super(acc, acc, posX, posY, acc, acc);
    setColor(color(0,0));
  }
  
  Gravity(float posX, float posY, float acc, String effect_image_filename){
    this(posX, posY, acc);
    setImage(effect_image_filename, acc);
  }
  
  Gravity(float posX, float posY, float acc, PImage image){
    this(posX, posY, acc);
    setImage(image, acc);
  }
  
  Gravity(float posX, float posY, float acc, String effect_image_filename, float image_size){
    this(posX, posY, acc);
    setImage(effect_image_filename, image_size);
  }
  
  Gravity(float posX, float posY, float acc, PImage image, float image_size){
    this(posX, posY, acc);
    setImage(image, image_size);
  }
  
  public float getGravity(){
    return this.acceleration[X];
  }
  
  public void apply(Ball b){
    float pullForce = 1 - constrain(ball.distanceFrom(position[X]+imageSize/2, position[Y]+imageSize/2)*0.001, 0, 1);
    
    if(b.position[X] > position[X]+imageSize/2){
      b.extAccelerate(-pullForce, 0);
    }
    else if(b.position[X] < position[X]+imageSize/2){
      b.extAccelerate(pullForce, 0);
    }
    else{
      //println("Ball on UNDER side");
    }
    
    if(b.position[Y] > position[Y]+imageSize/2){
      b.extAccelerate(0, -pullForce);
    }
    else if(b.position[Y] < position[Y]+imageSize/2){
      b.extAccelerate(0, pullForce);
    }
    else{
      //println("Ball on UNDER side");
    }
  }
  
  @Override //Overriding to disable updating speed, incase called.
  public void update(){}
  
  
  public void draw(){
    showRotatingImage();
  }
}
