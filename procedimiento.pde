int r;
float ballX [];
int  direc [];
float largo1, ancho1, px1, py1, velocidad = 2, cambioy, py2;
int color1 = 200, color2 = 200, color3 = 200, liminf, limsup, calibri, calibri2, calibri3;
int check[];
float retraso[];
float n, barramer, base, tope = 10, manometroH, manometroW, magnitudx, magnitudy;
String textrt = "";

class Guipro {

  public int transforselected (int x1, int y1) {
    int n = 0;

    //isovolumetrica
    if (x1 >= 3 && x1 <= 124 && y1 >= 293 &&  y1 <= 339) {
      n = 1;
    }

    //isotermica
    if (x1 >= 3 && x1 <= 124 && y1 >= 357 &&  y1 <= 403) {
      n = 2;
    }

    //isobarica
    if (x1 >= 136 && x1 <= 256 && y1 >= 293 &&  y1 <= 339) {
      n = 3;
    }

    //adiabatica
    if (x1 >= 136 && x1 <= 256 && y1 >= 357 &&  y1 <= 403) {
      n = 4;
    } 
    return n;
  }

  public void recipiente(int x1, int y1, int ancho, int largo, int anchotap) {
    //recipiente

    strokeWeight(1);
    fill(135);
    rect(x1, y1, ancho, largo);
    stroke(0);
    ellipse(x1 + ancho/2, y1 + largo, ancho, anchotap);

    //vidrio
    fill(250, 150); 
    noStroke();
    rect(x1, y1, ancho, largo);
    arc(x1 + ancho/2, y1 + largo, ancho, anchotap, 0, PI);
    strokeWeight(3);

    stroke(0);
    fill(220);
    ellipse(x1 + ancho/2, y1, ancho, anchotap);

    fill(34, 113, 179);
    ellipse(x1 + ancho/2, y1, ancho, anchotap);
    float r = (0.3*anchotap);
    strokeWeight(1);
    circle(x1 + ancho/2, y1 - 80, r);
    circle(x1 + ancho/2, y1, r);
    noStroke();
    rect(x1 + ancho/2 - r/2, y1 - 80, r, 80);
    stroke(0);
    circle(x1 + ancho/2, y1 - 80, r);
  }

