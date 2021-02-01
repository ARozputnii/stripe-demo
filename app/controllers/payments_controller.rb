class PaymentsController < ApplicationController
  def create
    payment = PaymentService.new(current_user, card_params).call
    payment.keys.include?(:success) ? flash.notice = "#{payment}" : flash.alert = "#{payment}"
  end

  private
  def card_params
    params.require(:credit_card).permit(:card_number, :month, :year, :cvc, :card_id, :price)
  end

  def get_flash(type, message)
    type.alert ? flash.alert = "#{message}" : flash.notice = "#{message}"
  end
end
