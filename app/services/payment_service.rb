class PaymentService
  def initialize(user, params)
    @user =  user.customer_id? ? user : user.add_customer_id
    @params = params
    @stripe_card_id = stripe_card_id
  end

  def call
    if @stripe_card_id.class == String
      create_payment(@stripe_card_id)
      @user.credit_cards.find_or_create_by(short_card_number: @params[:card_number], stripe_id: @stripe_card_id)
      { success: "This payment is complete." }
    else
      @stripe_card_id
    end

  rescue Stripe::InvalidRequestError => e; { error: e.message }
  end

  private
  def stripe_card_id
    if @params[:card_id].present?
      CreditCard.find(@params[:card_id]).stripe_id
    else
      CreditCardService.new(@user, @params).create_credit_card
    end
  end

  def create_payment(card_id)
    Stripe::Charge.create(
      customer: @user.customer_id,
      source:   card_id,
      amount:   @params[:price],
      currency: "usd"
    )
  rescue Stripe::CardError => e; { errors: e.message }
  end
end
