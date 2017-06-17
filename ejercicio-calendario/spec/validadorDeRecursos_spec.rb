require 'rspec'
require_relative '../model/validadorDeRecurso.rb'
require_relative '../model/recurso.rb'
require_relative '../model/repositorioRecursos.rb'

describe 'ValidadorDeRecurso' do

	let (:validador) {ValidadorDeRecurso.new}
	let (:repositorio) {RepositorioRecursos.new}
	let (:recurso) {Recurso.new("id_recurso")}

	it "validar recurso inexistente deberia devolver excepcion NameError si el recurso buscado no esta el repositorio" do
		repositorio.stub(:estaRecurso?).with('id_recurso') { false }

    	expect{validador.validarRecursoInExistente("id_recurso",repositorio)}.to raise_error(NameError)
  	end

  	it "validar recurso inexistente no deberia devolver excepcion NameError si el recurso buscado esta el repositorio" do
		repositorio.stub(:estaRecurso?).with('id_recurso') { true }

    	expect{validador.validarRecursoInExistente("id_recurso",repositorio)}.not_to raise_error
  	end

  	it "validar recurso existente deberia devolver excepcion NameError si el recurso a agregar ya esta en el repositorio" do
		repositorio.stub(:estaRecurso?).with('id_recurso') { true }

    	expect{validador.validarRecursoExistente("id_recurso",repositorio)}.to raise_error(NameError)
  	end

  	it "validar recurso existente no deberia devolver excepcion NameError si el recurso a agregar no esta en el repositorio" do
		repositorio.stub(:estaRecurso?).with('id_recurso') { false }

    	expect{validador.validarRecursoExistente("id_recurso",repositorio)}.not_to raise_error
  	end

  	it "validarRecursoSinUso deberia devolver NameError si el recurso ya fue reservado por otro evento" do  		
  		repositorio.stub(:estaRecurso?).with('id_recurso') { true }
  		repositorio.stub(:obtenerRecurso).with('id_recurso') { recurso }
  		recurso.stub(:estaEnUso?) { true }

  		expect{validador.validarRecursoSinUso("id_recurso",repositorio)}.to raise_error
  	end

  	it "validarRecursoSinUso no deberia devolver NameError si el recurso no esta siendo usado" do  	
  		repositorio.stub(:estaRecurso?).with('id_recurso') { true }
  		repositorio.stub(:obtenerRecurso).with('id_recurso') { recurso }
  		recurso.stub(:estaEnUso?) { false }

  		expect{validador.validarRecursoSinUso("id_recurso",repositorio)}.not_to raise_error
  	end

end