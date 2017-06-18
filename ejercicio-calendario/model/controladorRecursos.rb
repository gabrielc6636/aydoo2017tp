require_relative 'repositorioRecursos.rb'
require_relative 'gestor_archivos.rb'
require_relative 'validadorDeRecurso.rb'

class ControladorRecursos

	attr_accessor :repositorioRecursos
	attr_accessor :gestorArchivos
	attr_accessor :validadorDeRecurso	

	def initialize
		self.repositorioRecursos = RepositorioRecursos.new
		self.gestorArchivos = GestorArchivos.new
		self.validadorDeRecurso = ValidadorDeRecurso.new
	end

	def agregarRecurso(nombreRecurso)
		validadorDeRecurso.validarRecursoExistente(nombreRecurso.downcase, repositorioRecursos)
	    recurso = Recurso.new(nombreRecurso.downcase)

	    repositorioRecursos.agregarRecurso(recurso)
	    recursos = repositorioRecursos.obtenerRecursos()
	    gestorArchivos.guardarRecursos(recursos)
	end

	def cargarRecursos(listaRecursos)
		listaRecursos.each do |jsonRecurso|
			recurso = Recurso.new(jsonRecurso['nombre'].downcase)
			recurso.enUso = jsonRecurso['enUso']
			repositorioRecursos.agregarRecurso(recurso)
		end
	end

	def obtenerRecursos
		repositorioRecursos.obtenerRecursos
	end

	def obtenerRecurso(id_recurso)
		repositorioRecursos.obtenerRecurso(id_recurso.downcase)
	end

	def eliminarRecurso(id_recurso)
		validadorDeRecurso.validarRecursoInExistente(id_recurso, repositorioRecursos)
		recurso = repositorioRecursos.obtenerRecurso(id_recurso)

		repositorioRecursos.eliminarRecurso(recurso)
		evento = Evento.eventos.values.detect{|e| e.recursosAsignados.key? id_recurso}
		validadorDeRecurso.validarRecursoEnUsoSinEventoAsignado(evento, recurso)
		if !evento.nil? && recurso.estaEnUso?
			evento.eliminarRecursoAsignado(recurso)			
			gestorArchivos.guardarEventos(Evento.eventos.values)		
		end
    	gestorArchivos.guardarRecursos(obtenerRecursos())
	end

	def asignarRecursoAEvento(id_recurso, id_evento)
		validadorDeRecurso.validarRecursoInExistente(id_recurso.downcase, repositorioRecursos)
		validadorDeRecurso.validarRecursoSinUso(id_recurso.downcase, repositorioRecursos)
		recurso = repositorioRecursos.obtenerRecurso(id_recurso.downcase)		
				
		if !Evento.eventos.key? id_evento.downcase
			raise NameError.new("El evento es inexistente")
		end
		evento = Evento.eventos.fetch(id_evento.downcase)
		evento.asignarRecurso(recurso);
		eventos = Evento.eventos.values	
    	gestorArchivos.guardarRecursos(obtenerRecursos())
    	gestorArchivos.guardarEventos(eventos)
	end

end