require 'rspec' 
require_relative '../model/gestor_calendarios'

describe 'GestorCalendarios' do
  
  let(:gestor) { GestorCalendarios.new }

  it 'es posible agregar un calendario al gestor' do
    gestor.restablecer
    nombre = "Un calendario"
    gestor.agregar_calendario(nombre)
    expect(gestor.calendarios[nombre.downcase].nombre).to eq nombre
  end
  
  it 'es posible borrar un calendario existente' do
    gestor.restablecer
    nombre = "Un calendario"
    gestor.agregar_calendario(nombre)
    gestor.borrar_calendario(nombre)
    expect(gestor.calendarios.size).to eq 0
  end
  
  it 'es posible agregar mas de un calendario al gestor' do
    gestor.restablecer
    un_nombre = "Un calendario"
    otro_nombre = "Otro calendario"
    gestor.agregar_calendario(un_nombre)
    gestor.agregar_calendario(otro_nombre)
    expect(gestor.calendarios.size).to eq 2
  end
  
  it 'no es posible agregar dos calendarios con el mismo nombre' do
    gestor.restablecer
    nombre = "Un calendario"
    gestor.agregar_calendario(nombre)
    expect{gestor.agregar_calendario(nombre)}.to raise_error
  end
  
  it 'no es posible agregar dos calendarios variando mayusculas' do
    gestor.restablecer
    nombre = "Un calendario"
    nombre_variando_mayusculas = "uN CalenDario"
    gestor.agregar_calendario(nombre)
    expect{gestor.agregar_calendario(nombre_variando_mayusculas)}.to raise_error
  end
  
  it 'es posible obtener un calendario como JSON' do
    gestor.restablecer
    nombre = "Un calendario"
    gestor.agregar_calendario(nombre)
    salida =
    '{
  "nombre": "Un calendario"
}'
    expect(gestor.obtener_calendario(nombre)).to eq salida
  end
  
  it 'no es posible obtener un calendario que no existe' do
    gestor.restablecer
    expect{gestor.obtenerCalendario("A")}.to raise_error
  end
  
  it 'es posible obtener los calendarios como JSON' do
    gestor.restablecer
    un_nombre = "Un calendario"
    otro_nombre = "Otro calendario"
    gestor.agregar_calendario(un_nombre)
    gestor.agregar_calendario(otro_nombre)
    salida =
    '[
  {
    "nombre": "Un calendario"
  },
  {
    "nombre": "Otro calendario"
  }
]'
    expect(gestor.obtener_calendarios).to eq salida
  end
  
  it 'es posible leer un calendario de archivo' do
    gestor.restablecer
    nombre = "Un calendario"
    gestor.agregar_calendario(nombre)
    gestor.leer_de_archivo
    expect(gestor.calendarios[nombre.downcase].nombre).to eq nombre
  end
  
  it 'es posible escribir un calendario en archivo' do
    gestor.restablecer
    nombre = "Un calendario"
    gestor.agregar_calendario(nombre)
    gestor.escribir_en_archivo
    salida = File.open("calendarios.json", &:readline)
    esperado = '[
'
    expect(salida).to eq esperado
  end

end
