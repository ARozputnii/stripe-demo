# == Schema Information
#
# Table name: credit_cards
#
#  id                :bigint           not null, primary key
#  short_card_number :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_credit_cards_on_user_id  (user_id)
#
class CreditCard < ApplicationRecord
  belongs_to :user

  attr_accessor :card_number, :cvc, :card_id, :price

  before_validation :set_last_card_number

  validates :digits, presence: true
  validates :month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :year, presence: true, numericality: { greater_than_or_equal_to: DateTime.now.year }

  private
  def set_last_card_number
    if card_number
      card_number.to_s.gsub!(/\s/, "")
      self.short_card_number ||= card_number.to_s.length <= 4 ? card_number : card_number.to_s.slice(-4..-1)
    end
  end
end
