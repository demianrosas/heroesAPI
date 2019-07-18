FactoryBot.define do
  factory :mission do
    description { Faker::Lorem.paragraph }
    place { Faker::Nation.capital_city }
    date { Faker::Date.between(2.days.ago, Date.today) }
    status 'in progress'
    hero_id nil
  end
end
