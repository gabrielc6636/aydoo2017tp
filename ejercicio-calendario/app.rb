require 'sinatra' 
require_relative 'model/gestor_eventos'
require_relative 'model/calendario'
require_relative 'model/formateador_json'
require_relative 'model/exception_calendario_existente'
require_relative 'model/exception_calendario_sin_nombre'

gestor_eventos = GestorEventos.new

get  '/calendarios' do
  calendarios = Calendario.calendarios.values
  salida = FormateadorJson.formatear_coleccion(calendarios)
  "<pre>#{salida}</pre>"
end

post '/calendarios' do
  begin
    Calendario.new params['nombre']
    status 201
  rescue ExceptionCalendarioExistente, ExceptionCalendarioSinNombre
    status 400
  end
end

delete '/calendarios/:nombre' do
  begin
    Calendario.calendarios.delete(params[:nombre].downcase) { |k| fail KeyError, k }
  rescue KeyError
    status 404
  end
end

get '/calendarios/:nombre' do
  begin
    calendario = Calendario.calendarios.fetch(params[:nombre].downcase)
    salida = FormateadorJson.formatear_objeto(calendario)
    "<pre>#{salida}</pre>"
  rescue KeyError
    status 404
  end
end

post '/eventos' do
  gestor_eventos.agregar_evento(params['calendario'], params['id'], params['nombre'], params['inicio'], params['fin'])
  status 201
end

get '/eventos' do
  eventos = gestor_eventos.obtener_eventos
  "<pre>#{eventos}</pre>"
end

get '/eventos/:id' do
  evento = gestor_eventos.obtener_evento(params[:id])
  "<pre>#{evento}</pre>"
end
