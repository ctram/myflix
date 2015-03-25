Fabricator(:review) do
  title {Faker::Lorem.sentence}
  rating {(Random::rand * 5).ceil}
  body {Faker::Lorem.paragraph}
end
