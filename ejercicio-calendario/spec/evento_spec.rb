require 'rspec'
require_relative '../model/evento'

describe 'Evento' do

  before(:each) {Evento.class_variable_set :@@eventos, {}
  Calendario.class_variable_set :@@calendarios, {}}

  it 'no es posible agregar un evento sin id' do
    expect {Evento.new "A", "", "B", "C", "D"}.to raise_error(ExceptionEventoSinId)
  end

  it 'no es posible crear un evento con fin anterior al inicio' do
    calendario = Calendario.new "Un calendario"
    expect {Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T17:00:00-03:00"}.to raise_error(ExceptionDuracionInvalida)
  end

  it 'no es posible crear un evento de mas de 72 horas' do
    calendario = Calendario.new "Un calendario"
    expect {Evento.new calendario, "1", "Un evento", "2017-03-28T17:00:00-03:00", "2017-03-31T18:00:00-03:00"}.to raise_error(ExceptionDuracionInvalida)
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
    recurrencia = Recurrencia.new "semanal", "2017-04-30T22:00:00-03:00"
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00", recurrencia
    expect(evento.recurrencia).to eq recurrencia
  end

  it 'al asignar una recurrencia se generan eventos recurrentes' do
    recurrencia = Recurrencia.new "semanal", "2017-04-30T22:00:00-03:00"
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00", recurrencia
    expect(evento.eventos_recurrentes.size).to eq 4
  end

  it 'es posible eliminar los eventos recurrentes' do
    recurrencia = Recurrencia.new "semanal", "2017-04-30T22:00:00-03:00"
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00", recurrencia
    evento.eliminar_eventos_recurrentes
    expect(Evento.eventos.size).to eq 1
  end

  it 'es posible crear un evento sin recurrencia' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect(evento.recurrencia).to eq nil
  end

  it 'no es posible agregar un evento con id repetido' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect {Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"}.to raise_error(ExceptionEventoExistente)
  end

  it 'es posible crear varios eventos a partir de una lista de hashes' do
    calendario = Calendario.new "Un calendario"
    hashes = [{"calendario" => "Un calendario", "id" => "1", "nombre" => "Un evento", "inicio" => "2017-03-31T18:00:00-03:00", "fin" => "2017-03-31T22:00:00-03:00"},
              {"calendario" => "Un calendario", "id" => "2", "nombre" => "Otro evento", "inicio" => "2017-04-30T18:00:00-03:00", "fin" => "2017-04-30T22:00:00-03:00"}]
    Evento.batch(hashes)
    expect(Evento.eventos.size).to eq 2
  end

  it 'al crear eventos por batch los recurrentes se generan a partir del original' do
    recurrencia = {"frecuencia" => "semanal", "fin" => "2017-04-10T22:00:00-03:00"}
    calendario = Calendario.new "Un calendario"
    hashes = [{"calendario" => "Un calendario", "id" => "1", "nombre" => "Un evento", "inicio" => "2017-03-31T18:00:00-03:00", "fin" => "2017-03-31T22:00:00-03:00", "recurrencia" => recurrencia},
              {"calendario" => "Un calendario", "id" => "1R#1", "nombre" => "Un evento #1", "inicio" => "2017-04-07T18:00:00-03:00", "fin" => "2017-04-07T22:00:00-03:00"}]
    Evento.batch(hashes)
    expect(Evento.eventos['1'].eventos_recurrentes.size).to eq 1
  end

  it 'es posible actualizar la fecha de inicio de un evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    evento.actualizar("2017-04-30T18:00:00-03:00", "2017-04-30T22:00:00-03:00")
    expect(evento.inicio).to eq "2017-04-30T18:00:00-03:00"
  end

  it 'al actualizar la fecha de inicio, la de fin se mantiene' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    evento.actualizar("2017-03-31T19:00:00-03:00", nil)
    expect(evento.fin).to eq "2017-03-31T22:00:00-03:00"
  end

  it 'es posible actualizar la fecha de fin de un evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    evento.actualizar("2017-04-30T18:00:00-03:00", "2017-04-30T22:00:00-03:00")
    expect(evento.fin).to eq "2017-04-30T22:00:00-03:00"
  end

  it 'al actualizar la fecha de inicio, la de fin se mantiene' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    evento.actualizar(nil, "2017-03-31T19:00:00-03:00")
    expect(evento.inicio).to eq "2017-03-31T18:00:00-03:00"
  end

  it 'al actualizar un evento con recurrencia, los eventos recurrentes se actualizan' do
    recurrencia = Recurrencia.new "semanal", "2017-04-30T22:00:00-03:00"
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00", recurrencia
    evento.actualizar("2017-03-31T17:00:00-03:00", nil)
    expect(evento.eventos_recurrentes['1R#1'].inicio).to eq "2017-04-07T17:00:00-03:00"
  end

  it 'se comprueba la duracion nueva al actualizar un evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    expect {evento.actualizar("2017-04-30T18:00:00-03:00", "2017-05-31T22:00:00-03:00")}.to raise_error(ExceptionDuracionInvalida)
  end

  it 'se comprueba la superposicion al actualizar un evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    Evento.new calendario, "2", "Otro evento", "2017-04-30T18:00:00-03:00", "2017-04-30T22:00:00-03:00"
    expect {evento.actualizar("2017-04-30T17:00:00-03:00", "2017-04-30T19:00:00-03:00")}.to raise_error(ExceptionEventoSuperpuesto)
  end
  
  it 'no es posible crear un evento superpuesto con uno recurrente' do
    recurrencia = Recurrencia.new "semanal", "2017-04-30T22:00:00-03:00"
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00", recurrencia
    expect{Evento.new calendario, "2", "Otro evento", "2017-04-07T17:00:00-03:00", "2017-04-07T19:00:00-03:00"}.to raise_error(ExceptionEventoSuperpuesto)
  end
  
  it 'no es posible crear un evento recurrente superpuesto con uno comun' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-04-07T19:00:00-03:00", "2017-04-07T21:00:00-03:00"
    recurrencia = Recurrencia.new "semanal", "2017-04-30T22:00:00-03:00"
    expect{Evento.new calendario, "2", "Otro evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00", recurrencia}.to raise_error(ExceptionEventoSuperpuesto)
  end

  it 'es posible obtener un evento sin recurrencia como hash' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    hash = {"calendario" => "Un calendario",
            "id" => "1",
            "nombre" => "Un evento",
            "inicio" => "2017-03-31T18:00:00-03:00",
            "fin" => "2017-03-31T22:00:00-03:00"}
    expect(evento.to_h).to eq hash
  end

  it 'es posible obtener un evento con recurrencia como hash' do
    recurrencia = Recurrencia.new "semanal", "2017-04-30T22:00:00-03:00"
    calendario = Calendario.new "Un calendario"
    evento = Evento.new calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00", recurrencia
    recurrencia_hash = {"frecuencia" => "semanal", "fin" => "2017-04-30T22:00:00-03:00"}
    hash = {"calendario" => "Un calendario",
            "id" => "1",
            "nombre" => "Un evento",
            "inicio" => "2017-03-31T18:00:00-03:00",
            "fin" => "2017-03-31T22:00:00-03:00",
            "recurrencia" => recurrencia_hash}
    expect(evento.to_h).to eq hash
  end

end
