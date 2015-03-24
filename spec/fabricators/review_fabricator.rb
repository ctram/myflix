Fabricator(:review) do
  title 'Great Story'
  rating (Random::rand * 5).round
  body Faker::Lorem.paragraph
end