  public void recipiente2d(int x, int y, int anchobor, int largobor, int largobor2, int trans, boolean setvisible) {
    
    if(setvisible){
    switch(trans) {
    case 1: 
      noStroke();
      fill(200);  
      rect(x, y, anchobor, largobor);
      rect(x + largobor2, y, anchobor, largobor);
      rect(x, y, largobor2 + anchobor, anchobor);
      rect(x, y + largobor, largobor2 + anchobor, anchobor);

      //tubo de escape
      noStroke();
      fill(227, 228, 229);
      rect(x - 50, y + largobor - 20, 50, 20 );
      ellipse( x - 50, y + largobor - 10, 40, 20);
      rect( x - 70, y + largobor - 50, 20, 40);

      //medidor de presion
      fill(250);
      circle(x-60, y + largobor - 75, 80);
      strokeWeight(2);
      stroke(0);
      line(x-60, y + largobor - 75, x - 60 + magnitudx, y + largobor - 75 + magnitudy );
      manometroH = 30;
      manometroW = 30;
      fill(0);
      strokeWeight(1);
      textSize(10);
      text(textrt, x-60 - (textWidth(textrt))/2, y + largobor - 50);

      //termometro
      fill(250);
      noStroke();
      rect(x + largobor2 + anchobor + 25, y, 16, largobor + anchobor, 4);
      circle(x + largobor2 + anchobor + 33, y +  largobor + anchobor - 15, 35);
      fill(200);
      rect(x + largobor2 + anchobor + 28, y + 10, 10, largobor + anchobor - 20, 4);

      //color de la barra
      fill(color1, color2, color3);
      circle(x + largobor2 + anchobor + 33, y +  largobor + anchobor - 15, 25);
      rect(x + largobor2 + anchobor + 28, y + tope, 10, base); 
      barramer = largobor + anchobor - 37;
      stroke(0);
      fill(200);

       py2 = y+anchobor;
       py1 = y+anchobor;
  
      break; 

    case 2:
      noStroke();
      fill(200);
      rect( x + (largobor2 + anchobor)/2 - anchobor/4, y + cambioy - 80, anchobor/2, 80 ); // cabeza 

      //laterales
      rect(x, y, anchobor, largobor);
      rect(x + largobor2, y, anchobor, largobor);


      //parte inferior 
      rect(x, y + largobor, largobor2 + anchobor, anchobor);


      // parte superior (movil)
      stroke(250, 0, 0);
      rect(x + anchobor, y + cambioy, largobor2 - anchobor, anchobor);
      stroke(0);
      
      
      //techo
      py2=y+cambioy+anchobor;
      py1 = y + anchobor;

      //tubo de escape
      noStroke();
      fill(227, 228, 229);
      rect(x - 50, y + largobor - 20, 50, 20 );
      ellipse( x - 50, y + largobor - 10, 40, 20);
      rect( x - 70, y + largobor - 50, 20, 40);

      //medidor de presion
      fill(250);
      circle(x-60, y + largobor - 75, 80);
      strokeWeight(2);
      stroke(0);
      line(x-60, y + largobor - 75, x - 60 + magnitudx, y + largobor - 75 + magnitudy );
      manometroH = 30;
      manometroW = 30;
      fill(0);
      strokeWeight(1);

      textSize(10);
      text(textrt, x-60 - (textWidth(textrt)/2), y + largobor - 50);


      //termometro
      fill(250);
      noStroke();
      rect(x + largobor2 + anchobor + 25, y, 16, largobor + anchobor, 4);
      circle(x + largobor2 + anchobor + 33, y +  largobor + anchobor - 15, 35);

      fill(200);
      rect(x + largobor2 + anchobor + 28, y + 10, 10, largobor + anchobor - 20, 4);

      //color de la barra
      fill(color1, color2, color3);

      rect(x + largobor2 + anchobor + 28, y + tope, 10, base, 4); 
      barramer = largobor + anchobor - 37;
      circle(x + largobor2 + anchobor + 33, y +  largobor + anchobor - 15, 25);

      stroke(0);
      fill(200);
      break; 

    case 3: 

      break;
    }
    }
  }

  public void esferas(float x1, float y1, float n, float ancho, float largo, float techo) {

    fill(200); 
     randomSeed(2);
    ancho1 = ancho;
    largo1 = largo;
    
    px1 = x1;
    //py1 = y1;
    
   
    r = (int(n))* 2;
    ballX= new float[r];

    direc = new int[int(n)]; // dirección de las particulas 
    check = new int [r];
    retraso  = new float [r];

    for ( int i = 0; i < r - 1; i += 2) {

      ballX[i] = random(x1 + 12, x1 + ancho-12);
      ballX[i+1] = random(techo + 12, y1 + largo-12);

      // 10 es el valor del radio + 2 para que no aparezca en un borde, todo esto es para evitar bugs
    }

    //las direcciones se generan aleatoriamente también
    for (int i = 0; i< n; ++i) {
      direc[i] = int(random(1, 9));
    }

    for (int i = 0; i < r; ++i) {
      check[i] = 0;
    }
  }

