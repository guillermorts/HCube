void LedLine(int ox, int oy, int oz, float fx, int fy, float fz) {
    float nx=fx-ox;
    int ny=fy-oy;
    float nz=fz-oz;
    float mx=max(abs(nx), abs(ny));
    mx=max(abs(mx), abs(nz));
    float interV=1/ (2*mx);
    for (int i=0; i<2*mx; i++) {
        if (int(ox+interV*nx*i)>-1&&int(ox+interV*nx*i)<20) {
            ;
            if (int(oy+interV*ny*i)>-1&&int(oy+interV*ny*i)<20) {
                if (int(oz+interV*nz*i)>-1&&int(oz+interV*nz*i)<20)
                    cube[int(ox+interV*nx*i)][int(oy+interV*ny*i)][int(oz+interV*nz*i)]=mainC;
            }
        }
    }
}
void LedLineRGB(float ox, float oy, float oz, float fx, float fy, float fz, color cl  ) {
    float nx=fx-ox;
    float ny=fy-oy;
    float nz=fz-oz;
    float mx=max(abs(nx), abs(ny));
    mx=max(abs(mx), abs(nz));
    float interV=1/ (2*mx);
    for (int i=0; i<2*mx; i++) {
        if (int(ox+interV*nx*i)>-1&&int(ox+interV*nx*i)<20) {
            ;
            if (int(oy+interV*ny*i)>-1&&int(oy+interV*ny*i)<20) {
                if (int(oz+interV*nz*i)>-1&&int(oz+interV*nz*i)<20)
                    cube[int(ox+interV*nx*i)][int(oy+interV*ny*i)][int(oz+interV*nz*i)]=cl;
            }
        }
    }
}
void backCubFade(color c, float n) {
    for (int k=0; k<20; k++) {

        for (int j=0; j<20; j++) {
            for (int i=0; i<20; i++) {
                //fill(0);
                color ct=cube[i][j][k];
                cube[i][j][k]=lerpColor(c, ct, n);
            }
        }
    }
}
void backCubCopy(color c, float n) {
    for (int k=0; k<20; k++) {
        for (int j=0; j<20; j++) {
            for (int i=0; i<20; i++) {
                //fill(0);
                // color ct=cube[i][j][k];
                cube[i][j][k]=c;
            }
        }
    }

    go2();
}
void go2() {
    //  cop(off);
    // first.loadPixels();
    for (int i=0; i<20; i++) {

        for (int j=0; j<20; j++) {
            // color c=first.get(i, j);
            color c=first.pixels[i+j*20];
            cube[i][j][0]=c;
            cube[i][j][19]=c;
            cube[19][j][19-i]=c;
            cube[0][j][19-i]=c;
        }
    }
}
void backCub(color c) {
    for (int k=0; k<20; k++) {

        for (int j=0; j<20; j++) {
            for (int i=0; i<20; i++) {
                //fill(0);
                cube[i][j][k]=c;
            }
        }
    }
}

void go(int off) {
    cop(off);
    first.loadPixels();
    for (int i=0; i<20; i++) {

        for (int j=0; j<20; j++) {
            // color c=first.get(i, j);
            color c=first.pixels[i+j*20];
            cube[i][j][0]=c;
        }
    }
}

void cop(int off) {
    if (bk!=2) {
        for (int k=19; k>0; k--) {
            for (int j=0; j<20; j++) {
                for (int i=0; i<20; i++) {
                    cube[i][j][k]=cube[i][j][k-1];
                }
            }
        }
    }
}

void mainCchange() {
    mainC=color(random(0, 255), 255, 255);
}
void secCchange() {
    secCl=color(random(0, 255), 255, 255);
}
void terCchange() {
    terCl=color(random(0, 255), 255, 255);
}

// d = day in month
// m = month (January = 1 : December = 12)
// y = 4 digit year
// Returns 0 = Sunday .. 6 = Saturday
public int dow(int d, int m, int y) {
    if (m < 3) {
        m += 12;
        y--;
    }
    return (d + int((m+1)*2.6) +  y + int(y/4) + 6*int(y/100) + int(y/400) + 6) % 7;
}

