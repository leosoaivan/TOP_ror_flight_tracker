# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Airport.delete_all
Flight.delete_all

codes = ["ATL", "ORD", "LAX", "DFW", "JFK", "DEN", "SFO", "LAS", "CLT", "MIA"]
names = [
  "Hartsfield-Jackson Atlanta",
  "Chicago O'Hare",
  "Los Angeles",
  "Dallas/Fort Worth",
  "John F. Kennedy",
  "Denver",
  "San Francisco",
  "McCarran",
  "Charlotte Douglas",
  "Miami"
]

codes.size.times do |count|
  Airport.create(code: "#{codes[count]}", name: "#{names[count]}")
end

airports = Airport.all

100.times do |count|
  airports = Airport.all.sample(2)
  Flight.create(
    departing: airports.first,
    arriving: airports.second,
    duration: 21_600 + rand(1000) * 10,
    date: DateTime.new(2017, 12, 20) + rand(5).day
  )
end

