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
    
  	nombre = "Recuros 1"

    controlador.agregarRecurso(nombre)

    recurso = controlador.obtenerRecurso(nombre)

    expect(recurso.nombre).to eq nombre
  end

  it 'Si agrego dos recursos, obtengo 2 recursos' do
    
  	nombre = "Recuros 1"

    controlador.agregarRecurso(nombre)

    nombre = "Recuros 2"

    controlador.agregarRecurso(nombre)

    expect(controlador.obtenerRecursos.size).to eq 2
  end

  it 'Si tengo un recurso, tengo que poder eliminarlo' do
    
  	nombre = "Recuros 1"

    controlador.agregarRecurso(nombre)

	recurso = controlador.obtenerRecurso(nombre)

    expect(recurso.nombre).to eq nombre

    controlador.eliminarRecurso(nombre)

	recurso = controlador.obtenerRecurso(nombre)

	result = recurso.nil?

    expect(result).to eq true
    
  end

  it 'Si cargo 1 recurso, obtengo 1 recurso' do
    
	json = JSON.parse '[{"nombre":"Proyector","enUso":"false"}]'

	controlador.cargarRecursos(json)

    controlador.agregarRecurso(nombre)

    expect(controlador.obtenerRecursos.size).to eq 1
  end

end