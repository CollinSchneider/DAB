# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ProductItem.destroy_all
Product.destroy_all

50.times do
  Product.create(
    user_id: [42, 43, 44].sample,
    status: 2,
    category: ['apparel', 'tech', 'art_culture', 'gadgets', 'essentials', 'accessories'].sample,
    title: Faker::Commerce.product_name,
    price: Faker::Number.between(1, 150),
    description: Faker::Lorem.paragraph,
    feature_one: Faker::Lorem.sentence,
    feature_two: Faker::Lorem.sentence,
    feature_three: Faker::Lorem.sentence,
    feature_four: Faker::Lorem.sentence,
    feature_five: Faker::Lorem.sentence,
    picture: Faker::Avatar.image,
    total_orders: 0
    )
end

150.times do
  ProductItem.create(
    product_id: Faker::Number.between(1625, 1674),
    description: ['XL', 'Blue', 'XS', 'Large Red', 'Green', 'Medium', 'Pink'].sample,
    quantity: Faker::Number.between(1, 100),
    status: 1
  )
end
