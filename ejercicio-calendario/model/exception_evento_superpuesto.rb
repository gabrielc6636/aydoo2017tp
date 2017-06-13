class ExceptionEventoSuperpuesto < ArgumentError

  def initialize(msg="Ya existe un evento en ese horario")
    super
  end

end
