class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @credit_card = CreditCard.new
  end

  def show; end

  def repeat_payment
    @user = current_user
  end
end
