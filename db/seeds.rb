# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.destroy_all

50.times do
  Product.create(
    user_id: [28, 30].sample,
    status: 2,
    category: ['Apparel', 'Tech', 'Art/Culture', 'Gadgets', 'Essentials', 'Accessories'].sample,
    title: Faker::Commerce.product_name,
    price: Faker::Number.between(1, 150),
    total_quantity: Faker::Number.between(1, 100),
    description: Faker::Lorem.paragraph,
    feature_one: Faker::Lorem.sentence,
    feature_two: Faker::Lorem.sentence,
    feature_three: Faker::Lorem.sentence,
    feature_four: Faker::Lorem.sentence,
    feature_five: Faker::Lorem.sentence,
    picture: Faker::Avatar.image
    )
end
