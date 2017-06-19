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

  it "validarEventoSinTerminar para evento no finalizado deberia devolver excepcion" do
	evento.stub(:estaFinalizado?) { false }

    expect{validador.validarEventoSinTerminar(evento)}.to raise_error(StandardError)
  end  

  it "validarEventoSinTerminar para evento finalizado no deberia devolver excepcion" do
	evento.stub(:estaFinalizado?) { true }

    expect{validador.validarEventoSinTerminar(evento)}.not_to raise_error
  end

  it "validarEventoFinalizado para evento finalizado deberia devolver excepcion" do
	evento.stub(:estaFinalizado?) { true }

    expect{validador.validarEventoFinalizado(evento)}.to raise_error(StandardError)
  end

  it "validarEventoFinalizado para evento no finalizado no deberia devolver excepcion" do
	evento.stub(:estaFinalizado?) { false }

    expect{validador.validarEventoFinalizado(evento)}.not_to raise_error
  end

  it "validarEventoInExistente para evento que no esta en el master de eventos deberia devolver excepcion" do	  	

    expect{validador.validarEventoInExistente("id_evento")}.to raise_error(NameError)
  end

  it "validarEventoInExistente para evento que esta en el master de eventos no deberia devolver excepcion" do
  	Evento.eventos[evento.id] = evento	  	

    expect{validador.validarEventoInExistente("id_evento")}.not_to raise_error
  end

end