require "ffaker"

Interest.destroy_all
Skill.destroy_all
User.destroy_all

5.times do
  Interest.create(name: FFaker::SportRU.summer)
end

5.times do
  Skill.create(name: FFaker::SportRU.name)
end

User.create(
  email: FFaker::Internet.unique.email,
  name: FFaker::NameRU.first_name_male,
  surname: FFaker::NameRU.last_name_male,
  patronymic: FFaker::NameRU.middle_name_male,
  nationality: FFaker::Address.country.downcase,
  country: FFaker::Address.country,
  gender: :male,
  age: rand(18...60),
  interests: Interest.take(3),
  skills: Skill.take(3)
)