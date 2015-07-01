# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

address = Address.create(first_name: 'name', last_name: 'last name',
  address: 'some address', city: 'city', state: 'state', zip_code: 1100111, country: 'country')
User.create(first_name: 'test first_name', last_name: 'test last_name', 
  email: 'test@email.com', password: 'password', address: address)

parent = ItemCategory.create(name: Faker::Commerce.department)
2.times do
  category = ItemCategory.create(name: Faker::Commerce.department(1), parent: parent)
  2.times do
    item_detail = {}
    editorial_review = {}

    2.times do
      item_detail[Faker::Lorem.word] = Faker::Lorem.sentence
      editorial_review[Faker::Lorem.sentence] = Faker::Lorem.paragraph(6)
    end
    Item.create(name: Faker::Commerce.product_name, 
      img: "products/#{rand(1..19)}.jpg",
      item_category: category,
      stock: rand(1..10),
      custom_options: [Faker::Commerce.color, Faker::Commerce.color],
      description: Faker::Lorem.paragraph(4),
      item_detail: item_detail,
      features: Faker::Lorem.paragraph(4),
      editorial_review: editorial_review,
      price: rand(5..300)
      )
  end
end