require_relative '../model/repositorioRecursos.rb'
require_relative '../model/gestor_archivos.rb'
require_relative '../model/validadorDeRecurso.rb'
require_relative '../model/recurso.rb'
require_relative '../model/controladorRecursos.rb'
require 'json'

describe 'ControladorRecursos' do

  let(:repositorio) { RepositorioRecursos.new }  
  let(:controlador) { ControladorRecursos.new } 
   
  it 'Si agrego un recurso, tengo que poder obtenerlo' do
    
  	nombre = "Recursos 1"

    controlador.agregarRecurso(nombre)

    recurso = controlador.obtenerRecurso(nombre)

    expect(recurso.nombre).to eq nombre.downcase
  end

  it 'Si agrego dos recursos, obtengo 2 recursos' do
    
  	nombre = "Recursos 1"

    controlador.agregarRecurso(nombre)

    nombre = "Recuros 2"

    controlador.agregarRecurso(nombre)

    expect(controlador.obtenerRecursos.size).to eq 2
  end

  it 'Si tengo un recurso, tengo que poder eliminarlo' do
    
  	nombre = "Recuros 1"

    controlador.agregarRecurso(nombre)

	  recurso = controlador.obtenerRecurso(nombre)

    expect(recurso.nombre).to eq nombre.downcase

    controlador.eliminarRecurso(nombre.downcase)

    recurso = controlador.obtenerRecurso(nombre)

    expect(recurso.nil?).to eq true
    
  end

  it 'Si cargo 1 recurso, obtengo 1 recurso' do
    
	  json = JSON.parse '[{"nombre":"Proyector","enUso":"false"}]'

	  controlador.cargarRecursos(json)

    expect(controlador.obtenerRecursos.size).to eq 1
  end

end