public void GUI_update()
{   
    background(0);
    noStroke();
    estado.setText("HCube se encuentra "+MODO_TEXTOS[MODO]);

    hora.setText("Hora: "+hour()+":"+minute()+":"+second());
    fecha.setText("Fecha: " +day()+"-"+month()+"-"+year()+" ("+dias_semana[dia_sem]+")");
    apagado.setText("Hoy HCube se apaga a las "+cierres_h[dia_sem]+":"+cierres_m[dia_sem]);
    encendido.setText("Hoy HCube se enciende a las "+aperturas_h[dia_sem]+":"+aperturas_m[dia_sem]);
    image(logo_makers, width-margen_X-tam_X, height-margen_Y-tam_Y*3, tam_X, tam_X);
}

public void check_time()
{
    //println("Son las: "+(hour()*60+minute()));
    //println("Se apaga a las: "+(cierres_h[dia_sem]*60+cierres_m[dia_sem]));
    //println("Se enciende a las: "+(aperturas_h[dia_sem]*60+aperturas_m[dia_sem]));
    if (abierto)
    {
        if ((hour()*60+minute())>=(cierres_h[dia_sem]*60+cierres_m[dia_sem]))
        {
            abrir=false;
            cerrar=true;
        }
    }
    if (cerrado)
    {
        if ((((hour()*60+minute())>=(aperturas_h[dia_sem]*60+aperturas_m[dia_sem]))&&(hour()*60+minute())<(cierres_h[dia_sem]*60+cierres_m[dia_sem])))
        {
            abrir=true;
            cerrar=false;
        }
        if (dia_sem==0)
        {
            abrir=false;
            cerrar=true;
        }
    }
}

public void blackout()
{
    for (int i=0; i<20; i++)
    {
        for ( int j=0; j<20; j++)
        {
            for ( int k=0; k<20; k++)
            {
                cube[k][j][i]=color(0);
            }
        }
    }
}

