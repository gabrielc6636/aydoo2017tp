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

PARTE 2

Decisiones de diseño

Un evento solo puede tener asignado un recurso a la ves
