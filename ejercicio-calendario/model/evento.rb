require_relative './calendario'
require_relative './recurrencia'
require_relative './exception_duracion_invalida'
require_relative './exception_evento_sin_id'
require_relative './exception_evento_existente'
require_relative 'jsonEvento.rb'
require_relative 'recurso.rb'
require_relative 'validadorDeRecurso.rb'

class Evento
  @@eventos = {}
  attr_reader :calendario
  attr_reader :id
  attr_reader :nombre
  attr_reader :inicio
  attr_reader :fin
  attr_accessor :recurrencia
  attr_reader :eventos_recurrentes

  attr_accessor :recursosAsignados

  DURACION_MAXIMA_HORAS = 72
  HORAS_EN_DIA = 24

  def initialize(calendario, id, nombre, inicio, fin, recurrencia=nil)
    raise ExceptionEventoSinId if id == ""
    raise ExceptionEventoExistente if @@eventos[id]
    validar_duracion(inicio, fin)
    @inicio = inicio
    @fin = fin
    @calendario = calendario
    @nombre = nombre
    @id = id
    calendario.agregar_evento(self)
    self.recurrencia = recurrencia
    @@eventos[id] = self
    generar_eventos_recurrentes

    self.recursosAsignados = {}  
  end

  def generar_eventos_recurrentes
    eventos_recurrentes = {}
    if not @recurrencia.nil?
      fecha_actual = DateTime.parse(@inicio)
      duracion = (DateTime.parse(@fin) - fecha_actual)
      fecha_fin = DateTime.parse(@recurrencia.fin)
      fecha_actual = Recurrencia.sumadores[@recurrencia.frecuencia]
                         .sumar(fecha_actual)
      contador = 1
      while fecha_actual < fecha_fin
        id = @id + "R#" + contador.to_s
        nombre = @nombre + " #" + contador.to_s
        fin_evento = fecha_actual + duracion
        eventos_recurrentes[id] = Evento.new(
            @calendario, id, nombre, fecha_actual.to_s, fin_evento.to_s)
        contador += 1
        fecha_actual = Recurrencia.sumadores[@recurrencia.frecuencia]
                           .sumar(fecha_actual)
      end
    end
    @eventos_recurrentes = eventos_recurrentes
  end

  def validar_duracion(inicio, fin)
    inicio = @inicio if inicio.nil?
    fin = @fin if fin.nil?
    fecha_hora_inicio = DateTime.parse(inicio)
    fecha_hora_fin = DateTime.parse(fin)
    horas = (fecha_hora_fin - fecha_hora_inicio) * HORAS_EN_DIA
    raise ExceptionDuracionInvalida if horas.between?(
        0, DURACION_MAXIMA_HORAS) == false
  end

  def self.crear_desde_lista(lista, controladorDeRecursos)    
    lista.each do |jsonEvento|
      manejadorJson = JsonEvento.new(jsonEvento)
      validadorDeRecursos = ValidadorDeRecurso.new

      if /R#[[:digit:]]/.match(manejadorJson.obtenerIdEvento()).nil?        
        recurrencia = nil    
        calendario = Calendario.calendarios[manejadorJson.obtenerNombreCalendario().downcase]      
        if manejadorJson.tieneRecurrencia?
          recurrencia = Recurrencia.new(manejadorJson.obtenerFrecuenciaDeRecurrencia(), manejadorJson.obtenerFinDeRecurrencia())          
        end
        evento = Evento.new(calendario, manejadorJson.obtenerIdEvento(),
                   manejadorJson.obtenerNombreEvento(), manejadorJson.obtenerFechaInicio(),
                   manejadorJson.obtenerFechaFin(), recurrencia)  
          if manejadorJson.tieneRecursosAsignados?
            manejadorJson.obtenerRecursosAsignados().each do |recursoJson|
              nombre_recurso = recursoJson['nombre']
              validadorDeRecursos.validarRecursoInExistente(nombre_recurso, controladorDeRecursos.repositorioRecursos)
              recurso = controladorDeRecursos.obtenerRecurso(nombre_recurso)
              evento.agregarRecurso(recurso)
            end
          end       
      end
    end
  end

  def agregarRecurso(nuevoRecurso) 
    self.recursosAsignados[nuevoRecurso.nombre] = nuevoRecurso
  end

  def eliminarRecursoAsignado(recurso)
    recursosAsignados.delete(recurso.nombre)
  end

  def asignarRecurso(recurso)
    agregarRecurso(recurso)
    recurso.reservar()
  end

  def self.eventos
    @@eventos
  end

  def eliminar_eventos_recurrentes
    Evento.class_variable_set :@@eventos, Evento.eventos.delete_if {
        |k, v| @eventos_recurrentes.key?(k)}
    @calendario.eventos = @calendario.eventos.delete_if {
        |k, v| @eventos_recurrentes.key?(k)}
    @eventos_recurrentes = {}
  end

  def actualizar(inicio, fin)
    inicio = @inicio if inicio.nil?
    fin = @fin if fin.nil?
    validar_duracion(inicio, fin)
    calendario.validar_superposicion(inicio, fin, @id)
    @inicio = inicio
    @fin = fin
    eliminar_eventos_recurrentes
    generar_eventos_recurrentes
  end

  def to_h
    hash = {"calendario" => @calendario.nombre,
            "id" => @id,
            "nombre" => @nombre,
            "inicio" => @inicio,
            "fin" => @fin,   
          }

    if !self.recursosAsignados.empty?
        recursos_str = []
        recursosAsignados.values.each do |recurso| 
          recursos_str << recurso.to_h
        end        
      hash["recursosAsignados"] = recursos_str
    end
    if @recurrencia
      hash["recurrencia"] = recurrencia.to_h
    end
    return hash
  end

end
