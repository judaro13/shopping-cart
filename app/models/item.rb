class Item
  include Mongoid::Document

  field :name,            type: String
  field :stock,           type: Integer, default: 0
  field :custom_options,  type: Array, default: []
  field :description,     type: String
  field :item_detail,     type: Hash, default: {}
  field :features,        type: String
  field :editorial_review, type: Hash, default: {}
  field :img,              type: String

  belongs_to :item_category

  validates_presence_of :name, :img
  validates_numericality_of :stock

  before_create  :update_counter

  def update_counter
    self.item_category.inc(count: 1)
  end
end
