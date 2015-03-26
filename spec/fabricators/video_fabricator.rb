Fabricator(:video) do
  name {Faker::Lorem.words.join(" ").capitalize}
  description {Faker::Lorem.paragraph}
  category
end
