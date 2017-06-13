class ExceptionEventoExistente < ArgumentError

  def initialize(msg="Ya existe un evento con ese id")
    super
  end

end
