class Evento
  attr_reader :calendario
  attr_reader :id
  attr_reader :nombre
  attr_reader :inicio
  attr_reader :fin
  
  def initialize(calendario, id, nombre, inicio, fin)
    @calendario = calendario
    @id = id
    @nombre = nombre
    @inicio = inicio
    @fin = fin
  end
  
  def hash()
    return {"calendario" => @calendario,
            "id" => @id,
            "nombre" => @nombre,
            "inicio" => @inicio,
            "fin" => @fin}
  end
    
end
