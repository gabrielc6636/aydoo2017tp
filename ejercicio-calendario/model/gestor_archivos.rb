class GestorArchivos

  CARACTERES = 0
  ARCHIVO_RECURSOS = "recursos.json"

  def escribir(texto, archivo)
    File.truncate(archivo, CARACTERES) if File.file?(archivo)
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

  def guardarRecursos(dato)
    escribir(dato, ARCHIVO_RECURSOS)
  end

  def cargarRecursos
    leer(ARCHIVO_RECURSOS)
  end

end
