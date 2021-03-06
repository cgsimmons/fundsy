class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.integer :amount
      t.text :description
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