  //este metodo va cambiando la posicion de las esferas
  
  
  public void move() {
    float dirx = 0, diry = 0;
    int j = 0;
    for (int i = 0; i < r; i += 2) {
      if ( ballX[i]<= px1+10 && ballX[i] >= px1+10 - 30 || ballX[i] >= px1 + ancho1 - 10 && ballX[i] <= px1 + ancho1 - 10 + 30) {   //ballX[i]<= px1+7 || ballX[i] >= px1 + ancho1 - 7

        dirx *= -1; 
        switch (direc[j]) {
        case 1:
          direc[j] = 5;
          break; 
        case 2: 
          direc[j] = 6;
          break; 
        case 3: 
          direc[j] = 7; 
          break; 
        case 4: 
          direc[j] = 8;
          break; 
        case 5: 
          direc[j] = 1; 
          break;
        case 6: 
          direc[j] = 2; 
          break;
        case 7: 
          direc[j] = 3;
          ; 
          break; 
        case 8: 
          direc[j] = 4;
          break;
        }
      }
          //diferenciar py1
      if (ballX[i+1] <= py2+10 && ballX[i+1] >= py2+10 - 30 || ballX[i+1] >= py1-10  + largo1 && ballX[i+1] <= py1-10  + largo1 + 30 ) {   //ballX[i+1] <= py1+7.1 || ballX[i+1] >= py1 + largo1 - 7.1 
        diry *= (-1); 

        switch (direc[j]) {
        case 1:
          direc[j] = 5;
          break; 
        case 2: 
          direc[j] = 6;
          break; 
        case 3: 
          direc[j] = 7; 
          break; 
        case 4: 
          direc[j] = 8;
          break; 
        case 5: 
          direc[j] = 1; 
          break;
        case 6: 
          direc[j] = 2; 
          break;
        case 7: 
          direc[j] = 3;
          ; 
          break; 
        case 8: 
          direc[j] = 4;
          break;
        }
      }

      //movimiento en x
      switch(direc[j]) {
      case 1: 
        dirx = 0;
        break; 
      case 2: 
        dirx = velocidad*cos(radians(45)); 
        break; 
      case 3: 
        dirx = velocidad; 
        break; 
      case 4: 
        dirx =velocidad*cos(radians(45)); 
        break; 
      case 5: 
        dirx = 0; 
        break;
      case 6: 
        dirx = -velocidad*cos(radians(45)); 
        break;
      case 7: 
        dirx = -velocidad; 
        break; 
      case 8: 
        dirx = -velocidad*cos(radians(45)); 
        break;
      }

      ballX[i] += dirx;

      //movimiento en y
      switch(direc[j]) {
      case 1: 
        diry = -velocidad;
        break; 

      case 2: 
        diry = -velocidad*sin(radians(45)); 
        break; 

      case 3: 
        diry = 0; 
        break; 

      case 4: 
        diry = velocidad*sin(radians(45)); 
        break; 

      case 5: 
        diry = velocidad; 
        break;
      case 6: 
        diry = velocidad*sin(radians(45)); 
        break;
      case 7: 
        diry = 0; 
        break; 
      case 8: 
        diry = -velocidad*sin(radians(45)); 
        break;
      }

      ballX[i+1] += diry;
      ++j;
    }
  }

  public void dibujar() {


    for ( int i = 0; i < r-1; i += 2) {

      circle(ballX[i], ballX[i+1], 10);
    }
  }


  public float isovolumetrica(float t1, float t2, float p1, float p2) {

    float r = 0;

    if (t2 == 0) {
      t2 = (p2*t1)/p1; 
      r = t2;
    }

    if (p2 == 0) {
      p2 = (p1*t2)/t1; 
      r = p2;
    }

    return r;
  }

  public float isotermica(float v1, float v2, float p1, float p2) {

    float r = 0;

    if (v2 == 0) {
      v2 = (p1*v1)/p2; 
      r = v2;
    }

    if (p2 == 0) {
      p2 = (p1*v1)/v2;
      r = p2;
    }

    return r;
  } 
  public float isobarica(float t1, float t2, float v1, float v2) {

    float r = 0;

    if (v2 == 0) {
      v2 = (v1*t2)/t1; 
      r = v2;
    }

    if (t2 == 0) {
      t2 = (v2*t1)/v1; 
      r = t2;
    }

    return r;
  }

  public void adiabatica(boolean gas, int transSelect, float val_1, float val_2, float val_3, float n) {
    float consR = 0.082;
    float yad, to, tf, po, pf, vo, vf;
    if (gas) {
      yad = 1.6;
    } else {
      yad = 1.4;
    }

    switch(transSelect) {
    case 1: 
      vo=val_1;
      vf=val_2;
      po=val_3;
      //volumen y Presion
      //se halla presion final
      if (vf !=0) {
        presion1 = po*(pow((vo/vf), yad));
      } else {
        presion1=0;
      }
      //se calculan las temperaturas
      temperatura0 =(vo*po)/(n*consR);
      temperatura1=(vf*presion1)/(n*consR);

      break;
    case 2: 
      to=val_1;
      tf=val_2;
      vo=val_3;
      //temperatura y volumen
      //se halla el volumen final
      if (tf != 0) {
        volumen1=pow((to/tf), 1/(yad-1))*vo;
      } else {
        volumen1=0;
      }
      //se calculan las presiones
      presion0=n*consR*to/vo;
      presion1=n*consR*tf/volumen1;
      break;
    case 3: 
      po=val_1;
      pf=val_2;
      to=val_3;
      //presion y temperatura
      if (pf != 0) {
        temperatura1=pow((po/pf), (1-yad/yad))*to;
      } else {
        temperatura1=0;
      }  
      //se calculan los volumenes
      volumen0=n*consR*to/po;
      volumen1=n*consR*temperatura1/pf;
      break;}  }

