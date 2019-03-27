ArrayList<SphereParticle> particles;
PGraphics textLayer;
PFont font;

int numParticles = 420;
float radius = 100;
float threshold = 30;
int camAngle = 1;

color bg;
color fg;
int bgAlpha;
int fgAlphaLines;
int fgAlphaDots; 

void setup()
{
  fullScreen(P3D);
  smooth(4);
  strokeJoin(ROUND);
  strokeCap(ROUND);
  
  bg = color(0);
  fg = color(255);
  
  bgAlpha = 20;
  fgAlphaLines = 5;
  fgAlphaDots = 0;
  
  textLayer = createGraphics(width, height, P2D);

  font = loadFont("font.vlw");
  
  hint(DISABLE_DEPTH_TEST);
  
  textLayer.beginDraw();
   
  textLayer.clear();
  textLayer.textFont(font);
  textLayer.textAlign(CENTER, CENTER);
  textLayer.textSize(60);
  
  textLayer.translate(width/2, height/2);
  textLayer.noStroke();
  textLayer.fill(bg);
  textLayer.text("davidjonas.art", 0, 0);
  textLayer.filter(BLUR, 10);
  textLayer.stroke(fg);
  textLayer.fill(fg);
  textLayer.text("davidjonas.art", 0, 0);
  textLayer.endDraw();

  particles = new ArrayList<SphereParticle>();
  //recreateParticles();
  
  background(bg);
}

void draw()
{
  //background(0);
  fill(bg, bgAlpha);
  noStroke();
  rect(0,0,width,height);
  
  pushMatrix();
  
  camera(cos(camAngle/300.0)*(cos(camAngle/300.0)*50 +300), 0.0, sin(camAngle/300.0)*(cos(camAngle/300.0)*50 +300),    0.0, 0.0, 0.0,     .5, .5, 0.0);
  if(true)
  {
    camAngle++;
  }
  
  
  for (SphereParticle p : new ArrayList<SphereParticle>(particles))
  {
    if (!p.render()) {
      particles.remove(p);
    }
    else
    {
      for (SphereParticle o : particles)
      {
        if(p != o && PVector.dist(p.position, o.position) < threshold)
        {
           strokeWeight(1);
           stroke(fg, fgAlphaLines);
           line(o.position.x, o.position.y, o.position.z, p.position.x, p.position.y, p.position.z);
        }
      }
    }
  }
  popMatrix();
  
  image(textLayer, 0, 0);
  
  if(particles.size() < numParticles/3)
  {
    recreateParticles();
  }
}

SphereParticle randomParticle(int index){
  
  //float theta = index % PI;
  float theta = HALF_PI;
  float phi = index % TWO_PI;
  return new SphereParticle(theta, phi, 5, color(fg, fgAlphaDots), (int)random(1000), random(0.005));
}

void recreateParticles()
{
  //particles.clear();
  for (int i=0; i<numParticles; i++)
  {
    particles.add(randomParticle(i));
  }
}

void keyPressed()
{
  if(key == ' ') {
    //background(0);
    //camAngle=(int )random(360);
    recreateParticles();
  } else if(key == 'b')
  {
    saveFrame("output/BlackBg/logo_####.jpg");
  } else if(key == 'w')
  {
    filter(INVERT);
    saveFrame("output/WhiteBg/logo_####.jpg");
  }
}
