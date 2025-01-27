FactoryBot.define do
  factory :user do
    
    email { FFaker::Internet.unique.email }
    name { FFaker::NameRU.first_name }
    surname { FFaker::NameRU.last_name  }
    patronymic { "" }
    nationality { FFaker::Address.country }
    country { FFaker::Address.country }
    gender { User.genders.keys.sample }
    age { rand(18...60) }

    skills { [] }
    interests { [] }

    before(:create, :build) do |user|
      user.name = FFaker::NameRU.send("first_name_#{user.gender}")
      user.surname = FFaker::NameRU.send("last_name_#{user.gender}")
      user.patronymic = FFaker::NameRU.send("middle_name_#{user.gender}")
    end
  end
end
