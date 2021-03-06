require 'rspec'
require_relative '../model/recurso.rb'

describe 'Recurso' do

	let (:recurso) {Recurso.new("id_recurso")}

	it "recurso recien creado deberia esta disponible para su uso" do
		expect(recurso.esta_en_uso?).to eq false
	end

	it "Reservar el recurso deberia dejarlo en estado en uso " do
		recurso.reservar()

		expect(recurso.esta_en_uso?).to eq true
	end

	it "Liberar el recurso deberia dejarlo en estado sin uso " do
		recurso.liberar()

		expect(recurso.esta_en_uso?).to eq false
	end

end