require 'rspec'
require_relative '../model/gestor_archivos'

describe 'GestorArchivos' do

  it 'se escribe en archivo' do
    archivo = "prueba_escritura.txt"
    GestorArchivos.escribir("Prueba", archivo)
    salida = File.open(archivo, &:readline)
    expect(salida).to eq "Prueba\n"
    File.delete(archivo)
  end

  it 'se lee un archivo' do
    archivo = "prueba_lectura.txt"
    GestorArchivos.escribir("Prueba", archivo)
    lectura = GestorArchivos.leer(archivo)[0]
    expect(lectura).to eq "Prueba\n"
    File.delete(archivo)
  end

  it 'se intenta leer un archivo inexistente' do
    archivo = "no_deberia_existir.txt"
    lectura = GestorArchivos.leer(archivo)
    expect([]).to eq lectura
  end

end
