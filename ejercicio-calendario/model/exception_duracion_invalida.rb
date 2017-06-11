class ExceptionDuracionInvalida < ArgumentError
  
  def initialize(msg="La duracion del evento no es valida.")
    super
  end

end
