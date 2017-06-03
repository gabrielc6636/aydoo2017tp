require_relative './exceptioncalendarioexistente'

class GestorCalendario
  
  attr_reader :calendarios
  
  def initialize()
    @calendarios = Hash.new
  end
  
  def agregarCalendario(calendario)
    
    raise ExceptionCalendarioExistente if @calendarios[calendario.nombre]
    @calendarios[calendario.nombre] = calendario
    
  end
  
end
