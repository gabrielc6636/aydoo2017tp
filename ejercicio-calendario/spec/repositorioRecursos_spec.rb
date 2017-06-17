require 'rspec' 
require_relative '../model/repositorioRecursos.rb'
require_relative '../model/recurso.rb'

describe 'RepositorioRecursos' do

  let(:repositorio) { RepositorioRecursos.new }  
   
  it 'agregarRecurso en repositorio vacio deberia devolver tamanio del lista igual a 1' do
    nuevoRecurso = Recurso.new("sala 1", false)

    repositorio.agregarRecurso(nuevoRecurso)

    expect(repositorio.recursos.size).to eq 1
  end

  it 'eliminar recurso deberia devolver tamanio de lista - 1 ' do
    recurso1 = Recurso.new("sala 1", false)
    recurso2 = Recurso.new("sala 2", false)

    repositorio.agregarRecurso(recurso1)
    repositorio.agregarRecurso(recurso2)
    tamanio = repositorio.recursos.size
    repositorio.eliminarRecurso(recurso1)

    expect(repositorio.recursos.size).to eq tamanio-1
  end

  
end