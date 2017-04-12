// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed, life;
  float G;
  float mass;
  int id;
  Mover(int n) {
    // Start in the center
    location = new PVector(random(0.49, 0.52), random(.49, .52), random(0.49, 0.52));
    velocity = new PVector(random(-0.1, 0.1), random(-0, 1), random(-0.1, 0.1));
   // velocity = new PVector(cos(TWO_PI*n/sqrt(nP)), sin(TWO_PI*n/sqrt(nP))*cos(PI*n/nP), sin(TWO_PI*n/sqrt(nP))*sin(PI*n/nP));
    velocity.mult(300);
    acceleration= new PVector(0, 0, 0);
    topspeed = 2;
    mass = random(5, 5);
    G = 0.4;
    life=random(10,20);
    id=n;
  }
  void reset(){
     location = new PVector(random(0.49, 0.52), random(.49, .52), random(0.49, 0.52));
    velocity = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
      velocity = new PVector(random(-0.1, 0.1), random(1, 1), random(-0.1, 0.1));
     life=50;
   
   life=random(10,20);
  }
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    // distance = constrain(distance,5.0,50.0);


    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    // if(distance<mass)
    strength=-strength*1;
    force.mult(strength);
    return force;
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void checkBorders() {
    PVector f=new PVector(0, 0, 0);
    float bsiz=10;
    if (location.x<-bsiz) {
      velocity.x=-velocity.x;
    }
    if (location.x>bsiz-1) { 
      velocity.x=-velocity.x;
    }
    if (location.y<-bsiz) {
      velocity.y= -velocity.y;
    }
    if (location.y>bsiz-1) { 
      velocity.y= -velocity.y;
    }
    if (location.z<-bsiz) {
      velocity.z= -velocity.z;
    }
    if (location.z>bsiz-1) {
      velocity.z= -velocity.z;
    }
    applyForce(f);
  }
  void update() {

    // Compute a vector that points from location to mouse
    //  PVector mouse = new PVector(mouseX,mouseY);
    //   PVector acceleration = PVector.sub(mouse,location);
    // Set magnitude of acceleration
    //acceleration.setMag(0.2);
    // acceleration.normalize();
    //  acceleration.mult(0.2);

    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
    acceleration.mult(0);
    //     mass-=0.001;
    //     mass=max(mass,0);
    life--;
  }

  void display() {

    int xt=constrain(int(location.x)+10, 0, 19);
    int yt=constrain(int(location.y)+10, 0, 19);
    int zt=constrain(int(location.z)+10, 0, 19);
 //   colorMode(HSB);
    //cube[xt][yt][zt]=color(min(10*life,255));
    float val=min(10*fftbin[id%20],255);
    cube[xt][yt][zt]=color(hue(terCl),255,val);
  
    if(life<1)reset();
  }
    void displayBox() {

    int xt=constrain(int(location.x)+10, 0, 18);
    int yt=constrain(int(location.y)+10, 0, 18);
    int zt=constrain(int(location.z)+10, 0, 18);

    cube[xt][yt][zt]=color(255,0,0);
    for (int k=0; k<2; k++) { 
    for (int j=0; j<2; j++) { 
      for (int i=0; i<2; i++) {   
       cube[xt+i][yt+j][zt+k]=color(id*20, 255, 255);
      }}
    }
    if(life<1)reset();
  }
}