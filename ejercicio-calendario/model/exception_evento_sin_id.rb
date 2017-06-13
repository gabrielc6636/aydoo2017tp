class ExceptionEventoSinId < ArgumentError

  def initialize(msg="El evento debe crearse con un id")
    super
  end

end
