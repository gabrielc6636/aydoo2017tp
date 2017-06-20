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
		validadorDeRecurso.validar_recurso_existente(nombreRecurso.downcase, repositorioRecursos)
	    recurso = Recurso.new(nombreRecurso.downcase)

	    repositorioRecursos.agregar_recurso(recurso)
	    gestorArchivos.guardar_recursos(obtener_recursos)
	end

	def cargar_recursos
		listaRecursos = self.gestorArchivos.cargar_recursos()		
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
		self.validadorDeRecurso.validar_recurso_inExistente(id_recurso, repositorioRecursos)
		recurso = obtener_recurso(id_recurso)

		self.repositorioRecursos.eliminar_recurso(recurso)
		evento = Evento.eventos.values.detect{|e| e.recursosAsignados.key? id_recurso}
		self.validadorDeRecurso.validar_recurso_enUso__sin_eventoAsignado(evento, recurso)
		if !evento.nil? && recurso.esta_en_uso?
			evento.liberar_recurso_asignado(recurso)			
			self.gestorArchivos.guardar_eventos(Evento.eventos.values)		
		end
    	self.gestorArchivos.guardar_recursos(obtener_recursos())
	end

	def asignar_recurso_evento(id_recurso, id_evento)
		validadorDeRecurso.validar_recurso_inExistente(id_recurso.downcase, repositorioRecursos)
		validadorDeRecurso.validar_recurso_sin_uso(id_recurso.downcase, repositorioRecursos)		
		recurso = obtener_recurso(id_recurso)		
						
		validadorDeEvento.validar_evento_inExistente(id_evento.downcase)
		evento = Evento.eventos.fetch(id_evento.downcase)
		validadorDeEvento.validar_evento_finalizado(evento)		
		validadorDeEvento.validar_evento_posterior_72hs(evento.inicio)
		evento.asignar_recurso(recurso)
    	gestorArchivos.guardar_recursos(obtener_recursos())
    	gestorArchivos.guardar_eventos(Evento.eventos.values)
	end

	def liberar_recurso(id_recurso) 
		validadorDeRecurso.validar_recurso_inExistente(id_recurso.downcase, repositorioRecursos)
		recurso = obtener_recurso(id_recurso)
		if recurso.esta_en_uso?
			evento = Evento.eventos.values.detect{|e| e.recursosAsignados.key? id_recurso.downcase}
			validadorDeRecurso.validar_recurso_enUso__sin_eventoAsignado(evento, recurso)
			validadorDeEvento.validar_evento_sin_terminar(evento)
			evento.liberar_recurso_asignado(recurso)			
			eventos = Evento.eventos.values	
    		gestorArchivos.guardar_recursos(obtener_recursos())
    		gestorArchivos.guardar_eventos(eventos)			
		end 
	end

end