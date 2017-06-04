class Calendario
  
  attr_reader :nombre
  
  def initialize(nombre)
    @nombre = nombre
  end
  
  def hash()
    return {"nombre" => @nombre}
  end
    
end
