class ValidadorDeRecurso

	def validar_recurso_sin_uso(nombreRecurso, repositorioRecursos)
		validar_recurso_inExistente(nombreRecurso, repositorioRecursos) 
		recurso = repositorioRecursos.obtener_recurso(nombreRecurso)
		if recurso.esta_en_uso?
			raise NameError.new("El recurso esta siendo utilizado por otro evento")
		end
	end

	def validar_recurso_existente(nombreRecurso, repositorioRecursos)
		if repositorioRecursos.esta_recurso? nombreRecurso
			raise NameError.new("Ya existe un recurso con ese nombre")
		end
	end

	def validar_recurso_inExistente(nombreRecurso, repositorioRecursos)
		if !repositorioRecursos.esta_recurso? nombreRecurso
			raise NameError.new("El recurso es inexistente")
		end
	end

	def validar_recurso_enUso__sin_eventoAsignado(evento, recurso)
		if evento.nil? && recurso.esta_en_uso?
			raise ArgumentError.new("No se encontro en el evento que tiene reservado el recurso")
		end
	end

end