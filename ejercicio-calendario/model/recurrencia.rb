class Recurrencia
  attr_reader :frecuencia
  attr_reader :fin
  
  def initialize(frecuencia, fin)
    @frecuencia = frecuencia
    @fin = fin
  end
  
  def to_h
    return {"frecuencia" => @frecuencia,
            "fin" => @fin}
  end
    
end
