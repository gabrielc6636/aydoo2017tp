require 'rspec' 
require_relative '../model/calendario'

describe 'Calendario' do

  it 'es posible asignar un nombre a un calendario' do
    calendario = Calendario.new "Un calendario"
    expect(calendario.nombre).to eq "Un calendario"
  end
  
  it 'es posible obtener el calendario como hash' do
    calendario = Calendario.new "Un calendario"
    hash = {"nombre" => "Un calendario",}
    expect(calendario.hash).to eq hash
  end
  
  it 'no es posible agregar un calendario sin nombre' do
    expect{Calendario.new ""}.to raise_error
  end

end
