class ValidadorDeEvento

	def validarEventoSinTerminar(evento)
		if Time.now < Time.parse(evento.fin)
			raise StandardError.new("Evento aun no ha finalizado")
		end
	end

end