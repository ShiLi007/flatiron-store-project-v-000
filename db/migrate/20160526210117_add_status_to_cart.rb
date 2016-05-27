class AddStatusToCart < ActiveRecord::Migration
  def change
    add_column :carts, :status, :string, default: "pending"
  end
end
