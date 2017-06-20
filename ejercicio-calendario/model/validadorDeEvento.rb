class ValidadorDeEvento

	def validarEventoSinTerminar(evento)
		if !evento.estaFinalizado?
			raise StandardError.new("Evento aun no ha finalizado")
		end
	end

	def validarEventoFinalizado(evento)
		if evento.estaFinalizado?
			raise StandardError.new("El evento ya ha finalizado")
		end
	end

	def validarEventoInExistente(id_evento)
		if !Evento.eventos.key? id_evento
			raise NameError.new("El evento es inexistente")
		end		
	end

	def validarEventoPosteriorA72hs(fecha_inicio)
		if Time.parse(fecha_inicio) > (Time.now + (72*3600))
			raise NameError.new("El evento supera las 72hs")
		end
	end

end