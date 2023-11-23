import processing.pdf.*;
import grafica.*;

GPlot plot;

PImage fondo, bstart, menu, bback, recipiente, tapa, vidrio, mechero, hielo; 
int transition = 0, ef1, t1, x, x1, x2, x3, x4, x5, y1, y2, nesferas=20, start1, stop1, control = 0, contadorgap1 = 0, contadorgap2 = 0, atomo=0;
float volumen0 = 0, volumen1 = 0, temperatura0 = 0, temperatura1 = 0, presion0 = 0, presion1 = 0, gap1 = 0.1, gap2 = 0.1, w=0, u=0, q=0, techo1;
String t = "SIMULADOR DE GAS IDEAL";  
boolean notrepit = false, secalcula = false, gas=true, calcular=false, anuncio=false, notrepit2 = false, notrepit3 =false;
int j, top;
Guipro tool;

void setup() {
  //no cambies el tamaño 
  size(1080, 720);
  fondo = loadImage("background.png");
  bstart = loadImage("botonplay.png");
  menu = loadImage("menu2.png");
  bback = loadImage("boton atras.png");
  recipiente = loadImage("recipiente.png");
  tapa = loadImage("recipientetapa.png");
  vidrio = loadImage("vidriorecipiente.png");
  mechero = loadImage("mechero2.jpg");
  hielo = loadImage("hielo.jpg");
  tool = new Guipro();

  plot = new GPlot(this);
  plot.setPos(600, 150);

  plot.setTitleText("Grafica Presion vs Volumen");
  plot.getXAxis().setAxisLabelText("Volumen");
  plot.getYAxis().setAxisLabelText("Presion");
}


