require 'sinatra' 
require_relative 'model/gestor_calendarios'
require_relative 'model/gestor_eventos'
require_relative 'model/exception_calendario_existente'
require_relative 'model/exception_calendario_sin_nombre'
require_relative 'model/exception_calendario_no_encontrado'

gestor_calendarios = GestorCalendarios.new
gestor_eventos = GestorEventos.new

get  '/calendarios' do
  calendarios = gestor_calendarios.obtener_calendarios
  "<pre>#{calendarios}</pre>"
end

post '/calendarios' do
  begin
    gestor_calendarios.agregar_calendario(params['nombre'])
    status 201
  rescue ExceptionCalendarioExistente, ExceptionCalendarioSinNombre
    status 400
  end
end

delete '/calendarios/:nombre' do
  begin
    gestor_calendarios.borrar_calendario(params[:nombre])
  rescue ExceptionCalendarioNoEncontrado
    status 404
  end
end

get '/calendarios/:nombre' do
  begin
    calendario = Calendario.calendarios[params[:nombre].downcase]
    salida = FormateadorJson.formatear_objeto(calendario)
    "<pre>#{salida}</pre>"
  rescue ExceptionCalendarioNoEncontrado
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
