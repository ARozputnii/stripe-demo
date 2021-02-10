class AfterPaymentLogic
  def initialize(user, params, stripe_card_id)
    @user = user
    @params = params
    @stripe_card_id = stripe_card_id
  end

  def call
    if @params[:card_id].nil? && @user.credit_cards.find_by(short_card_number: @params[:card_number].slice(-4..-1)).nil?
      credit_card = @user.credit_cards.new(short_card_number: @params[:card_number], stripe_id: @stripe_card_id)
      credit_card.save(validate: false)
    end
  end
end
