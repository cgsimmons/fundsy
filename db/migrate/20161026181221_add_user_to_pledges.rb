class AddUserToPledges < ActiveRecord::Migration[5.0]
  def change
    add_reference :pledges, :user, foreign_key: true
  end
end
