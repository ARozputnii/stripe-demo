class HomeController < ApplicationController
  def index
    @credit_card = CreditCard.new
  end

  def show; end

  def repeat_payment
    @user = current_user
  end
end
