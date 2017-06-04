require 'json'

class GestorArchivos
   
  def escribir(objetos, archivo)
    
    File.truncate(archivo, 0) if File.file?(archivo) 
    open(archivo, "a") do |f|
      objetos.each do |o|
        json = o.hash.to_json
        f.puts(json)
      end
    end
    
  end
  
end