void draw() {
  println("X: ", mouseX, " Y: ", mouseY);
  switch(transition) {
  case 0: 
    image(fondo, 0, 0, width, height);
    image(bstart, width/2-width/20, height/2+ 2*(width/20), width/10, width/10);

    ef1 = 0; 
    t1 = 250;
    if (frameCount % 50 == 0) {
      ef1 = 50;
      delay(500);
      t1 = 0;
    }
    textSize(40);  
    fill(t1, 250, t1);
    text(t, width/2-textWidth(t)/2, height/2+50 - ef1);
    break; 

  case 1: 
    println(anuncio, " T-E-C: ", w, " ", u, " ", q);

    image(menu, 0, 0, width, height); 
    image(bback, width/8 - width/16, 0, width/8, width/18); 

    if (anuncio) {
      //noLoop();
      TEC(gas, control, nesferas, presion0, volumen0, volumen1, temperatura0, temperatura1);
      fill(225);
      textSize(30);
      fill(9, 216, 17);
      rect(720, 520, 310, 150, 7);
      fill(250);
      text("Trabajo: "+nf(w, 0, 1)+" J", 735, 560);
      text("Energia: "+nf(u, 0, 1)+" N*m", 735, 600);
      text("Calor: "+nf(q, 0, 1)+"K°", 735, 650);

      if (presion1==presion0) {
        j=(int)presion1;
      } else if (presion1>presion0) {
        j=(int)presion1;
      } else {
        j=(int)presion0;
      }

      if (volumen1==volumen0) {
        top=(int)volumen1;
      } else if (volumen1>volumen0) {
        top=(int)volumen1;
      } else {
        top=(int)volumen0;
      }

      GPointsArray points = new GPointsArray(top);

      for (int i = 0; i < top; i++) {
        points.add(i, j);
        if (presion1!=presion0) {
          j--;
        }
      }
      beginRecord(PDF, "graficaPvV.pdf");
      plot.setPoints(points);
      plot.defaultDraw();
      endRecord();
      //exit();
    }

    //visualizacion de los valores
    if (atomo==0) {
      fill(225, 0, 0);
      ellipse(width-100, 70, 25, 25);
      textSize(15);
      fill(225);
      text("Monoatomico", width-55-textWidth("monoatomico"), 50);
      gas=true;
    } else if (atomo==1) {
      fill(0, 0, 225);
      ellipse(width-100, 70, 25, 25);
      textSize(15);
      fill(225);
      text("Diatomico", width-55-textWidth("diatomico"), 50);
      gas=false;
    }


    textSize(10);
    fill(0);
    String text1 = tool.acortador(str(volumen0));
    volumen0 = float(text1);
    text(text1, 130 - (textWidth(text1)/2)+1, 155);

    String text2 = tool.acortador(str(volumen1));
    volumen1 = float(text2);
    text(text2, 130 - (textWidth(text2)/2)+1, 507);

    String text3 = str(nesferas);
    text(text3, 130 - (textWidth(text3)/2)+0.6, 675);

    String text4 = tool.acortador(str(presion0));
    presion0 = float(text4);
    text(text4, 42 - (textWidth(text4)/2)+1, 210);

    String text5 = tool.acortador(str(presion1));
    presion1 = float(text5);
    text(text5, 42 - (textWidth(text5)/2)+1, 562);

    String text6 = tool.acortador(str(temperatura0));
    temperatura0 = float(text6);
    text(text6, 218 - (textWidth(text6)/2)+1, 210);

    String text7 = tool.acortador(str(temperatura1));
    temperatura1 = float(text7);  
    text(text7, 218 - (textWidth(text7)/2)+1, 562);

    //animación isovolumetrica 

    if (control == 1 && secalcula) {

      // se crea el recipiente
      tool.recipiente2d(413, 363, 30, 200, 143, 1, true);
      if (notrepit) {
        tool.esferas(443, 393, nesferas, 113, 170, 393);
        notrepit = false;
      }


      tool.dibujar();
      tool.move();
      tool.timer();
      if (millis() <= start1 + 5000 ) {

        if (temperatura0 > 0 ) {

          tool.changecolor(250, 0, 0);
        }

        if (temperatura0 < 0 ) {

          tool.changecolor(0, 0, 250);
        }
        tool.velocidad(temperatura0);
        tool.escaladortemp(temperatura0);
        tool.animadortemp(temperatura0);
        tool.escaladorpress(presion0);
        tool.animadorpress(presion0);
      } 


      if (millis() > start1 + 5000 ) {

        if (temperatura1 > 0 ) {

          tool.changecolor(250, 0, 0);
        }

        if (temperatura1 < 0 ) {

          tool.changecolor(0, 0, 250);
        }
        tool.velocidad(temperatura1);
        tool.escaladortemp(temperatura1);
        tool.animadortemp(temperatura1);
        tool.escaladorpress(presion1);
        tool.animadorpress(presion1);
      }
    }
    // fin de la animación isovolumetrica

    //animacion isotermica


    if (control == 2 && secalcula) {


      tool.velocidad(temperatura0);
      tool.escaladortemp(temperatura0);
      tool.animadortemp(temperatura0);

      if (temperatura0 > 0 ) {

        tool.changecolor(250, 0, 0);
      }

      if (temperatura0 < 0 ) {

        tool.changecolor(0, 0, 250);
      }



      // momento inicial 
      if (millis() <= start1 + 5000 ) {
        tool.recipiente2d(413, 363, 30, 200, 143, 2, true);

        tool.escaladorvol(volumen0); 
        tool.animadorvol(volumen0);
        tool.escaladorpress(presion0);
        tool.animadorpress(presion0);

        if (notrepit) {
          tool.recipiente2d(413, 363, 30, 200, 143, 2, false);
          tool.esferas(443, 393, 0, 113, 170, 0);
          notrepit = false;
          notrepit2 = true;
        } 


        if (notrepit2) {
          tool.escaladorvol(volumen0);
          techo1 = 393 + tool.limitevol(volumen0); 
          tool.esferas(443, 393, nesferas, 113, 170, techo1);
          notrepit2 = false;
          notrepit3 = true;
        }
      } 

      //momento final
      if (millis() > start1 + 5000 ) {
        tool.recipiente2d(413, 363, 30, 200, 143, 2, true);

        tool.escaladorvol(volumen1); 
        tool.animadorvol(volumen1);
        tool.escaladorpress(presion1);
        tool.animadorpress(presion1);

        if (notrepit3) {

          tool.escaladorvol(volumen1);
          techo1 = 393 + tool.limitevol(volumen1); 
          print(tool.limitevol(volumen1));
          tool.esferas(443, 393, nesferas, 113, 170, techo1);

          notrepit3 = false;
        }
      }

      tool.dibujar();
      tool.move();
      tool.timer();
    }

    // fin de la isotermica

    // inicio de la isobarica
    if (control == 3 && secalcula) {
      tool.escaladorpress(presion0);
      tool.animadorpress(presion0);

      if (millis() <= start1 + 5000 ) {
        tool.recipiente2d(413, 363, 30, 200, 143, 2, true);

        tool.velocidad(temperatura0);
        tool.escaladorvol(volumen0); 
        tool.animadorvol(volumen0);
        tool.escaladortemp(temperatura0); 
        tool.animadortemp(temperatura0);

        if (temperatura0 > 0 ) {
          tool.changecolor(250, 0, 0);
        }
        if (temperatura0 < 0 ) {
          tool.changecolor(0, 0, 250);
        }  


        if (notrepit) {
          tool.recipiente2d(413, 363, 30, 200, 143, 2, false);
          tool.esferas(443, 393, 0, 113, 170, 0);
          notrepit = false;
          notrepit2 = true;
        } 


        if (notrepit2) {
          //tool.escaladorvol(volumen0);
          techo1 = 393 + tool.limitevol(volumen0); 
          tool.esferas(443, 393, nesferas, 113, 170, techo1);
          notrepit2 = false;
          notrepit3 = true;
        }
      } 

      //momento final

      if (millis() > start1 + 5000 ) {
        tool.recipiente2d(413, 363, 30, 200, 143, 2, true);

        tool.velocidad(temperatura1);
        tool.escaladorvol(volumen1); 
        tool.animadorvol(volumen1);
        tool.escaladortemp(temperatura1); 
        tool.animadortemp(temperatura1);

        if (temperatura1 > 0 ) {
          tool.changecolor(250, 0, 0);
        }
        if (temperatura1 < 0 ) {
          tool.changecolor(0, 0, 250);
        }


        if (notrepit3) {

          tool.escaladorvol(volumen1);
          techo1 = 393 + tool.limitevol(volumen1); 
          print(tool.limitevol(volumen1));
          tool.esferas(443, 393, nesferas, 113, 170, techo1);

          notrepit3 = false;
        }
      }

      //mostrar las esferas en movimiento
      tool.dibujar();
      tool.move();
      tool.timer();
    }
    //fin de la isobarica

    //Inicio adiabatica
    if (control == 4 && secalcula) {
      tool.escaladorpress(presion0);
      tool.animadorpress(presion0);

      if (millis() <= start1 + 5000 ) {
        tool.recipiente2d(413, 363, 30, 200, 143, 2, true);
        
         tool.escaladorpress(presion0);
         tool.animadorpress(presion0);
        tool.velocidad(temperatura0);
        tool.escaladorvol(volumen0); 
        tool.animadorvol(volumen0);
        tool.escaladortemp(temperatura0); 
        tool.animadortemp(temperatura0);

        if (notrepit) {
          tool.recipiente2d(413, 363, 30, 200, 143, 2, false);
          tool.esferas(443, 393, 0, 113, 170, 0);
          notrepit = false;
          notrepit2 = true;
        } 


        if (notrepit2) {
          //tool.escaladorvol(volumen0);
          techo1 = 393 + tool.limitevol(volumen0); 
          tool.esferas(443, 393, nesferas, 113, 170, techo1);
          notrepit2 = false;
          notrepit3 = true;
        }
      } 
      if (millis() > start1 + 5000 ) {
        tool.recipiente2d(413, 363, 30, 200, 143, 2, true);
         
        tool.escaladorpress(presion1);
        tool.animadorpress(presion1);
        tool.velocidad(temperatura1);
        tool.escaladorvol(volumen1); 
        tool.animadorvol(volumen1);
        tool.escaladortemp(temperatura1); 
        tool.animadortemp(temperatura1);
        //notrepit3 = true;
        if (notrepit3) {
          tool.escaladorvol(volumen1);
          techo1 = 393 + tool.limitevol(volumen1); 
          print(tool.limitevol(volumen1));
          tool.esferas(443, 393, nesferas, 113, 170, techo1);
          notrepit3 = false;
        }
      }

      
      tool.dibujar();
      tool.move();
      tool.timer();
    }
    
     
     if (secalcula && control != 4) {
        if (temperatura1 < 0) {
          image(hielo, 413 + 173/2 - 50, 620, 100, 100);
        } else if (temperatura1 > 0) {
          image(mechero, 413 + 173/2 - 50, 620, 100, 100);
        }
      }
     
    noStroke();

     //animacion de ceder o ganar calor 
     
     
     if(q < 0){
     
     stroke(250, 250, 0);
     line(570, 593 , 570, 650);
     fill(250, 250, 0);
     triangle(570, 650, 580, 640, 560, 640);
     
      text("-Q",580, 650);
     stroke(0);
     
     } else if(q > 0) {
       
     stroke(250, 250, 0);
     line(570, 536 , 570, 593);
     fill(250, 250, 0);
     triangle(570, 536, 580, 546, 560, 546);
     
     text("+Q", 580, 593);
     stroke(0);
     
     
     }
     
       


    // visualización del botón del gap de valores

    //gap de valores iniciales 
    strokeWeight(15);
    stroke(0);
    point(20, 148);
    strokeWeight(1);
    stroke(0);

    //gap de valores finales
    strokeWeight(15);
    stroke(0);
    point(20, 500);
    strokeWeight(1);
    stroke(0);
    break;
  }
}

