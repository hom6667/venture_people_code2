# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create( email: 'admin@qut.edu.au', password: 'Qweasd12' )
user = User.find(1)
user.add_role :admin
user.update_attribute :admin, true


# t = User.find(1)
# t.update_attribute :admin, true


# admin account
# admin@qut.edu.au
# Qweasd12
