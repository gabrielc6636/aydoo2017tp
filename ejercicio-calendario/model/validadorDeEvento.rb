class ValidadorDeEvento

	def validar_evento_sin_terminar(evento)
		if !evento.esta_finalizado?
			raise StandardError.new("Evento aun no ha finalizado")
		end
	end

	def validar_evento_finalizado(evento)
		if evento.esta_finalizado?
			raise StandardError.new("El evento ya ha finalizado")
		end
	end

	def validar_evento_inExistente(id_evento)
		if !Evento.eventos.key? id_evento
			raise NameError.new("El evento es inexistente")
		end		
	end

	def validar_evento_posterior_72hs(fecha_inicio)
		if Time.parse(fecha_inicio) > (Time.now + (72*3600))
			raise NameError.new("No es posible reservar recursos con mas de 72 horas de anticipacion")
		end
	end

end