void mousePressed() {

  //cambio de escena
  if (mouseX >= width/2-width/20 && mouseX <=  width/2-width/20 + width/10 && mouseY >= height/2+ 2*(width/20) && mouseY <= height/2+ 2*(width/20) + width/10 && transition == 0 ) {
    transition = 1;
    volumen0 = 0; 
    volumen1 = 0; 
    temperatura0 = 0; 
    temperatura1 = 0; 
    presion0 = 0; 
    presion1 = 0; 
    nesferas = 0; 
    control = 0;
  }

  if (mouseX >= width/8 - 100 && mouseX <= width/8 + 100 && mouseY >= 0 && mouseY <= 90 && transition == 1) {
    transition = 0;
    control = 0; 
    contadorgap1 = 0; 
    contadorgap2 = 0; 
    atomo=0;
    volumen0 = 0; 
    volumen1 = 0; 
    temperatura0 = 0; 
    temperatura1 = 0; 
    presion0 = 0; 
    presion1 = 0; 
    gap1 = 0.1; 
    gap2 = 0.1;
    w=0;
    u=0;
    q=0;
    notrepit = true; 
    secalcula = false; 
    gas=true; 
    calcular=false;
    anuncio=false;
  }

  //botones de valores iniciales 
  //volumen inicial
  if (mouseX >= 90 && mouseX <= 112  && mouseY >= 138 && mouseY <= 161 && transition == 1) {
    volumen0 -= gap1;
    System.out.println(volumen0);
  } 
  if (mouseX >= 149 && mouseX <= 171  && mouseY >= 138 && mouseY <= 161 && transition == 1) {
    volumen0 += gap1;
    System.out.println(volumen0);
  }

  //presion inicial
  if (mouseX >= 0 && mouseX <= 22  && mouseY >= 193 && mouseY <= 216 && transition == 1) {
    presion0 -= gap1;
    System.out.println(presion0);
  } 
  if (mouseX >= 60 && mouseX <= 82  && mouseY >= 193 && mouseY <= 216 && transition == 1) {
    presion0 += gap1;
    System.out.println(presion0);
  }

  //temperatura inicial 
  if (mouseX >= 178 && mouseX <= 200  && mouseY >= 193 && mouseY <= 216 && transition == 1) {
    temperatura0 -= gap1;
    System.out.println(temperatura0);
  } 
  if (mouseX >= 238 && mouseX <= 260  && mouseY >= 193 && mouseY <= 216 && transition == 1) {
    temperatura0 += gap1;
    System.out.println(temperatura0);
  }

  // transformaciones
  if (mouseX >= 3 && mouseX <= 256 && mouseY >= 293 && mouseY <= 403) {

    control = tool.transforselected(mouseX, mouseY);
    if ( control != 0 && transition == 1) {
      System.out.print(control);
      volumen1 = 0 ; 
      presion1 = 0; 
      temperatura1 = 0;

      if (secalcula)
        secalcula = false;
    }
  }

  //botones de valores finales 

  if (control != 1) {

    //volumen final
    if (mouseX >= 90 && mouseX <= 112  && mouseY >= 488 && mouseY <= 511 && transition == 1) {
      volumen1 -= gap2;
      System.out.println(volumen1);
    } 
    if (mouseX >= 149 && mouseX <= 171  && mouseY >= 488 && mouseY <= 511 && transition == 1) {
      volumen1 += gap2;
      System.out.println(volumen1);
    }
  } 
  if (control == 1) {
    volumen1 = volumen0;
  }

  if (control != 3) {

    //presión final
    if (mouseX >= 0 && mouseX <= 22  && mouseY >= 543 && mouseY <= 567 && transition == 1) {
      presion1 -= gap2;
      System.out.println(presion1);
    } 
    if (mouseX >= 60 && mouseX <= 82  && mouseY >= 543 && mouseY <= 567 && transition == 1) {
      presion1 += gap2;
      System.out.println(presion1);
    }
  }

  if (control == 3) {
    presion1 = presion0;
  }
  if (control != 2) {


    //temperatura final 
    if (mouseX >= 178 && mouseX <= 200  && mouseY >= 543 && mouseY <= 567 && transition == 1) {
      temperatura1 -= gap2;
      System.out.println(temperatura1);
    } 
    if (mouseX >= 238 && mouseX <= 260  && mouseY >= 543 && mouseY <= 567 && transition == 1) {
      temperatura1 += gap2;
      System.out.println(temperatura1);
    }
  } 
  if (control == 2) {
    temperatura1 = temperatura0;
  }


  //Boton Numero de esferas
  if (mouseX >= 90 && mouseX <= 112  && mouseY >= 658 && mouseY <= 681 && transition == 1) {
    --nesferas;
    System.out.println(nesferas);
  } 
  if (mouseX >= 149 && mouseX <= 171  && mouseY >= 658 && mouseY <= 681 && transition == 1) {
    ++nesferas;
    System.out.println(nesferas);
  } 

  // boton calcular 
  if (mouseX >= 60 && mouseX <= 199 && mouseY >= 690 && mouseY <= 715 && transition == 1 ) {
    System.out.println("se calcula "); 
    calcular=true;
    secalcula = true; // controla el click 
    notrepit = true;

    start1 = millis();

    if (calcular) {
      //tool.esferas(443, 393, nesferas, 113, 170);
      calcular=false;
      anuncio=true;
    }



    if (control == 1 && presion1 == 0) {
      presion1 = tool.isovolumetrica(temperatura0, temperatura1, presion0, presion1);
      System.out.print(presion1);
    }

    if (control == 1 && temperatura1 == 0) {
      temperatura1 = tool.isovolumetrica(temperatura0, temperatura1, presion0, presion1);
      System.out.print(temperatura1);
    }

    if (control == 2 && presion1 == 0) {
      presion1 = tool.isotermica(volumen0, volumen1, presion0, presion1   );
      System.out.print(presion1);
    }

    if (control == 2 && volumen1 == 0) {
      volumen1 = tool.isotermica(volumen0, volumen1, presion0, presion1   );
      System.out.print(volumen1);
    }
    if (control == 3 && volumen1 == 0) {
      volumen1 = tool.isobarica(temperatura0, temperatura1, volumen0, volumen1 );
      System.out.print(volumen1);
    }
    if (control == 3 && temperatura1 == 0) {
      temperatura1 = tool.isobarica(temperatura0, temperatura1, volumen0, volumen1);
      System.out.print(temperatura1);
    }
    if (control == 4 && volumen1 != 0 && volumen0 != 0) {
      if (presion0 == 0) {
        tool.adiabatica(gas, 1, volumen0, volumen1, temperatura0, nesferas);
      } else {
        tool.adiabatica(gas, 1, volumen0, volumen1, presion0, nesferas);
      }
    } else if (control == 4 && temperatura1 != 0 && temperatura0 != 0) {
      if (volumen0 == 0) {
        tool.adiabatica(gas, 2, temperatura0, temperatura1, presion0, nesferas);
      } else {
        tool.adiabatica(gas, 2, temperatura0, temperatura1, volumen0, nesferas);
      }
    } else if (control == 4 && presion1 != 0 && presion0 != 0) {
      if (temperatura0 == 0) {
        tool.adiabatica(gas, 3, presion0, presion1, volumen0, nesferas);
      } else {
        tool.adiabatica(gas, 3, presion0, presion1, temperatura0, nesferas);
      }
    }

    //TEC(gas, control, nesferas, presion0, volumen0, volumen1, temperatura0, temperatura1);
  }


  // Botones gap

  // gap de los valores iniciales 
  if (mouseX >= 12.5 && mouseX <= 27.7 && mouseY >= 140.5  && mouseY <= 155.5 && transition == 1) {
    contadorgap1++;

    if (contadorgap1 == 4) {
      contadorgap1 = 0;
    }

    gap1 = tool.gap(contadorgap1);

    print(contadorgap1, gap1);
  }

  //gap valores finales
  if (mouseX >= 12.5 && mouseX <= 27.7 && mouseY >= 492.5  && mouseY <= 507.5 && transition == 1) {
    contadorgap2++;

    if (contadorgap2 == 4) {
      contadorgap2 = 0;
    }

    gap2 = tool.gap(contadorgap2);

    println(contadorgap2, gap2);
  }
}
