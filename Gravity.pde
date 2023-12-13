class Gravity extends GameObject{
  float gravity;
  
  Gravity(float posX, float posY, float acc){
    super(acc, acc, posX, posY);
    setGravity(acc);
    setColor(color(0));
  }
  
  void setGravity(float g){
    this.gravity = g;
  }
  
  public void draw(){
    //image(gravity_effect_image, 0, 0);
  }
}
