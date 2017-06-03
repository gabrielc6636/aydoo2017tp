require 'rspec' 
require_relative '../model/calendario'

describe 'Calendario' do

  let(:calendario) { Calendario.new }  

  it 'es posible asignar un nombre' do
    calendario.nombre = "Un calendario"
    expect(calendario.nombre).to eq "Un calendario"
  end
  
=begin
  it 'es posible asignar un nombre a un calendario' do
    Calendario.new "Un calendario"
    expect(calendario.nombre).to eq "Un calendario"
  end
=end

end

