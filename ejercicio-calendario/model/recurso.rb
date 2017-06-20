class Recurso

	attr_accessor :nombre
	attr_accessor :enUso

	def initialize(nombreRecurso)
		self.nombre = nombreRecurso
		self.enUso = false
	end

	def esta_en_uso?
		enUso
	end

	def reservar
		self.enUso = true
	end

	def liberar
		self.enUso = false
	end

	def to_h
    	return {
    		"nombre" => self.nombre,
    		"enUso" => self.enUso
    	}
  	end

end