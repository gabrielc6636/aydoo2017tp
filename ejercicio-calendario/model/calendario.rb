require_relative './exception_calendario_sin_nombre'

class Calendario
  attr_reader :nombre
  
  def initialize(nombre)
    if nombre == ""
      raise ExceptionCalendarioSinNombre
    end
    @nombre = nombre
  end
  
  def to_h
    return {"nombre" => @nombre}
  end
    
end
