class Ball extends GameObject implements PhysicalObject{
  float radius;
  float coe = 0.8;
  
  Ball(){
    this(50);
  }
  
  Ball(float radius){
    this(
        radius, 
        0, 0,
        0, 0,
        0, 0
    );
  }
  
  Ball(float radius, float posX, float posY){
    this(
        radius, 
        posX, posY,
        0, 0,
        0, 0
    );
  }
  
  Ball(float radius, float posX, float posY, float velX, float velY){
    this(
        radius, 
        posX, posY,
        velX, velY,
        0, 0
    );
  }
  
  Ball(float radius, float posX, float posY, float velX, float velY, float accX, float accY){
    super(radius, radius, posX, posY, velX, velY, accX, accY);
    this.setRadius(radius);
  }
  
  public float getRadius(){
    return radius;
  }

  public void setRadius(float radius){
    this.radius = radius;
  }
  
  public boolean checkCollision(GameObject o){
    if(o instanceof Ball){
      return abs(sqrt(sq(o.position[Y])+sq(o.position[X])) - sqrt(sq(this.position[Y])+sq(this.position[X]))) == (((Ball)o).getRadius()+this.getRadius()); 
    }
    else if (o instanceof Wall){
      // return abs(sqrt(sq(o.position[Y])+sq(o.position[X])) - sqrt(sq(this.position[Y])+sq(this.position[X]))) == 
    }
    return false;
  }
  
  @Override
  public void draw(){
    update();
    circle(position[X], position[Y], radius*2); // Diameter based drawing function
  }
}
