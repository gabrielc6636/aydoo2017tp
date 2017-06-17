require 'rspec' 
require_relative '../model/repositorioRecursos.rb'
require_relative '../model/recurso.rb'

describe 'RepositorioRecursos' do

  let(:repositorio) { RepositorioRecursos.new }  
   
  it 'agregarRecurso en repositorio vacio deberia devolver tamanio del lista igual a 1' do
    nuevoRecurso = Recurso.new("sala 1")

    repositorio.agregarRecurso(nuevoRecurso)

    expect(repositorio.recursos.size).to eq 1
  end

  it 'eliminar recurso deberia devolver tamanio de lista - 1 ' do
    recurso1 = Recurso.new("sala 1")
    recurso2 = Recurso.new("sala 2")

    repositorio.agregarRecurso(recurso1)
    repositorio.agregarRecurso(recurso2)
    tamanio = repositorio.recursos.size
    repositorio.eliminarRecurso(recurso1)

    expect(repositorio.recursos.size).to eq tamanio-1
  end

  it 'repositorio con recurso sala 1 deberia devolver true al preguntar estaRecurso?' do
    nuevoRecurso = Recurso.new("sala 1")

    repositorio.agregarRecurso(nuevoRecurso)

    expect(repositorio.estaRecurso? nuevoRecurso.nombre).to eq true
  end

  it 'repositorio sin recurso sala 1 deberia devolver false al preguntar estaRecurso?' do    
    expect(repositorio.estaRecurso? "Sala 1").to eq false
  end

  it 'obtenerRecurso en repositorio con recurso sala devuelve el recurso sala' do   
    nuevoRecurso = Recurso.new("sala 1")

    repositorio.agregarRecurso(nuevoRecurso)

    expect(repositorio.obtenerRecurso("sala 1")).to eq nuevoRecurso
  end
  
end