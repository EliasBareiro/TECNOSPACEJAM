
//--- inicio un funciones para la puntuacion, vidas y la imagen de la pelota --------
import gab.opencv.*;
import processing.video.*;
import processing.sound.*;

OpenCV opencv;

Capture camara;

FCircle bola;

SoundFile Jam, Abucheo, Aclamacion, Oohh;

int ancho = 1080;
int alto = 600;

import fisica.*;
int t = 0;
int tt = 0;
boolean cajaquerepele = false;

boolean repeler = false;
boolean atraer = false;


float puntoEnX = random(1000);
float puntoEnY = random(600);

float puntoEnX1 = random(1000);
float puntoEnY1 = random(600);

FWorld world;
FMouseJoint cadena;
FBox caja;
FCircle circulo;


PImage imagen_pelota_basket1, imagen_personaje, imagen_ganar, imagen_perder;
PImage imagen_fondo_basket, imagen_pelota_basket2, imagen_pelota_basket3, imagen_aro;
int puntos = 0;
int vidas = 3;
int tiempo_transcurrido,millis_inicio;

String GameState;

void setup()
{ 
  size(1080, 600);
  frameRate(30);
  
  GameState = "JUEGO";
  
  camara = new Capture(this, ancho, alto);
  camara.start();
  opencv = new OpenCV(this, ancho, alto);
  
  imagen_pelota_basket1 = loadImage("Pelota 1.png");
  imagen_pelota_basket2 = loadImage("Pelota 2.png");
  imagen_pelota_basket3 = loadImage("Pelota 3.png");
  imagen_personaje = loadImage("caja.png");
  imagen_aro = loadImage("aro 2.png");
  imagen_fondo_basket = loadImage("fondo.jpg");
  imagen_ganar = loadImage("Ganaste.png");
  imagen_perder = loadImage("Perdiste.png");
    

  Fisica.init(this);
 
 // -------------- creo un mundo, gravedad y paredes --------------------

  world = new FWorld();
  world.setGravity(100, 1000);
  world.setEdges(color(1,0));
  
  // -------------- creo el aro donde anotas  ------------------
  
  bola = new FCircle(60);
  bola.setPosition(1000, 100);
  bola.setName("mouse");
  bola.attachImage(imagen_aro);
  bola.setStatic(true);
  world.add(bola);
  // ---------- la caja para mover las pelotas  -----------------
 
  caja = new FBox(200, 60);
  caja.setPosition(width/2, height/2);
  //caja.setStatic(true);
   caja.attachImage(imagen_personaje);
  caja.setRotatable(false);
  world.add(caja);
  
  // ------------- el suelo para perder puntos  ---------------
  
  FBox suelo = new FBox(5000,20);
  suelo.setPosition(300, 600);
  suelo.setName("suelo");
  suelo.setNoFill();
  suelo.setNoStroke();
  suelo.setStatic(true);
  world.add(suelo);
    
  // --------------- cadena para que se mueva la caja -------------------------- 
  cadena = new FMouseJoint(caja, width / 2, height / 2);
  cadena.setFrequency(400000000);
  cadena.setNoStroke();
  world.add(cadena);
  
  // ------------------- Musica y efectos de sonido -----------------------------
  Jam = new SoundFile(this, "Space_jam.wav");
  Abucheo = new SoundFile(this, "abucheo.wav");
  Aclamacion = new SoundFile(this, "aclamacion.wav");
  Oohh = new SoundFile(this, "oohhhhh.wav");
  
  
}

void draw()
{
  switch(GameState){
    case "JUEGO":
      if(!Jam.isPlaying()){Jam.play();}
      
      background(/*0,255,255*/imagen_fondo_basket);
      int umbral = 250;
  
      world.step();
      world.draw(this);
  
      if (camara.available()){
        camara.read();
        opencv.loadImage(camara);
        opencv.threshold(umbral);
        PVector pixelMasBrillante = opencv.max();
        //image(camara, 0, 0);
        //stroke(255, 0, 0);
        //ellipse(pixelMasBrillante.x, pixelMasBrillante.y, 30, 30);
        cadena.setTarget(/*mouseX, mouseY*/pixelMasBrillante.x, pixelMasBrillante.y);
        }
      
  
      // --------------- dibujo los puntos y las vidas ------------
        fill(255);
        textSize(80);
        text(""+puntos, 655,70);

        fill(255);
        textSize(80);
        text(""+vidas,370,70);
  
      // ------------- limitar el numero de pelotas --------------------
      if (frameCount % 240 == 0 && t <= 4) {
         for (int i = 0; i < 1; i++)
      {
      // ------------ creo las pelotas de basket -----------------
        t++;
        circulo = new FCircle(40);
        circulo.setName("pelotabasket");
        circulo.setPosition(random(10, 20), random(10, 20));
        circulo.attachImage(imagen_pelota_basket1);
        circulo.setRestitution(1.0);
        circulo.setNoStroke();
        circulo.setFill(random(255), random(255), random(255));

        if (random(2) < 1){
          circulo.attachImage(imagen_pelota_basket2);
          circulo.setRestitution(1.06);
        }else if (random(3) < 1){
          circulo.attachImage(imagen_pelota_basket3);
          circulo.setRestitution(1.40);
        }
          
        

        world.add(circulo);
      }}
      
      if(puntos >= 3 && vidas > 0){
        GameState = "GANAR";
      }
      if(vidas == 0){
        GameState = "PERDER";
      }
      
      break;
    case "GANAR":
      Jam.stop();
      image(imagen_ganar,0,0, width, height);
      if (frameCount % 120 == 0) {
         tt += 1;
      }
      if(tt == 3){
         GameState = "JUEGO";
         puntos = 0;
         vidas = 3;
         t = 0;
         tt = 0;
      }
      break;
    case "PERDER":
      Jam.stop();
      image(imagen_perder,0,0, width, height);
      if (frameCount % 120 == 0) {
         tt += 1;
      }
      if(tt == 3){
         GameState = "JUEGO";
         puntos = 0;
         vidas = 3;
         t = 0;
         tt = 0;
      }
      break;
    default:  
      break;
  }
  
  
  
  
  //----------------- el tiempo -----------------------------------
  
  //tiempo de musica space jam = 2620 segundos
  
  
mostrarTiempo();

if(tiempo_transcurrido>=17000 && tiempo_transcurrido<=22000 ){
  repeler = true;
  repelerDesdeUnPunto();

    }
// ---------------------aparece un enemigo que atrae las pelotas ------------------------

  if(tiempo_transcurrido>=10000 && tiempo_transcurrido<=15000 ){
  atraer = true;
  atraerAUnPunto();

    }
    
    
}
