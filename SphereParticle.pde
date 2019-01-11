
class SphereParticle {
  PVector coords;
  PVector direction;
  PVector position;
  int age;
  boolean alive;
  int ttl;
  float size;
  color col;
  float s;
  
  SphereParticle(float theta, float phi, float particleSize, color particleColor, int life, float speed)
  {
    coords = new PVector(theta, phi);
    direction = PVector.random2D().mult(speed);
    position = getCartesian();
    age = 0;
    alive = true;
    ttl = 300;
    size = particleSize;
    col = particleColor;
    ttl = life;
    s=speed;
  }
  
  void step()
  {
    coords.add(direction);
    direction.add(PVector.random2D().mult(s/10)).normalize().mult(s);
    position = getCartesian();
    age++;
    alive = ttl == 0 || age < ttl;
  }
  
  void draw()
  {
    pushMatrix();
    translate(position.x, position.y, position.z);
    strokeWeight(size);
    stroke(col);
    point(0,0);
    popMatrix();
  }
  
  boolean render()
  {
    step();
    //draw();
    
    return alive;
  }
  
  PVector getCartesian()
  {
      float x = cos(coords.x)*sin(coords.y)*radius;
      float y = sin(coords.x)*sin(coords.y)*radius;
      float z = cos(coords.y)*radius;
      
      return new PVector(x,y,z);
  }
}
