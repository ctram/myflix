
Category.create(name:'Comedies')
Category.create(name:'Dramas')
Category.create(name:'Action')
Category.create(name:'Sci-Fi')

arr_videos = []

# Generate 25 videos with random cover art and placed in categories at random.
25.times do
  category_num = (Random::rand * 4).ceil
  cover_num = ((Random::rand * 4).ceil)

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
  arr_videos << Fabricate(:video, name: Faker::Lorem.sentence, cover_small_url: cover, category_id: category_num)
end

arr_users = Fabricate.times(5,:user)

# Generate 5 reviews for each video, reviewed by each of the users.
arr_videos.each do |video|
  arr_users.each do |user|
    Fabricate(
              :review,
              user: user,
              video: video,
              body: Faker::Lorem.paragraph,
              rating: (Random::rand * 5).ceil,
              title: Faker::Lorem.sentence
    )
  end
end

# Generate my_queues and queue_items - generate a my_queue for each of the 5
# users. Each user has 5 queue_items on his my_queue. Each queue_item is a
# random video.
arr_users.each do |user|
  my_queue = Fabricate(:my_queue)
  my_queue.user = user
  user.my_queue = my_queue
  5.times do
    queue_item = Fabricate(:queue_item)
    queue_item.my_queue = my_queue
    queue_item.video = arr_videos.sample
    user.my_queue.queue_items << queue_item
  end
end
