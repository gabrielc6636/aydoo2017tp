require_relative 'formateador_json.rb'

class GestorArchivos

  CARACTERES = 0
  ARCHIVO_RECURSOS = "recursos.json"
  ARCHIVO_EVENTOS = "eventos.json"
  ARCHIVO_CALENDARIOS = "calendarios.json"

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

  def guardarCalendarios(calendarios)
    arrayJson = FormateadorJson.formatear_coleccion(calendarios)
    escribir(arrayJson, ARCHIVO_CALENDARIOS)
  end

  def cargarCalendarios
    data = leer(ARCHIVO_CALENDARIOS)
    FormateadorJson.interpretar(data)
  end

  def guardarEventos(eventos)
    arrayJson = FormateadorJson.formatear_coleccion(eventos)
    escribir(arrayJson, ARCHIVO_EVENTOS)
  end

  def cargarEventos
    data = leer(ARCHIVO_EVENTOS)
    FormateadorJson.interpretar(data)
  end

  def guardarRecursos(recursos)
    arrayJson = FormateadorJson.formatear_coleccion(recursos)
    escribir(arrayJson, ARCHIVO_RECURSOS)
  end

  def cargarRecursos
    data = leer(ARCHIVO_RECURSOS)
    FormateadorJson.interpretar(data)
  end

end
