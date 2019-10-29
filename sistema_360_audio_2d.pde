import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.serial.*;


//Sonido prueba
Minim minim;
AudioPlayer player;


//Serial myPort;

Joysticks j1;
Bocinas b1;
float[] distanciasMapeo;


void setup() {
  //Sonido
  minim = new Minim(this);
  player = minim.loadFile("idn.mp3");
  
  size(500, 500);
  j1= new Joysticks(); 
  b1 = new Bocinas();
  //myPort = new Serial(this, Serial.list()[0], 9600);
  distanciasMapeo= new float[b1.getPosiciones().length];
}

void draw() {
  background(255);
  j1.pintar();
  b1.pintar();
  calcularDistancias();
  //myPort.write(enviarSerial());
  
  //SONIDO
  if ( player.isPlaying() )
  {
    text("Press any key to pause playback.", 10, 20 );
  }
  else
  {
    text("Press any key to start playback.", 10, 20 );
  }
  player.setPan(dosAUno(distanciasMapeo[0],distanciasMapeo[1]));

}


void calcularDistancias() {
  for (int i=0; i< distanciasMapeo.length; i++) {
    distanciasMapeo[i]= map( dist( b1.getPosiciones()[i][0], b1.getPosiciones()[i][1], j1.getPosicion()[0], j1.getPosicion()[1]), 0, 300, 0, 1);
  }
}

String enviarSerial() {
  String mensaje ="";
  String separador="/";

  for (int i=0; i< distanciasMapeo.length; i++) {
    mensaje= mensaje+str(distanciasMapeo[i]);
    if (i!=distanciasMapeo.length-1) {
      mensaje= mensaje+separador;
    }
  }
  return mensaje;
}

void keyPressed()
{
  if ( player.isPlaying() )
  {
    player.pause();
  }
  // if the player is at the end of the file,
  // we have to rewind it before telling it to play again
  else if ( player.position() == player.length() )
  {
    player.rewind();
    player.play();
  }
  else
  {
    player.play();
  }
}

float dosAUno(float a, float b){
  return b+(a*-1);
}
