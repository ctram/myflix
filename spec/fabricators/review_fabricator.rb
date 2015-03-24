Fabricator(:review) do
  title {Faker::Lorem.sentence}
  rating (Random::rand * 5).round
  body {Faker::Lorem.paragraph}
end
