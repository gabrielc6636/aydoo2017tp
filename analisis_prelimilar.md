<h2>¿Está la documentación/diagramas completos?</h2>

* El diagrama de clases no refleja todas clases del sistema. Por ejemplos los sumadores, excepciones.
* En los diagrama de secuencia solo se muestra la creacion de un evento y de un calendario, no parecen los diagramas de secuencia para los circuitos de actualizar, borrar un evento, borrar calendario, crear eventos recurrentes.

<h2>¿Está correctamente utilizada la notación UML?</h2>



<h2>¿Son consistentes los diagramas con el código?</h2>

* En el diagrama no se muestran todos los tipos de sumadores que figuran en el metodo estatico sumadores de la clase Recurrencia.
* El diagrama muestra que la Recurrencia conoce 4 sumadores de recurrencia cuando en realidad solo los usa. 
* El diagrama muestra que la coleccion de eventos del calendario esta condicionada a la existencia del mismo. Sin embargo al eliminar un calendario sus eventos no se eliminan.

<h2>¿Implementa toda la funcionalidad pedida?</h2>

* Segun el diagrama de clases un calendario poseen una coleccion de eventos que esta condicionada al mismo, esto quiere decir que si se elimina el calendario tambien su coleccion de evetnos. Tomando en cuenta esta se observo que la funcionalidad borrar calendario no borra los eventos asociados. 
* La funcionalidad que pretender traer todos los eventos de un calendario no funciona: get '/eventos?:calendario?'
* Editar un evento para hacerlo recurrente no lo actualiza

<h2>¿Qué observaciones tiene sobre el modelo?</h2>

**Se observaron la siguientes violaciones a los principios Solid:**

1. Single responsability: 
  	 * Se observa que las no tiene responsabilidades unicas, algunos ejemplos:
	 * Las clases Calendario y Evento clases se encargan de crear, actualizar, y eliminar en esas colecciones. Esto viola el principio solid single responsibility ya que un calendario se encarga de crear calendarios lo cual no es correcto. Lo mismo ocurre con el evento.
	 * En app.rb cada post y get muestra la logica de negocio de como crear, obtener y actualiza los objetos. Ademas posee constantes que muestran los nombres de archivos donde se guardaran los datos. Posee mucha informacion que deberia ser manejada por otros objetos
	 
2. Open/Close: 
	 * La clase calendario y evento también se encarga de validar la superposición de eventos dentro de un calendario y el evento se encarga de validar la duración del evento no sea mayor a 72 horas. La responsabilidad de estas validaciones de negocio deberían ser llevadas a cabo por otro objeto, pues si el dia de mañana se agrega otra validación debería modificar la clase evento lo cual no es correcto.
	 * La clase Recurrencia posee un método llamado “self.sumadores” que devuelve un diccionario de sumadores. Luego dependiendo de la frecuencia crea y devuelve una instancia del sumador correspondiente.

3. Inversion de dependencia: 
	 * La clase Evento sabe como crear eventos recurrentes y como validar las reglas negocios, la logica con se crean los eventos recurrente no debe conocerla el Evento. El evento, a lo sumo, solo deberia saber como agregarse esos eventos creados recurrentemente. Seria más correcto que la logica de creacion de eventos en forma recurrente es una reponsabilidad que deberia manejar otro objeto.
	 * La clase evento por ejemplo crear_desde_lista al instanciar un objeto de tipo Recurrencia. Esto dificulta la realizacion de los test.

**Observaciones en cuanto decisiones de diseño**
 
* Un calendario conoce calendarios, lo cual resulta raro conceptualmente. Los mismo ocurre con evento que conoce una coleccion de eventos.
* La clase calendario se encarga de validar la superposicion.
* Resulta dificil incorporar cambios y realizar test ya que las responsabilidades no estan bien distribuidas. 
* Todo la logica de las funcionalidades es manejada por las clases Calendario, Evento y app.rb, esto provoca que cualquier cambio que se agregue involucre tocar minimamente dos clases. Por ejemplo el agregado de una validación.
* Dentro del metodo initialize de la clase Calendario se realizan validaciones sobre el nombre y se agrega el calendario que se esta creando en una colecciones de calendarios estatica que tambien administra la clase Calendario.
* Dentro del metodo initialize de la clase Evento se crear los eventos recurrentes, se realizan las validaciones de unicidad de nombre y id y se asocia el evento con el calendario.
	 
<h2>Cambios en el Diseño</h2>

* Refactor de la app.rb por violar principio single responsability e interface segregation. Para este fin se genero la clase ControladorApp
* Refactor de clase gestor de archivos pues este debe ser responsable de saber sobre que archivos guardar los datos y no la app.rb
* Agregar validadores para el evento
* Arreglar las funcionalidades que no funcionaban:
  * Editar evento para hacerlo recurrente
  * Al eliminar un calendario se deben eliminar junto con los eventos asociados
  * Obtener los eventos de un calendario determinado: Si bien la firma estaba bien (get 'eventos?calendario=calendario1') existia un problema ya que su nombre conincidia con la firma de otro y se terminaba llamando al metodo get 'eventos/' trayendo todos los eventos. La solucion propuesta fue modificar el nombre de la forma:
   	*Obtener eventos de un calendario especifico: get '/eventos/calendario/:calendario'
* Por los cambios realizados de rehacer diagramas de clases y secuencia debido a los cambios realizados

<h2> Partes 2: Recursos </h2>

* Se debe hacer un repositorio para recursos
* Un controlador que se encargue de administrar las altas, bajas y modificaciones sobre el repositorio
* Funcionalidades de asignar y liberar recurso
	 
