
arr_categories = []
arr_categories << Category.create(name:'Comedies')
arr_categories << Category.create(name:'Dramas')
arr_categories << Category.create(name:'Action')
arr_categories << Category.create(name:'Sci-Fi')

arr_videos = []

# Generate 25 videos with random cover art and placed in categories at random.
25.times do
  cover_num = (Random::rand * 4).ceil

  case cover_num
  when 1
    cover = 'monk_small.jpg'
  when 2
    cover = 'family_guy.jpg'
  when 3
    cover = 'futurama.jpg'
  when 4
    cover = 'south_park.jpg'
  end
  arr_videos << Fabricate(
                          :video,
                          name: Faker::Lorem.words(3).join(" ").capitalize,
                          cover_small_url: cover,
                          category: arr_categories.sample
  )
end

arr_users = Fabricate.times(5,:user)

# Generate 5 reviews for each video, reviewed by each of the users.
arr_videos.each do |video|
  arr_users.each do |user|
    Fabricate(
              :review,
              user: user,
              video: video,
              body: Faker::Lorem.paragraph(3),
              rating: (Random::rand * 5).ceil,
              title: Faker::Lorem.sentence
    )
  end
end

# Each user has 5 queue_items in his queue_items. Each
# queue_item is a random video.
arr_users.each do |user|
  5.times do
    queue_item = Fabricate(:queue_item, user: user, video: arr_videos.sample)
    user.queue_items << queue_item
  end
end
