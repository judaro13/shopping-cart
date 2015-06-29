class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String


  field :first_name,         type: String
  field :last_name,          type: String
  field :title,              type: String
  
  has_one :address
  has_one :cart

  validates_presence_of :first_name, :last_name, :address
  accepts_nested_attributes_for :address,  
    allow_destroy: true

  after_initialize  :build_relations_if_nil

  def build_relations_if_nil
    self.address = Address.new if address.nil?
    self.cart = Cart.create if cart.nil?
  end

end
