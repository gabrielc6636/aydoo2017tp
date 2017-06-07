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
  
  it 'es posible obtener un evento del gestor' do
    id = "1"
    nombre = "Un evento"
    gestor.agregar_evento("Un calendario", id, nombre, "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00")
    salida = '{
  "calendario": "Un calendario",
  "id": "1",
  "nombre": "Un evento",
  "inicio": "2017-03-31T18:00:00-03:00",
  "fin": "2017-03-31T22:00:00-03:00"
}'
    expect(gestor.obtener_evento(id)).to eq salida
  end
  
end
