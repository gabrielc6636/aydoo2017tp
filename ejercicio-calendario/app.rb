require 'sinatra' 
require_relative 'model/gestorcalendario'
require_relative 'model/calendario'

gestor = GestorCalendario.new

get  '/calendarios'  do
	calendarios = gestor.calendarios
    	"#{calendarios}"
end

post  '/calendarios'  do
	calendario = Calendario.new (params['nombre'])
	gestor.agregarCalendario(calendario)
end

delete  '/calendarios'  do
	gestor.borrarCalendario(params['nombre'])
end
