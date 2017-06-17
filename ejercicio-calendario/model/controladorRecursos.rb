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
		validadorDeRecurso.validarRecursoExistente(nombreRecurso, repositorioRecursos)
	    recurso = Recurso.new(nombreRecurso)

	    repositorioRecursos.agregarRecurso(recurso)
	    salida = FormateadorJson.formatear_coleccion(repositorioRecursos.obtenerRecursos())
	    gestorArchivos.guardarRecursos(salida)
	end

	def cargarRecursos(listaRecursos)

		listaRecursos.each do |jsonRecurso|
			recurso = Recurso.new(jsonRecurso['nombre'])
			recurso.enUso = jsonRecurso['enUso']
			repositorioRecursos.agregarRecurso(recurso)
		end

	end

	def obtenerRecursos
		repositorioRecursos.obtenerRecursos
	end

	def obtenerRecurso(id_recurso)
		repositorioRecursos.obtenerRecurso(id_recurso)
	end

	def eliminarRecurso(id_recurso)
		validadorDeRecurso.validarRecursoInExistente(id_recurso, repositorioRecursos)
		recurso = repositorioRecursos.obtenerRecurso(id_recurso)

		repositorioRecursos.eliminarRecurso(recurso)
		recursos = obtenerRecursos()
    	salida = FormateadorJson.formatear_coleccion(recursos)
    	gestorArchivos.guardarRecursos(salida)
	end
end