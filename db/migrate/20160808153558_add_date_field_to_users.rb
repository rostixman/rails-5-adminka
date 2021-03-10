class AddDateFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date, :datetime
  end
end
