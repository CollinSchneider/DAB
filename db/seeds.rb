# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.destroy_all
Affiliate.destroy_all

3.times do
  Affiliate.create \
    email: Faker::Internet.email,
    password_digest: Faker::Internet.password
end

100.times do
  Product.create(
    affiliate_id: Faker::Number.between(16, 18),
    title: Faker::Commerce.product_name,
    price: Faker::Number.between(1, 150),
    description: Faker::Lorem.paragraph,
    category: Faker::Commerce.department(3),
    picture: Faker::Avatar.image
    )
end
