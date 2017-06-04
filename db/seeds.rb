# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
  Airport.new(code: codes[count], name: names[count])
end
