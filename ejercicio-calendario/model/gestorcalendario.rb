require_relative './exceptioncalendarioexistente'
require_relative './exceptioncalendarionoencontrado'
require_relative './gestorarchivos'
require 'json'

class GestorCalendario
  
  attr_reader :calendarios
  
  def leer_de_archivo()
    gestorArchivo = GestorArchivos.new
    restablecer
    lineas = gestorArchivo.leer("calendarios.json")
    texto = ""
    lineas.each do |l|
      texto << l
    end
    if texto != ""
      res = JSON.parse(texto)
      res.each do |r|
        agregarCalendario(Calendario.new r["nombre"])
      end
    end
  end
  
  def restablecer()
    @calendarios = Hash.new
  end
  
  def initialize()
    leer_de_archivo
  end
  
  def escribir_en_archivo()
    gestorArchivo = GestorArchivos.new
    gestorArchivo.escribir(obtener_calendarios, "calendarios.json")
  end
  
  def agregarCalendario(calendario)
    
    nombre_minusculas = calendario.nombre.downcase
    raise ExceptionCalendarioExistente if @calendarios[nombre_minusculas]
    @calendarios[nombre_minusculas] = calendario
    escribir_en_archivo
    
  end
  
  def obtener_calendario(nombre)
    calendario = calendarios[nombre.downcase]
    raise ExceptionCalendarioNoEncontrado if calendario.nil?
    return JSON.pretty_generate(calendario.hash)
  end
  
  def obtener_calendarios()
    res = []
    calendarios.values.each do |c|
      res << c.hash
    end
    return JSON.pretty_generate(res)
  end
  
  def borrarCalendario(nombre)
    nombre_minusculas = nombre.downcase
    @calendarios.delete(nombre_minusculas)
  end
  
end
