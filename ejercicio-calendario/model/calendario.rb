require_relative './exception_calendario_sin_nombre'
require_relative './exception_calendario_existente'

class Calendario
  @@calendarios = Hash.new
  attr_reader :nombre
  attr_reader :eventos
  
  def initialize(nombre)
    raise ExceptionCalendarioSinNombre if nombre == ""
    raise ExceptionCalendarioExistente if @@calendarios[nombre.downcase]
    @nombre = nombre
    @eventos = Hash.new
    @@calendarios[nombre.downcase] = self
  end
  
  def agregar_evento(evento)
    @eventos[evento.id] = evento
  end
  
  def self.batch(lista)
    lista.each do |l|
      Calendario.new l['nombre']
    end
  end
  
  def self.calendarios
    @@calendarios
  end
  
  def to_h
    return {"nombre" => @nombre}
  end
    
end
