require 'rspec' 
require_relative '../model/calendario'

describe 'Calendario' do

  it 'es posible asignar un nombre a un calendario' do
    calendario = Calendario.new "Un calendario"
    expect(calendario.nombre).to eq "Un calendario"
  end

end
