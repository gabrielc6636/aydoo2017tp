require_relative './exceptioncalendarioexistente'

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
  
  def escribir_en_archivo()
    gestorArchivo = GestorArchivos.new
    gestorArchivo.escribir(@calendarios.values, "calendarios.json")
  end
  
end
