class Address
  include Mongoid::Document
  field :first_name,          type: String
  field :last_name,           type: String
  field :company,             type: String
  field :address,             type: String
  field :address_complement,  type: String
  field :city,                type: String
  field :state,               type: String
  field :zip_code,            type: Integer
  field :country,             type: String
  field :aditional_info,      type: String
  field :home_phone,          type: String
  field :movil_phone,         type: String

  belongs_to :user

  validates_presence_of :first_name, :last_name, 
                        :address, :city, :state, 
                        :zip_code, :country

end
