Fabricator(:user)  do
  name_first {Faker::Name.first_name}
  name_last {Faker::Name.last_name}
  email {Faker::Internet.safe_email}
  password {Faker::Internet.password(20)}
end
