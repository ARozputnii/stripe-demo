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
require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
