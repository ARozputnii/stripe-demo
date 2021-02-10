class PaymentsController < ApplicationController
  before_action :credit_card_valid

  def create
    return @error = @validator if card_params[:card_id].nil? && @validator != true

    payment = PaymentService.new(current_user, card_params).call
    payment[:success].present? ? (redirect_to show_path) : (@error = payment[:error])
  end

  private
  def card_params
    params.require(:credit_card).permit(:card_number, :month, :year, :cvc, :card_id, :price)
  end

  def credit_card_valid
    @validator = CreditCard.new(card_params).check_on_valid
  end
end
