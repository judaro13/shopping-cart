namespace :items do
  # Populate the db with fake items

  task populate: :environment do

    4.times do
      puts ''
      puts "*"*10
      parent = ItemCategory.create(name: Faker::Commerce.department)
      puts parent.name
      3.times do
        category = ItemCategory.create(name: Faker::Commerce.department(1), parent: parent)
        puts ''
        puts category.name
        rand(5..20).times do
          item_detail = {}
          editorial_review = {}

          rand(3..5).times do
            item_detail[Faker::Lorem.word] = Faker::Lorem.sentence
            editorial_review[Faker::Lorem.sentence] = Faker::Lorem.paragraph(6)
          end

          Item.create(name: Faker::Commerce.product_name, 
            img: "products/#{rand(1..11)}.jpg",
            item_category: category,
            stock: rand(1..10),
            custom_options: [Faker::Commerce.color, Faker::Commerce.color],
            description: Faker::Lorem.paragraph(4),
            item_detail: item_detail,
            features: Faker::Lorem.paragraph(4),
            editorial_review: editorial_review
            )
          print "."
        end
      end
    end 
    puts 'done!'
  end
end