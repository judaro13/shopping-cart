class ItemCategory
  include Mongoid::Document

  field :name, type: String
  field :count, type: Integer, default: 0

  belongs_to :parent, class_name: 'ItemCategory', inverse_of: :child
  has_many :child, class_name: 'ItemCategory', inverse_of: :parent
  has_many :items

  validates_presence_of :name 
  validates_uniqueness_of :name
  validates_numericality_of :count

  before_update :update_parent, if: Proc.new { |cat| cat.count_changed? }


  def update_parent
    return unless self.parent
    self.parent.inc(count: 1)
  end
end
