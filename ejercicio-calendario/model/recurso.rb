class Recurso

	attr_accessor :nombre
	attr_accessor :estaEnUso

	def initialize(nombreRecurso, siendoUsado)
		self.nombre = nombreRecurso
		self.estaEnUso = siendoUsado
	end

end