require_relative 'repositorioRecursos.rb'
require_relative 'gestor_archivos.rb'
require_relative 'validadorDeRecurso.rb'
require_relative 'validadorDeEvento.rb'

class ControladorRecursos

	attr_accessor :repositorioRecursos
	attr_accessor :gestorArchivos
	attr_accessor :validadorDeRecurso
	attr_accessor :validadorDeEvento	

	def initialize
		self.repositorioRecursos = RepositorioRecursos.new
		self.gestorArchivos = GestorArchivos.new
		self.validadorDeRecurso = ValidadorDeRecurso.new
		self.validadorDeEvento = ValidadorDeEvento.new		
	end

	def agregar_recurso(nombreRecurso)
		validadorDeRecurso.validarRecursoExistente(nombreRecurso.downcase, repositorioRecursos)
	    recurso = Recurso.new(nombreRecurso.downcase)

	    repositorioRecursos.agregar_recurso(recurso)
	    gestorArchivos.guardarRecursos(obtener_recursos)
	end

	def cargar_recursos
		listaRecursos = self.gestorArchivos.cargarRecursos()		
		listaRecursos.each do |jsonRecurso|
			recurso = Recurso.new(jsonRecurso['nombre'].downcase)
			recurso.enUso = jsonRecurso['enUso']
			self.repositorioRecursos.agregar_recurso(recurso)
		end
	end

	def obtener_recursos
		self.repositorioRecursos.obtener_recursos
	end

	def obtener_recurso(id_recurso)
		self.repositorioRecursos.obtener_recurso(id_recurso.downcase)
	end

	def eliminar_recurso(id_recurso)
		self.validadorDeRecurso.validarRecursoInExistente(id_recurso, repositorioRecursos)
		recurso = obtener_recurso(id_recurso)

		self.repositorioRecursos.eliminar_recurso(recurso)
		evento = Evento.eventos.values.detect{|e| e.recursosAsignados.key? id_recurso}
		self.validadorDeRecurso.validarRecursoEnUsoSinEventoAsignado(evento, recurso)
		if !evento.nil? && recurso.estaEnUso?
			evento.liberarRecursoAsignado(recurso)			
			self.gestorArchivos.guardarEventos(Evento.eventos.values)		
		end
    	self.gestorArchivos.guardarRecursos(obtener_recursos())
	end

	def asignar_recurso_evento(id_recurso, id_evento)
		validadorDeRecurso.validarRecursoInExistente(id_recurso.downcase, repositorioRecursos)
		validadorDeRecurso.validarRecursoSinUso(id_recurso.downcase, repositorioRecursos)		
		recurso = obtener_recurso(id_recurso)		
						
		validadorDeEvento.validarEventoInExistente(id_evento.downcase)
		evento = Evento.eventos.fetch(id_evento.downcase)
		validadorDeEvento.validarEventoFinalizado(evento)		
		validadorDeEvento.validarEventoPosteriorA72hs(evento.inicio)
		evento.asignarRecurso(recurso)
    	gestorArchivos.guardarRecursos(obtener_recursos())
    	gestorArchivos.guardarEventos(Evento.eventos.values)
	end

	def liberar_recurso(id_recurso) 
		validadorDeRecurso.validarRecursoInExistente(id_recurso.downcase, repositorioRecursos)
		recurso = obtener_recurso(id_recurso)
		if recurso.estaEnUso?
			evento = Evento.eventos.values.detect{|e| e.recursosAsignados.key? id_recurso.downcase}
			validadorDeRecurso.validarRecursoEnUsoSinEventoAsignado(evento, recurso)
			validadorDeEvento.validarEventoSinTerminar(evento)
			evento.liberarRecursoAsignado(recurso)			
			eventos = Evento.eventos.values	
    		gestorArchivos.guardarRecursos(obtener_recursos())
    		gestorArchivos.guardarEventos(eventos)			
		end 
	end

end