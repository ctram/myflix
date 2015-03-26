Fabricator(:queue_item) do
  my_queue
  video
  position {((Random::rand) * 50).ceil.to_i}
  rating {((Random::rand) * 5).ceil.to_i}
end
