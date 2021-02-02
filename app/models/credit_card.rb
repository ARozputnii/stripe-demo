# == Schema Information
#
# Table name: credit_cards
#
#  id                :bigint           not null, primary key
#  short_card_number :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stripe_id         :string
#  user_id           :bigint
#
# Indexes
#
#  index_credit_cards_on_user_id  (user_id)
#
class CreditCard < ApplicationRecord
  before_save :set_last_card_number

  belongs_to :user, optional: true

  attr_accessor :card_number, :cvc, :card_id, :price, :month, :year

  validates :card_number, presence: true

  private
  def set_last_card_number
    short_card_number.to_s.length <= 4 ? short_card_number : update(short_card_number: short_card_number.to_s.slice(-4..-1))
  end
end