  public String acortador(String text) {
    String d = "", result = "", result1 = "", result2 = "";
    int i = 0, sw = 0, p = 1, ind =0;
    boolean n = false; 

    while ( i<text.length() && sw == 0) {
      d = text.substring(i, i+1);
      if (d.equals(".")) {
        sw = 1;
        ind = i;
      } else {
        result1 = result1 + d;
      }

      ++i;
    }

    i = ind + 1; 
    sw = 0;

    while ( i<text.length() && sw == 0) {

      d = text.substring(i, i+1);

      if (text.length() - (ind + 1) > 1) { 

        if (p == 2) {
          if (int(d) > 5) {
            d = str(int(text.substring(i-1, i)) + 1);

            if (int(d) == 10) {
              n = true;
            } else {
              result2 = result2 + d;
            }
          } else {
            d = text.substring(i-1, i);
            result2 = result2 + d;
          }
          sw = 1;
        }
      } else {
        result2 = result2 + d;
      }

      p = p + 1;




      ++i;
    }

    if (n) {
      if (result1.substring(0, 1).equals("-")) {
        result = str(int(result1) -  1) + ".0";
      } else {
        result = str(int(result1) +  1) + ".0";
      }
    } else {
      result = result1 + "." + result2;
    }
    return result;
  }

  public void timer() {

    for (int i = 0; i < r; ++i) {
      if (retraso[i] + 250 == millis()) {
        check[i] = 0;
      }
    }
  }


  public void changecolor(int color_a, int color_b, int color_c) {

    color1 = color_a;
    color2 = color_b;
    color3 = color_c;
  }

  public float gap(int contador) {

    float gap = 0.1;

    switch(contador) {
    case 1: 
      gap = 1.0;
      break;

    case 2: 
      gap = 10.0;
      break;

    case 3: 
      gap = 100.0;
      break;
    }

    return gap;
  }

  public void velocidad(float temp) {

    if (temp == -273.15) {
      velocidad = 0.1;
    } else {
      velocidad = (temp + 273.15)*0.006;
    }
  }

  public void escaladortemp(float temp) {

    int sw = 0, p1 = 0, p2 = 50, c = 0; 

    while (sw == 0) {

      if (temp < p1 ) {
        p1 -= 50;
        p2 -= 50;
        ++c;
      }

      if (temp > p2 ) {
        p1 += 50;
        p2 += 50;
        ++c;
      }

      if (temp >= p1 && temp <= p2 ) {

        sw = 1;
      }
    }

    calibri = c;
    liminf = p1; 
    limsup = p2;
    //print(calibri);
  }


  public void animadortemp (float temp) {

    float unidad = barramer/50;
    float ubicacion = 0;

    if (temp % 50 == 0) {
      ubicacion = barramer;
    } else {
      if (temp < 0) {
        ubicacion = unidad*(temp + calibri*50);
      }

      if (temp > 0) {
        ubicacion = unidad*(temp - calibri*50);
      }
    }
    tope = 10 + (barramer-ubicacion);
    base = ubicacion;
  }

  public void escaladorpress(float press) {

    int sw = 0, p1 = 0, p2 = 300, c = 0; 

    while (sw == 0) {

      if (press< p1 ) {
        p1 -= 300;
        p2 -= 300;
        ++c;
      }

      if (press > p2 ) {
        p1 += 300;
        p2 += 300;
        ++c;
      }

      if (press >= p1 && press <= p2 ) {

        sw = 1;
      }
    }

    calibri2 = c;
    //print(calibri2);
  }