void sendData( color[][][] cuboled)
{
    //Data ordering
    int capas=Resolution/2;
    int led = 0; //Numero de led
    int ii = 0; //Columna
    int jj = 0 ; //Fila
    int capa = Resolution/2-1;
    int res = Resolution;
    color[] final_ordered = new color[Resolution/2*Resolution*Resolution];
    color[] final2_ordered = new color[Resolution/2*Resolution*Resolution];
    while (led<capas*Resolution*Resolution) {

        final_ordered [led] = cuboled [ii][jj][capa];
        led++;
        if (ii % 2 == 0) {
            jj++;
        } else {
            jj--;
        } 


        if (jj == -1) {
            jj++;
            ii++;
        }
        if (jj == res) {
            jj--;
            ii++;
        }
        if (ii==Resolution) {
            ii=0;
            jj=0;                    
            capa--;
        }
    }

    led = 0; //Numero de led
    ii = 0; //Columna
    jj = 0 ; //Fila
    capa = (Resolution/2);

    while (led<capas*Resolution*Resolution) {

        final2_ordered [led] = cuboled [ii][jj][capa];
        led++;
        if (ii % 2 == 0) {
            jj++;
        } else {
            jj--;
        } 
        if (jj == -1) {
            jj++;
            ii++;
        }
        if (jj == res) {
            jj--;
            ii++;
        }
        if (ii==Resolution) {
            ii=0;
            jj=0;                    
            capa++;
        }
    }

    byte[] toSend = new byte[3* Resolution/2 * Resolution * Resolution];
    byte[] toSend2 = new byte[3 * Resolution / 2 * Resolution * Resolution];
    //Cutoff limit routine
    for (int k=0; k<(3* Resolution/2 * Resolution * Resolution); k+=3) {
        if (cutoff)
        {
            if ((byte)(int)(red(final_ordered [k / 3])*255)<cutoff_level)
            {
                toSend[k]=0;
            } else
            {
                toSend [k] = (byte)(int)(red(final_ordered [k / 3])*255);
            }
            if ((byte)(int)(green(final_ordered [k / 3])*255)<cutoff_level)
            {
                toSend[k+1]=0;
            } else
            {
                toSend [k+1] = (byte)(int)(green(final_ordered [k / 3])*255);
            }
            if ((byte)(int)(blue(final_ordered [k / 3])*255)<cutoff_level)
            {
                toSend[k+2]=0;
            } else
            {
                toSend [k+2] = (byte)(int)(blue(final_ordered [k / 3])*255);
            }
        } else
        {
            toSend [k] = (byte)(int)(red(final_ordered [k / 3])*255);
            toSend [k + 1] = (byte)(int)(green(final_ordered [k / 3])*255);
            toSend [k + 2] = (byte)(int)(blue(final_ordered [k / 3])*255);
        }
    }

    for (int k=0; k<(3* Resolution/2 * Resolution * Resolution); k+=3) {
        if (cutoff)
        {
            if ((byte)(int)(red(final2_ordered [k / 3])*255)<cutoff_level)
            {
                toSend2[k]=0;
            } else
            {
                toSend2 [k] = (byte)(int)(red(final2_ordered [k / 3])*255);
            }
            if ((byte)(int)(green(final2_ordered [k / 3])*255)<cutoff_level)
            {
                toSend2[k+1]=0;
            } else
            {
                toSend2 [k+1] = (byte)(int)(green(final2_ordered [k / 3])*255);
            }
            if ((byte)(int)(blue(final2_ordered [k / 3])*255)<cutoff_level)
            {
                toSend2[k+2]=0;
            } else
            {
                toSend2 [k+2] = (byte)(int)(blue(final2_ordered [k / 3])*255);
            }
        } else
        {
            toSend2 [k] = (byte)(int)(red(final2_ordered [k / 3])*255);
            toSend2 [k + 1] = (byte)(int)(green(final2_ordered [k / 3])*255);
            toSend2 [k + 2] = (byte)(int)(blue(final2_ordered [k / 3])*255);
        }
    }
    //Power limiting routine
    long sum = 0;
    long maxVal =255*3*Resolution*Resolution*Resolution;
    for (int i = 0; i < 3 * Resolution / 2 * Resolution * Resolution; i++)
    {
        sum += toSend[i] + toSend2[i];
    }
    float porcent = ((float)sum / (float)maxVal);
    float porcent_limit = ((float)powerLevelLimit / (float)100);

    if (porcent >= porcent_limit)
    {
        Limit_surpassed = true;
        if (powerLimit)
        {
            Limiting = true;
            for (int i = 0; i < 3 * Resolution / 2 * Resolution * Resolution; i++)
            {
                toSend[i] = (byte)(int)((float)toSend[i] * (float)((float)sum / (float)maxVal));
                toSend2[i] = (byte)(int)((float)toSend2[i] * (float)((float)sum / (float)maxVal));
            }
        } else
        {

            Limiting = false;
        }
    } else
    {
        Limit_surpassed = false;
        Limiting = false;
    }
    //Serial handling
    if (sendData)
    {
        if (Request_Response)
        {
            int numS1 = 0;
            int numS2 = 0;
            //numS1 = serie.available();
            //numS2 = serie2.available();

            if (numS1 > 0 && numS2 > 0)
            {
                // serie.clear();
                // serie2.clear();
                serie.write(toSend);
                serie2.write(toSend2);
                sendData = true;
            } else {
                Failed_Send = true;
            }
        } else
        {
            serie.write(toSend);
            serie2.write(toSend2);
            sendData = true;
        }
    }
}

