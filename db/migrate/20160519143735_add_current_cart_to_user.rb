class AddCurrentCartToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_cart_id, :integer, default: nil
  end
end
