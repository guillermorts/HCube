void keyPressed() {
  switch(key) {
  case '0' :
  case '1' :
  case '2' :
  case '3' :
  case '4' :
  case '5' :
  case '6' :
  case '7' :
  case '8' :

    s=int(str(key));

    break;
      case '9' :
      mainCchange();
      break;
  case 'a':
    fir=1;
    break;
  case 's':
    fir=2;
    break;
  case 'd':
    fir=3;
    break;
  case 'f':
    fir=4;
    break;
  case 'g':
    fir=5;
    break;
      case 'h':
    fir=6;
    break;
      case 'j':
    fir=7;
    break;
      case 'k':
    fir=8;
    break;
      case 'l':
   // fir=9;
    terCchange();
    break;
      case 'ñ':
    fir=0;
    break;
      
  case 'q':
    sec=1;
    break;
  case 'w':
    sec=2;
    break;
  case 'e':
    sec=3;
    break;
  case 'r':
    sec=4;
    break;
  case 't':
    sec=5;
    break;
  case 'y':
    sec=6;
    break;  
  case 'u':
    sec=7;
    break;  
  case 'i':
    sec=8;
    break;  
  case 'o':
   // sec=9;
    secCchange();
    break;  
  case 'p':
    sec=0;
    break;
  case 'z':
    bk=0;
    break;  
  case 'x':
    bk=1;
    break;  
  case 'c':
    bk=2;
    break;
     case 'v':
    bk=3;
    break;
    case 'm':
    auto=!auto;
    println("AutoMode is: "+auto);
    break;
    case ',':
    ResetPartic();
    break;
    
    case '+':
    gain+=10;
    println("gain:",gain);
    break;
    case '-':
    if(gain>0){
    gain-=10;
  }else{gain=0;}
      println("gain:",gain);
    break;
     case '/':
    cambia=true;
    break;
      case '=':
    craz=!craz;
    break;
  }
}