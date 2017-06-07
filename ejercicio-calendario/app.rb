require 'sinatra' 
require_relative 'model/gestorcalendario'
require_relative 'model/calendario'

gestor = GestorCalendario.new

get  '/calendarios'  do
	calendarios = gestor.obtener_calendarios
  "<pre>#{calendarios}</pre>"
end

post  '/calendarios'  do
	calendario = Calendario.new (params['nombre'])
	gestor.agregarCalendario(calendario)
end

delete  '/calendarios'  do
	gestor.borrarCalendario(params['nombre'])
end

get  '/calendarios/:nombre'  do
	calendario = gestor.calendarios[params[:nombre].downcase]
    	"#{calendario}"
end
