class JsonEvento
	attr_accessor :datosJson

	def initialize(json)
		self.datosJson = json
	end

	def obtener_id_Evento		
		return datosJson['id']
	end

	def obtener_fecha_inicio		
		return datosJson['inicio']
	end

	def obtener_fecha_fin		
		return datosJson['fin']
	end

	def obtener_nombre_evento		
		return datosJson['nombre']
	end

	def obtener_nombre_calendario		
		return datosJson['calendario']
	end

	def tiene_recurrencia?
		recurrencia = obtener_recurrencia

		return !recurrencia.nil?
	end

	def obtener_recurrencia
		return datosJson['recurrencia']
	end

	def obtener_frecuencia_recurrencia
		return obtener_recurrencia['frecuencia']
	end

	def obtener_fin_eecurrencia
		return obtener_recurrencia['fin']
	end

	def obtener_recursos_asignados
		return datosJson['recursosAsignados']
	end

	def tiene_recursos_asignados?
		recurso = obtener_recursos_asignados()

		return !recurso.nil?
	end

end
