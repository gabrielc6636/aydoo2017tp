require_relative './exception_calendario_existente'
require_relative './exception_calendario_no_encontrado'
require_relative './gestor_archivos'
require_relative './calendario'
require 'json'

class GestorCalendarios
  attr_reader :calendarios
  
  def leer_de_archivo
    gestor_archivos = GestorArchivos.new
    restablecer
    lineas = gestor_archivos.leer("calendarios.json")
    texto = ""
    lineas.each do |l|
      texto << l
    end
    if texto != ""
      res = JSON.parse(texto)
      res.each do |r|
        agregar_calendario(r["nombre"])
      end
    end
  end
  
  def restablecer
    @calendarios = Hash.new
  end
  
  def initialize
    leer_de_archivo
  end
  
  def escribir_en_archivo
    gestor_archivos = GestorArchivos.new
    gestor_archivos.escribir(obtener_calendarios, "calendarios.json")
  end
  
  def agregar_calendario(nombre)
    nombre_minusculas = nombre.downcase
    raise ExceptionCalendarioExistente if @calendarios[nombre_minusculas]
    @calendarios[nombre_minusculas] = Calendario.new nombre
    escribir_en_archivo
  end
  
  def obtener_calendario(nombre)
    calendario = calendarios[nombre.downcase]
    raise ExceptionCalendarioNoEncontrado if calendario.nil?
    return JSON.pretty_generate(calendario.to_h)
  end
  
  def obtener_calendarios
    res = []
    calendarios.values.each do |c|
      res << c.to_h
    end
    return JSON.pretty_generate(res)
  end
  
  def borrar_calendario(nombre)
    nombre_minusculas = nombre.downcase
    raise ExceptionCalendarioNoEncontrado if @calendarios[nombre_minusculas].nil?
    @calendarios.delete(nombre_minusculas)
    escribir_en_archivo
  end
  
end