void visualize_3d()
{

    background(0);
    noStroke();
    translate(width/2, height/2);
    rotateX(map(mouseY, 0, width, -TAU/20, TAU/20));
    rotateY(map(mouseX, 0, width, 0, TAU));
    translate(-10*sep, -10*sep, -10*sep);
    for (int k=0; k<20; k++) {

        for (int j=0; j<20; j++) {
            for (int i=0; i<20; i++) {
                //fill(0);
                fill(cube[i][j][k]);
                pushMatrix();
                translate(i*sep, j*sep, k*sep);
                box(tam);
                //point(0
                popMatrix();
            }
        }
    }
}

void Prim() {
    backCub(0);
    for (int k=0; k<20; k++) {
        for (int j=0; j<20; j++) {
            for (int i=0; i<20; i++) {

                Select(s, i, j, k);
            }
        }
    }
}
void Select(int e, int i, int j, int k) {
    switch(e) {
    case 0:
        if (noise(i*.1, j*.1, k*.1+frameCount*.1)>0.6) cube[i][j][k]=color(255);

        break;
    case 1:
        float d=dist(i, j, k, 10, 10, 10);
        if (int(d-frameCount*spd)%5==0)cube[i][j][k]=color(255);
        break;
    case 2:
        CBall(i, j, k);
        break;
    case 3:
        HBall(i, j, k);
        break;
    case 4:
        LBall(i, j, k);
        break;  
    case 5 :
        SineSurf(i, j, k);
        break;
    case 6:
        Plane(i, j, k);
        break;
    case 7:
        Tunnel(i, j, k);
    case 8:
        cube[i][j][k]=color(255*noise(i*.1, j*.1, k*.1+frameCount*.1), 255*noise(i*.1+200, j*.1, k*.1+frameCount*.1), 255*noise(i*.1, j*.1+500, k*.1+frameCount*.1));

        break;
    }
}
void CBall(int i, int j, int k) {
    float d=dist(i, j, k, 10, 10, 10);
    if (int(d-frameCount*spd)%5==0)  cube[i][j][k]=color(255, 0, 0);
    if (int(d-frameCount*spd+1)%5==0)cube[i][j][k]=color(0, 255, 0);
    if (int(d-frameCount*spd+2)%5==0)cube[i][j][k]=color(0, 0, 255);
}
void HBall(int i, int j, int k) {
    float d=dist(i, j, k, 10, 10, 10);
    colorMode(HSB);
    float h=abs(0+25*d-frameCount*spd*10)%255;
    cube[i][j][k]=color(255-h, 255, 255);
    colorMode(RGB);
}
void LBall(int i, int j, int k) {
    float d=dist(i, j, k, 10, 10, 10);
    colorMode(HSB);
    float h=abs(0+25*d-frameCount*spd*10)%255;
    cube[i][j][k]=color(255-h);
    colorMode(RGB);
}
void SineSurf(int i, int j, int k) {
    cube[i][j][k]=color(127+127*sin(i*TAU/40+frameCount*TAU*spd+j*TAU/20+k*TAU/10));
}
void Plane(int i, int j, int k) {
    if (i==0)cube[i][j][k]=color(255);
    if (i==19)cube[i][j][k]=color(255);
    if (j==0)cube[i][j][k]=color(255);
    if ((k+int(frameCount*spd))%20==0)cube[i][j][k]=color(255);
}
void Tunnel(int i, int j, int k) {
    color c=first.get(i, j);
    cube[i][j][k]=color(random(0, 255), random(0, 255), random(0, 255));
}



float heliSpeed, heliAng;

