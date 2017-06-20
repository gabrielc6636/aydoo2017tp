__Decisiones de diseño:__

* El calendario y el evento poseen una variable de clase que guarda todos los creados.
* Cada evento conoce los eventos recurrentes asociados al mismo.
* Los objetos se guardan en Hashes para permitir un acceso fácil y rápido por nombre o id.
* Al crear un evento con recurrencia, los eventos recurrentes se crean automáticamente.
* Un evento recurrente es igual a un evento, pero posee un ID y nombre definidos, basados en el evento origen. 
* La salida a consola/archivo y entrada desde request/archivo se realiza en formato JSON.
* El cálculo de la fecha de recurrencia se realiza mediante sumadores, uno para cada frecuencia.
* Se accede al sumador necesario mediante un hash, donde la key es el texto de la frecuencia (ej. "semanal").
* Existe una clase especializada en formatear e interpretar JSON, y otra para lectura y escritura a archivo.
* Como los eventos recurrentes se generan en la creación del original, los mismos no se crean desde lista.

<h1>PARTE 2: Recursos</h1>

<h2>DECISIONES DE DISEÑO </h2>

* Un evento puede tener varios recursos reservados pero no repetidos. y un recurso solo puede ser usado por un evento
* El recurso posee un booleano que indica si esta siendo usado o no. La razon para hacerlo de este modo radica en como se cargan los datos desde los archivos. Se pretendia en una primera instancia que un recurso conozca el evento que lo reservo y evento al recurso reservado, pero esto genero problemas de sincronizacion al cargar los datos desde los archivos.

**Asigancion de recursos**

* Para asignar un archivo a un evento se usa: post 'eventos/:id_evento/:id_recurso': De esta manera se le solicita asignar el recurso id_recurso al evento id_evento. Esta es la unica forma de asignar un recurso.
* No se puede asignar un recurso a un evento finalizado.
* Si el recurso a asignar esta asignado a un evento finalizado este puede asignarse a un nuevo evento.

**Liberacion de recurso**
	
* Es posible liberar un recurso mediante: post 'recursos/liberar/:id'. 
	* Si el recurso no esta siendo usado no hace nada. 
	* Si el recurso esta siendo usado, solo es posible liberarlo si el evento que lo esta usando ya finalizo, de lo contrario se lanza una excepción. 
* Al eliminar un evento si tiene recursos asigandos estos se liberan
* Al eliminar un calendario este eliminar su eventos y en procesos se liberan los recursos que tengan asociados esos eventos

**Eliminacion de recurso**

* Al eliminar un recurso el mismo se desasigna del evento que los esta usando.




 