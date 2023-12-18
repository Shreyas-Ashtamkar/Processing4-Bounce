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
    this.coe = 0.8;
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
      if(!(dist(o.position[X],o.position[Y], this.position[X], this.position[Y]) <= (o.getSize()[X]+this.getRadius())) || this == o){
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
  
  public PVector reflectedVel(float[] a, float[] b, float coe){
    PVector aVelocity = new PVector(a[X], a[Y]);
    PVector bVelocity = new PVector(b[X], b[Y]);
    
    PVector relativeVel     = PVector.sub(bVelocity, aVelocity);
    PVector collisionNormal =  PVector.sub(bVelocity, aVelocity).normalize();
    
    float   projectedVel = PVector.dot(relativeVel, collisionNormal);
    PVector reflectedVel = PVector.mult(collisionNormal, projectedVel * coe);

    return reflectedVel;
  }
  
  public void restitution(Ball b){ //<>// //<>//
    PVector reflectedVel = reflectedVel(this.velocity, b.velocity, 1);
    
    println("\r Relative Velocity : "+reflectedVel.x+", "+reflectedVel.y);
    
    this.bounceXY(reflectedVel.x, reflectedVel.y);
    b.bounceXY(-reflectedVel.x, -reflectedVel.y);
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
