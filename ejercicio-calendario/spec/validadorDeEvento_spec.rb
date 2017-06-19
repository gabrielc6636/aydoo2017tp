require 'rspec'
require_relative '../model/validadorDeEvento.rb'
require_relative '../model/evento.rb'

describe 'validadorDeEvento' do

  let (:validador) {ValidadorDeEvento.new}
  let (:calendario) {calendario = Calendario.new("Un calendario")}
  let (:evento) {Evento.new(calendario,"id_evento", "nombre_evento", "2017-03-31T18:00:00-03:00", "2017-03-31T20:00:00-03:00")}  

  it "validar evento finalzado para evento no finalizado deberia devolver excepcion" do
	evento.stub(:estaFinalizado?) { false }

    expect{validador.validarEventoSinTerminar(evento)}.to raise_error(NameError)
  end  

end