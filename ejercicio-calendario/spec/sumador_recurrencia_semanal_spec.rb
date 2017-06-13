require 'rspec' 
require_relative '../model/sumador_recurrencia_semanal'

describe 'SumadorRecurrenciaSemanal' do

  it 'es posible sumarle una semana a una fecha' do
    sumador = SumadorRecurrenciaSemanal.new
    fecha_inicial = DateTime.new(2017,2,26,13,0,0)
    fecha_esperada = DateTime.new(2017,3,5,13,0,0)
    expect(sumador.sumar(fecha_inicial)).to eq fecha_esperada
  end

end
