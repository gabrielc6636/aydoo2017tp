require 'json'

class FormateadorJson
   
  def self.formatear_objeto(objeto)
    return JSON.pretty_generate(objeto.to_h)
  end
  
  def self.formatear_coleccion(coleccion)
    res = []
    coleccion.each do |o|
      res << o.to_h
    end
    return JSON.pretty_generate(res)
  end
  
  def self.interpretar(lineas)
    texto = ""
    lineas.each do |l|
      texto << l
    end
    if texto != ""
      return JSON.parse(texto)
    end
    return []
  end
  
end
