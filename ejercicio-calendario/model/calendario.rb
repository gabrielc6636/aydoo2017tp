require_relative './exception_calendario_sin_nombre'

class Calendario
  @@calendarios = Hash.new
  attr_reader :nombre
  
  def initialize(nombre)
    if nombre == ""
      raise ExceptionCalendarioSinNombre
    end
    @nombre = nombre
    @@calendarios[nombre.downcase] = self
  end
  
  def self.calendarios
    @@calendarios
  end
  
  def to_h
    return {"nombre" => @nombre}
  end
    
end
