require 'rspec'
require_relative '../model/validadorDeRecurso.rb'
require_relative '../model/recurso.rb'
require_relative '../model/repositorioRecursos.rb'

describe 'ValidadorDeRecurso' do

	let (:validador) {ValidadorDeRecurso.new}
	let (:repositorio) {RepositorioRecursos.new}
	let (:recurso) {Recurso.new("id_evento")}

	it "validar recurso inexistente deberia devolver excepcion NameError si el recurso buscado no esta el repositorio" do
		repositorio.stub(:estaRecurso?).with('id_evento') { false }

    	expect{validador.validarRecursoInExistente("id_evento",repositorio)}.to raise_error(NameError)
  	end

  	it "validar recurso inexistente no deberia devolver excepcion NameError si el recurso buscado esta el repositorio" do
		repositorio.stub(:estaRecurso?).with('id_evento') { true }

    	expect{validador.validarRecursoInExistente("id_evento",repositorio)}.not_to raise_error
  	end

  	it "validar recurso existente deberia devolver excepcion NameError si el recurso a agregar ya esta en el repositorio" do
		repositorio.stub(:estaRecurso?).with('id_evento') { true }

    	expect{validador.validarRecursoExistente("id_evento",repositorio)}.to raise_error(NameError)
  	end

end