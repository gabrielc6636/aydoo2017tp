require 'sinatra' 
require_relative 'model/gestorcalendario'
require_relative 'model/calendario'

gestor = GestorCalendario.new

get  '/calendarios' do
	calendarios = gestor.obtener_calendarios
  "<pre>#{calendarios}</pre>"
end

post '/calendarios' do
  begin
    calendario = Calendario.new (params['nombre'])
    gestor.agregarCalendario(calendario)
    status 201
  rescue ExceptionCalendarioExistente, ExceptionCalendarioSinNombre
    status 400
  end
end

delete '/calendarios/:nombre' do
  begin
    gestor.borrar_calendario(params[:nombre])
  rescue ExceptionCalendarioNoEncontrado
    status 404
  end
end

get '/calendarios/:nombre' do
  begin
    calendario = gestor.obtener_calendario(params[:nombre])
    "<pre>#{calendario}</pre>"
  rescue ExceptionCalendarioNoEncontrado
    status 404
  end
end
