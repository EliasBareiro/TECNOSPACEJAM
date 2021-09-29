String conseguirNombre(FBody cuerpo)
{
  String nombre = "nada";
  
  if (cuerpo != null)
  {
    nombre = cuerpo.getName();
    
    if (nombre == null)
    {
      nombre = "nada";
    }
  }
  
  return nombre;
}

void dividirCirculo(FCircle circulo)
{
  
  world.remove(circulo);
  

}void moverAro(FCircle bola){
  
  float d1 = bola.getSize() / 3;
  float x1 = bola.getX();
  float y1 = bola.getY();
  
  world.remove(bola);
  
  bola = new FCircle(60);
  bola.setPosition(1000, random(100,500));
  bola.attachImage(imagen_aro);
  bola.setName("mouse");
  bola.setStatic(true);
  world.add(bola);
  

}

void repelerDesdeUnPunto()
{
  if (repeler == true){
  ArrayList<FBody> cuerpos = world.getBodies();

  float factor = 100;

  for (FBody cuerpo : cuerpos)
  {
    float dx = cuerpo.getX() - puntoEnX;
    float dy = cuerpo.getY() - puntoEnY;

    if(dist (puntoEnX,puntoEnY, cuerpo.getX(),cuerpo.getY()) < 200){
       cuerpo.addForce(dx * 100, dy * 100);
   }
  } 

  pushStyle();

  noStroke();
  fill(0,0,200,100);
  ellipse(puntoEnX,puntoEnY, 300,300);

  popStyle();

  ellipse(puntoEnX,puntoEnY, 50,50);

 }
}


void atraerAUnPunto()
{

  if (atraer == true){
  ArrayList<FBody> cuerpos = world.getBodies();

  float factor = 100;

  for (FBody cuerpo : cuerpos)
  {
    float dx = puntoEnX1 - cuerpo.getX();
    float dy = puntoEnY1 - cuerpo.getY();


    if(dist (puntoEnX1,puntoEnY1, cuerpo.getX(),cuerpo.getY()) < 200){
       cuerpo.addForce(dx * 100, dy * 100);
   }
  }
  pushStyle();

  noStroke();
  fill(200,0,0,100);
  ellipse(puntoEnX1,puntoEnY1, 300,300);

  popStyle();

  ellipse(puntoEnX1,puntoEnY1, 50,50); 

  }

}


void mostrarTiempo() {
  //actualizo cuantos segundos pasaron desde iniciarTiempo:
  tiempo_transcurrido = millis()-millis_inicio;
  fill(0,255,0);
  
  fill(255, 255, 0, 180);
  float tiempo_a_escala_pantalla = map(tiempo_transcurrido, 0, 20*1000, height, 0); //mapeo del tiempo para que aparezca como un rectangulo en la pantalla
  //rect(790, tiempo_a_escala_pantalla, 10, height);
}
void iniciarTiempo() {
  millis_inicio = millis(); 
  
}
