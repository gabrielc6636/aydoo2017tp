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
  
end
