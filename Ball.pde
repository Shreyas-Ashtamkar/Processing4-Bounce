class Ball extends GameObject implements PhysicalObject{
  float radius;
  
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
    setColor(color(0, 0, 255));
    this.coe = 1;
  }
  
  public float getRadius(){
    return radius;
  }

  public void setRadius(float radius){
    this.setSize(radius, radius);
    this.radius = radius;
  }
  
  @Override
  public boolean checkCollision(GameObject o){
    if(o instanceof Ball){
      if(!(dist(o.position[X],o.position[Y], this.position[X], this.position[Y]) <= (o.getSize()[X]+this.getRadius()))){
        return o.inRestitutionXY = this.inRestitutionXY = false;
      }
      else{
        return true;
      }
    }
    else if (o instanceof Wall){
      return o.checkCollision(this);
    }
    return false;
  }
  
  public void restitution(Ball b){
    float relVelocity[] = {
      b.velocity[X] - this.velocity[X],
      b.velocity[Y] - this.velocity[Y]
    };
    
    this.bounceXY(relVelocity[X], relVelocity[Y]);
    b.bounceXY(-relVelocity[X], -relVelocity[Y]);
  }
  
  public void applyGravity(Gravity g){
    g.apply(this);
  }
  
  public void applyMultiGravity(ArrayList<Gravity> gs){
    float a[] = {0.0,0.0}, cg[];
    
    for(Gravity g:gs){
      cg = g.getGravity(this);
      a[X] += cg[X];
      a[Y] += cg[Y];
    }
    
    this.extAccelerate(a[X], a[Y]);
  }
  
  @Override
  public void draw(){
    update();
    paint(
      () -> circle(position[X], position[Y], radius*2)
    );
  }
}
