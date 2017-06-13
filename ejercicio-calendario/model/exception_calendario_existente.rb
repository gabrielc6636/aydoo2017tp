class ExceptionCalendarioExistente < ArgumentError

  def initialize(msg="Ya existe un calendario con ese nombre")
    super
  end

end
