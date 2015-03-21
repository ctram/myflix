Fabricator(:user)  do
  name_first 'John'
  name_last 'Smith'
  email 'js@example.com'
  password Faker::Internet.password(20)
end
