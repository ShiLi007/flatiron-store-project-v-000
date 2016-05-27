class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user
  has_one :order

  def total
    total = 0
    self.line_items.each do |i|
      total += (i.item.price * i.quantity)
    end
    return total
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
    self.update(status: "submitted")
    items.each {|item| item.update(inventory: item.inventory -= item.line_items.map {|li| li.quantity}.inject(:+))}
  end

end
