# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.destroy_all

100.times do
  Product.create(
    affiliate_id: 17,
    status: 2,
    title: Faker::Commerce.product_name,
    price: Faker::Number.between(1, 150),
    description: Faker::Lorem.paragraph,
    category: Faker::Commerce.department(3),
    picture: Faker::Avatar.image
    )
end
