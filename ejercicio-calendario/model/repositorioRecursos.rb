require_relative 'recurso.rb'

class RepositorioRecursos

	attr_accessor :recursos

	def initialize
		self.recursos = {}
	end

	def agregarRecurso(recurso)
		recursos[recurso.nombre] = recurso
	end

end