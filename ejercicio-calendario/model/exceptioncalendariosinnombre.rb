class ExceptionCalendarioSinNombre < ArgumentError
  
  def initialize(msg="El calendario debe crearse con un nombre")
    super
  end

end
