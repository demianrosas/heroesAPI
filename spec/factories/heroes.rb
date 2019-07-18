FactoryBot.define do
  factory :hero do
    name { Faker::Superhero.name }
    superpower { Faker::Superhero.power }
    company { Faker::Lorem.word }
    alignment { Faker::Lorem.word }
  end
end
