# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name:'Comedies')
Category.create(name:'Dramas')
Category.create(name:'Action')
Category.create(name:'Sci-Fi')

Video.create name:'Monk', description:'asdasdsda', cover_small_url:'monk_small.jpg', category_id:1

Video.create name:'Family Guy', description:'asdasdsda', cover_small_url:'family_guy.jpg',category_id:2

Video.create name:'Futurama', description:'asdasdsda',  cover_small_url:'futurama.jpg', category_id:3

Video.create name:'South Park', description:'asdasdsda', cover_small_url:'south_park.jpg', category_id:1
