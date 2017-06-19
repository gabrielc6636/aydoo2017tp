require_relative 'calendario.rb'
require_relative 'evento.rb'
require_relative 'gestor_archivos.rb'
require_relative 'controladorRecursos.rb'


class ControladorApp
	
	attr_accessor :gestorArchivos
	attr_accessor :controladorRecursos

	def initialize
		self.gestorArchivos = GestorArchivos.new
		self.controladorRecursos = ControladorRecursos.new

		lista_recursos = gestorArchivos.cargarRecursos()
		self.controladorRecursos.cargarRecursos(lista_recursos)
		lista_calendarios = gestorArchivos.cargarCalendarios()
		lista_eventos = gestorArchivos.cargarEventos()

		Calendario.crear_desde_lista(lista_calendarios)
		Evento.crear_desde_lista(lista_eventos, controladorRecursos)
	end

	def agregarCalendario(nombreCalendario)
	    Calendario.new(nombreCalendario)
	    calendarios = Calendario.calendarios.values
	    gestorArchivos.guardarCalendarios(calendarios)
	end

	def eliminarCalendario(nombreCalendario)
	    calendario = Calendario.calendarios.fetch(nombreCalendario.downcase)
	    calendario.eliminar_eventos
	    Calendario.calendarios.delete(nombreCalendario.downcase)
	    calendarios = Calendario.calendarios.values
	    gestorArchivos.guardarCalendarios(calendarios)
	end

	def obtenerCalendarios
		Calendario.calendarios.values  		
	end

	def obtenerCalendario(nombreCalendario)
		Calendario.calendarios.fetch(nombreCalendario.downcase)
	end

	def guardarEvento(datosJson)
	    calendario = Calendario.calendarios.fetch(datosJson.fetch('calendario').downcase)
	    recurrencia = nil
	    if datosJson['recurrencia']
	      recurrencia = Recurrencia.new(datosJson['recurrencia'].fetch('frecuencia'), datosJson['recurrencia'].fetch('fin'))
	    end
	    Evento.new(calendario, datosJson.fetch('id'), datosJson.fetch('nombre'),
	               datosJson.fetch('inicio'), datosJson.fetch('fin'), recurrencia)
	    eventos = Evento.eventos.values
	    gestorArchivos.guardarEventos(eventos)
	end

	def eliminarEvento(nombreEvento)
		evento = Evento.eventos.fetch(nombreEvento)
	    evento.eliminar_eventos_recurrentes
	    Evento.eventos.delete(evento.id)
	    eventos = Evento.eventos.values
	    gestorArchivos.guardarEventos(eventos)
	end

	def actualizarEvento(datosJson)
	    evento = Evento.eventos.fetch(datosJson['id'])
	    evento.actualizar(datosJson['inicio'], datosJson['fin'])
	    eventos = Evento.eventos.values
	    gestorArchivos.guardarEventos(eventos)
	end

	def obtenerEventos
		Evento.eventos.values
	end

	def obtenerEvento(nombreEvento)
		Evento.eventos.fetch(nombreEvento.downcase)
	end

	def obtenerEventosParaCalendario(nombreCalendario)
		Calendario.calendarios.fetch(nombreCalendario)
	end

	def agregarRecurso(nombreRecurso)
		controladorRecursos.agregarRecurso(nombreRecurso)
	end

	def obtenerRecursos
		controladorRecursos.obtenerRecursos()
	end

	def eliminarRecurso(id_recurso)
		controladorRecursos.eliminarRecurso(id_recurso)
	end

	def asignarRecursoAEvento(id_evento, id_recurso)   
		controladorRecursos.asignarRecursoAEvento(id_recurso, id_evento)   
	end

	def liberarRecurso(id_recurso) 
		controladorRecursos.liberarRecurso(id_recurso) 
	end

end