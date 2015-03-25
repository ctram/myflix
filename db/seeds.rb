
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

arr_users = []
# Generate 5 unique users.
5.times do
  arr_users << Fabricate(:user)
end

# Generate 5 reviews for each video, reviewed by each of the users.
arr_videos.each do |video|
  arr_users.each do |user|
    Fabricate(:review, user_id: user.id, video_id: video.id)
  end
end
