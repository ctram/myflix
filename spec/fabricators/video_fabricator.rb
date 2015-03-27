Fabricator(:video) do
  name {Faker::Lorem.words(3).join(" ").capitalize}
  description {Faker::Lorem.paragraph}
  category
end
