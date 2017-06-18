require 'sinatra'
require_relative 'model/gestor_archivos'
require_relative 'model/calendario'
require_relative 'model/evento'
require_relative 'model/recurrencia'
require_relative 'model/formateador_json'
require_relative 'model/exception_calendario_existente'
require_relative 'model/exception_calendario_sin_nombre'
require_relative 'model/repositorioRecursos'
require_relative 'model/controladorRecursos.rb'

archivo_calendarios = "calendarios.json"
archivo_eventos = "eventos.json"
gestorArchivos = GestorArchivos.new
controladorRecursos = ControladorRecursos.new

lista_recursos = FormateadorJson.interpretar(gestorArchivos.cargarRecursos())
controladorRecursos.cargarRecursos(lista_recursos)
lista_calendarios = FormateadorJson.interpretar(gestorArchivos.leer(archivo_calendarios))
lista_eventos = FormateadorJson.interpretar(gestorArchivos.leer(archivo_eventos))

Calendario.crear_desde_lista(lista_calendarios)
Evento.crear_desde_lista(lista_eventos, controladorRecursos)


post '/calendarios' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    Calendario.new(entrada.fetch('nombre'))
    calendarios = Calendario.calendarios.values
    salida = FormateadorJson.formatear_coleccion(calendarios)
    gestorArchivos.escribir(salida, archivo_calendarios)
    halt 200, "Se ha creado el calendario con exito el calendario"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

delete '/calendarios/:nombre' do
  begin
    nombre = params[:nombre].downcase
    calendario = Calendario.calendarios.fetch(nombre)
    calendario.eliminar_eventos
    Calendario.calendarios.delete(nombre)
    calendarios = Calendario.calendarios.values
    salida = FormateadorJson.formatear_coleccion(calendarios)
    gestorArchivos.escribir(salida, archivo_calendarios)
    halt 200, "Se ha eliminado con exito el calendario " + nombre
  rescue Exception =>ex
    halt 400, "404 Not Found: " + ex.to_s
  end
end

get '/calendarios' do
  begin
  calendarios = Calendario.calendarios.values
  salida = FormateadorJson.formatear_coleccion(calendarios)

  halt 200, salida
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/calendarios/:nombre' do
  begin
    calendario = Calendario.calendarios.fetch(params[:nombre].downcase)
    salida = FormateadorJson.formatear_objeto(calendario)
    halt 200, salida
  rescue Exception => ex
    halt 404, "404 Not Found: " + ex.to_s
  end
end

post '/eventos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    calendario = Calendario.calendarios.fetch(entrada.fetch('calendario').downcase)
    recurrencia = nil
    if entrada['recurrencia']
      recurrencia = Recurrencia.new(entrada['recurrencia'].fetch('frecuencia'), entrada['recurrencia'].fetch('fin'))
    end
    Evento.new(calendario, entrada.fetch('id'), entrada.fetch('nombre'),
               entrada.fetch('inicio'), entrada.fetch('fin'), recurrencia)
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)
    gestorArchivos.escribir(salida, archivo_eventos)
    halt 201, "Se ha creado el evento con exito"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

delete '/eventos/:id' do
  begin
    evento = Evento.eventos.fetch(params[:id])
    evento.eliminar_eventos_recurrentes
    Evento.eventos.delete(evento.id)
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)
    gestorArchivos.escribir(salida, archivo_eventos)
    halt 200, "Se ha eliminado con exito el evento"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

put '/eventos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    evento = Evento.eventos.fetch(entrada['id'])
    evento.actualizar(entrada['inicio'], entrada['fin'])
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)
    gestorArchivos.escribir(salida, archivo_eventos)
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos' do
  begin
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)

    halt 200, salida
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos?:calendario?' do
  begin
  calendario = Calendario.calendarios.fetch(params['calendario'])
  salida = FormateadorJson.formatear_coleccion(calendario.eventos.values)

  halt 200, salida
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos/:id' do
  begin
    evento = Evento.eventos.fetch(params[:id])
    salida = FormateadorJson.formatear_objeto(evento)
    "#{salida}"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

post '/recursos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])

    controladorRecursos.agregarRecurso(entrada.fetch('nombre'))
    
    halt 201, "El recurso se creo con exito"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/recursos' do
  begin    
    recursos = controladorRecursos.obtenerRecursos()    
    
    halt 200, salida = FormateadorJson.formatear_coleccion(recursos)
  rescue Exception => ex
    halt 400, ex.to_s
  end
end

delete '/recursos/:id' do
  begin
    id_recurso = params[:id]

    controladorRecursos.eliminarRecurso(id_recurso)    

    halt 200, "El recurso se elimino con exito"
  rescue Exception => ex
    halt 404, "Ha ocurrido un error al eliminar el recurso: " + ex.to_s
  end
end

post '/eventos/:id_evento/:id_recurso' do
  begin
    id_recurso = params[:id_recurso]
    id_evento = params[:id_evento]

    controladorRecursos.asignarRecursoAEvento(id_recurso, id_evento)   

    halt 200, "El recurso se asigno al evento con exito"
  rescue Exception => ex
    halt 400, "Ha ocurrido un error al asignar el recurso: " + ex.to_s
  end  
end

