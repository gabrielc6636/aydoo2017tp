require 'rspec'
require_relative '../model/recurrencia'

describe 'Recurrencia' do

  it 'es posible asignarle una frecuencia a la recurrencia' do
    frecuencia = "semanal"
    recurrencia = Recurrencia.new frecuencia, "2017-03-31T22:00:00-03:00"
    expect(recurrencia.frecuencia).to eq frecuencia
  end

  it 'es posible asignarle un fin a la recurrencia' do
    fin = "2017-03-31T22:00:00-03:00"
    recurrencia = Recurrencia.new "semanal", fin
    expect(recurrencia.fin).to eq fin
  end

  it 'es posible obtener la recurrencia como hash' do
    recurrencia = Recurrencia.new "semanal", "2017-03-31T22:00:00-03:00"
    hash = {"frecuencia" => "semanal",
            "fin" => "2017-03-31T22:00:00-03:00"}
    expect(recurrencia.to_h).to eq hash
  end

end
