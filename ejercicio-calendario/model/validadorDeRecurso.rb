class ValidadorDeRecurso

	def validarRecursoSinUso(nombreRecurso, repositorioRecursos)
		validarRecursoInExistente(nombreRecurso, repositorioRecursos) 
		recurso = repositorioRecursos.obtener_recurso(nombreRecurso)
		if recurso.estaEnUso?
			raise NameError.new("El recurso esta siendo utilizado por otro evento")
		end
	end

	def validarRecursoExistente(nombreRecurso, repositorioRecursos)
		if repositorioRecursos.esta_recurso? nombreRecurso
			raise NameError.new("Ya existe un recurso con ese nombre")
		end
	end

	def validarRecursoInExistente(nombreRecurso, repositorioRecursos)
		if !repositorioRecursos.esta_recurso? nombreRecurso
			raise NameError.new("El recurso es inexistente")
		end
	end

	def validarRecursoEnUsoSinEventoAsignado(evento, recurso)
		if evento.nil? && recurso.estaEnUso?
			raise ArgumentError.new("No se encontro en el evento que tiene reservado el recurso")
		end
	end

end