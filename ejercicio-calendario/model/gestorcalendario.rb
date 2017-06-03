class GestorCalendario
  
  attr_reader :calendarios
  
  def initialize()
    @calendarios = Hash.new
  end
  
  def agregarCalendario(calendario)
    @calendarios[calendario.nombre] = calendario
  end
  
end
