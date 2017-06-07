class ExceptionCalendarioNoEncontrado < ArgumentError
  
  def initialize(msg="No se ha encontrado el calendario")
    super
  end

end
