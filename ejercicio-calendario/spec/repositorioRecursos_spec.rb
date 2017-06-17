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

  
end