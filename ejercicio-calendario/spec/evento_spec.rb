require 'rspec' 
require_relative '../model/evento'

describe 'Evento' do
  
  it 'es posible guardar un evento' do
    evento = Evento.new "Un calendario", "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(Evento.eventos["1"].nombre).to eq "Un evento"
  end
  
  it 'es posible asignarle un calendario al evento' do
    evento = Evento.new "Un calendario", "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.calendario).to eq "Un calendario"
  end
  
  it 'es posible asignarle un id al evento' do
    evento = Evento.new "Un calendario", "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.id).to eq "1"
  end

  it 'es posible asignarle un nombre al evento' do
    evento = Evento.new "Un calendario", "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.nombre).to eq "Un evento"
  end
  
  it 'es posible asignarle un inicio al evento' do
    evento = Evento.new "Un calendario", "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.inicio).to eq "2017-03-31T18:00:00-03:00"
  end
  
  it 'es posible asignarle un fin al evento' do
    evento = Evento.new "Un calendario", "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.fin).to eq "2017-03-31T22:00:00-03:00"
  end
  
  it 'es posible crear varios eventos a partir de una lista de hashes' do
    hashes = [{"calendario" => "Un calendario", "id" => "1", "nombre" => "Un evento", "inicio" => "2017-03-31T18:00:00-03:00", "fin" => "2017-03-31T22:00:00-03:00"},
              {"calendario" => "Un calendario", "id" => "2", "nombre" => "Otro evento", "inicio" => "2017-04-31T18:00:00-03:00", "fin" => "2017-04-31T22:00:00-03:00"}]
    Evento.batch(hashes)
    expect(Evento.eventos.size).to eq 2
  end
  
  it 'es posible obtener el evento como hash' do
    evento = Evento.new "Un calendario", "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    hash = {"calendario" => "Un calendario",
            "id" => "1",
            "nombre" => "Un evento",
            "inicio" => "2017-03-31T18:00:00-03:00",
            "fin" => "2017-03-31T22:00:00-03:00"}
    expect(evento.to_h).to eq hash
  end

end
