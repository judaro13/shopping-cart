class ItemCategory
  include Mongoid::Document

  field :name, type: String
  field :count, type: Integer, default: 0

  belongs_to :parent, class_name: 'ItemCategory', inverse_of: :child
  has_many :child, class_name: 'ItemCategory', inverse_of: :parent

  validates_presence_of :name
  validates_numericality_of :count
end
