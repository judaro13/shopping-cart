class Cart
  include Mongoid::Document
  field :total, type: Float,    default: 0
  field :count, type: Integer,  default: 0
  field :items, type: Hash,     default: {} # {item_id: total_products, ...}

  belongs_to :user

  def add_item(item_id, item_count)
    self.items[item_id.to_s] = self.items[item_id.to_s].to_i + item_count

    item = Item.find(item_id) 
    self.count += item_count
    self.total += item.price * item_count
    self.save
  end

  def remove_item(item_id, item_count)
    self.items[item_id.to_s] = self.items[item_id.to_s].t_i - item_count

    item = Item.find(item_id) 
    self.count -= item_count
    self.total -= item.price * item_count
    self.save
  end

  def clean
    self.set(total: 0, count:0, items: {})
  end

end
