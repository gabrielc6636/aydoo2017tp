require_relative '../model/repositorioRecursos.rb'
require_relative '../model/gestor_archivos.rb'
require_relative '../model/validadorDeRecurso.rb'
require_relative '../model/recurso.rb'

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

    expect(recurso.nil).to eq true
    
  end

end