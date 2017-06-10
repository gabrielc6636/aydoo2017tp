require_relative './exception_evento_sin_id'
require_relative './exception_evento_existente'

class Evento
  @@eventos = Hash.new
  attr_reader :calendario
  attr_reader :id
  attr_reader :nombre
  attr_reader :inicio
  attr_reader :fin
  attr_reader :recurrencia
  
  def initialize(calendario, id, nombre, inicio, fin, recurrencia=nil)
    raise ExceptionEventoSinId if id == ""
    raise ExceptionEventoExistente if @@eventos[id]
    @calendario = calendario
    @id = id
    @nombre = nombre
    @inicio = inicio
    @fin = fin
    @recurrencia = recurrencia
    @@eventos[id] = self
  end
  
  def self.batch(lista)
    lista.each do |l|
      Evento.new l['calendario'], l['id'], l['nombre'], l['inicio'], l['fin']
    end
  end
  
  def self.eventos
    @@eventos
  end
  
  def actualizar(inicio, fin)
    @inicio = inicio
    @fin = fin
  end
  
  def to_h
    return {"calendario" => @calendario,
            "id" => @id,
            "nombre" => @nombre,
            "inicio" => @inicio,
            "fin" => @fin}
  end
    
end
