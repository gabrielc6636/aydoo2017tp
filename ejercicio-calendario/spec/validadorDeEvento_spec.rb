require 'rspec'
require_relative '../model/validadorDeEvento.rb'
require_relative '../model/evento.rb'

describe 'validadorDeEvento' do

  let (:validador) {ValidadorDeEvento.new}
  let (:calendario) {calendario = Calendario.new("Un calendario")}
  let (:evento) {Evento.new(calendario,"id_evento", "nombre_evento", "2017-03-31T18:00:00-03:00", "2017-03-31T20:00:00-03:00")}    

  before(:each) {
  	Evento.class_variable_set :@@eventos, {}
  	Calendario.class_variable_set :@@calendarios, {}
  }

  it "validar_evento_sin_terminar para evento no finalizado deberia devolver excepcion" do
	evento.stub(:esta_finalizado?) { false }

    expect{validador.validar_evento_sin_terminar(evento)}.to raise_error(StandardError)
  end  

  it "validar_evento_sin_terminar para evento finalizado no deberia devolver excepcion" do
	evento.stub(:esta_finalizado?) { true }

    expect{validador.validar_evento_sin_terminar(evento)}.not_to raise_error
  end

  it "validar_evento_finalizado para evento finalizado deberia devolver excepcion" do
	evento.stub(:esta_finalizado?) { true }

    expect{validador.validar_evento_finalizado(evento)}.to raise_error(StandardError)
  end

  it "validar_evento_finalizado para evento no finalizado no deberia devolver excepcion" do
	evento.stub(:esta_finalizado?) { false }

    expect{validador.validar_evento_finalizado(evento)}.not_to raise_error
  end

  it "validar_evento_inExistente para evento que no esta en el master de eventos deberia devolver excepcion" do	  	

    expect{validador.validar_evento_inExistente("id_evento")}.to raise_error(NameError)
  end

  it "validar_evento_inExistente para evento que esta en el master de eventos no deberia devolver excepcion" do
  	Evento.eventos[evento.id] = evento	  	

    expect{validador.validar_evento_inExistente("id_evento")}.not_to raise_error
  end

end