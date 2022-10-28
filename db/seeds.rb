# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


user1 = User.create(email: "emily@gmail.com", password: "password", first_name: "Emily", last_name: "Smith", birthday: "1999-01-07", location: "New York, NY")
user2 = User.create(email: "josh@gmail.com", password: "password", first_name: "Josh", last_name: "Smith", birthday: "1976-03-12", location: "New York, NY")
user3 = User.create(email: "michael@gmail.com", password: "password", first_name: "Michael", last_name: "Smith", birthday: "2006-10-04", location: "New York, NY")