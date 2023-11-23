void mouseClicked() {
  if (mouseX < width-87.5 && mouseX > width-112.5) {
    if (atomo==0) {
      atomo=1;
    } else if (atomo == 1) {
      atomo =0;
    }
    println("gas: ", gas);
  }
}

//Trabajo_Energia_Calor
void TEC(boolean gas, int tranf, int n, float p, float vo, float vf, float to, float tf) {
  float R = 0.08; 
  float Cv;

  if (gas) {
    Cv=3*R/2;
  } else {
    Cv=5*R/2;
  }

  switch(tranf) {
  case 1://isovolumetrica
    w=0;
    u=n*Cv*(tf-to);
    q=u;
    break;
  case 2://isotermica
    w=n*R*to*log(vf/vo);
    u=0;
    q=w;
    break;
  case 3://isobarica
    if (vo!=0) {
      w=p*(vf-vo);
    }
    u=n*Cv*(tf-to);
    q=u+w;
    break;
  case 4: //adiabatica
    w=(n*Cv*(tf-to));
    u=n*Cv*(tf-to);
    q=0;
      break;
  }

}
