void voice() {
  //  backCub(0);
  float val=min( auInc, 10);

  // println(val);
  for (int i=0; i<val; i++) {
    cube[10][10+i][10]=color (255);
    cube[10][10-i][10]=color (255);
  }
}
void voice2() {
  //  backCub(0);
  float val=min( auInc, 10);

  // println(val);
  for (int i=0; i<val; i++) {
    cube[10][10+i][10]=secCl;
    cube[10][10-i][10]=secCl;
    cube[10+i][10][10]=secCl;
    cube[10-i][10][10]=secCl;
    cube[10][10][10+i]=secCl;
    cube[10][10][10-i]=secCl;
  }
}
void particles() {
  // translate(width/2, height/2);
  // scale(0.1,0.1,0.1);
  //image(bg,0,0);

  // blendMode(ADD  );

  //backCubFade(000000, 0.4); 
  for (int i = 0; i < movers.length; i++) {
    for (int j = 0; j < movers.length; j++) {

      if (i != j) {
        PVector force = movers[j].attract(movers[i]);
        movers[i].applyForce(force);
      }
    }
    movers[i].applyForce(wind);
    movers[i].checkBorders();
    float c = mouseX/100.0;

    PVector friction = movers[i].velocity.get();
    float speed = friction.mag();
    float dragMagnitude = c * speed * speed;
    friction.mult(-1);
    friction.normalize();
    friction.mult(dragMagnitude);


    //movers[i].applyForce(friction);
    movers[i].update();
    movers[i].display();
  }
}
void ResetPartic() {
  for (int i = 0; i < movers.length; i++) {
    movers[i].reset();
  }
  println("reset");
}

void OctaM() {
  for (int k = 0; k < 10; k++) {
    for (int i = 10; i < 20-k; i++) {
      for (int j = 10; j < 20-k; j++) {
        cube[j][10+k][i]=color (255, 255, 0);
        cube[j][10-k][i]=color (0, 0, 255);
        cube[20-j][10+k][i]=color (0, 255, 255);
        cube[20-j][10-k][i]=color (0, 255, 0);
        cube[20-j][10+k][20-i]=color (255, 0, 0);
        cube[20-j][10-k][20-i]=color (255, 0, 255);
        cube[j][10+k][20-i]=color (255, 127, 0);
        cube[j][10-k][20-i]=color (255, 0, 127);
      }
    }
  }
}
float octaSpeed, octaAng;
void OctaV() {
  //  octaSpeed=min(in.mix.level()*TAU/20, 0.2);
  // octaAng+=octaSpeed;
  float siz=max(0, 8);
  println(siz);
  for (int i = 0; i < 4; i++) {
    float ang=i*TAU/4+frameCount*TAU/40+octaAng;

    // LedLineRGB(10, 0, 10, 10+int(10*cos(ang)), 10, 10+int(10*sin(ang)), secCl);
    // LedLineRGB(10, 19, 10, 10+int(10*cos(ang)), 10, 10+int(10*sin(ang)), secCl);
    // LedLineRGB(10+int(10*cos(ang+TAU/4)), 10, 10+int(10*sin(ang+TAU/4)), 10+int(10*cos(ang)), 10, 10+int(10*sin(ang)), secCl);

    LedLineRGB(centerX, centerY-siz, centerZ, centerX+int(siz*cos(ang)), centerY, centerZ+int(siz*sin(ang)), secCl);
    LedLineRGB(centerX, centerY+siz, centerZ, centerX+int(siz*cos(ang)), centerY, centerZ+int(siz*sin(ang)), secCl);
    LedLineRGB(centerX+int(siz*cos(ang+HALF_PI)), centerY, centerZ+int(siz*sin(ang+HALF_PI)), centerX+int(siz*cos(ang)), centerY, centerZ+int(siz*sin(ang)), secCl);
    //   LedLineRGB(10, 19, 10, 10+int(10*cos(ang)), 10, 10+int(10*sin(ang)), secCl);
    //  LedLineRGB(10+int(10*cos(ang+TAU/4)), 10, 10+int(10*sin(ang+TAU/4)), 10+int(10*cos(ang)), 10, 10+int(10*sin(ang)), secCl);
  }
  // println("o");
}

