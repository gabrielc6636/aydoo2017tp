require 'sinatra'
require_relative 'model/gestor_archivos'
require_relative 'model/calendario'
require_relative 'model/evento'
require_relative 'model/recurrencia'
require_relative 'model/formateador_json'
require_relative 'model/exception_calendario_existente'
require_relative 'model/exception_calendario_sin_nombre'

archivo_calendarios = "calendarios.json"
archivo_eventos = "eventos.json"
Calendario.batch(FormateadorJson.interpretar(GestorArchivos.leer(archivo_calendarios)))
Evento.batch(FormateadorJson.interpretar(GestorArchivos.leer(archivo_eventos)))

get '/calendarios' do
  calendarios = Calendario.calendarios.values
  salida = FormateadorJson.formatear_coleccion(calendarios)
  "#{salida}"
end

post '/calendarios' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    Calendario.new entrada.fetch('nombre')
    calendarios = Calendario.calendarios.values
    salida = FormateadorJson.formatear_coleccion(calendarios)
    GestorArchivos.escribir(salida, archivo_calendarios)
    status 201
  rescue ExceptionCalendarioExistente, ExceptionCalendarioSinNombre, KeyError
    status 400
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
    GestorArchivos.escribir(salida, archivo_calendarios)
  rescue KeyError
    status 404
  end
end

get '/calendarios/:nombre' do
  begin
    calendario = Calendario.calendarios.fetch(params[:nombre].downcase)
    salida = FormateadorJson.formatear_objeto(calendario)
    "#{salida}"
  rescue KeyError
    status 404
  end
end

post '/eventos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    calendario = Calendario.calendarios.fetch(entrada['calendario'].downcase)
    recurrencia = nil
    if entrada['recurrencia']
      recurrencia = Recurrencia.new(entrada['recurrencia']['frecuencia'], entrada['recurrencia']['fin'])
    end
    Evento.new(calendario, entrada['id'], entrada['nombre'], entrada['inicio'], entrada['fin'], recurrencia)
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)
    GestorArchivos.escribir(salida, archivo_eventos)
    status 201
  rescue ExceptionEventoSinId, ExceptionEventoExistente, ExceptionDuracionInvalida, ExceptionEventoSuperpuesto
    status 400
  end
end

delete '/eventos/:id' do
  begin
    Evento.eventos.delete(params[:id]) {|k| fail KeyError, k}
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)
    GestorArchivos.escribir(salida, archivo_eventos)
  rescue KeyError
    status 404
  end
end

put '/eventos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    evento = Evento.eventos.fetch(entrada['id'])
    evento.actualizar(entrada['inicio'], entrada['fin'])
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)
    GestorArchivos.escribir(salida, archivo_eventos)
  rescue KeyError
    status 404
  rescue ExceptionDuracionInvalida, ExceptionEventoSuperpuesto
    status 400
  end
end

get '/eventos' do
  eventos = Evento.eventos.values
  salida = FormateadorJson.formatear_coleccion(eventos)
  "#{salida}"
end

get '/eventos?:calendario?' do
  calendario = Calendario.calendarios.fetch(params['calendario'])
  salida = FormateadorJson.formatear_coleccion(calendario.eventos.values)
  "#{salida}"
end

get '/eventos/:id' do
  begin
    evento = Evento.eventos.fetch(params[:id])
    salida = FormateadorJson.formatear_objeto(evento)
    "#{salida}"
  rescue KeyError
    status 404
  end
end
