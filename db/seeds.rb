# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

auth_user = AuthUser.new
auth_user.email = 'admin@tkmbia.co'
auth_user.role = 'admin'
auth_user.password = '123123123'

auth_user.save!

User.create!(full_name: 'Administrador TKmbia', auth_user_id: auth_user.id)