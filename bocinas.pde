class Bocinas {
  int nBocinas = 2;
  int radio = 150;
  int radioBocina = 40;
  float[] coordenadasX = new float[nBocinas];
  float[] coordenadasY = new float[nBocinas];
  float[][] cordenadasUnidas = new float[nBocinas][2];
  Bocinas(){
  inicializar();
  }
  
  void inicializar() {
    for (int i=0; i< nBocinas; i++) { 
      float x = (radio)*sin((TWO_PI/nBocinas)*i)+width/2;
      float y = (radio)*cos((TWO_PI/nBocinas)*i)+height/2;
      coordenadasX[i]=x; 
      coordenadasY[i]=y;
      cordenadasUnidas[i][0] =x ;
      cordenadasUnidas[i][1] =y ;
    }
  }


  void pintar() {
    for(int i=0; i< nBocinas;i++){
      noStroke();
      fill(255,0,0,64);
      ellipse(coordenadasX[i],coordenadasY[i],radioBocina,radioBocina);
    }
  }
  
  float[][] getPosiciones(){
   return cordenadasUnidas;
  }
}
