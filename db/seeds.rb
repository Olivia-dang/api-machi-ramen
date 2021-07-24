# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# purge all attached image
Item.all.each { |item| item.image.purge }

# truncate all tables and reset the identity sequence
%w[users categories items].each do |table|
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE;")
end


# create users
u1 = User.create({ first_name: 'Admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'password', role: "Admin" })
4.times do |i|
    User.create(
        role: 'Regular',
        first_name: Faker::JapaneseMedia::Doraemon.character,
        last_name: Faker::Name.last_name,
        email: "user#{i+1}@test.com",
        phone_number: Faker::PhoneNumber.phone_number_with_country_code,
        password: 'password',
        password_confirmation: 'password'
    )
    puts "created user #{i + 1 }"
end

# create categories
c1 = Category.create({ name: 'Starter' })
c2 = Category.create({ name: 'Drink' })
c3 = Category.create({ name: 'Main' })
c4 = Category.create({ name: 'Dessert' })
puts "Created 4 categories"

#create items
2.times do |index|
    item = Item.create({
        user_id: u1.id,
        category_id: c1.id,
        name: Faker::JapaneseMedia::Conan.character,
        description: Faker::Quotes::Shakespeare.as_you_like_it_quote ,
        price: Faker::Number.decimal(l_digits: 2)
    })
    item.image.attach(io: File.open(Rails.root / 'docs' / 'item_seed' / "starter-#{index + 1}.png"), filename:"starter-#{index + 1}.png")
    puts "created Starter item #{index + 1 }"
end

2.times do |index|
    item = Item.create({
        user_id: u1.id,
        category_id: c2.id,
        name: Faker::JapaneseMedia::Doraemon.character,
        description: Faker::Quote.famous_last_words,
        price: Faker::Number.decimal(l_digits: 2)
    })
    item.image.attach(io: File.open(Rails.root / 'docs' / 'item_seed' / "drink-#{index + 1}.png"), filename:"drink-#{index + 1}.png")
    puts "created Drink item #{index + 1 }"
end

4.times do |index|
    item = Item.create({
        user_id: u1.id,
        category_id: c3.id,
        name: Faker::JapaneseMedia::Naruto.character + " Ramen",
        description: Faker::Quote.yoda,
        price: Faker::Number.decimal(l_digits: 2)
    })
    item.image.attach(io: File.open(Rails.root / 'docs' / 'item_seed' / "main-#{index + 1}.png"), filename:"main-#{index + 1}.png")
    puts "created Main item #{index + 1 }"
end

4.times do |index|
    item = Item.create({
        user_id: u1.id,
        category_id: c4.id,
        name: Faker::JapaneseMedia::OnePiece.character,
        description: Faker::JapaneseMedia::OnePiece.quote,
        price: Faker::Number.decimal(l_digits: 2)
    })
    item.image.attach(io: File.open(Rails.root / 'docs' / 'item_seed' / "dessert-#{index + 1}.jpg"), filename:"dessert-#{index + 1}.jpg")
    puts "created Dessert item #{index + 1 }"
end
