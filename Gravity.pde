class Gravity extends GameObject{
  float rotationSpeed = 0.01;
  final double G = 6.6743e-11, M=1e+12;
  
  Gravity(float posX, float posY, float acc){
    super(acc, acc, posX, posY, 0.0, 0.0, acc, acc);
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
  
  public void setGravity(float gravity){
    this.acceleration[X] = gravity;
    this.acceleration[Y] = gravity;
  }
  
  public float getGravity(){
    return this.acceleration[X];
  }
  
  public float getPullForce(Ball b){
    float pullForce = getGravity();
    pullForce *= G*M/sq(dist(b.position[X], b.position[Y], position[X]+imageSize/2, position[Y]+imageSize/2));
    pullForce = -constrain(pullForce, 0, getGravity()/110);
    
    return pullForce;
  }
  
  public float[] getGravity(Ball b){
    float pullForce = getPullForce(b);
    float acc[] = {0.0, 0.0};
    
    if(b.position[X] > position[X]+imageSize/2){
      acc[X] = pullForce;
    }
    else if(b.position[X] < position[X]+imageSize/2){
      acc[X] = -pullForce;
    }
    else{
      //println("Ball on UNDER side");
    }
      
    if(b.position[Y] > position[Y]+imageSize/2){
      acc[Y] = pullForce;
    }
    else if(b.position[Y] < position[Y]+imageSize/2){
      acc[Y] = -pullForce;
    }
    else{
      //println("Ball on UNDER side");
    }
  
    return acc;
  }
  
  public void apply(Ball b){
    float a[] = getGravity(b);
    
    b.extAccelerate(a[X],a[Y]);
  }
  
  @Override //Overriding to disable updating speed, incase called.
  public void update(){}
  
  
  public void draw(){
    //showCircle();
    //showImage();
    showRotatingImage();
  }
}
