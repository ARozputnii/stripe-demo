class PaymentsController < ApplicationController
  def create
    return @error = validator if validator != true
    payment = PaymentService.new(current_user, card_params).call
    payment[:success].present? ? (redirect_to show_path) : (@error = payment[:error])
  end

  private
  def card_params
    params.require(:credit_card).permit(:card_number, :month, :year, :cvc, :card_id, :price)
  end

  def validator
    ValidatorService.new(CreditCard, card_params).call
  end
end
