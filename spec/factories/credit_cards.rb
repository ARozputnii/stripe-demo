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
FactoryBot.define do
  factory :credit_card do
    digits { "MyString" }
    month { 1 }
    year { 1 }
  end
end
