require 'rspec'
require_relative '../model/calendario'
require_relative '../model/evento'

describe 'Calendario' do

  before(:each) {Calendario.class_variable_set :@@calendarios, {}
  Evento.class_variable_set :@@eventos, {}}

  it 'es posible asignar un nombre a un calendario' do
    calendario = Calendario.new("Un calendario")
    expect(calendario.nombre).to eq "Un calendario"
  end

  it 'el calendario se crea sin eventos' do
    calendario = Calendario.new("Un calendario")
    expect(calendario.eventos.size).to eq 0
  end

  it 'es posible eliminar los eventos de un calendario' do
    calendario = Calendario.new("Un calendario")
    Evento.new(calendario, "1", "Un evento", "2017-03-31T18:00:00-03:00",
               "2017-03-31T22:00:00-03:00")
    calendario.eliminar_eventos
    expect(Evento.eventos.size).to eq 0
  end

  it 'no es posible crear dos eventos superpuestos' do
    calendario = Calendario.new("Un calendario")
    Evento.new(calendario, "1", "Un evento", "2017-03-31T16:00:00-03:00",
               "2017-03-31T17:30:00-03:00")
    expect {Evento.new(calendario, "2", "Otro evento",
                       "2017-03-31T17:00:00-03:00", "2017-03-31T18:00:00-03:00"
    )}.to raise_error(ExceptionEventoSuperpuesto)
  end

  it 'no es posible crear dos eventos con el mismo nombre' do
    calendario = Calendario.new("Un calendario")
    Evento.new(calendario, "1", "Un evento", "2017-03-31T16:00:00-03:00",
               "2017-03-31T17:30:00-03:00")
    expect {Evento.new(calendario, "2", "Un evento",
                       "2017-04-30T17:00:00-03:00", "2017-04-30T18:00:00-03:00"
    )}.to raise_error(ExceptionEventoRepetido)
  end

  it 'es posible crear varios calendarios a partir de una lista de hashes' do
    hashes = [{"nombre" => "Un calendario"}, {"nombre" => "Otro calendario"}]
    Calendario.crear_desde_lista(hashes)
    expect(Calendario.calendarios.size).to eq 2
  end

  it 'al crearse, el calendario se asigna a la coleccion' do
    nombre = "Un calendario"
    calendario = Calendario.new(nombre)
    expect(Calendario.calendarios[nombre.downcase]).to eq calendario
  end

  it 'es posible obtener el calendario como hash' do
    calendario = Calendario.new("Un calendario")
    hash = {"nombre" => "Un calendario"}
    expect(calendario.to_h).to eq hash
  end

  it 'no es posible agregar un calendario sin nombre' do
    expect {Calendario.new("")}.to raise_error(ExceptionCalendarioSinNombre)
  end

  it 'no es posible agregar un calendario con nombre repetido' do
    nombre = "Un calendario"
    calendario = Calendario.new(nombre)
    expect {Calendario.new(nombre)}
        .to raise_error(ExceptionCalendarioExistente)
  end

  it 'no es posible agregar un calendario variando mayusculas' do
    calendario = Calendario.new("Un calendario")
    expect {Calendario.new("uN cAlEndArIO")}
        .to raise_error(ExceptionCalendarioExistente)
  end

end
