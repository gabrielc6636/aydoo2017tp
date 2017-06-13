require 'rspec' 
require_relative '../model/sumador_recurrencia_anual'

describe 'SumadorRecurrenciaAnual' do

  it 'es posible sumarle un anio a una fecha' do
    sumador = SumadorRecurrenciaAnual.new
    fecha_inicial = DateTime.new(2016,3,14,16,0,0)
    fecha_esperada = DateTime.new(2017,3,14,16,0,0)
    expect(sumador.sumar(fecha_inicial)).to eq fecha_esperada
  end
  
  it 'si el anio origen es bisiesto, el destino estara en el 28 de febrero' do
    sumador = SumadorRecurrenciaAnual.new
    fecha_inicial = DateTime.new(2016,2,29,13,0,0)
    fecha_esperada = DateTime.new(2017,2,28,13,0,0)
    expect(sumador.sumar(fecha_inicial)).to eq fecha_esperada
  end

end
