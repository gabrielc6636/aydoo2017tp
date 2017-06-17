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
	    salida = FormateadorJson.formatear_coleccion(repositorioRecursos.obtenerRecursos())
	    gestorArchivos.guardarRecursos(salida)
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
		validadorDeRecurso.validarRecursoInExistente(id_recurso.downcase, repositorioRecursos)
		recurso = repositorioRecursos.obtenerRecurso(id_recurso.downcase)

		repositorioRecursos.eliminarRecurso(recurso)
		recursos = obtenerRecursos()
    	salida = FormateadorJson.formatear_coleccion(recursos)
    	gestorArchivos.guardarRecursos(salida)
	end

	def asignarRecursoAEvento(id_recurso, id_evento)
		validadorDeRecurso.validarRecursoInExistente(id_recurso.downcase, repositorioRecursos)
		validadorDeRecurso.validarRecursoSinUso(id_recurso.downcase, repositorioRecursos)
		recurso = repositorioRecursos.obtenerRecurso(id_recurso.downcase)		
		
		evento = Evento.eventos.fetch(id_evento.downcase)
		if evento.nil?
			raise NameError.new("El evento es inexistente")
		end
		evento.asignarRecurso(recurso);
		eventos = Evento.eventos.values
    	salida = FormateadorJson.formatear_coleccion(eventos)
    	gestorArchivos.guardarEventos(salida)
	end

end