class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.belongs_to :cart
      t.string :status, default: "in process"
    end
  end
end
