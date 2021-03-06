require 'rspec'
require_relative '../model/validadorDeRecurso.rb'
require_relative '../model/recurso.rb'
require_relative '../model/repositorioRecursos.rb'

describe 'ValidadorDeRecurso' do

	let (:validador) {ValidadorDeRecurso.new}
	let (:repositorio) {RepositorioRecursos.new}
	let (:recurso) {Recurso.new("id_recurso")}

	it "validar recurso inexistente deberia devolver excepcion NameError si el recurso buscado no esta el repositorio" do
		repositorio.stub(:esta_recurso?).with('id_recurso') { false }

    	expect{validador.validar_recurso_inExistente("id_recurso",repositorio)}.to raise_error(NameError)
  	end

  	it "validar recurso inexistente no deberia devolver excepcion NameError si el recurso buscado esta el repositorio" do
		repositorio.stub(:esta_recurso?).with('id_recurso') { true }

    	expect{validador.validar_recurso_inExistente("id_recurso",repositorio)}.not_to raise_error
  	end

  	it "validar recurso existente deberia devolver excepcion NameError si el recurso a agregar ya esta en el repositorio" do
		repositorio.stub(:esta_recurso?).with('id_recurso') { true }

    	expect{validador.validar_recurso_existente("id_recurso",repositorio)}.to raise_error(NameError)
  	end

  	it "validar recurso existente no deberia devolver excepcion NameError si el recurso a agregar no esta en el repositorio" do
		repositorio.stub(:esta_recurso?).with('id_recurso') { false }

    	expect{validador.validar_recurso_existente("id_recurso",repositorio)}.not_to raise_error
  	end

  	it "validar_recurso_sin_uso deberia devolver NameError si el recurso ya fue reservado por otro evento" do  		
  		repositorio.stub(:esta_recurso?).with('id_recurso') { true }
  		repositorio.stub(:obtener_recurso).with('id_recurso') { recurso }
  		recurso.stub(:esta_en_uso?) { true }

  		expect{validador.validar_recurso_sin_uso("id_recurso",repositorio)}.to raise_error
  	end

  	it "validar_recurso_sin_uso no deberia devolver NameError si el recurso no esta siendo usado" do  	
  		repositorio.stub(:esta_recurso?).with('id_recurso') { true }
  		repositorio.stub(:obtener_recurso).with('id_recurso') { recurso }
  		recurso.stub(:esta_en_uso?) { false }

  		expect{validador.validar_recurso_sin_uso("id_recurso",repositorio)}.not_to raise_error
  	end

end