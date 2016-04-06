# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Create the core categories
Category.create!(name: "Mind", description: "Anything to do with Mind")
Category.create!(name: "Body", description: "Anything to do with Body")
Category.create!(name: "Soul", description: "Anything to do with Soul")

# Create media for each category
mind = Category.where(name: "Mind").first
body = Category.where(name: "Body").first
soul = Category.where(name: "Soul").first

# Mind
Medium.create!(name: "Quote", mediumable: mind)
Medium.create!(name: "Picture", mediumable: mind)

# Body
Medium.create!(name: "Picture", mediumable: body)

# Soul
Medium.create!(name: "Picture", mediumable: soul)


# mind_media = mind.media.all
# body_media = body.media.all
# soul_media = soul.media.all
 # mind_medium_names = cat_mind.media.all.each{|m| p m.name}