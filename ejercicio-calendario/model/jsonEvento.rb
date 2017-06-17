class JsonEvento
	attr_accessor :datosJson

	def initialize(json)
		self.datosJson = json
	end

	def obtenerIdEvento		
		return datosJson['id']
	end

	def obtenerFechaInicio		
		return datosJson['inicio']
	end

	def obtenerFechaFin		
		return datosJson['fin']
	end

	def obtenerNombreEvento		
		return datosJson['nombre']
	end

	def obtenerNombreCalendario		
		return datosJson['calendario']
	end

	def tieneRecurrencia?
		recurrencia = obtenerRecurrencia

		return !recurrencia.nil?
	end

	def obtenerRecurrencia
		return datosJson['recurrencia']
	end

	def obtenerFrecuenciaDeRecurrencia
		return obtenerRecurrencia['frecuencia']
	end

	def obtenerFinDeRecurrencia
		return obtenerRecurrencia['fin']
	end

	def obtenerRecurso
		return datosJson['recurso']
	end

	def tieneRecurso?
		recurso = obtenerRecurso()

		return !recurso.nil?
	end

	def obtenerNombreRecurso
		return obtenerRecurso['nombre']
	end

	def obtenerEnUsoRecurso
		return obtenerRecurso['enUso']
	end

end
