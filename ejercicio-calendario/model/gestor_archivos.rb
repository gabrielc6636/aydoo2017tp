class GestorArchivos

  CARACTERES = 0

  def self.escribir(texto, archivo)
    File.truncate(archivo, CARACTERES) if File.file?(archivo)
    open(archivo, "a") do |f|
      f.puts(texto)
    end
  end

  def self.leer(archivo)
    lineas = []
    if File.file?(archivo)
      f = open(archivo).each do |l|
        lineas << l
      end
    end
    return lineas
  end

end
