interface Physics {
  public int collision(GameObject o);
  public void restitution(GameObject o);
}

interface PhysicalObject {
  public void extAccelerate(float accX, float accY);
  public void bounceX();
  public void bounceY();
}
