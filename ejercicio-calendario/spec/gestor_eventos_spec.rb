require 'rspec' 
require_relative '../model/gestor_eventos'

describe 'GestorEventos' do
  
  let(:gestor) { GestorEventos.new }

  it 'es posible agregar un evento al gestor' do
    id = "1"
    nombre = "Un evento"
    gestor.agregar_evento("Un calendario", id, nombre, "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00")
    expect(gestor.eventos[id].nombre).to eq nombre
  end
  
end
