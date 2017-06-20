require 'sinatra'
require_relative 'model/controladorApp.rb'
require_relative 'model/controladorRecursos.rb'

controladorRecursos = ControladorRecursos.new
controladorRecursos.cargar_recursos()
controladorApp = ControladorApp.new
controladorApp.cargar_datos(controladorRecursos)


post '/calendarios' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    controladorApp.agregar_calendario(entrada.fetch('nombre'))

    halt 200, "Se ha creado el calendario con exito el calendario"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

delete '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    controladorApp.eliminar_calendario(nombre, controladorRecursos)

    halt 200, "Se ha eliminado con exito el calendario " + nombre
  rescue Exception =>ex
    halt 400, "404 Not Found: " + ex.to_s
  end
end

get '/calendarios' do
  begin
    calendarios = controladorApp.obtener_calendarios()
    salida = FormateadorJson.formatear_coleccion(calendarios)

    halt 200, salida
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/calendarios/:nombre' do
  begin    
    calendario = controladorApp.obtener_calendario(params[:nombre])
    salida = FormateadorJson.formatear_objeto(calendario)

    halt 200, salida
  rescue Exception => ex
    halt 404, "404 Not Found: " + ex.to_s
  end
end

post '/eventos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    controladorApp.guardar_evento(entrada)

    halt 201, "Se ha creado el evento con exito"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

delete '/eventos/:id' do
  begin
    nombreEvento = params[:id]
    controladorApp.eliminar_evento(nombreEvento, controladorRecursos)

    halt 200, "Se ha eliminado con exito el evento"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

put '/eventos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    controladorApp.actualizar_evento(entrada)

    halt 200, "El evento ha sido actualizado con exito"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos' do
  begin
    eventos = controladorApp.obtener_eventos
    salida = FormateadorJson.formatear_coleccion(eventos)

    halt 200, salida
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos/calendario/:calendario' do
  begin
    nombreCalendario = params[:calendario]
    calendario = controladorApp.obtener_eventos_para_calendario(nombreCalendario)
    salida = FormateadorJson.formatear_coleccion(calendario.eventos.values)

    halt 200, salida
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos/:id' do
  begin
    nombreEvento = params[:id]
    evento = controladorApp.obtener_evento(nombreEvento)
    salida = FormateadorJson.formatear_objeto(evento)

    halt 200, salida
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

post '/eventos/:id_evento/:id_recurso' do
  begin
    id_recurso = params[:id_recurso]
    id_evento = params[:id_evento]

    controladorRecursos.asignar_recurso_evento(id_recurso, id_evento)   

    halt 200, "El recurso se asigno al evento con exito"
  rescue Exception => ex
    halt 400, "Ha ocurrido un error al asignar el recurso: " + ex.to_s
  end  
end

post '/recursos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])

    controladorRecursos.agregar_recurso(entrada.fetch('nombre'))
    
    halt 201, "El recurso se creo con exito"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/recursos' do
  begin    
    recursos = controladorRecursos.obtener_recursos()    
    
    halt 200, salida = FormateadorJson.formatear_coleccion(recursos)
  rescue Exception => ex
    halt 400, ex.to_s
  end
end

delete '/recursos/:id' do
  begin
    id_recurso = params[:id]
    controladorRecursos.eliminar_recurso(id_recurso)    

    halt 200, "El recurso se elimino con exito"
  rescue Exception => ex
    halt 404, "Ha ocurrido un error al eliminar el recurso: " + ex.to_s
  end
end

post '/recursos/liberar/:id' do
  begin
    id_recurso = params[:id]

    controladorRecursos.liberar_recurso(id_recurso)   

    halt 200, "El recurso ha sido liberado"
  rescue Exception => ex
    halt 400, "Ha ocurrido un error al liberar el recurso: " + ex.to_s
  end 
end

