Trabajo sobre el salto del personaje.

La idea es generar un efecto mas satisfactorio en el jugador al saltar y diferenciar el salto normal con el salto en el aire haciendo que tengan efectos distintos. Se agrega el juiciness especialmente al segundo salto para dar feedback al jugador de que se trata de un movimiento diferente que permite llegar a nuevos lugares, y que le da mas potencia a los saltos. Tambien estos permite indicar que el segundo salto tiene logica con los poderes del personaje, ya que es algo sobrenatural saltar en el aire y tiene mas sentido que se genere un efecto especial al hacerlo.

Cambios:

Primero agregue un nuevo AudioHandler para el doblejump y su efecto de sonido, siendo mas fuerte haciendo notar que es una accion especial.

Luego agregue un efecto ghost al segundo salto que proyecta la imagen del sprite de toda la trayectora del salto.

Por ultimo, agregue dos particulas al segundo salto, uno que siga el rastro del salto, y una pequeña explosion de nubes que ayude a indicar la potencia de ese salto.