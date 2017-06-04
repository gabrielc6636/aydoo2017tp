require 'sinatra' 
require_relative 'model/gestorcalendario'

gestor = GestorCalendario.new

get  '/calendarios'  do
		calendarios = gestor.calendarios
    "#{calendarios}"
end

