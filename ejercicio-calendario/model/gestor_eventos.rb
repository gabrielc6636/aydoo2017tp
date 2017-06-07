require 'json'

class GestorEventos
  attr_reader :eventos
  
  def initialize
    @eventos = Hash.new
  end
  
  def agregar_evento(calendario, id, nombre, inicio, fin)
    @eventos[id] = Evento.new calendario, id, nombre, inicio, fin
  end
  
  def obtener_evento(id)
    evento = eventos[id]
    return JSON.pretty_generate(evento.hash)
  end
    
end
