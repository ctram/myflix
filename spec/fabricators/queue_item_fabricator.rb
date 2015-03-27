Fabricator(:queue_item) do
  video
  user
  position {((Random::rand) * 50).ceil.to_i}
  rating {((Random::rand) * 5).ceil.to_i}
end
