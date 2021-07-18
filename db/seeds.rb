# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# truncate all tables and reset the identity sequence
%w[users categories items roles].each do |table|
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE;")
end

# create roles
r1 = Role.create({ name: 'Admin', description: 'Can perform any CRUD operation on any resource' })
r2 = Role.create({ name: 'Regular', description: 'Can read items' })

# create users
u1 = User.create({ first_name: 'Admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'aaaaaaaa', role_id: r1.id })
4.times do |i|
    User.create(
        role_id: r2.id,
        first_name: Faker::JapaneseMedia::Doraemon.character,
        last_name: Faker::Name.last_name,
        email: "user#{i+1}@test.com",
        phone_number: Faker::PhoneNumber.phone_number_with_country_code,
        password: 'pppppp',
        password_confirmation: 'pppppp'
    )
    puts "created user #{i + 1 }"
end

# create categories
c1 = Category.create({ name: 'Starter' })
c2 = Category.create({ name: 'Drink' })
c3 = Category.create({ name: 'Main' })
c4 = Category.create({ name: 'Dessert' })

4.times do |i|
    Item.create({
        user_id: u1.id,
        category_id: c1.id,
        name: Faker::JapaneseMedia::DragonBall.character ,
        description: Faker::Quote.famous_last_words,
        price: Faker::Number.decimal(l_digits: 2)
    })
    puts "created Starter item #{i + 1 }"
end

4.times do |i|
    Item.create({
        user_id: u1.id,
        category_id: c2.id,
        name: Faker::JapaneseMedia::Conan.character,
        description: Faker::Quote.famous_last_words,
        price: Faker::Number.decimal(l_digits: 2)
    })
    puts "created Drink item #{i + 1 }"
end

8.times do |i|
    Item.create({
        user_id: u1.id,
        category_id: c3.id,
        name: Faker::JapaneseMedia::Doraemon.location + " Ramen",
        description: Faker::Quote.famous_last_words,
        price: Faker::Number.decimal(l_digits: 2)
    })
    puts "created Main item #{i + 1 }"
end

4.times do |i|
    Item.create({
        user_id: u1.id,
        category_id: c4.id,
        name: Faker::JapaneseMedia::OnePiece.character,
        description: Faker::JapaneseMedia::OnePiece.quote,
        price: Faker::Number.decimal(l_digits: 2)
    })
    puts "created Dessert item #{i + 1 }"
end