  public void animadorpress (float press) {

    float grado = 0.9;
    float ubicacion = 0;

    if (press >= 0) {

      //valores de los 50
      if (press - calibri2*300 == 0 ) {

        magnitudx = -1*(manometroW*cos(radians(45)));
        magnitudy = manometroH*sin(radians(45));
      } 

      if ( press - calibri2*300 == 50) {

        magnitudx = -1*(manometroW*cos(0));
        magnitudy = manometroH*sin(0);
      }

      if ( press - calibri2*300 == 100) {

        magnitudx = -1*(manometroW*cos(radians(45)));
        magnitudy = -1*(manometroH*sin(radians(45)));
      }
      if ( press - calibri2*300 == 150) {

        magnitudx = manometroW*cos(radians(90));
        magnitudy = -1*(manometroH*sin(radians(90)));
      }

      if ( press - calibri2*300 == 200) {

        magnitudx = manometroW*cos(radians(45));
        magnitudy = -1*(manometroH*sin(radians(45)));
      }

      if ( press - calibri2*300 == 250) {

        magnitudx = manometroW*cos(radians(0));
        magnitudy = manometroH*sin(radians(0));
      }

      if ( press - calibri2*300 == 300) {

        magnitudx = manometroW*cos(radians(45));
        magnitudy = manometroH*sin(radians(45));
      }

      if ((press - calibri2*300) > 0 && (press - calibri2*300) < 50 ) {

        ubicacion = grado*(press - calibri2*300);

        magnitudx = -1*(manometroW*cos(radians(45-ubicacion)));
        magnitudy = manometroH*sin(radians(45-ubicacion));
      }

      if ((press - calibri2*300) > 50 && (press - calibri2*300) < 100) {

        ubicacion = grado*(press - calibri2*300);

        magnitudx = -1*(manometroW*cos(radians(ubicacion - 45)));
        magnitudy = -1*(manometroH*sin(radians(ubicacion- 45)));
      }

      if ((press - calibri2*300) > 100 && (press - calibri2*300) < 150) {


        ubicacion = grado*(press - calibri2*300);

        magnitudx = -1*(manometroW*cos(radians(ubicacion-45)));
        magnitudy = -1*(manometroH*sin(radians(ubicacion-45)));
      }

      if ((press - calibri2*300) > 150 && (press - calibri2*300) < 200) {

        ubicacion = grado*(press - calibri2*300);

        magnitudx = -1*(manometroW*cos(radians(ubicacion-45)));
        magnitudy = -1*(manometroH*sin(radians(ubicacion-45)));
      }

      if ((press - calibri2*300) > 200 && (press - calibri2*300) < 250) {

        ubicacion = grado*(press - calibri2*300);

        magnitudx = -1*(manometroW*cos(radians(ubicacion-45)));
        magnitudy = -1*(manometroH*sin(radians(ubicacion-45)));
      }

      if ((press - calibri2*300) > 250 && (press - calibri2*300) < 300) {

        ubicacion = grado*(press - calibri2*300);

        magnitudx = -1*(manometroW*cos(radians(ubicacion-45)));
        magnitudy = -1*(manometroH*sin(radians(ubicacion-45)));
      }
      textrt = str(press)+" atm";
    }
  }

  public void escaladorvol(float vol) {

    int sw = 0, p1 = 0, p2 = 100, c = 0; 

    while (sw == 0) {

      if (vol < p1 ) {
        p1 -= 100;
        p2 -= 100;
        ++c;
      }

      if (vol > p2 ) {
        p1 += 100;
        p2 += 100;
        ++c;
      }

      if (vol >= p1 && vol <= p2 ) {

        sw = 1;
      }
    }
    calibri3 = c;
  } 

  public void animadorvol (float vol) {

    float unidad = largo1/100;
    float ubicacion = 0;

    if (vol % 100 == 0 && vol != 0) {
      ubicacion = 0;
    } else {
      ubicacion = largo1 - (unidad*(vol- calibri3*100));
    }
    cambioy = ubicacion;
  }
  
  public float limitevol (float vol) {

    float unidad = largo1/100;
    float ubicacion = 0;

    if (vol % 100 == 0 && vol != 0) {
      ubicacion = 0;
    } else {
      ubicacion = largo1 - (unidad*(vol- calibri3*100));
    }
    
    return ubicacion;
  }
  
}
