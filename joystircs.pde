class Joysticks {
  int radio = 30;
  int radioEsfera = 20;
  int nJoysticks = 97;
  int[] nElementosPorRadio = new int[]{1, 8, 16, 16, 16, 16, 16, 8};
  FloatList coordenadasX = new FloatList();
  FloatList coordenadasY = new FloatList();
  FloatList colores = new FloatList();
  IntList ruta = new IntList();
  float[] posicionesActuales = new float[2];

  //BorrarRuta
  float tiempo = millis();
  int temporizador = 120;
  int cont=0;

  Joysticks() {
    inicializar();
  }

  void inicializar() {
    for (int j=0; j< nElementosPorRadio.length; j++) {
      for (int i=0; i< nElementosPorRadio[j]; i++) { 
        float x = (j*radio)*sin((TWO_PI/nElementosPorRadio[j])*i)+width/2;
        float y = (j*radio)*cos((TWO_PI/nElementosPorRadio[j])*i)+height/2;
        coordenadasX.append(x); // Store the x co-ordinate
        coordenadasY.append(y); // Store the x co-ordinate
        colores.append(255);
      }
    }
  }

  void pintar() {
    for (int i=0; i<nJoysticks; i++) { 
      float x = coordenadasX.get(i);
      float y = coordenadasY.get(i);
      if (ruta.hasValue(i)) fill(0, 255, 0, colores.get(i));
      else fill(255);
      stroke(2);
      ellipse(x, y, radioEsfera, radioEsfera);
    }
    crearRuta();
    pintarRuta();
    despintarRuta();
  }

  void crearRuta() {
    if (mousePressed == true) {
      for (int i=0; i<nJoysticks; i++) {
        if (dist(mouseX, mouseY, coordenadasX.get(i), coordenadasY.get(i))<radioEsfera/2) {
          if (ruta.size()>0) {
            if (ruta.get(ruta.size()-1)!=i) {
              ruta.append(i);
            }
          } else {
            ruta.append(i);
          }
        }
      }
    }
  }

  void pintarRuta() {
    if (ruta.size()>0) {
      for (int i=0; i< ruta.size(); i++) {
        colores.set(ruta.get(i), 255-(i*(255/ruta.size())));
      }
    }
  }

  void despintarRuta() {
    if (ruta.size()>0) {
      if (mousePressed==false) {
        if (millis() >= tiempo + temporizador) {
          posicionesActuales[0] =coordenadasX.get(ruta.get(0));
          posicionesActuales[1] =coordenadasY.get(ruta.get(0));
          colores.set(ruta.get(0), 255);
          ruta.remove(0);
          tiempo = millis();
        }
      }
    }
  }

  float[] getPosicion( ) {
    return posicionesActuales;
  }
}
