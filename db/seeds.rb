# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

r1 = Role.create({ name: 'Regular', description: 'Can read items' })
r2 = Role.create({ name: 'Admin', description: 'Can perform any CRUD operation on any resource' })

u1 = User.create({ first_name: 'Admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'aaaaaaaa', role_id: r1.id })
u2 = User.create({ first_name: 'Sue', email: 'sue@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r1.id })
u3 = User.create({ first_name: 'Kev', email: 'kev@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r1.id })
u4 = User.create({ first_name: 'Jack', email: 'jack@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r1.id })
u5 = User.create({ first_name: 'Sally', email: 'sally@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r1.id })


c1 = Category.create({ name: 'Glasses' })

i1 = Item.create({ name: 'Rayban Sunglasses', description: 'Stylish shades', price: 99.99, user_id: u1.id, category_id: c1.id })
i2 = Item.create({ name: 'Gucci watch', description: 'Expensive timepiece', price: 199.99, user_id: u1.id, category_id: c1.id })
i3 = Item.create({ name: 'Henri Lloyd Pullover', description: 'Classy knitwear', price: 299.99, user_id: u1.id, category_id: c1.id })
i4 = Item.create({ name: 'Porsche socks', description: 'Cosy footwear', price: 399.99, user_id: u1.id, category_id: c1.id })