void FirS() {
    switch(bk) {
    case 0:
        backCub(0);
        break;
    case 1:
        backCubFade(000000, 0.4); 
        break;
    case 2:
        backCubCopy(000000, 0); 
        break;
    }

    switch(sec) {
    case 1:
        //voice();
        break; 
    case 2:
        voice2();
        break;
    case 0:
        Letras();
        break;

    case 3:
        TetraV();
        break;
    case 4:
        OctaV();
        break;
    case 5:
        HelicV();
        break;
    case 6:
        CubeV();
        break;
    case 7:
        Ball();
        break;
    case 8:
        Letras2();
        break;
    case 9:

        break;
    }


    switch(fir) {

    case 1:

        break;
    case 2:
        SineSurf();
        break;
    case 3:
        SineCenter();
        break;
    case 4:
        noiseCloud(); 
        break;
    case 5:
        WhiteCouds();
        break;
    case 6:
        HueBall();
        break;
    case 7:
        GrowBall();
        break;
    case 8:
        particles();
        break;
    case 9:
        //Prim();
        break;
    case 0:

        break;
    }
    switch(s) {
    case 1:

        break;
    case 2:
        Sound2();
        break;
    case 3:
        city();
        break;
    case 4:
        HelicoFill();
        break;
    case 5:
        Caves();
        break;  
    case 6:
        sineWave();  
        break;
    case 7:
        Boveda();
        break;
    case 8:
        Sound1();
        break;
    case 9:

        // HueBall();
        break;
    case 0:

        break;
    }
}
//Exit Button
public void Exit() {
    println("Exiting...");
    exit();
}
//Auto button
public void Auto() {
    AUTO=!AUTO;
}
//ON button
public void ON() {
    AUTO=false;
    MODO=3;
    cerrar=false;
    abrir=false;
    abierto=true;
    cerrado=false;
}
//OFF button
public void OFF() {
    AUTO=false;
    MODO=0;
    cerrar=false;
    abrir=false;
    abierto=false;
    cerrado=true;
}
//Serial-toggle
public void Serial_Toggle()
{
    if (!serial_open)
    {
        try {
            serie = new Serial(this, puerto0, 9600);
            serie2 = new Serial(this, puerto1, 9600);
            serial_open=true;
        }
        catch(Exception e)
        {
            println("Los puertos especificados no están disponibles!");
            exit();
        }
    } else
    { 
        if (serie.active())
        {
            serial_open=false;
            serie.stop();
            serie2.stop();
        }
    }
}

void lista_puertos_0(int n) {
puerto0=(String)cp5.get(ScrollableList.class, "lista_puertos_0").getItem(n).get("name");
println("Seleccionado el puerto 0: "+puerto0);
}

void lista_puertos_1(int n) {
puerto1=(String)cp5.get(ScrollableList.class, "lista_puertos_1").getItem(n).get("name"); 
println("Seleccionado el puerto 1: "+puerto1);
}