class ExceptionEventoRepetido < ArgumentError
  
  def initialize(msg="Ya existe un evento con ese nombre en el calendario")
    super
  end

end
