require 'rspec'
require_relative '../model/formateador_json'

describe 'FormateadorJson' do

  before(:each) {Calendario.class_variable_set :@@calendarios, {}}

  it 'es posible formatear un calendario' do
    nombre = "Un calendario"
    calendario = Calendario.new(nombre)
    salida = '{
  "nombre": "Un calendario"
}'
    expect(FormateadorJson.formatear_objeto(calendario)).to eq salida
  end

  it 'es posible formatear varios calendarios' do
    nombre = "Un calendario"
    otro_nombre = "Otro calendario"
    calendario = Calendario.new(nombre)
    otro_calendario = Calendario.new(otro_nombre)
    calendarios = [calendario, otro_calendario]
    salida = '[
  {
    "nombre": "Un calendario"
  },
  {
    "nombre": "Otro calendario"
  }
]'
    expect(FormateadorJson.formatear_coleccion(calendarios)).to eq salida
  end

  it 'es posible interpretar una entrada' do
    entrada = ['[', '  {', '    "a": "b"', '  }', ']']
    interpretado = FormateadorJson.interpretar(entrada)
    expect(interpretado[0]['a']).to eq "b"
  end

end
