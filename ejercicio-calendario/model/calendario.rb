require_relative './exceptioncalendariosinnombre'

class Calendario
  
  attr_reader :nombre
  
  def initialize(nombre)
    if nombre == ""
      raise ExceptionCalendarioSinNombre
    end
    @nombre = nombre
  end
  
  def hash()
    return {"nombre" => @nombre}
  end
    
end
