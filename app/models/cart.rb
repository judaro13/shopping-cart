class Cart
  include Mongoid::Document
  field :total, type: Float,    default: 0
  field :count, type: Integer,  default: 0
  
  belongs_to :user
  has_many :items

  before_update :update_counters

  private
  def update_counters
    return unless self.items_chaged?
    
  end

end
