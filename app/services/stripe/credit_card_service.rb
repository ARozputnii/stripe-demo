class CreditCardService
  def initialize(user_id, card)
    @user = User.find(user_id)
    @card = card
  end

  def create_credit_card
    Stripe::Customer.create_source(
      Stripe::Customer.retrieve(@user.customer_id).id,
      { source: generate_token },
      ).id
  rescue Stripe::InvalidRequestError => e; hash_errors(e)
  rescue Stripe::CardError => e; hash_errors(e)
  end

  private
  def generate_token
    Stripe::Token.create(
      card: {
        number: @card[:number],
        exp_month: @card[:month],
        exp_year: @card[:year],
        cvc: @card[:cvc]
      }
    ).id
  end

  def hash_errors(e)
    { error: e.message }
  end
end
