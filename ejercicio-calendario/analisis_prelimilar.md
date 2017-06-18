Análisis Diagramas
 
En el diagrama de clases faltan las clases excepcion. Con el diagrama actual no se sabe quién usa las excepciones. 
En el diagrama de clases hay una clase SumadorRecurrencia que no se ve en el modelo. Si hay otras clases como SumadorRecurrenciaAnual, SumadorRecurrenciaDiaria, SumadorRecurrenciaMensual y SumadorRecurrenciaSemanal, las cuales no están representadas en el diagrama. 
 
Análisis Diseño
 
Un calendario conoce calendarios, lo cual resulta raro conceptualmente, es difícil de entender porque un calendario debería conocer otros calendarios. Los mismo ocurre con evento que conoce una coleccion de eventos. Ambas clases se encargan de crear, actualizar, y eliminar en esas colecciones. 
Esto viola el principio solid single responsibility ya que un calendario se encarga de crear calendarios lo cual no es correcto. Lo mismo ocurre con el evento.
 
La clase calendario y evento violan el principio solid Open/Close pues también se encarga de validar la superposición de eventos dentro de un calendario y el evento se encarga de validar la duración del evento no sea mayor a 72 horas. La responsabilidad de estas validaciones de negocio deberían ser llevadas a cabo por otro objeto, pues si el dia de mañana se agrega otra validación, como por ejemplo si entre la fecha de inicio y fin del evento hay un feriado se extiende la duracion del evento 24 horas más, entonces debería modificar las clase evento lo cual no es correcto.

El hecho que la clase Evento sepa como crear eventos recurrentes y como validar las reglas negocios violan el principio solid interface segregacion pues la logica con se crean los eventos recurrente no debe conocerla el Evento. El evento, a lo sumo, solo deberia saber como agregarse esos eventos creados recurrentemente. Seria más correcto que la logica de creacion de eventos en forma recurrente es una reponsabilidad que deberia manejar otro objeto.
 
La clase Recurrencia viola el principio Liskov Substitution pues en lugar de tener un atributo sumador que sea instancia de una clase abstracta SumadorDeRecurrencia, (que creo que fue la idea viendo el diagrama de clase) y usar las otras clases sumadores de forma polimórfica, se realizó un método llamado “self.sumadores” que devuelve un diccionario de sumadores. También se observa que la firma del método es confusa pues contiene un self en al firma.
 
La clase Recurrencia viola el principio interface segregation pues como se señaló en el punto anterior los sumadores podrían ser tratados mediante una clase abstracta o simplemente generar la instancia de sumador correspondiente mediante un factory method. Esto último creo que es lo que se buscó hacer con el método “self.sumadores” en la clase Recurrencia
 
Las clase evento viola el principio interface segregation a través del método “generar_eventos_recurrentes” pues tiene la lógica de creación de eventos recurrentes a lo sumo el evento debería recibir la coleccion de los eventos generados de forma recurrente y guardarla.

app.rb viola el principio interface segregation, pues en los post y get poseen logica de negocio por ejemplo, como se obtiene los eventos, calendarios, como se persisten los datos, como se crean los eventos etc.

Funcionalidades

la funcionalidad que pretender traer todos los eventos de un calendario no funciona: get '/eventos?:calendario?'
 
Mejoras

Los métodos get y post de app.rb no tiene feedback de si la operación fue exitosa o no más allá del status de la operación. Sería correcto mostrar mensajes de creación, actualización o borrado exitoso y sería más interesante aún que cuando se produzca un error aparezca un mensaje informando el error producido.
 
Los nombre de algunos métodos y variable resultan confusos, por ejemplo el métodos de la clase calendario y evento cuya firma es “to_h” el nombre no representa lo que hace el método que por el cuerpo del mismo se deduce que genera un json con los datos del evento o calendario según corresponda. 
Existen métodos estáticos “self” en la firma lo cual equivale a un método estático. Estos métodos dificultan la creación de test
