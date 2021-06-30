# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create(username: 'Maxwolfe', email: 'max@wolfe', password: 'password')
u2 = User.create(username: 'Shaunwolfe', email: 'shaun@wolfe', password: 'password')
u3 = User.create(username: 'Taylorwolfe', email: 'taylor@wolfe', password: 'password')
u4 = User.create(username: 'Darciewolfe', email: 'darcie@wolfe', password: 'password')
u5 = User.create(username: 'Jessewolfe', email: 'jesse@wolfe', password: 'password')

f1 = Follow.create(follower_id: 1, followed_user_id: u1.id)
f2 = Follow.create(follower_id: u1.id, followed_user_id: u2.id)
f3 = Follow.create(follower_id: u1.id, followed_user_id: u3.id)
f4 = Follow.create(follower_id: u1.id, followed_user_id: u4.id)
f5 = Follow.create(follower_id: u1.id, followed_user_id: u5.id)