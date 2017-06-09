require_relative './evento'
require 'json'

class GestorEventos
  attr_reader :eventos
  
  def initialize
    @eventos = Hash.new
  end
  
  def agregar_evento(calendario, id, nombre, inicio, fin)
    @eventos[id] = Evento.new calendario, id, nombre, inicio, fin
  end
  
  def obtener_eventos
    res = []
    eventos.values.each do |e|
      res << e.to_h
    end
    return JSON.pretty_generate(res)
  end
    
end
