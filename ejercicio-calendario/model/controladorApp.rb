require_relative 'calendario.rb'
require_relative 'evento.rb'
require_relative 'gestor_archivos.rb'
require_relative 'controladorRecursos.rb'


class ControladorApp
	
	attr_accessor :gestorArchivos

	def initialize
		self.gestorArchivos = GestorArchivos.new		
	end

	def cargar_datos(controladorRecursos)
		lista_calendarios = gestorArchivos.cargar_calendarios()
		lista_eventos = gestorArchivos.cargar_eventos()

		Calendario.crear_desde_lista(lista_calendarios)
		Evento.crear_desde_lista(lista_eventos, controladorRecursos)
	end


	def agregar_calendario(nombreCalendario)
	    Calendario.new(nombreCalendario)
	    calendarios = Calendario.calendarios.values
	    gestorArchivos.guardar_calendarios(calendarios)
	end

	def eliminar_calendario(nombreCalendario, controladorRecursos)
	    calendario = Calendario.calendarios.fetch(nombreCalendario.downcase)
	    calendario.eliminar_eventos()
	    Calendario.calendarios.delete(nombreCalendario.downcase)
	    calendarios = Calendario.calendarios.values
		gestorArchivos.guardar_eventos(Evento.eventos.values)
	    gestorArchivos.guardar_calendarios(calendarios)
	    gestorArchivos.guardar_recursos(controladorRecursos.obtener_recursos())
	end

	def obtener_calendarios
		Calendario.calendarios.values  		
	end

	def obtener_calendario(nombreCalendario)
		Calendario.calendarios.fetch(nombreCalendario.downcase)
	end

	def crear_recurrencia(jsonRecurrencia) 
		Recurrencia.new(jsonRecurrencia.fetch('frecuencia'), jsonRecurrencia.fetch('fin'))
	end

	def guardar_evento(datosJson)
	    calendario = Calendario.calendarios.fetch(datosJson.fetch('calendario').downcase)
	    recurrencia = nil
	    if datosJson['recurrencia']
	      recurrencia = crear_recurrencia(datosJson['recurrencia'])
	    end
	    Evento.new(calendario, datosJson.fetch('id'), datosJson.fetch('nombre'),
	               datosJson.fetch('inicio'), datosJson.fetch('fin'), recurrencia)
	    eventos = Evento.eventos.values
	    gestorArchivos.guardar_eventos(eventos)
	end

	def eliminar_evento(nombreEvento, controladorRecursos)
		evento = Evento.eventos.fetch(nombreEvento)
	    evento.eliminar_eventos_recurrentes
	    evento.liberar_recursos_asignados()
	    Evento.eventos.delete(evento.id)
	    eventos = Evento.eventos.values
	    gestorArchivos.guardar_eventos(eventos)
	    gestorArchivos.guardar_recursos(controladorRecursos.obtener_recursos())
	end

	def actualizar_evento(datosJson)
	    evento = Evento.eventos.fetch(datosJson['id'])
	    evento.actualizar(datosJson['inicio'], datosJson['fin'], datosJson['recurrencia'])
	    eventos = Evento.eventos.values
	    gestorArchivos.guardar_eventos(eventos)
	end

	def obtener_eventos
		Evento.eventos.values
	end

	def obtener_evento(nombreEvento)
		Evento.eventos.fetch(nombreEvento.downcase)
	end

	def obtener_eventos_para_calendario(nombreCalendario)
		Calendario.calendarios.fetch(nombreCalendario)
	end

end