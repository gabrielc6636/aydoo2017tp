require 'rspec'
require_relative '../model/recurso.rb'

describe 'Recurso' do

	let (:recurso) {Recurso.new("id_recurso")}

	it "recurso recien al preguntarle si esta esta siendo usado deberia devolver false" do
		expect(recurso.estaEnUso?).to eq false
	end

end