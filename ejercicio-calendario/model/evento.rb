require_relative './calendario'
require_relative './exception_duracion_invalida'
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
  attr_reader :eventos_recurrentes
  
  def initialize(calendario, id, nombre, inicio, fin, recurrencia=nil)
    raise ExceptionEventoSinId if id == ""
    raise ExceptionEventoExistente if @@eventos[id]
    validar_duracion(inicio, fin)
    @inicio = inicio
    @fin = fin
    @calendario = calendario
    calendario.agregar_evento(self)
    @id = id
    @nombre = nombre
    @recurrencia = recurrencia
    @@eventos[id] = self
    generar_eventos_recurrentes
  end
  
  def generar_eventos_recurrentes
    eventos_recurrentes = Hash.new
    if not @recurrencia.nil?
      fecha_actual = DateTime.parse(@inicio)
      duracion = (DateTime.parse(@fin) - fecha_actual)
      fecha_fin = DateTime.parse(@recurrencia.fin)
      fecha_actual += @recurrencia.frecuencia.to_i
      contador = 1
      while fecha_actual < fecha_fin
        id = @id + "R#" + contador.to_s
        eventos_recurrentes[id] = Evento.new @calendario, id, @nombre, fecha_actual.to_s, (fecha_actual + duracion).to_s
        contador += 1
        fecha_actual += @recurrencia.frecuencia.to_i
      end
    end
    @eventos_recurrentes = eventos_recurrentes
  end
  
  def validar_duracion(inicio, fin)
    inicio = @inicio if inicio.nil?
    fin = @fin if fin.nil?
    fecha_hora_inicio = DateTime.parse(inicio)
    fecha_hora_fin = DateTime.parse(fin)
    horas = (fecha_hora_fin - fecha_hora_inicio) * 24
    raise ExceptionDuracionInvalida if horas.between?(0,72) == false
  end
  
  def self.batch(lista)
    lista.each do |l|
      Evento.new Calendario.calendarios[l['calendario'].downcase], l['id'], l['nombre'], l['inicio'], l['fin']
    end
  end
  
  def self.eventos
    @@eventos
  end
  
  def actualizar(inicio, fin)
    inicio = @inicio if inicio.nil?
    fin = @fin if fin.nil?
    validar_duracion(inicio, fin)
    calendario.validar_superposicion(inicio, fin, @id)
    @inicio = inicio
    @fin = fin
  end
  
  def to_h
    hash = {"calendario" => @calendario.nombre,
            "id" => @id,
            "nombre" => @nombre,
            "inicio" => @inicio,
            "fin" => @fin}
    if @recurrencia
      hash["recurrencia"] = recurrencia.to_h
    end
    return hash
  end
    
end
