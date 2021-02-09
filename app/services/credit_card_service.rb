class CreditCardService
  def initialize(user, params)
    @user = user
    @card_number = params[:card_number]
    @month = params[:month]
    @year = params[:year]
    @cvc = params[:cvc]
  end

  def create_credit_card
    Stripe::Customer.create_source(Stripe::Customer.retrieve(@user.customer_id).id,
                                   { source: generate_token }).id
  rescue Stripe::InvalidRequestError => e; hash_errors(e)
  rescue Stripe::CardError => e; hash_errors(e)
  end

  private
  def generate_token
    Stripe::Token.create(
      card: {
        number: @card_number,
        exp_month: @month,
        exp_year: @year,
        cvc: @cvc
      }
    ).id
  end

  def hash_errors(e)
    { error: e.message }
  end
end
