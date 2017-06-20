require_relative '../model/gestor_archivos.rb'
require_relative '../model/validadorDeRecurso.rb'
require_relative '../model/recurso.rb'
require_relative '../model/controladorRecursos.rb'
require 'json'

describe 'ControladorRecursos' do
  
  let(:controlador) { ControladorRecursos.new } 

  before do
    controlador.gestorArchivos.stub(:guardarRecursos) {"recursos guardados"}
  end
   
  it 'Si agrego un recurso, tengo que poder obtenerlo' do
    nombre = "Recursos 1"
    controlador.agregar_recurso(nombre)
    recurso = controlador.obtener_recurso(nombre)

    expect(recurso.nombre).to eq nombre.downcase
  end

  it 'Si agrego dos recursos, obtengo 2 recursos' do
    nombre = "Recursos 1"
    controlador.agregar_recurso(nombre)
    nombre = "Recuros 2"
    controlador.agregar_recurso(nombre)

    expect(controlador.obtener_recursos.size).to eq 2
  end

  it 'Si tengo un recurso, tengo que poder eliminarlo' do
    nombre = "Recuros 1"
    controlador.agregar_recurso(nombre)
    recurso = controlador.obtener_recurso(nombre)
    expect(recurso.nombre).to eq nombre.downcase
    controlador.eliminar_recurso(nombre.downcase)
    recurso = controlador.obtener_recurso(nombre)

    expect(recurso.nil?).to eq true
  end

end