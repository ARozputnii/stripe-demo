class ValidatorService
  def initialize(model, params)
    @model = model
    @params = params
  end

  def call
    m = @model.new(@params)
    m.valid? ? true : m.errors.full_messages
  end
end