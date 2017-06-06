require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/gestorarchivos'

describe 'GestorArchivo' do
  
  let(:gestor) { GestorArchivos.new }

  it 'se escribe un calendario en archivo' do
    archivo = "pruebacalendarios.json"
    nombre = "Un calendario"
    calendario = Calendario.new nombre
    gestor.escribir([calendario], archivo)
    salida = JSON.parse(File.open(archivo, &:readline))
    expect(salida["nombre"]).to eq nombre
  end
  
  it 'se lee un archivo' do
    archivo = "pruebacalendarios.json"
    nombre = "Un calendario"
    calendario = Calendario.new nombre
    gestor.escribir([calendario], archivo)
    lectura = gestor.leer(archivo)[0]
    expect(lectura["nombre"]).to eq nombre
  end
  
  it 'se intenta leer un archivo inexistente' do
    archivo = "noexiste.json"
    lectura = gestor.leer(archivo)
    expect([]).to eq lectura
  end

end