void HelicoFill() {
    heliAng+=heliSpeed;
    heliSpeed=auInc*0.02;
    float s=control2*.3+auInc  ;
    first.beginDraw();
    first.background(0, 0, 0);
    first.stroke(mainC);
    first.noFill();
    first.translate(10, 10);
    first.rotate(heliAng);
    first.line(-s, 0, s, 0);
    first.endDraw();
    go(0);
    //cop();
}
void Caves() {
    first.beginDraw();
    first.background(0, 0, 0);
    first.stroke(mainC);
    first.noFill();
    first.translate(10, 10);
    //first.rotate(frameCount*PI/(50*spd));
    float rad=(control2*.9)*sin(frameCount*PI/(550)+octaAng);
    // first.ellipse(sqrt(BallS), BallS, rad, rad);
    //first.line(sqrt(BallS),BallS-rad
    first.ellipse(-sqrt(BallS)*0, -BallS*0, rad, rad);
    first.endDraw();
    go(0);
    //cop();
}
void Sound1() {
    first.beginDraw();
    first.background(0, 0, 0);
    first.stroke(mainC);
    first.noFill();
    for (int i = 0; i < 20 - 1; i++)
    {
        first.line( i, 10 + in.left.get(i)*gain, i+1, 10 + in.left.get(i+1)*gain );
        //  line( i, 10 + in.right.get(i)*10, i+1, 300 + in.right.get(i+1)*10 );
    }
    // first.translate(10, 10);
    //first.rotate(frameCount*PI/(50*spd));
    float rad=20*sin(frameCount*PI/(50*spd));
    //  first.ellipse(0, 0, rad, rad);
    first.endDraw();
    go(0);
    //cop();
}
void Sound2() {
    first.beginDraw();
    first.colorMode(HSB);
    first.background(0, 0, 0);
    first.noFill();
    float c=hue(mainC);
    for (int i = 0; i < fftLog.avgSize(); i++) {
        first.stroke(c+30*i/20., 255, 255);
        first.line( i, 19, i, height-pow(fftLog.getAvg(i), 0.3)*gain*sqrt(i+1)*2);
    }

    first.endDraw();
    go(-1);
    //cop();
}
boolean cambia=false;
void AutoMode() {
    int f=0;
    int c=0;
    if ( beat.isOnset()||cambia ) {  
        cambia=false;
        f=int(random(0, 8));
        c=int(random(0, 8));
        if (f==0) {
            s=int(random(1, 9));
            if (random(0, 1.5)>1) {
                bk=3;
                fir=1;
                sec=1;
            } else {
                bk=2;
            }
        }
        if (f==4) {
            s=int(random(1, 9));
            if (random(0, 1.5)>1) {
                bk=3;
                fir=1;
                sec=1;
            } else {
                bk=2;
            }
        }
        if (f==1)fir=int(random(1, 9));
        if (f==2)sec=int(random(1, 9));
        if (f==3)bk=int(random(2, 3.5));
        if (fir>1||fir<8)bk=min(bk, 2);
        if (c==1) mainCchange();  
        if (c==2)secCchange();

        if (c==3)terCchange();
        println("change", "bk:", bk);
    }
}
boolean craz;
void Crazy() {
    mainCchange();  
    secCchange();
    terCchange();
}
void AutoMode2() {

    if ( beat.isOnset()||cambia ) {  
        int se=int(random(0, 80));
        cambia=false;
        if (se<10) {
            s=int(random(2, 9));
            fir=1;
            sec=1;
            bk=3;
        }

        if (se>10&&se<20) {
            fir=int(random(2, 9));
            s=1;
            sec=1;
            bk=1;
        }
        if (se>30&&se<40) {
            sec=int(random(2, 9));
            s=1;
            fir=1;
            bk=1;
        }
    }
}

void sendValues(color cubo[][][]) {
    OscMessage oscCapa =new OscMessage("/cubo");
    for (int i=0; i<20; i++)
    {
        for ( int j=0; j<20; j++)
        {
            for ( int k=0; k<20; k++)
            {

                buffer[i*1200+j*60+k*3]=byte(int(red(cubo[k][j][i])));
                buffer[i*1200+j*60+k*3+1]=byte(int(green(cubo[k][j][i])));
                buffer[i*1200+j*60+k*3+2]=byte(int(blue(cubo[k][j][i])));
            }
        }
    }
    OscMessage oscMess3 = new OscMessage("/capa");
    oscMess3.add(buffer);
    oscP5.send(oscMess3, myRemoteLocation);
    //println(frameRate);
}