/*
Coded by Victor Doval
 http://lightprocesses.tumblr.com/
 modified by Germán Torres for Makers UPV
 http://www.makersupv.com
 */
import ddf.minim.analysis.*;
import ddf.minim.*;
import oscP5.*;
import netP5.*;
import controlP5.*;
import java.util.Date;
import java.util.*;
import processing.serial.*;

Minim minim;  
AudioPlayer jingle;
AudioInput in;
BeatDetect beat;

//import themidibus.*; //Import the library
//MidiBus myBus; // The MidiBus
boolean midiAct=false;
int[] midiV;
FFT fftLin;
FFT fftLog;
float[] fftbin;
PFont fuente;

byte[] buffer;
OscP5 oscP5;
NetAddress myRemoteLocation;

float sep=15;
float tam=2;
float spd, spdX=0.5;
int s;
PGraphics first, wal;
PImage lz;
int fir=0, sec=0, bk;
color[][][] cube;
int xsiz=20;
int ysiz=20, zsiz=20;
float  BallS;
color mainC=color(255);
color secCl=color(255);
color terCl=color(255);
boolean auto=false;
int centerX, centerY, centerZ;
float auInc, gain=60, control2=20, gainH=1, control3=20, control4=50;

long t_elapsed_0=0, t_elapsed_1=0, t_elapsed_2=0;
long t_lim_0=0, t_lim_1=0, t_lim_2=0;

boolean visualiza3d=false;
boolean interfaz2d=true;

ControlP5 cp5;
//Textarea myTextarea;
Textlabel titulo, hora, fecha, apagado, encendido, estado;

public int margen_X, margen_Y, tam_X, tam_Y;
public int x_div=8, y_div=12;
public int[] pos_X=new int[x_div];
public int[] pos_Y=new int[y_div];
String[] dias_semana = { 
    "Domingo", "Lunes", "Martes", "Miércoles", 
    "Jueves", "Viernes", "Sábado"
};
int dia_sem;
public int aperturas_h[]={7, 7, 7, 7, 7, 7, 7}, aperturas_m[]={0, 0, 0, 0, 0, 0, 0};
public int cierres_h[]={23, 23, 23, 23, 23, 23, 23}, cierres_m[]={30,30, 30, 30, 30, 30, 30};

public int MODO=0;
public boolean AUTO=false;
public boolean cerrado=false, abierto=true, cerrar=false, abrir=false;
public String last_state="cerrado";
public String[] MODO_TEXTOS={"apagado por el usuario.", "apagado según horario.", "encendido según horario.", "encendido por el usuario."};

PImage logo_makers;

public boolean sendData=true, Request_Response=false, serial_open=false;
public boolean powerLimit=true, Limiting=false, Limit_surpassed=false, cutoff=false, Failed_Send=false;
public int powerLevelLimit=25;
public int Resolution=20;
public int cutoff_level=31;
Serial serie, serie2;
public String puerto0="", puerto1="";

public long t_ini=0, t_elapsed=0, t_lim=15000;//Temporizador de cambio de animación
public long t_ini2=0, t_elapsed2=0, t_lim2=5000;//Temporizador de cambio de color

