require_relative './exceptioncalendarioexistente'
require 'json'

class GestorCalendario
  
  attr_reader :calendarios
  
  def initialize()
    @calendarios = Hash.new
  end
  
  def agregarCalendario(calendario)
    
    nombre_minusculas = calendario.nombre.downcase
    raise ExceptionCalendarioExistente if @calendarios[nombre_minusculas]
    @calendarios[nombre_minusculas] = calendario
    
  end
  
  def obtener_calendarios()
    res = []
    calendarios.values.each do |c|
      res << c.hash
    end
    return JSON.pretty_generate(res)
  end
  
  def escribir_en_archivo()
    gestorArchivo = GestorArchivos.new
    gestorArchivo.escribir(obtener_calendarios, "calendarios.json")
  end
  
  def borrarCalendario(nombre)
    nombre_minusculas = nombre.downcase
    @calendarios.delete(nombre_minusculas)
  end
  
end
