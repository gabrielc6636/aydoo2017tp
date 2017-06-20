require_relative 'recurso.rb'

class RepositorioRecursos

	attr_accessor :recursos

	def initialize
		self.recursos = {}
	end

	def agregar_recurso(recurso)
		recursos[recurso.nombre] = recurso
	end

	def eliminar_recurso(recurso)
		recursos.delete(recurso.nombre)
	end

	def esta_recurso?(id_recurso)
		recursos.key? id_recurso
	end

	def obtener_recursos
		recursos.values
	end

	def obtener_recurso(id_recurso) 
		recursos[id_recurso]
	end

end