void setup() {
    fullScreen();
    //fullScreen(P3D);
    margen_X=width/20;
    margen_Y=height/20;
    tam_X=(width-2*margen_X)/x_div;
    tam_Y=(height-2*margen_Y)/y_div;
    for (int i=0; i<x_div; i++)
    {
        pos_X[i]=margen_X+i*tam_X;
    }
    for (int i=0; i<y_div; i++)
    {
        pos_Y[i]=margen_Y+i*tam_Y;
    }

    oscP5 = new OscP5(this, 57131);
    myRemoteLocation = new NetAddress("127.0.0.1", 57130);
    buffer= new byte[20*20*20*3];
    minim = new Minim(this);
    // myBus = new MidiBus(this, "LPD8", -1);
    midiV=new int[8];
    in = minim.getLineIn();
    fftLog = new FFT( in.bufferSize(), in.sampleRate() );
    fftbin=new float[20];
    beat = new BeatDetect();
    centerX=xsiz/2;
    centerY=ysiz/2;
    centerZ=zsiz/2;
    fuente=loadFont("MunroSmall-10.vlw");
    lz=loadImage("LUZ2.jpg");

    frameRate(20);

    first=createGraphics(20, 20);
    first.beginDraw();
    first.background(0, 0, 0);
    first.endDraw();
    wal=createGraphics(20, 20);
    wal.beginDraw();
    wal.background(0, 0, 0);
    wal.stroke(255);
    wal.noFill();
    wal.textFont(fuente);
    wal.text("VIC", 1, 6);
    wal.text("DO", 1, 12);
    wal.text("VAL", 1, 18);
    wal.endDraw();
    image(wal, 0, 0);
    cube=new color[20][20][20];
    backCub(0);
    fftLog.logAverages( 22, 2 );
    println(fftLog.avgSize());
    stParticles();

    colorMode(HSB);
    if (interfaz2d) {

        cp5 = new ControlP5(this);
        cp5.addButton("Exit")
            .setSwitch(false)
            .setPosition(pos_X[x_div-1], pos_Y[0])
            .setSize(tam_X, tam_Y)
            ;
        cp5.addButton("Serial_Toggle")
            .setSwitch(false)
            .setPosition(pos_X[x_div-3], pos_Y[0])
            .setSize(tam_X, tam_Y)
            ;
        cp5.addButton("Auto")
            .setSwitch(false)
            .setPosition(pos_X[x_div-2], pos_Y[y_div-2])
            .setSize(tam_X, tam_Y)
            ;
        cp5.addButton("ON")
            .setSwitch(false)
            .setPosition(pos_X[x_div-2], pos_Y[3])
            .setSize(tam_X, tam_Y)
            ;
        cp5.addButton("OFF")
            .setSwitch(false)
            .setPosition(pos_X[x_div-2], pos_Y[4])
            .setSize(tam_X, tam_Y)
            ;
        titulo=cp5.addTextlabel("titulo_lab")
            .setText("HCube v1.1")
            .setPosition(pos_X[0], pos_Y[0])
            .setColorValue(0xffffffff)
            .setFont(createFont("Helvetica", tam_Y))
            ;
        hora=cp5.addTextlabel("hora_lab")
            .setText("Hora: "+hour()+":"+minute()+":"+second())
            .setPosition(pos_X[0], pos_Y[2])
            .setColorValue(0xffffffff)
            .setFont(createFont("Helvetica", tam_Y/2))
            ;
        dia_sem = dow(day(), month(), year());
        fecha=cp5.addTextlabel("fecha_lab")
            .setText("Fecha: " +day()+"-"+month()+"-"+year()+" ("+dias_semana[dia_sem]+")")
            .setPosition(pos_X[0], pos_Y[3])
            .setColorValue(0xffffffff)
            .setFont(createFont("Helvetica", tam_Y/2))
            ;
        apagado=cp5.addTextlabel("apagado_lab")
            .setText("Hoy HCube se apaga a las "+cierres_h[dia_sem]+":"+cierres_m[dia_sem])
            .setPosition(pos_X[0], pos_Y[4])
            .setColorValue(0xffff0000)
            .setFont(createFont("Helvetica", tam_Y/2))
            ;
        encendido=cp5.addTextlabel("encendido_lab")
            .setText("Hoy HCube se enciende a las "+aperturas_h[dia_sem]+":"+aperturas_m[dia_sem])
            .setPosition(pos_X[0], pos_Y[5])
            .setColorValue(0xff00ff00)
            .setFont(createFont("Helvetica", tam_Y/2))
            ;
        estado=cp5.addTextlabel("estado_lab")
            .setText("HCube se encuentra ")
            .setPosition(pos_X[3], pos_Y[5])
            .setColorValue(0xffffffff)
            .setFont(createFont("Helvetica", tam_Y/2))
            ;
        logo_makers=loadImage("makersupv.png");
        List pList_0=Arrays.asList(Serial.list());
        List pList_1=Arrays.asList(Serial.list());

        cp5.addScrollableList("lista_puertos_0")
            .setPosition(pos_X[3], pos_Y[1])
            .setSize(tam_X*2, tam_Y*3)
            .setBarHeight(tam_Y/2)
            .setItemHeight(tam_Y/2)
            .addItems(pList_0);

        cp5.addScrollableList("lista_puertos_1")
            .setPosition(pos_X[5], pos_Y[1])
            .setSize(tam_X*2, tam_Y*3)
            .setBarHeight(tam_Y/2)
            .setItemHeight(tam_Y/2)
            .addItems(pList_0);
    }
    t_ini=millis();
    t_ini2=millis();
}

