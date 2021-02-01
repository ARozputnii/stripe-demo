class PaymentService
  def initialize(user, params)
    @user = user
    @params = params
    @stripe_card_id = stripe_card_id
  end

  def call
    if @stripe_card_id.class == String
      create_charge(@stripe_card_id)
      @user.credit_cards.create_with(@params).find_or_create_by(stripe_id: @stripe_card_id)
      @user.company.company_tariff_plan.update(period_expires: @params[:period], tariff_plan_id: @tariff_plan.id)
      { success: "This payment is complete." }
    elsif @stripe_card_id.class == String
      { error: "Tariff plan not found." }
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
      CreditCardService.new(@user.id, @params).create_credit_card
    end
  end

  def create_charge(card_id)
    Stripe::Charge.create(
      customer: @user.customer_id,
      source:   card_id,
      amount:   @tariff_plan.price,
      currency: "usd"
    )
  rescue Stripe::CardError => e; { errors: e.message }
  end
end
