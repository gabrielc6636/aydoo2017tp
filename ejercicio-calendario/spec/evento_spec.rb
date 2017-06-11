require 'rspec' 
require_relative '../model/evento'

describe 'Evento' do
  
  before(:each) { Evento.class_variable_set :@@eventos, Hash.new
                  Calendario.class_variable_set :@@calendarios, Hash.new}
  
  it 'no es posible agregar un evento sin id' do
    expect{Evento.new "A", "", "B", "C", "D"}.to raise_error(ExceptionEventoSinId)
  end
  
  it 'no es posible crear un evento con fin anterior al inicio' do
    calendario = Calendario.new "Un calendario"
    expect{Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T17:00:00-03:00"}.to raise_error(ExceptionDuracionInvalida)
  end
  
  it 'no es posible crear un evento de mas de 72 horas' do
    calendario = Calendario.new "Un calendario"
    expect{Evento.new calendario, "1", "Un evento", "2017-03-28T17:00:00-03:00", "2017-03-31T18:00:00-03:00"}.to raise_error(ExceptionDuracionInvalida)
  end
  
  it 'es posible guardar un evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(Evento.eventos["1"]).to eq evento
  end
  
  it 'es posible asignarle un calendario al evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.calendario).to eq calendario
  end
  
  it 'es posible asignarle un id al evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.id).to eq "1"
  end

  it 'es posible asignarle un nombre al evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.nombre).to eq "Un evento"
  end
  
  it 'es posible asignarle un inicio al evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.inicio).to eq "2017-03-31T18:00:00-03:00"
  end
  
  it 'es posible asignarle un fin al evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.fin).to eq "2017-03-31T22:00:00-03:00"
  end
  
  it 'es posible asignarle una recurrencia al evento' do
    recurrencia = Recurrencia.new "7", "2017-04-30T22:00:00-03:00"
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00", recurrencia
    expect(evento.recurrencia).to eq recurrencia
  end
  
  it 'al asignar una recurrencia se generan eventos recurrentes' do
    recurrencia = Recurrencia.new "7", "2017-04-30T22:00:00-03:00"
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00", recurrencia
    expect(evento.eventos_recurrentes.size).to eq 4
  end
  
  it 'es posible crear un evento sin recurrencia' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.recurrencia).to eq nil
  end
  
  it 'no es posible agregar un evento con id repetido' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect{Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"}.to raise_error(ExceptionEventoExistente)
  end
  
  it 'es posible crear varios eventos a partir de una lista de hashes' do
    calendario = Calendario.new "Un calendario"
    hashes = [{"calendario" => "Un calendario", "id" => "1", "nombre" => "Un evento", "inicio" => "2017-03-31T18:00:00-03:00", "fin" => "2017-03-31T22:00:00-03:00"},
              {"calendario" => "Un calendario", "id" => "2", "nombre" => "Otro evento", "inicio" => "2017-04-30T18:00:00-03:00", "fin" => "2017-04-30T22:00:00-03:00"}]
    Evento.batch(hashes)
    expect(Evento.eventos.size).to eq 2
  end
  
  it 'es posible actualizar la fecha de inicio de un evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    evento.actualizar("2017-04-31T18:00:00-03:00", "2017-04-31T22:00:00-03:00")
    expect(evento.inicio).to eq "2017-04-31T18:00:00-03:00"
  end
                     
  it 'es posible actualizar la fecha de fin de un evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    evento.actualizar("2017-04-31T18:00:00-03:00", "2017-04-31T22:00:00-03:00")
    expect(evento.fin).to eq "2017-04-31T22:00:00-03:00"
  end
  
  it 'es posible obtener el evento como hash' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    hash = {"calendario" => "Un calendario",
            "id" => "1",
            "nombre" => "Un evento",
            "inicio" => "2017-03-31T18:00:00-03:00",
            "fin" => "2017-03-31T22:00:00-03:00"}
    expect(evento.to_h).to eq hash
  end

end