int nP=400;
Mover[] movers = new Mover[nP];
PVector wind;
void stParticles() {

    for (int i = 0; i < movers.length; i++) {
        movers[i] = new Mover(i);
    }
    wind = new PVector(0.0, 2, -0);
}
void draw() {
    t_elapsed=millis()-t_ini;
    t_elapsed2=millis()-t_ini2;
    fftLog.forward( in.mix );
    beat.detect(in.mix);
    if (midiAct)midiCont();
    auInc=in.mix.level()*gain;
    if (auInc<=0.01)
    {
        auInc=random(0.0, 3.0);
    }
    BallS=max(sqrt( auInc), 3);

    for (int i = 0; i < fftLog.avgSize(); i++) {

        fftbin[i]= fftLog.getAvg(i);
    }
    octaSpeed=min( auInc*TAU/(20*gainH*30f), 0.2);
    if (octaSpeed<=0.0075)
    {
        octaSpeed=0.0075+random(-0.005, 0.01);
    }
    if ((random(0.0, 1)>0.99)&&(t_elapsed>=t_lim))
    {
        t_ini=millis();
        t_elapsed=0;
        cambia=true;
    }
    if ((random(0.0, 1)>0.99)&&(t_elapsed2>=t_lim2))
    {
        t_ini2=millis();
        t_elapsed2=0;
        mainCchange();
        terCchange();
        secCchange();
    }
    octaAng+=octaSpeed;
    spd=map(octaSpeed, 0, 0.2, 0, 1);
    spdX=map(mouseX, 0, height, 0, 1);
    dia_sem = dow(day(), month(), year());

    switch(MODO)
    {
    case 0:
        //User OFF
        cerrado=true;
        abierto=false;
        if (AUTO)
        {
            MODO=1;
        }
        break;
    case 1:
        //Auto OFF
        blackout();
        check_time();
        if (cerrar)
        {
            blackout();
        }
        if (abrir)
        {   
            abrir=false;
            MODO=2;
            abierto=true;
            cerrado=false;
        }
        if (!AUTO)
        {
            MODO=0;
        }
        break;
    case 2:
        //Auto ON
        AutoMode2();
        check_time();
        if (cerrar)
        {
            cerrar=false;
            MODO=1;
            abierto=false;
            cerrado=true;
        }
        if (!AUTO)
        {
            MODO=3;
        }
        break;
    case 3:
        //User ON
        AutoMode2();
        abierto=true;
        cerrado=false;
        if (AUTO)
        {
            MODO=2;
        }
        break;
    }
    GUI_update();
    FirS();

    if (serial_open) {
        sendData(cube);
    } else
    {
        sendValues(cube);
    }
    if (interfaz2d)
    {
        background(0);
        noStroke();
        textSize(tam_Y/2);
        text(frameRate, pos_X[x_div-3], pos_Y[y_div-1]);
    }
    if (visualiza3d) {
        visualize_3d();
    }
}