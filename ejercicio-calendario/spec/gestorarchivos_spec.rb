require 'rspec' 
require_relative '../model/gestorarchivos'

describe 'GestorArchivo' do
  
  let(:gestor) { GestorArchivos.new }

  it 'se escribe en archivo' do
    archivo = "prueba_escritura.txt"
    gestor.escribir("Prueba", archivo)
    salida = File.open(archivo, &:readline)
    expect(salida).to eq "Prueba\n"
  end
  
  it 'se lee un archivo' do
    archivo = "prueba_lectura.txt"
    gestor.escribir("Prueba", archivo)
    lectura = gestor.leer(archivo)[0]
    expect(lectura).to eq "Prueba\n"
  end
  
  it 'se intenta leer un archivo inexistente' do
    archivo = "no_deberia_existir.txt"
    lectura = gestor.leer(archivo)
    expect([]).to eq lectura
  end

end
