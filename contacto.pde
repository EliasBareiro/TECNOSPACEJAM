// -----------  hago que los objetos tengan contacto -------------

void contactStarted(FContact contacto)
{
  FBody cuerpo1 = contacto.getBody1();
  FBody cuerpo2 = contacto.getBody2();
  
  String nombre1 = conseguirNombre(cuerpo1);
  String nombre2 = conseguirNombre(cuerpo2);
  
  if (nombre1 == "mouse" && nombre2 == "pelotabasket") dividirCirculo((FCircle)cuerpo2);
  if (nombre2 == "mouse" && nombre1 == "pelotabasket") dividirCirculo((FCircle)cuerpo1);
  if (nombre1 == "suelo" && nombre2 == "pelotabasket") dividirCirculo((FCircle)cuerpo2);
  if (nombre2 == "suelo" && nombre1 == "pelotabasket") dividirCirculo((FCircle)cuerpo1);
  if (nombre1 == "mouse" && nombre2 == "pelotabasket") moverAro((FCircle)cuerpo1);
  if (nombre2 == "mouse" && nombre1 == "pelotabasket") moverAro((FCircle)cuerpo2 ); 
  if (nombre1 == "mouse") puntos=puntos+1; 
  if (nombre1 == "mouse") Aclamacion.play();
  if (nombre1 == "suelo") vidas=vidas-1;
  if (nombre1 == "suelo") Oohh.play();
}
