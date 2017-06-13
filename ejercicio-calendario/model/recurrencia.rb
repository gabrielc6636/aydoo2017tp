require_relative './sumador_recurrencia_semanal'

class Recurrencia
  attr_reader :frecuencia
  attr_reader :fin
  
  def initialize(frecuencia, fin)
    @frecuencia = frecuencia
    @fin = fin
  end
  
  def self.sumadores
    {"semanal" => SumadorRecurrenciaSemanal.new,
     "mensual" => SumadorRecurrenciaMensual.new}
  end
  
  def to_h
    return {"frecuencia" => @frecuencia,
            "fin" => @fin}
  end
    
end
