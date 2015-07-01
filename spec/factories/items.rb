FactoryGirl.define do
  factory :item do
    name { Faker::Lorem.word }
    stock 1
    price 100.0
    item_category FactoryGirl.create(:item_category)
  end
end
