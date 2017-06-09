require_relative './exception_calendario_sin_nombre'
require_relative './exception_calendario_existente'

class Calendario
  @@calendarios = Hash.new
  attr_reader :nombre
  
  def initialize(nombre)
    raise ExceptionCalendarioSinNombre if nombre == ""
    raise ExceptionCalendarioExistente if @@calendarios[nombre.downcase]
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
