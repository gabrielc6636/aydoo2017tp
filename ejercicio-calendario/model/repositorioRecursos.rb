require_relative 'recurso.rb'

class RepositorioRecursos

	attr_accessor :recursos

	def initialize
		self.recursos = {}
	end

	def agregarRecurso(recurso)
		recursos[recurso.nombre] = recurso
	end

	def eliminarRecurso(recurso)
		recursos.delete(recurso.nombre)
	end

	def estaRecurso?(id_recurso)
		recursos.key? id_recurso
	end

	def obtenerRecursos
		recursos.values
	end

	def obtenerRecurso(id_recurso) 
		recursos[id_recurso]
	end

end