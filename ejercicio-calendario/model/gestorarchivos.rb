class GestorArchivos
   
  def escribir(texto, archivo)
    
    File.truncate(archivo, 0) if File.file?(archivo) 
    open(archivo, "a") do |f|
      f.puts(texto)
    end
    
  end
  
  def leer(archivo)
    
    lineas = []
    if File.file?(archivo)
      f = open(archivo).each do |l| 
        lineas << l
      end
    end
    return lineas
    
  end
  
end
