require 'rspec'
require_relative '../model/sumador_recurrencia_diaria'

describe 'SumadorRecurrenciaDiaria' do

  it 'es posible sumarle un dia a una fecha' do
    sumador = SumadorRecurrenciaDiaria.new
    fecha_inicial = DateTime.new(2017, 5, 31, 15, 0, 0)
    fecha_esperada = DateTime.new(2017, 6, 1, 15, 0, 0)
    expect(sumador.sumar(fecha_inicial)).to eq fecha_esperada
  end

end
