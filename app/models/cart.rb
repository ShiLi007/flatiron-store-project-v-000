class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user
  has_one :order

  def total
    items.map {|item| item.price * item.line_items.map {|li| li.quantity}.inject(:+)}.inject(:+)
  end

  def add_item(item_id)
    line_item = line_items.find_by(item_id: item_id) 
    if line_item 
      line_item.quantity += 1
    else
      line_item=self.line_items.build(item_id: item_id)
    end
    line_item
  end

  def checkout
    self.status = "submitted"
    change_inventory
  end

  def change_inventory
    if self.status = "submitted"
    self.line_items.each do |line_item| 
        line_item.item.inventory -= line_item.quantity
        line_item.item.save
      end
    end
  end

end