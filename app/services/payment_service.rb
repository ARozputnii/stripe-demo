class PaymentService
  def initialize(user, params)
    @user =  user.customer_id? ? user : user.add_customer_id
    @params = params
    @stripe_card_id = stripe_card_id
  end

  def call
    return @stripe_card_id if @stripe_card_id.class != String

    create_payment(@stripe_card_id)
    if @charge.present?
      AfterPaymentLogic.new(@user, @params, @stripe_card_id).call
      { success: "This payment is complete." }
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
    @charge = Stripe::Charge.create(
      customer: @user.customer_id,
      source:   card_id,
      amount:   (@params[:price].to_f * 100).to_i,
      currency: "usd"
    )
  rescue Stripe::CardError => e; { errors: e.message }
  end
end
