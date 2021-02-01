class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.string :short_card_number
      t.references :user

      t.timestamps
    end
  end
end