void TetraV() {
  //  octaSpeed=min(in.mix.level()*TAU/20, 0.2);
  // octaAng+=octaSpeed;
  float s=10*cos(PI/4);
  // println(s);
  for (int i = 0; i < 2; i++) {
    float ang=i*TAU/2+frameCount*TAU/40+octaAng;

    LedLineRGB(10-int(10*cos(ang)), 10-s, 10-int(10*sin(ang)), 10-int(10*cos(ang+PI/2)), 10+s, 10-int(10*sin(ang+PI/2)), secCl);
    LedLineRGB(10-int(10*cos(ang)), 10-s, 10-int(10*sin(ang)), 10-int(10*cos(ang-PI/2)), 10+s, 10-int(10*sin(ang-PI/2)), secCl);

    LedLineRGB(10-int(10*cos(ang)), 10-s, 10-int(10*sin(ang)), 10-int(10*cos(ang+PI)), 10-s, 10-int(10*sin(ang+PI)), secCl);
    LedLineRGB(10-int(10*cos(ang-PI/2)), 10+s, 10-int(10*sin(ang-PI/2)), 10-int(10*cos(ang+PI/2)), 10+s, 10-int(10*sin(ang+PI/2)), secCl);
  }
  //  println("o");
}
void HelicV() {
  octaSpeed=min(in.mix.level()*TAU/20, 0.2);
  octaAng+=octaSpeed;
  float f=hue(secCl);

  for (int i = 0; i < 20; i++) {
    float ang=i*TAU/20+frameCount*TAU/40+octaAng;

    LedLineRGB(10-int(10*cos(ang)), i, 10-int(10*sin(ang)), 10+int(10*cos(ang)), i, 10+int(10*sin(ang)), color((f+i*2)%255, 255, 255));
  }
}
void CubeV() {
  //octaSpeed=min(in.mix.level()*TAU/20, 0.2);
  //octaAng+=octaSpeed;
  float s=10*cos(PI/4);
  // println(s);
  for (int i = 0; i < 4; i++) {
    float ang=i*TAU/4+frameCount*TAU/40+octaAng;

    LedLineRGB(10-int(10*cos(ang)), 10-s, 10-int(10*sin(ang)), 10-int(10*cos(ang)), 10+s, 10-int(10*sin(ang)), secCl);
    LedLineRGB(10-int(10*cos(ang)), 10-s, 10-int(10*sin(ang)), 10-int(10*cos(ang+PI/2)), 10-s, 10-int(10*sin(ang+PI/2)), secCl);
    LedLineRGB(10-int(10*cos(ang)), 10+s, 10-int(10*sin(ang)), 10-int(10*cos(ang+PI/2)), 10+s, 10-int(10*sin(ang+PI/2)), secCl);
  }
}
void Letras() {
  //for (int k = 0; k < 20; k++) {
  float f=hue(secCl);

  for (int j = 0; j < 20; j++) {
    for (int i = 1; i < 19; i++) {
      //color c=wal.get(19-i, j);
      float c=brightness(wal.get(19-i, j));
      color ct=color((i*10+f)%255, 255, c);
      cube[i][j][i]=ct;

      cube[i][j][i-1]=ct;
      //     cube[i][j][i+1]=c;
    }
  }
  //}
}
void Letras2() {
  // colorMode(HSB);
  float f=hue(secCl);
  //for (int k = 0; k < 20; k++) {
  for (int j = 0; j < 20; j++) {
    for (int i = 1; i < 19; i++) {
      float c=brightness(lz.get(19-i, j));
      color ct=color((i*10+f)%255, 255, c);
      cube[i][j][i]=ct;

      cube[i][j][i-1]=ct;
      //     cube[i][j][i+1]=c;
    }
  }
  //}
}
void city() {
  //cop(0);
  first.beginDraw();
  first.background(0, 0, 0);
  first.stroke(mainC);
  for (int i=0; i<20; i++) {
    //int hei=int(random(0, 10));
    int hei=int(gain*octaSpeed*randomGaussian());
    hei=min(hei, 20);
    hei=max(hei, 0);
    first.line(i, 20, i, 20-hei);

    /*  for (int j=0; j<hei; j++) {
     cube[i][19-j][0]=color(255);
     }
     for (int j=hei; j<20; j++) {
     cube[i][19-j][0]=color(0);
     }*/
  }

  first.endDraw();
  go(0);
}
void sineWave() {
  colorMode(HSB);
  //  cop(0);
  first.beginDraw();
  first.background(0, 0, 0);
  first.stroke(mainC);
  float f=hue(mainC);
  for (int i=0; i<20; i++) {
    //int hei=int(random(0, 10));
    int hei=int(5*randomGaussian());
    float val=min(in.mix.level(), 10);
    color ct=color((2*i+frameCount*0.1+f)%255, 255, 255);
    hei=10+int((auInc*.1+control4*.1)*sin(i*TAU/control2+frameCount*TAU/(control3)+octaAng));
    first.stroke(ct);
    first.point(i, hei);
    // hei=min(hei, 19);
    //hei=max(hei, 0);
    /*for (int j=0; j<hei; j++) {
     cube[i][19-j][0]=color(255);
     }*/
    /*   for (int j=0; j<20; j++) {
     cube[i][19-j][0]=color(0);
     }*/

    // float val=min(10*fftbin[i%20],255);
    //  cube[i][hei][0]=color((2*i+frameCount*0.1)%255, 255, 255);
  }
  first.endDraw();
  go(0);
}
void Boveda() {
  colorMode(HSB);
  //  cop(0);
  first.beginDraw();
  first.background(0, 0, 0);
  first.stroke(mainC);
  first.noFill();
  first.arc(10, 10, 20, 20, PI, TAU*0.75);
  first.arc(9, 10, 20, 20, TAU*0.75, TAU);
  int vel=max(int(control4*.2), 1);
  if (frameCount%vel>int(vel*.5)) {
    first.line(0, 10, 0, 15+5*sin(frameCount*TAU/vel));
    //  first.stroke(255,127,255);
    first.line(19, 10, 19, 15+5*sin(frameCount*TAU/vel));
  } else {
    first.line(0, 10, 0, 19);
    //  first.stroke(255,127,255);
    first.line(19, 10, 19, 19);
  }
  /*  for (int i=0; i<20; i++) {
   //int hei=int(random(0, 10));
   int hei=int(5*randomGaussian());
   float val=min(in.mix.level(), 10);
   color ct=color((2*i+frameCount*0.1)%255, 255, 255);
   hei=10+int((9)*sin(i*TAU/20+frameCount*TAU/(100)+val));
   first.stroke(ct);
   
   }*/
  first.endDraw();
  go(0);
}
void Ball() {
  //  float  BallS=max(sqrt(in.mix.level())*20,3);
  float f=hue(secCl);
  for (int k=0; k<20; k++) {
    for (int j=0; j<20; j++) {
      for (int i=0; i<20; i++) {
        float d=dist(i, j, k, 10, 10, 10);
        colorMode(HSB);
        //float h=abs(0+25*d-frameCount*spd*10)%255;
        if (d<BallS)
          cube[i][j][k]=color(f+random(0, 30)%255, 255, 255);
      }
    }
  }
}
void noiseCloud() {
  for (int k=0; k<20; k++) {
    for (int j=0; j<20; j++) {
      for (int i=0; i<20; i++) {
        float d=20*noise(i*.1+octaAng, j*1, k*.1);
        colorMode(HSB);
        //float h=abs(0+25*d-frameCount*spd*10)%255;
        if (d<BallS*2)
          cube[i][j][k]=color(255*noise(i*.1, j*.1, k*.1+frameCount*.1), 255*noise(i*.1+200, j*.1, k*.1+frameCount*.1), 255*noise(i*.1, j*.1+500, k*.1+frameCount*.1));
      }
    }
  }
}
void HueBall() {
  // println(octaAng);
  for (int k=0; k<20; k++) {
    for (int j=0; j<20; j++) {
      for (int i=0; i<20; i++) {
        float d=dist(i, j, k, 10, 10, 10);
        //  colorMode(HSB);
        float h=abs(0+25*d-150*octaAng)%255;
        cube[i][j][k]=color(255-h, 255, 255);
        // colorMode(RGB);
      }
    }
  }
}
void WhiteCouds() {

  for (int k=0; k<20; k++) {
    for (int j=0; j<20; j++) {
      for (int i=0; i<20; i++) {
        if (noise(i*.1, j*.1, k*.1+10*octaAng)>0.6) cube[i][j][k]=terCl;
      }
    }
  }
}
void GrowBall() {

  for (int k=0; k<20; k++) {
    for (int j=0; j<20; j++) {
      for (int i=0; i<20; i++) {
        float d=dist(i, j, k, 10, 10, 10);
        if (abs(int(d-2*octaAng))%5==0)cube[i][j][k]=terCl;
      }
    }
  }
}
void SineSurf() {
  float sp1=map(control2,0,127,.05, .1);
  float sp2=map(control3,0,127,.05, .1);
  float sp3=map(control4,0,127,.05, .1);
  for (int k=0; k<20; k++) {
    for (int j=0; j<20; j++) {
      for (int i=0; i<20; i++) {
        float v=(0.5+0.5*sin(i*TAU*sp1+frameCount*TAU/spd+j*TAU*sp2+k*TAU*sp3+octaAng));
        if (v<0.3)cube[i][j][k]=lerpColor(terCl, 0, v);
      }
    }
  }
}
void SineCenter() {
  float val=min(in.mix.level()*20, 4);
  float amp=control2*.3;
  float per=max(control3,0.1);
  // for (int k=0; k<20; k++) {
  for (int j=0; j<20; j++) {
    for (int i=0; i<20; i++) {
      float d=dist(i, j, 10, 10);
      float h=12+amp*sin(d*TAU/control3-5*octaAng);
      h=constrain(h,0,19);
      cube[i][int(h)][j]=terCl;
    }
  }
  //  }
}