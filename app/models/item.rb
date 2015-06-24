class Item
  include Mongoid::Document

  field :name,            type: String
  field :stock,           type: Integer, default: 0
  field :custom_options,  type: Hash, default: {}
  field :description,     type: String
  field :item_detail,     type: Hash, default: {}
  field :features,        type: String
  field :editorial_review, type: Hash, default: {}
  field :img_url,         type: String

  belongs_to :item_category

  validates_presence_of :name, :img_url
  validates_numericality_of :count
end
