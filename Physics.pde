interface Physics {
  public boolean collision(GameObject a, GameObject b);
  public void restitution();
}

interface PhysicalObject {
  float coe = 1;
  public void bounceX();
  public void bounceY();
}
