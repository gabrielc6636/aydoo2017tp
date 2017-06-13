require_relative './sumador_recurrencia_diaria'
require_relative './sumador_recurrencia_semanal'
require_relative './sumador_recurrencia_mensual'
require_relative './sumador_recurrencia_anual'

class Recurrencia
  attr_reader :frecuencia
  attr_reader :fin
  
  def initialize(frecuencia, fin)
    @frecuencia = frecuencia
    @fin = fin
  end
  
  def self.sumadores
    {"diaria" => SumadorRecurrenciaDiaria.new,
     "semanal" => SumadorRecurrenciaSemanal.new,
     "mensual" => SumadorRecurrenciaMensual.new,
     "anual" => SumadorRecurrenciaAnual.new
    }
  end
  
  def to_h
    return {"frecuencia" => @frecuencia,
            "fin" => @fin}
  end
    
end
